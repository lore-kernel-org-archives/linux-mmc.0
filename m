From: Bough Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH] mmc: core: Restore parts of the polling policy when
 switch to HS/HS DDR
Date: Mon, 16 Jan 2017 03:09:15 +0000
Message-ID: <AM4PR0401MB2324E25D7D492F7DAAA90E9E907D0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <1484305503-30723-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0056.outbound.protection.outlook.com ([104.47.2.56]:4832
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751302AbdAPDJU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 15 Jan 2017 22:09:20 -0500
In-Reply-To: <1484305503-30723-1-git-send-email-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>, Clemens Gruber <clemens.gruber@pqgruber.com>, Gary Bisson <gary.bisson@boundarydevices.com>, Dong Aisheng <dongas86@gmail.com>, Fabio Estevam <festevam@gmail.com>, "A.S. Dong" <aisheng.dong@nxp.com>

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Friday, January 13, 2017 7:05 PM
> To: linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>; Adrian Hunter
> <adrian.hunter@intel.com>; Linus Walleij <linus.walleij@linaro.org>; Chao=
tian
> Jing <chaotian.jing@mediatek.com>; Yong Mao <yong.mao@mediatek.com>;
> Shawn Lin <shawn.lin@rock-chips.com>; Clemens Gruber
> <clemens.gruber@pqgruber.com>; Gary Bisson
> <gary.bisson@boundarydevices.com>; Dong Aisheng <dongas86@gmail.com>;
> Fabio Estevam <festevam@gmail.com>; A.S. Dong <aisheng.dong@nxp.com>;
> Bough Chen <haibo.chen@nxp.com>
> Subject: [PATCH] mmc: core: Restore parts of the polling policy when swit=
ch to
> HS/HS DDR
>=20
> Regressions for not being able to detect an eMMC HS DDR mode card has bee=
n
> reported for the sdhci-esdhc-imx driver, but potentially other sdhci vari=
ants
> may suffer from the similar problem.
>=20
> The commit e173f8911f09 ("mmc: core: Update CMD13 polling policy when
> switch to HS DDR mode"), is causing the problem. It seems that change mov=
ed
> one step to far, regarding changing the host's timing before polling for =
a busy
> card.
>=20
> To fix this, let's move back to the behaviour when the host's timing is u=
pdated
> after the polling, but before the switch status is fetched and validated.
>=20
> In cases when polling with CMD13, we keep validating the switch status at=
 each
> attempt. However, to align with the other card busy detections mechanism,
> let's fetch and validate the switch status also after the host's timing i=
s updated.
>=20
> Reported-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> Reported-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Fixes: e173f8911f09 ("mmc: core: Update CMD13 polling policy when switch.=
.")
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/mmc_ops.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index db2969f..fe80f26 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -506,9 +506,6 @@ static int mmc_poll_for_busy(struct mmc_card *card,
> unsigned int timeout_ms,
>  		}
>  	} while (busy);
>=20
> -	if (host->ops->card_busy && send_status)
> -		return mmc_switch_status(card);
> -
>  	return 0;
>  }
>=20
> @@ -577,24 +574,26 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8
> index, u8 value,
>  	if (!use_busy_signal)
>  		goto out;
>=20
> -	/* Switch to new timing before poll and check switch status. */
> -	if (timing)
> -		mmc_set_timing(host, timing);
> -
>  	/*If SPI or used HW busy detection above, then we don't need to poll.
> */
>  	if (((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
> ||
> -		mmc_host_is_spi(host)) {
> -		if (send_status)
> -			err =3D mmc_switch_status(card);
> +		mmc_host_is_spi(host))
>  		goto out_tim;
> -	}
>=20
>  	/* Let's try to poll to find out when the command is completed. */
>  	err =3D mmc_poll_for_busy(card, timeout_ms, send_status,
> retry_crc_err);
> +	if (err)
> +		goto out;
>=20
>  out_tim:
> -	if (err && timing)
> -		mmc_set_timing(host, old_timing);
> +	/* Switch to new timing before check switch status. */
> +	if (timing)
> +		mmc_set_timing(host, timing);
> +
> +	if (send_status) {
> +		err =3D mmc_switch_status(card);
> +		if (err && timing)
> +			mmc_set_timing(host, old_timing);
> +	}
>  out:
>  	mmc_retune_release(host);
>=20
> --
> 1.9.1

Test this patch on i.MX6Q-SABRESD board, it can fix the issue.

Tested-by: Haibo Chen <haibo.chen@nxp.com>

Best Regards,
Hiabo Chen
