From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: Possible bug in sdio.c?
Date: Sun, 29 May 2011 16:12:08 +0200
Message-ID: <20110529141208.GC8360@rere.qmqm.pl>
References: <4DE1A7B0.7000600@manipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:44380 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312Ab1E2OMM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 29 May 2011 10:12:12 -0400
Content-Disposition: inline
In-Reply-To: <4DE1A7B0.7000600@manipal.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prashanth Bhat <prashanth.bhat@manipal.net>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Sun, May 29, 2011 at 07:26:00AM +0530, Prashanth Bhat wrote:
> Hi Micha=B3,
> In mmc/core/sdio.c, routine mmc_enable_4bit_bus():
>=20
> I think:
>=20
>     if (card->type =3D=3D MMC_TYPE_SDIO)
>               return sdio_enable_wide(card);
>=20
> should really be:
>=20
>     if (card->type =3D=3D MMC_TYPE_SDIO || card->type =3D=3D MMC_TYPE=
_SD_COMBO )
>                return sdio_enable_wide(card);
>=20
> Otherwise, the SDIO component of the SD Combo card will not operate
> in wide mode. What do you think?
>=20
> Perhaps a similar change is needed in the sdio_enable_hs() routine to=
o.

Hi,

You sent similar problem report some time ago. I assumed you will follo=
w
on with a patch fixing mmc_card_sd() and friends (the functions you poi=
nt
out in this mail should use that).

Best Regards,
Micha=B3 Miros=B3aw
