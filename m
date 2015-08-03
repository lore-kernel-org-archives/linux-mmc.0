From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 10/16] mmc: host: omap_hsmmc: avoid pbias regulator enable on power off
Date: Mon, 3 Aug 2015 17:56:35 +0530
Message-ID: <1438604801-11823-11-git-send-email-kishon@ti.com>
References: <1438604801-11823-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438604801-11823-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Fix omap_hsmmc_set_power so that pbias regulator is not enabled
during power off.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 194c59f..4af902d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -386,16 +386,16 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
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
