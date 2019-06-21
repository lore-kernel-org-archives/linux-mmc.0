From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/3] mmc: sdhci-sprd: Add start_signal_voltage_switch ops
Date: Fri, 21 Jun 2019 14:12:31 +0800
Message-ID: <89fb15e88f33a3c1ce7b5eefa9414a20c984c579.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

For Spreadtrum SD host controller, we can not use standard SD registers
to change and detect the I/O voltage signals, since our voltage regulator
for I/O is fixed in hardware, and no signals were connected to the SD
controller. Thus add Spreadtrum specific voltage switch ops to change
voltage instead of using standard SD host registers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 024c3c5..8b23c88 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -403,6 +403,22 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sdhci_request(mmc, mrq);
 }
 
+static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	int ret;
+
+	if (!IS_ERR(mmc->supply.vqmmc)) {
+		ret = mmc_regulator_set_vqmmc(mmc, ios);
+		if (ret) {
+			pr_err("%s: Switching signalling voltage failed\n",
+			       mmc_hostname(mmc));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
 					     struct mmc_ios *ios)
 {
@@ -470,6 +486,14 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	host->mmc_host_ops.request = sdhci_sprd_request;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 		sdhci_sprd_hs400_enhanced_strobe;
+	/*
+	 * We can not use the standard ops to change and detect the voltage
+	 * signal for Spreadtrum SD host controller, since our voltage regulator
+	 * for I/O is fixed in hardware, that means we do not need control
+	 * the standard SD host controller to change the I/O voltage.
+	 */
+	host->mmc_host_ops.start_signal_voltage_switch =
+		sdhci_sprd_voltage_switch;
 
 	host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
 		MMC_CAP_ERASE | MMC_CAP_CMD23;
-- 
1.7.9.5
