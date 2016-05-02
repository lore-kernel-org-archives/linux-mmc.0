From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 4/4] mmc: sh_mobile_sdhi: check return value when changing clk
Date: Mon,  2 May 2016 22:25:42 +0200
Message-ID: <1462220742-4426-5-git-send-email-wsa@the-dreams.de>
References: <1462220742-4426-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1462220742-4426-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

And return the old clock rate if something went wrong.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index ac9ba36da39b5b..5309c73be1f04f 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -166,7 +166,7 @@ static unsigned int sh_mobile_sdhi_clk_update(struct tmio_mmc_host *host,
 {
 	struct sh_mobile_sdhi *priv = host_to_priv(host);
 	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
-	int i;
+	int i, ret;
 
 	/* tested only on RCar Gen2+ currently; may work for others */
 	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
@@ -195,9 +195,9 @@ static unsigned int sh_mobile_sdhi_clk_update(struct tmio_mmc_host *host,
 		}
 	}
 
-	clk_set_rate(priv->clk, best_freq);
+	ret = clk_set_rate(priv->clk, best_freq);
 
-	return best_freq;
+	return ret == 0 ? best_freq : clk_get_rate(priv->clk);
 }
 
 static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
-- 
2.6.2
