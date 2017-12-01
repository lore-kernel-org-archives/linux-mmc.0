From: Shah Nehal-Bakulchandra <Nehal-Bakulchandra.Shah@amd.com>
Subject: [PATCH v5] mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400
Date: Fri,  1 Dec 2017 15:38:52 +0530
Message-ID: <1512122932-24836-1-git-send-email-Nehal-Bakulchandra.Shah@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0055.outbound.protection.outlook.com ([104.47.36.55]:37855
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751771AbdLAKJe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 1 Dec 2017 05:09:34 -0500
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
->Created amd probe slot function.
->Reduce mmc core dependency changes
->Fix some alignment problems.
 
Changes since v2:(https://patchwork.kernel.org/patch/10001487/)
->Implemented set_ios method as suggested by Adrian.
->completely removed mmc core dependencies in the patch.
->moved AMD DLL register definitions to sdhci-acpi.c

Changes since v3:(https://patchwork.kernel.org/patch/10052811/)
->Minor alignment changes suggested by Adrian

Changes since v4:(https://patchwork.kernel.org/patch/10073921/)
->Moved AMD specific macros to AMD specific code

 drivers/mmc/host/sdhci-acpi.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index ac678e9..3fb0e2d 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -370,6 +370,83 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_qcom_sd = {
 	.caps    = MMC_CAP_NONREMOVABLE,
 };
 
+/* AMD sdhci reset dll register. */
+#define SDHCI_AMD_RESET_DLL_REGISTER    0x908
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
+	/* AMD Platform requires dll setting */
+	sdhci_writel(host, 0x40003210, SDHCI_AMD_RESET_DLL_REGISTER);
+	usleep_range(10, 20);
+	sdhci_writel(host, 0x40033210, SDHCI_AMD_RESET_DLL_REGISTER);
+}
+
+/*
+ * For AMD Platform it is required to disable the tuning
+ * bit first controller to bring to HS Mode from HS200
+ * mode, later enable to tune to HS400 mode.
+ */
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
+	    ios->timing == MMC_TIMING_MMC_HS400) {
+		sdhci_writew(host, 0x80, SDHCI_HOST_CONTROL2);
+		sdhci_acpi_amd_hs400_dll(host);
+	}
+}
+
+static const struct sdhci_ops sdhci_acpi_ops_amd = {
+	.set_clock	= sdhci_set_clock,
+	.set_bus_width	= sdhci_set_bus_width,
+	.reset		= sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
+static const struct sdhci_acpi_chip sdhci_acpi_chip_amd = {
+	.ops = &sdhci_acpi_ops_amd,
+};
+
+static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
+					  const char *hid, const char *uid)
+{
+	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
+	struct sdhci_host *host   = c->host;
+
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
+static const struct sdhci_acpi_slot sdhci_acpi_slot_amd_emmc = {
+	.chip   = &sdhci_acpi_chip_amd,
+	.caps   = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.quirks = SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE |
+			SDHCI_QUIRK_32BIT_ADMA_SIZE,
+	.probe_slot     = sdhci_acpi_emmc_amd_probe_slot,
+};
+
 struct sdhci_acpi_uid_slot {
 	const char *hid;
 	const char *uid;
@@ -393,6 +470,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 	{ "PNP0D40"  },
 	{ "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
 	{ "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
+	{ "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc },
 	{ },
 };
 
@@ -409,6 +487,7 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 	{ "PNP0D40"  },
 	{ "QCOM8051" },
 	{ "QCOM8052" },
+	{ "AMDI0040" },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
-- 
2.7.4

