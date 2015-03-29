From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] mmc: Add support for marking hpi as broken through devicetree
Date: Sun, 29 Mar 2015 20:09:34 +0200
Message-ID: <1427652575-12642-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The eMMC on a tablet I've will stop working / communicating as soon as
the kernel executes:

		mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				EXT_CSD_HPI_MGMT, 1,
 				card->ext_csd.generic_cmd6_time);

There seems to be no way to reliable identify eMMC-s which have a broken
hpi implementation, but at least for eMMC's which are soldered onto a board
we can work around this by specifying that hpi is broken in devicetree.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/mmc-card.txt | 31 ++++++++++++++++++++++
 drivers/mmc/core/mmc.c                             | 10 ++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.txt

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
new file mode 100644
index 0000000..0cc67fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.txt
@@ -0,0 +1,31 @@
+mmc-card / eMMC bindings
+------------------------
+
+This documents describes the devicetree bindings for a mmc-host controller
+child node describing a mmc-card / an eMMC, see "Use of Function subnodes"
+in mmc.txt
+
+Required properties:
+-compatible : Must be "mmc-card"
+-reg        : Must be <0>
+
+Optional properties:
+-broken-hpi : Use this to indicate that the mmc-card has a broken hpi
+              implementation, and that hpi should not be used
+
+Example:
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+
+	mmmcard: mmccard@0 {
+		reg = <0>;
+		compatible = "mmc-card";
+		broken-hpi;
+	};
+};
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1d41e85..8d18920 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
@@ -336,6 +337,8 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 {
 	int err = 0, idx;
 	unsigned int part_size;
+	struct device_node *np = card->dev.of_node;
+	bool broken_hpi = false;
 
 	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
 	card->ext_csd.raw_ext_csd_structure = ext_csd[EXT_CSD_STRUCTURE];
@@ -349,6 +352,9 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		}
 	}
 
+	if (np && of_device_is_compatible(np, "mmc-card"))
+		broken_hpi = of_property_read_bool(np, "broken-hpi");
+
 	/*
 	 * The EXT_CSD format is meant to be forward compatible. As long
 	 * as CSD_STRUCTURE does not change, all values for EXT_CSD_REV
@@ -494,7 +500,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		}
 
 		/* check whether the eMMC card supports HPI */
-		if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
+		if (!broken_hpi && (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1)) {
 			card->ext_csd.hpi = 1;
 			if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x2)
 				card->ext_csd.hpi_cmd =	MMC_STOP_TRANSMISSION;
@@ -1251,6 +1257,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		card->ocr = ocr;
 		card->type = MMC_TYPE_MMC;
 		card->rca = 1;
+		/* Also gets done by mmc_add_card, but we need early access */
+		card->dev.of_node = mmc_of_find_child_device(host, 0);
 		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
 	}
 
-- 
2.3.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
