From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] mmc: mxs: Initialize the spinlock prior to using it
Date: Thu, 27 Oct 2016 16:57:51 -0200
Message-ID: <1477594672-31611-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34082 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938571AbcJ0S6C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 14:58:02 -0400
Received: by mail-vk0-f67.google.com with SMTP id c126so589580vkd.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2016 11:58:01 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, stefan.wahren@i2se.com, marex@denx.de, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

An interrupt may occur right after devm_request_irq() is called and
prior to the spinlock initialization, leading to a kernel oops,
as the interrupt handler uses the spinlock.

In order to prevent this problem, move the spinlock initialization 
prior to requesting the interrupts.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/mmc/host/mxs-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index d839147..44ecebd 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -661,13 +661,13 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mmc);
 
+	spin_lock_init(&host->lock);
+
 	ret = devm_request_irq(&pdev->dev, irq_err, mxs_mmc_irq_handler, 0,
 			       dev_name(&pdev->dev), host);
 	if (ret)
 		goto out_free_dma;
 
-	spin_lock_init(&host->lock);
-
 	ret = mmc_add_host(mmc);
 	if (ret)
 		goto out_free_dma;
-- 
2.7.4

