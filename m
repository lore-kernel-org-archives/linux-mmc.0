From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 6/6] mmc: sdhci-pltfm: add pltfm-driver for imx35/51
Date: Thu, 14 Oct 2010 04:07:56 +0100
Message-ID: <20101014030755.GE3553@void.printf.net>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de> <1286806866-19258-7-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38373 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754362Ab0JNDIB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Oct 2010 23:08:01 -0400
Content-Disposition: inline
In-Reply-To: <1286806866-19258-7-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>

Hi Wolfram,

On Mon, Oct 11, 2010 at 04:21:06PM +0200, Wolfram Sang wrote:
> This driver adds basic support for the esdhc-core found on e.g.
> imx35/51. It adds up to the pltfm-core.
>=20
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> Tested-by : Eric B=E9nard <eric@eukrea.com>
> ---
>=20
> Changes since last version:
>=20
> * use PTR_ERR if clk_get failed
>=20
>  drivers/mmc/host/Kconfig           |   10 +++
>  drivers/mmc/host/Makefile          |    1 +
>  drivers/mmc/host/sdhci-esdhc-imx.c |  143 ++++++++++++++++++++++++++=
++++++++++
>  drivers/mmc/host/sdhci-pltfm.c     |    3 +
>  drivers/mmc/host/sdhci-pltfm.h     |    1 +
>  5 files changed, 158 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-esdhc-imx.c
>=20
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8de7b9e..7b07f10 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -130,6 +130,16 @@ config MMC_SDHCI_CNS3XXX
> =20
>  	  If unsure, say N.
> =20
> +config MMC_SDHCI_ESDHC_IMX
> +	bool "SDHCI platform support for the Freescale eSDHC i.MX controlle=
r"
> +	depends on MMC_SDHCI_PLTFM
> +	select MMC_SDHCI_IO_ACCESSORS
> +	help
> +	  This selects the Freescale eSDHC controller support on the platfo=
rm
> +	  bus, found on platforms like mx35/51.
> +
> +	  If unsure, say N.
> +

Could you add a machine dependency here?  Otherwise this is going to
offer itself to x86 users, and then fail to compile due to lack of a
clk_* implementation.

Apart from that, looks ready for mmc-next -- the mdelay(100) fix can
come later, since that's orthogonal.

Thanks,

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
