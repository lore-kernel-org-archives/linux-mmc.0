From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/6] mmc: tmio: set tmio_mmc_host to driver data
Date: Mon, 20 Nov 2017 21:40:39 +0100
Message-ID: <20171120204039.ubskujnlclwr7pwb@ninjato>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2cshlbkuthi73czh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510042172-27220-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--2cshlbkuthi73czh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 05:09:28PM +0900, Masahiro Yamada wrote:
> The remove, suspend, resume hooks need tmio_mmc_host.  It is tedious
> to get mmc_host from the driver_data and pass it to mmc_priv().
> We can directly set tmio_mmc_host to driver data to clean up the code.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--2cshlbkuthi73czh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloTPccACgkQFA3kzBSg
Kba/lRAAhRQTPjvX8OTCM57ilXZluF62gn2K/FCH7mb2it1tfyoI59sQE+yD+45N
XHLr6oZXt03oXo00PcOCEmJMEKC5s0um42UfVZvuj7oHLkf/xq1NMcsNgvntpGWZ
I5ZY7Le1in+CddIw+Epw8ICFE3Jfv0u8lp5wb3KJiMg1ZWq6US5Y+6dyU5q8EfCQ
4nDcGZVe5U+A2Eu8IeqtfAw83ek3HZ0ljLcc/H1Wn7MlBAXhlKREyHRwY+SlO3uU
GH6/FwT7Ac6mxBkJAPI1gpiBoYXimAf/A2VBPSwSZO1KwQQdSqTCu6lL49eRWR0x
POkTOFJFNOvHSuykHPrd4rnpLzHHRPnSz/PrS4UeT2UMtW7EFTToWG4ZUzcVhN8s
CAg+4VkZWQ4sq84JVB5cBdrhqNp03Tjwk3dFncA0rrMoydY31axV09wtdacLcHl7
438MU5DkVHhlCIHTw4kWLmrnmZmcxm5WmhZZk6/Hf3yXJY1Q4AQk+sas4oPjoxZQ
HHN4fOWOyYKxvk46T26/IxnB07RNndm86r1XSBELP9tWqbeCAb8KCAtGcwTrJbbO
LTpmv1YrBMASPRC9EZR6Vdu31E7wmzXrbkp5MzZJX1zulIZdywi6zgbQpe/r4YJG
mZj3BMHwuEeBDUyqejfJcYtsvcAPVcPlYo8wlghs0Dkn/tOIRzE=
=dRUz
-----END PGP SIGNATURE-----

--2cshlbkuthi73czh--
