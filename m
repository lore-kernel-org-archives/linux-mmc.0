From: Doug Anderson <dianders@chromium.org>
Subject: Re: mwifiex card reset
Date: Tue, 1 Jul 2014 08:09:38 -0700
Message-ID: <CAD=FV=Xi5B2=tssgQSgjeKtYVcw-x9pS6Ci580M6OfroPCb+RA@mail.gmail.com>
References: <CALtMJEBWPM+75wxM2Mp5EX_o6NWtZUJdYRCv6psbvdUn4k295w@mail.gmail.com>
	<20140628052220.GG10407@us.netrek.org>
	<20140628072322.GC7410@atomide.com>
	<CALtMJED5vfgkAhMBXKaDP6u9U9n41c-wziyTxt6e_7XTSxG3oQ@mail.gmail.com>
	<20140630061912.GA2461@atomide.com>
	<53B1BAC1.3090902@zonque.org>
	<477F20668A386D41ADCC57781B1F70430FE5F37540@SC-VEXCH1.marvell.com>
	<20140701065721.GM24891@us.netrek.org>
	<CA+NduCAuRFTQneJUBiKP2Aeq2HCxe71yxg_iDDStkNvhzRg-Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:35273 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbaGAPJj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Jul 2014 11:09:39 -0400
Received: by mail-vc0-f174.google.com with SMTP id hy4so9070139vcb.19
        for <linux-mmc@vger.kernel.org>; Tue, 01 Jul 2014 08:09:38 -0700 (PDT)
In-Reply-To: <CA+NduCAuRFTQneJUBiKP2Aeq2HCxe71yxg_iDDStkNvhzRg-Rg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Cd <yuvaraj.lkml@gmail.com>, Olof Johansson <olof@lixom.net>
Cc: James Cameron <quozl@laptop.org>, Bing Zhao <bzhao@marvell.com>, Daniel Mack <daniel@zonque.org>, Tony Lindgren <tony@atomide.com>, Andreas Fenkart <afenkart@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>

+Olof who posted the patch that Yuvaraj referenced.

On Tue, Jul 1, 2014 at 5:20 AM, Yuvaraj Cd <yuvaraj.lkml@gmail.com> wrote:
> On Tue, Jul 1, 2014 at 12:27 PM, James Cameron <quozl@laptop.org> wrote:
>> On Mon, Jun 30, 2014 at 11:44:29PM -0700, Bing Zhao wrote:
>>> I may have missed something, but doesn't the MMC_POWER_OFF and
>>> MMC_POWER_ON|UP handling in controller driver help?
>>> Anyway the clocks/GPIOs/regulators are sort of platform
>>> dependent. Would it be better putting it in /arch/arm/mach-xxxxx/?
>>
>> Wouldn't device tree for mmc be better?
> I have come across same problem.Below is the thread in which more
> discussions happened on this.
>  http://patchwork.ozlabs.org/patch/312444/
> I am adding few more those who are interested in this solution.

Thanks to Yuvaraj for referencing the old thread.

It seems like there are already enough chefs in the kitchen so I'm not
going to add any more suggestions myself.  I'll point out that on all
ARM Chromebooks (which to date have a Marvell part connected via SDIO)
all face the same problem.  In production kernels we've continued to
get by with various hacks.  The current kernels use a hack with
regulator chaining and assumptions about 32K clocks already being on.
This is less egregious than the hacks in older kernels which initted
WiFi in the LCD backlight function (dont ask) but is still a hack.

-Doug
