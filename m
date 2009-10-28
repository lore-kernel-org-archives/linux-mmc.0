From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc driver in
 at91sam9g45 chip and board
Date: Wed, 28 Oct 2009 08:35:48 +0800
Message-ID: <20091028083548.38f1d80c@hskinnemoen-d830>
References: <acfa557032a93e2d3186981b16f7048a5a31028a.1256314995.git.nicolas.ferre@atmel.com>
	<20090930155557.7dae503b@hskinnemoen-d830>
	<a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com>
	<cd73a99e0910271243x744c956bl598fef9fd4144840@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay.atmel.no ([80.232.32.139]:59371 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756988AbZJ1AgR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Oct 2009 20:36:17 -0400
In-Reply-To: <cd73a99e0910271243x744c956bl598fef9fd4144840@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Victor <avictor.za@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, kernel@avr32linux.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

Andrew Victor <avictor.za@gmail.com> wrote:
> > +static struct mci_platform_data __initdata mci0_data =3D {
> > + =C2=A0 =C2=A0 =C2=A0 .slot[0] =3D {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .bus_width =C2=A0=
 =C2=A0 =C2=A0=3D 4,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .detect_pin =C2=A0=
 =C2=A0 =3D AT91_PIN_PD10,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .wp_pin =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D -1,
> > + =C2=A0 =C2=A0 =C2=A0 }, =20
>=20
> Causes at91_set_gpio_input() to be called for pin -1.  Which shouldn'=
t be valid.
> AT91 platforms use 0 to indicate an un-connected GPIO pin, so the
> assignment of "wp_pin" should probably just be removed.

The mci driver expects non-existent pins to have a negative value, as
do all other drivers which use gpio_is_valid().

Haavard
