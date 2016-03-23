From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2] mmc: omap_hsmmc: devm_pinctrl_get returns ERR_PTR upon error
Date: Wed, 23 Mar 2016 20:28:36 +0100
Message-ID: <1458761316-11706-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37040 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbcCWT2m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Mar 2016 15:28:42 -0400
Received: by mail-wm0-f43.google.com with SMTP id p65so37438121wmp.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Mar 2016 12:28:42 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Andreas Fenkart <afenkart@gmail.com>

keystone_defconfig can be compiled without PINCTRL support

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 62e421a..ecf3db8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1841,9 +1841,14 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
 	 * and need to remux SDIO DAT1 to GPIO for wake-up from idle.
 	 */
 	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
+#ifndef CONFIG_PINCTRL
+		dev_info(host->dev, "missing pinctrl support\n");
+		ret = -ENODEV;
+		goto err_free_irq;
+#else
 		struct pinctrl *p = devm_pinctrl_get(host->dev);
-		if (!p) {
-			ret = -ENODEV;
+		if (IS_ERR(p)) {
+			ret = PTR_ERR(p);
 			goto err_free_irq;
 		}
 		if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_DEFAULT))) {
@@ -1860,6 +1865,7 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
 			goto err_free_irq;
 		}
 		devm_pinctrl_put(p);
+#endif
 	}
 
 	OMAP_HSMMC_WRITE(host->base, HCTL,
-- 
2.7.0

