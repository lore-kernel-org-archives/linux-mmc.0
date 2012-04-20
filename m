From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH/RFC] sh: ecovec: switch MMC power control to regulator
Date: Fri, 20 Apr 2012 18:07:44 +0100
Message-ID: <20120420170744.GC3080@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
 <Pine.LNX.4.64.1204201850180.3974@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1204201850180.3974@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2012 at 06:59:41PM +0200, Guennadi Liakhovetski wrote:

> +static struct gpio_regulator_state mmcif_power_states[] = {
> +	{ .value = 3300000, .gpios = 0 },
> +};

It doesn't make much odds but if you've only got one voltage the fixed
voltage regulator is a little more idiomatic here (there's some overlap
as they've been evolving separately.  No harm in gpio-regulator though.

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPkZfaAAoJEBus8iNuMP3dw8IP/0qnKyU5HHudd5Y+YHuCKCEC
aF/SThj/8zAeHFK7pdV5cJQfH/k7I+FnQCVPtbVIZz37l/fjbE2Sc4cLK1F0C8f4
yoOmkOEIkKuI37b5+60EKeV3oSOVyQbJpFa8z9oELHnzucR2xPTZqi6YupPY8jJA
Z4Ur3NjpMqcNdhG4ySoyPUOpHRWF4ulDnLvoWJ45Q44x300l3d/QtQfk3hXui5s/
5aImVt49eW+w5eM0+b7QqnswK8J7nyKw8ul3zkYR+SO4YzfHyPMRv2tJxe1mzDtt
rWU9f3YE1SaAHfNyr/Jz2j7VWaf2eIJH0uhQOWxT6CU1fnJd9OMe+Trxm0EaAL0Z
OP0O+OV4yHOpa1I9YIBsRR86r9vDeYHpVO/8ffkINffiSwSYV560V3Tghto9duwM
z0612FORxRZK9iZjp0bwYfo99iyz9Nhk4ktYVfxvmoCedOfB9iHw/QQThRJcKAG0
94xVSExsMeu+25RzYUorJCEF7oZVfrLviIm+SpeXos+2KkUKm6Lnf2nakRaCjsu9
j20MHt73+nGSpVjFIoH9Aus++4Kgi8NigAgstrff/TtMHOgTRapwmIHbxqnuSMxn
VDUOqupTekISzm93OvVIii9ohBuE29Q2CSRaOPoXz1yv8n4BtTD5zzFSlVZJUMHl
rbuu+AxUWB6mYAZtzYqY
=vt/H
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
