From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [RFT PATCH 3/4] mmc: meson-gx: align default phase on soc vendor tree
Date: Thu,  6 Dec 2018 16:18:27 +0100
Message-ID: <20181206151828.24417-4-jbrunet@baylibre.com>
References: <20181206151828.24417-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206151828.24417-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Align the default Core and Tx phase with the SoC vendor tree.
Even if the Tx phase is different from what the documentation
recommends, it seems to provide better results.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 5cc31e434ca1..837bed0b8c01 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -634,14 +634,8 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	if (ret)
 		return ret;
 
-	/*
-	 * Set phases : These values are mostly the datasheet recommended ones
-	 * except for the Tx phase. Datasheet recommends 180 but some cards
-	 * fail at initialisation with it. 270 works just fine, it fixes these
-	 * initialisation issues and enable eMMC DDR52 mode.
-	 */
 	clk_set_phase(host->mmc_clk, 180);
-	clk_set_phase(host->tx_clk, 270);
+	clk_set_phase(host->tx_clk, 0);
 	clk_set_phase(host->rx_clk, 0);
 
 	return clk_prepare_enable(host->mmc_clk);
-- 
2.19.2
