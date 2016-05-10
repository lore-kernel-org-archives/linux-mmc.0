From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 2/3] mmc: sh_mobile_sdhi: Add tuning support
Date: Tue, 10 May 2016 14:52:03 +0900
Message-ID: <1462859524-28522-3-git-send-email-horms+renesas@verge.net.au>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

Add tuning support for use with SDR104 mode
This includes adding support for the sampling clock controller (SCC).

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v1 [Simon Horman]
* Rebase
* Always use value of 0x8 for TAPNUM field of DTCNTL register
  rather than reading value from DT property. There does not
  seem to be a need to expose this in DT at this point.
* Do not include tmio_mmc_start_signal_voltage_switch changes which
  are already in mainline in a different form
* Do not add renesas,clk-rate property as the max-frequency property, which
  is now present in mainline, seems to provide the needed rate
* Omit Gen3 specific changes
* Do not provide renesas,mmc-scc-tappos DT property.
  Instead, always use taps provided in driver.
* Do not parse sd-uhs-sdr50 and sd-uhs-sdr104 properties.
  This is handled by the core.

v0 [Ai Kyuse]
---
 drivers/mmc/host/sh_mobile_sdhi.c | 264 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 263 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 5309c73be1f0..e74bbdad05f4 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -41,6 +41,11 @@
 
 #define host_to_priv(host) container_of((host)->pdata, struct sh_mobile_sdhi, mmc_data)
 
+struct sh_mobile_sdhi_scc {
+	unsigned long clk;	/* clock for SDR104 */
+	u32 tap;		/* sampling clock position for SDR104 */
+};
+
 struct sh_mobile_sdhi_of_data {
 	unsigned long tmio_flags;
 	unsigned long capabilities;
@@ -48,6 +53,9 @@ struct sh_mobile_sdhi_of_data {
 	enum dma_slave_buswidth dma_buswidth;
 	dma_addr_t dma_rx_offset;
 	unsigned bus_shift;
+	int scc_offset;
+	struct sh_mobile_sdhi_scc *taps;
+	int taps_num;
 };
 
 static const struct sh_mobile_sdhi_of_data of_default_cfg = {
@@ -60,12 +68,27 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen1_compatible = {
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 };
 
+/* Definitions for sampling clocks */
+static struct sh_mobile_sdhi_scc rcar_gen2_scc_taps[] = {
+	{
+		.clk = 156000000,
+		.tap = 0x00000703,
+	},
+	{
+		.clk = 0,
+		.tap = 0x00000300,
+	},
+};
+
 static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
 			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
 	.dma_rx_offset	= 0x2000,
+	.scc_offset	= 0x0300,
+	.taps		= rcar_gen2_scc_taps,
+	.taps_num	= ARRAY_SIZE(rcar_gen2_scc_taps),
 };
 
 static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
@@ -207,6 +230,18 @@ static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
 	clk_disable_unprepare(priv->clk);
 }
 
+static void sh_mobile_sdhi_set_clk_div(struct platform_device *pdev, int state)
+{
+	struct mmc_host *mmc = platform_get_drvdata(pdev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	if (state) {
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
+				sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x00ff);
+	}
+}
+
 static int sh_mobile_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 						      struct mmc_ios *ios)
 {
@@ -241,6 +276,202 @@ static int sh_mobile_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 	return pinctrl_select_state(priv->pinctrl, pin_state);
 }
 
+/* SCC registers */
+#define SH_MOBILE_SDHI_SCC_DTCNTL	0x000
+#define SH_MOBILE_SDHI_SCC_TAPSET	0x002
+#define SH_MOBILE_SDHI_SCC_DT2FF	0x004
+#define SH_MOBILE_SDHI_SCC_CKSEL	0x006
+#define SH_MOBILE_SDHI_SCC_RVSCNTL	0x008
+#define SH_MOBILE_SDHI_SCC_RVSREQ	0x00A
+
+/* Definitions for values the SH_MOBILE_SDHI_SCC_DTCNTL register */
+#define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
+#define SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT	16
+#define SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK	0xff
+
+/* Definitions for values the SH_MOBILE_SDHI_SCC_CKSEL register */
+#define SH_MOBILE_SDHI_SCC_CKSEL_DTSEL		BIT(0)
+/* Definitions for values the SH_MOBILE_SDHI_SCC_RVSCNTL register */
+#define SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN	BIT(1)
+/* Definitions for values the SH_MOBILE_SDHI_SCC_RVSREQ register */
+#define SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR	BIT(2)
+
+static inline u32 sd_scc_read32(struct tmio_mmc_host *host, int addr)
+{
+	struct platform_device *pdev = host->pdev;
+	const struct of_device_id *of_id =
+		of_match_device(sh_mobile_sdhi_of_match, &pdev->dev);
+	const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
+
+	return readl(host->ctl + of_data->scc_offset +
+		     (addr << host->bus_shift));
+}
+
+static inline void sd_scc_write32(struct tmio_mmc_host *host, int addr,
+				  u32 val)
+{
+	struct platform_device *pdev = host->pdev;
+	const struct of_device_id *of_id =
+		of_match_device(sh_mobile_sdhi_of_match, &pdev->dev);
+	const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
+
+	writel(val, host->ctl + of_data->scc_offset +
+	       (addr << host->bus_shift));
+}
+
+static bool sh_mobile_sdhi_inquiry_tuning(struct tmio_mmc_host *host)
+{
+	/* SDHI should be tuning only SDR104 */
+	if (host->mmc->ios.timing == MMC_TIMING_UHS_SDR104)
+		return true;
+	else
+		return false;
+}
+
+static unsigned int sh_mobile_sdhi_init_tuning(struct tmio_mmc_host *host)
+{
+	/* set sampling clock selection range */
+	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_DTCNTL,
+			0x8 << SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT);
+
+	/* Initialize SCC */
+	sd_ctrl_write32_as_16_and_16(host, CTL_STATUS, 0x00000000);
+
+	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_DTCNTL,
+		SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
+		sd_scc_read32(host, SH_MOBILE_SDHI_SCC_DTCNTL));
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_CKSEL,
+		SH_MOBILE_SDHI_SCC_CKSEL_DTSEL |
+		sd_scc_read32(host, SH_MOBILE_SDHI_SCC_CKSEL));
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x0100 |
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_RVSCNTL,
+		~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
+		sd_scc_read32(host, SH_MOBILE_SDHI_SCC_RVSCNTL));
+
+	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_DT2FF, host->scc_tappos);
+
+	/* Read TAPNUM */
+	return (sd_scc_read32(host, SH_MOBILE_SDHI_SCC_DTCNTL) >>
+		SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT) &
+		SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK;
+}
+
+static int sh_mobile_sdhi_prepare_tuning(struct tmio_mmc_host *host,
+					 unsigned long tap)
+{
+	/* Set sampling clock position */
+	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_TAPSET, tap);
+
+	return 0;
+}
+
+#define SH_MOBILE_SDHI_MAX_TAP	3
+
+static int sh_mobile_sdhi_select_tuning(struct tmio_mmc_host *host,
+					unsigned long *tap)
+{
+	unsigned long tap_num;	/* total number of taps */
+	unsigned long tap_cnt;	/* counter of tuning success */
+	unsigned long tap_set;	/* tap position */
+	unsigned long tap_start;	/* start position of tuning success */
+	unsigned long tap_end;	/* end position of tuning success */
+	unsigned long ntap;	/* temporary counter of tuning success */
+	unsigned long i;
+
+	/* Clear SCC_RVSREQ */
+	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
+
+	/* Select SCC */
+	tap_num = (sd_scc_read32(host, SH_MOBILE_SDHI_SCC_DTCNTL) >>
+		   SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT) &
+		SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK;
+
+	tap_cnt = 0;
+	ntap = 0;
+	tap_start = 0;
+	tap_end = 0;
+	for (i = 0; i < tap_num * 2; i++) {
+		if (tap[i] == 0)
+			ntap++;
+		else {
+			if (ntap > tap_cnt) {
+				tap_start = i - ntap;
+				tap_end = i - 1;
+				tap_cnt = ntap;
+			}
+			ntap = 0;
+		}
+	}
+
+	if (ntap > tap_cnt) {
+		tap_start = i - ntap;
+		tap_end = i - 1;
+		tap_cnt = ntap;
+	}
+
+	if (tap_cnt >= SH_MOBILE_SDHI_MAX_TAP)
+		tap_set = (tap_start + tap_end) / 2 % tap_num;
+	else
+		return -EIO;
+
+	/* Set SCC */
+	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_TAPSET, tap_set);
+
+	/* Enable auto re-tuning */
+	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_RVSCNTL,
+		SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN |
+		sd_scc_read32(host, SH_MOBILE_SDHI_SCC_RVSCNTL));
+
+	return 0;
+}
+
+static bool sh_mobile_sdhi_retuning(struct tmio_mmc_host *host)
+{
+	/* Check SCC error */
+	if (sd_scc_read32(host, SH_MOBILE_SDHI_SCC_RVSCNTL) &
+	    SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &&
+	    sd_scc_read32(host, SH_MOBILE_SDHI_SCC_RVSREQ) &
+	    SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR) {
+		/* Clear SCC error */
+		sd_scc_write32(host, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
+		return true;
+	}
+	return false;
+}
+
+static void sh_mobile_sdhi_hw_reset(struct tmio_mmc_host *host)
+{
+	struct tmio_mmc_data *pdata = host->pdata;
+
+	if (pdata->flags & TMIO_MMC_HAS_UHS_SCC) {
+		/* Reset SCC */
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+		sd_scc_write32(host, SH_MOBILE_SDHI_SCC_CKSEL,
+			~SH_MOBILE_SDHI_SCC_CKSEL_DTSEL &
+			sd_scc_read32(host, SH_MOBILE_SDHI_SCC_CKSEL));
+
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x0100 |
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+		sd_scc_write32(host, SH_MOBILE_SDHI_SCC_RVSCNTL,
+			~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
+			sd_scc_read32(host, SH_MOBILE_SDHI_SCC_RVSCNTL));
+
+		sd_scc_write32(host, SH_MOBILE_SDHI_SCC_RVSCNTL,
+			~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
+			sd_scc_read32(host, SH_MOBILE_SDHI_SCC_RVSCNTL));
+	}
+}
+
 static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
 {
 	int timeout = 1000;
@@ -311,7 +542,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct tmio_mmc_data *mmd = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
 	struct resource *res;
-	int irq, ret, i = 0;
+	int irq, ret, i;
 	struct tmio_mmc_dma *dma_priv;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -357,6 +588,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		host->bus_shift = of_data->bus_shift;
 	}
 
+	host->set_clk_div	= sh_mobile_sdhi_set_clk_div;
 	host->dma		= dma_priv;
 	host->write16_hook	= sh_mobile_sdhi_write16_hook;
 	host->clk_enable	= sh_mobile_sdhi_clk_enable;
@@ -364,6 +596,12 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	host->clk_disable	= sh_mobile_sdhi_clk_disable;
 	host->multi_io_quirk	= sh_mobile_sdhi_multi_io_quirk;
 	host->start_signal_voltage_switch = sh_mobile_sdhi_start_signal_voltage_switch;
+	host->inquiry_tuning	= sh_mobile_sdhi_inquiry_tuning;
+	host->init_tuning	= sh_mobile_sdhi_init_tuning;
+	host->prepare_tuning	= sh_mobile_sdhi_prepare_tuning;
+	host->select_tuning	= sh_mobile_sdhi_select_tuning;
+	host->retuning		= sh_mobile_sdhi_retuning;
+	host->hw_reset		= sh_mobile_sdhi_hw_reset;
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
 	if (!host->bus_shift && resource_size(res) > 0x100) /* old way to determine the shift */
@@ -403,6 +641,30 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto efree;
 
+	if (mmc_data->capabilities & MMC_CAP_UHS_SDR104) {
+		mmc_data->capabilities |= MMC_CAP_HW_RESET;
+		mmc_data->flags |= TMIO_MMC_HAS_UHS_SCC;
+	}
+
+	if (of_id && of_id->data) {
+		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
+		const struct sh_mobile_sdhi_scc *taps = of_data->taps;
+		bool hit = false;
+
+		for (i = 0; i < of_data->taps_num; i++) {
+			if (taps[i].clk == 0 ||
+			    taps[i].clk == host->mmc->f_max) {
+				host->scc_tappos = taps->tap;
+				hit = true;
+				break;
+			}
+		}
+
+		if (!hit)
+			dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104 and HS200\n");
+	}
+
+	i = 0;
 	while (1) {
 		irq = platform_get_irq(pdev, i);
 		if (irq < 0)
-- 
2.1.4
