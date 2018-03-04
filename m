From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 14/16] mmc: tmio: move TMIO_MASK_{READOP,WRITEOP}
 handling to correct place
Date: Sun, 4 Mar 2018 23:34:51 +0100
Message-ID: <20180304223451.joqs2yoopwogncvj@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-15-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7gyjdunorgun5zsi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516206496-16612-15-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--7gyjdunorgun5zsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:14AM +0900, Masahiro Yamada wrote:
> As far as I tested the IP on UniPhier SoCs, TMIO_STAT_{RXRDY,TXRQ}
> are asserted for DMA mode as well as for PIO.  I need to disable the
> those IRQs in dma_ops->start hook, otherwise the DMA transfer fails
> with the following error message:
>   PIO IRQ in DMA mode!
>=20
> Renesas chips are the same cases since I see their dma_ops->start
> hooks explicitly clear TMIO_STAT_{RXRDY,TXRQ} (with nice comment!).
>=20
> If we do this sanity check in TMIO MMC core, RXRDY/TXRQ handling
> should be entirely moved to the core.  tmio_mmc_cmd_irq() will
> be a suitable place to disable them.
>=20
> The probe function sets TMIO_MASK_{READOP,WRITEOP} but this is odd.
>=20
>     /* Unmask the IRQs we want to know about */
>     if (!_host->chan_rx)
>             irq_mask |=3D TMIO_MASK_READOP;
>     if (!_host->chan_tx)
>             irq_mask |=3D TMIO_MASK_WRITEOP;
>=20
> At this point, _host->{chan_rx,chan_tx} are _always_ NULL because
> tmio_mmc_request_dma() is called after this code.  Consequently,
> TMIO_MASK_{READOP,WRITEOP} are set here whether DMA is used or not.
> Remove this pointless code.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--7gyjdunorgun5zsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqcdIcACgkQFA3kzBSg
KbbQ1Q//bxdR3m/BVVyL+YM+FHh5fhacmQn4jWGsiuAoMJxwnoF+7UTkf8esucKs
VAtJVb+l3nlCDzOKoc25R6o+kJO4RKSKdYRAp2hFQzXPUbA/R34cuANqhdP021JW
huAbKtbd03f3I5n1HOzplwh5dwUIaSUxK7vMfyRQjeQSJAyFn1K0I10amoVLVEeE
v2p9AvH/SVsEm5FS+XR+ODEoxs6JXChBdsB6RRuNqDwySpjGy8GI02d3rOpYCLlZ
ruohLPN7rKUBu344pwHgneb9jlExfQRC81AP1TlVlddPFs1+1xJ5Y0akiZQuYtXs
PpUnO8z/jZt1Jc/KIiCgZvSm9eYEPf5S/LBJCg2Cb+eNt7z2pMC/NPrm1JWoFsWi
9MY2bsj/Gzquq3GgwMgIuMZtYNouT41AZXriTdt7ODcM4s67g0RUpAoadejwxQ14
G2C3cBlZTGneiB/Vi2h3pN7BSAxzuDcBMebyTXwnnf/CDzc2Jf+TGs6K9mONqdKG
9iVMD3in/d7AOTknxlVo3mrX3usFq1NHhAx7BfcqI02WOoMt6aR2sXDyeIvd+91c
6Mfg0LWr9mcGSbeRMVSyxakB0ZGC6/xAIxSje+pAbXGNG+s6qeLQtk+VdGL+4Syu
ZQuN4iMZYOVKFaT8hrC+O/PfyEmMISeP+D78EBuOOikWW7aV230=
=u/GX
-----END PGP SIGNATURE-----

--7gyjdunorgun5zsi--
