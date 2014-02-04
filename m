From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/17] amba: PM fixups for amba bus and some amba drivers
Date: Tue, 4 Feb 2014 18:49:09 +0000
Message-ID: <20140204184909.GT22609@sirena.org.uk>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9LnWyBss4uQTlezA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--9LnWyBss4uQTlezA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 04:58:41PM +0100, Ulf Hansson wrote:

> The fixes for the amba bus needs to be merged prior to the other, thus I think
> it could make sense to merge this complete patchset through Russell's tree,
> if he and the other maintainers think this is okay.

What are the actual dependencies for the SPI bit?  AFAICT it's probably
the first patch needs the bus updating?

--9LnWyBss4uQTlezA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8TYiAAoJELSic+t+oim9pVoP/R8rI+1Ffz2UfTaJ72AcKLgz
gZxsn12hQIOOKoB/RXI2qF6zJj09JIsO5u47CkjJ5IaDAmCY1s5sJxqo1o1shwle
pTWRflDp7esLDdQeitkPlfyzfELmqteUN4flCZHq19bBjN7+lAkgFoAuctJPqN8N
QsY3qv1K35SkQ4lV6JRUpX7YS5tB6rTqOkUMct30wuDYgDqRGqt8gASl2FT/CIrG
9kC5teiCunSstqb5zF2jEury7HdeqovRXJA2bAk5jV3ephlyKYboNsDQ+cpRBhrO
lVzYRJ15g+8GZO1RXikum18YyRyfKPeD4RfQt5BV8ID5Z7S0JcqgmD+6vbBOJo7a
CRv2OFO+l1czH50UjVyAA3/RUGjiRvScnd6ARLfEqdyb3sXxwltbnxn2Ja71ZRXx
iYaGu6CKNmjhXL24JBDCDqs3biMwbGiYek8hLh4JSMapsdDnN1DhRV5JDOrHwGuK
Ug8rflPflwBitCS1fH476MUTT9FDVg93D/RnyvN8t/HTyFj8m8az/6ojurBUK745
t3UUUGZNvAsIQ/19yLG1Uf2WdUsVD7sLs3cvv95oYJCEd3cklR5eoBB5jqKX48aR
Saibmy7zsYn7awBLv6NUZBkTkhSbA/h4aAmhafAdLnP7pH8SKhzgCoDPh63LFCZc
phCnP+GmtkNuvKjagVW1
=xvOJ
-----END PGP SIGNATURE-----

--9LnWyBss4uQTlezA--
