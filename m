From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
Date: Sat, 14 Dec 2013 20:51:16 -0800
Message-ID: <20131215045116.23538.4@quantum>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
 <1386880245-10192-3-git-send-email-dinguyen@altera.com>
 <201312142233.27143.arnd@arndb.de> <52AD1185.6090501@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:50357 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058Ab3LOEvU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Dec 2013 23:51:20 -0500
Received: by mail-yh0-f48.google.com with SMTP id f73so2772267yha.21
        for <linux-mmc@vger.kernel.org>; Sat, 14 Dec 2013 20:51:19 -0800 (PST)
In-Reply-To: <52AD1185.6090501@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>, Arnd Bergmann <arnd@arndb.de>, dinguyen@altera.com
Cc: dinh.linux@gmail.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter De Schrijver <pdeschrijver@nvidia.com>

Quoting zhangfei (2013-12-14 18:18:45)
> Dear Arnd
> 
> On 12/15/2013 05:33 AM, Arnd Bergmann wrote:
> > On Thursday 12 December 2013, dinguyen@altera.com wrote:
> >> From: Dinh Nguyen <dinguyen@altera.com>
> >>
> >> Add a "altr,socfpga-sdmmc-sdr-clk" clock type in the SOCFPGA clock driver. This
> >> clock type is not really a "clock" for say, but a mechanism to set the phase
> >> shift of the clock that is used to feed the SD/MMC CIU's clock. This clock does
> >> not have parent so it is designated as a CLK_IS_ROOT.
> >>
> >> This clock implements the set_clk_rate method that is meant to receive the SDR
> >> settings that is designated by the "samsung,dw-mshc-sdr-timing" binding. The
> >> SD/MMC driver passes this clock phase information into the clock driver to use.
> >>
> >> This enables the SD/MMC driver to touch registers that are located outside of
> >> the SD/MMC IP, which helps make the core SD/MMC driver generic.
> >>
> >> Signed-off-by: Dinh Nguyen <dinguyen@alter.com>
> >
> > Ok, this looks like it will work, but we haven't concluded if this is the
> > best way to do it. I'm looking for guidance from Mike here.
> >
> > The alternatives I can see for this particular problem are:
> >
> > 1. fake a clock and use the 'clk_set_rate' callback to set the phase
> >     rather than the clock frequency (as you do in this patch).
> > 2. extend the common clock API to provide a 'clk_set_phase' interface
> >     that you can call on the CIU clock to set this, so you don't have
> >     to fake anything. This seems to be the nicest interface if we have
> >     the same problem in more drivers.

clk_set_phase has been proposed before and now may be the time to add
it. There are two things that need to be addressed:

1) what are the values for the phase? This needs to work for others that
must set clk phase, so we need to consider all those requirements before
making a new function declaration in clk.h

2) is setting a clock's phase something done dynamically? Put another
way, does the same clock has it's phase set multiple times while the
system is running? For static configuration that only happens during
initialization we do not need a new API. The clock driver can handle it
privately. For dynamic operations though we likely need a new API.

I've Cc'd Peter since I think Tegra has clock phase requirements as well
that we discussed some time back.

Regards,
Mike

> > 3. make the phase setting private to whichever clock is used for CIU
> >     (as one of your previous patches did, which I did not like).
> > 4. make the phase an additional argument to the clock specifier,
> >     so you would have <&mmcclock 12345 5678> rather than just <&mmcclock>
> >     in the mmc host device node to specify the two possible phases.
> >
> > I would also like to get buy-in from Zhangfei Gao, since he is working
> > on the same thing. Please coordinate with him to make sure whatever
> > one of you comes up with works for the other one too. At the moment,
> > patches are flying so fast without much discussion inbetween that I'd
> > prefer Chris to hold off from merging either one until you have both
> > revieved and Acked each other's patches.
> >
> 
> This is our case
> In this version ip, supported now.
> Only several mode (LEGACY, HS) are supported in the code, where fixed 
> div and sample is need to be set, so we can hide them in clock.
> And each controller have different value & register, so different 
> controller use different clock.
> These clock can be ciu_clock, whose parent are original clock input.
> 
> In next version ip, which still not in hand.
> HS200 and other mode have to be supported, tuning process have to be 
> included, good example is drivers/mmc/host/dw_mmc-exynos.c
> .execute_tuning         = dw_mci_exynos_execute_tuning,
> It have to choose the best point during the tuning process.
> Some other mode may still need tuning, which is special in our case.
> 
> Zhangfei
> 
> 
> 
> 
> 
