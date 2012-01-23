From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] mmc: add workaround for fixed regulators
Date: Mon, 23 Jan 2012 23:26:09 +0900
Message-ID: <CAH9JG2XkbVsCzyfmiyBbzPTjNHgdpeuHobi7VwTW_YH14CyuCA@mail.gmail.com>
References: <1327312397-10176-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34647 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab2AWO0K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2012 09:26:10 -0500
Received: by qadc10 with SMTP id c10so1811718qad.19
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2012 06:26:09 -0800 (PST)
In-Reply-To: <1327312397-10176-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

Hi Marek,

I sent the patch same issue and get the Acked from Adrian.
http://permalink.gmane.org/gmane.linux.kernel.mmc/12206

Please see it.

Thank you,
Kyungmin Park

On Mon, Jan 23, 2012 at 6:53 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Voltage change errors should not be fatal to mmc subsystem. Some
> regulators don't support changing the supplied voltage values, while
> they can still be used for enabling and disabling the supply. This fi=
xes
> the regresion that appeared in sdhci driver after commit ceb6143b -
> erlier it worked fine with fixed gpio-based regulator.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0drivers/mmc/core/core.c | =A0 =A06 ++++++
> =A01 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index f545a3e..8726ae4 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1128,6 +1128,12 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D 0;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Some regulators don't support voltag=
e changes, so
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* assume that board designer used co=
rrect values
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result =3D=3D -EINVAL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D 0;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (result =3D=3D 0 && !mmc->regulator=
_enabled) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D regulator_e=
nable(supply);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!result)
> --
> 1.7.1.569.g6f426
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
