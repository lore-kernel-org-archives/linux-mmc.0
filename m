From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH RESEND 4/9] mmc: mxs-mmc: adopt pinctrl support
Date: Mon,  7 May 2012 09:16:09 +0800
Message-ID: <1336353374-28939-5-git-send-email-shawn.guo@linaro.org>
References: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41174 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089Ab2EGBQk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 May 2012 21:16:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6027251pbb.19
        for <linux-mmc@vger.kernel.org>; Sun, 06 May 2012 18:16:40 -0700 (PDT)
In-Reply-To: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org

Cc: linux-mmc@vger.kernel.org
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/mxs-mmc.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index e3f5af9..bb03ddd 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -39,6 +39,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
 #include <linux/fsl/mxs-dma.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <mach/mxs.h>
 #include <mach/common.h>
@@ -682,6 +683,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct resource *iores, *dmares, *r;
 	struct mxs_mmc_platform_data *pdata;
+	struct pinctrl *pinctrl;
 	int ret = 0, irq_err, irq_dma;
 	dma_cap_mask_t mask;
 
@@ -719,6 +721,12 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	host->irq = irq_err;
 	host->sdio_irq_en = 0;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		goto out_iounmap;
+	}
+
 	host->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
-- 
1.7.5.4

