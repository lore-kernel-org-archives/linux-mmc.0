From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/1] mmc: sunxi: Disable irq during pm_suspend
Date: Wed, 4 Jul 2018 09:44:35 +0200
Message-ID: <20180704074435.46aqhuthrn2vok5x@flea>
References: <1530685741-20604-1-git-send-email-stefan@olimex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5f54sll2jggg7dtn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530685741-20604-1-git-send-email-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Mavrodiev <stefan@olimex.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--5f54sll2jggg7dtn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 09:28:59AM +0300, Stefan Mavrodiev wrote:
> When mmc host controller enters suspend state, the clocks are
> disabled, but irqs are not. For some reason the irqchip emits
> false interrupts, which causes system lock loop.
>=20
> Debug log is:
>   ...
>   sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 51200000
>   sunxi-mmc 1c11000.mmc: enabling the clock
>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   sunxi-mmc 1c11000.mmc: cmd 6(80000146) arg 3210101 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   mmc1: new DDR MMC card at address 0001
>   mmcblk1: mmc1:0001 AGND3R 14.6 GiB
>   mmcblk1boot0: mmc1:0001 AGND3R partition 1 4.00 MiB
>   mmcblk1boot1: mmc1:0001 AGND3R partition 2 4.00 MiB
>   sunxi-mmc 1c11000.mmc: cmd 18(80003352) arg 0 ie 0x0000fbc2 len 409
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00004000 idi 00000002
>    mmcblk1: p1
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
> and so on...
>=20
> This issue apears on eMMC cards, routed on MMC2 slot. The patch is
> tested with A20-OLinuXino-MICRO/LIME/LIME2 boards.
>=20
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--5f54sll2jggg7dtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAls8euIACgkQ0rTAlCFN
r3QWcxAAkanogogQaGFEgZZiX02cRiz03ciIQAbsl77c3hxxh5Kpe8/hdfpVYwHL
F+eVvMUeD4WeX7qXOptd3NlBClOSRw3atXmW1z7aEIQwKrKYNZn8foAjuV2+jrz5
3PfQalJf8ZpZDUDnZqISCIvt778H0qAp7DYk4+Hk0q5fUo5KYC+PebhHg8EL44ig
m//ETl6Te/d7dppUlO3n6qeF6AfdSToFg0e5E3g3L7nbot7mZWZ8Arc1AcyU1qjZ
WRxRz40PTBq/dMIC3DGSCC4zQ8dMZ9+W2+4eisFXG7+Oh7i6nstXxR8VCotmp3H6
HIgHxFmVaRPnmgWlGu0POvvxwI2d0e89tLMirk9MK4AP8sQgViDsl21kg4Q9G3sN
2z5gwco+8bTwmLjGg5eR8WM2zSMBfyWF/ZPqFwLT9Rx2MZCuS1uzkEjI0OIz3RjK
dh6feqFals4qT3NzzsRgV8wZLA3uaHD/Qef+zzfPCRcWvj596IPOy9QRsoQUn4/k
gN1fNSalYjSSmAXsCkEYDSgZcjCdgV3pRGcDfmv6cIzAysPATbulyrxa5gzXdkcp
QRItj0ZuVZLiMbAKfjNMVqUcGUZSm5Yl+OJao1FHE6UMlD8Q4HK+Tu2wNT+yWzTk
XxmYG10kFow2jI1o0Imce+f/ocacDvjmNZZaH9kT4khr8921p0g=
=s/IJ
-----END PGP SIGNATURE-----

--5f54sll2jggg7dtn--
