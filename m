From: Tuomas Tynkkynen <tuomas-yrGDUoBaLx3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] mmc: Don't reference Linux-specific OF_GPIO_ACTIVE_LOW flag in DT binding
Date: Sat, 23 Dec 2017 02:34:12 +0200
Message-ID: <20171223003412.13688-1-tuomas@tuxera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tuomas Tynkkynen <tuomas-yrGDUoBaLx3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

OF_GPIO_ACTIVE_LOW is a Linux implementation detail. The binding
document should be referring to GPIO_ACTIVE_LOW found in
include/dt-bindings/gpio/gpio.h.

Signed-off-by: Tuomas Tynkkynen <tuomas-yrGDUoBaLx3QT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index fb11ae8b3b72..467cd7b147ce 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -67,10 +67,10 @@ logic applies to the "wp-inverted" property.
 CD and WP lines can be implemented on the hardware in one of two ways: as GPIOs,
 specified in cd-gpios and wp-gpios properties, or as dedicated pins. Polarity of
 dedicated pins can be specified, using *-inverted properties. GPIO polarity can
-also be specified using the OF_GPIO_ACTIVE_LOW flag. This creates an ambiguity
+also be specified using the GPIO_ACTIVE_LOW flag. This creates an ambiguity
 in the latter case. We choose to use the XOR logic for GPIO CD and WP lines.
 This means, the two properties are "superimposed," for example leaving the
-OF_GPIO_ACTIVE_LOW flag clear and specifying the respective *-inverted
+GPIO_ACTIVE_LOW flag clear and specifying the respective *-inverted property
 property results in a double-inversion and actually means the "normal" line
 polarity is in effect.
 
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
