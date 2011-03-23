From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/4 v3] mmc: tmio: only access registers above 0xff, if
 available
Date: Wed, 23 Mar 2011 14:49:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103231446280.6836@axis700.grange>
References: <Pine.LNX.4.64.1103231445070.6836@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1103231445070.6836@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Not all tmio implementations have registers above oxff. Accessing
them on thise platforms is dangerous. In some cases it leads to
address wrapping to addresses below 0x100, which corrupts random
unrelated registers.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a7406e3..28e14c7 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -209,6 +209,7 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host, int new_clock)
 static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 {
 	struct tmio_mmc_data *pdata = host->pdata;
+	struct resource *res = platform_get_resource(host->pdev, IORESOURCE_MEM, 0);
 
 	/*
 	 * Testing on sh-mobile showed that SDIO IRQs are unmasked when
@@ -218,8 +219,11 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 	 */
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		disable_irq(host->irq);
-	sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
-	msleep(10);
+	/* implicit BUG_ON(!res) */
+	if (resource_size(res) > 0x100) {
+		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
+		msleep(10);
+	}
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
 		tmio_mmc_enable_sdio_irq(host->mmc, host->sdio_irq_enabled);
 		enable_irq(host->irq);
@@ -232,6 +236,7 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 {
 	struct tmio_mmc_data *pdata = host->pdata;
+	struct resource *res = platform_get_resource(host->pdev, IORESOURCE_MEM, 0);
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x0100 |
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
@@ -239,8 +244,11 @@ static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 	/* see comment in tmio_mmc_clk_stop above */
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		disable_irq(host->irq);
-	sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
-	msleep(10);
+	/* implicit BUG_ON(!res) */
+	if (resource_size(res) > 0x100) {
+		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
+		msleep(10);
+	}
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
 		tmio_mmc_enable_sdio_irq(host->mmc, host->sdio_irq_enabled);
 		enable_irq(host->irq);
@@ -249,12 +257,17 @@ static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 
 static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
+	struct resource *res = platform_get_resource(host->pdev, IORESOURCE_MEM, 0);
+
 	/* FIXME - should we set stop clock reg here */
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
-	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
+	/* implicit BUG_ON(!res) */
+	if (resource_size(res) > 0x100)
+		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
 	msleep(10);
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
-	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
+	if (resource_size(res) > 0x100)
+		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
 	msleep(10);
 }
 
-- 
1.7.2.5

