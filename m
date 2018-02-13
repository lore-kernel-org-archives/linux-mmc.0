From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/3] mmc: renesas_sdhi: add eMMC HS400 mode support
Date: Tue, 13 Feb 2018 14:01:14 +0100
Message-ID: <20180213130114.frishm3mflriz45z@katana>
References: <20180119133906.11280-1-horms+renesas@verge.net.au>
 <20180119133906.11280-4-horms+renesas@verge.net.au>
 <20180207222143.mscy7c2gi63jbvtc@ninjato>
 <20180213113843.enfk3jhjgpfvvlsc@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4q7pgkyodbwwuq32"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180213113843.enfk3jhjgpfvvlsc@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--4q7pgkyodbwwuq32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 12:38:44PM +0100, Simon Horman wrote:
> On Wed, Feb 07, 2018 at 11:21:44PM +0100, Wolfram Sang wrote:
> >=20
> > > +	/* Reset HS400 mode */
> > > +	sd_ctrl_write16(host, CTL_SDIF_MODE, ~0x0001 &
> > > +			sd_ctrl_read16(host, CTL_SDIF_MODE));
> > > +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
> > > +		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
> > > +			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
> > > +			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
> > > +
> >=20
> > This looks like code duplication. Can't we simply call
> > renesas_sdhi_reset_hs400_mode()?
>=20
> Yes, thanks for noticing. I will make that so.
>=20
> I think that the previous few lines, not added by this patch,
> can also be consolidated into a renesas_sdhi_reset_scc() function
> and re-used in renesas_sdhi_reset_scc().

Even better!


--4q7pgkyodbwwuq32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqC4ZoACgkQFA3kzBSg
KbZejQ/8DISG5gGCRS2XVQbeuovTD1pSuBS/wItwXbhKiuF2nAbw1B09w3JuGRtN
MTpWxDME59CoyGSYGsqMqaiLFkbvtGJP5IUXbG5IisMzj2YaHctSAwWfjrNGNBcS
64M3rZ9RC95oez5l4UO5dkC7b2XstKZnNRvdn+qoMQb2LTAOqVdoBuecMXE7tLCr
04MB0zRM7hlvVgRl7YV5MKqMqvuCgGHoLsar5QbxIgRen+JZ0+GwvtEWnrsmutVe
whsGhY6ansyZtSzTqlxjv+RL41TNI1vDBjXcAbEOnrcAGreEyT+76h8uo7YIdidT
TMtnSdO16+EOn27nYnxDGuDfiVZaMhOXQFxkgJJh2a67ry7q5EQsFg57/+gTYT+F
rXT48K2NT6yyVwWGE1SSd7tZ/QRCUt/aTtJe1JtY/ZSTe3/fB7RBqWX+AHCYiwrp
bWxvCpgvaZmsobh2as5VKS/TV2izRE/DdUX6wAP9Ysgh5+NysRvS29rHaJQKb0gd
jEzMQemOLvhOFw4dOR0SDCiKIjwjrkmtsqjntMpYRJdHknzPquYb0a9U1i03gpWz
kuMVGA3hM207nqJHtNAVmU09+D37Q9nStUvd5iI32zHhWMdQjWJCrNefmHV9ji1v
NSZemrcm7Vb+5B+cin3YzLqwk8Fypi+YLPVchOkm1sFzbgpSbUw=
=Cm0r
-----END PGP SIGNATURE-----

--4q7pgkyodbwwuq32--
