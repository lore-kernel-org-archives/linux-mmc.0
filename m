From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 4/5] mmc: tmio/sdhi: distinguish between SCLKDIVEN and ILL_FUNC
Date: Tue, 26 Apr 2016 18:53:44 +0200
Message-ID: <1461689625-3693-5-git-send-email-wsa@the-dreams.de>
References: <1461689625-3693-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461689625-3693-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This bit has a different meaning in SDHI and original TMIO. Document
that and use the proper naming.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 3 ++-
 drivers/mmc/host/tmio_mmc.h       | 3 ++-
 drivers/mmc/host/tmio_mmc_pio.c   | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index b85b87eb55009f..5923ce7e0fccb3 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -244,7 +244,8 @@ static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
 {
 	int timeout = 1000;
 
-	while (--timeout && !(sd_ctrl_read16(host, CTL_STATUS2) & (1 << 13)))
+	while (--timeout && !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS)
+			      & TMIO_STAT_SCLKDIVEN))
 		udelay(1);
 
 	if (!timeout) {
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 55f251fdb78623..8dd5ea4be0a371 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -70,7 +70,8 @@
 #define TMIO_STAT_DAT0		BIT(23)	/* only known on R-Car so far */
 #define TMIO_STAT_RXRDY         BIT(24)
 #define TMIO_STAT_TXRQ          BIT(25)
-#define TMIO_STAT_ILL_FUNC      BIT(29)
+#define TMIO_STAT_ILL_FUNC      BIT(29) /* only when !TMIO_MMC_HAS_IDLE_WAIT */
+#define TMIO_STAT_SCLKDIVEN     BIT(29) /* only when TMIO_MMC_HAS_IDLE_WAIT */
 #define TMIO_STAT_CMD_BUSY      BIT(30)
 #define TMIO_STAT_ILL_ACCESS    BIT(31)
 
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index f4d8b5a741a875..e9b0271a81742a 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -548,7 +548,7 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 		 * waiting for one more interrupt fixes the problem.
 		 */
 		if (host->pdata->flags & TMIO_MMC_HAS_IDLE_WAIT) {
-			if (status & TMIO_STAT_ILL_FUNC)
+			if (status & TMIO_STAT_SCLKDIVEN)
 				done = true;
 		} else {
 			if (!(status & TMIO_STAT_CMD_BUSY))
-- 
2.7.0
