From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: mxs-mmc: Register the irq with the device name
Date: Tue, 18 Nov 2014 00:37:12 -0200
Message-ID: <1416278232-31263-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:63225 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaKRChd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Nov 2014 21:37:33 -0500
Received: by mail-qc0-f173.google.com with SMTP id i17so3123286qcy.18
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2014 18:37:32 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Instead of registering the irq name with the driver's name, it's better to pass
the device name so that we have a more explicit indication as to what mmc
instance the irq is related:
    
$ cat /proc/interrupts 
           CPU0       
...
 26:          6         -  96  80010000.ssp

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/mxs-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index cd74e51..339059a 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -660,7 +660,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mmc);
 
 	ret = devm_request_irq(&pdev->dev, irq_err, mxs_mmc_irq_handler, 0,
-			       DRIVER_NAME, host);
+			       dev_name(&pdev->dev), host);
 	if (ret)
 		goto out_free_dma;
 
-- 
1.9.1

