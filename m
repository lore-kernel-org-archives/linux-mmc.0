From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] mmc: omap_hsmmc: precedence bug in
 omap_hsmmc_context_restore()
Date: Thu, 22 Aug 2013 15:56:13 +0300
Message-ID: <20130822125613.GB2543@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

'!' has higher precedence than '&' so this doesn't work as intended
although since RESETDONE is 1 it would work if none of the other bits
are set.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Untested.

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1865321..7346b15 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -612,7 +612,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	if (host->context_loss == context_loss)
 		return 1;
 
-	if (!OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE)
+	if (!(OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE))
 		return 1;
 
 	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
