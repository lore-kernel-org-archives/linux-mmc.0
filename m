From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v3] DT: mmc: sh_mmcif: document R8A779[34] support
Date: Fri, 16 Oct 2015 01:40:16 +0300
Message-ID: <2657565.2y8qYzu3eL@wasted.cogentembedded.com>
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

Renesas R8A7794 SoC also has the MMCIF controller...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Ulf Hansson's 'mmc.git' repo's 'next' branches plus the
patch I posted earlier today...

Changes in version 3:
- resolved reject.

Changes in version 2:
- deferred R8A7793 support to the patch posted earlier by Ulrich Hecht;
- fixed typo in the changelog.

 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt |    1 +
 1 file changed, 1 insertion(+)

Index: mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
===================================================================
--- mmc.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
+++ mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -11,6 +11,7 @@ Required properties:
 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
 	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
 	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
+	- "renesas,mmcif-r8a7794" for the MMCIF found in r8a7794 SoCs
 
 - clocks: reference to the functional clock
 

