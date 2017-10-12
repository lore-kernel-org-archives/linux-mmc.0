From: "Shah, Nehal-bakulchandra" <Nehal-Bakulchandra.shah@amd.com>
Subject: [PATCH] mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller
 with HS400
Date: Thu, 12 Oct 2017 16:02:28 +0530
Message-ID: <83dfe4d0-8084-e1b5-0d87-ff42c3e5ca4c@amd.com>
References: <1507803468-26313-1-git-send-email-Nehal-bakulchandra.Shah@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0043.outbound.protection.outlook.com ([104.47.34.43]:37120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751186AbdJLKc5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Oct 2017 06:32:57 -0400
In-Reply-To: <1507803468-26313-1-git-send-email-Nehal-bakulchandra.Shah@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, sandeep.singh@amd.com, Nitesh-kumar.Agrawal@amd.com

From: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>

This patch supports HS400 for AMD upcoming emmc 5.0 controller.The
HS400 and HS200 mode requires hardware work around also. This patch
adds the quirks for the same.

Signed-off-by: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
---
 drivers/mmc/core/mmc.c        |  6 +--
 drivers/mmc/host/sdhci-acpi.c | 89 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      |  3 +-
 drivers/mmc/host/sdhci.h      |  5 +++
 include/linux/mmc/host.h      |  6 +++
 5 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4ffea14..7bf3736 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1164,7 +1164,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 
 	/* Set host controller to HS timing */
 	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
-
+	host->ios.transition = HS200_TO_HS_TO_HS400;
 	/* Reduce frequency to HS frequency */
 	max_dtr = card->ext_csd.hs_max_dtr;
 	mmc_set_clock(host, max_dtr);
@@ -1196,7 +1196,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 			 mmc_hostname(host), err);
 		return err;
 	}
-
+	host->ios.transition = SWITCHING_TO_HS400;
 	/* Set host controller to HS400 timing and frequency */
 	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
 	mmc_set_bus_speed(card);
@@ -1204,7 +1204,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = mmc_switch_status(card);
 	if (err)
 		goto out_err;
-
+	host->ios.transition = SWITCHED_TO_HS400;
 	return 0;
 
 out_err:
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index ac678e9..a3456be 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -89,6 +89,47 @@ static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
 	return c->slot && (c->slot->flags & flag);
 }
 
+ /*AMD Driver Strength function*/
+
+static int amd_select_drive_strength(struct mmc_card *card,
+				     unsigned int max_dtr, int host_drv,
+				     int card_drv, int *drv_type)
+{
+	return MMC_SET_DRIVER_TYPE_A;
+}
+
+static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host)
+{
+	/*AMD Platform requires dll setting*/
+	sdhci_writel(host, 0x40003210, SDHCI_AMD_REST_DLL_REGISTER);
+	usleep_range(10, 20);
+	sdhci_writel(host, 0x40033210, SDHCI_AMD_REST_DLL_REGISTER);
+}
+
+/*
+ * For AMD Platform it is required to disable the tuning
+ * bit first controller to bring to HS Mode from HS200
+ * mode, later enable to tune to HS400 mode.
+ */
+
+static void sdhci_amd_set_hs400_transition(struct sdhci_host *host)
+{
+	switch (host->mmc->ios.transition) {
+	case HS200_TO_HS_TO_HS400:
+		sdhci_writew(host, 0x9, SDHCI_HOST_CONTROL2);
+		break;
+
+	case SWITCHING_TO_HS400:
+		sdhci_writew(host, 0x80, SDHCI_HOST_CONTROL2);
+		sdhci_acpi_amd_hs400_dll(host);
+		break;
+
+	case SWITCHED_TO_HS400:
+	default:
+		break;
+	}
+}
+
 static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
 {
 	u8 reg;
@@ -123,6 +164,18 @@ static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
 	.ops = &sdhci_acpi_ops_int,
 };
 
+static const struct sdhci_ops sdhci_acpi_ops_amd = {
+	.set_clock = sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_platform_hs400_transition = sdhci_amd_set_hs400_transition,
+};
+
+static const struct sdhci_acpi_chip sdhci_acpi_chip_amd = {
+	.ops = &sdhci_acpi_ops_amd,
+};
+
 #ifdef CONFIG_X86
 
 static bool sdhci_acpi_byt(void)
@@ -269,6 +322,32 @@ static int bxt_get_cd(struct mmc_host *mmc)
 	return ret;
 }
 
+static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
+					  const char *hid, const char *uid)
+{
+	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
+	struct sdhci_host *host;
+	unsigned int caps1, caps;
+
+	if (!c || !c->host)
+		return 0;
+
+	host = c->host;
+
+	caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	caps  = sdhci_readl(host, SDHCI_CAPABILITIES);
+
+	if (caps1 & SDHCI_SUPPORT_DDR50)
+		host->mmc->caps = MMC_CAP_1_8V_DDR;
+
+	if ((caps1 & SDHCI_SUPPORT_SDR104) &&
+	    (host->mmc->caps & MMC_CAP_1_8V_DDR))
+		host->mmc->caps2 = MMC_CAP2_HS400_1_8V;
+
+	host->mmc_host_ops.select_drive_strength = amd_select_drive_strength;
+	return 0;
+}
+
 static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev,
 				      const char *hid, const char *uid)
 {
@@ -370,6 +449,14 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 	.caps    = MMC_CAP_NONREMOVABLE,
 };
 
+static const struct sdhci_acpi_slot sdhci_acpi_slot_amd_emmc = {
+	.chip   = &sdhci_acpi_chip_amd,
+	.caps   = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |  MMC_CAP_HW_RESET,
+	.quirks = SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE |
+			SDHCI_QUIRK_32BIT_ADMA_SIZE,
+	.probe_slot     = sdhci_acpi_emmc_amd_probe_slot,
+};
+
 struct sdhci_acpi_uid_slot {
 	const char *hid;
 	const char *uid;
@@ -393,6 +480,7 @@ struct sdhci_acpi_uid_slot {
 	{ "PNP0D40"  },
 	{ "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
 	{ "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
+	{ "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc},
 	{ },
 };
 
@@ -409,6 +497,7 @@ struct sdhci_acpi_uid_slot {
 	{ "PNP0D40"  },
 	{ "QCOM8051" },
 	{ "QCOM8052" },
+	{ "AMDI0040" },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ecd0d43..ac74390 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1633,7 +1633,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->ops->set_power(host, ios->power_mode, ios->vdd);
 	else
 		sdhci_set_power(host, ios->power_mode, ios->vdd);
-
+	if (host->ops->set_platform_hs400_transition)
+		host->ops->set_platform_hs400_transition(host);
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0469fa1..42dd043 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -271,6 +271,9 @@
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2
 
+/* AMD sdhci reset dll register.*/
+#define SDHCI_AMD_REST_DLL_REGISTER	0x908
+
 /*
  * End of controller registers.
  */
@@ -571,6 +574,8 @@ struct sdhci_ops {
 	void		(*set_bus_width)(struct sdhci_host *host, int width);
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
+	/* ios for transiton phase for going to hs400 */
+	void (*set_platform_hs400_transition)(struct sdhci_host *host);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
 	void		(*reset)(struct sdhci_host *host, u8 mask);
 	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ebd1ceb..0d0d5d3 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -77,6 +77,12 @@ struct mmc_ios {
 #define MMC_SET_DRIVER_TYPE_D	3
 
 	bool enhanced_strobe;			/* hs400es selection */
+
+	unsigned int transition;      /* track transition modes (hs200 hs400) */
+
+#define HS200_TO_HS_TO_HS400	1
+#define SWITCHING_TO_HS400	2
+#define SWITCHED_TO_HS400	3
 };
 
 struct mmc_host;
-- 
1.9.1

