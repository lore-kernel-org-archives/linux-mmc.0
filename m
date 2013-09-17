From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] mmc: core: Fixup ocr mask setup to prevent spec
 violation
Date: Tue, 17 Sep 2013 12:04:29 +0100
Message-ID: <20130917110429.GR21013@sirena.org.uk>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
 <Pine.LNX.4.64.1309162253320.17217@axis700.grange>
 <CAPDyKFrvPkwAVfi8gv0hG3DKeiJm+_AqODhERX=O0ZxB-gcHiw@mail.gmail.com>
 <Pine.LNX.4.64.1309171008190.20367@axis700.grange>
 <CAPDyKFpfe7mL4aLBo4S4tibpoL8DoiK3TiVzPvc4V-eG1Yrm_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mjrw6G9AoRBv8oQK"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:53475 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab3IQLEy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2013 07:04:54 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFpfe7mL4aLBo4S4tibpoL8DoiK3TiVzPvc4V-eG1Yrm_w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Prasanna NAVARATNA <prasanna.navaratna@gmail.com>


--mjrw6G9AoRBv8oQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 11:29:21AM +0200, Ulf Hansson wrote:

> If you want to change voltage level for eMMC, both VCC and VCCQ must
> be possible to power cycle, unless you have a hw-reset wire connected
> to the eMMC which is implemented by a host->ops callback. This
> complicates things for SD/SDIO as well, while trying to setup the
> conditions for when to set the PWR_CYCLE flag.

Should the hardware resets not be being converted over to be represented
as GPIOs (or the reset controller API) to factor things out?

--mjrw6G9AoRBv8oQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSODc6AAoJELSic+t+oim9KC4QAIrr4vMrZNs6cDEseHPsEN7o
fclQaeR1nSiHK4gYatToPd20iFtWcoWiKJ89MPOVtzXmzpDir1rA2FR0Aq8ISEcq
d6seK268NzRVOpfRxLtt2sWd55TURcDroOejXH1Tqs1JThKe2VLWhbeyP+otcxbx
s7tSkEkKdi2DlP+bskQ9JSQG2gUZy4MhJ2Ww8+DPHL2K6DmdGPppDZ3TvdCFk8LX
EDoL2QXQgfhf1ycbbvJcuVdVRRXwUZQ7LC1Wt7nCjdwstuvHhpkpicpIRzoZc3lT
PHnhWoUpf0eT11NtcZX/GhqblBo5QUQRrFumBf6aT3O4R7ERvjS/vTDAWwxng7xU
HMlL9VN7dsmiEXXbffVQww1mTQsaXXBtO6kF9+fWtBT+kHKq+HZAe2boo1OOh/52
AHygbfergtTU5CQ9phfRE5ZrJ+jbi3nqWfBOIxOe5mV4j9Xm4LCg7yxm5YZV8f7/
zCwdNPwgn/bw7ghk+JUU9N+zphC0q61JdCZ/F+zQb20fKTxsH7VfZjoV6OEkXP4K
wDxJFHV0hM/Igy7EsUwB/2emwsfHJH4DUXcGwBHUC+yssZrgy3vFo+XvmjIKxeka
WA/30ODieYEZ2qkOawGg9pOziaY9q75A7pfNumNT0GZLawFFPuUCyeZQxuxk4jlv
LaM5PAJtou832WEC4aDG
=oIWy
-----END PGP SIGNATURE-----

--mjrw6G9AoRBv8oQK--
