From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] MMC: move regulator handling closer to core v3
Date: Thu, 9 Sep 2010 09:03:17 +0200
Message-ID: <AANLkTinADjBaOcfdtGRZK0WdMs0xt+PLWGE7NUBndRr_@mail.gmail.com>
References: <1283677538-31121-1-git-send-email-linus.walleij@stericsson.com>
	<20100908155114.880463fc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60771 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab0IIHDT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Sep 2010 03:03:19 -0400
In-Reply-To: <20100908155114.880463fc.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@nokia.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Sundar Iyer <sundar.iyer@stericsson.com>, Daniel Mack <daniel@caiaq.de>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>, David Brownell <dbrownell@users.sourceforge.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>, Cliff Brake <cbrake@bec-systems.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2010/9/9 Andrew Morton <akpm@linux-foundation.org>:
> On Sun, =A05 Sep 2010 11:05:38 +0200
> Linus Walleij <linus.walleij@stericsson.com> wrote:
>> + =A0 =A0 if (host->vcc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (power_mode =3D=3D MMC_POWER_UP)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_regulator_set_=
ocr(host->mmc, host->vcc, vdd);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (power_mode =3D=3D MMC_POWER_OFF)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_regulator_set_=
ocr(host->mmc, host->vcc, 0);
>> + =A0 =A0 }
>
> There's no point in copying the return value into a local then ignori=
ng
> it. =A0mmc_regulator_set_ocr() can return a negative errno so we shou=
ld
> test for that, clean up and propagate the error.

OK I'll fix.

> The same comments apply to mmci_set_ios().

OK.

Yours,
Linus Walleij
