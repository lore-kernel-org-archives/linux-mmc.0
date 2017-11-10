From: Shah Nehal-Bakulchandra <Nehal-Bakulchandra.Shah@amd.com>
Subject: [PATCH v3] mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400
Date: Fri, 10 Nov 2017 16:11:28 +0530
Message-ID: <1510310488-13413-1-git-send-email-Nehal-Bakulchandra.Shah@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2nam02on0062.outbound.protection.outlook.com ([104.47.38.62]:51200
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752419AbdKJKmY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Nov 2017 05:42:24 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, Shyam-sundar.S-k@amd.com, Sandeep.Singh@amd.com, Nitesh-kumar.Agrawal@amd.com, Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>

From: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>

This patch supports HS400 for AMD upcoming emmc 5.0 controller.The
HS400 and HS200 mode requires hardware work around also. This patch
adds the quirks for the same.

Signed-off-by: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
---

Changes since v1:(https://patchwork.kernel.org/patch/9813945/)
*Reworked on review comments received which has the following:
-> Created amd probe slot function.
-> Reduce mmc core dependency changes
-> Fix some alignment problems.

Changes since v2:(https://patchwork.kernel.org/patch/10001487/)
-> Implemented set_ios method as suggested by Adrian.
-> completely removed mmc core dependencies in the patch.
-> moved AMD DLL register definitions to sdhci-acpi.c


 drivers/mmc/host/sdhci-acpi.c | 80 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index ac678e9..f171fee 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -49,6 +49,8 @@
 #endif
 
 #include "sdhci.h"
+/* AMD sdhci reset dll register.*/
+#define SDHCI_AMD_REST_DLL_REGISTER    0x908
 
 enum {
 	SDHCI_ACPI_SD_CD		= BIT(0),
@@ -89,6 +91,43 @@ static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
 	return c->slot && (c->slot->flags & flag);
 }
 
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
+static void amd_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned int old_timing = host->timing;
+
+	sdhci_set_ios(mmc, ios);
+	if (old_timing == MMC_TIMING_MMC_HS200 &&
+	    ios->timing == MMC_TIMING_MMC_HS)
+		sdhci_writew(host, 0x9, SDHCI_HOST_CONTROL2);
+	if (old_timing != MMC_TIMING_MMC_HS400 &&
+	    ios->timing == MMC_TIMING_MMC_HS400){
+		sdhci_writew(host, 0x80, SDHCI_HOST_CONTROL2);
+		sdhci_acpi_amd_hs400_dll(host);
+	}
+}
+
 static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
 {
 	u8 reg;
@@ -123,6 +162,17 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_int = {
 	.ops = &sdhci_acpi_ops_int,
 };
 
+static const struct sdhci_ops sdhci_acpi_ops_amd = {
+	.set_clock = sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
+static const struct sdhci_acpi_chip sdhci_acpi_chip_amd = {
+	.ops = &sdhci_acpi_ops_amd,
+};
+
 #ifdef CONFIG_X86
 
 static bool sdhci_acpi_byt(void)
@@ -269,6 +319,26 @@ static int bxt_get_cd(struct mmc_host *mmc)
 	return ret;
 }
 
+static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
+					  const char *hid, const char *uid)
+{
+	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
+	struct sdhci_host *host;
+
+	host = c->host;
+	sdhci_read_caps(host);
+	if (host->caps1 & SDHCI_SUPPORT_DDR50)
+		host->mmc->caps = MMC_CAP_1_8V_DDR;
+
+	if ((host->caps1 & SDHCI_SUPPORT_SDR104) &&
+	    (host->mmc->caps & MMC_CAP_1_8V_DDR))
+		host->mmc->caps2 = MMC_CAP2_HS400_1_8V;
+
+	host->mmc_host_ops.select_drive_strength = amd_select_drive_strength;
+	host->mmc_host_ops.set_ios = amd_set_ios;
+	return 0;
+}
+
 static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev,
 				      const char *hid, const char *uid)
 {
@@ -370,6 +440,14 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_qcom_sd = {
 	.caps    = MMC_CAP_NONREMOVABLE,
 };
 
+static const struct sdhci_acpi_slot sdhci_acpi_slot_amd_emmc = {
+	.chip   = &sdhci_acpi_chip_amd,
+	.caps   = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |  MMC_CAP_HW_RESET,
+	.quirks = SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE |
+		  SDHCI_QUIRK_32BIT_ADMA_SIZE,
+	.probe_slot     = sdhci_acpi_emmc_amd_probe_slot,
+};
+
 struct sdhci_acpi_uid_slot {
 	const char *hid;
 	const char *uid;
@@ -393,6 +471,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 	{ "PNP0D40"  },
 	{ "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
 	{ "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
+	{ "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc},
 	{ },
 };
 
@@ -409,6 +488,7 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 	{ "PNP0D40"  },
 	{ "QCOM8051" },
 	{ "QCOM8052" },
+	{ "AMDI0040" },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
-- 
2.7.4

