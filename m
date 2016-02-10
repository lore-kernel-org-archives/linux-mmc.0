From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [RFC PATCH] mmc: sdhci-of-at91: don't put device in suspend after probe
Date: Wed, 10 Feb 2016 10:58:03 +0100
Message-ID: <1455098283-14500-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

By putting the device in suspend at the end of the probe, it is
impossible to wake up on non software event such as card
insertion/removal.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Hi,

Since I had no feedback on this topic:
http://permalink.gmane.org/gmane.linux.kernel.mmc/35160

I would like to no more put the device in suspend at the end of the probe. If
my device is suspended at the end of the probe, I have no issue to resume on
a software event such as mounting my sdcard but hardware event such as card
insertion and removal do not trigger a resume.

It seems there are only two sdhci drivers using runtime pm so maybe nobody has
noticed this issue.

Regards

Ludovic

 drivers/mmc/host/sdhci-of-at91.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 9cb86fb..ae24dea 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -210,8 +210,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	if (ret)
 		goto pm_runtime_disable;
 
-	pm_runtime_put_autosuspend(&pdev->dev);
-
 	return 0;
 
 pm_runtime_disable:
-- 
2.7.0
