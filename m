From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 09/11] mmc: host: omap_hsmmc: Allow io voltage switch even for fixed vdd
Date: Thu, 30 Jul 2015 13:16:32 +0530
Message-ID: <1438242394-25599-10-git-send-email-kishon@ti.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438242394-25599-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com, mugunthanvnm@ti.com
List-Id: linux-mmc@vger.kernel.org

Now that vmmc regulator is made optional, do not bail out if vmmc
regulator is not found.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 96dd406..26010a3 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -434,13 +434,6 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int iov)
 	struct mmc_host *mmc = host->mmc;
 	int ret = 0;
 
-	/*
-	 * If we don't see a Vcc regulator, assume it's a fixed
-	 * voltage always-on regulator.
-	 */
-	if (!mmc->supply.vmmc)
-		return 0;
-
 	if (mmc_pdata(host)->before_set_reg)
 		mmc_pdata(host)->before_set_reg(dev, power_on, iov);
 
-- 
1.7.9.5
