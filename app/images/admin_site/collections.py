from django.contrib import admin


class CollectionAdmin(admin.ModelAdmin):
    # set list display and functionality
    list_display = (
        "category",
        "description",
    )
    search_fields = [
        "category",
    ]