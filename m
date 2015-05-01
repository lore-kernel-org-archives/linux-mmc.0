From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH v3 2/3] mmc: host: arasan: Add the support for sdhci-arasan4.9a in sdhci-of-arasan.c.
Date: Fri,  1 May 2015 10:24:11 +0530
Message-ID: <1430456052-8888-3-git-send-email-stripathi@apm.com>
References: <1430456052-8888-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430456052-8888-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds the quirks and compatible string in sdhci-of-arasan.c
to support sdhci-arasan4.9a version of controller.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 981d66e..92a4222 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -20,6 +20,7 @@
  */

 #include <linux/module.h>
+#include <linux/of_device.h>
 #include "sdhci-pltfm.h"

 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
@@ -169,6 +170,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_disable_all;
 	}

+	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
+		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
+		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
+	}
+
 	sdhci_get_of_property(pdev);
 	pltfm_host = sdhci_priv(host);
 	pltfm_host->priv = sdhci_arasan;
@@ -206,6 +212,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)

 static const struct of_device_id sdhci_arasan_of_match[] = {
 	{ .compatible = "arasan,sdhci-8.9a" },
+	{ .compatible = "arasan,sdhci-4.9a" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
--
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
