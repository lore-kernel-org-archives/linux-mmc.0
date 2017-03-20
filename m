From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 06/25] mmc: sdhci-pci: Don't re-tune with runtime pm for some Intel devices
Date: Mon, 20 Mar 2017 19:50:34 +0200
Message-ID: <1490032253-6030-7-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29206 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756042AbdCTR6N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:13 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Make use  of an Intel ACPI _DSM that indicates if re-tuning is needed after
D3.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 90 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 84b73cb22940..3564327c9c7b 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -259,6 +259,77 @@ static int mfd_sdio_probe_slot(struct sdhci_pci_slot *slot)
 	.probe_slot	= pch_hc_probe_slot,
 };
 
+enum {
+	INTEL_DSM_FNS		=  0,
+	INTEL_DSM_D3_RETUNE	= 10,
+};
+
+struct intel_host {
+	u32	dsm_fns;
+	bool	d3_retune;
+};
+
+const u8 intel_dsm_uuid[] = {
+	0xA5, 0x3E, 0xC1, 0xF6, 0xCD, 0x65, 0x1F, 0x46,
+	0xAB, 0x7A, 0x29, 0xF7, 0xE8, 0xD5, 0xBD, 0x61,
+};
+
+static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
+		       unsigned int fn, u32 *result)
+{
+	union acpi_object *obj;
+	int err = 0;
+
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), intel_dsm_uuid, 0, fn, NULL);
+	if (!obj)
+		return -EOPNOTSUPP;
+
+	if (obj->type != ACPI_TYPE_BUFFER || obj->buffer.length < 1) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (obj->buffer.length >= 4)
+		*result = *(u32 *)obj->buffer.pointer;
+	else if (obj->buffer.length >= 2)
+		*result = *(u16 *)obj->buffer.pointer;
+	else
+		*result = *(u8 *)obj->buffer.pointer;
+out:
+	ACPI_FREE(obj);
+
+	return err;
+}
+
+static int intel_dsm(struct intel_host *intel_host, struct device *dev,
+		     unsigned int fn, u32 *result)
+{
+	if (fn > 31 || !(intel_host->dsm_fns & (1 << fn)))
+		return -EOPNOTSUPP;
+
+	return __intel_dsm(intel_host, dev, fn, result);
+}
+
+static void intel_dsm_init(struct intel_host *intel_host, struct device *dev,
+			   struct mmc_host *mmc)
+{
+	int err;
+	u32 val;
+
+	err = __intel_dsm(intel_host, dev, INTEL_DSM_FNS, &intel_host->dsm_fns);
+	if (err) {
+		pr_debug("%s: DSM not supported, error %d\n",
+			 mmc_hostname(mmc), err);
+		return;
+	}
+
+	pr_debug("%s: DSM function mask %#x\n",
+		 mmc_hostname(mmc), intel_host->dsm_fns);
+
+	err = intel_dsm(intel_host, dev, INTEL_DSM_D3_RETUNE, &val);
+	intel_host->d3_retune = err ? true : !!val;
+}
+
 static void sdhci_pci_int_hw_reset(struct sdhci_host *host)
 {
 	u8 reg;
@@ -359,8 +430,19 @@ static int bxt_get_cd(struct mmc_host *mmc)
 	return ret;
 }
 
+static void byt_read_dsm(struct sdhci_pci_slot *slot)
+{
+	struct intel_host *intel_host = sdhci_pci_priv(slot);
+	struct device *dev = &slot->chip->pdev->dev;
+	struct mmc_host *mmc = slot->host->mmc;
+
+	intel_dsm_init(intel_host, dev, mmc);
+	slot->chip->rpm_retune = intel_host->d3_retune;
+}
+
 static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
+	byt_read_dsm(slot);
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
 				 MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
 				 MMC_CAP_CMD_DURING_TFR |
@@ -405,6 +487,8 @@ static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
 	int err;
 
+	byt_read_dsm(slot);
+
 	err = ni_set_max_freq(slot);
 	if (err)
 		return err;
@@ -416,6 +500,7 @@ static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 
 static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
+	byt_read_dsm(slot);
 	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
 				 MMC_CAP_WAIT_WHILE_BUSY;
 	return 0;
@@ -423,6 +508,7 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 
 static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 {
+	byt_read_dsm(slot);
 	slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 	slot->cd_idx = 0;
 	slot->cd_override_level = true;
@@ -488,6 +574,7 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 			  SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
 			  SDHCI_QUIRK2_STOP_WITH_TC,
 	.ops		= &sdhci_intel_byt_ops,
+	.priv_size	= sizeof(struct intel_host),
 };
 
 static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
@@ -497,6 +584,7 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 	.allow_runtime_pm = true,
 	.probe_slot	= ni_byt_sdio_probe_slot,
 	.ops		= &sdhci_intel_byt_ops,
+	.priv_size	= sizeof(struct intel_host),
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
@@ -506,6 +594,7 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 	.allow_runtime_pm = true,
 	.probe_slot	= byt_sdio_probe_slot,
 	.ops		= &sdhci_intel_byt_ops,
+	.priv_size	= sizeof(struct intel_host),
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
@@ -517,6 +606,7 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 	.own_cd_for_runtime_pm = true,
 	.probe_slot	= byt_sd_probe_slot,
 	.ops		= &sdhci_intel_byt_ops,
+	.priv_size	= sizeof(struct intel_host),
 };
 
 /* Define Host controllers for Intel Merrifield platform */
-- 
1.9.1

