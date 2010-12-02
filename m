From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] mmci: supply per-instance regulator name
Date: Thu, 2 Dec 2010 14:23:48 +0100
Message-ID: <AANLkTikXAvjDOYETutyY7+3aRmWbv9roMHONscNZM-E-@mail.gmail.com>
References: <1291289707-5529-1-git-send-email-linus.walleij@stericsson.com>
	<20101202120318.GB3182@sirena.org.uk>
	<20101202122827.GG29347@n2100.arm.linux.org.uk>
	<20101202130809.GD859@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38889 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773Ab0LBNXu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2010 08:23:50 -0500
Received: by wwa36 with SMTP id 36so8720690wwa.1
        for <linux-mmc@vger.kernel.org>; Thu, 02 Dec 2010 05:23:48 -0800 (PST)
In-Reply-To: <20101202130809.GD859@rakim.wolfsonmicro.main>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2010/12/2 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Thu, Dec 02, 2010 at 12:28:27PM +0000, Russell King - ARM Linux wr=
ote:
>
>> The way the MMCI code is, it only requests one regulator per AMBA
>> device, and therefore only one regulator per struct device. =A0So I
>> don't think the current code needs changing in any way provided the
>> struct device is used to find the corresponding regulator.
>
> Hrm. =A0In that case I'm not sure what the problem Linus' patch fixes=
 is -
> the driver is already requesting using the struct device, I was assum=
ing
> that the supplies weren't being requested in a fine grained enough
> fashion.

Probably it's the platform board regulator config that needs fixing
instead, so as to bind to the correct device.
I'll check...

I'll do another patch that simply gets rid of the #ifdef for now
instead.

Thanks,
Linus Walleij
