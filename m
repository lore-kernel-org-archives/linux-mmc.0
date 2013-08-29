From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ARM: shmobile: update SDHI DT compatibility string to the
 <unit>-<soc> format
Date: Thu, 29 Aug 2013 17:14:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1308291650120.3786@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-sh@vger.kernel.org
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Currently DT compatibility strings of both types can be found in the kernel
sources: <unit>-<soc> and <soc>-<unit>, whereas a unique format should be
followed and the former one is preferred. This patch converts the SDHI
MMC driver and its users to the common standard. This is safe for now, since
ATM no real products are using this driver with DT.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

Ok, the "no real products" is an assumption, that Laurent and Simon kind 
of agreed upon, so, I'm using it here to avoid having to carry old 
compatibility strings with us around. If anyone has other information - 
please shout. Otherwise, I think, it would be the easiest for Chris to ack 
this and for Simon to pull this via the ARM tree for late 3.12 (possibly, 
post -rc1) inclusion.

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   17 ++++++++++-------
 arch/arm/boot/dts/r8a73a4.dtsi                     |    6 +++---
 arch/arm/boot/dts/r8a7740.dtsi                     |    4 ++--
 arch/arm/boot/dts/r8a7790.dtsi                     |    8 ++++----
 arch/arm/boot/dts/sh73a0.dtsi                      |    6 +++---
 drivers/mmc/host/sh_mobile_sdhi.c                  |   16 ++++++++--------
 6 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index df204e1..6a2a116 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -9,12 +9,15 @@ compulsory and any optional properties, common to all SD/MMC drivers, as
 described in mmc.txt, can be used. Additionally the following tmio_mmc-specific
 optional bindings can be used.
 
+Required properties:
+- compatible:	"renesas,sdhi-shmobile" - a generic sh-mobile SDHI unit
+		"renesas,sdhi-sh7372" - SDHI IP on SH7372 SoC
+		"renesas,sdhi-sh73a0" - SDHI IP on SH73A0 SoC
+		"renesas,sdhi-r8a73a4" - SDHI IP on R8A73A4 SoC
+		"renesas,sdhi-r8a7740" - SDHI IP on R8A7740 SoC
+		"renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
+		"renesas,sdhi-r8a7779" - SDHI IP on R8A7779 SoC
+		"renesas,sdhi-r8a7790" - SDHI IP on R8A7790 SoC
+
 Optional properties:
 - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
-
-When used with Renesas SDHI hardware, the following compatibility strings
-configure various model-specific properties:
-
-"renesas,sh7372-sdhi":	(default) compatible with SH7372
-"renesas,r8a7740-sdhi":	compatible with R8A7740: certain MMC/SD commands have to
-			wait for the interface to become idle.
diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index b0511b1..cc7211b 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -236,7 +236,7 @@
 	};
 
 	sdhi0: sdhi@ee100000 {
-		compatible = "renesas,r8a73a4-sdhi";
+		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee100000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 165 4>;
@@ -245,7 +245,7 @@
 	};
 
 	sdhi1: sdhi@ee120000 {
-		compatible = "renesas,r8a73a4-sdhi";
+		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee120000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 166 4>;
@@ -254,7 +254,7 @@
 	};
 
 	sdhi2: sdhi@ee140000 {
-		compatible = "renesas,r8a73a4-sdhi";
+		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee140000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 167 4>;
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 8fc4a5d..c4992b5 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -155,7 +155,7 @@
 	};
 
 	sdhi0: sdhi@e6850000 {
-		compatible = "renesas,r8a7740-sdhi";
+		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xe6850000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 117 4
@@ -167,7 +167,7 @@
 	};
 
 	sdhi1: sdhi@e6860000 {
-		compatible = "renesas,r8a7740-sdhi";
+		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xe6860000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 121 4
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 3b879e7..885f9f4 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -152,7 +152,7 @@
 	};
 
 	sdhi0: sdhi@ee100000 {
-		compatible = "renesas,r8a7790-sdhi";
+		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee100000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 165 4>;
@@ -161,7 +161,7 @@
 	};
 
 	sdhi1: sdhi@ee120000 {
-		compatible = "renesas,r8a7790-sdhi";
+		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee120000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 166 4>;
@@ -170,7 +170,7 @@
 	};
 
 	sdhi2: sdhi@ee140000 {
-		compatible = "renesas,r8a7790-sdhi";
+		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee140000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 167 4>;
@@ -179,7 +179,7 @@
 	};
 
 	sdhi3: sdhi@ee160000 {
-		compatible = "renesas,r8a7790-sdhi";
+		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee160000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 168 4>;
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index ba59a58..3955c76 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -196,7 +196,7 @@
 	};
 
 	sdhi0: sdhi@ee100000 {
-		compatible = "renesas,r8a7740-sdhi";
+		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xee100000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 83 4
@@ -208,7 +208,7 @@
 
 	/* SDHI1 and SDHI2 have no CD pins, no need for CD IRQ */
 	sdhi1: sdhi@ee120000 {
-		compatible = "renesas,r8a7740-sdhi";
+		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xee120000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 88 4
@@ -219,7 +219,7 @@
 	};
 
 	sdhi2: sdhi@ee140000 {
-		compatible = "renesas,r8a7740-sdhi";
+		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xee140000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 104 4
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 87ed3fb..f344659 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -113,14 +113,14 @@ static const struct sh_mobile_sdhi_ops sdhi_ops = {
 };
 
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
-	{ .compatible = "renesas,shmobile-sdhi" },
-	{ .compatible = "renesas,sh7372-sdhi" },
-	{ .compatible = "renesas,sh73a0-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,r8a73a4-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,r8a7740-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,r8a7778-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,r8a7779-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,r8a7790-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-shmobile" },
+	{ .compatible = "renesas,sdhi-sh7372" },
+	{ .compatible = "renesas,sdhi-sh73a0", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a73a4", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a7740", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a7778", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a7779", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a7790", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
-- 
1.7.2.5
