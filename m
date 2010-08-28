From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] mmc: move regulator handling to core
Date: Sat, 28 Aug 2010 16:48:58 +0200
Message-ID: <AANLkTi=20KrUy334JRmMYwK7rbaVYrYCqW-BHZYGPrwT@mail.gmail.com>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
	<20100827190306.GB20407@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37162 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab0H1Os7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Aug 2010 10:48:59 -0400
In-Reply-To: <20100827190306.GB20407@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Pierre Ossman <pierre@ossman.eu>, Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, Adrian Hunter <adrian.hunter@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Cliff Brake <cbrake@bec-systems.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Madhusudhan <madhu.cr@ti.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2010/8/27 Chris Ball <cjb@laptop.org>:

> Looks like this patch got dropped because of the missing modification=
s
> to arch/arm/mach-omap2/mmc-twl4030.c. =A0Are we still interested in t=
he
> patch otherwise, and can anyone help with that?

Actually just before the summer I submitted something not quite similar=
:
I moved all regulator handling *out* of the MMC core because I didn't
trust the way reference counting was being handled.

There is something very disturbing about this code from
regulator/core/core.c mmc_regulator_set_ocr():

enabled =3D regulator_is_enabled(supply);
if (enabled < 0)
	return enabled;

if (...) {
	(...)
	voltage =3D regulator_get_voltage(supply);
	if (voltage < 0)
		result =3D voltage;
	else if (voltage < min_uV || voltage > max_uV)
		result =3D regulator_set_voltage(supply, min_uV, max_uV);
	else
		result =3D 0;

	if (result =3D=3D 0 && !enabled)
		result =3D regulator_enable(supply);
} else if (enabled) {
	result =3D regulator_disable(supply);
}

I didn't realize until today where the problem is: if you have
two hosts on the same regulator this does not handle
concurrency correctly. There is no lock taken between reading
the enabled status and acting on it later in the code.

So it looks to me like it is possible for one slot to enable the
regulator and race with another slot which disables it at the
same time and end up with the regulator disabled :-(

My solution would still be to move the enable/disable out
of the core, so I need to follow up on that.

This old patch however, goes in the opposite direction,
moving it all into the core. If you do this, please fix the
concurrency issue also...

Yours,
Linus Walleij
