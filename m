From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: Where to power on the wifi device before loading the driver.
Date: Thu, 14 Jun 2012 13:12:34 +0100
Message-ID: <20120614121234.GC3913@opensource.wolfsonmicro.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD90352.9090606@wwwdotorg.org>
 <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120614063120.GA20167-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mursalin Akon <makon-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "'linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "'linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rakesh Kumar <krakesh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 14, 2012 at 08:31:20AM +0200, Thierry Reding wrote:
> On Wed, Jun 13, 2012 at 03:17:06PM -0600, Stephen Warren wrote:

> > The core of the issue is that:

> > * Tegra30 support is via device tree.
> > * We have an SDIO bus, and the WiFi device attached to that bus is
> > enumerable.
> > * Since the WiFi device is enumerable, no node exists in the DT to
> > represent it.
> > * However, the driver for the WiFi device needs certain information,
> > such as the reset GPIO ID and perhaps power GPIO.

> PCI devices are also enumerable and yet they can be matched up with nodes in
> the device tree. Perhaps something similar could be added for the SDIO bus?

This seems to make the most sense - pushing this through the regulator
API is just a bodge.

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2dRnAAoJEBus8iNuMP3dZv8P/iRUNp/d1E9ekU/9muMqEHqN
YuYrh5eoSB+n/Z5L3NhfNHooqJ4AGlxLKKaBYy1vuuonCvmzQzPhmVsR3EIjPqWS
AGcNnmcg/Kwxw9JNiIpglRxBK6WLUyxN2ru9gll9y7/rDi5ghFwL/Y/Wjg4NqFaJ
E8CqUraBHvWM0KFlOakj0Ho54/tLY5tQ1jjubIX6PJ2dTgEYObEoGPe6wdvd30dZ
6MUgfZ5mpevjnCYk8s+Y1DGSkztlsbiMhMRU/op4cDlojCBg4Q1WzwgiLmq8RCEq
1da0m6RpJEByMVmoT9lVa6iWweOV6iLnah9xTFIPS6dm6J/rNXkRu9TPDlkf1pK7
MjyHLTjLNGYqjpAnqKbcYBsRcVjagIggxK96KqecFGMUxL8Sj4I/eG04Qug5SDfL
xRQFXhyCpTkTDgg99nRw0gadt+FOI5VHXxO4fYQuiImO1eN2D7r76pVMC0qDjffv
wDZjckI7UHqDsYZSNzv+gfWmwVTHT8NfuEhY0az7bxIyZ+1vbNgBd++Apyyu30XC
5d+IG1BBLTmszZSkVMu52skbe7jg1cRcn6KQTsRDz+bJ2u50imPk8axdF2iPeL7Y
6CDdxWFooC/lXfCHIUSp03ncdUSLCWY9KAiBw0r54S450wp7Xb+k8UvWq2HO1ql6
H0xwR/e7wiWw8QuvBrIt
=2m8d
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
