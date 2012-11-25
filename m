From: Daniel Drake <dsd@laptop.org>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Sun, 25 Nov 2012 12:22:09 -0600
Message-ID: <CAMLZHHTw=3mEigjQRcSZH3Lfo1npDY02icLO5i0eEGHJDwtRkA@mail.gmail.com>
References: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
	<CA+20K0CQmFHNruQv5-7D=2kxqxp=Vt1h2rXXuKF0-JOm8jyoJQ@mail.gmail.com>
	<CAMLZHHRAq7NHrDeA6d3JLsALGgVgfBxL8Y=DMNCLSDvFOFVw2Q@mail.gmail.com>
	<CA+20K0Cfmpe46S8pS2QOn4ac0x=Uab0MsDHX_=SSraaqyA1c3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61829 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab2KYSWK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Nov 2012 13:22:10 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4503491pad.19
        for <linux-mmc@vger.kernel.org>; Sun, 25 Nov 2012 10:22:10 -0800 (PST)
In-Reply-To: <CA+20K0Cfmpe46S8pS2QOn4ac0x=Uab0MsDHX_=SSraaqyA1c3A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Nov 20, 2012 at 2:53 AM, Johan Rudholm <jrudholm@gmail.com> wrote:
>> On the other hand, we may have a good basis to add a quirk, triggered
>> by the device tree, for when the hardware physically does not have
>> 1.8v capabilities.
>
> This also seems proper, if we know we can't get 1.8V, then we
> shouldn't even try for it. In this way the detection will also be
> faster (no 10 retries).

I've gone for this approach in the patches just posted.
    sdhci: add quirk for lack of 1.8v support
    mmc: add no-1-8-v device tree flag

>> If this is the case, the driver could have another heuristic: if there
>> is no vmmc regulator, there is no way of cutting the card power,
>> therefore we could avoid even trying 1.8v on the basis that we know we
>> can't recover if things go wrong.
>
> So the driver could for instance drop the MMC_CAP_UHS_DDR50 cap if
> there is no way to power cycle the card? I think that sounds
> reasonable and according to spec, although also a little bit hard
> since there probably are cards out there that never require a power
> cycle to perform a proper voltage switch?

Thats true, and actually, after some more investigation it doesn't
seem like we have a solid basis to add such behaviour. It looks like
whether or not the voltage supply is supplied by the same chip that
provides the SDHCI interface, or whether it is a purely external
factor, varies from board to board. So we can't assume a lack of
regulator means a lack of ability to switch voltages.

Thanks
Daniel
