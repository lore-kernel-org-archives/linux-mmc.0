From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias
 configuration in dt
Date: Thu, 13 Jun 2013 18:45:54 +0100
Message-ID: <20130613174554.GB1403@sirena.org.uk>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
 <1370546059-24181-7-git-send-email-balajitk@ti.com>
 <CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com>
 <20130613095353.GX8164@atomide.com>
 <51B9DA30.1090308@ti.com>
 <CACRpkdY6cZ+bT-C9Go3sZVw6ErQqTm0m9__uKQrkg4eUU1thHA@mail.gmail.com>
 <20130613162937.GK8164@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dWDJ72qfEa57oDWE"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:36983 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309Ab3FMRqU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jun 2013 13:46:20 -0400
Content-Disposition: inline
In-Reply-To: <20130613162937.GK8164@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Balaji T K <balajitk@ti.com>, Lee Jones <lee.jones@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Ulf Hansson <ulf.hansson@linaro.org>


--dWDJ72qfEa57oDWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 13, 2013 at 09:29:38AM -0700, Tony Lindgren wrote:
> * Linus Walleij <linus.walleij@linaro.org> [130613 08:35]:

> > No. If we go down that road *anything* that is connected to a
> > pad becomes part of the pinctrl subsystem, then pinctrl-single
> > becomes some kind of hardware abstraction or BIOS, and that
> > is *not* the intent. It is only supposed to deal with the bits
> > there that are 100% related to what pinctrl does, nothing else.

> Sounds like the way to go is to do a standalone regulator driver that
> optionally uses pinctrl-single,bits. But only for the bits in the PBIAS
> register that are 100% related to pinctrl.

> In any case the PBIAS regulator driver should be a separate driver
> as it may need to be a child of the SCM driver for PM needs in the
> future.

This all seems sensible to me.

--dWDJ72qfEa57oDWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRugVOAAoJELSic+t+oim9Xh4P/i8yow/72dAO2CNeRUYvEOUZ
gW8nWnKB8HXiujoJiPzl94fcMNL9RBV9t2xIJG6Gk2+P7Pelhm4WZ7fDa3Cd0tr7
BX0t4VRLHT7KCSqQXuodvJSw38Xo0GDbZsucrxbXJeKo3VMXZGznxr07qwfYaS0E
BxbcwW7hpvc4hGQ9Qv4+4+Uw3/5OyoJpapKtB1qW44Q8KHVGNexPXA8L7kYrlXZE
ISbrvKN9C1xlnZ6suUOLMRywCMGjBX/rSBweX421BAn8XnYeIR+iK1G0X8l6kfet
IaKkktM2f9kISuovBhxHpht8rtD0KtBQEGHJZZsR1rLkFcranyO87jlFCD54o2Bf
Q3e7qpbDDelAQoGV2XjOSCKs6+Lpk5klxCo1TODSn0UU9X/Ekubq5G6VoMTnVKBS
HjbLeyRvXllR5WJEAVxD9EZ9O2LiN5OefVhI6seqcO6cifdAoyc00DBQ6mo3bOBI
j7GUPBax1Yov7RHlMdRJ7CwJH+/CWNKg80R16GARFFxgDG7hS7af1AaeTsn6EWVH
3eI5vzmWm7aaeM92/NE2diygiVX6MfR/2toPQ/gEF0oRKzdV3wzcYP1IrO9BafGl
KGx1Jo25ews6TK79m7kHdelM+JF9fXq5pOrXGvUVhnNGpcUh3gdRtBVX7yWfzr1K
JX3a0kwDSJkVPlv+xL6i
=A+R2
-----END PGP SIGNATURE-----

--dWDJ72qfEa57oDWE--
