From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] mmc: pxamci: fix read-only gpio detection polarity
Date: Thu,  5 Nov 2015 20:46:53 +0100
Message-ID: <1446752813-26718-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The commit converting pxamci to slot-gpio API inverted the logic of the
read-only gpio. Fix it by inverting the logic again.

Fixes: fd546ee6a7dc ("mmc: pxamci: fix card detect with slot-gpio API")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/pxamci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 8cadd74e8407..ce08896b9d69 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -805,7 +805,7 @@ static int pxamci_probe(struct platform_device *pdev)
 		goto out;
 	} else {
 		mmc->caps |= host->pdata->gpio_card_ro_invert ?
-			MMC_CAP2_RO_ACTIVE_HIGH : 0;
+			0 : MMC_CAP2_RO_ACTIVE_HIGH;
 	}
 
 	if (gpio_is_valid(gpio_cd))
-- 
2.1.4
