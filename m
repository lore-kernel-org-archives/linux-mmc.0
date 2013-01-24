From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Thu, 24 Jan 2013 13:48:39 +0100
Message-ID: <CAPDyKFpc3GZd0Zr4TcGBX_cobJLXFJzr+LAO5Z6TEJu2_26ekA@mail.gmail.com>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
	<CAPDyKFpOd3abjoYyrOeV=i+VRwUqisMwJe8_33j0G7zcd5r6Eg@mail.gmail.com>
	<1359030968.26878.46.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:48159 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab3AXMsl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jan 2013 07:48:41 -0500
Received: by mail-lb0-f182.google.com with SMTP id gg6so6445303lbb.13
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jan 2013 04:48:40 -0800 (PST)
In-Reply-To: <1359030968.26878.46.camel@hornet>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Pawel,

On 24 January 2013 13:36, Pawel Moll <pawel.moll@arm.com> wrote:
> Hello Ulf,
>
> On Fri, 2012-12-21 at 11:05 +0000, Ulf Hansson wrote:
>> On 14 December 2012 16:38, Pawel Moll <pawel.moll@arm.com> wrote:
>> > The Versatile Express IOFPGA as shipped on VECD 5.0 (bitfiles v108/208
>> > and v116/216) contains a modified version of the PL180 MMCI, with
>> > PeriphID Configuration value changed to 0x2.
>> >
>> > This version adds an optional "hardware flow control" feature. When
>> > enabled MMC card clock will be automatically disabled when FIFO is
>> > about to over/underflow and re-enabled once the host retrieved some
>> > data. This makes the controller immune to over/underrun errors caused
>> > by big interrupt handling latencies.
>> >
>> > This patch adds relevant device variant in the driver.
>> >
>> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
>
>> So enabling this in the variant will also effect how the clock is
>> being set/gated when the clock freq is 0.
>>
>> Please have a look at "mmc: mmci: Gate the clock when freq is 0", a
>> patch I sent out as of 12 dec.
>> That patch is using the power register to gate the clock. Will that
>> work with this new version of the PL180 as well? If not, that patch
>> must be reworked.
>
> I'm not quite sure what you meant here, but I see that v2 of your patch
> does whatever it is supposed to do to ST variants only, so I guess your
> objections don't apply any more?

Correct. ST-variants requires to use the POWER register to gate the
clock. So if this is not the case for VE you don't need to bother,
otherwise you should set "pwrreg_clkgate" for this variant as well.

Kind regards
Ulf Hansson
