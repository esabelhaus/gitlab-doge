require 'spec_helper'
require 'omniauth'

module OmniauthHelper
  def mock_dice()
    OmniAuth.config.mock_auth[:dice] = OmniAuth::AuthHash.new({
      :provider => 'dice',
      :uid => 'cn=ruby certificate rbcert,dc=ruby-lang,dc=org',
      :extra =>  {
        :raw_info =>  {
          :citizenshipStatus =>  'US',
          :country =>  'USA',
          :dn =>  'cn=pr. twilight sparkle,ou=c001,ou=mlp,ou=pny,o=princesses of celestia,c=us',
          :email =>  'twilight@example.org',
          :firstName =>  'twilight',
          :lastName =>  'sparkle',
          :fullName =>  'twilight sparkle',
          :grantBy =>  [
            'princess celestia'
          ],
          :organizations =>  [
            'princesses',
            'librarians',
            'unicorns'
          ],
          :uid =>  'twilight.sparkle',
          :dutyorg =>  'ponyville library',
          :visas =>  [
            'EQUESTRIA',
            'CLOUDSDALE'
          ],
          :affiliations =>  [
            'WONDERBOLTS'
          ],
          :telephoneNumber =>  '555-555-5555'
        }
      },
      :info =>  {
        :dn =>  'cn=pr. twilight sparkle,ou=c001,ou=mlp,ou=pny,o=princesses of celestia,c=us',
        :email =>  'twilight@example.org',
        :first_name  => 'twilight',
        :last_name   => 'sparkle',
        :full_name   => 'twilight sparkle',
        :common_name =>  'pr. twilight sparkle',
        :name        => 'pr. twilight sparkle',
        :citizenship_status =>  'US',
        :country =>  'USA',
        :grant_by =>  [
          'princess celestia'
        ],
        :organizations =>  [
          'princesses',
          'librarians',
          'unicorns'
        ],
        :uid =>  'twilight.sparkle',
        :dutyorg =>  'ponyville library',
        :visas =>  [
          'EQUESTRIA',
          'CLOUDSDALE'
        ],
        :affiliations =>  [
          'WONDERBOLTS'
        ],
        :telephone_number =>  '555-555-5555',
        :primary_visa? =>  true,
        :likely_npe?  => false
      }
    })
  end
end
