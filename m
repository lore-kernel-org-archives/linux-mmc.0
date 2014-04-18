From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] regulator: pbias: Fix is_enabled callback
 implementation
Date: Fri, 18 Apr 2014 18:27:56 +0100
Message-ID: <20140418172756.GR12304@sirena.org.uk>
References: <1394250929.3892.1.camel@phoenix>
 <20140414211644.GG12304@sirena.org.uk>
 <CAFRkauDTvEGoaWFBtPWHtw-JFmhTbdHcxoVP56fnv1YG047Knw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y0koQ0R6+zV0KVa4"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:38126 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbaDRR2d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Apr 2014 13:28:33 -0400
Content-Disposition: inline
In-Reply-To: <CAFRkauDTvEGoaWFBtPWHtw-JFmhTbdHcxoVP56fnv1YG047Knw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <chris@printf.net>, Liam Girdwood <lgirdwood@gmail.com>, Balaji T K <balajitk@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Stefan Roese <sr@denx.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org


--Y0koQ0R6+zV0KVa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 11:14:13PM +0800, Axel Lin wrote:

> commit 60e8c1e34d3a
> "regulator: pbias: Convert to use regmap helper functions"
> might also required for 3.15.
> The reason is this commit implements .list_voltage and the mmc core calls
> regulator_list_voltage() in mmc_regulator_get_ocrmask().

Makes sense, yes.

--Y0koQ0R6+zV0KVa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUWCZAAoJELSic+t+oim9J+cP/1lirOR4yrhIrTa6o8Nyc1uy
tKXOK2cNUyWJUpKHh3GhrEApeA49ym5FZccaN8A43NWy0j5rmjh+/C/8E7vbDYAc
MNyBldKtvN3IvCUk7b5Y++mWHDSk4l0hxuMZ2vnc6L9bHUKd9x1O4RBTDX87Gzxm
/P/ApR9TpYav9KAfKe1x/JxGw69UwdlquRIyPuT9wv1BlmuHpIVPVIG/RmepICaa
v2oRCiBnVUkqeqwgn+UV8whxVBC3rVmQvZR0t75bjWjvS9wDD+mO8birRJFdJypN
DhxkP8WCaOtlmjVQYqhXYf5UP6a2k1KfedfFmuOKcmdRM5W3sPcSxIDVHRcD7p3Q
qfMxBJH7kQUkF6o6ZfsuEPoAh/wdsE69qmoWNyzZPTvJ9K4q2qPdENQ+OOnJCdZk
G/c2nC09MseRFeP6/JVVksTJgsZ6HamAFNcXd7vSLdoPqCNn+18ZJYeOSy1S7c+9
ob8uHsFxBY1rhVHl5AN28yF3KhsZSaApjkX7sL5G33nOCRjpz3M1kZgRwZQfMEnE
lkMERrCo3w6hvoufaJ8RGPZ8qL64Ia8lfDPGmginadDbakH2ZYSiefxAy/zdonoe
5+a+UlA+f/j3Kvzth0LJeQlhEIcdNOMLHS8tVxPlAlR4HTUpJiEH5UGVqHcXuluT
QtS73l4woo9QE/BN9VKC
=SvxI
-----END PGP SIGNATURE-----

--Y0koQ0R6+zV0KVa4--
