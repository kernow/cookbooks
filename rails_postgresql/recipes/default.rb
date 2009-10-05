include_recipe  "postgresql::server"

package         "libpgsql-ruby1.8"
package         "postgresql-server-dev-8.3"
gem_package     "pg"