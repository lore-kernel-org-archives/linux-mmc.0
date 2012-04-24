From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 6/7] mmc: sdhi: do not install dummy callbacks
Date: Tue, 24 Apr 2012 18:41:46 +0200
Message-ID: <1335285707-22707-7-git-send-email-g.liakhovetski@gmx.de>
References: <1335285707-22707-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62648 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782Ab2DXQlu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Apr 2012 12:41:50 -0400
In-Reply-To: <1335285707-22707-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Currently the SDHI glue for the TMIO MMC driver installs dummy .get_cd() and
.set_pwr() callbacks even if the platform didn't supply them. This is not
necessary, since the TMIO MMC driver itself checks for NULL callbacks. This
is also dubious if the platform provides a regulator for SD-card power
switching. It is better to only install those callbacks, if they are really
provided by the platform.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index a746ae8..ae2e3da 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -64,18 +64,14 @@ static void sh_mobile_sdhi_set_pwr(struct platform_device *pdev, int state)
 {
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 
-	if (p && p->set_pwr)
-		p->set_pwr(pdev, state);
+	p->set_pwr(pdev, state);
 }
 
 static int sh_mobile_sdhi_get_cd(struct platform_device *pdev)
 {
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 
-	if (p && p->get_cd)
-		return p->get_cd(pdev);
-	else
-		return -ENOSYS;
+	return p->get_cd(pdev);
 }
 
 static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
@@ -151,8 +147,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eclkget;
 	}
 
-	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
-	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
+	if (p->set_pwr)
+		mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
+	if (p->get_cd)
+		mmc_data->get_cd = sh_mobile_sdhi_get_cd;
 	mmc_data->clk_enable = sh_mobile_sdhi_clk_enable;
 	mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
-- 
1.7.2.5

