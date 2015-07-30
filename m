From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] DT: mmc: sh_mmcif: fix "compatible" property text
Date: Thu, 30 Jul 2015 22:59:22 +0300
Message-ID: <3979266.lQrOKbu0yo@wasted.cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The "compatible" property text contradicts even the example given in the MMCIF
binding document itself; moreover, the Renesas MMCIF driver only  matches  on
the generic "compatible" string, and doesn't look for at SoC specific strings
currently at all. Thus describe "renesas,sh-mmcif" string as mandatory and the
others as optional.

Fixes: b4c27763d749 ("mmc: sh_mmcif: Document DT bindings")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: renesas/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
===================================================================
--- renesas.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
+++ renesas/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -6,11 +6,11 @@ and the properties used by the MMCIF dev
 
 Required properties:
 
-- compatible: must contain one of the following
+- compatible: must contain "renesas,sh-mmcif"; may also contain one of
+  the following:
 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
 	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
 	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
-	- "renesas,sh-mmcif" for the generic MMCIF
 
 - clocks: reference to the functional clock
 

