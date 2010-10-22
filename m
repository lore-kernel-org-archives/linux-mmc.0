From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
Date: Sat, 23 Oct 2010 00:12:03 +0100
Message-ID: <20101022231203.GA6502@void.printf.net>
References: <4CC0A281.1010202@eukrea.com> <1287696028-27854-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60622 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070Ab0JVXMF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Oct 2010 19:12:05 -0400
Content-Disposition: inline
In-Reply-To: <1287696028-27854-1-git-send-email-eric@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.gsc@gmail.com, w.sang@pengutronix.de, nicolas.pitre@linaro.org, r65037@freescale.com, amit.kucheria@linaro.org

On Thu, Oct 21, 2010 at 11:20:27PM +0200, Eric B=E9nard wrote:
> this patch fix timeout problems on i.MX's sdhci as suggested by
> Richard Zhu.
>=20
> Tested on :
> - i.MX257 : not needed
> - i.MX357 : needed
> - i.MX515 : needed
>=20
> more details can be found here :
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/02=
9748.html
>=20
> Signed-off-by: Eric B=E9nard <eric@eukrea.com>
> Tested-by: Shawn Guo <shawn.gsc@gmail.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sd=
hci-esdhc-imx.c
> index afbac9a..11e1ae1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -130,6 +130,12 @@ static int esdhc_pltfm_init(struct sdhci_host *h=
ost, struct sdhci_pltfm_data *pd
>  		gpio_request(boarddata->wp_gpio, "SD_WP");
>  		gpio_direction_input(boarddata->wp_gpio);
>  	}
> +
> +	if (cpu_is_mx35() || cpu_is_mx51()) {
> +		dev_info(mmc_dev(host->mmc), "using broken timeout quirk\n");
> +		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +	}
> +
>  	return 0;
>  }
> =20

This has Wolfram's RFC wp-on-gpio patch applied.  Want to repost these
against mmc-next?

I'll plan on leaving this until after -rc1, so that I can send out a
pull request shortly.  Thanks,

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
