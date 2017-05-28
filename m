From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/7] mmc: use proper name for the R-Car SoC
Date: Sun, 28 May 2017 11:30:47 +0200
Message-ID: <20170528093051.11816-5-wsa+renesas@sang-engineering.com>
References: <20170528093051.11816-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170528093051.11816-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

It is 'R-Car', not 'RCar'. No code or binding changes, only descriptive text.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
I suggest this trivial patch should be picked individually per susbsystem.

 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 include/linux/mfd/tmio.h             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 846ee1a8e5a675..397b3e29977ea8 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -130,7 +130,7 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
 	int i, ret;
 
-	/* tested only on RCar Gen2+ currently; may work for others */
+	/* tested only on R-Car Gen2+ currently; may work for others */
 	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
 		return clk_get_rate(priv->clk);
 
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index a1520d88ebf3a3..c83c16b931a886 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -66,7 +66,7 @@
  */
 #define TMIO_MMC_SDIO_IRQ		(1 << 2)
 
-/* Some features are only available or tested on RCar Gen2 or later */
+/* Some features are only available or tested on R-Car Gen2 or later */
 #define TMIO_MMC_MIN_RCAR2		(1 << 3)
 
 /*
-- 
2.11.0
