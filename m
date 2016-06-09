From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v4 12/14] EXAMPLE CODE: usb: hub: Power sequence the ports on
 activation
Date: Thu, 09 Jun 2016 11:44:29 +0200
Message-ID: <1465465471-28740-13-git-send-email-k.kozlowski@samsung.com>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@v
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

The autodetection of attached USB device might not work on certain
boards where the power is delivered externally.  These devices also might
require a hard reset.  Use pwrseq for that in USB hub.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/usb/core/hub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c421745b84aa..46d9f9aedacc 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/pwrseq.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -1663,6 +1664,15 @@ static int hub_configure(struct usb_hub *hub,
 
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
 	return 0;
 
-- 
1.9.1
