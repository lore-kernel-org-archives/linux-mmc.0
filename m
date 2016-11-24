From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH mmc/next] mmc: sh_mmcif: Document r8a73a4, r8a7779 and sh73a0 DT bindings
Date: Thu, 24 Nov 2016 19:17:15 +0100
Message-ID: <1480011435-22125-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Simply document new compatibility strings as the driver is already
activated using a fallback compatibility string.

These compat strings are in keeping with those for all other
Renesas ARM based SoCs with sh_mmcif enabled in mainline.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
I plan to follow-up with patches to use these new compat strings
to bring the DT files of the SoCs in question in-line with those
for other Renesas ARM based SoCs with sh_mmcif enabled in mainline.
---
 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
index ff611fa66871..e4ba92aa035e 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
+++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -8,11 +8,14 @@ Required properties:
 
 - compatible: should be "renesas,mmcif-<soctype>", "renesas,sh-mmcif" as a
   fallback. Examples with <soctype> are:
+	- "renesas,mmcif-r8a73a4" for the MMCIF found in r8a73a4 SoCs
 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
+	- "renesas,mmcif-r8a7778" for the MMCIF found in r8a7778 SoCs
 	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
 	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
 	- "renesas,mmcif-r8a7793" for the MMCIF found in r8a7793 SoCs
 	- "renesas,mmcif-r8a7794" for the MMCIF found in r8a7794 SoCs
+	- "renesas,mmcif-sh73a0" for the MMCIF found in sh73a0 SoCs
 
 - clocks: reference to the functional clock
 
-- 
2.7.0.rc3.207.g0ac5344
