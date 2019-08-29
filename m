From: =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH v2] mmc: sdhi: fill in actual_clock
Date: Thu, 29 Aug 2019 20:36:34 +0200
Message-ID: <20190829183634.3376-1-tszucs@protonmail.ch>
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
 drivers/mmc/host/renesas_sdhi_core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 64d3b5fb7fe5..4c9774dbcfc1 100644
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
@@ -153,9 +153,9 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 		}
 	}
 
-	ret = clk_set_rate(priv->clk, best_freq);
+	clk_set_rate(priv->clk, best_freq);
 
-	return ret == 0 ? best_freq : clk_get_rate(priv->clk);
+	return clk_get_rate(priv->clk);
 }
 
 static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
@@ -166,10 +166,13 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
-	if (new_clock == 0)
+	if (new_clock == 0) {
+		host->mmc->actual_clock = 0;
 		goto out;
+	}
 
-	clock = renesas_sdhi_clk_update(host, new_clock) / 512;
+	host->mmc->actual_clock = renesas_sdhi_clk_update(host, new_clock);
+	clock = host->mmc->actual_clock / 512;
 
 	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
 		clock <<= 1;
-- 
2.11.0
