From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 09/18] mmc: meson-gx: change interrupt name
Date: Tue, 14 Feb 2017 21:06:39 +0100
Message-ID: <cbe84305-803a-5431-9246-0b30d6f135b0@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33230 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754589AbdBNUHm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 15:07:42 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so5209718wmv.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 12:07:42 -0800 (PST)
In-Reply-To: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

So far the driver name is used for the interrupt. Therefore in
/proc/interrupts we can't tell which interrupt belongs to which
SD_EMMC port.
So let's use the device name instead (what is the OF node name).

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index a67c811e..1a76c925 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -757,9 +757,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
 	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
 
-	ret = devm_request_threaded_irq(&pdev->dev, host->irq,
-					meson_mmc_irq, meson_mmc_irq_thread,
-					IRQF_SHARED, DRIVER_NAME, host);
+	ret = devm_request_threaded_irq(&pdev->dev, host->irq, meson_mmc_irq,
+					meson_mmc_irq_thread, IRQF_SHARED,
+					dev_name(&pdev->dev), host);
 	if (ret)
 		goto free_host;
 
-- 
2.11.1


