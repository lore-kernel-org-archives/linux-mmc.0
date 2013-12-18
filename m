From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND LIST PATCHv7 1/4] clk: socfpga: Add a clk-phase property to the "altr, socfpga-gate-clk"
Date: Wed, 18 Dec 2013 22:21:46 +0100
Message-ID: <201312182221.46506.arnd@arndb.de>
References: <1387213476-22122-1-git-send-email-dinguyen@altera.com> <1387213476-22122-2-git-send-email-dinguyen@altera.com> <20131218205636.23538.50735@quantum>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60100 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab3LRVWA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 16:22:00 -0500
In-Reply-To: <20131218205636.23538.50735@quantum>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: dinguyen@altera.com, dinh.linux@gmail.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Wednesday 18 December 2013, Mike Turquette wrote:
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > index f936476..616d9ee 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -413,6 +413,7 @@
> >                                                 compatible = "altr,socfpga-gate-clk";
> >                                                 clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
> >                                                 clk-gate = <0xa0 8>;
> > +                                               clk-phase = <0 3>;
> 
> Looking at this again, I have a hard time understanding the values in
> the clk-phase property. You reference some functions in the property
> definition above, but they are not obvious to me.
> 
> Additionally I wonder if the binding would better if the clock-phase
> property was simply the value in degrees. E.g:
> 
>         clk-phase = <315>;    // 315 degrees

I would definitely prefer using degrees over an arbitrary enumeration that
might work on some platforms but not on others.

I'm also a bit skeptical about the idea of putting the phase into the clock
provider rather than the consumer, given the comments about the
clk_set_phase() interface earlier. Generally we try to avoid having
consumer-specific settings in a provider node (for any DT binding,
not just clocks). Can't you have the same numbers in the dw-mshc
node instead and let the mmc driver call clk_set_phase instead?
If every clock has a fixed phase for a given piece of hardware, it
could even be set automatically by making the common clk code read
the clk-phase attribute at the time a driver calls clk_get.

	Arnd
