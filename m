From: Michael Heimpold <mhei@heimpold.de>
Subject: Re: [Regression Resend] mmc: mx28: sd card detection broken since 3.18-rc1
Date: Tue, 04 Nov 2014 00:26:38 +0100
Message-ID: <2622508.LMF0YfKZGi@kerker>
References: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de> <8090335.0rPHov2cpK@kerker> <5457F8BD.1040800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5457F8BD.1040800@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Kristina =?utf-8?B?TWFydMWhZW5rbw==?= <kristina.martsenko@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Kristina,

Am Montag, 3. November 2014, 23:50:53 schrieb Kristina Mart=C5=A1enko:
> On 03/11/14 22:49, Michael Heimpold wrote:
> > Hi,
>=20
> Hi Michael,
>=20
> > Am Montag, 3. November 2014, 01:01:07 schrieben Sie:
> >> On 01/11/14 23:40, Stefan Wahren wrote:
> >>> Hi,
> >>>
> >>> i was testing Linux Kernel 3.18-rc2 with my i.MX28 board (I2SE Du=
ckbill) and ran
> >>> into the problem that the sd card isn't detected from the Kernel =
at booting
> >>> (driver: mxs-mmc.c). That results in a endless wait for the root =
partition
> >>
> >> I ran into this issue as well. Seems that a card-detect flag=20
> >> (MMC_CAP2_CD_ACTIVE_HIGH) can currently be set based on an=20
> >> uninitialized variable, which can lead to the card being reported =
as=20
> >> not present. This patch fixes it for me:
> >>
> >> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> >> index 03c53b72a2d6..f0e187682d3b 100644
> >> --- a/drivers/mmc/core/host.c
> >> +++ b/drivers/mmc/core/host.c
> >> @@ -311,7 +311,7 @@ int mmc_of_parse(struct mmc_host *host)
> >>  	struct device_node *np;
> >>  	u32 bus_width;
> >>  	int len, ret;
> >> -	bool cap_invert, gpio_invert;
> >> +	bool cap_invert, gpio_invert =3D false;
> >> =20
> >=20
> > sorry, but I don't understand how your patch fixes the problem.
> >=20
> > First use of the gpio_invert bool is in line 370/371 within mmc_gpi=
od_request_cd
> > (re-wrapped into a single line here for better reading):
> >=20
> > -snip-
> > ret =3D mmc_gpiod_request_cd(host, "cd", 0, true,  0, &gpio_invert)=
;
> > -snap-
> >=20
> > A pointer to the bool is passed, and inside mmc_gpiod_request_cd (d=
rivers/mmc/core/slot-gpio.c,
> > line 322), always a value is assigned:
> >=20
> > -snip-
> > if (gpio_invert)
> >                 *gpio_invert =3D !gpiod_is_active_low(desc);
> > -snap-
> >=20
> > So returning to mmc_of_parse, the bool should always have an initia=
lized value.
> > Apart from some error handling, the bool is used immediately in the=
 xor expression
> > and results in setting MMC_CAP2_CD_ACTIVE_HIGH bit, or not.
> >=20
> > I also cannot see a code path, where gpio_invert is used without a =
call to mmc_gpiod_request_cd.
> >=20
> > Would be nice, if you could point me to what I'm missing.
>=20
> mmc_gpiod_request_cd can return without ever reaching the line where=20
> the value is assigned to gpio_invert:
>=20
> desc =3D devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
> if (IS_ERR(desc))
> 	return PTR_ERR(desc);
>=20
> This can happen when the host controller doesn't use a GPIO for card=20
> detection (but instead uses a dedicated pin). In this case=20
> devm_gpiod_get_index will return -ENOENT.
>=20

ah, I see - thank you for taking the time to explain.

> >>  	if (!host->parent || !host->parent->of_node)
> >>  		return 0;
> >> @@ -401,6 +401,7 @@ int mmc_of_parse(struct mmc_host *host)
> >>  	else
> >>  		cap_invert =3D false;
> >> =20
> >> +	gpio_invert =3D false;
> >>  	ret =3D mmc_gpiod_request_ro(host, "wp", 0, false, 0, &gpio_inve=
rt);
> >=20
> > Same here. The functions always assigns a value when a pointer is g=
iven.
>=20
> Same thing, the function can return before gpio_invert is ever assign=
ed=20
> to.
>=20
> > (And this change is unrelated to the reporters problem, so should b=
e fixed with a
> > dedicated patch.)
>=20
> Since both flags are set wrong for the exact same reason, and they're=
=20
> both regressions in 3.18, I thought it would make sense to fix them=20
> both in one patch. (Especially since I think it's cleaner to split th=
e=20
> gpio_invert variable into cd_gpio_invert and ro_gpio_invert, and I wa=
s=20
> going to do that in the patch I'd send.) Let me know if you still thi=
nk=20
> I should send separate patches for them.
=20
Splitting the variable sounds good to me and will improve readability. =
In this case
(and with proper commit message) I think it's really possible to combin=
e both fixes
in one patch.

Thanks,
Michael

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
