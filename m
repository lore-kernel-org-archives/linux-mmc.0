From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/17] mmc: mmci: Put the device into low power state at
 system suspend
Date: Wed, 5 Feb 2014 14:13:58 +0000
Message-ID: <20140205141358.GJ22609@sirena.org.uk>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-6-git-send-email-ulf.hansson@linaro.org>
 <8738jyu1h9.fsf@paris.lan>
 <CACRpkdZt5+t7b0_a__2kJP4V9PS2cyXmguWrST+fzbKCnosi7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NN0dgmCSDRRJ0kp/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZt5+t7b0_a__2kJP4V9PS2cyXmguWrST+fzbKCnosi7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--NN0dgmCSDRRJ0kp/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 05, 2014 at 01:49:49PM +0100, Linus Walleij wrote:
> On Tue, Feb 4, 2014 at 8:22 PM, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> > I'm trying to thing of a good reason to not make PM_SLEEP depend on
> > PM_RUNTIME for platforms like this.

> Isn't the typical Android platform using PM_SLEEP without using
> PM_RUNTIME?

No, not at all.  Android does make aggressive use of sleep but it's also
highly desirable to use runtime PM - for example you don't want to have
to power up the entire SoC simply because the system is getting a new
e-mail pushed to it or location updates, most of the hardware is doing
nothing.

--NN0dgmCSDRRJ0kp/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8kciAAoJELSic+t+oim9RHMP/1sOol6uyBPyCeoYAIDa1zv3
JmyludROrGMYmnRCYTAIu9P656WfkYpjqrXJW2dQms76B9XCgkCoLedvbai3acz5
CFTUVv3IPjSARmO6J73+9K6Ivpy2vraQCrfA3bkVyzKApdtl5SWidjRMH6ISKpS+
m9hDTzc2ND0OJuLt/xkSc2khGsKIcFrNkjHAvfePRzzwOaCXXC1RRcU4CpYHSG7g
olGw5HX+u5fWbq8o8TNKGtKlAVLR24KVafwjBXw3/RCSKAGAy1kgYsXLCiAkrnQ5
nnTcUD4Xyw+jT1roIPONZr9cKjpMka8aG6k7pJO3ti5oztzV1mO6MTpAApm2Ww8W
91D5GJJNrNROnHhJlt8etNPrT0Xr52oUX+Dy03pNqYEoY5y4yhUOFM1QOIc7/l0C
KBvVFZ2L5asB7AqXvz0qCvvlZgorjwPTqWhvOfSZYGWcI/WyIh5HvxZ5aESjttBM
GFLOmLt37snOuzyZYtDwCh+LxFmzfdMNega2lNL20AXjLZah+/nXGUTQ/LFFxoH2
HsCHOnyh0ELcEc+Xk4nTCY9X72k0hoZdlwMrhAFuZ/NhXR8YQs010Vsd0+loIH7e
+ekxhy8RJYpr8QFRFPrJYWR/68wlRSInxWMHXlDu4Dkc24qa3Zkv3sATzzSQJpfI
8YT+IczGa9wjteaJOVBG
=8X+O
-----END PGP SIGNATURE-----

--NN0dgmCSDRRJ0kp/--
