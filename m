From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] mmc: host: omap_hsmmc: add a verbose print to enable CONFIG_REGULATOR_PBIAS
Date: Thu, 14 Jan 2016 14:45:20 +0530
Message-ID: <1452762920-2588-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: pali.rohar@gmail.com, pavel@ucw.cz, sre@debian.org, sre@ring0.de, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, linux-mmc@vger.kernel.org, kishon@ti.com, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

Since v4.3+, CONFIG_REGULATOR_PBIAS should be enabled (for platforms that
have PBIAS regulator) in order for MMC1 to work.

Add a more verbose print to help enable CONFIG_REGULATOR_PBIAS for users
using a olddefconfig or a custom .config.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7fb0753..7086bd6 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -503,8 +503,11 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	host->pbias = devm_regulator_get_optional(host->dev, "pbias");
 	if (IS_ERR(host->pbias)) {
 		ret = PTR_ERR(host->pbias);
-		if ((ret != -ENODEV) && host->dev->of_node)
+		if ((ret != -ENODEV) && host->dev->of_node) {
+			dev_err(host->dev,
+			"SD card detect fail? enable CONFIG_REGULATOR_PBIAS\n");
 			return ret;
+		}
 		dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
 			PTR_ERR(host->pbias));
 		host->pbias = NULL;
-- 
1.7.9.5
