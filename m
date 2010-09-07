From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v1 6/8] sdio: enable Runtime PM for SDIO cards
Date: Tue,  7 Sep 2010 14:29:07 +0300
Message-ID: <1283858949-11073-7-git-send-email-ohad@wizery.com>
References: <1283858949-11073-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283858949-11073-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Gao Yunpeng <yunpeng.gao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Enable runtime PM for new SDIO cards.

As soon as the card will be added to the device tree, runtime PM core
will release its power, since it doesn't have any users yet.

Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/core/sdio.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index c118cc2..a5a76a8 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -709,6 +710,15 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 	card = host->card;
 
 	/*
+	 * Enable Runtime PM for this card
+	 */
+	err = pm_runtime_set_active(&card->dev);
+	if (err)
+		goto remove;
+
+	pm_runtime_enable(&card->dev);
+
+	/*
 	 * The number of functions on the card is encoded inside
 	 * the ocr.
 	 */
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
