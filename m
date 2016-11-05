From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3] mmc: mxs: Initialize the spinlock prior to using it
Date: Sat,  5 Nov 2016 17:45:07 -0200
Message-ID: <1478375107-32513-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33794 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756848AbcKETpk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Nov 2016 15:45:40 -0400
Received: by mail-qt0-f196.google.com with SMTP id l20so4153234qta.1
        for <linux-mmc@vger.kernel.org>; Sat, 05 Nov 2016 12:45:40 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: kernel@pengutronix.de, marex@denx.de, stefan.wahren@i2se.com, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

An interrupt may occur right after devm_request_irq() is called and
prior to the spinlock initialization, leading to a kernel oops,
as the interrupt handler uses the spinlock.

In order to prevent this problem, move the spinlock initialization 
prior to requesting the interrupts.

Fixes: e4243f13d10e (mmc: mxs-mmc: add mmc host driver for i.MX23/28)
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
Changes since v2:
- Add a Fixes tag as suggested by Stefan
Changes since v1:
- Make it a standalone patch instead of patch series
- Cc stable as suggested by Stefan

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

