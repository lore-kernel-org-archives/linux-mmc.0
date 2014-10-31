From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/4] mmc: sdhci: Add HS400 support to SDHCI driver
Date: Fri, 31 Oct 2014 14:22:51 +0200
Message-ID: <1414758171-1244-5-git-send-email-adrian.hunter@intel.com>
References: <1414758171-1244-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64435 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759419AbaJaMZD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 31 Oct 2014 08:25:03 -0400
In-Reply-To: <1414758171-1244-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

MMC core already has support for HS400.  Add HS400
support to SDHCI driver.  The SDHC Standard specification
does not define HS400 so consequently HS400 support is
non-standard.  However HS400 is not selected without
the host controller setting the corresponding capability
flags so host controllers not yet supporting HS400
will not be affected.  To support that, a quirk
SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 is introduced to
enable the use of capabilities register reserved bit-63
to indicate HS400 support.

Because HS400 is non-standard for SDHCI, it is possible
that different vendors will do things in different ways.
However HS200 support faced the same issue but currently
there is only one solution.  As such, no attempt has
been made to provide for alternate HS400 solutions except
for SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c  | 13 ++++++++++++-
 drivers/mmc/host/sdhci.h  |  3 +++
 include/linux/mmc/sdhci.h |  2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 91e888c..20e390c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1143,6 +1143,9 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	case MMC_TIMING_UHS_DDR50:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_DDR50);
 		break;
+	case MMC_TIMING_MMC_HS400:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
+		break;
 	default:
 		pr_warn("%s: Invalid UHS-I mode selected\n",
 			mmc_hostname(host->mmc));
@@ -1470,6 +1473,8 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 	else if ((timing == MMC_TIMING_UHS_DDR50) ||
 		 (timing == MMC_TIMING_MMC_DDR52))
 		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+	else if (timing == MMC_TIMING_MMC_HS400)
+		ctrl_2 |= SDHCI_CTRL_HS400; /* Non-standard */
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
@@ -1541,7 +1546,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		u16 clk, ctrl_2;
 
 		/* In case of UHS-I modes, set High Speed Enable */
-		if ((ios->timing == MMC_TIMING_MMC_HS200) ||
+		if ((ios->timing == MMC_TIMING_MMC_HS400) ||
+		    (ios->timing == MMC_TIMING_MMC_HS200) ||
 		    (ios->timing == MMC_TIMING_MMC_DDR52) ||
 		    (ios->timing == MMC_TIMING_UHS_SDR50) ||
 		    (ios->timing == MMC_TIMING_UHS_SDR104) ||
@@ -1888,6 +1894,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * tuning function has to be executed.
 	 */
 	switch (host->timing) {
+	case MMC_TIMING_MMC_HS400:
 	case MMC_TIMING_MMC_HS200:
 	case MMC_TIMING_UHS_SDR104:
 		break;
@@ -3115,6 +3122,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	} else if (caps[1] & SDHCI_SUPPORT_SDR50)
 		mmc->caps |= MMC_CAP_UHS_SDR50;
 
+	if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 &&
+	    (caps[1] & SDHCI_SUPPORT_HS400))
+		mmc->caps2 |= MMC_CAP2_HS400;
+
 	if ((mmc->caps2 & MMC_CAPS2_1_2V) &&
 	    (IS_ERR(mmc->supply.vqmmc) ||
 	     !regulator_is_supported_voltage(mmc->supply.vqmmc, 1100000,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 79937cf..ddd31cd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -161,6 +161,7 @@
 #define   SDHCI_CTRL_UHS_SDR50		0x0002
 #define   SDHCI_CTRL_UHS_SDR104		0x0003
 #define   SDHCI_CTRL_UHS_DDR50		0x0004
+#define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
 #define  SDHCI_CTRL_VDD_180		0x0008
 #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
@@ -203,6 +204,7 @@
 #define  SDHCI_RETUNING_MODE_SHIFT		14
 #define  SDHCI_CLOCK_MUL_MASK	0x00FF0000
 #define  SDHCI_CLOCK_MUL_SHIFT	16
+#define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
 
 #define SDHCI_CAPABILITIES_1	0x44
 
@@ -235,6 +237,7 @@
 #define SDHCI_PRESET_FOR_SDR50 0x6A
 #define SDHCI_PRESET_FOR_SDR104        0x6C
 #define SDHCI_PRESET_FOR_DDR50 0x6E
+#define SDHCI_PRESET_FOR_HS400 0x74 /* Non-standard */
 #define SDHCI_PRESET_DRV_MASK  0xC000
 #define SDHCI_PRESET_DRV_SHIFT  14
 #define SDHCI_PRESET_CLKGEN_SEL_MASK   0x400
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 931ac5e..edd0f25 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -102,6 +102,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_STOP_WITH_TC			(1<<8)
 /* Controller does not support 64-bit DMA */
 #define SDHCI_QUIRK2_BROKEN_64_BIT_DMA			(1<<9)
+/* Capability register bit-63 indicates HS400 support */
+#define SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400		(1<<10)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.1

