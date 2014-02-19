From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 06/17] spi: pl022: Let runtime PM callbacks be available
 for CONFIG_PM
Date: Thu, 20 Feb 2014 00:10:40 +0900
Message-ID: <20140219151040.GH2669@sirena.org.uk>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-7-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFombL2-Rt46QpXPNWe5PeGQnOGmQQNfYd5MdYdEePn-4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4FPEP2OQoJToMU+c"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFombL2-Rt46QpXPNWe5PeGQnOGmQQNfYd5MdYdEePn-4w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--4FPEP2OQoJToMU+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 03:20:07PM +0100, Ulf Hansson wrote:

> Also note that, Russell has already applied the corresponding part in
> the amba bus (patch 1)

Why would this depend on an AMBA patch and if it does surely the two
need to be merged together somehow?

--4FPEP2OQoJToMU+c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBMltAAoJELSic+t+oim99zkP/j/xXWSCyg6KeVYXGT17LNZl
Ahj9b7lhCX9OQ+Ck3pUTLZPIcna7v/6nTjYRh1cW/nPj6vyjqmidlATEQqy6Lz+n
TmfxUIPy9pVFYfHF+nJTZa2LJa57COlwShCOwTqiws3H+zaX8+VBNRC72ockUoH/
6t58ir29hbingGybeKL9K/cM3Gq4juAQ9BsJhGuUrntNRSdQfeNpYJZc6igmz6TD
rw/uQ0uaHDleSs+LlRf87VqxfRYYXFEIAKunHctLV61PQoKcWxGMgOIKwBcA+gVh
MBji3dJS2zT5OhokKd51y+e8E2a9mFeohudxHBHFSk4lAXLGTRMf5GcnlsySuHud
8RkyH2B/fwVdmVjF7x4qlhPfQs5MvDhghPXpTYyB4kOurtJ01qrXW7lj6Nos6Yfn
4LZqjwoQRmyjdWXVFjXq5bc2CHzM096PYuqsR5m85aYHKwyMCWFbHx/MEgsfeKcr
jLD3RYaxMVHCUhy7wzSi+FONpawa0YW7WXPsdIWiwW/ei7jzZNJENNVtAX5QBT1g
WLOShXyX6npWKTgvR4ektWEAWlMFiZeYJIq7s9Kwz+v8bhXVTcTTAQhKZKl5U8gi
3DUvUZR6ml/l4dB82NU6j3zN0kiKwJJM9cza0tu+5EBP//J8h6y+KlVAdBYOYfSi
ULKfGg33W/QJxcFMkVpt
=Cboj
-----END PGP SIGNATURE-----

--4FPEP2OQoJToMU+c--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
