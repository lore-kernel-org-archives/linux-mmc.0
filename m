From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/6] regulator: pbias: program pbias register offset in
 pbias driver
Date: Wed, 2 Sep 2015 19:06:54 +0100
Message-ID: <20150902180654.GD5313@sirena.org.uk>
References: <1441190853-7133-1-git-send-email-kishon@ti.com>
 <1441190853-7133-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yKkOmjQZXRsvHRX8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441190853-7133-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--yKkOmjQZXRsvHRX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 02, 2015 at 04:17:28PM +0530, Kishon Vijay Abraham I wrote:
> Add separate compatible strings for every platform and populate the
> pbias register offset in the driver data.
> This helps avoid depending on the dt for pbias register offset.

Can you respin with Tony's comment please and I'll apply?

--yKkOmjQZXRsvHRX8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5zq+AAoJECTWi3JdVIfQOTwH/0rKzNXEmTRwVG7+a7Ui662i
ic6zzg0bSG0I20MuxJBQyPd0u5eY9mspJQNwPRUxGpr2nqvgwSf6zo1+60qG6szq
YxmOCroSj4Kp8wEPlLinqsolMnL8Gje5TnetR28pPgm5XstJYiSe7x2XGR3DCPh8
NBcbWNu5NYmuVcPff7dQjmabzST6r/QGsBhZsijwid4c8MaXoHXprvvj4XMl3pPA
2F1CP1j6x3oLSSdYU+vG/xh2wIQUQnZ+E927fF2o9FpJEUt16MK9Q1sWTaHvq7Kv
ppHB4wBkc4bto31pRFPgSPSgLwrjBr+woCtSdkgreXJfugr4Pn/sPNVYFFUMmtA=
=eMLU
-----END PGP SIGNATURE-----

--yKkOmjQZXRsvHRX8--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
