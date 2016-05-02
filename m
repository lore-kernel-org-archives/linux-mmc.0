From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 2/4] mmc: tmio/sdhi: introduce flag for RCar 2+ specific features
Date: Mon,  2 May 2016 22:25:40 +0200
Message-ID: <1462220742-4426-3-git-send-email-wsa@the-dreams.de>
References: <1462220742-4426-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1462220742-4426-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

RCar Gen2 and later implementations of TMIO/SDHI have their own set of
features and additions. FAST_CLK_CHG is just one of them and I see a few
others being added soon. Some may work on older chipsets but this needs
to be tested case by case. Instead of adding a bunch of flags for each
feature, add a global RCar2+ one for now. We can still break out
features if the need arises.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 4 ++--
 drivers/mmc/host/tmio_mmc_pio.c   | 6 +++---
 include/linux/mfd/tmio.h          | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 6857e4ba724415..19e4c29e4233b0 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -62,7 +62,7 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen1_compatible = {
 
 static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_FAST_CLK_CHG,
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
 	.dma_rx_offset	= 0x2000,
@@ -70,7 +70,7 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
 
 static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_FAST_CLK_CHG,
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED,
 	.bus_shift	= 2,
 };
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 95f22997f31a66..f44e2ab7aea2ba 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -157,7 +157,7 @@ static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 {
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 1 : 10);
+	msleep(host->pdata->flags & TMIO_MMC_MIN_RCAR2 ? 1 : 10);
 
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
 		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
@@ -174,7 +174,7 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 5 : 10);
+	msleep(host->pdata->flags & TMIO_MMC_MIN_RCAR2 ? 5 : 10);
 }
 
 static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
@@ -205,7 +205,7 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
-	if (!(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG))
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
 		msleep(10);
 
 	tmio_mmc_clk_start(host);
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 05d58ee5e6a78f..7a26286db895c5 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -66,8 +66,8 @@
  */
 #define TMIO_MMC_SDIO_IRQ		(1 << 2)
 
-/* Some controllers don't need to wait 10ms for clock changes */
-#define TMIO_MMC_FAST_CLK_CHG		(1 << 3)
+/* Some features are only available or tested on RCar Gen2 or later */
+#define TMIO_MMC_MIN_RCAR2		(1 << 3)
 
 /*
  * Some controllers require waiting for the SD bus to become
-- 
2.6.2
