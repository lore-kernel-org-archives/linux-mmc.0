From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 12/13] pwm: jz4740: Let the pinctrl driver configure the
 pins
Date: Wed, 18 Jan 2017 08:20:18 +0100
Message-ID: <20170118072018.GB18989@ulmo.ba.sec>
References: <20170117231421.16310-1-paul@crapouillou.net>
 <20170117231421.16310-13-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20170117231421.16310-13-paul@crapouillou.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com
List-Id: linux-mmc@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 12:14:20AM +0100, Paul Cercueil wrote:
> Now that the JZ4740 and similar SoCs have a pinctrl driver, we rely on
> the pins being properly configured before the driver probes.
>=20
> One inherent problem of this new approach is that the pinctrl framework
> does not allow us to configure each pin on demand, when the various PWM
> channels are requested or released. For instance, the PWM channels can
> be configured from sysfs, which would require all PWM pins to be configur=
ed
> properly beforehand for the PWM function, eventually causing conflicts
> with other platform or board drivers.
>=20
> The proper solution here would be to modify the pwm-jz4740 driver to
> handle only one PWM channel, and create an instance of this driver
> for each one of the 8 PWM channels. Then, it could use the pinctrl
> framework to dynamically configure the PWM pin it controls.
>=20
> Until this can be done, the only jz4740 board supported upstream
> (Qi lb60) could configure all of its connected PWM pins in PWM function
> mode, if those are not used by other drivers nor by GPIOs on the
> board.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/pwm/pwm-jz4740.c | 29 -----------------------------
>  1 file changed, 29 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 76d13150283f..a75ff3622450 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -21,22 +21,10 @@
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> =20
> -#include <asm/mach-jz4740/gpio.h>

What about the linux/gpio.h header? It seems to me like that would be no
longer needed after this patch either.

Other than that this looks like the patch I'd expect if the pinmux was
configured statically, based on board design.

Thierry

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/FzEACgkQ3SOs138+
s6Fc2g//dBxUhoJLEIycA+khYQpD62rjvdJT1q5wLLQ+Den0WbIVJPY25Pq1mJof
YfyYtNPRxPxJ0bnrjG1Zg0zbdv2SH/L85r7mDgp5KBkX6iOZejnDlhP687KF8Vre
VEsTgdd33zu9HJAYNjLgD/J+SIJ+5GM2nl1N4unmondfMt1HVCyMPwGwKqYoxoWC
wpqdz/wY7kLoU4Q+CDa5Dbois4xy3rsVNgtPDwSsMdzxmHOuKs8R68Bb4fP4K76u
KxJpzS6sumat3i0TDNmuuk3e0IgsalqiB9NVH08ptil/kkTzQspQ/ajZZQuhnpl6
av5PSr+15+HCK5dSFpCWdH0SEUYGDAd/PSlIjzx2BU07y/izHI55ww7af2WtPzZK
RDzsmK9DBln26Nek9G5EggcvNhiUcKDibaZ2uog5jYfPSOgESJwfomp1auoD/b3h
B8XsuTAK11eMAbyRshFmuRo9uLVnJJCJeO5SG+3gnXBxOZzHE8cxvwL3Lw1VvMvb
50842gN0fX5dKGO+2KOimOJ/Koov4wmBXVY1buvW4YWU9JkeU439jgiLb16jB1UR
JnEFOblWuKCVpZNuzib/bNOwfv4xP5YaQfm1uNgVZMNwIzYBxKa8tGllTIQQaY+v
xej1u4K0SR8CiPc2tw81+HQp9SV/xxIxa4/otXWhORsO//+CR2c=
=py/u
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
