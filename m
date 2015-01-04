From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH next 2/2] mmc: sdhci-pxav3: fix pm unbalanced issue in -> remove()
Date: Sun, 4 Jan 2015 23:15:48 +0800
Message-ID: <1420384548-7816-3-git-send-email-jszhang@marvell.com>
References: <1420384548-7816-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:5328 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752647AbbADPTB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Jan 2015 10:19:01 -0500
In-Reply-To: <1420384548-7816-1-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org
Cc: peter.griffin@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

This patch calls pm_runtime_put_noidle() to restore the device's usage
counter in the ->remove() implementation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 1255dd2..4de39fb 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -412,8 +412,10 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	struct sdhci_pxa *pxa = pltfm_host->priv;
 
 	pm_runtime_get_sync(&pdev->dev);
-	sdhci_remove_host(host, 1);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	sdhci_remove_host(host, 1);
 
 	clk_disable_unprepare(pxa->clk_io);
 	if (!IS_ERR(pxa->clk_core))
-- 
2.1.4

