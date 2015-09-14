From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/17] ARM: dts: am57xx-beagle-x15: Fix regulator
 populated in MMC1 dt node
Date: Mon, 14 Sep 2015 10:12:42 -0700
Message-ID: <20150914171242.GO4215@atomide.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
 <1438168187-1614-13-git-send-email-kishon@ti.com>
 <55B92B88.1080409@ti.com>
 <55DC0D07.7030504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:50430 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291AbbINRMq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Sep 2015 13:12:46 -0400
Content-Disposition: inline
In-Reply-To: <55DC0D07.7030504@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Nishanth Menon <nm@ti.com>, ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com

* Kishon Vijay Abraham I <kishon@ti.com> [150824 23:40]:
> Hi Tony,
> 
> On Thursday 30 July 2015 01:07 AM, Nishanth Menon wrote:
> > On 07/29/2015 06:09 AM, Kishon Vijay Abraham I wrote:
> >> For beagle x15, both the vdd and io lines are connected to the
> >> same regulator (ldo1_reg). However vmmc_aux is populated to vdd_3v3.
> >> Remove it.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  arch/arm/boot/dts/am57xx-beagle-x15.dts |    1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> >> index a63bf78..d0db5c5 100644
> >> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> >> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> >> @@ -579,7 +579,6 @@
> >>  	pinctrl-0 = <&mmc1_pins_default>;
> >>  
> >>  	vmmc-supply = <&ldo1_reg>;
> >> -	vmmc_aux-supply = <&vdd_3v3>;
> >>  	pbias-supply = <&pbias_mmc_reg>;
> >>  	bus-width = <4>;
> >>  	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
> >>
> > Acked-by: Nishanth Menon <nm@ti.com>
> 
> Can you pick this one or you want me to resend it?

Picking into omap-for-v4.3/fixes thanks.

Tony
