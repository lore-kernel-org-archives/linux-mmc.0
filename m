From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] mxcmmc: Add the ability to bind a regulator to manage the
 MMC card voltage
Date: Mon, 8 Nov 2010 23:12:01 +0100
Message-ID: <AANLkTi=oKHTmLS=xiNi9CJKttBGzMHjhZ3q_KWvi+xta@mail.gmail.com>
References: <1288656337.29881.13.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63634 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318Ab0KHWMC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2010 17:12:02 -0500
In-Reply-To: <1288656337.29881.13.camel@realization>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Daniel Mack <daniel@caiaq.de>, Andrew Morton <akpm@linux-foundation.org>, =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, Fabio Estevam <fabioestevam@yahoo.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

2010/11/2 Alberto Panizzo <maramaopercheseimorto@gmail.com>:

> +static inline void mxcmci_init_ocr(struct mxcmci_host *host)
> +{
> +#ifdef CONFIG_REGULATOR
> + =A0 =A0 =A0 host->vcc =3D regulator_get(mmc_dev(host->mmc), "vmmc")=
;
> +
> + =A0 =A0 =A0 if (IS_ERR(host->vcc)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->vcc =3D NULL;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->ocr_avail =3D mmc_regulator_=
get_ocrmask(host->vcc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->pdata && host->pdata->ocr_ava=
il)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(mmc_dev(host->=
mmc),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "pdata-=
>ocr_avail will not be used\n");
> + =A0 =A0 =A0 }
> +#endif

You don't need these #ifdef CONFIG_REGULATOR guardposts
anymore. I implemented stub functions for the ocrmask functions
for 2.6.37.

> +static inline void mxcmci_set_power(struct mxcmci_host *host, unsign=
ed int vdd)
> +{
> +#ifdef CONFIG_REGULATOR
> + =A0 =A0 =A0 if (host->vcc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_regulator_set_ocr(host->vcc, vdd);
> +#endif

Neither here.

But for both cases: no big deal. Take it the day it disturbs you :-)

Yours,
Linus Walleij
