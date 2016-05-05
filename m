From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v2 10/13] usb: hub: Power sequence the ports on activation
Date: Thu, 05 May 2016 14:34:23 +0200
Message-ID: <1462451666-17945-11-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: tjakobi@math.uni-bielefeld.de, m.szyprowski@samsung.com, hverkuil@xs4all.nl, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

The autodetection of attached USB device might not work on certain
boards where the power is delivered externally. These devices also might
require a hard reset. Use pwrseq for that in USB hub.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/usb/core/hub.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 1c82fcc448f5..0fddaacc62bf 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/pwrseq.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -1661,7 +1662,17 @@ static int hub_configure(struct usb_hub *hub,
 
 	usb_hub_adjust_deviceremovable(hdev, hub->descriptor);
 
+	/* FIXME: When do the pre-power-on? */
+	/*
+	for (i = 0; i < maxchild; i++)
+		pwrseq_pre_power_on(hub->ports[i]->pwrseq);
+	*/
+
+	for (i = 0; i < maxchild; i++)
+		pwrseq_post_power_on(hub->ports[i]->pwrseq);
+
 	hub_activate(hub, HUB_INIT);
+
 	return 0;
 
 fail:
-- 
1.9.1
