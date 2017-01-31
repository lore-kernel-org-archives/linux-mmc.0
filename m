From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 8/9] mmc: meson-gx: remove unneeded checks in remove
Date: Tue, 31 Jan 2017 21:58:57 +0100
Message-ID: <db91ad1d-7291-0282-d9a6-14498c608cc2@gmail.com>
References: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36420 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdAaVIO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 16:08:14 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so940721wmd.3
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 13:08:14 -0800 (PST)
In-Reply-To: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org

The remove callback is called only if probe finished successfully.
Therefore these checks are not needed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 48ce4ba4..bc787444 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -811,15 +811,11 @@ static int meson_mmc_remove(struct platform_device *pdev)
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


