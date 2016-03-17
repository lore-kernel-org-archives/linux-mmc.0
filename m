From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] ARM: dts: r8a7793: Add SDHI controllers
Date: Thu, 17 Mar 2016 10:23:50 +0900
Message-ID: <20160317012350.GD17728@verge.net.au>
References: <1458148297-22159-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1458148297-22159-2-git-send-email-ulrich.hecht+renesas@gmail.com>
 <56E99645.10504@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56E99645.10504@cogentembedded.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 16, 2016 at 08:22:13PM +0300, Sergei Shtylyov wrote:
> On 03/16/2016 08:11 PM, Ulrich Hecht wrote:
> 
> >Same as on r8a7791.
> >
> >Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> >---
> >  arch/arm/boot/dts/r8a7793.dtsi | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> >index b7f32d3..009ce38 100644
> >--- a/arch/arm/boot/dts/r8a7793.dtsi
> >+++ b/arch/arm/boot/dts/r8a7793.dtsi
> >@@ -509,6 +509,39 @@
> >  		reg = <0 0xe6060000 0 0x250>;
> >  	};
> >
> >+	sdhi0: sd@ee100000 {
> >+		compatible = "renesas,sdhi-r8a7793";
> >+		reg = <0 0xee100000 0 0x328>;
> >+		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
> >+		clocks = <&mstp3_clks R8A7793_CLK_SDHI0>;
> >+		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
> >+		       <&dmac1 0xcd>, <&dmac1 0xce>;
> >+		dma-names = "tx", "rx";
> 
>    4 DMA channels but only 2 channel names?

It looks like that should be:

		dma-names = "tx", "rx", "tx", "rx";

It also looks like there should be:

		power-domains = <&cpg_clocks>;

Ulrich, could you verify the above and repost as necessary?
