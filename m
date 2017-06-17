From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH mmc/next v2 3/4] mmc: renesas-sdhi: add support for R-Car
 Gen3 SDHI DMAC
Date: Sat, 17 Jun 2017 17:00:56 +0200
Message-ID: <20170617150055.eeholgustydof3w5@ninjato>
References: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
 <1497607134-10241-4-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fei7tpaoar3a5iv5"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497607134-10241-4-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org


--fei7tpaoar3a5iv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 11:58:53AM +0200, Simon Horman wrote:
> Add a new variant of the SDHI driver to support R-Car Gen3 with DMA via
> on-chip bus mastering.  Since the DMAC is in a part of the SDHI module it
> is not suitable to be used via DMA Engine.
>=20
> Clearing of DM_CM_INFO1 after DMA thanks to Dirk Behme
>=20
> Cc: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>

Your Sob is missing!

> + * - Since this SDHI DMAC register set has actual 32-bit and "bus_shift"=
 is 2,
> + *   this driver cannot use original sd_ctrl_{write,read}32 functions.

Easier to understand, I'd think, would be:

Since the SDHI DMAC register set has not 16 but 32-bit width, we need a
custom accessor.

> +	ret =3D dma_map_sg(&host->pdev->dev, sg, host->sg_len, dir);
> +	if (ret < 0) {
> +		dev_err(&host->pdev->dev, "%s: dma_map_sg failed\n", __func__);

__func__?

> +	/* start the DMAC */

Not very useful comment in my book, but no strong opinion.

> +	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_DTRAN_CTRL,
> +					    DTRAN_CTRL_DM_START);
> +}
> +	dma_unmap_sg(&host->pdev->dev, host->sg_ptr, host->sg_len, dir);
> +
> +	spin_unlock_irq(&host->lock);
> +
> +	spin_lock_irq(&host->lock);

Just keep the lock?

Rest looks good so far...


--fei7tpaoar3a5iv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllFRCMACgkQFA3kzBSg
KbaI4Q/+J0uTdJ6EWAAZ7KjxRq/vIGK++nNoh/FXUUfMOWsICxEdfO9Y/Ks3IkMN
ym8zQFjSbQacJJWPXNXjDUiQc/DC2TsniH18fgNZ5IOeCsvh7CIcqo+NOKKLxHE3
peRdoyGlu7Ti0BbwGAX0iwyjGXSnJndYCCyjGS39Ui/T1fOB4hzGTjDLBjSX610r
9KBjM7IZPfinkizqGTgPuC6o1AeMidSQxDqtQ1vk812NFE3BLbaRR9GYkb4e9Gqz
Q8ZWl8aN3mE5kKeMcNWVV7e4ylPXdngapuN8uOQkh1DxusJgPyNdpCsEDBAn7Hrb
EuxHxYBqjoIPzseYFpvkHbbWAm61d3L6oKS3uKaulc1MTbq1dJBxFPoEXd8O5cWK
5YUWb7NfNB8J1Dn/7f8ZyrwelEjz95w91/D0cikWHYREmWISCRVYb3Zbu5W5hHz3
NXjeRziw/jGfZFsluED0NrSs2IYG5NRN7S6VDQ/VnqbHepmvpZr+SNgjNWYRFoVQ
Y8kg7g5qYPpI2SJYnfI8jmRG+PWLeqOlJ16Hy/Xqv3IUJ3Yw1lmAHriGM4LOD75+
kUyNlo7Vy4ik5YPokHLprUClY0X3xA5Q5vFpo21zuEBHdhGJZk7p3qdBBE6zVL2a
97hFVcXIBBqKpr+qwwqg3oS+SrJZiA+kWZ/rsm8PC6zISego7Xo=
=jfPw
-----END PGP SIGNATURE-----

--fei7tpaoar3a5iv5--
