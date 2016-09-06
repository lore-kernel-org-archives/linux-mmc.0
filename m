From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: davinci: remove incorrect NO_IRQ use
Date: Tue,  6 Sep 2016 14:56:09 +0200
Message-ID: <20160906125633.1563621-1-arnd@arndb.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:57612 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933143AbcIFM5B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2016 08:57:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, David Lechner <david@lechnology.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

platform_get_irq() returns an error value on failure, not NO_IRQ,
so the error handling here could never work.

This changes the code to propagate the error value instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/davinci_mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index c521559412fc..67ef4810b3de 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1216,9 +1216,11 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (!r || irq == NO_IRQ)
+	if (!r)
 		return -ENODEV;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	mem_size = resource_size(r);
 	mem = devm_request_mem_region(&pdev->dev, r->start, mem_size,
-- 
2.9.0

