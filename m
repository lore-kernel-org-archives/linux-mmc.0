From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH] ARM: shmobile: update SDHI DT compatibility string to
 the <unit>-<soc> format
Date: Sat, 21 Sep 2013 10:14:09 -0700
Message-ID: <20130921171409.GA6863@verge.net.au>
References: <Pine.LNX.4.64.1308291650120.3786@axis700.grange>
 <1621893.Re68yLczyK@avalon>
 <20130905060102.GH14960@verge.net.au>
 <86ob87tpsi.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <86ob87tpsi.fsf-zkTaxWjgBN6ccd+RBA7C9g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 05, 2013 at 01:29:33PM +0100, Chris Ball wrote:
> Hi,
> 
> On Thu, Sep 05 2013, Simon Horman wrote:
> >> > Ok, the "no real products" is an assumption, that Laurent and Simon kind
> >> > of agreed upon, so, I'm using it here to avoid having to carry old
> >> > compatibility strings with us around. If anyone has other information -
> >> > please shout. Otherwise, I think, it would be the easiest for Chris to ack
> >> > this and for Simon to pull this via the ARM tree for late 3.12 (possibly,
> >> > post -rc1) inclusion.
> >
> > Thanks, I believe that is a good plan.
> >
> > Chris, could we get an Ack?
> 
> Acked-by: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>

Thanks, and sorry for the delay.

I have queued up the following, And I will push it either in the next
half hour or some time next week - I have to jump on a plane shortly.

Guennadi, it seems that SDHI (and MMCIF) support form
armadillo800eva-reference never made it into my tree.  And I have dropped
r8a7740.dtsi changes from the patch below accordingly.  Would you care to
repost that series with the compatibility string updated?


From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>

[PATCH] ARM: shmobile: update SDHI DT compatibility string to the <unit>-<soc> format

Currently DT compatibility strings of both types can be found in the kernel
sources: <unit>-<soc> and <soc>-<unit>, whereas a unique format should be
followed and the former one is preferred. This patch converts the SDHI
MMC driver and its users to the common standard. This is safe for now, since
ATM no real products are using this driver with DT.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
[Removed r8a7740.dtsi portion as it is not applicable]
Signed-off-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 17 ++++++++++-------
 arch/arm/boot/dts/r8a73a4.dtsi                     |  6 +++---
 arch/arm/boot/dts/r8a7790.dtsi                     |  8 ++++----
 arch/arm/boot/dts/sh73a0.dtsi                      |  6 +++---
 drivers/mmc/host/sh_mobile_sdhi.c                  | 16 ++++++++--------
 5 files changed, 28 insertions(+), 25 deletions(-)

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
index 6c26caa..658fcc5 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -193,7 +193,7 @@
 	};
 
 	sdhi0: sdhi@ee100000 {
-		compatible = "renesas,r8a73a4-sdhi";
+		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee100000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 165 4>;
@@ -202,7 +202,7 @@
 	};
 
 	sdhi1: sdhi@ee120000 {
-		compatible = "renesas,r8a73a4-sdhi";
+		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee120000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 166 4>;
@@ -211,7 +211,7 @@
 	};
 
 	sdhi2: sdhi@ee140000 {
-		compatible = "renesas,r8a73a4-sdhi";
+		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee140000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 167 4>;
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
1.8.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
