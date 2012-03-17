From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
Date: Sat, 17 Mar 2012 21:26:53 +0000
Message-ID: <20120317212652.GD3315@opensource.wolfsonmicro.com>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <201203152058.31398.arnd@arndb.de>
 <CACRpkdbyVXA+GxRtVL+JGPorp0ULJmeUEUZPxVxOT8W1-WmeMw@mail.gmail.com>
 <201203161236.36088.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43795 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754921Ab2CQV05 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Mar 2012 17:26:57 -0400
Content-Disposition: inline
In-Reply-To: <201203161236.36088.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Per Forlin <per.forlin@stericsson.com>, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org, cjb@laptop.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2012 at 12:36:35PM +0000, Arnd Bergmann wrote:
> On Friday 16 March 2012, Linus Walleij wrote:
> > On Thu, Mar 15, 2012 at 9:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> > But I guess you're after modelling the levelshifter as a regulator?

> > Basically the level shifter is a separate device has two voltage
> > inputs A and B (from other regulators) that is controlled by a
> > simple GPIO to select voltage A or B to drive the signals to
> > the card.

> > That could probably be modelled as a regulator with two
> > volategs for sure, but then we should maybe create a more
> > generic "struct level_shifter_regulator" (or whatever) for the
> > concept as a whole.

> Ok, thanks for the explanation.

I'm not sure I'd bother defining a special regulator type for this if it
is done using regulators - given that it's likely to just be a GPIO
rather than a specific driver I'm not sure it's worth worrying about how
exactly the hardware is implemented.

> > Let's page Mark about what to do with levelshifters and whether
> > they are regulators of sorts in his book.

> It does sound appealing, especially because this one could be
> done completely generically by defining a regulator that has
> a bunch of other regulators as well as a set of gpio lines as
> inputs and one output that can be used in other devices. We
> would probably only use this one together with device tree then.

It seems sensible to me - probably the existing gpio-regulator driver
can do the job, though it's not unreasonable to expect that we'll want
to support switching between variable voltage supplies at some point.

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZQFnAAoJEBus8iNuMP3dH2QP/jlFcGcMlmij+7XS83YKRo8S
rUr+JzLCXXhwG1qUZMIBykH5zu7uLZeHHClrworViHOu3jewk/DV+9Z+WHjdWjvy
Pf8K21xJxEaaREkAA8dyYy8jvCX8FrtherqNgoPFMfltAFPzO9YyVe9bKEUNpsNJ
ZEs52uU9wuaWbfhg4pN0sAhL9smH3owRxqfubWkJe1uQg1hPk1VX8v55ggO8kdiB
FG0w6E7cgrTJkXCF3bIaqazPIj5UCP37rYU49gOi4Nsy9Nl4/SQvufJt2x0DJDoC
a6T+Ucmj0kKIM1PUKFNbEAxcCk2qq8NndRqWfPZRv24a4PJJMPgYkZ4pLvQNEjHQ
DZqLE7/GyzKwgHzHIvZzBuJGFW7qLBbioziUipsHPhRSYWbwQ8fzkJCTyC8lZh5R
n5thwrMyWzveECbLsO04dXYYgHd0vjltdo07vz1IAl6upUNPdUUsZzVJEkNnZFZe
v/65alEkwhXHLQnIVqYe8HP6tD4ijcdUDqMcqiSdFcCssDjAd1+yndUvL2Zg0FY1
gTsX6ksdKpI59BvYXcC9a34uIeRq61ReVM2UZefaMS+/klE2bWte5K7eaZrkV63s
ssLxtOug6bsOdFs9dqxhmyszWKsF9cUvOklu5yYb7qeQfN2ppn00vgGnIIG/VpbN
Morrawkbo11id15sKSAh
=gFnw
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
