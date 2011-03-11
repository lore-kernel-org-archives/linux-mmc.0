From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/4 v2] mmc: mn57xx: remove work-around for unmasked SDIO
 interrupts
Date: Fri, 11 Mar 2011 09:09:44 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103110907460.23675@axis700.grange>
References: <Pine.LNX.4.64.1103110854050.23675@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1103110854050.23675@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

SDIO IRQs got unmasked on sh-mobile while writing to the
CTL_CLK_AND_WAIT_CTL register, because that register at address 0x138
is not implemented on those SoCs and writes to it overwrite the
register at address 0x38: CTL_SDIO_IRQ_MASK. Previous patches
eliminated access to register above 0xff on sh-mobile, so that this
work-around isn't needed anymore.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2:
 
1. rebase on top of driver split
2. remove the work-around only after users have been updated

 drivers/mmc/host/tmio_mmc_pio.c |   23 ++---------------------
 1 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 28e14c7..e1aed25 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -208,26 +208,14 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host, int new_clock)
 
 static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 {
-	struct tmio_mmc_data *pdata = host->pdata;
 	struct resource *res = platform_get_resource(host->pdev, IORESOURCE_MEM, 0);
 
-	/*
-	 * Testing on sh-mobile showed that SDIO IRQs are unmasked when
-	 * CTL_CLK_AND_WAIT_CTL gets written, so we have to disable the
-	 * device IRQ here and restore the SDIO IRQ mask before
-	 * re-enabling the device IRQ.
-	 */
-	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
-		disable_irq(host->irq);
 	/* implicit BUG_ON(!res) */
 	if (resource_size(res) > 0x100) {
 		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
 		msleep(10);
 	}
-	if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
-		tmio_mmc_enable_sdio_irq(host->mmc, host->sdio_irq_enabled);
-		enable_irq(host->irq);
-	}
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	msleep(10);
@@ -235,24 +223,17 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 
 static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 {
-	struct tmio_mmc_data *pdata = host->pdata;
 	struct resource *res = platform_get_resource(host->pdev, IORESOURCE_MEM, 0);
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x0100 |
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	msleep(10);
-	/* see comment in tmio_mmc_clk_stop above */
-	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
-		disable_irq(host->irq);
+
 	/* implicit BUG_ON(!res) */
 	if (resource_size(res) > 0x100) {
 		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
 		msleep(10);
 	}
-	if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
-		tmio_mmc_enable_sdio_irq(host->mmc, host->sdio_irq_enabled);
-		enable_irq(host->irq);
-	}
 }
 
 static void tmio_mmc_reset(struct tmio_mmc_host *host)
-- 
1.7.2.3

