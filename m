From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] mmc: move regulator handling to core
Date: Sun, 29 Aug 2010 17:30:48 +0200
Message-ID: <AANLkTim+cOSt=kjXXh_w+b4mzCiZN76HQ3az7SJKmOxR@mail.gmail.com>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
	<20100827190306.GB20407@void.printf.net>
	<AANLkTi=20KrUy334JRmMYwK7rbaVYrYCqW-BHZYGPrwT@mail.gmail.com>
	<20100829132711.GB10233@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52748 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab0H2Pat convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Aug 2010 11:30:49 -0400
In-Reply-To: <20100829132711.GB10233@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Chris Ball <cjb@laptop.org>, Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Pierre Ossman <pierre@ossman.eu>, Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, Adrian Hunter <adrian.hunter@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Cliff Brake <cbrake@bec-systems.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Madhusudhan <madhu.cr@ti.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2010/8/29 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Sat, Aug 28, 2010 at 04:48:58PM +0200, Linus Walleij wrote:
>> 2010/8/27 Chris Ball <cjb@laptop.org>:
>
>> > Looks like this patch got dropped because of the missing modificat=
ions
>> > to arch/arm/mach-omap2/mmc-twl4030.c. =A0Are we still interested i=
n the
>> > patch otherwise, and can anyone help with that?
>
>> Actually just before the summer I submitted something not quite simi=
lar:
>> I moved all regulator handling *out* of the MMC core because I didn'=
t
>> trust the way reference counting was being handled.
>
> This seems like the wrong approach; if there's a problem it'd seem mu=
ch
> better to fix the core code that everything is sharing rather than
> factor it out - the location of the code is orthogonal to its
> helpfulness.

I actually did not move the essential regulator bits out just enable/di=
sable,
so that these were in the sites where the regulators were actually
enabled/disabled in respective driver. That makes the internal
regulator reference count do the trick.

I can get that patch into shape easily, if for nothing else it's a nice
discussion item.

Yours,
Linus Walleij
