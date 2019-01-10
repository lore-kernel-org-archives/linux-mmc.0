From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Properly set DMA mask
Date: Thu, 10 Jan 2019 11:59:11 +0100
Message-ID: <20190110105911.GA32301@ulmo>
References: <20190104104753.3383-1-thierry.reding@gmail.com>
 <20190104174354.GA18110@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190104174354.GA18110@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 09:43:54AM -0800, Christoph Hellwig wrote:
> > +	u64 dma_mask =3D dma_get_mask(dev);
>=20
> This is not a driver API.  I think what you want is
> dma_get_required_mask to query the mask.  But in that case
> you still need to always actually set a mask in the driver as well.

That's slightly different from what I want to do here. The purpose of
this part of the patch is that when the SDHCI hardware supports only 32
bits of address space, then we want to prevent 64-bit addressing mode
=66rom being used because it isn't useful.

So what we do want to check here is the DMA mask configured by the
driver (or the default set by the bus, or wherever it came from).
dma_get_required_mask() returns the DMA mask required to address all of
system memory. That would perhaps be a useful additional check, but it's
orthogonal to what I'm trying to do here.

Is there something else appropriate that I could use to query the DMA
mask set for a device?

Thierry

> Something like this patch:
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a22e11a65658..36c61778d8f3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3500,6 +3500,13 @@ static int sdhci_set_dma_mask(struct sdhci_host *h=
ost)
>  	struct device *dev =3D mmc_dev(mmc);
>  	int ret =3D -EINVAL;
> =20
> +	/*
> +	 * Systems that can't address more than 32-bits do not need to use
> +	 * 64-bit addressing mode, even if the device supports it.
> +	 */
> +	if (dma_get_required_mask(dev) <=3D DMA_BIT_MASK(32))
> +		host->flags &=3D ~SDHCI_USE_64_BIT_DMA;
> +
>  	if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
>  		host->flags &=3D ~SDHCI_USE_64_BIT_DMA;
> =20

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw3JXwACgkQ3SOs138+
s6EFTw/7BZu4QJfWJPApvi5Sv44HQ9OKjmlUaxHefd33MQZnD9x9lUwC3GCxO35t
gY9IwrqQvX1EPZRwoOHJoW/ZA45t+l+j/JyUuHcYZ+wksJLpWoBCZH72otrX/Krb
p6GEHVCO91AqM171Wjr9YOjPDvNyv6QQ3ouFX6Rob0vrv76eOC/dHSjwC88LXn0y
qqwMptpBePH/LZtzwdMXGB9CcmPIydnXv5HP4TsKA+SpJJzDYgPRmKY5hQSZjkz0
Jci2Ts6Ujvw6EeKes7Zu/UIDeM9xJnyg8H6tYZeTxyWfMesqQr+fbIBhy1T/MvG7
MCp05Nae6erPqm4NDYTauQd34fchCMjKHHNxzh/Jj4m6MZwuNkTR5xWCkGql3ZzI
wBFNO6/HM73fpkZWfFTsIhZ5JGgsQL5zs/vE/B6KKg+U1PAaa7p9xAhADhfWNCSi
RuBj08ikw2lWji5GSBJPy7xMWDk7/5/Ygfy8gutuU6m8PvONFWMb91CNZB3f6SeQ
B4wxSrHQm5y5EbXhnoixZgZsL2NC9BVEYsXuXcJB1BAF5KXDBJ62B2a4AfYZwoZ8
qnKUDHCmq34SUcXYJuqmUrgAtBrAX8ZAw/y2RSxel5z/rfUOdStJkIuXIuv3dD8I
Lc+k5BHCxceozRPyDIJnXS3dbbTrkrMTODeuwdcGfXyQaySh04k=
=4WZZ
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
