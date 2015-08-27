From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 10/15] mmc: host: omap_hsmmc: avoid pbias regulator enable on power off
Date: Thu, 27 Aug 2015 14:44:02 +0530
Message-ID: <1440666847-12594-11-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Fix omap_hsmmc_set_power so that pbias regulator is not enabled
during power off.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 810d612..eec6975 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -388,16 +388,16 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 		ret = omap_hsmmc_enable_supply(mmc, vdd);
 		if (ret)
 			return ret;
+
+		ret = omap_hsmmc_set_pbias(host, true, vdd);
+		if (ret)
+			goto err_set_voltage;
 	} else {
 		ret = omap_hsmmc_disable_supply(mmc);
 		if (ret)
 			return ret;
 	}
 
-	ret = omap_hsmmc_set_pbias(host, true, vdd);
-	if (ret)
-		goto err_set_voltage;
-
 	if (mmc_pdata(host)->after_set_reg)
 		mmc_pdata(host)->after_set_reg(dev, power_on, vdd);
 
-- 
1.7.9.5
