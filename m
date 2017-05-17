From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] mmc: tmio: use SDIO master interrupt bit only when
 allowed
Date: Wed, 17 May 2017 07:47:18 +0000
Message-ID: <TY1PR06MB099248E104D6762E9E860BF3D8E70@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <20161209165141.26599-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:8004 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752368AbdEQHr1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 May 2017 03:47:27 -0400
In-Reply-To: <20161209165141.26599-1-wsa+renesas@sang-engineering.com>
Content-Language: ja-JP
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Yasushi SHOJI <yashi@atmark-techno.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Wolfram-san,

> -----Original Message-----
> From: Wolfram Sang
> Sent: Saturday, December 10, 2016 1:52 AM
>=20
> The master bit to enable SDIO interrupts can only be accessed if
> SCLKDIVEN bit allows that. However, the core uses the SDIO enable
> callback at times when SCLKDIVEN forbids the change. This leads to
> "timeout waiting for SD bus idle" messages.
>=20
> We now activate the master bit in probe once if SDIO is supported. IRQ
> en-/disabling will be done now by the individual IRQ enablement bits
> only.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Yasushi SHOJI <yashi@atmark-techno.com>
> ---
>=20
> No change from RFC, only Rev-by added (which included testing).
>=20
>  drivers/mmc/host/tmio_mmc_pio.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_=
pio.c
> index 7ef24ec620b542..526e52719f81b9 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -140,12 +140,10 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_hos=
t *mmc, int enable)
>=20
>  		host->sdio_irq_mask =3D TMIO_SDIO_MASK_ALL &
>  					~TMIO_SDIO_STAT_IOIRQ;
> -		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
>  		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
>  	} else if (!enable && host->sdio_irq_enabled) {
>  		host->sdio_irq_mask =3D TMIO_SDIO_MASK_ALL;
>  		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
> -		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
>=20
>  		host->sdio_irq_enabled =3D false;
>  		pm_runtime_mark_last_busy(mmc_dev(mmc));
> @@ -1203,7 +1201,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host=
,
>  	if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
>  		_host->sdio_irq_mask =3D TMIO_SDIO_MASK_ALL;
>  		sd_ctrl_write16(_host, CTL_SDIO_IRQ_MASK, _host->sdio_irq_mask);
> -		sd_ctrl_write16(_host, CTL_TRANSACTION_CTL, 0x0000);
> +		sd_ctrl_write16(_host, CTL_TRANSACTION_CTL, 0x0001);
>  	}

I'm afraid but I would like to confirm about this 6 month ago's patch :)

This patch enables CTL_TRANSACTION_CTL to 0x0001 in tmio_mmc_host_probe().
But, I have a concern we have to disable/enable the register in suspend/res=
ume()
because registers setting is possible to be cleared after resume.
What do you think?

Best regards,
Yoshihiro Shimoda

