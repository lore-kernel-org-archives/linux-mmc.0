From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] mmc: host: omap_hsmmc: Fix MMC for omap3 legacy booting
Date: Wed,  7 Oct 2015 06:22:25 -0700
Message-ID: <1444224145-24333-2-git-send-email-tony@atomide.com>
References: <1444224145-24333-1-git-send-email-tony@atomide.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:56472 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978AbbJGNWo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Oct 2015 09:22:44 -0400
In-Reply-To: <1444224145-24333-1-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Nishanth Menon <nm@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

Starting with commit 7d607f917008 ("mmc: host: omap_hsmmc: use
devm_regulator_get_optional() for vmmc") MMC on omap3 stopped working
for legacy booting.

This is because legacy booting sets up some of the resource in the
platform init code, and for optional regulators always seem to
return -EPROBE_DEFER for the legacy booting.

Let's fix the issue by checking for device tree based booting for
now. Then when omap3 boots in device tree only mode, this patch
can be just reverted.

Fixes: 7d607f917008 ("mmc: host: omap_hsmmc: use
devm_regulator_get_optional() for vmmc")
Cc: Felipe Balbi <balbi@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ae3a2b9..7fb0753 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -478,7 +478,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	mmc->supply.vmmc = devm_regulator_get_optional(host->dev, "vmmc");
 	if (IS_ERR(mmc->supply.vmmc)) {
 		ret = PTR_ERR(mmc->supply.vmmc);
-		if (ret != -ENODEV)
+		if ((ret != -ENODEV) && host->dev->of_node)
 			return ret;
 		dev_dbg(host->dev, "unable to get vmmc regulator %ld\n",
 			PTR_ERR(mmc->supply.vmmc));
@@ -493,7 +493,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	mmc->supply.vqmmc = devm_regulator_get_optional(host->dev, "vmmc_aux");
 	if (IS_ERR(mmc->supply.vqmmc)) {
 		ret = PTR_ERR(mmc->supply.vqmmc);
-		if (ret != -ENODEV)
+		if ((ret != -ENODEV) && host->dev->of_node)
 			return ret;
 		dev_dbg(host->dev, "unable to get vmmc_aux regulator %ld\n",
 			PTR_ERR(mmc->supply.vqmmc));
@@ -503,7 +503,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	host->pbias = devm_regulator_get_optional(host->dev, "pbias");
 	if (IS_ERR(host->pbias)) {
 		ret = PTR_ERR(host->pbias);
-		if (ret != -ENODEV)
+		if ((ret != -ENODEV) && host->dev->of_node)
 			return ret;
 		dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
 			PTR_ERR(host->pbias));
-- 
2.1.4

