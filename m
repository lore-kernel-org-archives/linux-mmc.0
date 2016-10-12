From: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Subject: [RFC v2 1/2] sdhci: Add device tree property broken-highspeed
Date: Wed, 12 Oct 2016 13:40:55 -0500
Message-ID: <1476297656-7019-2-git-send-email-zach.brown@ni.com>
References: <1476297656-7019-1-git-send-email-zach.brown@ni.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476297656-7019-1-git-send-email-zach.brown-acOepvfBmUk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zach.brown-acOepvfBmUk@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Certain board configurations can make highspeed malfuction due to timing
issues. In these cases a way is needed to force the controller and card
into standard speed even if they otherwise appear to be capable of
highspeed.

The broken-highspeed property will let the sdhci driver know that
highspeed will not work.

Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 8a37782..a2b298c 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -52,6 +52,8 @@ Optional properties:
 - no-sdio: controller is limited to send sdio cmd during initialization
 - no-sd: controller is limited to send sd cmd during initialization
 - no-mmc: controller is limited to send mmc cmd during initialization
+- broken-highspeed: Highspeed is broken, even if the controller and card
+  themselves claim they support highspeed.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
