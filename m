From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 8/9] mmc: meson-gx: remove unneeded checks in remove
Date: Tue, 7 Feb 2017 22:35:40 +0100
Message-ID: <b3177559-272e-38e1-c3fc-be9fa9796416@gmail.com>
References: <0991d40b-e05b-2fcb-9ee4-7b529448de69@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34155 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755340AbdBGViV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 16:38:21 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so30712489wmi.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Feb 2017 13:36:22 -0800 (PST)
In-Reply-To: <0991d40b-e05b-2fcb-9ee4-7b529448de69@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

The remove callback is called only if probe finished successfully.
Therefore these checks are not needed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
v3:
- no changes
---
 drivers/mmc/host/meson-gx-mmc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 4feb8971..3cc6334a 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -808,15 +808,11 @@ static int meson_mmc_remove(struct platform_device *pdev)
 {
 	struct meson_host *host = dev_get_drvdata(&pdev->dev);
 
-	if (WARN_ON(!host))
-		return 0;
-
 	/* disable interrupts */
 	writel(0, host->regs + SD_EMMC_IRQ_EN);
 
-	if (host->bounce_buf)
-		dma_free_coherent(host->dev, host->bounce_buf_size,
-				  host->bounce_buf, host->bounce_dma_addr);
+	dma_free_coherent(host->dev, host->bounce_buf_size,
+			  host->bounce_buf, host->bounce_dma_addr);
 
 	clk_disable_unprepare(host->cfg_div_clk);
 	clk_disable_unprepare(host->core_clk);
-- 
2.11.0


