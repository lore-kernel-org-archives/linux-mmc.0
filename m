From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/3] mmc: sdhci-iproc: add bcm2835 support
Date: Wed, 27 Jan 2016 22:25:41 +0000
Message-ID: <1453933542-30287-3-git-send-email-stefan.wahren@i2se.com>
References: <1453933542-30287-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:63403 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967470AbcA0W0y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 17:26:54 -0500
In-Reply-To: <1453933542-30287-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@martin.sperl.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, jszhang@marvell.com, shawn.lin@rock-chips.com, bcm-kernel-feedback-list@broadcom.com, Stefan Wahren <stefan.wahren@i2se.com>

Scott Branden from Broadcom said that the BCM2835 eMMC IP core is
very similar to IPROC and share most of the quirks. So use this driver
instead of separate one.

The sdhci-iproc contains a better workaround for the clock domain
crossing problem which doesn't need any delays. This results in a
better write performance.

Btw we get the rid of the SDHCI_CAPABILITIES hack in the sdhci_readl
function.

Suggested-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Eric Anholt <eric@anholt.net>
---
 drivers/mmc/host/Kconfig       |    6 +++---
 drivers/mmc/host/sdhci-iproc.c |   15 +++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1526b8a..60de1e4 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -318,15 +318,15 @@ config MMC_SDHCI_F_SDH30
 	  If unsure, say N.
 
 config MMC_SDHCI_IPROC
-	tristate "SDHCI platform support for the iProc SD/MMC Controller"
-	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
+	depends on ARCH_BCM2835 || ARCH_BCM_IPROC || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	default ARCH_BCM_IPROC
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the iProc SD/MMC controller.
 
-	  If you have an IPROC platform with SD or MMC devices,
+	  If you have a BCM2835 or IPROC platform with SD or MMC devices,
 	  say Y or M here.
 
 	  If unsure, say N.
diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index cdc6c4a..871c92c 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -169,7 +169,22 @@ static const struct sdhci_iproc_data iproc_data = {
 	.mmc_caps = MMC_CAP_1_8V_DDR,
 };
 
+static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_MISSING_CAPS,
+	.ops = &sdhci_iproc_ops,
+};
+
+static const struct sdhci_iproc_data bcm2835_data = {
+	.pdata = &sdhci_bcm2835_pltfm_data,
+	.caps = SDHCI_CAN_VDD_330,
+	.caps1 = 0x00000000,
+	.mmc_caps = 0x00000000,
+};
+
 static const struct of_device_id sdhci_iproc_of_match[] = {
+	{ .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
 	{ .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_data },
 	{ }
 };
-- 
1.7.9.5

