From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: All OMAP platforms: MMC is broken
Date: Wed, 7 Oct 2015 15:41:46 +0200
Message-ID: <CAPDyKFoBPEnHuNR_bsrPU6X=q5pHa8cDR7_Ng9xLnLsudymvOg@mail.gmail.com>
References: <20151005112304.GZ23801@atomide.com>
	<20151005143532.GA23801@atomide.com>
	<20151005145127.GB23801@atomide.com>
	<20151005171155.GF23801@atomide.com>
	<20151005183813.GD21626@n2100.arm.linux.org.uk>
	<20151006090015.GE21626@n2100.arm.linux.org.uk>
	<20151006094425.GM23801@atomide.com>
	<20151006150009.GF21626@n2100.arm.linux.org.uk>
	<20151006153710.GS23801@atomide.com>
	<20151007124551.GI21626@n2100.arm.linux.org.uk>
	<20151007132642.GV23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34161 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbbJGNls (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Oct 2015 09:41:48 -0400
Received: by wicfx3 with SMTP id fx3so213192780wic.1
        for <linux-mmc@vger.kernel.org>; Wed, 07 Oct 2015 06:41:47 -0700 (PDT)
In-Reply-To: <20151007132642.GV23801@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, "arm@kernel.org" <arm@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 7 October 2015 at 15:26, Tony Lindgren <tony@atomide.com> wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [151007 05:50]:
>> On Tue, Oct 06, 2015 at 08:37:11AM -0700, Tony Lindgren wrote:
>> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [151006 08:04]:
>> > > On Tue, Oct 06, 2015 at 02:44:25AM -0700, Tony Lindgren wrote:
>> > > >
>> > > > Hmm DT-based boot finds the MMC card for LDP, dmesg below from DT boot [1].
>> > > > Looks like you're on on -rc4 and not -rc3. My guess is that MMC is not
>> > > > working for you with DT-based booting because you don't seem to have
>> > > > CONFIG_REGULATOR_PBIAS in your seed config for. Care to try enabling that
>> > > > for both your omap3 and omap4 seed config files?
>> > >
>> > > This is precisely the kind of crap I'm objecting to.  New kernel versions
>> > > come along, and things break because people add extra Kconfig symbols that
>> > > previous versions did not rely upon - and there's no communication of
>> > > what's required for new kernel versions.
>> > >
>> > > This stuff needs documenting, so that people are aware what changes they
>> > > need to make - please put something in Documentation/arm/OMAP which
>> > > tracks what new additions are required to the Kconfig to keep things
>> > > working.
>> >
>> > Good idea, how about something like the following? AFAIK that's the
>> > only .config option needed as MFD_SYSCON is selected by Kconfig
>> > already.

Similar to MFD_SYSCON, why don't we have REGULATOR_PBIAS to be
selected when omap_hsmmc is being used?

It seems like that should also be a patch for the rc, right!?

>>
>> Right, that resolves the issue.  Now, what's the story on the revert
>> and the other patch - have they already been taken for -rc kernels?

Great!

>
> Not yet, I was waiting for the confirmation from you. I've now posted the
> revert with proper description and the fix so Ulf can pick them up and
> merged as regression fixes for the -rc series:

I am on it!

>
> http://marc.info/?l=linux-omap&m=144422416621373&w=2
> http://marc.info/?l=linux-omap&m=144422416921375&w=2

Russell, may I add your tested by tag for these?

Again, thanks!

Kind regards
Uffe
