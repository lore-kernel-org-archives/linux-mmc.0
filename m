From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/3] Allow setting dmi-product-name on the cmdline + dmi sdhci quirk
Date: Sat, 25 Feb 2017 18:23:54 +0100
Message-ID: <20170225172357.26294-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jean Delvare <jdelvare@suse.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi All,

So patch 1/3 and 2+3/3 are only somewhat related and they can be merged
independent of each other.

The catch is that the GPD win for which patch 3/3 adds a dmi based quirk
does not have any usable dmi strings. I've contacted the manufacturer
for a BIOS update (no clue how that will go) but even with the BIOS update
I believe patch 1/3 will be useful for similar cases and for people who
do not want to flash their BIOS.

So if Jean is happy with patch 1/3 then 2+3/3 can be merged independently.

Regards,

Hans

p.s.

Takashi this means that you can add a dmi based quirk for the headphone
detection too, my goal is to make everything just work on the GPD win
if the user supplies dmi_product_name=GPD-WINI55 on the kernel cmdline
(we will also need a udev hwdb entry to fix the accelerometer orientation).
