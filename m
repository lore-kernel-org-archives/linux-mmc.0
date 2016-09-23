From: Zach Brown <zach.brown@ni.com>
Subject: [RFC 2/2] sdhci: Prevent SD from doing highspeed timing when sd-broken-highspeed property is set
Date: Fri, 23 Sep 2016 15:01:09 -0500
Message-ID: <1474660869-15532-3-git-send-email-zach.brown@ni.com>
References: <1474660869-15532-1-git-send-email-zach.brown@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474660869-15532-1-git-send-email-zach.brown@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com
List-Id: linux-mmc@vger.kernel.org

From: Chen Yee Chew <chen.yee.chew@ni.com>

When the sd-broken-highspeed property is set the sdhci driver will not
go into highspeed mode even if the controller and card appear to
otherwise support highspeed mode.

This is useful in cases where the controller and card support highspeed,
but the board configuration or some other issue make highspeed
impossible.

Signed-off-by: Chen Yee Chew <chen.yee.chew@ni.com>
Reviewed-by: Keng Soon Cheah <keng.soon.cheah@ni.com>
Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 3 +++
 drivers/mmc/host/sdhci.c       | 3 ++-
 drivers/mmc/host/sdhci.h       | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index ad49bfa..7482706 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -87,6 +87,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	if (of_get_property(np, "broken-cd", NULL))
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
+	if (of_get_property(np, "sd-broken-highspeed", NULL))
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HISPD;
+
 	if (of_get_property(np, "no-1-8-v", NULL))
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4805566..4b0969c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3274,7 +3274,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
 		mmc->caps &= ~MMC_CAP_CMD23;
 
-	if (host->caps & SDHCI_CAN_DO_HISPD)
+	if ((host->caps & SDHCI_CAN_DO_HISPD) &&
+	    !(host->quirks2 & SDHCI_QUIRK2_BROKEN_HISPD))
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c722cd2..3d0fdda 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -424,6 +424,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Highspeed is broken even if it appears otherwise */
+#define SDHCI_QUIRK2_BROKEN_HISPD		(1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.7.4
