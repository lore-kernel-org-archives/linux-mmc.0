From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] mmc: sdhci-of-at91: fix pm runtime unbalanced issue in error path
Date: Tue, 26 Jan 2016 18:42:34 +0800
Message-ID: <1453804954-3490-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:38195 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752280AbcAZKqm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 05:46:42 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

The device power usage counter is increased by pm_runtime_get_noresume
but isn't decreased in err_add_host error path.

Fix this issue by calling pm_runtime_put_noidle() in the error path to
restore the device's power usage counter.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Fixes: f5f17813ae9b ("mmc: sdhci-of-at91: add PM support)
---
 drivers/mmc/host/sdhci-of-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 7db7163..3bf6f31 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -210,7 +210,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 
 pm_runtime_disable:
 	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 clocks_disable_unprepare:
 	clk_disable_unprepare(priv->gck);
 	clk_disable_unprepare(priv->mainck);
-- 
2.7.0

