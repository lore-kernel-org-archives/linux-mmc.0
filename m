From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v7 2/8] clk: sunxi: Implement MMC phase control
Date: Tue, 18 Feb 2014 15:15:32 +0100
Message-ID: <20140218141532.GH3142@lukather>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100221.15040.47203.stgit@pagira.o2s.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBE6YRWMAKGQECIGUC2Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140217100221.15040.47203.stgit-pgFh0Jf6HD9Xzn/AsuzBOg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 17, 2014 at 11:02:21AM +0100, David Lanzend=F6rfer wrote:
> From: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
>=20
> Signed-off-by: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>

You're missing your Signed-off-by here too.  Remember, for every patch
you send, your Signed-off-by must be there, regardless wether you're
the author or not.

A commit log would be very much welcome too.

Now, down to the patch itself, I remember Mike saying that he would
prefer adding a function in the framework instead of hardcoding
it. Mike, what's your feeling on this? Would merging this seem
reasonnable to you as is, or do you want to take this to the
framework?

> ---
>  drivers/clk/sunxi/clk-sunxi.c |   35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index abb6c5a..33b9977 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -377,6 +377,41 @@ static void sun7i_a20_get_out_factors(u32 *freq, u32=
 parent_rate,
> =20
> =20
>  /**
> + * clk_sunxi_mmc_phase_control() - configures MMC clock phase control
> + */

If you don't go the framework road, some documentation on what are the
arguments it takes and what it's supposed to return would be great.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTA2sEAAoJEBx+YmzsjxAgCMkQAI2kyBm+/uq0g4rIozLMUInV
exoluhSH0iqlEXJh6WK7/gAAPsR1NvQeYmzmblKR2QcmeQed3xIQ2iLl4VT+b8e6
lMZLmxWgJzZNZpDiIQFFZv32KtvkY5thUqAemhgK1NPB4m0VoAPhtHZTi32NSuTN
zG5a/YlCtXFqZKbpx81caPqrmwgFFTHGur/DS70MXRSYDmukq0FW3tNpZ28e+d62
lZi3SdAy1TBJJ535XDnskdF7s9BDdmt7IdXXekLw7Qfz4Eu63thD1+DsO0qLayd4
GYuOlWN1CYDNp0UwFNVQNhnfrDLx+NjsA+HK7UJbcRrCe24zqLujulaH9IdOKrj8
tUa4m6q2mzhPCdFvCNzmefnjq4W3XYsEgAdAWaj95IEWY9IAD0lj5dUsow8wKq8Y
aV/L37+I35tZznE3z87E/kZH70lzR7tE73bVBuX9vtiLRbWKjRUgqS20GKURxx4y
jAdmD5c0CtmI0vBBqtIwQGN520iQKjOs60vqJyZC5G0B1nFZ8/iRa0K7Sew/8wBp
uMqzW3YDlJMxZMHUJ3+1DdbW5KT3k7uVk3pvAh40PG0LuQrCpIzKM4We/GlakVDB
yL/V1m7erqJJDfB6Gb5Fyq75UqEHDt1er63XIcmAspVwFYs4EnqBR8wAAaDhDE+h
hGq4rhGkLqiLUI9B2Efa
=YYKH
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
