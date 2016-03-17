From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ARM: dts: r8a7793: Add MMCIF0
Date: Thu, 17 Mar 2016 10:23:55 +0900
Message-ID: <20160317012355.GF17728@verge.net.au>
References: <1458148237-21902-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <56E995EE.2010805@cogentembedded.com>
 <20160317002907.GC17728@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160317002907.GC17728@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 17, 2016 at 09:29:08AM +0900, Simon Horman wrote:
> On Wed, Mar 16, 2016 at 08:20:46PM +0300, Sergei Shtylyov wrote:
> > Hello.
> > 
> > On 03/16/2016 08:10 PM, Ulrich Hecht wrote:
> > 
> > >Same as on r8a7794.
> 
> Thanks, I'm pleased to see this.
> Its been on my todo list for a while.
> 
> > >
> > >Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > >---
> > >  arch/arm/boot/dts/r8a7793.dtsi | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > >diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> > >index 63f811d..33413e8 100644
> > >--- a/arch/arm/boot/dts/r8a7793.dtsi
> > >+++ b/arch/arm/boot/dts/r8a7793.dtsi
> > >@@ -509,6 +509,18 @@
> > >  		reg = <0 0xe6060000 0 0x250>;
> > >  	};
> > >
> > >+	mmcif0: mmcif@ee200000 {
> > >+		compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
> > >+		reg = <0 0xee200000 0 0x80>;
> > >+		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
> > >+		clocks = <&mstp3_clks R8A7793_CLK_MMCIF0>;
> > >+		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
> > >+		       <&dmac1 0xd1>, <&dmac1 0xd2>;
> > >+		dma-names = "tx", "rx";
> > 
> >    4 DMA channels but only 2 channel names?
> 
> Right, it looks like it should be:
> 
> 		dma-names = "tx", "rx", "tx", "rx";
> 
> Ulrich, could you verify that and repost?

One more thing. I think you also need a power domains property:

	power-domains = <&cpg_clocks>;
