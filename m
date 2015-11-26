From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: sdhci-of-at91: controller is suspended too early
Date: Thu, 26 Nov 2015 17:41:31 +0100
Message-ID: <1448556091-502-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

When calling sdhci_add_host(), the controller is already suspended. It
causes to read 0 in registers.
Increment the device's usage counter before calling sdhci_add_host(),
decrement it after and put it in suspend if it is possible.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: "mmc: sdhci-of-at91: add PM support"
---
 drivers/mmc/host/sdhci-of-at91.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 81ab9db..7e7d8f0 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -200,6 +200,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
@@ -209,6 +210,8 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	if (ret)
 		goto pm_runtime_disable;
 
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 pm_runtime_disable:
-- 
2.5.0
