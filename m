From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 5/13] mmc: sunxi: Mask DATA0 when updating the clock
Date: Wed, 25 Jan 2017 10:16:13 +0100
Message-ID: <20170125091613.hmlqoeh6hlqh57wh@lukather>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <c36c2e2289ff3268d4a57b265f23725d882a23ed.1484585798.git-series.maxime.ripard@free-electrons.com>
 <CAPDyKFpX14Ojse_0gZZtQiUtSP_w9tN+Wu5OBx2Uv42FLSY5OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ml3hgkidtpfvanxm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpX14Ojse_0gZZtQiUtSP_w9tN+Wu5OBx2Uv42FLSY5OA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Andre Przywara <andre.przywara@arm.com>
List-Id: linux-mmc@vger.kernel.org


--ml3hgkidtpfvanxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 09:18:46AM +0100, Ulf Hansson wrote:
> On 16 January 2017 at 17:56, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The A64 MMC controllers need DATA0 to be masked while updating the cloc=
k,
> > otherwise any subsequent command will result in a timeout.
>=20
> Could you elaborate on what mask DATA0 really means? I don't follow.

To be honest, I don't really know :)

This is how it's called both in the vendor tree and the datasheet. I
*think* it might be the first data line on the bus, but I'm not sure
exactly why that would cause any issue when updating the clock.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ml3hgkidtpfvanxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYiGzYAAoJEBx+YmzsjxAgdUcQAIbpWuWV6VAdA7mYR+XY6OIO
/3nnh2721twIj2KFwwfqtqVTY4qMslOI4lefqdRcUOrC+BwPiOJqj+cyCWXsbxMA
AxuBJdELagdPMnhgVn3rgsd4DHGvMMi1uoe9bo9JOzgRdvFohAvReTDIQOH8GRdH
4e4ncZpSZAmCE49zN636bxVsGtnpPGUYePuq1sN3el05rm/po6qL2XmezskjjuuS
V3SATQb4fe+mpZb2+BFKAlEfpliK4HHHs4wjc/eh1jRkfux8X45R2sX14dbjRllu
/PtJXRfbGCHsIC0VcoqRaV/ctEVCEJUGKlm3H4LYmu22BMWL7+v3x5Fj1/omAJhy
LHjV6J8cLfXDvVSkAuy1puTmZzYkhOplWE+ANTwX0ZU193ONuW29zTOHtMxCIkcN
lvkU+VlwyW5nPhurl17PWQ2bX1sLOM8JxVFyUgXCbGrHDDokRiSEt+jUpaDodnkx
S9Ar9bHLOTb7Iw1aeYxuX42FObQxN2aZJe2fd5eEHU44TqrOUuMsDVK1kpmteiv1
zLPFgCkwZWx/7/vizACno21kBqKhRRQBK47mxzcI+AnD8befA9vZxNKC69px/rsp
Vn5FP8KdVHrV27nkOjkXtOmEMH+DV3EaSjHb8TWs4cZ0P2LmXCZ3tW9r976nPVae
woY2Q4E2qX8ApoMt1/Ym
=7Khm
-----END PGP SIGNATURE-----

--ml3hgkidtpfvanxm--
