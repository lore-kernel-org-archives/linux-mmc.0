From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/3] mmc: mxs-mmc: Propagate the real error
Date: Wed, 19 Nov 2014 11:16:58 -0200
Message-ID: <1416403019-6353-2-git-send-email-fabio.estevam@freescale.com>
References: <1416403019-6353-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0109.outbound.protection.outlook.com ([65.55.169.109]:5427
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754066AbaKSNcv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Nov 2014 08:32:51 -0500
In-Reply-To: <1416403019-6353-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

If platform_get_irq() fails, it is better to propagate the real error value
instead of a 'fake' one.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/mxs-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 0d30730..f2c49e0 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -583,7 +583,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 
 	irq_err = platform_get_irq(pdev, 0);
 	if (irq_err < 0)
-		return -EINVAL;
+		return irq_err;
 
 	mmc = mmc_alloc_host(sizeof(struct mxs_mmc_host), &pdev->dev);
 	if (!mmc)
-- 
1.9.1

