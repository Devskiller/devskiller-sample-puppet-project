# Class: directory_creator
# ===========================
#
class directory_creator (
  String $directory,
  String $owner     = 'root',
  String $group     = 'root',
) {

  validate_absolute_path("${directory}")

  # add solution here

}
