From: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH] mmc: vub300: Use common code in
 __download_offload_pseudocode()
Date: Fri, 27 Oct 2017 21:31:47 +0200
Message-ID: <7b418db1-ec35-4c85-5d06-45edde56822c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-GB
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Olech <tony.olech-ze5PQcJzaeOs0fm86SgGizGjJy/sRE9J@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Date: Fri, 27 Oct 2017 21:21:40 +0200

Add a jump target so that a specific string copy operation is stored
only once at the end of this function implementation.
Replace two calls of the function "strncpy" by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/mmc/host/vub300.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index c1a169843f99..c898a45a84c5 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1244,12 +1244,8 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 						USB_RECIP_DEVICE, 0x0000, 0x0000,
 						xfer_buffer, xfer_length, HZ);
 			kfree(xfer_buffer);
-			if (retval < 0) {
-				strncpy(vub300->vub_name,
-					"SDIO pseudocode download failed",
-					sizeof(vub300->vub_name));
-				return;
-			}
+			if (retval < 0)
+				goto copy_error_message;
 		} else {
 			dev_err(&vub300->udev->dev,
 				"not enough memory for xfer buffer to send"
@@ -1291,12 +1287,8 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 						USB_RECIP_DEVICE, 0x0000, 0x0000,
 						xfer_buffer, xfer_length, HZ);
 			kfree(xfer_buffer);
-			if (retval < 0) {
-				strncpy(vub300->vub_name,
-					"SDIO pseudocode download failed",
-					sizeof(vub300->vub_name));
-				return;
-			}
+			if (retval < 0)
+				goto copy_error_message;
 		} else {
 			dev_err(&vub300->udev->dev,
 				"not enough memory for xfer buffer to send"
@@ -1349,6 +1341,12 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 			sizeof(vub300->vub_name));
 		return;
 	}
+
+	return;
+
+copy_error_message:
+	strncpy(vub300->vub_name, "SDIO pseudocode download failed",
+		sizeof(vub300->vub_name));
 }
 
 /*
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
