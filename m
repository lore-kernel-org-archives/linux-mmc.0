From: Prashanth Bhat <prashanth.bhat@manipal.net>
Subject: Re: [PATCH] mmc: mmc_add_card(): fix missing break in switch statement
Date: Tue, 03 May 2011 16:50:52 +0530
Message-ID: <4DBFE514.3050801@manipal.net>
References: <20110409061647.D5DAE13909@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:48665
	"HELO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752520Ab1ECL2F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 May 2011 07:28:05 -0400
In-Reply-To: <20110409061647.D5DAE13909@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Michal,

I hope you remember the email exchange we had about a month ago. I thin=
k=20
I see an issue with SD-COMBO support.

In include/linux/mmc/card.h, there are macros:

> #define mmc_card_mmc(c)         ((c)->type =3D=3D MMC_TYPE_MMC)
> #define mmc_card_sd(c)          ((c)->type =3D=3D MMC_TYPE_SD)
> #define mmc_card_sdio(c)        ((c)->type =3D=3D MMC_TYPE_SDIO)

In particular, the mmc_card_sd(c) is invoked in many places, to=20
determine whether the card is SD, and certain action is taken. Shouldn'=
t=20
the same be done for Combo cards, because these also have SD on them?

=46or instance, in drivers/mmc/core/core.c, routine=20
mmc_set_data_timeout(), there is a call to mmc_card_sd(c).
Also, in drivers/mmc/card/block.c, routine mmc_blk_alloc().

I would appreciate your opinion on this.

Thanks,
Prashanth


On Saturday 09 April 2011 11:46 AM, Micha=C5=82 Miros=C5=82aw wrote:
> Fixes a cosmetic bug that affects printk() for SD-combo cards.
>
> Noticed-by: Prashanth Bhat<prashanth.bhat@manipal.net>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw<mirq-linux@rere.qmqm.pl>
> ---
>   drivers/mmc/core/bus.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 63667a8..d6d62fd 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -284,6 +284,7 @@ int mmc_add_card(struct mmc_card *card)
>   		type =3D "SD-combo";
>   		if (mmc_card_blockaddr(card))
>   			type =3D "SDHC-combo";
> +		break;
>   	default:
>   		type =3D "?";
>   		break;
>   =20

