From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v3 1/1] mmc: omap_hsmmc: devm_pinctrl_get returns ERR_PTR upon error
Date: Tue, 19 Apr 2016 23:04:13 +0200
Message-ID: <1461099853-15011-2-git-send-email-afenkart@gmail.com>
References: <1461099853-15011-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38799 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932937AbcDSVEa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 17:04:30 -0400
Received: by mail-wm0-f52.google.com with SMTP id u206so50390955wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2016 14:04:29 -0700 (PDT)
In-Reply-To: <1461099853-15011-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Andreas Fenkart <afenkart@gmail.com>

Only the dummy implementation of devm_pinctrl_get returns NULL.
The real implementation returns ERR_PTR. By enforcing pinselect
in Kconfig we can simplify the test to check only for ERR_PTR.
detected/triggered by static code checker.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/Kconfig      | 1 +
 drivers/mmc/host/omap_hsmmc.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1526b8a..b469755 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -366,6 +366,7 @@ config MMC_OMAP
 config MMC_OMAP_HS
 	tristate "TI OMAP High Speed Multimedia Card Interface support"
 	depends on HAS_DMA
+	select PINCTRL
 	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
 	help
 	  This selects the TI OMAP High Speed Multimedia card Interface.
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 62e421a..15ebc3b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1842,8 +1842,8 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
 	 */
 	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
 		struct pinctrl *p = devm_pinctrl_get(host->dev);
-		if (!p) {
-			ret = -ENODEV;
+		if (IS_ERR(p)) {
+			ret = PTR_ERR(p);
 			goto err_free_irq;
 		}
 		if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_DEFAULT))) {
-- 
2.8.0.rc3

