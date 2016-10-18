From: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Subject: [PATCH 2/2] sdhci: Prevent SD from doing high-speed timing when broken-highspeed property is set
Date: Tue, 18 Oct 2016 10:37:06 -0500
Message-ID: <1476805026-677-3-git-send-email-zach.brown@ni.com>
References: <1476805026-677-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476805026-677-1-git-send-email-zach.brown-acOepvfBmUk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zach.brown-acOepvfBmUk@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

When the broken-highspeed property is set the sdhci driver will not
go into highspeed mode even if the controller and card appear to
otherwise support highspeed mode.

This is useful in cases where the controller and card support highspeed,
but the board configuration or some other issue make highspeed
impossible. For example, we send the SDIO lines through a fpga so we
need the data to change on the falling edge of the clock or there will
be issues with hold time.

Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/mmc/host/sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1e25b01..4ec44fd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -22,6 +22,7 @@
 #include <linux/scatterlist.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <linux/leds.h>
 
@@ -3269,7 +3270,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
 		mmc->caps &= ~MMC_CAP_CMD23;
 
-	if (host->caps & SDHCI_CAN_DO_HISPD)
+	if ((host->caps & SDHCI_CAN_DO_HISPD) &&
+	    !(of_property_read_bool(mmc_dev(mmc)->of_node, "broken-highspeed")))
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
