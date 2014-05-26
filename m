From: Mark Brown <broonie@kernel.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Mon, 26 May 2014 11:38:07 +0100
Message-ID: <20140526103807.GV22111@sirena.org.uk>
References: <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com>
 <537DE1AA.5050606@redhat.com>
 <537E31F7.1030505@gmail.com>
 <537F1148.3010102@redhat.com>
 <20140523112239.GB12304@sirena.org.uk>
 <537F3610.3050104@redhat.com>
 <20140523162718.GE22111@sirena.org.uk>
 <53806F26.6050706@redhat.com>
 <20140525123452.GS22111@sirena.org.uk>
 <53824294.1090609@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F3mDA9xuPwJBqvPm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42872 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbaEZKjG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 May 2014 06:39:06 -0400
Content-Disposition: inline
In-Reply-To: <53824294.1090609@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>


--F3mDA9xuPwJBqvPm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 25, 2014 at 09:20:52PM +0200, Hans de Goede wrote:
> On 05/25/2014 02:34 PM, Mark Brown wrote:

> > Why is that a problem - if we have no driver for the device there is no
> > point in powering it up in the first place is there?

> Well the driver may show up later, so if we only do the power-up once we have
> a driver, this means we need to re-check if we need to do the powerup later.

Sure.  Does that seem like a problem?

> Also the mmc people are very much against specifying a driver, as that is
> something which should be probed not specified. I agree with them I've
> already seen boards were more or less standardized sdio modules from different
> vendors are used, they have various standard sdio powerup related things, like
> an enable signal in standard places, but different editions of the boards
> have different sdio modules soldered on, using different drivers.

If the device isn't specified then presumably it'll power up with the
default sequence so we shouldn't need to worry about overriding anything
until we've powered up and enumerated.  The only time that there's a
problem and would need to specify exactly what the device is in the DTS
is if we need the custom sequence prior to being able to do that at
which point I don't see much option.

> I know that the DT is an ABI, and I'm not arguing for removing support for
> the simple-sdio-powerup compatible from the kernel when a more complex
> case arrives, nor am I arguing to remove it from the DT for existing working
> boards. The idea behind the simple-sdio-powerup compatible is that it makes
> the simple powerup behavior opt-in. So if a new board comes along which
> requires something more complex, the people working on this can do what ever
> they want / need without the simple powerup code getting in the way, as
> long as they don't *add* the simple-sdio-powerup compatible to their *new*
> DT file.

I don't understand why not powering the device up would be a sensible
default or why other OSs would also choose to implement things that way.
It would seem more natural that we would have the custom override in
place for things that need special handling, not the other way around -
I think that's really the difference between what we're saying.  My
expectation would be that we do the standard case by default and then
have the complex cases override rather than the other way around, that
way the standard case just works with no effort.

> Basically the idea behind the simple-sdio-powerup compatible is to make
> the worst case scenario for more complex boards to be the scenario which
> we have today, i.e. no support for sdio powerup at all, rather then having
> something in place which actually may get in the way, making things worse
> then they are today.

Well, if things aren't going to work either way for these devices
without extra stuff it seems it doesn't much matter but it helps the
simple case to have things default to working.  If we're in the case
where we've got a DT that just describes a slot and says to probe it
then powering the slot up seems sensible; if we're in the case where we
have explicit information on what's in the slot then that gives us an
opportunity to key custom behaviour off that explict information.

--F3mDA9xuPwJBqvPm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTgxmMAAoJELSic+t+oim9ZPcP/0P3P9akVcUKtquJagKxkbbf
KX4ZBdn6LnaSbb4dH7D++2Hpm2mb1k5r3oYa7hXSGLpszaxfRZmMkmf7YY/QQdzM
M4VvuwBJukNvTlKr4NP0S9jr+9YrVz/oI2PFANv9vgJTpHXOpce/HmQTd73Z0VH3
YlgzzpvekFMUWrror30BN4F75h6tGPcAPeO8F1y7jDTtlP8CJk92GDG1AL4U8tdk
lzzYAV+lvUK/CgeAtLP5C3tTEvcftimDPQcjb1e//IwZiqwiHQUzAhJO6llbKtpZ
pbcN230khJrX+kDoyyCo21ZOkgemIfmN9TteAOQv8zZdvxOWl1qA0aIvtel3JO3r
BV9qQ7wFS8wztW614ki9mr2zzwbI1deQs8u5nenas8Bz+XIIbOn4WL2iMx2AwdJJ
bcmzEMerpVg8ihjQlbC6W5Nh82r3I6iAdjHkkKS2Ip4iUy69w4Dl3QoK/iYYNEoy
rID+zL7vk9KYlhWWxcUIiFRSSB724PGFgsmv0DtsPEFgpAfVMGZ9gNcjGFTHq3BR
yPuAAlarvM8Zq1QG5yf6oFtXjlkvRudxtt2zSt3osriueSE2h3tyAm+2RWQRhTIG
VOy6qSxyIJl+btcLNOJkDaN2RwGCbQ1ftoE9AWxvRvMACP15lul1tNM7XRqJv2G0
r52BEEpKJl82pOg4dZvt
=8Bd7
-----END PGP SIGNATURE-----

--F3mDA9xuPwJBqvPm--
