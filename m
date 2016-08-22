From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH] sdhci: Add quirk and device tree parameter to force SD test mode
Date: Mon, 22 Aug 2016 17:55:31 -0500
Message-ID: <1471906531-28668-1-git-send-email-zach.brown@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, mark.rutland@arm.com, robh+dt@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Jaeden Amero <jaeden.amero@ni.com>

On some devices, CD is broken so that we must force the SDHCI into test
mode and set CD, so that it always detects an SD card as present.

In order to get a device with broken CD working, we had previously
always set the SDHCI into test mode. Unfortunately, this had the side
effect of making all SD cards used with our Linux kernels undetectable
and non-removable.

By making this "SD test mode" setting optional via a quirk, we can avoid
this side effect for devices other than the device with broken CD.
Additionally, we add a device parameter to sdhci-pltfm to allow all
SDHCI drivers to enable this quirk.

Signed-off-by: Jaeden Amero <jaeden.amero@ni.com>
Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 drivers/mmc/host/sdhci-pltfm.c                | 4 ++++
 drivers/mmc/host/sdhci.c                      | 9 +++++++++
 drivers/mmc/host/sdhci.h                      | 4 ++++
 4 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 22d1e1f..3a9be41 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -52,6 +52,8 @@ Optional properties:
 - no-sdio: controller is limited to send sdio cmd during initialization
 - no-sd: controller is limited to send sd cmd during initialization
 - no-mmc: controller is limited to send mmc cmd during initialization
+- force-sd-cd-test-mode: card detection is broken on device, force cd test
+  enable and cd test inserted so host will always detect a card.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 1d17dcf..056d101 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -87,6 +87,10 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	if (of_get_property(np, "broken-cd", NULL))
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
+	if (of_get_property(np, "force-sd-cd-test-mode", NULL))
+		host->quirks2 |=
+			SDHCI_QUIRK2_MUST_FORCE_SD_CD_TEST_MODE;
+
 	if (of_get_property(np, "no-1-8-v", NULL))
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cd65d47..2f4c6f9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -117,6 +117,15 @@ static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
 	u32 present;
+	u8  ctrl;
+
+	if (host->quirks2 & SDHCI_QUIRK2_MUST_FORCE_SD_CD_TEST_MODE) {
+		/* Put the card in test mode, with card inserted */
+		ctrl = sdhci_readl(host, SDHCI_HOST_CONTROL);
+		ctrl |= SDHCI_CTRL_CD_TEST_INSERTED |
+			SDHCI_CTRL_CD_TEST_ENABLE;
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	}
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
 	    !mmc_card_is_removable(host->mmc))
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0411c9f..dd609b2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -84,6 +84,8 @@
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
 #define   SDHCI_CTRL_8BITBUS	0x20
+#define  SDHCI_CTRL_CD_TEST_INSERTED	0x40
+#define  SDHCI_CTRL_CD_TEST_ENABLE	0x80
 
 #define SDHCI_POWER_CONTROL	0x29
 #define  SDHCI_POWER_ON		0x01
@@ -422,6 +424,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Controller must support device with broken CD */
+#define SDHCI_QUIRK2_MUST_FORCE_SD_CD_TEST_MODE		(1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.7.4
