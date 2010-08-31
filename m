From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] MMC: move regulator handling closer to core
Date: Tue, 31 Aug 2010 16:35:31 +0200
Message-ID: <AANLkTikQupSvmvcd92h6-pcuRM8keZRbU9g2bepq9NC-@mail.gmail.com>
References: <1283102159-25804-1-git-send-email-linus.walleij@stericsson.com>
	<4C7C1A2B.1010400@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C7C1A2B.1010400@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Mack <daniel@caiaq.de>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>, David Brownell <dbrownell@users.sourceforge.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>, Cliff Brake <cbrake@bec-systems.com>, "Lavinen Jarkko (Nokia-MS/Helsinki)" <jarkko.lavinen@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Tony Lindgren <tony@atomide.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Sundar Iyer <sundar.iyer@stericsson.com>, Bengt Jonsson <bengt.jonsson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

2010/8/30 Adrian Hunter <adrian.hunter@nokia.com>:

> [Me]
>> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
>> index 0a4e43f..47dae9b 100644
>> --- a/drivers/mmc/host/pxamci.c
>> +++ b/drivers/mmc/host/pxamci.c
>> @@ -99,14 +99,26 @@ static inline void pxamci_init_ocr(struct pxamci=
_host
>> *host)
>> =A0 =A0 =A0 =A0}
>> =A0}
>> =A0-static inline void pxamci_set_power(struct pxamci_host *host, un=
signed
>> int vdd)
>> +static inline void pxamci_set_power(struct pxamci_host *host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 unsigned char power_mode,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 unsigned int vdd)
>> =A0{
>> =A0 =A0 =A0 =A0int on;
>> =A0-#ifdef CONFIG_REGULATOR
>> - =A0 =A0 =A0 if (host->vcc)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_regulator_set_ocr(host->vcc, vdd);
>> -#endif
>> + =A0 =A0 =A0 if (host->vcc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (power_mode =3D=3D MMC_POWER_UP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_regulator_=
set_ocr(host->mmc, host->vcc,
>> vdd);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_er=
r(mmc_dev(host->mmc),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "could not set regulator OCR\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (power_mode =3D=3D MMC_POWER=
_OFF)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_regulator_=
set_ocr(host->mmc, host->vcc,
>> 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_er=
r(mmc_dev(host->mmc),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "could not disable regulator\n");
>> + =A0 =A0 =A0 }
>
> mmc_power_off() does set ios->vdd to 0 so the original code was fine
> wrt to ignoring power_mode.

Yeah I know. This bit was to increase readability, explicitly showing
the power state like this makes it more clear what is happening I think=
=2E

The rest of the comments are fixed, new patch soon.

Yours,
Linus Walleij
