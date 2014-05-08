From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v11 1/7] mmc: omap_hsmmc: compile fix for !CONFIG_OF build
Date: Fri, 9 May 2014 01:48:10 +0200
Message-ID: <20140508234809.GB7533@earth.universe>
References: <1399591018-12930-1-git-send-email-afenkart@gmail.com>
 <1399591234-13089-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399591234-13089-1-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2014 at 01:20:28AM +0200, Andreas Fenkart wrote:
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 8d07e2b..5042a15 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1864,6 +1864,7 @@ static inline struct omap_mmc_platform_data
>  {
>  	return ERR_PTR(-EINVAL);
>  }
> +#define omap_mmc_of_match      NULL
>  #endif
> =20
>  static int omap_hsmmc_probe(struct platform_device *pdev)

What do you need this for? omap_hsmmc.c uses of_match_ptr() to
access omap_mmc_of_match, which is a macro returning NULL for
!CONFIG_OF.

-- Sebastian

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTbBe5AAoJENju1/PIO/qaCaYP/RN9LK9aH9XsSferJeV4P/RT
N5tfholvkQr33PU00R2UJdI1xKxs0UgDTX1X4E/s+NI8xsjYd+9DaaZuR6dhqx+Q
AIQfmaJ2/Qad+BVueiwCOpK+SzUZEdsbi9tLYvlbBpyrKVMfEap8yCVhRcifPfxG
fe0J80dKY8rgW95QI35Fvg+SJ1QJsOhvYAktRwrFbgOu57AQcEOpJajEAmbCMnth
RLiGjU3WaWwXEQuFwv+2+Ku+wAGKChLA4C8hXl0GnzLteAUVu6fcCFrXs0ru8BDh
WkEEARsZJHa9PTPRj31CxTFemu0uYuL6BIGhlZL4nqpabVQm9MTW5+w7Xmlzaju7
8K829LxzAjUUJIWCE928q6UJnZNFOSKfhu/zPeDpc65HkAoHDrmfE38rqgouuC1r
C6raqLrA/acrNgJDIb/IpKFGORdnxn3XwJfCmTMp+w+edr8ieIXIrHGNJAy8i8fo
sKG/Wpo+m6juuPz3X5DqMSA/cjYJYb8pM/aKuNeMfoF8kPtpR8cO3QkzQeSBOeQh
shV4RPv/fxuVJIubwMkf5w1BoYNtxKUh4hWzDWPen+ybC86fI9v497eHS+Tw/19E
ktgzFYNHTwxAaSzbwimRD+u+VQLchRK0gtPDmqFmrdn/I8Ks3jcrLc77Rm+W3vms
5yzwipQtBYDeffsH4ZLz
=hyFF
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
