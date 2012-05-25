From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 6/8 v3] mmc: sdhi: do not install dummy callbacks
Date: Fri, 25 May 2012 17:45:32 +0200
Message-ID: <1337960752-4944-18-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Currently the SDHI glue for the TMIO MMC driver installs dummy .get_cd() and
.set_pwr() callbacks even if the platform didn't supply them. This is not
necessary, since the TMIO MMC driver itself checks for NULL callbacks. This
is also dubious if the platform provides a regulator for SD-card power
switching. It is better to only install those callbacks, if they are really
provided by the platform.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index d8b167c..42f07fa 100644
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
@@ -153,8 +149,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
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

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
