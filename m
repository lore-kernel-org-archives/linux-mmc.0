From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/4] mmci: adjust calculation of f_min
Date: Thu, 7 Jul 2011 22:22:12 +0200
Message-ID: <CAKnu2MpxV3OkLqm9BwGz9VVOpEdSEsmzaPGOCY7CbKhrKcQqFw@mail.gmail.com>
References: <1309247853-17143-1-git-send-email-linus.walleij@stericsson.com>
	<20110705112049.GX8286@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43729 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab1GGUWO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2011 16:22:14 -0400
Received: by iyb12 with SMTP id 12so1183863iyb.19
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2011 13:22:12 -0700 (PDT)
In-Reply-To: <20110705112049.GX8286@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>

2011/7/5 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Jun 28, 2011 at 09:57:33AM +0200, Linus Walleij wrote:
>> From: Ulf Hansson <ulf.hansson@stericsson.com>
>>
>> For the st_clkdiv variant f_min is too low for practical cases,
>> there is a heuristic calculation that appear to set the min
>> frequency to mclk rounded up with 512, for our practical use
>> cases dividing by 257 gives a reasonable floor value on the
>> ST Micro version of the clock divider.
>
> The only requirement with f_min is that the hardware is capable of
> producing a clock at that rate. =A0Having it smaller than 'practical'
> is not a problem, and may help some cards be detected.

Sorry the changelog is confused. What we're doing is just obey
the maximum clockdivider as seen in mmci_set_clkreg().

It's host->cclk =3D host->mclk / (clk + 2); for the ST version, and
since the maximum divider in hardware is 255 this becomes
257, so we cannot divide the frequency with anything lower
than 257.

This should also be DIV_ROUND_UP() though, I'm fixing a new
patch.

> So unless there is a reason not to (eg, divisors above 257 are invali=
d)
> its better to leave it as is.

Above 257 is indeed invalid on ST variants, as above 512 is on
ARM variants.

Thanks,
Linus Walleij
