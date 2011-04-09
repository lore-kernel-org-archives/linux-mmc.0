From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mmc_add_card(): fix missing break in switch statement
Date: Sat, 09 Apr 2011 10:08:44 -0400
Message-ID: <m3bp0fldoz.fsf@pullcord.laptop.org>
References: <20110409061647.D5DAE13909@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44776 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754098Ab1DIODm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Apr 2011 10:03:42 -0400
In-Reply-To: <20110409061647.D5DAE13909@rere.qmqm.pl> (=?utf-8?Q?=22Micha?=
 =?utf-8?Q?=C5=82_Miros=C5=82aw=22's?=
	message of "Sat, 9 Apr 2011 08:16:47 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: linux-mmc@vger.kernel.org, Prashanth Bhat <prashanth.bhat@manipal.net>

Hi,

On Sat, Apr 09 2011, Micha=C5=82 Miros=C5=82aw wrote:
> Fixes a cosmetic bug that affects printk() for SD-combo cards.
>
> Noticed-by: Prashanth Bhat <prashanth.bhat@manipal.net>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mmc/core/bus.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 63667a8..d6d62fd 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -284,6 +284,7 @@ int mmc_add_card(struct mmc_card *card)
>  		type =3D "SD-combo";
>  		if (mmc_card_blockaddr(card))
>  			type =3D "SDHC-combo";
> +		break;
>  	default:
>  		type =3D "?";
>  		break;

Thanks, pushed to mmc-next for .40.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
