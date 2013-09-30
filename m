From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] mmc: vub300: Move away from using deprecated APIs
Date: Mon, 30 Sep 2013 10:18:24 +0200
Message-ID: <1380529104-25818-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Olech <tony.olech-ze5PQcJzaeOs0fm86SgGizGjJy/sRE9J@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Suspend and resume of cards are handled by the protocol layer and
consequently the mmc_suspend|resume_host APIs are marked as deprecated.

This means we can simplify the suspend|resume callbacks by removing the
use of the deprecated APIs.

Cc: Tony Olech <tony.olech-ze5PQcJzaeOs0fm86SgGizGjJy/sRE9J@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
---
 drivers/mmc/host/vub300.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index e9028ad..4262296 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2392,26 +2392,12 @@ static void vub300_disconnect(struct usb_interface *interface)
 #ifdef CONFIG_PM
 static int vub300_suspend(struct usb_interface *intf, pm_message_t message)
 {
-	struct vub300_mmc_host *vub300 = usb_get_intfdata(intf);
-	if (!vub300 || !vub300->mmc) {
-		return 0;
-	} else {
-		struct mmc_host *mmc = vub300->mmc;
-		mmc_suspend_host(mmc);
-		return 0;
-	}
+	return 0;
 }
 
 static int vub300_resume(struct usb_interface *intf)
 {
-	struct vub300_mmc_host *vub300 = usb_get_intfdata(intf);
-	if (!vub300 || !vub300->mmc) {
-		return 0;
-	} else {
-		struct mmc_host *mmc = vub300->mmc;
-		mmc_resume_host(mmc);
-		return 0;
-	}
+	return 0;
 }
 #else
 #define vub300_suspend NULL
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
