From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 02/14] mmc: meson-gx: remove CLK_DIVIDER_ALLOW_ZERO clock flag
Date: Fri,  4 Aug 2017 19:43:41 +0200
Message-ID: <20170804174353.16486-3-jbrunet@baylibre.com>
References: <20170804174353.16486-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170804174353.16486-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Remove CLK_DIVIDER_ALLOW_ZERO. This flag means that a 1 based divider
with a 0 value will behave as a bypass clock

The mmc divider does not behave like this, a 0 value disables the clock
Remove this flag so CCF never allows a 0 value on this clock

Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 4217287923d4..d480a8052a06 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -389,7 +389,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	host->cfg_div.width = __builtin_popcountl(CLK_DIV_MASK);
 	host->cfg_div.hw.init = &init;
 	host->cfg_div.flags = CLK_DIVIDER_ONE_BASED |
-		CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ALLOW_ZERO;
+		CLK_DIVIDER_ROUND_CLOSEST;
 
 	host->cfg_div_clk = devm_clk_register(host->dev, &host->cfg_div.hw);
 	if (WARN_ON(PTR_ERR_OR_ZERO(host->cfg_div_clk)))
-- 
2.9.4
