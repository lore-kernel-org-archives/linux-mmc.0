From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 8/9] mmc: meson-gx: remove unneeded checks in remove
Date: Wed, 1 Feb 2017 07:49:27 +0100
Message-ID: <abf8a44d-7381-ea1f-44c6-27ccec3f647d@gmail.com>
References: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36704 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdBAGtz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 01:49:55 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so3592405wmd.3
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 22:49:55 -0800 (PST)
In-Reply-To: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

The remove callback is called only if probe finished successfully.
Therefore these checks are not needed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- no changes
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



