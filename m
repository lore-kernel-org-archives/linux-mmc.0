From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v1 3/8] sdio: add power_restore support
Date: Tue,  7 Sep 2010 14:29:04 +0300
Message-ID: <1283858949-11073-4-git-send-email-ohad@wizery.com>
References: <1283858949-11073-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283858949-11073-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Gao Yunpeng <yunpeng.gao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add a power_restore handler to the SDIO bus ops,
in order to support waking up SDIO cards that
were powered off by runtime pm.

Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/core/sdio.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 8a34945..c118cc2 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -639,11 +639,29 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	return err;
 }
 
+static int mmc_sdio_power_restore(struct mmc_host *host)
+{
+	int ret;
+
+	BUG_ON(!host);
+	BUG_ON(!host->card);
+
+	mmc_claim_host(host);
+	ret = mmc_sdio_init_card(host, host->ocr, host->card,
+			(host->pm_flags & MMC_PM_KEEP_POWER));
+	if (!ret && host->sdio_irqs)
+		mmc_signal_sdio_irq(host);
+	mmc_release_host(host);
+
+	return ret;
+}
+
 static const struct mmc_bus_ops mmc_sdio_ops = {
 	.remove = mmc_sdio_remove,
 	.detect = mmc_sdio_detect,
 	.suspend = mmc_sdio_suspend,
 	.resume = mmc_sdio_resume,
+	.power_restore = mmc_sdio_power_restore,
 };
 
 
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
