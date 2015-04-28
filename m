From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 1/2] mmc: sdhci: Add quirk to disable write-protect detection
Date: Tue, 28 Apr 2015 11:40:19 +0200
Message-ID: <1430214020-16816-1-git-send-email-lars@metafoo.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

It is not uncommon to see systems where there is no physical write-protect
signal (e.g. when using eMMC or microSD cards). Some SDHCI controllers may
have bogus data in the SDHCI_WRITE_PROTECT of the SDHCI_PRESENT_STATE
register on such systems. Add a new quirk which disables reading of the
write-protect status when set.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 drivers/mmc/host/sdhci.c | 3 +++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c80287a..7448757 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1719,6 +1719,9 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 	struct sdhci_host *host = mmc_priv(mmc);
 	int ret;
 
+	if (host->quirks2 & SDHCI_QUIRK2_DISABLE_WRITE_PROTECT)
+		return 0;
+
 	sdhci_runtime_pm_get(host);
 	ret = sdhci_do_get_ro(host);
 	sdhci_runtime_pm_put(host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e639b7f..62615e1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -409,6 +409,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_SUPPORT_SINGLE			(1<<13)
 /* Controller broken with using ACMD23 */
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
+/* Write protect signal is not wired, data in SDHCI_PRESENT_STATE is bogus */
+#define SDHCI_QUIRK2_DISABLE_WRITE_PROTECT		(1<<15)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
