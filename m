From: Mark Brown <broonie@kernel.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Tue, 27 May 2014 16:47:48 +0100
Message-ID: <20140527154748.GX12304@sirena.org.uk>
References: <20140523162718.GE22111@sirena.org.uk>
 <53806F26.6050706@redhat.com>
 <20140525123452.GS22111@sirena.org.uk>
 <53824294.1090609@redhat.com>
 <20140526103807.GV22111@sirena.org.uk>
 <538321AB.4050006@redhat.com>
 <20140526142225.GF22111@sirena.org.uk>
 <538356DA.7090302@redhat.com>
 <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
 <53838023.2080807@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="actP4k1Z62ny7sWM"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44524 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbaE0Psb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 May 2014 11:48:31 -0400
Content-Disposition: inline
In-Reply-To: <53838023.2080807@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>


--actP4k1Z62ny7sWM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2014 at 07:55:47PM +0200, Hans de Goede wrote:

> 				power-on-seq =3D "gpio_reg_enable", "usleep 1000", "clk_32khz", "usle=
ep 200";

=2E..

> Where power-on-seq would tell the mmc-core exactly how to bring up the sd=
io
> device, using standard prefixes so that the mmc-core knows that something=
 is
> a clock / gpio / reset / whatever.

There was some work on such generic power on sequences in DT from=20
Alexandre Courbot a while ago, search for "Runtime Interpreter Power
Sequences".  It ground to a halt IIRC mainly because it was never clear
that this should ever be encoded outside of the driver for a device but
the binding was pretty good and well reviewed, it's a good place to
start if there's a desire to do things like this.

--actP4k1Z62ny7sWM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJThLOhAAoJELSic+t+oim9is0P/jwSlzOCx98mdu8oxY7dyrFC
m7jfYHQNL752JER5QptF974/TJ5LaY/FLjb8pJ7o47bCUeE6z/Wd3jfJy4AqnmKD
rC5xABcYWHqVXf/NdD44htC146o7p+kc3VE068vypRjUaYSkCJ9y29zF+toC3Sre
XKpp6Oy6icRA6TKElfsBPkCvK8dClCS8t0c+aZOZPC4kh983nJsF946FLaAJOFmA
PSi8me9J3JruAGjije1L51MKr9AvSlTo/R3zFiX30mQTe2rSRRredvTulUzTzsaj
V6RcLqolkTbdEBpOonRp5ajFW0rGE6MNqyR028p6eg3YOGTF6k9veP1bAmA27Jcv
p7rQ4wXJ5DZpvSR/sGGDE3b0Jc+Ks+IKcA6I5OqO3eMKNjqcdIbvv3CdAJ6mhaMr
FhgWxJQ9W6Nc64pB2Itcf4snX85NBsZAMOL5Tz/bRsiwqPvNrRgvAFXLRQ0P9LMd
PjXxu6HNArFO2qq163HO/xxRt0jBUqjjZi9R77vrfE/0tZZChxMkcKAmVgvyYCXD
OFpo0oOr+3hn2tDn/kq2lcC7RD3koRGOYpWfDvgaq3paTspEf+/VPV6clsafrK79
w8pNrS4WWnZTNRV12SRbt8l5vcvjMP2j+9NyZ8E6ElNDxwmkX4NOPzDtMIrIutFK
e/Cq4HoU1psCy0ReWZoD
=1VKm
-----END PGP SIGNATURE-----

--actP4k1Z62ny7sWM--
