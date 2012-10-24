From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Power cycle card on voltage switch fail
Date: Wed, 24 Oct 2012 12:56:42 +0200
Message-ID: <CA+20K0BQD51dQCLxQhzU+A5-Pt5Jg76HoTjOAm7GBgq4DwqW6Q@mail.gmail.com>
References: <1348166542-3247-1-git-send-email-johan.rudholm@stericsson.com>
	<87bofsj52p.fsf@octavius.laptop.org>
	<CAMLZHHRdz-==wgqvkoest61eaAdSHWTA0x-JTBgLWdO3B2gKJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45794 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758162Ab2JXK4m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Oct 2012 06:56:42 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so415105iea.19
        for <linux-mmc@vger.kernel.org>; Wed, 24 Oct 2012 03:56:42 -0700 (PDT)
In-Reply-To: <CAMLZHHRdz-==wgqvkoest61eaAdSHWTA0x-JTBgLWdO3B2gKJQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi Chris and Daniel,

Chris: Thank you for commenting on this patch! Yes, the sdhci power
cycle code needs to be removed just as Daniel's patch does, and as I
suggested in another patch: [RFC] mmc: sdhci: Let core handle UHS
switch failure (https://patchwork.kernel.org/patch/1517211/).

Daniel: Thank you for testing the patch! Comments below.

2012/10/24 Daniel Drake <dsd@laptop.org>:
> On Tue, Oct 23, 2012 at 2:39 PM, Chris Ball <cjb@laptop.org> wrote:
>> Dan, maybe you could see if this patch (there's a 1/2 patch too) solves
>> your UHS problem?
>
> I tested [RFC/PATCH] mmc: core: Fixup signal voltage switch
> https://patchwork.kernel.org/patch/1514691/
>
> This was previously failing on both XO-1.75 (kernel 3.0) and XO-4
> (kernel 3.5) - the 1.8V switch would fail, but it would not
> successfully switch back to 3.3V.

Can you enlighten me a bit; what is XO? :) Host controller hardware?

> Testing on XO-4, it worked fine: the 1.8V failed switch was detected,
> it came back as 3.3V and everything was fine.

Ok, so since you didn't have the card_busy function at this point, the
failure was detected by the sdhci code, right? It power-cycles the
card, returns -EAGAIN, the new code in mmc_sd_get_cid will try 10
times and then come back to 3.3V. Is this what happened, did you get
this print?

                pr_warning("%s: Skipping voltage switch\n",
                        mmc_hostname(host));

> Testing on XO-1.75, it didn't work: it thought that the 1.8V switch
> was successful so it left it at that, then the card reacted in a very
> unstable manner (failed/retried reads, huge amount of kernel log spam,
> etc).

This points to that the way of checking if the card is busy or not may
not work on XO-1.75? But then it seems strange that the card was
semi-usable...

> So I came up with the attached sdhci patch. That fixes the XO-1.75
> case, which now correctly detects the 1.8V switch failure and goes to
> 3.3V. However, that broke XO-4, which now just does:
>   mmc2: Signal voltage switch failed, power cycling card (retries = 10)
>   mmc2: error -110 whilst initialising SD card
> (no more time to debug exactly whats happening)

Ok, so failure is detected in mmc_set_signal_voltage by your card_busy
function, good. Then the card is power cycled, and should be
initialized again, but this fails, it's probably mmc_send_app_op_cond
which returns -110. Maybe the power cycle fails?

So the strange thing here is that on kernel 3.5, without my patch,
1.8V switch fails and fall-back to 3.3V fails. With my patch, 1.8V
fails and fall-back to 3.3V succeeds. But, when we move the detection
and error-handling to my patch (the upper layer), the fall-back fails.

I'm thinking of a couple of things that could have gone wrong here...
If you used v2 of the patch, is assumes that the signal voltage is
reset to 3.30 V in mmc_power_up, but this was introduced quite
recently, in v3.6 (mmc: core: reset signal voltage on power up), but
you used v1, right? So then there are at least two other differences:

1) The way the card is power cycled.
    sdhci toggles the SDHCI_POWER_ON bit in SDHCI_POWER_CONTROL, but
my patch calls mmc_power_off / mmc_power_up.
    Do you know if mmc_power_off / up is a good way to power-cycle the card?

2) The way the clock is stopped.
    sdhci clears SDHCI_CLOCK_CARD_EN in SDHCI_CLOCK_CONTROL, my patch
sets ios.clock = 0 and calls mmc_set_ios.
    But maybe this is not the issue, since the 1.8V switch fails in all cases.

I don't really know how to proceed. Do you have the complete dmesgs
from the 3.5 kernel: with my patch and without your patch + with my
patch and with your patch? With these I could try to do a deeper
analysis.

By the way, in your patch
0001-update-sdhci-for-voltage-changing-fixes.txt you don't check if
the signal voltage switch succeeds electrically:

                        ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
                        if (ctrl & SDHCI_CTRL_VDD_180) {

but maybe we can assume that this will be fine after the delay of 5 ms
in mmc_set_signal_voltage? Also in sdhci_card_busy you don't do
runtime_pm_get before you check the busy status, but since the busy
check returns busy, perhaps this is not the issue here either.

> All tests with the same 32GB SD storage card.
>
> I wonder if this difference in behaviour is related to the difference
> in kernel versions on each platform (3.0 vs 3.5). I would like to test
> with 3.5 or newer running on both, but this requires a bit of setup
> work for the XO-1.75 first (long story). And I'm out of time at this
> point :( this was a borrowed SD card.

Ok, I hope you'll be able to get time and SD-card in the future. :)
Btw, what brand was the SD-card?

Kind regards, Johan
