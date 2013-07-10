From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 04/12] drivers/mmc/host: don't use
 devm_pinctrl_get_select_default() in probe
Date: Wed, 10 Jul 2013 16:57:39 +0100
Message-ID: <1373471889-18107-4-git-send-email-wsa@the-dreams.de>
References: <1373471889-18107-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1373471889-18107-1-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Marek Vasut <marex@denx.de>, Jingoo Han <jg1.han@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Balaji T K <balajitk@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <wsa@the-dreams.de>, linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-omap@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, Barry Song <baohua.song@csr.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-mmc@vger.kernel.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
we can rely on device core for setting the default pins. Compile tested only.

Acked-by: Linus Walleij <linus.walleij@linaro.org> (personally at LCE13)
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/mmc/host/mvsdio.c          |    6 ------
 drivers/mmc/host/mxs-mmc.c         |    8 --------
 drivers/mmc/host/omap_hsmmc.c      |    7 -------
 drivers/mmc/host/sdhci-esdhc-imx.c |    8 --------
 drivers/mmc/host/sdhci-sirf.c      |    8 --------
 5 files changed, 37 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 8960fc8..ed5edc2 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -25,7 +25,6 @@
 #include <linux/of_irq.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/slot-gpio.h>
-#include <linux/pinctrl/consumer.h>
 
 #include <asm/sizes.h>
 #include <asm/unaligned.h>
@@ -686,7 +685,6 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	struct resource *r;
 	int ret, irq;
 	int gpio_card_detect, gpio_write_protect;
-	struct pinctrl *pinctrl;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
@@ -703,10 +701,6 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	host->mmc = mmc;
 	host->dev = &pdev->dev;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl))
-		dev_warn(&pdev->dev, "no pins associated\n");
-
 	/*
 	 * Some non-DT platforms do not pass a clock, and the clock
 	 * frequency is passed through platform_data. On DT platforms,
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 4278a17..1eb3224 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -41,7 +41,6 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/stmp_device.h>
 #include <linux/spi/mxs-spi.h>
 
@@ -580,7 +579,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct mxs_mmc_host *host;
 	struct mmc_host *mmc;
 	struct resource *iores;
-	struct pinctrl *pinctrl;
 	int ret = 0, irq_err;
 	struct regulator *reg_vmmc;
 	enum of_gpio_flags flags;
@@ -620,12 +618,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		}
 	}
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		ret = PTR_ERR(pinctrl);
-		goto out_mmc_free;
-	}
-
 	ssp->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk)) {
 		ret = PTR_ERR(ssp->clk);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index eccedc7..332ce51 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -37,7 +37,6 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/mmc-omap.h>
 
@@ -1776,7 +1775,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
-	struct pinctrl *pinctrl;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
@@ -1995,11 +1993,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_disable_irq(host);
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl))
-		dev_warn(&pdev->dev,
-			"pins are not configured from the driver\n");
-
 	omap_hsmmc_protect_card(host);
 
 	mmc_add_host(mmc);
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d5f0d59..0880e3a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -25,7 +25,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/mmc-esdhc-imx.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -80,7 +79,6 @@ struct pltfm_imx_data {
 	int flags;
 	u32 scratchpad;
 	enum imx_esdhc_type devtype;
-	struct pinctrl *pinctrl;
 	struct esdhc_platform_data boarddata;
 	struct clk *clk_ipg;
 	struct clk *clk_ahb;
@@ -544,12 +542,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	clk_prepare_enable(imx_data->clk_ipg);
 	clk_prepare_enable(imx_data->clk_ahb);
 
-	imx_data->pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(imx_data->pinctrl)) {
-		err = PTR_ERR(imx_data->pinctrl);
-		goto disable_clk;
-	}
-
 	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 09805af..ccf12dd 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -13,7 +13,6 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/mmc/slot-gpio.h>
-#include <linux/pinctrl/consumer.h>
 #include "sdhci-pltfm.h"
 
 struct sdhci_sirf_priv {
@@ -46,15 +45,8 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_sirf_priv *priv;
-	struct pinctrl *pinctrl;
 	int ret;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		dev_err(&pdev->dev, "unable to get pinmux");
-		return PTR_ERR(pinctrl);
-	}
-
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_sirf_priv),
 		GFP_KERNEL);
 	if (!priv) {
-- 
1.7.10.4
