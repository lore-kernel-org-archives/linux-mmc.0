From: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Subject: [PATCH v2 1/3] mmc: dt: usdhi6rol0: add optional pinctrl binding
Date: Mon, 18 Apr 2016 15:44:53 +0200
Message-ID: <0376e04a938f459cee9e1f80e1447e060ba7e497.1460986983.git.larper@axis.com>
References: <cover.1460986983.git.larper@axis.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1460986983.git.larper-VrBV9hrLPhE@public.gmane.org>
In-Reply-To: <cover.1460986983.git.larper-VrBV9hrLPhE@public.gmane.org>
References: <cover.1460986983.git.larper-VrBV9hrLPhE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: g.liakhovetski-Mmb7MZpHnFY@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add a pinctrl binding to specify different pin settings for high speed
modes and UHS modes.

Signed-off-by: Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/usdhi6rol0.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
index 8babdaa..9dd9478 100644
--- a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
+++ b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
@@ -12,6 +12,10 @@ Optional properties:
 
 - vmmc-supply:	a phandle of a regulator, supplying Vcc to the card
 - vqmmc-supply:	a phandle of a regulator, supplying VccQ to the card
+- pinctrl-names: Must contain a "default" entry and optionally a "pins_uhs"
+                 entry for the UHS pin configuration.
+- pinctrl-N: One property for each name listed in pinctrl-names, see
+             ../pinctrl/pinctrl-bindings.txt.
 
 Additionally any standard mmc bindings from mmc.txt can be used.
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
