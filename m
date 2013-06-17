From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 1/2] ARM: davinci: move private EDMA API to arm/common
Date: Mon, 17 Jun 2013 11:43:27 +0100
Message-ID: <20130617104327.GD1403@sirena.org.uk>
References: <1371463571-2578-1-git-send-email-nsekhar@ti.com>
 <1371463571-2578-2-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="moC1XDyencuJ/zDM"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:60393 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab3FQKnl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2013 06:43:41 -0400
Content-Disposition: inline
In-Reply-To: <1371463571-2578-2-git-send-email-nsekhar@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Chris Ball <cjb@laptop.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Matt Porter <matt@ohporter.com>, Joel Fernandes A <joelagnel@ti.com>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>


--moC1XDyencuJ/zDM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2013 at 03:36:10PM +0530, Sekhar Nori wrote:
> From: Matt Porter <mporter@ti.com>
>=20
> Move mach-davinci/dma.c to common/edma.c so it can be used
> by OMAP (specifically AM33xx) as well.
>=20
> Signed-off-by: Matt Porter <mporter@ti.com>
> Acked-by: Chris Ball <cjb@laptop.org> # davinci_mmc.c
> [nsekhar@ti.com: dropped davinci sffsdr changes]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Acked-by: Mark Brown <broonie@linaro.org>

--moC1XDyencuJ/zDM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRvuhMAAoJELSic+t+oim9bHEP+QHtO0gbJlbZAkS1lO+p3cch
FBRsvIy8D8xAJHuw5uDcZkWWYQMwc9bSBSEbjctzbEPKJW6vEMUpribbyOVQ07T0
ncJvBTI1q8RtNv1A3rLSlAfioLyw8hc17E0MZuluQBJ56NBG6TKhoQp71FKKbQZx
BODJ8SvcPtUfOJgmtbIPl8uEfK0W/FaT0qFB42UI0ScF8lilPOXtTUC6aBiO3/Ch
CunWpVOl/64zV7iyTPapVSvKms3lyHhDOSwyDHaLtcJdquhITkxMT+C0a05d8FJX
31WB2RYIrOqzOyADsHEi3faFunkFezOs7lyVBbEuuFhtct84EcNIsv0+Go3zsbgj
2EECKyQ4Lg/2sF9C6XOp+stRukNl+q5ttxXAZjLfAR0WikIK0tuJkrcL3I8IOjEW
xQ81wd0QzMarFfKuZrBhsvV5urz8sSdMBqk8ufl7sIhNPJEio29Q8IQJZQZZ+WP6
9Er7d35yGPW034ZOGe0KsqNpjsQiAI5k4XJRnvt/Y6mz965HxgjfeKWWZ6mvic9d
sf3H2XDr83qWufdzs0OE+yTxzsSlTijbJclj++u4yFSnxT8DuV0rcrwI3q+YHo+y
8jwCDypIqvEABtzcoYwlzpNHTqumtiRqlmVNnwBgB1765bIfZOihvqRjjFMjZv0V
XkW1zTFBl8LhPjR3MbFt
=Hbb/
-----END PGP SIGNATURE-----

--moC1XDyencuJ/zDM--
