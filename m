From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/7] i2c: omap: Fix PM regression with deferred probe for
 pm_runtime_reinit
Date: Thu, 11 Feb 2016 18:34:28 +0100
Message-ID: <20160211173427.GB1524@katana>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455145370-20301-3-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "Rafael J . Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Wolfram, I'd like to merge this along with other related fixes via
> the ARM SoC tree if no objections, please review and ack if this
> look OK to you.

Well, since most patches seem to be picked up individually now, I'd
prefer to do the same. This is v4.5 material, or?


--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvMYjAAoJEBQN5MwUoCm2tI8P/iG7TLX3h5d14u9u12bh4qR9
o+soGafJJtaPKD9LP8VbOOSb3jLurtZ+V79DN0xuOEhTk/V4KrPUIFPVuLX2HCjv
kkYFrcaJb9/OC6fvDN3fainZQMMqbSNEIhEXKaYkhpbV9cUQchp8o0+olHmcZQ06
1H61F7jcxxG+fpUEHQlmaIdkMV1IIR3/UarjSW0yl5oq/I0KLoWHVpejcsm/bVaX
NSPPnIK4/nD92FyFdA/X6+IQ8vt9vNxj64DkZttnZKuSZbEC3CkcGWmDeI6jmOdA
E5yYSLarvoTRtv9SJsLG5tCNNGzMkko40r8ZEYITUywlIduNKtBqHhvhW1iw3Qiu
rV6B7pcaF2J5my46Er2DMy+Bo5FECG4cgLAdCzR8cKTL2WLNp/rCz7BtUkcBGgig
9TGC1Y8Dt7Hs0/Gz9M8iw0VONxkplQDjukWElIbG4a7JwZOh4Z3cqQaQx9Ykp6l/
9ScX/lZsjgCB0TMvFv9Cu97bIbEN+yt6VmZ3lDGHVZj5feKak5NjphaUP/+FPaE7
X5ORMwByctd+4zAzO2ScUBQGdMm8iJCvckeGdqxuhDEeYlriLAX6IE9zUut3Pn8q
2/6V3EawJTeqdJh2p8TMqVPsmDzXMTaI+O7+NbiZw1Hi4ZztUlLDatFk+BIiQ/mN
pX/dgdvKVoapY+4SOd1y
=KPxS
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
