#=============================================================================#
#                                   Imports                                   #
#=============================================================================#
import os, subprocess
from Bio import SeqIO, Seq, SeqFeature, SeqRecord, AlignIO, Align, Entrez, Graphics





#=============================================================================#
#                        Constants used multiple times                        #
#=============================================================================#
DNA_BASES = ('A', 'T', 'G', 'C')





#=============================================================================#
#                                  Functions                                  #
#=============================================================================#
def get_sequence(genome_dir:str, 
				chromosome:str, 
				start_pos:int, 
				end_pos:int, 
				reverse_complement : bool = False, 
				include_start: bool = True) -> str:
	'''
	Grabs sequences from a chromosome-specific fasta file in the passed directory for a reference genome.
	'''
	filepath = os.path.join(genome_dir, chromosome+'.fa')
	assert os.path.isdir(genome_dir), genome_dir
	assert os.path.isfile(filepath), filepath
	assert chromosome.startswith("chr"), chromosome
	assert start_pos > 0, start_pos
	assert start_pos < end_pos, f'{start_pos}, {end_pos}'

	length = end_pos - start_pos
	if include_start:
		start_pos += -1
		length += 1

	with open(filepath, "r") as f:
		first_line_nchar = len(f.readline())
		f.seek(first_line_nchar + start_pos)
		seq = f.read(length)

	if reverse_complement:
		seq = Seq.reverse_complement(seq)

	return seq



def emboss_read_srspair(file:str) -> list[dict]:
	'''
	Reads a srspair-formatted alignment file (output by an EMBOSS alignment tool) and returns a list of dictionaries.
	Each dictionary is a pairwise alignment between a Seq_1 and a Seq_2
	Dictionary contents: 
		{"Seq_1_name": str,
		"Seq_2_name": str,
		"Length": int,
		"N_identical": int,
		"Identity": float,
		"Similarity": float,
		"Gaps": int,
		"Score": float,
		"Display": str,
		"Seq_1_align_start": int,
		"Seq_1_align_end": int,
		"Seq_2_align_start": int,
		"Seq_2_align_end": int}
	'''
	alignments = []

	with open(file, "r") as f:
		line = f.readline()
		while line:
			line = f.readline()

			if line.startswith("# 1: "):
				seq_1_name = line.strip("\n").split(" ")[-1]
				seq_2_name = f.readline().strip("\n").split(" ")[-1]
				f.readline()
				f.readline()
				f.readline()
				f.readline()
				length = int(f.readline().split(" ")[-1])
				identity_line = f.readline().strip('# Identity:').strip()
				n_identical = int(identity_line.split('/')[0])
				identity = float(identity_line.split("(")[1].split("%")[0])
				similarity = float(f.readline().split("(")[1].split("%")[0])
				gaps = int(f.readline().split("/")[0].split(" ")[-1])
				score = float(f.readline().split(" ")[-1])
				f.readline()
				f.readline()
				f.readline()
				f.readline()
				
				display = []
				while True:
					line = f.readline()
					if line.startswith("#"): 
						break
					else:
						display.append(line)
				display = display[:-2]	# Trim off the last two \n's
				display[-1] = display[-1][:-1]	# Trim off the last two \n's
				
				seq_1_start = display[0].split(" ")
				seq_1_start = [ x for x in seq_1_start if x != "" ]
				seq_1_start = int(seq_1_start[1])
				seq_2_start = display[2].split(" ")
				seq_2_start = [ x for x in seq_2_start if x != "" ]
				seq_2_start = int(seq_2_start[1])
				seq_1_end = display[-3].split(" ")
				seq_1_end = int(seq_1_end[-1])
				seq_2_end = display[-1].split(" ")
				seq_2_end = int(seq_2_end[-1])

				align_dict = {"Seq_1_name": seq_1_name,
							"Seq_2_name": seq_2_name,
							"Length": length,
							"N_identical": n_identical,
							"Identity": identity,
							"Similarity": similarity,
							"Gaps": gaps,
							"Score": score,
							"Display": "".join(display),
							"Seq_1_align_start": seq_1_start,
							"Seq_1_align_end": seq_1_end,
							"Seq_2_align_start": seq_2_start,
							"Seq_2_align_end": seq_2_end}
				alignments.append(align_dict)

	return alignments



def emboss_matcher(ref_seq:str, 
				query_seq:str, 
				ref_name : str = "Ref_seq",
				query_name : str = "Query_seq",
				align_num : int = 1,
				protein_seqtype : bool = False,
				gap_open : float = None,
				gap_extend : float = None,
				stop_temp_overwrite : bool = True,
				keep_temp_files : bool = False) -> list[dict]:
	'''
	Local alignment of 2 sequences 
	Returns the top [align_num] local alignments 
	'''
	temp_ref_seq_file = "temp_fasta_ref.fa"
	temp_query_seq_file = "temp_fasta_queries.fa"
	temp_alignment_file = "temp_alignment.matcher"

	if stop_temp_overwrite:
		for filename in (temp_ref_seq_file, temp_query_seq_file, temp_alignment_file):
			assert not os.path.isfile(filename), filename
	assert isinstance(ref_seq, str)
	assert isinstance(query_seq, str)

	with open(temp_ref_seq_file, 'w') as w:
		w.write(f">{ref_name}\n")
		w.write(ref_seq)
	with open(temp_query_seq_file, 'w') as w:
		w.write(f">{query_name}\n")
		w.write(query_seq + "\n")
		
	command = f"matcher -auto -aformat bam -asequence {temp_ref_seq_file} -bsequence {temp_query_seq_file} -alternatives {align_num} -outfile {temp_alignment_file}"
	if protein_seqtype:
		command += f" -sprotein_asequence Y -sprotein_bsequence Y"
	if gap_open is not None:
		command += f" -gapopen {gap_open}"
	if gap_extend is not None:
		command += f" -gapextend {gap_extend}"
		
	response = subprocess.run(command.split(" "), capture_output=True, check=True)
	print(response.decode())

	alignments = emboss_read_srspair(temp_alignment_file)

	if keep_temp_files is False:
		os.remove(temp_alignment_file)
		os.remove(temp_ref_seq_file)
		os.remove(temp_query_seq_file)

	return alignments



def emboss_stretcher(seq_1:str, 
					seq_2:str, 
					seq_1_name : str = "seq_1",
					seq_2_name : str = "seq_2",
					protein_seqtype : bool = False,
					gap_open : int | float = None,
					gap_extend : int | float = None,
					alignment_file : str = "stretcher_alignment.txt",
					delete_alignment_file : bool = True):
	'''
	Global alignment of 2 sequences via the Myers and Miller algorithm
	Creates, parses, and then deletes a text file with the alignment result in the current directory. alignment_file CANNOT exist at runtime, else an assertion error is raised.
	Return a dict created by read_emboss_srspair that contains alignment results.
	'''
	assert not os.path.isfile(alignment_file), f'The file "{os.path.abspath(alignment_file)}" must not exist'

	command = f"stretcher -auto -asequence asis::{seq_1} -sid_asequence {seq_1_name} -bsequence asis::{seq_2} -sid_bsequence {seq_2_name} -aformat_outfile srspair -outfile {alignment_file}"
	if protein_seqtype:
		command += " -sprotein_asequence Y -sprotein_bsequence Y"
	if gap_open is not None:
		command += f" -gapopen {gap_open}"
	if gap_extend is not None:
		command += f" -gapextend {gap_extend}"
	subprocess.run(command.split(" "), check=True)

	alignment = emboss_read_srspair(alignment_file)[0]

	if delete_alignment_file:
		os.remove(alignment_file)

	return alignment


