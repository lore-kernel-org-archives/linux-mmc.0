From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 0/21] Totally remove SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk
Date: Thu, 28 Jan 2016 16:16:27 +0100
Message-ID: <CAPDyKFoBdJ-5sXyJpTNxDJVJSUA+Gsjc+0+uLedNZCHYcF+rvQ@mail.gmail.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
	<56A8BF22.8010509@intel.com>
	<20160127132348.GY10826@n2100.arm.linux.org.uk>
	<CAPDyKFr0MT5xa87F=4LPX7WbNuD0THndTDkvhL9N0h6A5g67eg@mail.gmail.com>
	<56AA03AA.5010706@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35745 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbcA1PQ2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 10:16:28 -0500
Received: by mail-yk0-f176.google.com with SMTP id y137so33864493yka.2
        for <linux-mmc@vger.kernel.org>; Thu, 28 Jan 2016 07:16:27 -0800 (PST)
In-Reply-To: <56AA03AA.5010706@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>, Wan Zongshun <vincent.wan@amd.com>

[...]

>> I don't intend to contribute much with actual patches. I am willing to
>> help review and also help with expertise around the PM related parts.
>>
>> I do realize that some callbacks may still be needed, even in the end
>> when sdhci has become a pure library. Although, those should be far
>> less then those we have today.
>>
>> Currently I am more or less unable to properly maintain sdhci because
>> of it's bad code structure. Therefore I have taken a quite simple
>> approach by rejecting new callbacks and quirks, in a way to prevent it
>> from being worse. To me, the best way forward would be if some of you
>> experienced sdhci developers stepped in as a maintainer for it. In
>> that way, I can trust the development moving in the "library
>> direction" so I can pull back from nacking potential interim sdhci
>> callbacks/quirks.
>>
>> Does it make sense?
>
> I am happy to help and even be the SDHCI maintainer if Russell King and
> others agree.  I have an interest in sdhci-acpi and sdhci-pci and also there
> is UHS-II and ADMA3 on the horizon.

That's really great news. Thank you very much Adrian!

Perhaps Russell is willing to help co-maintain it?

>
> I agree with Russell that a re-write would introduce more bugs and more work
> than it would be worth.  Making many small steps in the general direction is
> preferable.
>
> Initially it would nice to see it made easy for drivers to replace specific
> mmc ops and sdhci ops and then call the standard version before/after doing
> some custom code.  For example, P L Sai Krishna's auto-tuning problem might
> be solved by something to the effect of:
>
> int arasan_execute_tuning(struct mmc_host *mmc, u32 opcode)
> {
>         struct sdhci_host *host = mmc_priv(mmc);
>         int err;
>
>         err = sdhci_execute_tuning(mmc, opcode);
>         if (!err)
>                 arasan_tune_sdclk(host);
>         return err;
> }
>
> And Wan Zongshun also wanted to be able directly to replace
> sdhci_execute_tuning() from sdhci-pci.
>
> As suggested, my get_cd problem could also be solved by replacing the mmc
> get_cd op.
>

Sounds like a perfect plan!

Do you want to send a patch to the MAINTAINERS file?

>From my side I can also continue doing the administrative part of the
work, so there's need for you to set up a separate git tree or send
pull request. At least initially.
Instead I will just pick patches that's been acked by you (and
possibly Russell).

Kind regards
Uffe
