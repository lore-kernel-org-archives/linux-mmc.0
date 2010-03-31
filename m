From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH] libertas/sdio: set ECSI and SCSI bits for 1-bit transfers
Date: Wed, 31 Mar 2010 11:07:06 +0200
Message-ID: <x2ve2d7436a1003310207t16a7d1d6r7853de2dfa647c6c@mail.gmail.com>
References: <1269970733-24681-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:44723 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757209Ab0CaJHI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2010 05:07:08 -0400
In-Reply-To: <1269970733-24681-1-git-send-email-daniel@caiaq.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-kernel@vger.kernel.org, Alagu Sankar <alagusankar@embwise.com>, Volker Ernst <volker.ernst@txtr.com>, Dan Williams <dcbw@redhat.com>, "John W. Linville" <linville@tuxdriver.com>, Holger Schurig <hs4233@mail.mn-solutions.de>, Bing Zhao <bzhao@marvell.com>, libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org

2010/3/30 Daniel Mack <daniel@caiaq.de>:
[...]
> @@ -1022,6 +1025,27 @@ static int if_sdio_probe(struct sdio_func *fun=
c,
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto disable;
>
> + =A0 =A0 =A0 /* For 1-bit transfers, we need to enable the interrupt=
 flags in
> + =A0 =A0 =A0 =A0* the CCCR register. Temporarily set the function nu=
mber to 0
> + =A0 =A0 =A0 =A0* for that. */
> + =A0 =A0 =A0 if ((host->caps & MMC_CAP_SDIO_IRQ) &&
> + =A0 =A0 =A0 =A0 =A0 (host->ios.bus_width =3D=3D MMC_BUS_WIDTH_1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int num =3D func->num;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 reg;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 func->num =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D sdio_readb(func, SDIO_CCCR_IF, =
&ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto release_int;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D SDIO_BUS_ECSI | SDIO_BUS_SCSI;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdio_writeb(func, reg, SDIO_CCCR_IF, &r=
et);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto release_int;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 func->num =3D num;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0card->ioport =3D sdio_readb(func, IF_SDIO_IOPORT, &ret=
);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto release_int;

You should probably just use mmc_io_rw_direct() in this case instead
of abusing func->num.

Best Regards,
Micha=B3 Miros=B3aw
