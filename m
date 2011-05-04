From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] mmc: mmc_add_card(): fix missing break in switch
 statement
Date: Wed, 4 May 2011 13:23:05 +0200
Message-ID: <20110504112305.GC15486@rere.qmqm.pl>
References: <20110409061647.D5DAE13909@rere.qmqm.pl>
 <4DBFE514.3050801@manipal.net>
 <4DBFE73B.8010609@manipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:39950 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718Ab1EDLXH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 May 2011 07:23:07 -0400
Content-Disposition: inline
In-Reply-To: <4DBFE73B.8010609@manipal.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prashanth Bhat <prashanth.bhat@manipal.net>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, May 03, 2011 at 05:00:03PM +0530, Prashanth Bhat wrote:
> To be more specific, I would think that the code change required in
> include/linux/mmc/card.h is:
>=20
> #define mmc_card_mmc(c)         ((c)->type =3D=3D MMC_TYPE_MMC)
> - #define mmc_card_sd(c)          ((c)->type =3D=3D MMC_TYPE_SD)
> - #define mmc_card_sdio(c)        ((c)->type =3D=3D MMC_TYPE_SDIO)
>=20
> + #define mmc_card_sd(c)          ((c)->type =3D=3D MMC_TYPE_SD ||
> (c)->type =3D=3D MMC_TYPE_SD_COMBO)
> + #define mmc_card_sdio(c)        ((c)->type =3D=3D MMC_TYPE_SDIO ||
> (c)->type =3D=3D MMC_TYPE_SD_COMBO)

You can actually use (c->type & MMC_TYPE_SD) and (c->type & MMC_TYPE_SD=
IO).
Unless there will be more types of SD cards (unlikely) this way
will generate less code on average.

Best Regards,
Micha=B3 Miros=B3aw
