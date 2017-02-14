From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH v2 4/4] mmc: host: tmio: fill in response from auto cmd12
Date: Tue, 14 Feb 2017 10:06:47 +0000
Message-ID: <HK2PR06MB05484A4141A1A9AC8BE54E00D8580@HK2PR06MB0548.apcprd06.prod.outlook.com>
References: <20170213180342.26172-1-wsa+renesas@sang-engineering.com>
 <20170213180342.26172-5-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:23036 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750859AbdBNKGw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 05:06:52 -0500
In-Reply-To: <20170213180342.26172-5-wsa+renesas@sang-engineering.com>
Content-Language: ja-JP
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>

Hi,

> From: Wolfram Sang [mailto:wsa+renesas@sang-engineering.com]
> Sent: Tuesday, February 14, 2017 3:04 AM
>=20
> After we received the dataend interrupt, R1 response register carries
> the value from the automatically generated stop command. Report that
> info back to the MMC block layer, so we will be notified in case of e.g.
> ECC errors which happened during the last transfer.
>=20
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I tested this patch with a SD tester (SGDK320).
As the commit log, this patch could pass the R1 response. So,

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


However, I think the MMC block layer should check the brq->stop.resp[0]
because brq->stop.error should be zero in this case and mmc_blk_cmd_recover=
y()
is not called in mmc_blk_err_check().

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/mmc/host/tmio_mmc_pio.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_=
pio.c
> index b47dd9195fe3fe..a08db28b0100d6 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -557,6 +557,9 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
>  			dev_err(&host->pdev->dev, "unsupported stop: CMD%u,0x%x. We did CMD12=
,0\n",
>  				stop->opcode, stop->arg);
>=20
> +		/* fill in response from auto CMD12 */
> +		stop->resp[0] =3D sd_ctrl_read16_and_16_as_32(host, CTL_RESPONSE);
> +
>  		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0);
>  	}
>=20
> --
> 2.11.0

