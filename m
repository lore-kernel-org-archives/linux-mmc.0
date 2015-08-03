From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 01/16] mmc: host: omap_hsmmc: use devm_regulator_get_optional() for vmmc
Date: Mon, 3 Aug 2015 17:56:26 +0530
Message-ID: <1438604801-11823-2-git-send-email-kishon@ti.com>
References: <1438604801-11823-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33907 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbbHCM0x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Aug 2015 08:26:53 -0400
In-Reply-To: <1438604801-11823-1-git-send-email-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com

Since vmmc can be optional for some platforms, use
devm_regulator_get_optional() for vmmc. Now return error only
if the return value of devm_regulator_get_optional() is not the
same as -ENODEV, since with -EPROBE_DEFER, the regulator can be
obtained later and all other errors are fatal.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4d12032..b4b1bde 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -343,12 +343,16 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
 	struct regulator *reg;
 	int ocr_value = 0;
+	int ret;
 
-	reg = devm_regulator_get(host->dev, "vmmc");
+	reg = devm_regulator_get_optional(host->dev, "vmmc");
 	if (IS_ERR(reg)) {
-		dev_err(host->dev, "unable to get vmmc regulator %ld\n",
+		ret = PTR_ERR(reg);
+		if (ret != -ENODEV)
+			return ret;
+		host->vcc = NULL;
+		dev_dbg(host->dev, "unable to get vmmc regulator %ld\n",
 			PTR_ERR(reg));
-		return PTR_ERR(reg);
 	} else {
 		host->vcc = reg;
 		ocr_value = mmc_regulator_get_ocrmask(reg);
-- 
1.7.9.5

