From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] mmc: mmc_add_card(): fix missing break in switch
 statement
Date: Wed, 4 May 2011 18:42:45 +0200
Message-ID: <20110504164245.GA7152@rere.qmqm.pl>
References: <20110409061647.D5DAE13909@rere.qmqm.pl>
 <4DBFE514.3050801@manipal.net>
 <4DBFE73B.8010609@manipal.net>
 <20110504112305.GC15486@rere.qmqm.pl>
 <4DC18084.8060905@manipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:34951 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab1EDQmq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 May 2011 12:42:46 -0400
Content-Disposition: inline
In-Reply-To: <4DC18084.8060905@manipal.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prashanth Bhat <prashanth.bhat@manipal.net>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, May 04, 2011 at 10:06:20PM +0530, Prashanth Bhat wrote:
> On Wednesday 04 May 2011 04:53 PM, Micha=B3 Miros=B3aw wrote:
> >On Tue, May 03, 2011 at 05:00:03PM +0530, Prashanth Bhat wrote:
> >>To be more specific, I would think that the code change required in
> >>include/linux/mmc/card.h is:
> >>
> >>#define mmc_card_mmc(c)         ((c)->type =3D=3D MMC_TYPE_MMC)
> >>- #define mmc_card_sd(c)          ((c)->type =3D=3D MMC_TYPE_SD)
> >>- #define mmc_card_sdio(c)        ((c)->type =3D=3D MMC_TYPE_SDIO)
> >>
> >>+ #define mmc_card_sd(c)          ((c)->type =3D=3D MMC_TYPE_SD ||
> >>(c)->type =3D=3D MMC_TYPE_SD_COMBO)
> >>+ #define mmc_card_sdio(c)        ((c)->type =3D=3D MMC_TYPE_SDIO |=
|
> >>(c)->type =3D=3D MMC_TYPE_SD_COMBO)
> >You can actually use (c->type&  MMC_TYPE_SD) and (c->type&  MMC_TYPE=
_SDIO).
> >Unless there will be more types of SD cards (unlikely) this way
> >will generate less code on average.
> Interesting coincidence that the value of MMC_TYPE_SD and
> MMC_TYPE_SDIO and MMC_TYPE_SD_COMBO have the relationship that
> SD_COMBO is the bitwise OR of the other two. However, this seems to
> be more of a coincidence than intentional. The #defines were clearly
> meant to be numeric values rather than bit-masks.
>=20
> #define MMC_TYPE_MMC            0               /* MMC card */
> #define MMC_TYPE_SD             1               /* SD card */
> #define MMC_TYPE_SDIO           2               /* SDIO card */
> #define MMC_TYPE_SD_COMBO       3               /* SD combo (IO+mem) =
card */
>=20
>=20
> Using the bit-mask approach therefore doesn't feel like the natural
> way to me. Perhaps the #defines could be changed to
>=20
> #define MMC_TYPE_MMC            (1 << 0)               /* MMC card */
> #define MMC_TYPE_SD               (1 << 1)               /* SD card *=
/
> #define MMC_TYPE_SDIO            (1 << 2)               /* SDIO card =
*/
> #define MMC_TYPE_SD_COMBO       (MMC_TYPE_SD | MMC_TYPE_SDIO)    /*
> SD combo (IO+mem) card */

Since MMC =3D=3D !SD && !SDIO, then MMC_TYPE_MMC bit would carry redund=
ant
information.

Best Regards,
Micha=B3 Miros=B3aw

PS. Please do not top-post.
