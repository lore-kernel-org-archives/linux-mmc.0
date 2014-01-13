From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v10 1/7] mmc: omap_hsmmc: use devm_regulator API
Date: Mon, 13 Jan 2014 21:06:09 +0530
Message-ID: <1389627375-9107-2-git-send-email-balajitk@ti.com>
References: <1389279062-32291-1-git-send-email-balajitk@ti.com>
 <1389627375-9107-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40945 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbaAMPgf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jan 2014 10:36:35 -0500
In-Reply-To: <1389627375-9107-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, broonie@kernel.org, tony@atomide.com
Cc: Balaji T K <balajitk@ti.com>

Use devm_regulator API, while at it use
devm_regulator_get_optional for optional vmmc_aux supply

Signed-off-by: Balaji T K <balajitk@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index dbd32ad..1eb4350 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -316,7 +316,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	struct regulator *reg;
 	int ocr_value = 0;
 
-	reg = regulator_get(host->dev, "vmmc");
+	reg = devm_regulator_get(host->dev, "vmmc");
 	if (IS_ERR(reg)) {
 		dev_err(host->dev, "vmmc regulator missing\n");
 		return PTR_ERR(reg);
@@ -336,7 +336,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 		}
 
 		/* Allow an aux regulator */
-		reg = regulator_get(host->dev, "vmmc_aux");
+		reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
 		host->vcc_aux = IS_ERR(reg) ? NULL : reg;
 
 		/* For eMMC do not power off when not in sleep state */
@@ -366,8 +366,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 
 static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
 {
-	regulator_put(host->vcc);
-	regulator_put(host->vcc_aux);
 	mmc_slot(host).set_power = NULL;
 }
 
-- 
1.7.5.4

