From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/3] firmware: dmi_scan: Add dmi_product_name kernel cmdline option
Date: Sat, 25 Feb 2017 18:23:55 +0100
Message-ID: <20170225172357.26294-2-hdegoede@redhat.com>
References: <20170225172357.26294-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170225172357.26294-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jean Delvare <jdelvare@suse.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Unfortunately some firmware has all the DMI strings filled with:
"Default String" (or something equally useless). This makes it impossible
to apply DMI based quirks to certain machines.

This commit adds a dmi_product_name kernel cmdline option which can
be used to override the DMI_PRODUCT_NAME string, so that DMI based
quirks can still be used on such boards, there are 3 reasons for this:

1) Rather then add cmdline options for all things which can be DMI quirked
and thus may need to be specified, this only requires adding code for
a single extra cmdline option

2) Some devices can be quite quirky, e.g. the GPD win mini laptop /
clamshell x86 machine, needing several quirks in both kernel and userspace
(udev hwdb) in this case being able to fake a unique dmi product name
allows making these devices usable with a single kernel cmdline option
rather then requiring multiple kernel cmdline options + manual userspace
tweaking

3) In some case we may be able to successfully get the manufacturer to
fix the DMI strings with a firmware update, but not all users may want
to update, this will allow users to use DMI based quirks without forcing
them to update their firmware

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note the GPD win: http://www.gpd.hk/gpdwin.asp is the main reason I wrote
this patch. I've requested the manufacturer to do a BIOS update fixing the
DMI strings, but I cannot guarantee that that will happen.
---
 drivers/firmware/dmi_scan.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 54be60e..c99e753 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -1047,3 +1047,17 @@ void dmi_memdev_name(u16 handle, const char **bank, const char **device)
 	}
 }
 EXPORT_SYMBOL_GPL(dmi_memdev_name);
+
+static int __init dmi_parse_dmi_product_name(char *str)
+{
+	static char prod_name[32];
+
+	if (!str)
+		return -EINVAL;
+
+	strlcpy(prod_name, str, sizeof(prod_name));
+	dmi_ident[DMI_PRODUCT_NAME] = prod_name;
+
+	return 0;
+}
+early_param("dmi_product_name", dmi_parse_dmi_product_name);
-- 
2.9.3
