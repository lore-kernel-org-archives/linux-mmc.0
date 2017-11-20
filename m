From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/6] mmc: tmio: move mmc_host_ops to struct tmio_mmc_host
 from static data
Date: Mon, 20 Nov 2017 21:45:00 +0100
Message-ID: <20171120204500.gqysj63b32rveahm@ninjato>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-5-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2tvphu7xbraelwml"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510042172-27220-5-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--2tvphu7xbraelwml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 05:09:30PM +0900, Masahiro Yamada wrote:
> Currently, tmio_mmc_ops is static data and tmio_mmc_host_probe()
> updates some hooks in the static data.  This is a problem when
> two or more instances call tmio_mmc_host_probe() and each of them
> requests to use its own card_busy/start_signal_voltage_switch.
>=20
> We can borrow a solution from sdhci_alloc_host().  Copy the whole
> ops structure to host->mmc_host_ops, then override the hooks in
> malloc'ed data.  Constify tmio_mmc_ops since it is a template ops
> used by default.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--2tvphu7xbraelwml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloTPswACgkQFA3kzBSg
KbaazA/5AXrMlPQGVeiNeorpjLSkMOiQelpBaGXtzKOOFPLzKypZ2Mfjpj+2LZwH
UQBcYI+W9/3QYXaWOmIzTl8uY69oJMvoWbTC6POc0sYVu98hYqqSjaEKgydz2bVL
lKBozEJPjPoGBvczdTiuTI8WbmAGRFYoAbOawPzc1FzqSs6/wiUfZv9Ro8klhozc
belpgvhlLfbVt9/dQ/9GqoUr7yZd+aqKYTFOHAbAKjBUV+3aErx23V7QAOCmG56R
TcD7Y3MlQuh05SCZrrnAaaB82JJhp+sw+FHfnq9du0oBuhk3gXmf+1y7Ag9b1HLg
m8Xpi1orUZPm55ozDTvrbMKPEUknuoM1muxIjSVOaRqH2c3FFK3SFhjel8NZprY+
A+JH3MIEen+quSqA+lNs4PGnDJm+LDw46ZfsnDrC7HbTCkcXZuMVRBNLq/F/8cj2
/F3cw79ghmniC0YLtQ0IfwkhXoKCgDIm2GMAuX6yrvkbsyJv56kMP1VR77FzrKyx
nnpJiHo3Ty+ZFSbLkR4BCAp1CupBLJJEQWHBodUKNxO7XmVrFTtwRxuCiTfp7GKX
cGDERWoNqlnTJUgcyUt02hybmaPmWKXwm1BcE58VIExIvE2QoA+wq4xiUblNlo3O
yQvWavkNKUctHrePOvfn9hCQyy5sUzt3PgUy+mW0yYanh87YjgM=
=uTaW
-----END PGP SIGNATURE-----

--2tvphu7xbraelwml--
