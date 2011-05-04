From: Prashanth Bhat <prashanth.bhat@manipal.net>
Subject: Re: [PATCH] mmc: mmc_add_card(): fix missing break in switch statement
Date: Wed, 04 May 2011 22:06:20 +0530
Message-ID: <4DC18084.8060905@manipal.net>
References: <20110409061647.D5DAE13909@rere.qmqm.pl> <4DBFE514.3050801@manipal.net> <4DBFE73B.8010609@manipal.net> <20110504112305.GC15486@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from p3plsmtpa07-01.prod.phx3.secureserver.net ([173.201.192.230]:43546
	"HELO p3plsmtpa07-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751354Ab1EDQg4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2011 12:36:56 -0400
In-Reply-To: <20110504112305.GC15486@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Interesting coincidence that the value of MMC_TYPE_SD and MMC_TYPE_SDIO=
=20
and MMC_TYPE_SD_COMBO have the relationship that SD_COMBO is the bitwis=
e=20
OR of the other two. However, this seems to be more of a coincidence=20
than intentional. The #defines were clearly meant to be numeric values=20
rather than bit-masks.

#define MMC_TYPE_MMC            0               /* MMC card */
#define MMC_TYPE_SD             1               /* SD card */
#define MMC_TYPE_SDIO           2               /* SDIO card */
#define MMC_TYPE_SD_COMBO       3               /* SD combo (IO+mem) ca=
rd */


Using the bit-mask approach therefore doesn't feel like the natural way=
=20
to me. Perhaps the #defines could be changed to

#define MMC_TYPE_MMC            (1 << 0)               /* MMC card */
#define MMC_TYPE_SD               (1 << 1)               /* SD card */
#define MMC_TYPE_SDIO            (1 << 2)               /* SDIO card */
#define MMC_TYPE_SD_COMBO       (MMC_TYPE_SD | MMC_TYPE_SDIO)    /* SD=20
combo (IO+mem) card */

Thanks,
Prashanth

On Wednesday 04 May 2011 04:53 PM, Micha=B3 Miros=B3aw wrote:
> On Tue, May 03, 2011 at 05:00:03PM +0530, Prashanth Bhat wrote:
>   =20
>> To be more specific, I would think that the code change required in
>> include/linux/mmc/card.h is:
>>
>> #define mmc_card_mmc(c)         ((c)->type =3D=3D MMC_TYPE_MMC)
>> - #define mmc_card_sd(c)          ((c)->type =3D=3D MMC_TYPE_SD)
>> - #define mmc_card_sdio(c)        ((c)->type =3D=3D MMC_TYPE_SDIO)
>>
>> + #define mmc_card_sd(c)          ((c)->type =3D=3D MMC_TYPE_SD ||
>> (c)->type =3D=3D MMC_TYPE_SD_COMBO)
>> + #define mmc_card_sdio(c)        ((c)->type =3D=3D MMC_TYPE_SDIO ||
>> (c)->type =3D=3D MMC_TYPE_SD_COMBO)
>>     =20
> You can actually use (c->type&  MMC_TYPE_SD) and (c->type&  MMC_TYPE_=
SDIO).
> Unless there will be more types of SD cards (unlikely) this way
> will generate less code on average.
>
> Best Regards,
> Micha=B3 Miros=B3aw
>
>
>   =20

