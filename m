From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 3/3] mmc: omap_hsmmc: If probe fails, give out error messages
Date: Wed, 18 Apr 2012 15:19:13 +0530
Message-ID: <1334742553-11060-3-git-send-email-svenkatr@ti.com>
References: <y>
 <1334742553-11060-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39802 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424Ab2DRJuI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Apr 2012 05:50:08 -0400
In-Reply-To: <1334742553-11060-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Venkatraman S <svenkatr@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Giving out debug messages even in case of probe failure seems
not very useful. Make them error messages instead.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: <linux-mmc@vger.kernel.org>
---
 drivers/mmc/host/omap_hsmmc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d046ba2..6d3ceab 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1956,13 +1956,13 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	ret = request_irq(host->irq, omap_hsmmc_irq, 0,
 			mmc_hostname(mmc), host);
 	if (ret) {
-		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
+		dev_err(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
 		goto err_irq;
 	}
 
 	if (pdata->init != NULL) {
 		if (pdata->init(&pdev->dev) != 0) {
-			dev_dbg(mmc_dev(host->mmc),
+			dev_err(mmc_dev(host->mmc),
 				"Unable to configure MMC IRQs\n");
 			goto err_irq_cd_init;
 		}
@@ -1985,7 +1985,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 					   mmc_hostname(mmc), host);
 		if (ret) {
-			dev_dbg(mmc_dev(host->mmc),
+			dev_err(mmc_dev(host->mmc),
 				"Unable to grab MMC CD IRQ\n");
 			goto err_irq_cd;
 		}
-- 
1.7.10.rc2

