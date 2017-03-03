From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 3/10] mmc: meson-gx: remove unused members irq, ocr_mask
 from struct meson_host
Date: Fri, 3 Mar 2017 20:53:38 +0100
Message-ID: <f089a3a0-5f01-7cea-e794-2fdd3707632d@gmail.com>
References: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34128 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbdCCUAn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Mar 2017 15:00:43 -0500
Received: by mail-wr0-f195.google.com with SMTP id u48so14550872wrc.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 12:00:42 -0800 (PST)
In-Reply-To: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Member ocr_mask is never used and member irq we can replace with a
local variable in meson_mmc_probe. So let's remove both members.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- added acked-by
v3:
- no changes
v4:
- no changes
---
 drivers/mmc/host/meson-gx-mmc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b99461ff..b9de3d47 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -127,8 +127,6 @@ struct meson_host {
 
 	spinlock_t lock;
 	void __iomem *regs;
-	int irq;
-	u32 ocr_mask;
 	struct clk *core_clk;
 	struct clk_mux mux;
 	struct clk *mux_clk;
@@ -712,7 +710,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct meson_host *host;
 	struct mmc_host *mmc;
-	int ret;
+	int ret, irq;
 
 	mmc = mmc_alloc_host(sizeof(struct meson_host), &pdev->dev);
 	if (!mmc)
@@ -744,8 +742,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		goto free_host;
 	}
 
-	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq == 0) {
+	irq = platform_get_irq(pdev, 0);
+	if (!irq) {
 		dev_err(&pdev->dev, "failed to get interrupt resource.\n");
 		ret = -EINVAL;
 		goto free_host;
@@ -773,9 +771,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
 	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
 
-	ret = devm_request_threaded_irq(&pdev->dev, host->irq,
-					meson_mmc_irq, meson_mmc_irq_thread,
-					IRQF_SHARED, DRIVER_NAME, host);
+	ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
+					meson_mmc_irq_thread, IRQF_SHARED,
+					DRIVER_NAME, host);
 	if (ret)
 		goto free_host;
 
-- 
2.11.1



