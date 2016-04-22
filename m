From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/2] ARM: dts: r8a7793: Add SDHI controllers
Date: Fri, 22 Apr 2016 10:25:32 +1000
Message-ID: <20160422002531.GD25416@verge.net.au>
References: <CAMuHMdUQh0OnJhJ6RCH_MzDnOLd_ni_tEi4jC=KDewqTMQX7-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUQh0OnJhJ6RCH_MzDnOLd_ni_tEi4jC=KDewqTMQX7-w@mail.gmail.com>
 <CAMuHMdUwHhd-C=PCTubUUpQY4w5hDPjiCQMF65KMRojrnQgd+w@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-renesas-soc@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Apr 21, 2016 at 02:54:30PM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 18, 2016 at 6:02 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > --- a/arch/arm/boot/dts/r8a7793.dtsi
> > +++ b/arch/arm/boot/dts/r8a7793.dtsi
> > @@ -510,6 +510,42 @@
> >                 reg = <0 0xe6060000 0 0x250>;
> >         };
> >
> > +       sdhi0: sd@ee100000 {
> > +               compatible = "renesas,sdhi-r8a7793";
> > +               reg = <0 0xee100000 0 0x328>;
> > +               interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
> 
> GIC_SPI (x3)

Thanks, I should have noticed that.

On Thu, Apr 21, 2016 at 02:55:06PM +0200, Geert Uytterhoeven wrote:
> On Thu, Apr 21, 2016 at 5:27 AM, Simon Horman <horms@verge.net.au> wrote:
> >
> > We are back to one DMA controller this week so I updated your patch and
> > queued up the following.
> >
> > From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > Date: Mon, 18 Apr 2016 18:02:56 +0200
> > Subject: [PATCH] ARM: dts: r8a7793: Add SDHI controllers
> >
> > Same as on r8a7791.
> >
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/boot/dts/r8a7793.dtsi | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> > index fc552629ed4a..a93d509732a8 100644
> > --- a/arch/arm/boot/dts/r8a7793.dtsi
> > +++ b/arch/arm/boot/dts/r8a7793.dtsi
> > @@ -507,6 +507,39 @@
> >                 reg = <0 0xe6060000 0 0x250>;
> >         };
> >
> > +       sdhi0: sd@ee100000 {
> > +               compatible = "renesas,sdhi-r8a7793";
> > +               reg = <0 0xee100000 0 0x328>;
> > +               interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
> > +               clocks = <&mstp3_clks R8A7793_CLK_SDHI0>;
> > +               dmas = <&dmac0 0xcd>, <&dmac0 0xce>;
> > +               dma-names = "tx", "rx", "tx", "rx";
> 
> If you drop the last two dma values, you should drop the last two
> dma-names values, too.

Sorry about that, I'm unsure how I managed to mess that up.

I have updated the patch and re-queued the following.

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 18 Apr 2016 18:02:56 +0200
Subject: [PATCH] ARM: dts: r8a7793: Add SDHI controllers

Same as on r8a7791.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index bddc31283bd9..6186179fd66d 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -507,6 +507,39 @@
 		reg = <0 0xe6060000 0 0x250>;
 	};
 
+	sdhi0: sd@ee100000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee100000 0 0x328>;
+		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI0>;
+		dmas = <&dmac0 0xcd>, <&dmac0 0xce>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	sdhi1: sd@ee140000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee140000 0 0x100>;
+		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI1>;
+		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	sdhi2: sd@ee160000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee160000 0 0x100>;
+		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI2>;
+		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	scifa0: serial@e6c40000 {
 		compatible = "renesas,scifa-r8a7793",
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-- 
2.7.0.rc3.207.g0ac5344
