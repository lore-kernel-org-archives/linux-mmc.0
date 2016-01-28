From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 0/21] Totally remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
 quirk
Date: Thu, 28 Jan 2016 14:03:54 +0200
Message-ID: <56AA03AA.5010706@intel.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
 <56A8BF22.8010509@intel.com> <20160127132348.GY10826@n2100.arm.linux.org.uk>
 <CAPDyKFr0MT5xa87F=4LPX7WbNuD0THndTDkvhL9N0h6A5g67eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7510 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbcA1MHV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jan 2016 07:07:21 -0500
In-Reply-To: <CAPDyKFr0MT5xa87F=4LPX7WbNuD0THndTDkvhL9N0h6A5g67eg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>, Wan Zongshun <vincent.wan@amd.com>

On 27/01/16 17:07, Ulf Hansson wrote:
> On 27 January 2016 at 14:23, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Jan 27, 2016 at 02:59:14PM +0200, Adrian Hunter wrote:
>>> In my view Ulf needs to explain how the SDHCI library is going to work,
>>> particularly in the absence of new callbacks.
>>
>> We need to add new callbacks as part of the conversion to a library,
>> otherwise we're very much into a total rewrite from scratch (which
>> I think is far too much work, and prone to errors) or a big flag day
>> to switch everything over (which will require a moritorium on sdhci
>> patches while the effort to switch everything is ongoing.)
>>
>> Both of those approaches suffer from one huge drawback: there is no
>> way to bisect between them to locate the cause of a regression.
>>
>> A piece-meal approach, where the driver is gradually converted is a
>> far saner approach, because it means that each conversion in the step
>> can be done as a series of transformations, which not only can be
>> properly reviewed, but also bisected - and that is _hugely_ important
>> for the existing state of SDHCI.
>>
>> The chances of some hardware behavioural quirk being missed while
>> trying to convert SDHCI to a library are _extremely_ high, and the
>> only sane approach to this is one which allows a progressive
>> transformation of the driver.
>>
>> Also, the last thing we want is for drivers to end up duplicating
>> entire functions from sdhci.c just because they have one thing
>> different (eg, because they need to do something in the middle of
>> a set_ios() call which no other SDHCI driver needs.)  Having such
>> code duplication will just make maintanence even more of a
>> nightmare.
>>
>> set_ios() is probably one of the worst functions in sdhci right now,
>> and there's no obvious way to split it up into several stand-alone
>> functions which drivers could chain together.
>>
>> I think what needs to happen here is that Ulf needs to leave such
>> decisions about what is acceptable or unacceptable to those who are
>> trying to convert sdhci to a library, otherwise the conversion will
>> probably never happen... unless Ulf wants to get directly involved
>> in the conversion effort, producing patches to make it happen.
>>
> 
> I don't intend to contribute much with actual patches. I am willing to
> help review and also help with expertise around the PM related parts.
> 
> I do realize that some callbacks may still be needed, even in the end
> when sdhci has become a pure library. Although, those should be far
> less then those we have today.
> 
> Currently I am more or less unable to properly maintain sdhci because
> of it's bad code structure. Therefore I have taken a quite simple
> approach by rejecting new callbacks and quirks, in a way to prevent it
> from being worse. To me, the best way forward would be if some of you
> experienced sdhci developers stepped in as a maintainer for it. In
> that way, I can trust the development moving in the "library
> direction" so I can pull back from nacking potential interim sdhci
> callbacks/quirks.
> 
> Does it make sense?

I am happy to help and even be the SDHCI maintainer if Russell King and
others agree.  I have an interest in sdhci-acpi and sdhci-pci and also there
is UHS-II and ADMA3 on the horizon.

I agree with Russell that a re-write would introduce more bugs and more work
than it would be worth.  Making many small steps in the general direction is
preferable.

Initially it would nice to see it made easy for drivers to replace specific
mmc ops and sdhci ops and then call the standard version before/after doing
some custom code.  For example, P L Sai Krishna's auto-tuning problem might
be solved by something to the effect of:

int arasan_execute_tuning(struct mmc_host *mmc, u32 opcode)
{
	struct sdhci_host *host = mmc_priv(mmc);
	int err;

	err = sdhci_execute_tuning(mmc, opcode);
	if (!err)
		arasan_tune_sdclk(host);
	return err;
}

And Wan Zongshun also wanted to be able directly to replace
sdhci_execute_tuning() from sdhci-pci.

As suggested, my get_cd problem could also be solved by replacing the mmc
get_cd op.

