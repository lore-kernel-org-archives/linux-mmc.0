From: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Subject: [PATCH v5 1/4] mmc: dt: usdhi6rol0: add optional pinctrl binding
Date: Wed, 27 Apr 2016 17:21:26 +0200
Message-ID: <a96281244b55d55e36b72a40cd061d7ffd70b88e.1461770066.git.larper@axis.com>
References: <cover.1461770066.git.larper@axis.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1461770066.git.larper-VrBV9hrLPhE@public.gmane.org>
In-Reply-To: <cover.1461770066.git.larper-VrBV9hrLPhE@public.gmane.org>
References: <cover.1461770066.git.larper-VrBV9hrLPhE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: g.liakhovetski-Mmb7MZpHnFY@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add a pinctrl binding to specify different pin settings for high speed
modes and UHS modes.

Signed-off-by: Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/usdhi6rol0.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
index 8babdaa..6d1b797 100644
--- a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
+++ b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
@@ -12,6 +12,12 @@ Optional properties:
 
 - vmmc-supply:	a phandle of a regulator, supplying Vcc to the card
 - vqmmc-supply:	a phandle of a regulator, supplying VccQ to the card
+- pinctrl-names: Can contain a "default" entry and a "state_uhs"
+                 entry. The state_uhs entry is used together with the default
+                 entry when the board requires distinct settings for UHS speeds.
+
+- pinctrl-N: One property for each name listed in pinctrl-names, see
+             ../pinctrl/pinctrl-bindings.txt.
 
 Additionally any standard mmc bindings from mmc.txt can be used.
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
