from django.conf import settings
		
def generate_s3_key(is_profile_image: bool, is_private: bool, filename: str) -> str:
	"""
	Determine location (i.e. key) of file/image in s3 media bucket.

	File may either be in the profiles or captioned images folder, public or private.
	"""	
	folder = settings.S3_CAPTIONED_IMAGES_FOLDER_NAME
	if is_profile_image:
		folder = settings.S3_USER_PROFILES_FOLDER_NAME
	else: 
		if is_private:
			folder += '/private'
		else:
			folder += '/public'
	key = f'{folder}/{filename}'
	return key

def upper_text(text: str) -> str:
	"""
	Capitalises only the first letter of a string, keeping the remaining 
	characters the same.
	"""
	if len(text) > 1:
		return text[0].upper() + text[1:]
	elif text:
		return text.upper()
	return ""