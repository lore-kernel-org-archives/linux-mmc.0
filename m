From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [v0.1 PATCH 2/7] mmc: tmio: move tmio_mmc_set_clock() to platform hook
Date: Tue,  7 Aug 2018 15:17:17 +0900
Message-ID: <1533622642-13989-3-git-send-email-yamada.masahiro@socionext.com>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

tmio_mmc_set_clock() is full of quirks because different SoC vendors
extended this in different ways.

The original IP defines the divisor range 1/2 ... 1/512.

 bit 7 is set:    1/512
 bit 6 is set:    1/256
   ...
 bit 0 is set:    1/4
 all bits clear:  1/2

It is platform-dependent how to achieve the 1/1 clock.

I guess the TMIO-MFD variant uses the clock selector outside of this IP,
as far as I see tmio_core_mmc_clk_div() in drivers/mfd/tmio_core.c

I guess bit[7:0]=0xff is Renesas-specific extension.

Socionext (and Panasonic) uses bit 10 (CLKSEL) for 1/1.  Also, newer
versions of UniPhier SoC variants use bit 16 for 1/1024.

host->clk_update() is only used by the Renesas variants, whereas
host->set_clk_div() is only used by the TMIO-MFD variants.

To cope with this mess, promote tmio_mmc_set_clock() to a new
platform hook ->set_clock(), and melt the old two hooks into it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/renesas_sdhi_core.c | 50 ++++++++++++++++++++++-
 drivers/mmc/host/tmio_mmc.c          | 48 ++++++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h          |  4 +-
 drivers/mmc/host/tmio_mmc_core.c     | 79 ++++--------------------------------
 4 files changed, 105 insertions(+), 76 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 45c015da..1f4c82e 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -155,6 +155,54 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	return ret == 0 ? best_freq : clk_get_rate(priv->clk);
 }
 
+static void renesas_sdhi_clk_start(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		usleep_range(10000, 11000);
+}
+
+static void renesas_sdhi_clk_stop(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		usleep_range(10000, 11000);
+}
+
+static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
+				   unsigned int new_clock)
+{
+	u32 clk = 0, clock;
+
+	if (new_clock == 0) {
+		renesas_sdhi_clk_stop(host);
+		return;
+	}
+
+	clock = renesas_sdhi_clk_update(host, new_clock) / 512;
+
+	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
+		clock <<= 1;
+
+	/* 1/1 clock is option */
+	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && ((clk >> 22) & 0x1))
+		clk |= 0xff;
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		usleep_range(10000, 11000);
+
+	renesas_sdhi_clk_start(host);
+}
+
 static void renesas_sdhi_clk_disable(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
@@ -530,8 +578,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	host->write16_hook	= renesas_sdhi_write16_hook;
 	host->clk_enable	= renesas_sdhi_clk_enable;
-	host->clk_update	= renesas_sdhi_clk_update;
 	host->clk_disable	= renesas_sdhi_clk_disable;
+	host->set_clock		= renesas_sdhi_set_clock;
 	host->multi_io_quirk	= renesas_sdhi_multi_io_quirk;
 	host->dma_ops		= dma_ops;
 
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 43a2ea5..b031a77 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -13,6 +13,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/tmio.h>
@@ -23,6 +24,52 @@
 
 #include "tmio_mmc.h"
 
+static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	usleep_range(10000, 11000);
+	sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
+	usleep_range(10000, 11000);
+}
+
+static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
+	usleep_range(10000, 11000);
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	usleep_range(10000, 11000);
+}
+
+static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
+			       unsigned int new_clock)
+{
+	u32 clk = 0, clock;
+
+	if (new_clock == 0) {
+		tmio_mmc_clk_stop(host);
+		return;
+	}
+
+	clock = host->mmc->f_min;
+
+	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
+		clock <<= 1;
+
+	host->pdata->set_clk_div(host->pdev, (clk >> 22) & 1);
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
+	usleep_range(10000, 11000);
+
+	tmio_mmc_clk_start(host);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int tmio_mmc_suspend(struct device *dev)
 {
@@ -100,6 +147,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
 	host->bus_shift = resource_size(res) >> 10;
+	host->set_clock = tmio_mmc_set_clock;
 
 	host->mmc->f_max = pdata->hclk;
 	host->mmc->f_min = pdata->hclk / 512;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index e7d6513..e0aa3f9 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -132,7 +132,6 @@ struct tmio_mmc_host {
 
 	/* Callbacks for clock / power control */
 	void (*set_pwr)(struct platform_device *host, int state);
-	void (*set_clk_div)(struct platform_device *host, int state);
 
 	/* pio related stuff */
 	struct scatterlist      *sg_ptr;
@@ -169,10 +168,9 @@ struct tmio_mmc_host {
 
 	/* Mandatory callback */
 	int (*clk_enable)(struct tmio_mmc_host *host);
+	void (*set_clock)(struct tmio_mmc_host *host, unsigned int clock);
 
 	/* Optional callbacks */
-	unsigned int (*clk_update)(struct tmio_mmc_host *host,
-				   unsigned int new_clock);
 	void (*clk_disable)(struct tmio_mmc_host *host);
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 991b340..74b8972 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -160,70 +160,6 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
-static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
-{
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-
-	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
-		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
-		usleep_range(10000, 11000);
-	}
-}
-
-static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
-{
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
-		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
-		usleep_range(10000, 11000);
-	}
-
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-
-	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-}
-
-static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
-			       unsigned int new_clock)
-{
-	u32 clk = 0, clock;
-
-	if (new_clock == 0) {
-		tmio_mmc_clk_stop(host);
-		return;
-	}
-
-	if (host->clk_update)
-		clock = host->clk_update(host, new_clock) / 512;
-	else
-		clock = host->mmc->f_min;
-
-	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
-		clock <<= 1;
-
-	/* 1/1 clock is option */
-	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && ((clk >> 22) & 0x1))
-		clk |= 0xff;
-
-	if (host->set_clk_div)
-		host->set_clk_div(host->pdev, (clk >> 22) & 1);
-
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-
-	tmio_mmc_clk_start(host);
-}
-
 static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
 	/* FIXME - should we set stop clock reg here */
@@ -1032,15 +968,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		tmio_mmc_power_off(host);
-		tmio_mmc_set_clock(host, 0);
+		host->set_clock(host, 0);
 		break;
 	case MMC_POWER_UP:
 		tmio_mmc_power_on(host, ios->vdd);
-		tmio_mmc_set_clock(host, ios->clock);
+		host->set_clock(host, ios->clock);
 		tmio_mmc_set_bus_width(host, ios->bus_width);
 		break;
 	case MMC_POWER_ON:
-		tmio_mmc_set_clock(host, ios->clock);
+		host->set_clock(host, ios->clock);
 		tmio_mmc_set_bus_width(host, ios->bus_width);
 		break;
 	}
@@ -1196,7 +1132,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	int ret;
 
 	/*
-	 * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
+	 * Check the sanity of mmc->f_min to prevent host->set_clock() from
 	 * looping forever...
 	 */
 	if (mmc->f_min == 0)
@@ -1206,7 +1142,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 		_host->write16_hook = NULL;
 
 	_host->set_pwr = pdata->set_pwr;
-	_host->set_clk_div = pdata->set_clk_div;
 
 	ret = tmio_mmc_init_ocr(_host);
 	if (ret < 0)
@@ -1269,7 +1204,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
 
-	tmio_mmc_set_clock(_host, 0);
+	_host->set_clock(_host, 0);
 	tmio_mmc_reset(_host);
 
 	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
@@ -1353,7 +1288,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	if (host->clk_cache)
-		tmio_mmc_set_clock(host, 0);
+		host->set_clock(host, 0);
 
 	tmio_mmc_clk_disable(host);
 
@@ -1374,7 +1309,7 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	tmio_mmc_clk_enable(host);
 
 	if (host->clk_cache)
-		tmio_mmc_set_clock(host, host->clk_cache);
+		host->set_clock(host, host->clk_cache);
 
 	if (host->native_hotplug)
 		tmio_mmc_enable_mmc_irqs(host,
-- 
2.7.4
