From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] mmc: host: use platform_{get,set}_drvdata()
Date: Sat, 01 Jun 2013 14:16:22 +0900
Message-ID: <000001ce5e87$284f88e0$78ee9aa0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35309 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3FAFQZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Jun 2013 01:16:25 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNP001KT7ZB5FC0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 01 Jun 2013 14:16:23 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, =?iso-8859-2?Q?'_Micha=B3_Miros=B3aw_'?= <mirq-linux@rere.qmqm.pl>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>

Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
so we can directly pass a struct platform_device.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/cb710-mmc.c      |    2 +-
 drivers/mmc/host/sh_mobile_sdhi.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index 777ca20..9d6e2b8 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -703,7 +703,7 @@ static int cb710_mmc_init(struct platform_device *pdev)
 	if (!mmc)
 		return -ENOMEM;
 
-	dev_set_drvdata(&pdev->dev, mmc);
+	platform_set_drvdata(pdev, mmc);
 
 	/* harmless (maybe) magic */
 	pci_read_config_dword(chip->pdev, 0x48, &val);
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index cc4c872..6a5d90e 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -51,7 +51,7 @@ struct sh_mobile_sdhi {
 
 static int sh_mobile_sdhi_clk_enable(struct platform_device *pdev, unsigned int *f)
 {
-	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
+	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
 	int ret = clk_enable(priv->clk);
@@ -64,7 +64,7 @@ static int sh_mobile_sdhi_clk_enable(struct platform_device *pdev, unsigned int
 
 static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
 {
-	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
+	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
 	clk_disable(priv->clk);
@@ -119,7 +119,7 @@ static int sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 
 static void sh_mobile_sdhi_cd_wakeup(const struct platform_device *pdev)
 {
-	mmc_detect_change(dev_get_drvdata(&pdev->dev), msecs_to_jiffies(100));
+	mmc_detect_change(platform_get_drvdata(pdev), msecs_to_jiffies(100));
 }
 
 static const struct sh_mobile_sdhi_ops sdhi_ops = {
-- 
1.7.10.4


