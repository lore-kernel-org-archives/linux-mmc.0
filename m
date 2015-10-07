From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: All OMAP platforms: MMC is broken
Date: Wed, 7 Oct 2015 21:40:42 +0200
Message-ID: <CAPDyKFp5e_pizFSCzeYSM8sXGx6Jewgs2PRB-RQ1iWMM6WMOww@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35515 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbbJGTko (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Oct 2015 15:40:44 -0400
Received: by wicge5 with SMTP id ge5so228131203wic.0
        for <linux-mmc@vger.kernel.org>; Wed, 07 Oct 2015 12:40:43 -0700 (PDT)
In-Reply-To: <20151007155206.GX23801@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, "arm@kernel.org" <arm@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 7 October 2015 at 17:52, Tony Lindgren <tony@atomide.com> wrote:
> * Ulf Hansson <ulf.hansson@linaro.org> [151007 06:46]:
>> On 7 October 2015 at 15:26, Tony Lindgren <tony@atomide.com> wrote:
>> >> > Good idea, how about something like the following? AFAIK that's the
>> >> > only .config option needed as MFD_SYSCON is selected by Kconfig
>> >> > already.
>>
>> Similar to MFD_SYSCON, why don't we have REGULATOR_PBIAS to be
>> selected when omap_hsmmc is being used?
>>
>> It seems like that should also be a patch for the rc, right!?
>
> Well selecting CONFIG_REGULATOR is still optional and force selecting
> drivers usually leads into randconfig build issues sooner or later.
> And we'd like to make everything into loadable modules eventually.

I am not sure I get your point. Perhaps I was too vague in what I suggested.

Unless we express the dependencies via Kconfig files (or perhaps via
updated defconfigs), how do you expect build/boot automated tools to
handle this?

*People* can of course manually poll a README to learn about new
dependencies for each new kernel version, but me personally would
prefer if don't have to.

>
> We could print a warning during MMC1 probe if REGULATOR_PBIAS
> is not selected and attempt to continue probing?

No thanks, it would sprinkle drivers with ugly code :-). I would also
expect that we would get warnings even when we shouldn't, especially
as a cross SoC/board driver may have different dependencies.

To me REGULATOR_PBIAS is a dependency required by a certain SoC/board
when MMC_OMAP_HS is selected. Isn't such dependency easiest dealt with
from SoC/board Kconfig files? Llike for example in the OMAP2 case,
arch/arm/mach-omap2/Kconfig.

Kind regards
Uffe
