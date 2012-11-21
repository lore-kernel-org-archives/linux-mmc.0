From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: add missing prototype for
 regulator_is_supported_voltage
Date: Wed, 21 Nov 2012 18:43:53 +0900
Message-ID: <20121121094350.GQ4673@opensource.wolfsonmicro.com>
References: <CAMPhdO8uuNmdiaejcypOH77rsU2ZR+dov73KXyAsbAfW0tKmcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pwWdILMQNxDD/Cps"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56404 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754076Ab2KUJoD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Nov 2012 04:44:03 -0500
Content-Disposition: inline
In-Reply-To: <CAMPhdO8uuNmdiaejcypOH77rsU2ZR+dov73KXyAsbAfW0tKmcA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Philip Rakity <prakity@gmail.com>, Philip Rakity <prakity@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--pwWdILMQNxDD/Cps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2012 at 05:22:02PM +0800, Eric Miao wrote:

> +static inline int regulator_count_voltages(struct regulator *regulator)
> +{
> + return 0;
> +}

Looks like your mailer has mangled everything so this won't apply.

--pwWdILMQNxDD/Cps
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrKI5AAoJELSic+t+oim9C/UP/As7Zhe+4TLAXpmM9gLkqYeB
+nzNLZPAeYIyQY1tLDo/0FLTn+Uob4kOA47JwmIl80MpPq1WILvkjg5ktmJC8vMK
Wl850GMqCMfTRPigZ5gUXVhsHdTt+HVX4ahpoUgWcUWiaKYFnUNV76VsagV+wj0a
wo2BYfRa0o5KzrRWiFXIDFisFpjqbkv8Him5INAXfCe28eje6vAC9/rm7qRDd8b3
7Rbx3l6ptbC0nP4uJTlyZhYd+Rh0LzjvIXMVUyQAWSDV/MnO2b1SiRj12aXbHEsl
RngiVOYKe3IpJJqggatq1XUaQjdKsabN2L8Tt4wzoaIZ7NifiIJp6S8WLHIZ/wp0
FjkQsGoY39fqXAlL4eoKpLCVI8PAkPOrvY24mWvmhW5TAt1yy8TjOgpUT/RiwNfF
3gSUWYHDSYyOsG46CTXnfgX3K0mUKScsgf7KzLmn4gT2A4ds+1h3q943xMALHgkf
FbFmQyUIpTVBQtV28ghHZAa2YayjyFWQT3KuQnH+irwbNLQU3alkfc+EnlL6MmLy
zjgV0alNfZNT9gG98SFE9oHmiNN3ZTL1PHG74hSuWTf9hcO2Mfxw918ul1TfuerZ
NOhmebn/Ut9F8LjsvjUYXWjlamu46ojjj8IEFb/GHesDHP8iguc+yYYaWdgQlvHx
reGmcoDLeABO3YoR9yZi
=qLJa
-----END PGP SIGNATURE-----

--pwWdILMQNxDD/Cps--
