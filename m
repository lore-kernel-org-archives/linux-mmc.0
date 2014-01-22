From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Wed, 22 Jan 2014 11:30:49 +0000
Message-ID: <20140122113049.GA20247@sirena.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
 <CAPDyKFoywt_LcWXdWJCWMU8-GT2vLW27eiuF0WEyjHJV+96HpA@mail.gmail.com>
 <20140120191302.GA32178@quad.lixom.net>
 <CAPDyKFpfrs=e3bDvdFRpnD3RkmD8ZvAJgFi6XvCRAOocqAKkKw@mail.gmail.com>
 <CAOesGMi9puZSzdDJ-sur5ks7VcDH+XV_MbuA0xeidLgp=uJacg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:57935 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357AbaAVLbW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2014 06:31:22 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMi9puZSzdDJ-sur5ks7VcDH+XV_MbuA0xeidLgp=uJacg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Rob Herring <robh+dt@kernel.org>, ijc+devicetree@hellion.org.ok, Kumar Gala <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2014 at 10:14:49AM -0800, Olof Johansson wrote:
> On Tue, Jan 21, 2014 at 12:55 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> > That could make sense, but still I wonder how those shall be handled
> > in a fine grained power management setup. In other words, when shall
> > those be gated/ungated? Is the mmc core able to take the correct
> > decision about these?

> The reference clock is in most cases I've seen 32kHz, and not
> something that's under fine-grained power management. So it's not used
> to regulate interface speed, etc.

I have seen devices connected using SDIO which did use fine grained
power management here with faster clocks.  They're definitely not the
common case but they're there.  :/

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS36vlAAoJELSic+t+oim9MZ8QAJU0GhqtIAryM+UtQRxrO7wn
gSqcKh5/U4/6NG0FjLh0oGmcZK9rS/ssJA/Jpcls9yhukAVvZNBpEM4H1gbZERMD
gY/RigqQO6+FcU5clYB6kbN5fBxH1edob5YFDXBk6uEzIwjNZL7dRHyQJ9I3XxtI
bBtGr0kipSJDimb63s9526IhzE1RWIenHzrdEJpPKz26TqvkHnB3e6s154cdZIYy
7Brr15dslTi3AuB00D3DNVBEPak6llfoIPobSNgiBxwlHU+E3uvBpJcV5CXADa2v
xXV9OmYhGsUhqbtbKyOw5oseTWY+UjXVnxt9Zl7i/laPsLspTJ+wUvZESuTcPP6H
XnUVfMF4pIiCDT50jdiUocUAtzOIS5ORmqWyLyX5pvU938nqt9vQFf3SysERU4hb
/Qo0jubf9X/wrQs2KASlFU3l16Y6tVjMS0xdBBGeV5C1gRK3KbUMCWoKQcVkZXcu
N5vM/DUjq97cQxiziD2pY4mLrRiRQBZBwE0p0USQBSMmVQovFl6mNRnCvSR+qo2z
1idLtLYUsyEdWYLiVIVZP876SDNvDSJTF2zs7gU5DJZnTgWayq43AjMGVt8e9C6g
lp3myCZrFFK7wkGwaCbFk9h9e0GN9+Zcx8u2qX1iccy0ee7br0Gqaw5GN5T5fosl
EG/ZzJex1wxo5ZnicDje
=Am2N
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
