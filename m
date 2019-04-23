From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 4/7] mmc: meson-gx: disable HS400
Date: Tue, 23 Apr 2019 11:02:32 +0200
Message-ID: <20190423090235.17244-5-jbrunet@baylibre.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423090235.17244-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

At the moment, all our attempts to enable HS400 on Amlogic chipsets have
been unsuccessful or unreliable. Until we can figure out how to enable this
mode safely and reliably, let's force it off.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 3df50b53f834..118f09da8dfb 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -823,10 +823,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (meson_mmc_timing_is_ddr(ios))
 		val |= CFG_DDR;
 
-	val &= ~CFG_CHK_DS;
-	if (ios->timing == MMC_TIMING_MMC_HS400)
-		val |= CFG_CHK_DS;
-
 	err = meson_mmc_clk_set(host, ios);
 	if (err)
 		dev_err(host->dev, "Failed to set clock: %d\n,", err);
@@ -1339,6 +1335,13 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	mmc->max_segs = SD_EMMC_DESC_BUF_LEN / sizeof(struct sd_emmc_desc);
 	mmc->max_seg_size = mmc->max_req_size;
 
+	/*
+	 * At the moment, we don't know how to reliably enable HS400.
+	 * From the different datasheets, it is not even clear if this mode
+	 * is officially supported by any of the SoCs
+	 */
+	mmc->caps2 &= ~MMC_CAP2_HS400;
+
 	/* data bounce buffer */
 	host->bounce_buf_size = mmc->max_req_size;
 	host->bounce_buf =
-- 
2.20.1
