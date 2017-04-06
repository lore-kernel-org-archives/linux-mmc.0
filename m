From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 13/14] pwm: jz4740: Let the pinctrl driver configure
 the pins
Date: Thu, 6 Apr 2017 16:40:34 +0200
Message-ID: <20170406144034.GE8438@ulmo.ba.sec>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-14-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170402204244.14216-14-paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maarten ter Huurne <maarten-Ph2Y2OKCxY1M656bX5wj8A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2017 at 10:42:43PM +0200, Paul Cercueil wrote:
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
> (Qi lb60) can configure all of its connected PWM pins in PWM function
> mode, since those are not used by other drivers nor by GPIOs on the
> board.
>=20
> Signed-off-by: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
> ---
>  drivers/pwm/pwm-jz4740.c | 29 -----------------------------
>  1 file changed, 29 deletions(-)

Assuming that you want to take this through the pinctrl tree along with
the remainder of the series:

Acked-by: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljmU2EACgkQ3SOs138+
s6HGABAApLsMiPuePBh0cJc9OAijswAsVlj72HCTmH1JA3qrEfhOVWZxltlReNwi
z9upRVFfXOAux8PGiJT+0N/z5Zrkwu/haho/al14XxloMx4DSW4UWkeBAVyqBkba
N6btN6WY2TLAMi7gav0GWbXFhspUJCncB+HqK2wmXyAhQJfBjMQ2Et1OpniwQ5fe
v60TCWUjBY7dZtgtZ5I80tQKjYnZC6hLQoXZcBwTNvQbeIM3sl9cymdPbMXVIJH4
dzxud0NQLfx1flI0KlEI35gpRAAfinGr5XqUYipP1JtsegR51uvpQdQ6l2WdGcBV
9mICw0SZnFuELmPzAYXFjKEYvmOFLB9kMgVHISOgCCwFtJfIH4slY27lZLLvmUkg
y/erHU6r8KQfjkVdxNiMcktqMOoAoHaUpWfgsBL/kE3Am0aoXXL3AFEsKY8WXbDg
qjN3dsSIdafpEngfpz6tyxbZfPeUkpYubI4+D9T4ov5SC9JeKuPLd6TTXnGtAntx
FNhSfWilbcbkYG1r37LpNkW8xWo904JQ7G0pn7opGScBH92xGhV3+g0MBTlTfs/8
t1fqhL3r7+z576vncJwup/hFZq2XrjqCWjizIHKwp2q7vj8JFyN1NXrwRp0CwfJt
IwPgbk9MEqstyCKhNIpM4qoJvvmSTQS/SC3k2JvQVGkwjWiytNM=
=QxS9
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
