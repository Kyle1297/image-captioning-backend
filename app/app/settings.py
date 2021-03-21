import os
from pathlib import Path
from dotenv import load_dotenv
load_dotenv()


# set key variables
BASE_DIR = Path(__file__).resolve().parent.parent

SECRET_KEY = os.environ['SECRET_KEY']

DEBUG = int(os.environ.get("DEBUG", default=0))

ALLOWED_HOSTS = os.environ.get("ALLOWED_HOSTS").split(" ")


# application definition
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'corsheaders',
    'images',
    'storages',
    'django_filters',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.common.CommonMiddleware',
]

CORS_ORIGIN_WHITELIST = [
    'http://localhost:3000',
]

ROOT_URLCONF = 'app.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'app.wsgi.application'


# database
POSTGRES_HOST = os.environ['POSTGRES_HOST']

POSTGRES_DB = os.environ['POSTGRES_DB']

POSTGRES_USER = os.environ['POSTGRES_USER']

POSTGRES_PASSWORD = os.environ['POSTGRES_PASSWORD']

POSTGRES_PORT = os.environ['POSTGRES_PORT']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': POSTGRES_DB,
        'USER': POSTGRES_USER,
        'PASSWORD': POSTGRES_PASSWORD,
        'HOST': POSTGRES_HOST,
        'PORT': POSTGRES_PORT,
    }
}


# password validation
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# internationalization
LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# AWS defaults
AWS_SECRET_ACCESS_KEY = os.environ['AWS_SECRET_ACCESS_KEY']

AWS_ACCESS_KEY_ID = os.environ['AWS_ACCESS_KEY_ID']

AWS_DEFAULT_REGION = AWS_S3_REGION_NAME = os.environ['AWS_DEFAULT_REGION']

AWS_DEFAULT_LANGUAGE_CODE = os.environ['AWS_DEFAULT_LANGUAGE_CODE']


# general AWS S3 settings
USE_S3 = os.environ.get('USE_S3', default=False)

AWS_STATIC_BUCKET_NAME = os.environ['AWS_STATIC_BUCKET_NAME']

AWS_S3_STATIC_DOMAIN = f'{AWS_STATIC_BUCKET_NAME}.s3.amazonaws.com'

AWS_MEDIA_BUCKET_NAME = os.environ['AWS_MEDIA_BUCKET_NAME']

AWS_S3_MEDIA_DOMAIN = f'{AWS_MEDIA_BUCKET_NAME}.s3.amazonaws.com'

AWS_DEFAULT_ACL = None

AWS_S3_OBJECT_PARAMETERS = {
    'CacheControl': 'max-age=86400',
}

AWS_S3_SIGNATURE_VERSION = 's3v4'


# static and media file storage in production
if USE_S3 == "True":
    STATIC_URL = f'https://{AWS_S3_STATIC_DOMAIN}/'
    
    STATICFILES_STORAGE = 'app.storage_backends.StaticStorage'

    DEFAULT_FILE_STORAGE = 'app.storage_backends.MediaStorage'

    S3_CAPTIONED_IMAGES_FOLDER_NAME = 'captioned-images'

    S3_USER_PROFILES_FOLDER_NAME = 'user-profiles'


# static and media file storage in development
else:
    STATIC_URL = '/staticfiles/'

    STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
    
    MEDIA_URL = '/mediafiles/'

    MEDIA_ROOT = os.path.join(BASE_DIR, 'mediafiles')


# secure hosting
SECURE_PROXY_SSL_HEADER = ("HTTP_X_FORWARDED_PROTO", "https")


# rest framework configurations
REST_FRAMEWORK = {
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 3,
    'DEFAULT_FILTER_BACKENDS': ('django_filters.rest_framework.DjangoFilterBackend',)
}