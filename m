From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 13/13] MIPS: jz4740: Remove custom GPIO code
Date: Wed, 18 Jan 2017 08:27:51 +0100
Message-ID: <20170118072751.GC18989@ulmo.ba.sec>
References: <20170117231421.16310-1-paul@crapouillou.net>
 <20170117231421.16310-14-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5335441250778327517=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20170117231421.16310-14-paul@crapouillou.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, james.hogan@imgtec.com, Paul Burton <paul.burton@imgtec.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, Maarten ter Huurne <maarten@treewalker.org>, linux-mtd@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============5335441250778327517==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 12:14:21AM +0100, Paul Cercueil wrote:
> All the drivers for the various hardware elements of the jz4740 SoC have
> been modified to use the pinctrl framework for their pin configuration
> needs.
> As such, this platform code is now unused and can be deleted.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/include/asm/mach-jz4740/gpio.h | 371 ----------------------
>  arch/mips/jz4740/Makefile                |   2 -
>  arch/mips/jz4740/gpio.c                  | 519 -------------------------=
------
>  3 files changed, 892 deletions(-)
>  delete mode 100644 arch/mips/jz4740/gpio.c

Have you considered how this could best be merged? It's probably easiest
to take all of this through the MIPS tree because we have an addition of
the pinctrl that would be a replacement for the GPIO code, while at the
same time a bunch of drivers rely on the JZ4740 GPIO code for successful
compilation.

That's slightly complicated by the number of drivers, so needs a lot of
coordination, but it's not the worst I've seen.

Maybe one other solution that would make the transition easier would be
to stub out the GPIO functions if the pinctrl driver is enabled, and do
the removal of the mach-jz4740/gpio.h after all drivers have been merged
through their corresponding subsystem trees. That way all drivers should
remain compilable and functional at runtime, while still having the
possibility to merge through the subsystem trees.

That said, the whole series is fairly simple, so merging everything
through the MIPS tree sounds like the easiest way to go.

Thierry

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/GPcACgkQ3SOs138+
s6HJuA/8DBbCWXiobPupHIJkfkobmKLcWcDTCHrFnZvAFle+RTPeoANQQYkJ75pW
qHYVgHTL0x3n4NBLFvYl1Twl+fGLQNxEKbg87WBSj5jeAyTK3y4KA0P79OAfnkee
nSWeP8v+TluNV7gWSnFpUgFffHif24BbwtIsuLYxxn/awM2ZPQEx3CxDr5jvJD4E
2lTp4sYoRLmgHQb7Q7YH6b8JSibxXFEafzIfuSC42ySLXThDqY2TiMcQproKxfXl
/lruvG7w89INCAQOlXHG81sX0XGcbFYW0Cv1M5c0E3hk7DkbgFL3A5Q6IpnHjHdO
tOXg+DMjByeZMy9H3PP2vVnVva+fg5oMCWJHIP2Ih3d+CIBJdo6YlI/TvGH+Gh4h
4HKGiO83F+JljR5/ver0BBue9gyxCGs9sUO3B3TVAiunrS+hgfw/Wv+hcQ1IsubU
wnxXDrj54QxeP9O1T84yPD98e75O4tD1DHltfPZOI+bkxiQmvOGFYarcATKS0Edk
uJdWdEbfV/gB+1ckUpq0QEoTDdx7YEwuQCVn7dcS2hwyD4qEEc86j9Z+hkvk2+zg
cGHxOJ54wGqgIUMQM9/ohreFUPpifTWo6afe4tlos4V9BhA+1/dj29d0EmBJ2gON
TmNKjvYGHnilhT2uGMYDx6xfaXLGq8QG8o1kVlfRhCBWnGEyqzc=
=/Oal
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--


--===============5335441250778327517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============5335441250778327517==--
