From: Bastian Hecht <hechtb@googlemail.com>
Subject: [PATCH] mmc: sh_mobile_sdhi: add a callback for board specific init code
Date: Fri,  6 Jan 2012 11:39:24 +0100
Message-ID: <1325846364-13400-1-git-send-email-hechtb@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34841 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030200Ab2AFKjc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jan 2012 05:39:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org, Bastian Hecht <hechtb@gmail.com>

Some boards need a preliminary setup stage to prepare the sdhi
controller.
---
 drivers/mmc/host/sh_mobile_sdhi.c  |   13 +++++++++++++
 include/linux/mmc/sh_mobile_sdhi.h |    4 ++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 0df69ab..1da31a4 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -109,6 +109,12 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	mmc_data = &priv->mmc_data;
 	p->pdata = mmc_data;
 
+	if (p->init) {
+		ret = p->init(pdev);
+		if (ret)
+			goto einit;
+	}
+
 	snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
 	priv->clk = clk_get(&pdev->dev, clk_name);
 	if (IS_ERR(priv->clk)) {
@@ -242,6 +248,9 @@ eprobe:
 #endif
 	clk_put(priv->clk);
 eclkget:
+	if (p->cleanup)
+		p->cleanup(pdev);
+einit:
 	kfree(priv);
 	return ret;
 }
@@ -269,6 +278,10 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 	clk_disable(priv->clk);
 #endif
 	clk_put(priv->clk);
+
+	if (p->cleanup)
+		p->cleanup(pdev);
+
 	kfree(priv);
 
 	return 0;
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index 86347f6..9cad001 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -22,6 +22,10 @@ struct sh_mobile_sdhi_info {
 	struct tmio_mmc_data *pdata;
 	void (*set_pwr)(struct platform_device *pdev, int state);
 	int (*get_cd)(struct platform_device *pdev);
+
+	/* callbacks for board specific setup code */
+	int (*init)(struct platform_device *pdev);
+	void (*cleanup)(struct platform_device *pdev);
 };
 
 #endif /* LINUX_MMC_SH_MOBILE_SDHI_H */
-- 
1.7.5.4

