From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 15/16] mmc: meson-gx: change default tx phase
Date: Mon, 21 Aug 2017 18:03:00 +0200
Message-ID: <20170821160301.21899-16-jbrunet@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821160301.21899-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Initial default tx phase was set to 0 while the datasheet recommends 270.
Some cards fails to initialize with this setting and eMMC mode DDR52 does
not work.

Changing this setting to 270 fixes these issues, without any regression
so far

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 3167f561e1a6..290631d46a4b 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1158,8 +1158,14 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_host;
 
+        /*
+	 * Set phases : These values are mostly the datasheet recommended ones
+	 * except for the Tx phase. Datasheet recommends 180 but some cards
+	 * fail at initialisation with it. 270 works just fine, it fixes these
+	 * initialisation issues and enable eMMC DDR52 mode.
+	 */
 	host->tp.core_phase = 180;
-	host->tp.tx_phase = 0;
+	host->tp.tx_phase = 270;
 	host->tp.rx_phase = 0;
 
 	ret = meson_mmc_clk_init(host);
-- 
2.9.5
