From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 00/13] Ingenic JZ4740 / JZ4780 pinctrl driver
Date: Wed, 18 Jan 2017 08:15:30 +0100
Message-ID: <20170118071530.GA18989@ulmo.ba.sec>
References: <20170117231421.16310-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com
List-Id: linux-mmc@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 18, 2017 at 12:14:08AM +0100, Paul Cercueil wrote:
[...]
> One problem still unresolved: the pinctrl framework does not allow us to
> configure each pin on demand (someone please prove me wrong), when the
> various PWM channels are requested or released. For instance, the PWM
> channels can be configured from sysfs, which would require all PWM pins
> to be configured properly beforehand for the PWM function, eventually
> causing conflicts with other platform or board drivers.

Still catching up on a lot of email, so I haven't gone through the
entire series. But I don't think the above is true.

My understanding is that you can have separate pin groups for each
pin (provided the hardware supports that) and then control each of
these groups dynamically at runtime.

That is you could have the PWM driver's ->request() and ->free()
call into the pinctrl framework to select the correct pinmux
configuration as necessary.

> The proper solution here would be to modify the pwm-jz4740 driver to
> handle only one PWM channel, and create an instance of this driver
> for each one of the 8 PWM channels. Then, it could use the pinctrl
> framework to dynamically configure the PWM pin it controls.

That could probably work. From only looking at the JZ4740 PWM driver
there's no separate IP block to deal with the PWM outputs, but they are
merely GPIOs controller via a timer, so one instance per GPIO seems like
a fine solution to me.

> Until this can be done, the only jz4740 board supported upstream
> (Qi lb60) could configure all of its connected PWM pins in PWM function
> mode, if those are not used by other drivers nor by GPIOs on the
> board. The only jz4780 board upstream (CI20) does not yet support the
> PWM driver.

Typically all of the pinmux is pre-determined by the board design. That
is if you've got 8 pins that can be driven by a PWM signal, not all of
those might be exposed by the design. If, say, only 0-4 and 6 expose the
PWM signal while 5 and 7 expose a different function then you can simply
use a static pinmux configuration and ignore PWMs 5 and 7. Even if
someone were to configure them, the signal would simply go nowhere.

Of course you'd have to check that your hardware actually matches those
assumptions. They certainly apply to many SoCs that I've come across.

Thierry

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/Fg8ACgkQ3SOs138+
s6Gr8Q//TFgNuNimYiB+7+AruQDt63U50a4sL1bBqLZEtCja8d1coKzuIihocevQ
FmB9mRjJA9VM/PGa86qsjDBAtWbIROZYqBE50U0DjGcIOHdZOltSM7I0liWPQRGm
42j4lMZZo7mdcIGWzcQmmIFroDOC0HMgG7/ZnYP1xvheJJaIJXghb41I/hYo55ub
c3M+ySsnWHfeIhe6BCsxm7sW99iStEiMDvGQkT/42QdmqsDkA2oKRgxOH4sNqgae
0r6fKZIF3bJX5klQiarNroAm7zRmc1T8AB/60CeQTrgDA0NC/rYThPE707ivqgqq
wsLbrqWXsO194wJxXJ2PX3+mKxm0Y6TgQPdDEb6f2Mehl8/NNTmIURjRyxBWrfsG
u0q0of+WuoEHi014KW3Qy4DJcGaATi13wJJzV1R2SX0dDcApALoPrVthMpx3h599
kUpxaMFeWpCNGjRFszJdCn8ZZgxaoDZiKRvLR9ghRYB1CaFlR7SZEz/wiHDjEx0q
4OSgtSMDRdWOyInw+wCTVE/9dFrSBLoMVAihrmS9d6FqUDdNYYlRsU/QReC8lFFl
tabfOvtDw/BHahDuKlWJpW2QdVQ5xmr+uUDM6uWMWV8rYdIz20fP614uSt0nJNQx
7WMslUpB4sm1DGoeX0fL+PPa7wDWUeL9tAgZHmMEWIe8393sjtM=
=7L1k
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
