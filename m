From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH -next] mmc: omap_hsmmc: pass IRQF_ONESHOT to request_threaded_irq
Date: Thu, 17 May 2012 10:27:12 +0800
Message-ID: <1337221633-26656-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Ming Lei <ming.lei@canonical.com>
List-Id: linux-mmc@vger.kernel.org

The flag of IRQF_ONESHOT should be passed to request_threaded_irq,
otherwise the following failure message should be dumped because
hardware handler is defined as NULL:

[    3.383483] genirq: Threaded irq requested with handler=NULL and
!ONESHOT for irq 368
[    3.392730] omap_hsmmc: probe of omap_hsmmc.0 failed with error -22

The patch fixes one kernel hang bug which is caused by mmc card
probe failure and root device can't be brought up.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ebaf62a..9a7a60a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1981,7 +1981,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 		ret = request_threaded_irq(mmc_slot(host).card_detect_irq,
 					   NULL,
 					   omap_hsmmc_detect,
-					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   mmc_hostname(mmc), host);
 		if (ret) {
 			dev_dbg(mmc_dev(host->mmc),
-- 
1.7.9.5

