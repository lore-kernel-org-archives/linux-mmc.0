From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: unbreak sdhci-esdhc-imx on i.MX25
Date: Wed, 18 Apr 2012 20:00:42 -0400
Message-ID: <87wr5clhed.fsf@laptop.org>
References: <1334709020-31088-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56468 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656Ab2DSAAc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 20:00:32 -0400
In-Reply-To: <1334709020-31088-1-git-send-email-eric@eukrea.com> ("Eric
	=?utf-8?Q?B=C3=A9nard=22's?= message of "Wed, 18 Apr 2012 02:30:20 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>
Cc: linux-mmc@vger.kernel.org, shawn.guo@linaro.org, w.sang@pengutronix.de, s.hauer@pengutronix.de

Hi,

On Tue, Apr 17 2012, Eric B=C3=A9nard wrote:
> this was broken by me in 37865fe91582582a6f6c00652f6a2b1ff71f8a78
> "mmc: sdhci-esdhc-imx: fix timeout on i.MX's sdhc" where more
> extensive tests would have shown that read or write of data
> to the card were failing (even if the partition table was
> correctly read).
>
> Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sd=
hci-esdhc-imx.c
> index 6193a0d..8abdaf6 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -467,8 +467,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct=
 platform_device *pdev)
>  	clk_prepare_enable(clk);
>  	pltfm_host->clk =3D clk;
> =20
> -	if (!is_imx25_esdhc(imx_data))
> -		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +	host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> =20
>  	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
>  		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */

Thanks, pushed to mmc-next for 3.4.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
