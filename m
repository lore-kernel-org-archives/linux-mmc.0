From: =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH] mmc: sdhi: fill in actual_clock
Date: Wed, 28 Aug 2019 20:55:18 +0200
Message-ID: <20190828185518.4340-1-tszucs@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
List-Id: linux-mmc@vger.kernel.org

Save set clock in mmc_host actual_clock enabling exporting it via debugfs.
This will indicate the precise SD clock in I/O settings rather than only the
sometimes misleading requested clock.

Signed-off-by: Tamás Szűcs <tszucs@protonmail.ch>
---
 drivers/mmc/host/renesas_sdhi_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 64d3b5fb7fe5..ae842d0b59f9 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -124,7 +124,7 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
-	int i, ret;
+	int i;
 
 	/* tested only on R-Car Gen2+ currently; may work for others */
 	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
@@ -153,9 +153,11 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 		}
 	}
 
-	ret = clk_set_rate(priv->clk, best_freq);
+	host->mmc->actual_clock =
+		clk_set_rate(priv->clk, best_freq) == 0 ?
+			best_freq : clk_get_rate(priv->clk);
 
-	return ret == 0 ? best_freq : clk_get_rate(priv->clk);
+	return host->mmc->actual_clock;
 }
 
 static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
-- 
2.11.0
