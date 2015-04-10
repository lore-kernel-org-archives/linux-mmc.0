From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v4 4/9] mmc: sdhci-st: Add st_mmcss_cconfig function to configure mmcss glue registers.
Date: Fri, 10 Apr 2015 09:58:26 +0100
Message-ID: <1428656311-2605-5-git-send-email-peter.griffin@linaro.org>
References: <1428656311-2605-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428656311-2605-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-mmc@vger.kernel.org

STiH407 family SoC's have glue registers in the flashSS subsystem which
are used to configure the Arasan HC. This patch configures these glue
registers according to what has been specified in the DT.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 drivers/mmc/host/sdhci-st.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index b5e4df8..821be34 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -138,6 +138,87 @@ static inline void st_mmcss_set_static_delay(void __iomem *ioaddr)
 			ioaddr + ST_TOP_MMC_TX_CLK_DLY);
 }
 
+/**
+ * st_mmcss_cconfig: configure the Arasan HC inside the flashSS.
+ * @np: dt device node.
+ * @host: sdhci host
+ * Description: this function is to configure the Arasan host controller.
+ * On some ST SoCs, i.e. STiH407 family, the MMC devices inside a dedicated
+ * flashSS sub-system which needs to be configured to be compliant to eMMC 4.5
+ * or eMMC4.3.  This has to be done before registering the sdhci host.
+ */
+static void st_mmcss_cconfig(struct device_node *np, struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct mmc_host *mhost = host->mmc;
+	u32 cconf2, cconf3, cconf4, cconf5;
+
+	if (!of_device_is_compatible(np, "st,sdhci-stih407"))
+		return;
+
+	cconf2 = ST_MMC_CCONFIG_2_DEFAULT;
+	cconf3 = ST_MMC_CCONFIG_3_DEFAULT;
+	cconf4 = ST_MMC_CCONFIG_4_DEFAULT;
+	cconf5 = ST_MMC_CCONFIG_5_DEFAULT;
+
+	writel_relaxed(ST_MMC_CCONFIG_1_DEFAULT,
+			host->ioaddr + ST_MMC_CCONFIG_REG_1);
+
+	/* Set clock frequency, default to 50MHz if max-frequency is not
+	 * provided */
+
+	switch (mhost->f_max) {
+	case 200000000:
+		clk_set_rate(pltfm_host->clk, mhost->f_max);
+		cconf2 |= BASE_CLK_FREQ_200;
+		break;
+	case 100000000:
+		clk_set_rate(pltfm_host->clk, mhost->f_max);
+		cconf2 |= BASE_CLK_FREQ_100;
+		break;
+	default:
+		clk_set_rate(pltfm_host->clk, 50000000);
+		cconf2 |= BASE_CLK_FREQ_50;
+	}
+
+	writel_relaxed(cconf2, host->ioaddr + ST_MMC_CCONFIG_REG_2);
+
+	if (mhost->caps & MMC_CAP_NONREMOVABLE)
+		cconf3 |= ST_MMC_CCONFIG_EMMC_SLOT_TYPE;
+	else
+		/* CARD _D ET_CTRL */
+		writel_relaxed(ST_MMC_GP_OUTPUT_CD,
+				host->ioaddr + ST_MMC_GP_OUTPUT);
+
+	if (mhost->caps & MMC_CAP_UHS_SDR50) {
+		/* use 1.8V */
+		cconf3 |= ST_MMC_CCONFIG_1P8_VOLT;
+		cconf4 |= ST_MMC_CCONFIG_SDR50;
+		/* Use tuning */
+		cconf5 |= ST_MMC_CCONFIG_TUNING_FOR_SDR50;
+		/* Max timeout for retuning */
+		cconf5 |= RETUNING_TIMER_CNT_MAX;
+	}
+
+	if (mhost->caps & MMC_CAP_UHS_SDR104) {
+		/*
+		 * SDR104 implies the HC can support HS200 mode, so
+		 * it's mandatory to use 1.8V
+		 */
+		cconf3 |= ST_MMC_CCONFIG_1P8_VOLT;
+		cconf4 |= ST_MMC_CCONFIG_SDR104;
+		/* Max timeout for retuning */
+		cconf5 |= RETUNING_TIMER_CNT_MAX;
+	}
+
+	if (mhost->caps & MMC_CAP_UHS_DDR50)
+		cconf4 |= ST_MMC_CCONFIG_DDR50;
+
+	writel_relaxed(cconf3, host->ioaddr + ST_MMC_CCONFIG_REG_3);
+	writel_relaxed(cconf4, host->ioaddr + ST_MMC_CCONFIG_REG_4);
+	writel_relaxed(cconf5, host->ioaddr + ST_MMC_CCONFIG_REG_5);
+}
+
 static inline void st_mmcss_set_dll(void __iomem *ioaddr)
 {
 	if (!ioaddr)
@@ -214,6 +295,7 @@ static const struct sdhci_pltfm_data sdhci_st_pdata = {
 
 static int sdhci_st_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_host *host;
 	struct st_mmc_platform_data *pdata;
 	struct sdhci_pltfm_host *pltfm_host;
@@ -266,6 +348,9 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	pltfm_host->priv = pdata;
 	pltfm_host->clk = clk;
 
+	/* Configure the Arasan HC inside the flashSS */
+	st_mmcss_cconfig(np, host);
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed sdhci_add_host\n");
@@ -332,12 +417,15 @@ static int sdhci_st_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct st_mmc_platform_data *pdata = pltfm_host->priv;
+	struct device_node *np = dev->of_node;
 
 	clk_prepare_enable(pltfm_host->clk);
 
 	if (pdata->rstc)
 		reset_control_deassert(pdata->rstc);
 
+	st_mmcss_cconfig(np, host);
+
 	return sdhci_resume_host(host);
 }
 #endif
-- 
1.9.1
