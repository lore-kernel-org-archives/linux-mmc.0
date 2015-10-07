From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: All OMAP platforms: MMC is broken
Date: Thu, 8 Oct 2015 04:43:39 +0530
Message-ID: <5615A723.6090907@ti.com>
References: <20151005145127.GB23801@atomide.com>
 <20151005171155.GF23801@atomide.com>
 <20151005183813.GD21626@n2100.arm.linux.org.uk>
 <20151006090015.GE21626@n2100.arm.linux.org.uk>
 <20151006094425.GM23801@atomide.com>
 <20151006150009.GF21626@n2100.arm.linux.org.uk>
 <20151006153710.GS23801@atomide.com>
 <20151007124551.GI21626@n2100.arm.linux.org.uk>
 <20151007132642.GV23801@atomide.com>
 <CAPDyKFoBPEnHuNR_bsrPU6X=q5pHa8cDR7_Ng9xLnLsudymvOg@mail.gmail.com>
 <20151007155206.GX23801@atomide.com>
 <CAPDyKFp5e_pizFSCzeYSM8sXGx6Jewgs2PRB-RQ1iWMM6WMOww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52083 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbbJGXOZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Oct 2015 19:14:25 -0400
In-Reply-To: <CAPDyKFp5e_pizFSCzeYSM8sXGx6Jewgs2PRB-RQ1iWMM6WMOww@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, "arm@kernel.org" <arm@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Thursday 08 October 2015 01:10 AM, Ulf Hansson wrote:
> On 7 October 2015 at 17:52, Tony Lindgren <tony@atomide.com> wrote:
>> * Ulf Hansson <ulf.hansson@linaro.org> [151007 06:46]:
>>> On 7 October 2015 at 15:26, Tony Lindgren <tony@atomide.com> wrote:
>>>>>> Good idea, how about something like the following? AFAIK that's the
>>>>>> only .config option needed as MFD_SYSCON is selected by Kconfig
>>>>>> already.
>>>
>>> Similar to MFD_SYSCON, why don't we have REGULATOR_PBIAS to be
>>> selected when omap_hsmmc is being used?
>>>
>>> It seems like that should also be a patch for the rc, right!?
>>
>> Well selecting CONFIG_REGULATOR is still optional and force selecting
>> drivers usually leads into randconfig build issues sooner or later.
>> And we'd like to make everything into loadable modules eventually.
> 
> I am not sure I get your point. Perhaps I was too vague in what I suggested.
> 
> Unless we express the dependencies via Kconfig files (or perhaps via
> updated defconfigs), how do you expect build/boot automated tools to
> handle this?

Both omap2plus_defconfig and multi_v7_defconfig has
CONFIG_PBIAS_REGULATOR enabled [1].

I think by using *depends on* in Kconfig, we'll end up in the same issue
faced by Russell (since even with that CONFIG_PBIAS_REGULATOR won't be
enabled) and using *select* can lead to randconfig errors.

[1] -> https://lkml.org/lkml/2015/9/3/119

Thanks
Kishon
