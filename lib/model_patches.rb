# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
# Add a callback - to be executed before each request in development,
# and at startup in production - to patch existing app classes.
# Doing so in init/environment.rb wouldn't work in development, since
# classes are reloaded, but initialization is not run each time.
# See http://stackoverflow.com/questions/7072758/plugin-not-reloading-in-development-mode
#
Rails.configuration.to_prepare do
    # OutgoingMessage.class_eval do
    OutgoingMessage::Template::InitialRequest.class_eval do
        # Add intro paragraph to new request template
        def default_letter
            return nil if self.message_type == 'followup'
            #"If you uncomment this line, this text will appear as default text in every message"
        end

        def template_string(replacements)
          law_msg = "Az információs önrendelkezési jogról és az információszabadságról szóló 2011. évi CXII. törvény (a továbbiakban: Infotv.) 28. § (1) bekezdése alapján a következő adatigénylést terjesztem elő.\n\n" +
            "Kérem, szíveskedjen elektronikus másolatban megküldeni részemre \n\n(__ IGÉNYELT ADATOK MEGJELÖLÉSE __)\n\n" +
            "Az Infotv. 30. § (2) bekezdése szerint kérem, hogy a másolatokat és az egyéb igényelt adatokat elektronikus úton szíveskedjen részemre a feladó e-mail címére megküldeni.\n" +
            "Ha az igényelt adatokat bármely okból nem lehet e-mailben megküldeni, akkor kérem, hogy azokat a kimittud.atlatszo.hu weboldalon töltse fel.\n\n" +
            "Az Infotv. 29. § (3) és (5) bekezdése alapján adatigénylésem teljesítéséért költségtérítés kizárólag akkor állapítható meg, ha az adatigénylés teljesítése a közfeladatot ellátó szerv alaptevékenységének ellátásához szükséges munkaerőforrás aránytalan mértékű igénybevételével jár. Ilyen esetben az adatkezelő jogosult az adatigénylés teljesítésével összefüggő munkaerő-ráfordítás költségét költségtérítésként meghatározni. Kérem, hogy előzetesen elektronikus úton tájékoztasson arról, amennyiben a kért iratmásolatokra tekintettel költségtérítést állapítana meg. Ebben az esetben kérem, hogy a tájékoztatásban mellékeljen dokumentumlistát, dokumentumonként tüntesse fel az oldalszámot, az adatigénylés teljesítésével kapcsolatos munkaerő-ráfordítás mértékét és annak óradíját.\n\n" +
            "Kérem, hogy abban az esetben, ha az igényelt adatoknak csak egy részét tekinti megismerhetőnek, az Infotv. 30. § (1) bekezdése alapján azokat az adatigénylés részbeni megtagadásával együtt küldje meg számomra.\n\n" +
            "Felhívom szíves figyelmét, hogy a Nemzeti Adatvédelmi és Információszabadság Hatóság NAIH/2015/4710/2/V. számú állásfoglalásából következően a jelen adatigénylés az Infotv. 29. § (1b) bekezdése alapján nem tagadható meg, mivel tartalmazza az adatigénylő nevét és elérhetőségét. Ezen túlmenő adatok megadását az adatkezelő NAIH állásfoglalás szerint nem kérheti, továbbá nem jogosult a személyazonosság ellenőrzésére sem.\n\n" +
            "Segítő együttműködését előre is köszönöm.\n\n" +
            "Kelt: " + I18n.localize(Time.now.to_date, :format => :long)
          msg = salutation(replacements)
          msg += letter(replacements)
          msg += "\n\n"
          msg += law_msg
          msg += "\n\n\n\n"
          msg += signoff(replacements)
          msg += "\n\n"
        end

    end

    PublicBodyCSV.class_eval do
      def self.default_fields
        [:name,
        :short_name,
        :url_name,
        :request_email,
        :tag_string,
        :calculated_home_page,
        :publication_scheme,
        :disclosure_log,
        :notes,
        :created_at,
        :updated_at,
        :version]
      end
      def self.default_headers
        ['Name',
        'Short name',
        'URL name',
        'Email',
        'Tags',
        'Home page',
        'Publication scheme',
        'Disclosure log',
        'Notes',
        'Created at',
        'Updated at',
        'Version']
      end
    end
end
