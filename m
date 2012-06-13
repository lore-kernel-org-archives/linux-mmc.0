From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4] mmc: add a function to get regulators, supplying
 card's power
Date: Wed, 13 Jun 2012 17:26:59 +0800
Message-ID: <20120613092658.GD4545@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1206121743260.6800@axis700.grange>
 <4FD84DAA.30201@stericsson.com>
 <Pine.LNX.4.64.1206131024300.17854@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51950 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752165Ab2FMJ1B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jun 2012 05:27:01 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1206131024300.17854@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2012 at 10:28:22AM +0200, Guennadi Liakhovetski wrote:

> I have no strong preference about this. Having an additional struct is ho=
w=20
> I interpreted Mark's proposal:

> http://thread.gmane.org/gmane.linux.kernel.mmc/14624/focus=3D14876

> but I'm also fine with putting it in mmc_host. Chris, what's your=20
> preference?

I'm just suggesting that because it seems like this is idiomatic for the
MMC API.

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2FzbAAoJEBus8iNuMP3dcLYQAIjQLQmfwkTXWa5fNM7ZdY+h
Wfikoz4Vhgmh7T+w6TJnhyh0gGMarj9U0tWJHMgxjwFwclgiqYYtNwtDSsaBSy91
h/u/26HGZhIf0y/KlIrqFTOdX7ypvKhjNagVNL5gC2UtbkdCLJmUmlZYWpHHrlRA
pZiFzpacI0YoZvrVRdvxbDRjN6bxNYosWaKWkSPuoxFGoonFe6FvsQbjVXHWu0UB
5GvYQOrzxnSAwV4U3rtcyPk0ogu6c2afbewkL4T2lfNTWhwsN7vr8wemJXDi+bDA
UPUHAjBng3CwT6vNjNIGLhgsbURBMMjvrSLOE1adppnkM++k2O1yRzUnDCtQAFmu
HRqRvf8UFUvdPZAaIvZTg78N59araaKI/2MTaUQeGM9omPI1q7uZehh5ZYqafPuB
Qs2xJjNfrCsg8yisCiqRy1UE1pE8vV7FlSc0XPFuT4BIj0aS1E+9oibUiIWPazgg
nawrDHUiJgl0acEZHnhTqFUwH8xh28Zx/ckN6P4NobhncqxPefeBYO9I/IYkdmTH
+eLeZ2PVhVxwJvpWN2+RbG7IcvzYOzUej6GKhk4fTr4tnIj3/Dledq6K2c2Xlz+Q
ZeHaGLqsVIb/mwe4PHlEbwCwLMn//Rp+OiGXoEV9pw+YWads/vd91cZ0xtwMorJ2
JO0xutsxoMjfswLr+Jw4
=FFgg
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
