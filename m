From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH v3 5/6] ARM: shmobile: lager: Set clock rates for SDHI
Date: Tue, 30 Jun 2015 01:02:41 +0100
Message-ID: <1435622561.23818.43.camel@codethink.co.uk>
References: <1435332116.23818.7.camel@codethink.co.uk>
	 <1435332230.23818.12.camel@codethink.co.uk>
	 <87a8vjjas8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:35746 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbbF3ACq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Jun 2015 20:02:46 -0400
In-Reply-To: <87a8vjjas8.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Ian Molton <ian@mnementh.co.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@lists.codethink.co.uk, linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org

On Mon, 2015-06-29 at 06:23 +0000, Kuninori Morimoto wrote:
> Hi Ben 
> Cc Laurent, Geert, Magnus
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
> > +
> >  	vmmc-supply = <&vcc_sdhi0>;
> >  	vqmmc-supply = <&vccq_sdhi0>;
> >  	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
> > @@ -498,6 +501,9 @@
> >  	pinctrl-0 = <&sdhi2_pins>;
> >  	pinctrl-names = "default";
> >  
> > +	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
> > +	assigned-clock-rates = <97500000>;
> > +
> >  	vmmc-supply = <&vcc_sdhi2>;
> >  	vqmmc-supply = <&vccq_sdhi2>;
> >  	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
> 
> Thank you for your patch, but I still wandering about this.
> Please correct me if I'm misunderstanding.
> 
> Above seetings is for SDHI IP, and it can divide it ?
> The image is
> 
> 	[CPG] -> 156 MHz -> [SDHI] -> 1/x -> [CARD]
> 	         ~~~~~~~
> 
> If so, why we can't use max-frequency ?
> We can calculate/set SDHI IP clocks via 
> max-frequency / clk_round_rate() / clk_set_rate()
> since we know SDHI's divider capability.
> 
> SH-MMC is using this style. and I think it is flexible for every speed.
> Please check sh_mmcif_clock_control(), sh_mmcif_clk_setup()
> on ${LINUX}/drivers/mmc/host/sh_mmcif.c

That's certainly a nicer way of doing this.  The difficulty I see is
that tmio_mmc doesn't know anything about the input clock, and not all
of the drivers using it actually use the clock framework.

Ben.


