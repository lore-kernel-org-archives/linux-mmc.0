From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH] mmc: sdhci-s3c: pass IRQF ONESHOT to request threaded irq
Date: Sun, 3 Jun 2012 15:29:55 +0200
Message-ID: <201206031529.56170.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Fix a boot regression in existing kernels causing:

genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq XXX

caused by 1c6c6952 (genirq: Reject bogus threaded irq requests).

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Witnessed on a s3c2416 with 3.5-rc1

 drivers/mmc/host/sdhci-s3c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index f473d8b..460ddb5 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -408,7 +408,7 @@ static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
 		if (sc->ext_cd_irq &&
 		    request_threaded_irq(sc->ext_cd_irq, NULL,
 					 sdhci_s3c_gpio_card_detect_thread,
-					 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+					 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					 dev_name(dev), sc) == 0) {
 			int status = gpio_get_value(sc->ext_cd_gpio);
 			if (pdata->ext_cd_gpio_invert)
-- 
1.7.2.3
