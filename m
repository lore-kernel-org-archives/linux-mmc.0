From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH v2 5/6] ARM: shmobile: lager: Set clock rates for SDHI
Date: Thu, 11 Jun 2015 02:47:17 +0100
Message-ID: <1433987237.12074.95.camel@codethink.co.uk>
References: <1433892104.12074.49.camel@codethink.co.uk>
	 <1433892257.12074.54.camel@codethink.co.uk>
	 <87r3pjcabj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87r3pjcabj.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On Thu, 2015-06-11 at 01:20 +0000, Kuninori Morimoto wrote:
> Hi Ben
> 
> Sorry for my small amount of question, but I would like to ask 1 thing
> 
> > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> > index aaa4f258e279..5f68e53c58ae 100644
> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > @@ -488,6 +488,9 @@
> >  	pinctrl-0 = <&sdhi0_pins>;
> >  	pinctrl-names = "default";
> >  
> > +	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
> > +	assigned-clock-rates = <156000000>;
> 
> Can we use "max-frequency" here ?
> tmio/sh_mobile_sdhi have tmio_mmc_clk_update/sh_mobile_sdhi_clk_enable

The purpose of these properties is to configure the frequency of the
clock supplied to the SDHI block.  sh_mobile_sdhi has no code to do that
but these properties are handled by the clock core.

The max-frequency property tells the MMC core the maximum clock
frequency that the host can run the SD bus at, but anyway tmio_mmc and
sh_mobile_sdhi seem to always override it.

Ben.


