
import sys, getopt
import os, shutil



# https://stackoverflow.com/questions/1868714/how-do-i-copy-an-entire-directory-of-files-into-an-existing-directory-using-pyth
def copytree(src, dst, symlinks=False, ignore=None):
	for item in os.listdir(src):
		s = os.path.join(src, item)
		d = os.path.join(dst, item)
		print (item)
		if os.path.isdir(s):
			print ('isdir: copytree from {} to {}'.format(s,d))
			recursive_overwrite(s, d, follow_symlinks=symlinks)
			# shutil.copytree(s, d, symlinks, ignore, dirs_exist_ok=True)
		else:
			print("copy only file")
			# print ('notdir: copy2 from {} to {}'.format(s,d))
            # shutil.copy2(s, d)


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
		try:
			shutil.copyfile(src, dest, follow_symlinks=follow_symlinks)
		except PermissionError:
			print("Not permission for file, skipping " + str(dest))

			
def main(argv):
	default_root = "/"
	sections = ['all']
	direction = ''
	
	try:
		opts, args = getopt.getopt(argv,"htf:",["to_lisa","from_lisa"])
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

	if direction=='to':
		for s in sections:
			copytree('../configuration/'+s, default_root)
	else:
		print('not supported')

if __name__ == "__main__":
	main(sys.argv[1:])