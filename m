From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 5/9] mmc: meson-gx: improve interrupt handling
Date: Wed, 1 Feb 2017 07:48:58 +0100
Message-ID: <23e1aac3-5761-944a-f3ca-cb88a9e44ad8@gmail.com>
References: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34344 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdBAGtv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 01:49:51 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so3600210wmi.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 22:49:51 -0800 (PST)
In-Reply-To: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

Disabling and immediately re-enabling interrupts in meson_mmc_request
doesn't provide a benefit. Instead enable interrupts in probe already.
And disable interrupts in remove, this was missing so far.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- no changes
---
 drivers/mmc/host/meson-gx-mmc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 4ce4c640..0fba23d2 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -546,11 +546,6 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
 
-	/* clear, ack, enable all interrupts */
-	writel(0, host->regs + SD_EMMC_IRQ_EN);
-	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
-	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
-
 	host->mrq = mrq;
 
 	if (mrq->sbc)
@@ -777,8 +772,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	writel(0, host->regs + SD_EMMC_START);
 
 	/* clear, ack, enable all interrupts */
-	writel(0, host->regs + SD_EMMC_IRQ_EN);
 	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
+	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
 
 	ret = devm_request_threaded_irq(&pdev->dev, host->irq,
 					meson_mmc_irq, meson_mmc_irq_thread,
@@ -816,6 +811,9 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	if (WARN_ON(!host))
 		return 0;
 
+	/* disable interrupts */
+	writel(0, host->regs + SD_EMMC_IRQ_EN);
+
 	if (host->bounce_buf)
 		dma_free_coherent(host->dev, host->bounce_buf_size,
 				  host->bounce_buf, host->bounce_dma_addr);
-- 
2.11.0



