From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH] mmc: omap_hsmmc: devm_pinctrl_get returns ERR_PTR upon error
Date: Sun, 20 Mar 2016 23:55:04 +0100
Message-ID: <1458514504-21380-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33225 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498AbcCTWzN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Mar 2016 18:55:13 -0400
Received: by mail-wm0-f46.google.com with SMTP id l68so132310668wml.0
        for <linux-mmc@vger.kernel.org>; Sun, 20 Mar 2016 15:55:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Andreas Fenkart <afenkart@gmail.com>

devm_pinctrl_get returns NULL if CONFIG_PINCTRL is not set,
returns ERR_PTR on error otherwise

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 62e421a..898878d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1842,7 +1842,7 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
 	 */
 	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
 		struct pinctrl *p = devm_pinctrl_get(host->dev);
-		if (!p) {
+		if (!p || IS_ERR(p)) {
 			ret = -ENODEV;
 			goto err_free_irq;
 		}
-- 
2.7.0

