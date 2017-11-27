From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 00/22] mmc: tmio: various fixes and cleanups
Date: Mon, 27 Nov 2017 18:13:24 +0100
Message-ID: <20171127171324.sprmzsu4dkeo3gon@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kb3pclpwd4quu47y"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47657 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753109AbdK0RN1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Nov 2017 12:13:27 -0500
Content-Disposition: inline
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--kb3pclpwd4quu47y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I am getting more and more patches for TMIO.
> I put all in a single series to clarify the patch order.

Hmmm, that makes reviewing harder in my opinion.

I really liked the small serieses which could be improved, acked, and
applied. This big one will take much longer to review and resending will
cause quite some noise.

For clarifying patch order in small series, it should be enough to state
the dependencies in the cover letter. Super helpful is providing a
public git branch where ppl can pull from.

Also, can you state what kind of testing you did on what platforms? My
gut feeling says that the card detect changes might be easy to catch
regressions on old platforms, so we'd need to be extra cautious. I/we
can do testing on some Renesas platforms, too.

Other changes like moving stuff from tmio_core to renesas_sdhi is less
critical. Either it works or not, so that is easy to spot :)

Which might be another argument for multiple smaller patch series.

Nonetheless, I'll try to get this reviewed in the next days...

All the best,

   Wolfram


>=20
> 1, 2, 4, 5, 6, 7 were already acked or reviewed by Wolfram Sang.
>=20
>=20
> Masahiro Yamada (22):
>   mmc: renesas_sdhi: consolidate DMAC CONFIG options
>   mmc: renesas_sdhi: remove wrong depends on to enable compile test
>   mmc: renesas_sdhi: remove eprobe jump label
>   mmc: tmio: set tmio_mmc_host to driver data
>   mmc: tmio: use devm_ioremap_resource() instead of devm_ioremap()
>   mmc: tmio: move mmc_host_ops to struct tmio_mmc_host from static data
>   mmc: tmio, renesas_sdhi: set mmc_host_ops hooks directly
>   mmc: tmio: move mmc_gpio_request_cd() before mmc_add_host()
>   mmc: tmio: use mmc_can_gpio_cd() instead of checking
>     TMIO_MMC_USE_GPIO_CD
>   mmc: tmio: support IP-builtin card detection logic
>   mmc: renesas_sdhi: remove always false condition
>   mmc: tmio,renesas_sdhi: move struct tmio_mmc_dma to renesas_sdhi.h
>   mmc: tmio,renesas_sdhi: move Renesas-specific DMA data to
>     renesas_sdhi.h
>   mmc: tmio,renesas_sdhi: move ssc_tappos to renesas_sdhi.h
>   mmc: tmio: change bus_shift to unsigned int
>   mmc: tmio: fix never-detected card insertion bug
>   mmc: tmio: move TMIO_MASK_{READOP,WRITEOP} handling to correct place
>   mmc: tmio: remove useless TMIO_MASK_CMD handling in
>     tmio_mmc_host_probe()
>   mmc: tmio: ioremap memory resource in tmio_mmc_host_alloc()
>   mmc: tmio: move clk_enable/disable out of tmio_mmc_host_probe()
>   mmc: tmio: move {tmio_}mmc_of_parse() to tmio_mmc_host_alloc()
>   mmc: tmio: remove dma_ops from tmio_mmc_host_probe() argument
>=20
>  drivers/mmc/host/Kconfig                      |   5 +-
>  drivers/mmc/host/Makefile                     |   8 +-
>  drivers/mmc/host/renesas_sdhi.h               |  22 ++++
>  drivers/mmc/host/renesas_sdhi_core.c          |  49 ++++-----
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  14 ++-
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  35 +++---
>  drivers/mmc/host/tmio_mmc.c                   |  23 ++--
>  drivers/mmc/host/tmio_mmc.h                   |  23 +---
>  drivers/mmc/host/tmio_mmc_core.c              | 149 +++++++++++++-------=
------
>  9 files changed, 170 insertions(+), 158 deletions(-)
>=20
> --=20
> 2.7.4
>=20

--kb3pclpwd4quu47y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocR7MACgkQFA3kzBSg
Kba1aQ//SP5yIKtDG4DxWYQpVSgen3yYmgw7Md/1ldbWSZfCQAMv7WIdC5wYCYFf
u4iFioMyQgrBDrOqMt8i+AAeBe+HwAwpVPQDqJLpJ3WZSuuVbJ4TwEhWmwAM6Gw9
rdlUe5ij1PYb9VgxTDduSmfdI5QlZ8tbolYLotaYcsRtlt3+vGT7RdoAIdwou/A0
Rovg6RJ55mgsG6J2wKroktbwm5+rZVWCTWCDDMrWfiQEv6mRFnOs2ja2wVzDREDI
AX0s4ZbilGEm2VJwPnR6pr5z8IPHhutRoaQDxQPnCs2B11Phx+zr/b1Zua75Z/dC
408ubM5MvdYzrtANkirWKVqRRAbIndThDw4orNjHCjplE+V1B5sWWIBuYFAfE3EL
cpwWSSKMSE65gHJgSP6lKzbI5Iza2Sjiz6k4hZqnPMsPH7FDdTT9hAZ/DrTjgXGd
IgI91h/h+f3n+G2irfc8uYXppW9lZrT9r3rJc8II6FZoNTMw9s/64hNL+F73FROQ
bHsoXbrYIxrzXG2VBFLSl6UkIVMa1l+SxtSoB0Nm3vcPFnVApeM3J8UKldiikwqJ
V/G8liDCJI84h5Fw+4A9kSmHzEiApP3zCkx06QkXbWaLz98EuiKl8JitkyB/WSm3
ANBt6F9n3pX1Z0kDr8L6Tc9lUSmC8v6NFU3MkMRrX0RZDp0wcm8=
=fRMF
-----END PGP SIGNATURE-----

--kb3pclpwd4quu47y--
