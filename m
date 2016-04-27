From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 04/23] mmc: sdhci: re-factor sdhci_start_signal_voltage()
Date: Wed, 27 Apr 2016 23:26:52 +0300
Message-ID: <5721208C.2090509@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-5-git-send-email-aisheng.dong@nxp.com>
 <571A0E5E.4090904@intel.com>
 <CAA+hA=SygBBr+-C_r4Geodni+hj2Mg71o+ecVq_AD8vv22=UPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1449 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbcD0U05 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Apr 2016 16:26:57 -0400
In-Reply-To: <CAA+hA=SygBBr+-C_r4Geodni+hj2Mg71o+ecVq_AD8vv22=UPA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, haibo.chen@nxp.com

On 24/04/2016 12:14 p.m., Dong Aisheng wrote:
> Hi Adrian,
>
> Thanks for the review first.
>
> On Fri, Apr 22, 2016 at 7:43 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 15/04/16 20:29, Dong Aisheng wrote:
>>> Handle host and regulator signal voltage switch separately.
>>> Move host signal voltage switch code into a separated function
>>> sdhci_do_signal_voltage_switch() first, the following patches will
>>> remove the regulator voltage switch code and use the common
>>> mmc_regulator_set_vqmmc() instead.
>>
>> You have changed the order that things are done.
>
> Yes, the oder changes a bit that we always do controller voltage switch first.
> I suppose the order is irrelevant here since i don't recall any
> requirement from card.
>
> Actually the original order is also a bit mass.
> e.g.
> For MMC_SIGNAL_VOLTAGE_330, switch controller first, then vqmmc.
> But for MMC_SIGNAL_VOLTAGE_180, switch vqmmc first, then controller.
> It looks to us the original one also order irrelevant.
>
>> There is no way to know
>> what that will break, so let's not do that.  What about just changing
>> regulator_set_voltage() to mmc_regulator_set_vqmmc()?
>>
>
> Currently what i can think out VIO switch using are three cases: (Pls
> help add if any)
> 1) Both host IO and card IO use external vqmmc to do switch
> (e.g eMMC 1.8V DDR/HS200/HS400 mode)
>
> eMMC has no IO voltage switch protocol and requirement, so usually
> board designed
> using fixed 1.8V for eMMC and host IO.
> Event it's switchable, it should be done in the first mmc_power_up().
> Dynamical switch later may cause eMMC unable to work properly.
> (We have been confirmed about this issue by many eMMC vendors
> like Micron and Sandisk. I'm not sure if any exceptions in the community
> still doing VIO dynamical switch for eMMC, if yes, please help share
> the experience!).
>
> Event some people still do dynamical IO switch for eMMC, since eMMC
> spec has no requirement, so the order should also not care.
>
> 2) Host using controller IO switch while card using standard CMD (SD/SDIO3.0)
>
> SD/SDIO 3.0 spec defines the standard IO switch process and using it's internal
> regulator to do card IO voltage switch. It does not use external vqmmc
> regulator.
> So order irrelevant too.
>
> 3) Host using controller IO switch while card using external vqmmc
> (special SDIO3.0 or eMMC)
> I have met some special SDIO3.0 card like Broadcom WiFi which does not follow
> the spec and using external regulator for card IO voltage.
> Usually it's required to fix to 1.8v and also not order irrelevant.
>
> For eMMC, refer to case 1), it should be fixed to 1.8v at power up.
>
> So it looks all cases seems are not order required.

I don't agree that there is any way to know that other host controllers
are not affected.  I don't want a repeat of sdhci_set_power().

Please instead send a patch for just using mmc_regulator_set_vqmmc()
in place of regulator_set_voltage().
