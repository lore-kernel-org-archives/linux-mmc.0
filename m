From: Zhang Haijun <b42677@freescale.com>
Subject: Re: [PATCH 1/5] mmc:core: Add restrictions for data transfer and
 card ease
Date: Mon, 21 Oct 2013 17:18:25 +0800
Message-ID: <5264F161.5010203@freescale.com>
References: <1380010339-25446-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [213.199.154.249] ([213.199.154.249]:48788 "EHLO
	db9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753966Ab3JUJVO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Oct 2013 05:21:14 -0400
In-Reply-To: <1380010339-25446-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc@vger.kernel.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, ulf.hansson@linaro.org

Hi, all

Could any one help review this patch set for me?

Thanks in advance.

=D3=DA 2013/9/24 16:12, Haijun Zhang =D0=B4=B5=C0:
> At 50 Mhz SD_CLK period,
> the max timeout value =3D 2^27 * SD_CLK period ~=3D 2.69 sec.
>
> If max_discard_to was not designed, for mmc card preferred erase
> size should be used, for sd card just return UINT_MAX. Also add
> limit for data transfer, Use max_discard_to as max data timeout value
> to avoid timeout error in case data timeout was larger than
> 2.69 sec.
>
> For some crappy cards, the timeout value calculate from card was
> larger than UINT_MAX, in this case the timeout value write into
> register was not expected.
>
> This patch can reduce I/O error due to large timeout value for
> erase(CMD38) and write(CMD25) for some crappy cards.
>
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
>  drivers/mmc/core/core.c | 45 ++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index bf18b6b..b429baa 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -757,6 +757,7 @@ EXPORT_SYMBOL(mmc_read_bkops_status);
>   */
>  void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_ca=
rd *card)
>  {
> +	struct mmc_host *host =3D card->host;
>  	unsigned int mult;
> =20
>  	/*
> @@ -780,7 +781,12 @@ void mmc_set_data_timeout(struct mmc_data *data,=
 const struct mmc_card *card)
>  	if (data->flags & MMC_DATA_WRITE)
>  		mult <<=3D card->csd.r2w_factor;
> =20
> -	data->timeout_ns =3D card->csd.tacc_ns * mult;
> +	/* Avoid over flow for some crappy cards. */
> +	if ((UINT_MAX / mult) < card->csd.tacc_ns)
> +		data->timeout_ns =3D UINT_MAX;
> +	else
> +		data->timeout_ns =3D card->csd.tacc_ns * mult;
> +
>  	data->timeout_clks =3D card->csd.tacc_clks * mult;
> =20
>  	/*
> @@ -842,6 +848,11 @@ void mmc_set_data_timeout(struct mmc_data *data,=
 const struct mmc_card *card)
>  				data->timeout_ns =3D  100000000;	/* 100ms */
>  		}
>  	}
> +
> +	if (host->max_discard_to &&
> +			(host->max_discard_to <
> +			 (data->timeout_ns / 1000000)))
> +		data->timeout_ns =3D host->max_discard_to * 1000000;
>  }
>  EXPORT_SYMBOL(mmc_set_data_timeout);
> =20
> @@ -1816,11 +1827,14 @@ static unsigned int mmc_mmc_erase_timeout(str=
uct mmc_card *card,
>  		unsigned int timeout_clks =3D card->csd.tacc_clks * mult;
>  		unsigned int timeout_us;
> =20
> -		/* Avoid overflow: e.g. tacc_ns=3D80000000 mult=3D1280 */
> -		if (card->csd.tacc_ns < 1000000)
> -			timeout_us =3D (card->csd.tacc_ns * mult) / 1000;
> -		else
> +		/*
> +		 * Avoid over flow for some crappy cards.
> +		 * e.g. tacc_ns=3D80000000 mult=3D1280
> +		 */
> +		if ((UINT_MAX / mult) < card->csd.tacc_ns)
>  			timeout_us =3D (card->csd.tacc_ns / 1000) * mult;
> +		else
> +			timeout_us =3D (card->csd.tacc_ns * mult) / 1000;
> =20
>  		/*
>  		 * ios.clock is only a target.  The real clock rate might be
> @@ -2185,16 +2199,17 @@ unsigned int mmc_calc_max_discard(struct mmc_=
card *card)
>  	struct mmc_host *host =3D card->host;
>  	unsigned int max_discard, max_trim;
> =20
> -	if (!host->max_discard_to)
> -		return UINT_MAX;
> -
> -	/*
> -	 * Without erase_group_def set, MMC erase timeout depends on clock
> -	 * frequence which can change.  In that case, the best choice is
> -	 * just the preferred erase size.
> -	 */
> -	if (mmc_card_mmc(card) && !(card->ext_csd.erase_group_def & 1))
> -		return card->pref_erase;
> +	if (!host->max_discard_to) {
> +		/*
> +		 * Without erase_group_def set, MMC erase timeout depends
> +		 * on clock frequence which can change.  In that case, the
> +		 * best choice is just the preferred erase size.
> +		 */
> +		if (mmc_card_mmc(card) && !(card->ext_csd.erase_group_def & 1))
> +			return card->pref_erase;
> +		else
> +			return UINT_MAX;
> +	}
> =20
>  	max_discard =3D mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
>  	if (mmc_can_trim(card)) {

--=20
Thanks & Regards
Haijun.


