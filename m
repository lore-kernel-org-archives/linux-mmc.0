From: Andrew Victor <avictor.za@gmail.com>
Subject: Re: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc driver in
	at91sam9g45 chip and board
Date: Tue, 27 Oct 2009 21:43:26 +0200
Message-ID: <cd73a99e0910271243x744c956bl598fef9fd4144840@mail.gmail.com>
References: <acfa557032a93e2d3186981b16f7048a5a31028a.1256314995.git.nicolas.ferre@atmel.com>
	 <20090930155557.7dae503b@hskinnemoen-d830>
	 <a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932106AbZJ0TnZ@vger.kernel.org>
In-Reply-To: <a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mmc@vger.kernel.org, haavard.skinnemoen@atmel.com, akpm@linux-foundation.org, kernel@avr32linux.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

hi Nicolas,

> + =A0 =A0 =A0 if (data->slot[0].wp_pin)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_gpio_input(data->slot[0].wp_pi=
n, 1);

> +static struct mci_platform_data __initdata mci0_data =3D {
> + =A0 =A0 =A0 .slot[0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus_width =A0 =A0 =A0=3D 4,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .detect_pin =A0 =A0 =3D AT91_PIN_PD10,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .wp_pin =A0 =A0 =A0 =A0 =3D -1,
> + =A0 =A0 =A0 },

Causes at91_set_gpio_input() to be called for pin -1.  Which shouldn't =
be valid.
AT91 platforms use 0 to indicate an un-connected GPIO pin, so the
assignment of "wp_pin" should probably just be removed.


Regards,
  Andrew Victor
