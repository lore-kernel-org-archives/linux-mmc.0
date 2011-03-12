From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH resend] sdhci: work around broken dma boundary behaviour
Date: Sat, 12 Mar 2011 22:43:48 +0100
Message-ID: <20110312214348.GA312@pengutronix.de>
References: <1299530457-19904-1-git-send-email-mmvinni@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58797 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab1CLVnt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Mar 2011 16:43:49 -0500
Content-Disposition: inline
In-Reply-To: <1299530457-19904-1-git-send-email-mmvinni@yahoo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: linux-mmc@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I finally found some time.

On Mon, Mar 07, 2011 at 10:40:57PM +0200, Mikko Vinni wrote:
> Some SD host controllers (noticed on an integrated JMicron SD reader
> on an HP Pavilion dv5-1250eo laptop) don't update the dma address
> register before signaling a dma interrupt due to a dma boundary.
> Detect this and update the register to the next 512KB boundary,
> at which the transfer presumably stopped.
>=20
> As long as each transfer is at most 512KB in size (on this hardware
> the max seems to be 65536 bytes), this fix is needed at most once
> per transfer.

But we can't guarantee that. Transfer could be up to 65535 * 2K.

> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D28462
>=20
> Signed-off-by: Mikko Vinni <mmvinni <at> yahoo.com>

Proper EMail please.

>=20
> ---
> Sent on 2011-02-21 21:23:32 GMT
> (http://thread.gmane.org/gmane.linux.kernel.mmc/5568/focus=3D6145)
>=20
> Hoping to be able to drop this patch eventually from my own
> repo and have the hardware just work with mainline code.
> Maybe first in -next if nobody sees any serious problems
> straight away?
>=20
> This patch should not break anything for anybody whose
> hardware isn't already broken.
>=20
>  drivers/mmc/host/sdhci.c |   24 +++++++++++++++++++++---
>  1 files changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a25db42..8651731 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1537,9 +1537,27 @@ static void sdhci_data_irq(struct sdhci_host *host=
, u32 intmask)
>  		 * boundaries, but as we can't disable the feature
>  		 * we need to at least restart the transfer.
>  		 */
> -		if (intmask & SDHCI_INT_DMA_END)
> -			sdhci_writel(host, sdhci_readl(host, SDHCI_DMA_ADDRESS),
> -				SDHCI_DMA_ADDRESS);
> +		if (intmask & SDHCI_INT_DMA_END) {
> +			u32 dmastart, dmanow;
> +			dmastart =3D sg_dma_address(host->data->sg);

This will only work for the first 512K, right?

> +			dmanow =3D sdhci_readl(host, SDHCI_DMA_ADDRESS);
> +			if (dmanow =3D=3D dmastart) {
> +				/*
> +				 * HW failed to increase the address.
> +				 * Update to the next 512KB block boundary.
> +				 */
> +				dmanow =3D (dmanow & ~0x7ffff) + 0x80000;

Hmm, hardcoding these values is probably not a good idea. They should be
dependent on what is written to MAKE_BLKSIZE. Maybe a common define?

> +				if (dmanow > dmastart + host->data->blksz *
> +							host->data->blocks) {
> +					WARN_ON(1);
> +					dmanow =3D dmastart;
> +				}

Did this happen?

> +				DBG("%s: next DMA address forced "
> +				    "from 0x%08x to 0x%08x\n",
> +				    mmc_hostname(host->mmc), dmastart, dmanow);
> +			}
> +			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
> +		}
> =20
>  		if (intmask & SDHCI_INT_DATA_END) {
>  			if (host->cmd) {
> --=20
> 1.7.4.1

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk176RQACgkQD27XaX1/VRsCIQCfSXsCnZBP+4/MhVPGqM8gY4cE
PLcAniLiZBjJfKZpTAJzXlCRQyzpbIU9
=wp7L
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
