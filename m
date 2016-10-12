From: Zach Brown <zach.brown@ni.com>
Subject: [RFC v2 2/2] sdhci: Prevent SD from doing high-speed timing when broken-highspeed property is set
Date: Wed, 12 Oct 2016 13:40:56 -0500
Message-ID: <1476297656-7019-3-git-send-email-zach.brown@ni.com>
References: <1476297656-7019-1-git-send-email-zach.brown@ni.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:58624 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934023AbcJLSlF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Oct 2016 14:41:05 -0400
In-Reply-To: <1476297656-7019-1-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com

When the broken-highspeed property is set the sdhci driver will not
go into highspeed mode even if the controller and card appear to
otherwise support highspeed mode.

This is useful in cases where the controller and card support highspeed,
but the board configuration or some other issue make highspeed
impossible. For example, we send the SDIO lines through a fpga so we
need the data to change on the falling edge of the clock or there will
be issues with hold time.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 drivers/mmc/host/sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4805566..17e6c50 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -22,6 +22,7 @@
 #include <linux/scatterlist.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <linux/leds.h>
 
@@ -3274,7 +3275,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
 		mmc->caps &= ~MMC_CAP_CMD23;
 
-	if (host->caps & SDHCI_CAN_DO_HISPD)
+	if ((host->caps & SDHCI_CAN_DO_HISPD) &&
+	    !(of_property_read_bool(mmc_dev(mmc)->of_node, "broken-highspeed")))
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
-- 
2.7.4

