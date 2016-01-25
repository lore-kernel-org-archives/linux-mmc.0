From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 7/9] mmc: tmio: refactor set_clock a little
Date: Mon, 25 Jan 2016 20:15:14 +0100
Message-ID: <1453749316-1848-8-git-send-email-wsa@the-dreams.de>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Some of the indentation made the code awful to read. Fix that. Also,
introduce defines instead of magic hex values. Note that this includes
one change: We mask out know 0xff instead of 0x1ff. But 0x100 has always
been the clock enable bit. It doesn't make any sense to set it depending
on the clock calculation. Update copyright notices, too. I'll be working
on those files some more in the future.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

copy
---
 drivers/mmc/host/tmio_mmc_pio.c | 15 +++++++++------
 include/linux/mmc/tmio.h        |  5 +++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 207e77a09cda51..7f6b5adf12094b 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1,6 +1,8 @@
 /*
  * linux/drivers/mmc/host/tmio_mmc_pio.c
  *
+ * Copyright (C) 2016 Sang Engineering, Wolfram Sang
+ * Copyright (C) 2015-16 Renesas Electronics Corporation
  * Copyright (C) 2011 Guennadi Liakhovetski
  * Copyright (C) 2007 Ian Molton
  * Copyright (C) 2004 Ian Molton
@@ -159,19 +161,20 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 
 	if (new_clock) {
 		for (clock = host->mmc->f_min, clk = 0x80000080;
-			new_clock >= (clock<<1); clk >>= 1)
+		     new_clock >= (clock << 1);
+		     clk >>= 1)
 			clock <<= 1;
 
 		/* 1/1 clock is option */
 		if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) &&
-		    ((clk >> 22) & 0x1))
+		   ((clk >> 22) & 0x1))
 			clk |= 0xff;
 	}
 
 	if (host->set_clk_div)
-		host->set_clk_div(host->pdev, (clk>>22) & 1);
+		host->set_clk_div(host->pdev, (clk >> 22) & 1);
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & 0x1ff);
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
 	if (!(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG))
 		msleep(10);
 }
@@ -183,14 +186,14 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 		msleep(10);
 	}
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 5 : 10);
 }
 
 static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 {
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x0100 |
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 1 : 10);
 
diff --git a/include/linux/mmc/tmio.h b/include/linux/mmc/tmio.h
index 84d9053b5dca3e..5f5cd80e976500 100644
--- a/include/linux/mmc/tmio.h
+++ b/include/linux/mmc/tmio.h
@@ -1,6 +1,8 @@
 /*
  * include/linux/mmc/tmio.h
  *
+ * Copyright (C) 2016 Sang Engineering, Wolfram Sang
+ * Copyright (C) 2015-16 Renesas Electronics Corporation
  * Copyright (C) 2007 Ian Molton
  * Copyright (C) 2004 Ian Molton
  *
@@ -61,6 +63,9 @@
 #define TMIO_STAT_CMD_BUSY      0x40000000
 #define TMIO_STAT_ILL_ACCESS    0x80000000
 
+#define	CLK_CTL_DIV_MASK	0xff
+#define	CLK_CTL_SCLKEN		BIT(8)
+
 #define TMIO_BBS		512		/* Boot block size */
 
 #endif /* LINUX_MMC_TMIO_H */
-- 
2.1.4

