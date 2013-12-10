From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH Resend 3/3] mmc: sdhci-s3c: sdhci-s3c driver use sdhci-pltfm
Date: Tue, 10 Dec 2013 17:27:36 +0900
Message-ID: <52A6D078.5000208@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:37325 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642Ab3LJI1f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 03:27:35 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXL008120TXHOA0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 10 Dec 2013 17:27:33 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>

This patch revised to use sdhci-pltfm.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |  259 ++++++++++++++++++------------------------
 1 file changed, 111 insertions(+), 148 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 6debda9..80d116f 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -30,6 +30,7 @@

 #include "sdhci-s3c-regs.h"
 #include "sdhci.h"
+#include "sdhci-pltfm.h"

 #define MAX_BUS_CLK	(4)

@@ -38,24 +39,15 @@

 /**
  * struct sdhci_s3c - S3C SDHCI instance
- * @host: The SDHCI host created
  * @pdev: The platform device we where created from.
- * @ioarea: The resource created when we claimed the IO area.
  * @pdata: The platform data for this controller.
- * @cur_clk: The index of the current bus clock.
- * @clk_io: The clock for the internal bus interface.
  * @clk_bus: The clocks that are available for the SD/MMC bus clock.
  */
 struct sdhci_s3c {
-	struct sdhci_host	*host;
 	struct platform_device	*pdev;
-	struct resource		*ioarea;
 	struct s3c_sdhci_platdata *pdata;
-	unsigned int		cur_clk;
 	int			ext_cd_irq;
 	int			ext_cd_gpio;
-
-	struct clk		*clk_io;
 	struct clk		*clk_bus[MAX_BUS_CLK];
 };

@@ -71,11 +63,6 @@ struct sdhci_s3c_drv_data {
 	unsigned int	sdhci_quirks;
 };

-static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
-{
-	return sdhci_priv(host);
-}
-
 /**
  * get_curclk - convert ctrl2 register to clock source number
  * @ctrl2: Control2 register value.
@@ -90,14 +77,15 @@ static u32 get_curclk(u32 ctrl2)

 static void sdhci_s3c_check_sclk(struct sdhci_host *host)
 {
-	struct sdhci_s3c *ourhost = to_s3c(host);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_s3c *ourhost = pltfm_host->priv;
 	u32 tmp = readl(host->ioaddr + S3C_SDHCI_CONTROL2);

-	if (get_curclk(tmp) != ourhost->cur_clk) {
+	if (get_curclk(tmp) != pltfm_host->clock) {
 		dev_dbg(&ourhost->pdev->dev, "restored ctrl2 clock setting\n");

 		tmp &= ~S3C_SDHCI_CTRL2_SELBASECLK_MASK;
-		tmp |= ourhost->cur_clk << S3C_SDHCI_CTRL2_SELBASECLK_SHIFT;
+		tmp |= pltfm_host->clock << S3C_SDHCI_CTRL2_SELBASECLK_SHIFT;
 		writel(tmp, host->ioaddr + S3C_SDHCI_CONTROL2);
 	}
 }
@@ -110,7 +98,8 @@ static void sdhci_s3c_check_sclk(struct sdhci_host *host)
 */
 static unsigned int sdhci_s3c_get_max_clk(struct sdhci_host *host)
 {
-	struct sdhci_s3c *ourhost = to_s3c(host);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_s3c *ourhost = pltfm_host->priv;
 	struct clk *busclk;
 	unsigned int rate, max;
 	int clk;
@@ -138,11 +127,13 @@ static unsigned int sdhci_s3c_get_max_clk(struct sdhci_host *host)
  * @src: The source clock index.
  * @wanted: The clock frequency wanted.
  */
-static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
+static unsigned int sdhci_s3c_consider_clock(struct sdhci_host *host,
 					     unsigned int src,
 					     unsigned int wanted)
 {
 	unsigned long rate;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_s3c *ourhost = pltfm_host->priv;
 	struct clk *clksrc = ourhost->clk_bus[src];
 	int div;

@@ -153,7 +144,7 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 	 * If controller uses a non-standard clock division, find the best clock
 	 * speed possible with selected clock source and skip the division.
 	 */
-	if (ourhost->host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
+	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
 		rate = clk_round_rate(clksrc, wanted);
 		return wanted - rate;
 	}
@@ -181,7 +172,8 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 */
 static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	struct sdhci_s3c *ourhost = to_s3c(host);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_s3c *ourhost = pltfm_host->priv;
 	unsigned int best = UINT_MAX;
 	unsigned int delta;
 	int best_src = 0;
@@ -193,7 +185,7 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 		return;

 	for (src = 0; src < MAX_BUS_CLK; src++) {
-		delta = sdhci_s3c_consider_clock(ourhost, src, clock);
+		delta = sdhci_s3c_consider_clock(host, src, clock);
 		if (delta < best) {
 			best = delta;
 			best_src = src;
@@ -205,16 +197,16 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 		 best_src, clock, best);

 	/* select the new clock source */
-	if (ourhost->cur_clk != best_src) {
+	if (pltfm_host->clock != best_src) {
 		struct clk *clk = ourhost->clk_bus[best_src];

 		clk_prepare_enable(clk);
-		clk_disable_unprepare(ourhost->clk_bus[ourhost->cur_clk]);
+		clk_disable_unprepare(ourhost->clk_bus[pltfm_host->clock]);

 		/* turn clock off to card before changing clock source */
 		writew(0, host->ioaddr + SDHCI_CLOCK_CONTROL);

-		ourhost->cur_clk = best_src;
+		pltfm_host->clock = best_src;
 		host->max_clk = clk_get_rate(clk);

 		ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
@@ -253,12 +245,11 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 */
 static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *host)
 {
-	struct sdhci_s3c *ourhost = to_s3c(host);
 	unsigned int delta, min = UINT_MAX;
 	int src;

 	for (src = 0; src < MAX_BUS_CLK; src++) {
-		delta = sdhci_s3c_consider_clock(ourhost, src, 0);
+		delta = sdhci_s3c_consider_clock(host, src, 0);
 		if (delta == UINT_MAX)
 			continue;
 		/* delta is a negative value in this case */
@@ -271,27 +262,30 @@ static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *host)
 /* sdhci_cmu_get_max_clk - callback to get maximum clock frequency.*/
 static unsigned int sdhci_cmu_get_max_clock(struct sdhci_host *host)
 {
-	struct sdhci_s3c *ourhost = to_s3c(host);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_s3c *ourhost = pltfm_host->priv;

-	return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk], UINT_MAX);
+	return clk_round_rate(ourhost->clk_bus[pltfm_host->clock], UINT_MAX);
 }

 /* sdhci_cmu_get_min_clock - callback to get minimal supported clock value. */
 static unsigned int sdhci_cmu_get_min_clock(struct sdhci_host *host)
 {
-	struct sdhci_s3c *ourhost = to_s3c(host);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_s3c *ourhost = pltfm_host->priv;

 	/*
 	 * initial clock can be in the frequency range of
 	 * 100KHz-400KHz, so we set it as max value.
 	 */
-	return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk], 400000);
+	return clk_round_rate(ourhost->clk_bus[pltfm_host->clock], 400000);
 }

 /* sdhci_cmu_set_clock - callback on clock change.*/
 static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	struct sdhci_s3c *ourhost = to_s3c(host);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_s3c *ourhost = pltfm_host->priv;
 	struct device *dev = &ourhost->pdev->dev;
 	unsigned long timeout;
 	u16 clk = 0;
@@ -305,7 +299,7 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)

 	sdhci_s3c_set_clock(host, clock);

-	clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
+	clk_set_rate(ourhost->clk_bus[pltfm_host->clock], clock);

 	host->clock = clock;

@@ -319,6 +313,7 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 		if (timeout == 0) {
 			dev_err(dev, "%s: Internal clock never stabilised.\n",
 				mmc_hostname(host->mmc));
+
 			return;
 		}
 		timeout--;
@@ -373,27 +368,18 @@ static struct sdhci_ops sdhci_s3c_ops = {
 static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
-#ifdef CONFIG_PM_RUNTIME
-	struct sdhci_s3c *sc = sdhci_priv(host);
-#endif
 	unsigned long flags;

 	if (host) {
 		spin_lock_irqsave(&host->lock, flags);
 		if (state) {
 			dev_dbg(&dev->dev, "card inserted.\n");
-#ifdef CONFIG_PM_RUNTIME
-			clk_prepare_enable(sc->clk_io);
-#endif
 			host->flags &= ~SDHCI_DEVICE_DEAD;
 			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		} else {
 			dev_dbg(&dev->dev, "card removed.\n");
 			host->flags |= SDHCI_DEVICE_DEAD;
 			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
-#ifdef CONFIG_PM_RUNTIME
-			clk_disable_unprepare(sc->clk_io);
-#endif
 		}
 		tasklet_schedule(&host->card_tasklet);
 		spin_unlock_irqrestore(&host->lock, flags);
@@ -439,14 +425,23 @@ static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
 }

 #ifdef CONFIG_OF
-static int sdhci_s3c_parse_dt(struct device *dev,
-		struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
+static struct s3c_sdhci_platdata *sdhci_s3c_parse_dt(struct device *dev)
 {
+	struct s3c_sdhci_platdata *pdata = NULL;
 	struct device_node *node = dev->of_node;
-	struct sdhci_s3c *ourhost = to_s3c(host);
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_s3c *ourhost = pltfm_host->priv;
+
 	u32 max_width;
 	int gpio;

+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(dev, "No memory for pdata\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	/* if the bus-width property is not specified, assume width as 1 */
 	if (of_property_read_u32(node, "bus-width", &max_width))
 		max_width = 1;
@@ -455,12 +450,12 @@ static int sdhci_s3c_parse_dt(struct device *dev,
 	/* get the card detection method */
 	if (of_get_property(node, "broken-cd", NULL)) {
 		pdata->cd_type = S3C_SDHCI_CD_NONE;
-		return 0;
+		return pdata;
 	}

 	if (of_get_property(node, "non-removable", NULL)) {
 		pdata->cd_type = S3C_SDHCI_CD_PERMANENT;
-		return 0;
+		return pdata;
 	}

 	gpio = of_get_named_gpio(node, "cd-gpios", 0);
@@ -470,21 +465,20 @@ static int sdhci_s3c_parse_dt(struct device *dev,
 		ourhost->ext_cd_gpio = -1;
 		if (of_get_property(node, "cd-inverted", NULL))
 			pdata->ext_cd_gpio_invert = 1;
-		return 0;
+		return pdata;
 	} else if (gpio != -ENOENT) {
 		dev_err(dev, "invalid card detect gpio specified\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}

 	/* assuming internal card detect that will be configured by pinctrl */
 	pdata->cd_type = S3C_SDHCI_CD_INTERNAL;
-	return 0;
+	return pdata;
 }
 #else
-static int sdhci_s3c_parse_dt(struct device *dev,
-		struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
+static struct s3c_sdhci_platdata *sdhci_s3c_parse_dt(struct device *dev)
 {
-	return -EINVAL;
+	return ERR_PTR(-EINVAL);
 }
 #endif

@@ -504,66 +498,69 @@ static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
 			platform_get_device_id(pdev)->driver_data;
 }

+static struct sdhci_pltfm_data sdhci_s3c_pdata = {
+	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
+		SDHCI_QUIRK_NO_HISPD_BIT | SDHCI_QUIRK_NO_BUSY_IRQ |
+		SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
+		SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
+		SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE |
+		SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+	.ops = &sdhci_s3c_ops,
+};
+
 static int sdhci_s3c_probe(struct platform_device *pdev)
 {
-	struct s3c_sdhci_platdata *pdata;
 	struct sdhci_s3c_drv_data *drv_data;
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host;
 	struct sdhci_s3c *sc;
-	struct resource *res;
-	int ret, irq, ptr, clks;
+	int ret = 0, ptr, clks;
+	struct sdhci_pltfm_host *pltfm_host;

 	if (!pdev->dev.platform_data && !pdev->dev.of_node) {
 		dev_err(dev, "no device data specified\n");
 		return -ENOENT;
 	}

-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq specified\n");
-		return irq;
-	}
-
-	host = sdhci_alloc_host(dev, sizeof(struct sdhci_s3c));
+	host = sdhci_pltfm_init(pdev, &sdhci_s3c_pdata);
 	if (IS_ERR(host)) {
 		dev_err(dev, "sdhci_alloc_host() failed\n");
 		return PTR_ERR(host);
 	}
-	sc = sdhci_priv(host);

-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
+	sc = devm_kzalloc(dev, sizeof(struct sdhci_s3c), GFP_KERNEL);
+	if (!sc) {
 		ret = -ENOMEM;
 		goto err_pdata_io_clk;
 	}

+	pltfm_host = sdhci_priv(host);
+	pltfm_host->priv = sc;
+
 	if (pdev->dev.of_node) {
-		ret = sdhci_s3c_parse_dt(&pdev->dev, host, pdata);
-		if (ret)
+		sc->pdata = sdhci_s3c_parse_dt(&pdev->dev);
+		if (!sc->pdata)
 			goto err_pdata_io_clk;
 	} else {
-		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
+		memcpy(&sc->pdata, &pdev->dev.platform_data, sizeof(sc->pdata));
 		sc->ext_cd_gpio = -1; /* invalid gpio number */
 	}

 	drv_data = sdhci_s3c_get_driver_data(pdev);
+	if (drv_data)
+		host->quirks |= drv_data->sdhci_quirks;

-	sc->host = host;
 	sc->pdev = pdev;
-	sc->pdata = pdata;
-
-	platform_set_drvdata(pdev, host);

-	sc->clk_io = devm_clk_get(dev, "hsmmc");
-	if (IS_ERR(sc->clk_io)) {
+	pltfm_host->clk = devm_clk_get(dev, "hsmmc");
+	if (IS_ERR(pltfm_host->clk)) {
 		dev_err(dev, "failed to get io clock\n");
-		ret = PTR_ERR(sc->clk_io);
+		ret = PTR_ERR(pltfm_host->clk);
 		goto err_pdata_io_clk;
 	}

 	/* enable the local io clock and keep it running for the moment. */
-	clk_prepare_enable(sc->clk_io);
+	clk_prepare_enable(pltfm_host->clk);

 	for (clks = 0, ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
 		struct clk *clk;
@@ -581,7 +578,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 		 * save current clock index to know which clock bus
 		 * is used later in overriding functions.
 		 */
-		sc->cur_clk = ptr;
+		pltfm_host->clock = ptr;

 		dev_info(dev, "clock source %d: %s (%ld Hz)\n",
 			 ptr, name, clk_get_rate(clk));
@@ -594,31 +591,12 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	}

 #ifndef CONFIG_PM_RUNTIME
-	clk_prepare_enable(sc->clk_bus[sc->cur_clk]);
+	clk_prepare_enable(sc->clk_bus[pltfm_host->clock]);
 #endif

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	host->ioaddr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(host->ioaddr)) {
-		ret = PTR_ERR(host->ioaddr);
-		goto err_req_regs;
-	}
-
 	/* Ensure we have minimal gpio selected CMD/CLK/Detect */
-	if (pdata->cfg_gpio)
-		pdata->cfg_gpio(pdev, pdata->max_width);
-
-	host->hw_name = "samsung-hsmmc";
-	host->ops = &sdhci_s3c_ops;
-	host->quirks = 0;
-	host->quirks2 = 0;
-	host->irq = irq;
-
-	/* Setup quirks for the controller */
-	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
-	host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
-	if (drv_data)
-		host->quirks |= drv_data->sdhci_quirks;
+	if (sc->pdata->cfg_gpio)
+		sc->pdata->cfg_gpio(pdev, sc->pdata->max_width);

 #ifndef CONFIG_MMC_SDHCI_S3C_DMA

@@ -626,27 +604,17 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	 * support as well. */
 	host->quirks |= SDHCI_QUIRK_BROKEN_DMA;

-#endif /* CONFIG_MMC_SDHCI_S3C_DMA */
-
-	/* It seems we do not get an DATA transfer complete on non-busy
-	 * transfers, not sure if this is a problem with this specific
-	 * SDHCI block, or a missing configuration that needs to be set. */
-	host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
-
-	/* This host supports the Auto CMD12 */
-	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;

-	/* Samsung SoCs need BROKEN_ADMA_ZEROLEN_DESC */
-	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC;
+#endif /* CONFIG_MMC_SDHCI_S3C_DMA */

-	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
-	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
+	if (sc->pdata->cd_type == S3C_SDHCI_CD_NONE ||
+	    sc->pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;

-	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
+	if (sc->pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->mmc->caps = MMC_CAP_NONREMOVABLE;

-	switch (pdata->max_width) {
+	switch (sc->pdata->max_width) {
 	case 8:
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 	case 4:
@@ -654,14 +622,8 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 		break;
 	}

-	if (pdata->pm_caps)
-		host->mmc->pm_caps |= pdata->pm_caps;
-
-	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
-			 SDHCI_QUIRK_32BIT_DMA_SIZE);
-
-	/* HSMMC on Samsung SoCs uses SDCLK as timeout clock */
-	host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
+	if (sc->pdata->pm_caps)
+		host->mmc->pm_caps |= sc->pdata->pm_caps;

 	/*
 	 * If controller does not have internal clock divider,
@@ -674,11 +636,11 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	}

 	/* It supports additional host capabilities if needed */
-	if (pdata->host_caps)
-		host->mmc->caps |= pdata->host_caps;
+	if (sc->pdata->host_caps)
+		host->mmc->caps |= sc->pdata->host_caps;

-	if (pdata->host_caps2)
-		host->mmc->caps2 |= pdata->host_caps2;
+	if (sc->pdata->host_caps2)
+		host->mmc->caps2 |= sc->pdata->host_caps2;

 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
@@ -696,25 +658,26 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	/* The following two methods of card detection might call
 	   sdhci_s3c_notify_change() immediately, so they can be called
 	   only after sdhci_add_host(). Setup errors are ignored. */
-	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_init)
-		pdata->ext_cd_init(&sdhci_s3c_notify_change);
-	if (pdata->cd_type == S3C_SDHCI_CD_GPIO &&
-	    gpio_is_valid(pdata->ext_cd_gpio))
+	if (sc->pdata->cd_type == S3C_SDHCI_CD_EXTERNAL &&
+	    sc->pdata->ext_cd_init)
+		sc->pdata->ext_cd_init(&sdhci_s3c_notify_change);
+	if (sc->pdata->cd_type == S3C_SDHCI_CD_GPIO &&
+	    gpio_is_valid(sc->pdata->ext_cd_gpio))
 		sdhci_s3c_setup_card_detect_gpio(sc);

 #ifdef CONFIG_PM_RUNTIME
-	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
-		clk_disable_unprepare(sc->clk_io);
+	if (sc->pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
+		clk_disable_unprepare(pltfm_host->clk);
 #endif
 	return 0;

  err_req_regs:
 #ifndef CONFIG_PM_RUNTIME
-	clk_disable_unprepare(sc->clk_bus[sc->cur_clk]);
+	clk_disable_unprepare(sc->clk_bus[pltfm_host->clock]);
 #endif

  err_no_busclks:
-	clk_disable_unprepare(sc->clk_io);
+	clk_disable_unprepare(pltfm_host->clk);

  err_pdata_io_clk:
 	sdhci_free_host(host);
@@ -725,7 +688,8 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 static int sdhci_s3c_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host =  platform_get_drvdata(pdev);
-	struct sdhci_s3c *sc = sdhci_priv(host);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_s3c *sc = pltfm_host->priv;
 	struct s3c_sdhci_platdata *pdata = sc->pdata;

 	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
@@ -736,7 +700,7 @@ static int sdhci_s3c_remove(struct platform_device *pdev)

 #ifdef CONFIG_PM_RUNTIME
 	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
-		clk_prepare_enable(sc->clk_io);
+		clk_prepare_enable(pltfm_host->clk);
 #endif
 	sdhci_remove_host(host, 1);

@@ -744,9 +708,9 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);

 #ifndef CONFIG_PM_RUNTIME
-	clk_disable_unprepare(sc->clk_bus[sc->cur_clk]);
+	clk_disable_unprepare(sc->clk_bus[pltfm_host->clock]);
 #endif
-	clk_disable_unprepare(sc->clk_io);
+	clk_disable_unprepare(pltfm_host->clk);

 	sdhci_free_host(host);

@@ -773,26 +737,25 @@ static int sdhci_s3c_resume(struct device *dev)
 static int sdhci_s3c_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_s3c *ourhost = to_s3c(host);
-	struct clk *busclk = ourhost->clk_io;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_s3c *ourhost = pltfm_host->priv;
 	int ret;

 	ret = sdhci_runtime_suspend_host(host);
-
-	clk_disable_unprepare(ourhost->clk_bus[ourhost->cur_clk]);
-	clk_disable_unprepare(busclk);
+	clk_disable_unprepare(ourhost->clk_bus[pltfm_host->clock]);
+	clk_disable_unprepare(pltfm_host->clk);
 	return ret;
 }

 static int sdhci_s3c_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_s3c *ourhost = to_s3c(host);
-	struct clk *busclk = ourhost->clk_io;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_s3c *ourhost = pltfm_host->priv;
 	int ret;

-	clk_prepare_enable(busclk);
-	clk_prepare_enable(ourhost->clk_bus[ourhost->cur_clk]);
+	clk_prepare_enable(pltfm_host->clk);
+	clk_prepare_enable(ourhost->clk_bus[pltfm_host->clock]);
 	ret = sdhci_runtime_resume_host(host);
 	return ret;
 }

-- 
1.7.9.5


