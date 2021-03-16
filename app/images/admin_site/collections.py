from django.contrib import admin


class CollectionAdmin(admin.ModelAdmin):
    # set list display and functionality
    list_display = (
        "category",
        "is_main",
    )
    list_filter = (
        "is_main",
    )
    search_fields = [
        "category",
    ]
    fields = (
        "is_main",
        "category",
    )