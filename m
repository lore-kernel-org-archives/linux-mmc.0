From: Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] Revert "mmc: sdhi: use maximum width for the sdbuf
 register"
Date: Thu, 3 Aug 2017 10:04:09 +0000
Message-ID: <KL1PR06MB1702A9E5ED24F2B663A4A077B8B10@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <20170803094947.1490-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:40524 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751975AbdHCKEO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Aug 2017 06:04:14 -0400
In-Reply-To: <20170803094947.1490-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Ulf Hansson <ulf.hansson@linaro.org>

Tested this patch on iWave RZ/G1M platform.

Tested-by: Biju Das <biju.das@bp.renesas.com>

Regards,
Biju

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa+renesas@sang-engineering.com]
> Sent: 03 August 2017 10:50
> To: linux-mmc@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org; Simon Horman <horms@verge.net.au>;
> Biju Das <biju.das@bp.renesas.com>; Ulf Hansson <ulf.hansson@linaro.org>;
> Wolfram Sang <wsa+renesas@sang-engineering.com>
> Subject: [PATCH] Revert "mmc: sdhi: use maximum width for the sdbuf
> register"
>
> This reverts commit 785b215250310c690142abb1bdbb0767b8487c49. There is
> a secondary SDHI instance on Gen2 with has a 32-bit wide SDBUF register w=
hile
> all other registers are 16 bit apart. So, the logic used here does not ap=
ply and
> we need to rethink this and start cleanly from scratch.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c
> b/drivers/mmc/host/renesas_sdhi_core.c
> index 48da28dfef6465..dd215723fa4312 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -461,7 +461,8 @@ static void renesas_sdhi_enable_dma(struct
> tmio_mmc_host *host, bool enable)  {
>  sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ?
> DMA_ENABLE_DMASDRW : 0);
>
> -renesas_sdhi_sdbuf_width(host, enable ? (16 << host->bus_shift) : 16);
> +/* enable 32bit access if DMA mode if possibile */
> +renesas_sdhi_sdbuf_width(host, enable ? 32 : 16);
>  }
>
>  int renesas_sdhi_probe(struct platform_device *pdev,
> --
> 2.11.0




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
