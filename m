From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 00/14] clk: sunxi: Improve MMC clocks support
Date: Thu, 24 Jul 2014 13:20:36 +0200
Message-ID: <20140724112036.GS20328@lukather>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
 <53CA4CCA.5040303@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KD3NH8oGZ7XN2Llp"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47454 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbaGXLZF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jul 2014 07:25:05 -0400
Content-Disposition: inline
In-Reply-To: <53CA4CCA.5040303@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org


--KD3NH8oGZ7XN2Llp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sat, Jul 19, 2014 at 12:47:38PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 07/17/2014 11:08 AM, Maxime Ripard wrote:
> >Hi everyone,
> >
> >Here is an attempt at improving the MMC clock support in the Allwinner
> >SoCs.
> >
> >Until now, the MMC clocks were having a custom phase function that was
> >directly setting an obscure value in the right register, because we
> >were not really having any idea of what these values were.
> >
> >Now that we have more informations, we can introduce a common function
> >call to get and set the phase of a particular clock, and use this in
> >both our provider and our client.
> >
> >Another issue we had so far on the A13 was that, out of reset, the
> >PLL6 driving the MMC was running too high to be working. We can solve
> >that by adding two new properties in the DT to setup the rate
> >constraints we might have on a clock.
>=20
> Looks good to me, thanks for working on this.
>=20
> Question have you dumped the raw mmc0 clk reg before and after this
> patch set to verify that the end result is the same ?

I did at 100MHz, but I was missing other test cases, so more testing
at the various other frequencies we might run at would be very much
welcome (and some cross-testing).

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--KD3NH8oGZ7XN2Llp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT0OwEAAoJEBx+YmzsjxAgx6AP/AvHDQBurVxIM0n18dhi9VTz
9CM4kDnLqCmPCK95yqwyCJcd0+chEwE/huOuNUZs7P6UWgTBVRbOnAoB2pfileiJ
V6LtPG7UGlwshIqexYKAn41yvz5DH89kiBZUWRpjeeARvgbuEpY4I1T90MDJ87oF
kny75ksNGhp2d/a+WYc6Tza/0WQYacpILzyCzIBku2Hywn+yQeikGaIN5drrSfUM
6MqUo+ui2yd4z403Gbu+8odH3lfVDfLQh18IJnq1FE/lfKmEqy2RwharCB85cFnC
6lVFFr22donP48xGaNnIhwCj8/Kwy9kjIRb2i/cOjBoH9BB3LqfSsR1oE+Nvja3Z
uZSKtlC3+EvXG1tjc+Pk47V9jshWadwSiAgJeTTBQPKJ66sGlJq8LV/NVGpGAIFz
ki2/j8JFekEFTMQl9D3CDDHb4vY9gFvKJvMBzOdiSwEGtz+8IBvRiaIycX/seIRy
nrfmWJNHpIhlFDCQx4p8RTKEm3A1JuqLS/M0+li3O/0Io4C/KqJLNv/6aJMylu//
y5/bVc+iJ6iflV3vlFR07dHNJGIzlWaG9swPXevxQjyX3MJo5UOrZHd9ZRW0kqp6
/pZpssCobWBCk3cMf8usPWIkakdC4x852RkHrhI+xqyvYGLlfJgq5mHPwMk6riqC
VowhEj3VYEFe+VipskhB
=e536
-----END PGP SIGNATURE-----

--KD3NH8oGZ7XN2Llp--
