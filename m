From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 0/21] Totally remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
 quirk
Date: Fri, 29 Jan 2016 14:08:21 +0200
Message-ID: <56AB5635.9030007@intel.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
 <56A8BF22.8010509@intel.com> <20160127132348.GY10826@n2100.arm.linux.org.uk>
 <CAPDyKFr0MT5xa87F=4LPX7WbNuD0THndTDkvhL9N0h6A5g67eg@mail.gmail.com>
 <56AA03AA.5010706@intel.com>
 <CAPDyKFoBdJ-5sXyJpTNxDJVJSUA+Gsjc+0+uLedNZCHYcF+rvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:10671 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752569AbcA2MLt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Jan 2016 07:11:49 -0500
In-Reply-To: <CAPDyKFoBdJ-5sXyJpTNxDJVJSUA+Gsjc+0+uLedNZCHYcF+rvQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>, Wan Zongshun <vincent.wan@amd.com>

On 28/01/16 17:16, Ulf Hansson wrote:
> [...]
> 
>>> I don't intend to contribute much with actual patches. I am willing to
>>> help review and also help with expertise around the PM related parts.
>>>
>>> I do realize that some callbacks may still be needed, even in the end
>>> when sdhci has become a pure library. Although, those should be far
>>> less then those we have today.
>>>
>>> Currently I am more or less unable to properly maintain sdhci because
>>> of it's bad code structure. Therefore I have taken a quite simple
>>> approach by rejecting new callbacks and quirks, in a way to prevent it
>>> from being worse. To me, the best way forward would be if some of you
>>> experienced sdhci developers stepped in as a maintainer for it. In
>>> that way, I can trust the development moving in the "library
>>> direction" so I can pull back from nacking potential interim sdhci
>>> callbacks/quirks.
>>>
>>> Does it make sense?
>>
>> I am happy to help and even be the SDHCI maintainer if Russell King and
>> others agree.  I have an interest in sdhci-acpi and sdhci-pci and also there
>> is UHS-II and ADMA3 on the horizon.
> 
> That's really great news. Thank you very much Adrian!
> 
> Perhaps Russell is willing to help co-maintain it?
> 
>>
>> I agree with Russell that a re-write would introduce more bugs and more work
>> than it would be worth.  Making many small steps in the general direction is
>> preferable.
>>
>> Initially it would nice to see it made easy for drivers to replace specific
>> mmc ops and sdhci ops and then call the standard version before/after doing
>> some custom code.  For example, P L Sai Krishna's auto-tuning problem might
>> be solved by something to the effect of:
>>
>> int arasan_execute_tuning(struct mmc_host *mmc, u32 opcode)
>> {
>>         struct sdhci_host *host = mmc_priv(mmc);
>>         int err;
>>
>>         err = sdhci_execute_tuning(mmc, opcode);
>>         if (!err)
>>                 arasan_tune_sdclk(host);
>>         return err;
>> }
>>
>> And Wan Zongshun also wanted to be able directly to replace
>> sdhci_execute_tuning() from sdhci-pci.
>>
>> As suggested, my get_cd problem could also be solved by replacing the mmc
>> get_cd op.
>>
> 
> Sounds like a perfect plan!
> 
> Do you want to send a patch to the MAINTAINERS file?

Yes, I'll do that.

> 
>>From my side I can also continue doing the administrative part of the
> work, so there's need for you to set up a separate git tree or send
> pull request. At least initially.
> Instead I will just pick patches that's been acked by you (and
> possibly Russell).

I might make a tree because I want to try to separate Russell's bug fixes
from the clean-ups, and then cc stable on the bug fixes.

