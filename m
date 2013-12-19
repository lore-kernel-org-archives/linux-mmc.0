From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 3/7] regulator: add pbias regulator support
Date: Thu, 19 Dec 2013 12:51:20 +0000
Message-ID: <20131219125120.GY31886@sirena.org.uk>
References: <1386670577-3530-1-git-send-email-balajitk@ti.com>
 <1387456720-7202-1-git-send-email-balajitk@ti.com>
 <1387456720-7202-4-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iIOavGAISvUeFFLW"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387456720-7202-4-git-send-email-balajitk-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--iIOavGAISvUeFFLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2013 at 06:08:36PM +0530, Balaji T K wrote:
> pbias register controls internal power supply to sd card i/o pads
> in most OMAPs (OMAP2-5, DRA7).
> Control bits for selecting voltage level and
> enabling/disabling are in the same PBIAS register.

This is basically fine from a regulator point of view but I'd like to
see some review from the OMAP side given the concerns raised last time.

--iIOavGAISvUeFFLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsuvFAAoJELSic+t+oim910YP/1dfYxYr0UTlh3sg30KaUxhO
oK74gdd45pZKtAcsn7ClQLQufv8MBE3CbgWiJRB00X9KBa77Ua0kwPlkUl6LAp+o
U6rCaF2WaFeyAkICVdGqfWz5Z52rPMVu9TxRilwD8ABRIGxl37JXsIMHWniDtGPq
6AKm3riTvsqbtvz/oN2M/qq+EuW931J7eyyWZA/jcr1kJAfh49/O7+CqHWAFymaA
hdlaYAbaNywK3aq89U5l/i2uOkYCfRq205L9WcZXZSobG/CRPzERboXi9bF0hyDC
cEUwOQzl7SlnK4KOyBDEo3596ebieO5HRajOTKAdY+SrI6h+zEfiAZlfjARTjqJZ
byA1NtZtk1R3CYwt0OFwH/yeEkzyhwm71Y2IBjy4UvOXSu/a7K2q89Sf5XmSESWm
W0NI7zFYSVHvxuQQ7j+MtQ7F7y6h0KOCnsxaKWjVoLV+GEnKfUUlzJvFGiSBJc4m
Lns8PKYrj+bif545XHk6omUDWxJzMKbi9cbYsfeI+u2TRihCWoun+Evs2WgnH944
RacNUdAN17mfZ7MviG/j0+h0qy0TW2hoy0LVVAyM+0vHqB4crNCs+NVYcaplXUeW
zTB3/PSS+T4WeVJLqv/ElxX+YnZb8D5RaRcklEY/veOqZfN88c/3onGYNffxOt3q
kmwlJG9orNVu0FA5fqDH
=EmBq
-----END PGP SIGNATURE-----

--iIOavGAISvUeFFLW--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
