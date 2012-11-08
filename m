From: Daniel Drake <dsd@laptop.org>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Thu, 8 Nov 2012 11:48:22 -0600
Message-ID: <CAMLZHHTYFStTkY9Niyb0AKo_Nfeb2WyNEDSo5kt5tfzrNyUrUQ@mail.gmail.com>
References: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
	<CA+20K0CQmFHNruQv5-7D=2kxqxp=Vt1h2rXXuKF0-JOm8jyoJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46419 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260Ab2KHRsW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Nov 2012 12:48:22 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so2203109pbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 08 Nov 2012 09:48:22 -0800 (PST)
In-Reply-To: <CA+20K0CQmFHNruQv5-7D=2kxqxp=Vt1h2rXXuKF0-JOm8jyoJQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Nov 2, 2012 at 8:35 AM, Johan Rudholm <jrudholm@gmail.com> wrot=
e:
> An initial question, would it be possible to solve this by disabling
> the UHS support in the host cap, or through a quirk? Maybe this kind
> of solution is not applicable in this scenario? I wonder this because
> I guess it will be very hard to know how a card will react if we firs=
t
> tell it that we're going to switch voltages and then don't, since thi=
s
> is out of spec.

That would definitely be possible.

I'm not convinced this is outside the spec - the spec talks heavily
about power cycling, which you would  think would handle such cases
(i.e. a full state reset). However, I think I have generated enough
evidence in my last mail to show that we are not able to fully power
cycle, giving further support for some kind of quirk.

> Good question. I=92d guess that mmc_power_off/up does not work as
> expected here, that the card is not at all power cycled. But it seems
> that the power cycle code in sdhci_do_start_signal_voltage_switch
> works? What if we export a couple of debug functions from sdhci.c
> which allow us to power cycle and control the clock just like sdhci
> does, and call these functions from core.c and sd.c? If this works
> (and the failure is detected properly by the core layer, and 10
> retries are made etc), then we know that the problems most likely
> depend on how mmc_set_ios and mmc_power_off/up work with sdhci. I've
> attached a patch suggesting this, if you'd like to give it a try
> (warning: the patch has not been tested). The patch does not do
> anything about pm_runtime, but perhaps we don't need to worry about
> this here.

Your patch fixes the detection that the voltage switch has failed.

It doesn't fix the reset though - it still returns the -110 error
after trying to power cycle.

I mentioned in an earlier mail that we had this working in 3.0. I went
back to that configuration to investigate. Actually, it is maybe only
reliable 50% of the time - the other 50% we get the same error. When
it does work, here's what happens:

- mmc_rescan_try_freq is called to try the 400khz frequency
- in mmc_sd_get_cid(), rocr has value  c1ff8000, so we try the 1.8
switch, this fails
- we go back to 3.3v, then we receive the -110 timeout error immediatel=
y after
- mmc_rescan_try_freq is called to try the 300khz frequency
- the card is now alive for some reason
- in mmc_sd_get_cid(), rocr has value  c0ff8000, so we stick at 3.3V

Rather odd. It seems that 3.0 is more successful at power cycling the
card than 3.5, but it is far from reliable. It also appears that the
card I have here might have some logic to realise that 1.8V failed so
then it stops advertising the capability?

Anyway, with all the unreliability, unknowns, and power cycle
difficulty, I guess we should go for the quirk approach.
Do you have any suggestions for how this should be implemented? Should
I go for a new SDHCI quirk triggered by a new "sdhci,disable-1-8v"
device tree property?

Thanks
Daniel
