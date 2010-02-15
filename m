From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: tmio_mmc: Add MMC_CAP_MMC_HIGHSPEED support
Date: Mon, 15 Feb 2010 19:00:55 +0100
Message-ID: <63386a3d1002151000m77c9a02dhbcd626ff2a42b3ef@mail.gmail.com>
References: <4B790102.4050907@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:57934 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab0BOSHf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2010 13:07:35 -0500
Received: by bwz5 with SMTP id 5so1285697bwz.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Feb 2010 10:07:34 -0800 (PST)
In-Reply-To: <4B790102.4050907@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <goda.yusuke@renesas.com>
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org, Magnus Damm <magnus.damm@gmail.com>

2010/2/15 Yusuke Goda <goda.yusuke@renesas.com>:

> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 9cb1834..695199a 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -60,6 +60,7 @@ void tmio_core_mmc_clk_div(void __iomem *cnf, int s=
hift, int state);
> =A0*/
> =A0struct tmio_mmc_data {
> =A0 =A0 =A0 =A0const unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0hclk;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 cap_highspeed;

If this is really a bool, then declare it as a bool.

But isn't it better to be able to specify arbitary caps for the platfor=
m?
So make this an

unsigned long capabilities;

instead?  Else you will get in trouble the day you want to tag
on something else (like MMC_CAP_SD_HIGHSPEED), and it
doesn't make sense to extend the struct with bools for just about
everything.

Such a change would result in:

> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.=
c
> (...)
>        mmc->caps =3D MMC_CAP_4_BIT_DATA;
> +       if (pdata->cap_highspeed)
> +               mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED;

mmc->caps |=3D pdata->capabilities;

=2E.and then set .capabilities to MMC_CAP_MMC_HIGHSPEED in the
platform data.

Linus
