From: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Subject: [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
Date: Mon, 14 Aug 2017 12:39:26 +0100
Message-ID: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Paterson <chris.paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5) SDHI
is identical to the R-Car Gen2 family.

Signed-off-by: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
---
This patch is compiled and tested againt linux next tag
next-20170811. This patch depend on the driver change
[PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
https://patchwork.kernel.org/patch/9898611/


 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 4fd8b7a..0d507ec 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -15,6 +15,8 @@ Required properties:
 		"renesas,sdhi-r7s72100" - SDHI IP on R7S72100 SoC
 		"renesas,sdhi-r8a73a4" - SDHI IP on R8A73A4 SoC
 		"renesas,sdhi-r8a7740" - SDHI IP on R8A7740 SoC
+		"renesas,sdhi-r8a7743" - SDHI IP on R8A7743 SoC
+		"renesas,sdhi-r8a7745" - SDHI IP on R8A7745 SoC
 		"renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
 		"renesas,sdhi-r8a7779" - SDHI IP on R8A7779 SoC
 		"renesas,sdhi-r8a7790" - SDHI IP on R8A7790 SoC
@@ -34,8 +36,8 @@ Required properties:
 	  "core" and "cd". If the controller only has 1 clock, naming is not
 	  required.
 	  Below is the number clocks for each supported SoC:
-	   1: SH73A0, R8A73A4, R8A7740, R8A7778, R8A7779, R8A7790
-	      R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
+	   1: SH73A0, R8A73A4, R8A7740, R8A7743, R8A7745, R8A7778, R8A7779,
+	      R8A7790, R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
 	   2: R7S72100
 
 Optional properties:
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
