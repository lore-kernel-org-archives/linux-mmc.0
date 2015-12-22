From: Rameshwar Prasad Sahu <rsahu-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH] mmc: host: arasan: sdhci-of-arasan: Remove no-hispd and no-cmd23 quirks for sdhci-arasan4.9a
Date: Tue, 22 Dec 2015 18:50:51 +0530
Message-ID: <1450790451-20735-1-git-send-email-rsahu@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, kgondkar-qTEPVZfXA3Y@public.gmane.org, Rameshwar Prasad Sahu <rsahu-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The Arason SD host controller supports set block count command (cmd23)
and high speed mode. This patch re-enable both of these features that
was disabled. For device that doesn't support high speed, it should
configure its capability register accordingly instead disables it
explicitly.

Signed-off-by: Rameshwar Prasad Sahu <rsahu-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/mmc/host/sdhci-of-arasan.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 75379cb..5d9fdb3 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -172,11 +172,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_disable_all;
 	}

-	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
-		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
-		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
-	}
-
 	sdhci_get_of_property(pdev);
 	pltfm_host = sdhci_priv(host);
 	pltfm_host->priv = sdhci_arasan;
--
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
