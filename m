From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH resend] sdhci: work around broken dma boundary behaviour
Date: Mon, 14 Mar 2011 16:28:17 +0100
Message-ID: <20110314152817.GD2206@pengutronix.de>
References: <1299530457-19904-1-git-send-email-mmvinni@yahoo.com>
 <20110312214348.GA312@pengutronix.de>
 <423716.64271.qm@web161805.mail.bf1.yahoo.com>
 <20110314101829.GB2206@pengutronix.de>
 <470477.34668.qm@web161814.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39479 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1CNP2S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2011 11:28:18 -0400
Content-Disposition: inline
In-Reply-To: <470477.34668.qm@web161814.mail.bf1.yahoo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: linux-mmc@vger.kernel.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I was just  referring to using "<at>" instead of "@". The provider
> > doesn't really  matter :)
>=20
> Ah, ok. Yahoo makes it practically impossible to send well-formed
> patches from the web interface, but as long as it's not completely
> rejected for casual email, I prefer to keep the number of spam
> addresses to the minimum.

Okay, well, that is up to Chris.

> Almost. There is one statement in the spec ("At the end of transfer, the =
Host
> Controller may issue or may not issue DMA Interrupt"), which makes
> me wonder whether a host hontroller may issue a DMA Interrupt also at
> the end of a transfer which doesn't finish at the boundary.

Then we'll have a "useless" update. Won't hurt AFAICS, but might
surprise people examining the debug output.

> In sdhci.c or sdhci.c? I see SDHCI_MAKE_BLKSZ is used also in
> drivers/mmc/host/sdhci-esdhc-imx.c and drivers/mmc/host/sdhci-of-esdhc.c.

In those, I think it is okay to leave 0x07, because they always want to
clear all bits.

> I only compile tested this so far, so no proper patch yet, but what I wou=
ld
> write based on the comments is something like this:

(Sidenote: Indentation is broken. Tabwidth is 8)

> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -201,6 +201,9 @@
>  #define SDHCI_MAX_DIV_SPEC_200    256
>  #define SDHCI_MAX_DIV_SPEC_300    2046
> =20
> +#define SDHCI_DEFAULT_BOUNDARY_SIZE    (512 * 1024)
> +#define SDHCI_DEFAULT_BOUNDARY_ARG    (ilog2(SDHCI_DEFAULT_BOUNDARY_SIZE=
) - 12)
> +
>  struct sdhci_ops {
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>      u32        (*read_l)(struct sdhci_host *host, int reg);
>=20
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -808,7 +808,8 @@ static void sdhci_prepare_data(struct sdhci_host *hos=
t,=20
> struct mmc_data *data)
>      sdhci_set_transfer_irqs(host);
> =20
>      /* We do not handle DMA boundaries, so set it to max (512 KiB) */
> -    sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, data->blksz), SDHCI_BLOCK_SIZ=
E);
> +    sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
> +        data->blksz), SDHCI_BLOCK_SIZE);
>      sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>  }
> =20
> @@ -1545,9 +1546,20 @@ static void sdhci_data_irq(struct sdhci_host *host=
, u32=20
> intmask)
>           * boundaries, but as we can't disable the feature
>           * we need to at least restart the transfer.
>           */
> -        if (intmask & SDHCI_INT_DMA_END)
> -            sdhci_writel(host, sdhci_readl(host, SDHCI_DMA_ADDRESS),
> -                SDHCI_DMA_ADDRESS);
> +        if (intmask & SDHCI_INT_DMA_END) {
> +            u32 dmastart, dmanow;
> +            dmastart =3D sg_dma_address(host->data->sg);

Consecutive transfers won't work (I know you know ;)).

> +            dmanow =3D sdhci_readl(host, SDHCI_DMA_ADDRESS);
> +            /*
> +             * Force update to the next DMA block boundary.
> +             */
> +            dmanow =3D (dmastart &
> +                ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
> +                SDHCI_DEFAULT_BOUNDARY_SIZE;
> +            DBG("%s: next DMA address after 0x%08x is 0x%08x\n",
> +                mmc_hostname(host->mmc), dmastart, dmanow);
> +            sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
> +        }

Other than that, looks like the right direction to me.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1+NBEACgkQD27XaX1/VRsU8wCfdUfoPB7VLyw2POL9NA5eqxsI
CGMAoKDwnJnWvvFSI2hHEcZphSxBNv2C
=jqI0
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
