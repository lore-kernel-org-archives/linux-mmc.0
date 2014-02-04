From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/17] spi: pl022: Remove redundant pinctrl to default
 state in probe
Date: Tue, 4 Feb 2014 19:20:41 +0000
Message-ID: <20140204192041.GW22609@sirena.org.uk>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-11-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/z4P6UMu7uOEsbeQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391529538-21685-11-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--/z4P6UMu7uOEsbeQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 04:58:51PM +0100, Ulf Hansson wrote:
> The driver core is now taking care of putting our pins into default
> state at probe. Thus we can remove the redundant call for it in probe.

I applied this one too, as with the last patch it looks independant of
the runtime PM stuff.

--/z4P6UMu7uOEsbeQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8T2GAAoJELSic+t+oim9MWgQAIJUzM6v/rxDmFZOtPEr9BkH
CWEZ2pLg5tHvcD3YkzFSJaIXsHXpru24Qp7v1zVazJ0ZBDKuvcjMkTERbTvwVVl3
A+3d52Mi5SjEDTm6JnaOlta4PsF94HG4ofHKHhisPmK88tOHlrWvTVKpVw5o+Rxu
TsaBw5hy+fx2qRs3H9gVOlBaTCYrYC93gI1R5IcI1ovE84JJaHCc8ib8UiQmWxRy
G7QPDrqU+zi56yPS0TT9mEYUWcuT+TpDWXUJUTyy59H15P7NVsPit4afpFDNL9GO
koSgDNJME7BB0ZoC80xcEq0HbDqHmZeoH8hyeg5b57TlURbxD41wpzlMdZni0GFt
Z5KidIjR++JLERPiWyO782zAcAsP2MZ15gEbL7FgUB8JaOWJYA9skDfM8owX8UXd
TSk/n1kF0uq+Yn8K6t7FWMwAHNbluxCpsjyd2QI/X8XHkaiTKdUGazjiHbSblL2A
m5Hz2M4bgA3PZfXqvofZuDR6o7zIteWRFk1X7LOUDwuAOM4g6ipfGHYs0YlUYeAq
1nARTNtoOWVuSZY2tkxwaO3l1oLQkuk0d/1y/HqiEkmA3qeWi+LuRhJWlmieZVJU
vpSFPiV1XpTFjLEGcTzbOfO/tKLQxZEwufBVdzjYQpEsWXKAjlyREaiIdHLWNtXL
eOaQw3KUxdu0rORzgEdh
=miYw
-----END PGP SIGNATURE-----

--/z4P6UMu7uOEsbeQ--
