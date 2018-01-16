From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 19/22] mmc: tmio: ioremap memory resource in
 tmio_mmc_host_alloc()
Date: Tue, 16 Jan 2018 10:44:22 +0100
Message-ID: <20180116094422.2m2iotvgwzx6jfiz@tetsubishi>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-20-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dc6rnypxybjuatak"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511540697-27387-20-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--dc6rnypxybjuatak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2017 at 01:24:54AM +0900, Masahiro Yamada wrote:
> The register region is ioremap'ed in the tmio_mmc_host_probe(), i.e.
> drivers cannot get access to the hardware before mmc_add_host().
>=20
> Actually, renesas_sdhi_core.c reads out the CTL_VERSION register to
> complete the platform-specific settings.  However, at this point,
> the MMC host is already running.
>=20
> Move the register ioremap to tmio_mmc_host_alloc() so that drivers
> can perform platform-specific settings between tmio_mmc_host_alloc()
> and tmio_mmc_host_probe().
>=20
> I changed tmio_mmc_host_alloc() to return an error pointer to
> propagate the return code from devm_ioremap_resource().
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--dc6rnypxybjuatak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpdyXYACgkQFA3kzBSg
KbYUpg//aPP/JzY4FCSZ1+y0wQanBo1l84/ptPXWPY/2W3JF1Na9F3JFMob4U8QV
86+kh4+zm7xX8IHIPf/R7V3Dt2vj9e0mWshQwxRk/GC4Y2dXMN3eYm5WV79Ho2xq
oVsHr2VknGMZ1XMJSwFBkKjudPfZCcaALaYI9Gdk2Vp3DFTACoSFUFyi0knvCcqv
5fd/PvOvWXcaLwyZX9EkNtVlehP6yugfkScq3GkPbsJdv5VhX5gZmEShwEyPhWHs
aaNw0x+ZDmi6+Mz3rDg4c3/L+9V6IYrsHPr+VScW7u9n942rHHISCJttgMgIZ0B/
ZcJGRRB89g/iKyVlfTihHo0+pRaz/xOCAWzYn7LTSyP6ghM7JNIFbDVVBR55RBmO
h1Q5KpTyUrUSXbq+qoQ2SZewCpXWs/mhD3HEXXy9F8LSG31a44BSwnEjHB096v3U
XgqSCjF2d8pV5SyO3A8CZJhkgEcagYRYgGzF1ralMShEPrJcBJReRdCfrwMoW96V
+SJBYvJc16Y3UUNdBahDGpCyn2xSh17QyusRYGIyQDaYbEia6uRkVTDFL1Rexo1O
oK2X7ni4rl/r6/x0D6P4cVMJ/MZaovobInPoOpnSKAuCDRTNv5QRkGwq5mACX/tD
AvJ1R3yfJkpwxw0YmGCvTmwNzWsj0TqUnoHkRrk4s8O3UeZHyKo=
=HU2N
-----END PGP SIGNATURE-----

--dc6rnypxybjuatak--
