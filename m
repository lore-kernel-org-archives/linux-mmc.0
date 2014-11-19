From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/3] mmc: mxs-mmc: No need to do NULL check on 'iores'
Date: Wed, 19 Nov 2014 11:16:57 -0200
Message-ID: <1416403019-6353-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0113.outbound.protection.outlook.com ([157.56.110.113]:5308
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753408AbaKSNck (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Nov 2014 08:32:40 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

devm_ioremap_resource() already checks if 'iores' is NULL or not, so we can
skip this manual check.

While at it, move platform_get_resource() closer to devm_ioremap_resource() for
better readability.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/mxs-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index c049ac7..0d30730 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -581,9 +581,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct regulator *reg_vmmc;
 	struct mxs_ssp *ssp;
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq_err = platform_get_irq(pdev, 0);
-	if (!iores || irq_err < 0)
+	if (irq_err < 0)
 		return -EINVAL;
 
 	mmc = mmc_alloc_host(sizeof(struct mxs_mmc_host), &pdev->dev);
@@ -593,6 +592,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	ssp = &host->ssp;
 	ssp->dev = &pdev->dev;
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ssp->base = devm_ioremap_resource(&pdev->dev, iores);
 	if (IS_ERR(ssp->base)) {
 		ret = PTR_ERR(ssp->base);
-- 
1.9.1

