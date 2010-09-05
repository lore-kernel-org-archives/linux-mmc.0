From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] MMC: move regulator handling closer to core v2
Date: Sun, 5 Sep 2010 11:05:33 +0200
Message-ID: <AANLkTi=n=h=00QM-Tgy_3E425f+ZeTEkF=mfnUpt1+vS@mail.gmail.com>
References: <1283268367-3525-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTik-uLMUz2g2znaF0K43D8CONsGdjrRqxTCqpS_X@mail.gmail.com>
	<4C81E2CF.8070406@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C81E2CF.8070406@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Sundar Iyer <sundar.iyer@stericsson.com>, Daniel Mack <daniel@caiaq.de>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>, David Brownell <dbrownell@users.sourceforge.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>, Cliff Brake <cbrake@bec-systems.com>, "Lavinen Jarkko (Nokia-MS/Helsinki)" <jarkko.lavinen@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

2010/9/4 Adrian Hunter <adrian.hunter@nokia.com>:

> One of our contractors had a look at the patch and had this comment:
>
> One comment/question:
> /host/mmci.c in function
> "static int __devexit mmci_remove(struct amba_device *dev)" there is =
code:
> =A0 =A0 =A0 =A0if (regulator_is_enabled(host->vcc))
> =A0 =A0 =A0 =A0 =A0 =A0regulator_disable(host->vcc);
> should "ret =3D mmc_regulator_set_ocr(mmc, host->vcc, 0);" be added h=
ere?

Good catch!

Since it's in the remove() we can't do much about the return value from=
 that
call but we should sure use the _set_ocr() so fixed it and pushed v3.

Yours,
Linus Walleij
