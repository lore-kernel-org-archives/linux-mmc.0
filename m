From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v4 5/9] mmc: sdhci-st: Add sdhci_st_set_uhs_signaling function.
Date: Fri, 10 Apr 2015 09:58:27 +0100
Message-ID: <1428656311-2605-6-git-send-email-peter.griffin@linaro.org>
References: <1428656311-2605-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428656311-2605-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-mmc@vger.kernel.org

To allow UHS modes to work properly we need to provide the st specific
set_uhs_signaling callback function. This function differs from the
generic sdhci_set_uhs_signaling callback in that we need to configure
the correct delay depending on the UHS mode, and also set the V18_EN
bit.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 drivers/mmc/host/sdhci-st.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 821be34..2ce842b 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -261,6 +261,56 @@ static int sdhci_st_set_dll_for_clock(struct sdhci_host *host)
 	return ret;
 }
 
+static void sdhci_st_set_uhs_signaling(struct sdhci_host *host,
+					unsigned int uhs)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct st_mmc_platform_data *pdata = pltfm_host->priv;
+	u16 ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	int ret = 0;
+
+	/* Select Bus Speed Mode for host */
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	switch (uhs) {
+	/*
+	 * Set V18_EN -- UHS modes do not work without this.
+	 * does not change signaling voltage
+	 */
+
+	case MMC_TIMING_UHS_SDR12:
+		st_mmcss_set_static_delay(pdata->top_ioaddr);
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR12 | SDHCI_CTRL_VDD_180;
+		break;
+	case MMC_TIMING_UHS_SDR25:
+		st_mmcss_set_static_delay(pdata->top_ioaddr);
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR25 | SDHCI_CTRL_VDD_180;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		st_mmcss_set_static_delay(pdata->top_ioaddr);
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR50 | SDHCI_CTRL_VDD_180;
+		ret = sdhci_st_set_dll_for_clock(host);
+		break;
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
+		st_mmcss_set_static_delay(pdata->top_ioaddr);
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104 | SDHCI_CTRL_VDD_180;
+		ret =  sdhci_st_set_dll_for_clock(host);
+		break;
+	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
+		st_mmcss_set_static_delay(pdata->top_ioaddr);
+		ctrl_2 |= SDHCI_CTRL_UHS_DDR50 | SDHCI_CTRL_VDD_180;
+		break;
+	}
+
+	if (ret)
+		dev_warn(mmc_dev(host->mmc), "Error setting dll for clock "
+						"(uhs %d)\n", uhs);
+
+	dev_dbg(mmc_dev(host->mmc), "uhs %d, ctrl_2 %04X\n", uhs, ctrl_2);
+
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+}
 
 static u32 sdhci_st_readl(struct sdhci_host *host, int reg)
 {
@@ -284,6 +334,7 @@ static const struct sdhci_ops sdhci_st_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.read_l = sdhci_st_readl,
 	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_st_set_uhs_signaling,
 };
 
 static const struct sdhci_pltfm_data sdhci_st_pdata = {
-- 
1.9.1
