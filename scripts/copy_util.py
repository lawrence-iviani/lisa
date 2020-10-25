
import sys, getopt
import os, shutil



# https://stackoverflow.com/questions/1868714/how-do-i-copy-an-entire-directory-of-files-into-an-existing-directory-using-pyth
def copytree(src, dest, symlinks=False, ignore=None):
	for item in os.listdir(src):
		s = os.path.join(src, item)
		d = os.path.join(dest, item)
		#print (item)
		if os.path.isdir(s):
			print ('recurse folder {} '.format(s))
			recursive_overwrite(s, d, follow_symlinks=symlinks)
		else:
			copy_file(src, dest, follow_symlinks=follow_symlinks, use_sudo=False)


def recursive_overwrite(src, dest, follow_symlinks=False):
	if os.path.isdir(src):
		if not os.path.isdir(dest):
			os.makedirs(dest)
		files = os.listdir(src)
		for f in files:
			recursive_overwrite(os.path.join(src, f), 
								os.path.join(dest, f), 
								follow_symlinks)
	else:
		copy_file(src, dest, follow_symlinks=follow_symlinks, use_sudo=False)


def copy_file(src, dest, follow_symlinks=False, try_use_sudo=False):
	try:
		print("copy file :\t{} -> {}".format(src, dest))
		shutil.copyfile(src, dest, follow_symlinks=follow_symlinks)
	except PermissionError:
		if try_use_sudo:
			print("use sudo not implemented, SKIPPED file :\t{} -> {}".format(src, dest))
		else:
			print("Permission error for file {} SKIPPED ".format(dest))
	

global indent_level
indent_level = 0
def get_files_from_tree(src, remove_src=True, debug=False):
	files = []
	global indent_level
	basic_indent = str(indent_level) + ':'+'\t'*indent_level
	indent_level += 1
	
	if debug: print(basic_indent+'Inspecting: ', os.listdir(src))
	for item in os.listdir(src):
		s = os.path.join(src, item)
		if os.path.isdir(s):
			if debug: print(basic_indent+'\tInto Directory',s)
			found_files = get_files_from_tree(s, remove_src=False) # i want to remove the src only at first level
			for f in found_files:
				if debug: print(basic_indent+'\t\tfound file: ',f ) #, ' in ', found_files)
				if remove_src:
					if f.startswith(src):
						if debug: print(basic_indent+'\t\t\tADDING (SRC REMOVED): ', f[len(src):])
						files.append(f[len(src):])	
					else:
						if debug: 
							print(basic_indent+'\t\t\tNOT ADDING ', f, 'cannot remove prefix|' +str(src)+'|')
						else:
							print('NOT ADDING ', f, 'cannot remove prefix|' +str(src)+'|')
				else:
					if debug: print(basic_indent+'\t\t\tADDING (WITH SRC): ', f)
					files.append(f)	
				
			# shutil.copytree(s, d, symlinks, ignore, dirs_exist_ok=True)
		else:
			if debug: print(basic_indent+"----ADDING:  file ",s)
			files.append(s)
			# print ('notdir: copy2 from {} to {}'.format(s,d))
            # shutil.copy2(s, d)
	
	
	if remove_src:
		files = [f[1:] if f.startswith('/') else f for f in files]
	if debug: print(basic_indent+'RETURNING: ' + str(files))
	indent_level -= 1
	return files	
	
	
def main(argv):
	default_root = "/"
	sections = ['all']
	direction = ''
	
	def _header_operation(header):
		len_line = len(header) + 10
		return '*'*len_line + '\n' + '*'*5 + header + '*'*5 + '\n' + '*'*len_line
	
	try:
		opts, args = getopt.getopt(argv,"htf",["help","to_lisa","from_lisa"])
	except getopt.GetoptError:
		print('copy_util.py -h for help')
		sys.exit(2)
	for opt, arg in opts:
		if opt == '-h':
			print ('copy_util.py: \n\tCopy both two direction from/to the actual repository folder and\n\t'
					'\t $ copy_util.py -h | -t --to_lisa |-f --from_lisa ')
			sys.exit(3)
		elif opt in ("-t", "--to_lisa"):
			direction = 'to'
		elif opt in ("-f", "--from_lisa"):
			direction = 'from'
	if direction == '':
		print('Select one direction from or to lisa')
		sys.exit(4)
	if direction=='to':
		for s in sections:
			error
			copytree('../configuration/'+s, default_root)
	elif direction=='from':
		for s in sections:
			print(_header_operation('Searching '+s))
			# print('found from' + '../configuration/'+s + ': \n', get_files_from_tree('../configuration/'+s))
			dest = get_files_from_tree('../configuration/'+s)
			print('Found files: ' + str(dest))
			
			print(_header_operation('Copying '+s))
			copied = []
			for d in dest:
				try:
					copy_file(default_root+'/'+d, '../configuration/'+s+'/'+d,  follow_symlinks=False, try_use_sudo=False)
					copied.append(d)
				except FileNotFoundError as e:
					print(e, '\nSKIPPING ', d)
			missed = [x for x in dest if x not in copied]
			
			print(_header_operation('Operation result for: '))
			
			print('Copied files: ' + str(copied))
			print('Missed: ' + str(missed))
	else:
		print('not supported') 

if __name__ == "__main__":
	main(sys.argv[1:])