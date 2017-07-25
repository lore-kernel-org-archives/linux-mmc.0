From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 02/10] clk: sunxi-ng: Add MP_MMC clocks that support
 MMC timing modes switching
Date: Tue, 25 Jul 2017 09:32:50 +0200
Message-ID: <20170725073250.vpxugsrlxzhsn2tb@flea>
References: <20170724135905.28855-1-wens@csie.org>
 <20170724135905.28855-3-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tn4bdhsbqikmo5hf"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724135905.28855-3-wens@csie.org>
Sender: linux-clk-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org


--tn4bdhsbqikmo5hf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 09:58:57PM +0800, Chen-Yu Tsai wrote:
> All of our MMC clocks are of the MP clock type. A few MMC clocks on some
> SoCs, such as MMC2 on the A83T, support new/old timing mode switching.
>=20
> From a clock rate point of view, when the new timing mode is active. the
> output clock rate is halved.
>=20
> This patch adds a special wrapper class of clocks, MP_MMC, around the
> generic MP type clocks. The rate related callbacks in ccu_mp_mmc_ops
> for this class look at the timing mode bit and apply the /2 post-divider
> when needed, before passing it through to the generic class ops,
> ccu_mp_ops.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--tn4bdhsbqikmo5hf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZdvQiAAoJEBx+YmzsjxAgElMP/jeTumezFSsUsQzj7Tiu2zr8
0oWLqezsVZDipu3q6+dFqFICL3I66XcyujtujLg/lxVfRjqUAH8DPRuTLKGXDECe
dZFqpgEK+WezwElK4Qy8/bxbr1XDjjDRMt2FJ9YgTw/Q9NDRINEYeTH3NNQNsBhq
cJzdRihw6e0IT4SAkoLIUEmLtggVYji5C0d6j2VzjRcokROdwj267VxReUkyOl30
h2JJC9VLzkDwZmN8tu6dMmJDP4FLh3u1BlWivCRGHdnFV7tL6IJH3z2C/t2Mt5MP
s01ZrGR93+GkM/PZ2OiitNshJugypj2iuEwArBKEkJi5qiZUPyz+aMjzw7ADqOdi
1/meSfL1rx/b0VjJdSoW0I+2QncL8utr1IG0DTQa+g/jiCd7JoKTd3QeULdHA6rN
OOKM2LfjMbtd4pqjCCBGSmd/E1Er+EQ0I0JZIwkOM7pTKI+4m1oP9MJvWpybDxDz
v0u2Hbt/+fiSVh1qnujAKhnHArcm6JcoZLjwlH5I+unOnb8lj7lRWL69SffKjma/
H7dk3RaSB1YBQYvHaCJGOWXHeuRdOhcaFffHQMK6H2uuq8V0/3Pn7ouHxUwCGvMZ
Fhp8DxUS8d2odReORr/hRt5nMzTO9dVDEQkvwgkDzR7/fI0pDi8aYHPEG3gsnIui
YcZIybpgJ7ct3bIEb7AQ
=Ufib
-----END PGP SIGNATURE-----

--tn4bdhsbqikmo5hf--
