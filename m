From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Unsynchronized access to spi bus by mmc_rescan?
Date: Fri, 22 Jul 2016 00:12:41 +0100
Message-ID: <20160721231241.GV6509@sirena.org.uk>
References: <20160422212842.GB21636@brightrain.aerifal.cx>
 <20160504224445.GW21636@brightrain.aerifal.cx>
 <20160721204451.GE15995@brightrain.aerifal.cx>
 <20160721214015.GG15995@brightrain.aerifal.cx>
 <20160721224308.GT6509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="80Ds8Z/hZmemMosa"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160721224308.GT6509-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Matt Fleming <matt-HNK1S37rvNbeXh+fF434Mdi2O/JbrIOy@public.gmane.org>, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--80Ds8Z/hZmemMosa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2016 at 11:43:08PM +0100, Mark Brown wrote:

> This underlying issue is that we are trying to use one mutex for two
> purposes, the existing mutex is mainly being used to serialize access to
> the physical bus but the externally visible bus lock is there to ensure
> that only one caller is able to queue new transfers which is not the
> same thing at all.  It is completely irrelevant when we are pushing
> messages to the bus if we are doing so with the bus lock held.

Just sent a test patch for this, completely untested given the hour but
hopefully you can give it a spin if this is easy to reproduce for you.

Rich, I also just noticed that you didn't CC any people on any of your
postings prior to today.  As I know we've discussed before you should
*always* directly CC at least maintainers, you can not assume that
anyone is going to see anything that is only on the lists.  This was the
same reason why your top posted content free pings didn't get anywhere,
most likely none of the maintainers had seen any of your emails.

--80Ds8Z/hZmemMosa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXkVbpAAoJECTWi3JdVIfQZpIH+wSjpwLuXh2+uhiGlFvhe1qV
hVh1NkS+76V3khxjUT2eTNAoUOOKAFC9UOF3aFxvx7cK9ajaz7pSdle1FgJVg2F0
1ppoPOSsr/MChLapp/VJy+kUxkTi7XgaMOtoritJA7z2MIkz+/d2DY0W7Ek7xH8n
vmnFxWDL23aekL78qifU7zNQxqFDPyvntns31QrWs0DOY/HqLfagtkkUxySYw02D
zRkafleNV481fL0GDsY3IbCyL5hEXymsIoLQq+Hf52j7Cp7t7wlHkQX3zbLJP3y4
DtrJOVHuv/PH+O18aKCPQMulkDV0w8IBo8ciZe7vTQO4Q8TI079hBC+s2mHtKcE=
=GUXX
-----END PGP SIGNATURE-----

--80Ds8Z/hZmemMosa--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
