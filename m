From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3] mmc: implement Driver Stage Register handling
Date: Wed, 13 Aug 2014 17:57:07 +0200
Message-ID: <20140813155707.GP5134@pengutronix.de>
References: <1407944656-14592-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55053 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbaHMP5R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 11:57:17 -0400
Content-Disposition: inline
In-Reply-To: <1407944656-14592-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, Markus Niebel <Markus.Niebel@tq-group.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>

Hello,

On Wed, Aug 13, 2014 at 05:44:16PM +0200, Uwe Kleine-K=F6nig wrote:
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index f51b5ba3bbea..37ed493d8030 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -93,6 +93,27 @@ int mmc_deselect_cards(struct mmc_host *host)
>  	return _mmc_select_card(host, NULL);
>  }
> =20
> +/*
> + * Write the value specified in the device tree or board code into t=
he optional
> + * 16 bit Driver Stage Register. This can be used to tune raise/fall=
 times and
> + * drive strength of the DAT and CMD outputs. The actual meaning of =
a given
> + * value is hardware dependant.
> + * The presence of the DSR register can be determined from the CSD r=
egister,
> + * bit 76.
> + */
> +int mmc_set_dsr(struct mmc_host *host)
> +{
> +	int err;
The line declaring err can and should be dropped. I found that during m=
y
tests, but failed to change this in the patch before sending it out.

If you consider applying my patch, please fix this up. If not I will
take this as an opportunity to remind you in a few days with a v4 :-)

Uwe

> +	struct mmc_command cmd =3D {0};
> +
> +	cmd.opcode =3D MMC_SET_DSR;
> +
> +	cmd.arg =3D ((u32)host->dsr << 16) | 0xffff;
> +	cmd.flags =3D MMC_RSP_NONE | MMC_CMD_AC;
> +
> +	return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> +}
> +

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
