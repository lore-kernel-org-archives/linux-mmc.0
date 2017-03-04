From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 3/10] mmc: meson-gx: remove unused members irq, ocr_mask
 from struct meson_host
Date: Sat, 4 Mar 2017 13:21:54 +0100
Message-ID: <713d2aba-76b6-b47d-60d1-1e90d629c292@gmail.com>
References: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36391 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbdCDMi5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Mar 2017 07:38:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id v190so6831220wme.3
        for <linux-mmc@vger.kernel.org>; Sat, 04 Mar 2017 04:38:16 -0800 (PST)
In-Reply-To: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
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
v5:
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
2.12.0


