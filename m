From: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4] mmc: sh_mmcif: Document r7s72100 DT bindings
Date: Wed, 22 Mar 2017 10:42:09 -0400
Message-ID: <20170322144209.31768-1-chris.brandt@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Reviewed-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
v4:
* added Reviewed-by and Acked-by
v3:
* added list of how many interrupts each SOC has
v2:
* added interrupt description
---
 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
index e4ba92aa..c32dc5a 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
+++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -8,6 +8,7 @@ Required properties:
 
 - compatible: should be "renesas,mmcif-<soctype>", "renesas,sh-mmcif" as a
   fallback. Examples with <soctype> are:
+	- "renesas,mmcif-r7s72100" for the MMCIF found in r7s72100 SoCs
 	- "renesas,mmcif-r8a73a4" for the MMCIF found in r8a73a4 SoCs
 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
 	- "renesas,mmcif-r8a7778" for the MMCIF found in r8a7778 SoCs
@@ -17,6 +18,13 @@ Required properties:
 	- "renesas,mmcif-r8a7794" for the MMCIF found in r8a7794 SoCs
 	- "renesas,mmcif-sh73a0" for the MMCIF found in sh73a0 SoCs
 
+- interrupts: Some SoCs have only 1 shared interrupt, while others have either
+  2 or 3 individual interrupts (error, int, card detect). Below is the number
+  of interrupts for each SoC:
+    1: r8a73a4, r8a7778, r8a7790, r8a7791, r8a7793, r8a7794
+    2: r8a7740, sh73a0
+    3: r7s72100
+
 - clocks: reference to the functional clock
 
 - dmas: reference to the DMA channels, one per channel name listed in the
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
