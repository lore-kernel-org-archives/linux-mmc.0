From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/1] mmc: sunxi: Disable irq during pm_suspend
Date: Wed, 4 Jul 2018 13:48:10 +0200
Message-ID: <20180704114810.nwy763c7gvtgb4bq@flea>
References: <1530685741-20604-1-git-send-email-stefan@olimex.com>
 <CAPDyKFo_fadfNbt8YMS3MMjaxjt1B54DtZJ+-LoH9y5JeRi5pQ@mail.gmail.com>
 <9b8f30fd-12aa-46ba-ced9-aed38ada0059@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ru7c7wdsakc2z2iq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9b8f30fd-12aa-46ba-ced9-aed38ada0059@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stefan Mavrodiev <stefan@olimex.com>, Chen-Yu Tsai <wens@csie.org>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--ru7c7wdsakc2z2iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 12:34:01PM +0100, Marc Zyngier wrote:
> On 04/07/18 11:50, Ulf Hansson wrote:
> > + Marc
> >=20
> > On 4 July 2018 at 08:28, Stefan Mavrodiev <stefan@olimex.com> wrote:
> >> When mmc host controller enters suspend state, the clocks are
> >> disabled, but irqs are not. For some reason the irqchip emits
> >> false interrupts, which causes system lock loop.
> >>
> >> Debug log is:
> >>   ...
> >>   sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 51200000
> >>   sunxi-mmc 1c11000.mmc: enabling the clock
> >>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
> >>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
> >>   sunxi-mmc 1c11000.mmc: cmd 6(80000146) arg 3210101 ie 0x0000bbc6 len=
 0
> >>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
> >>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
> >>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
> >>   mmc1: new DDR MMC card at address 0001
> >>   mmcblk1: mmc1:0001 AGND3R 14.6 GiB
> >>   mmcblk1boot0: mmc1:0001 AGND3R partition 1 4.00 MiB
> >>   mmcblk1boot1: mmc1:0001 AGND3R partition 2 4.00 MiB
> >>   sunxi-mmc 1c11000.mmc: cmd 18(80003352) arg 0 ie 0x0000fbc2 len 409
> >>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00004000 idi 00000002
> >>    mmcblk1: p1
> >>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
> >>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
> >>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
> >>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
> >> and so on...
> >>
> >> This issue apears on eMMC cards, routed on MMC2 slot. The patch is
> >> tested with A20-OLinuXino-MICRO/LIME/LIME2 boards.
> >>
> >> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> >> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> >> ---
> >>  Changes in v2:
> >>   - Add comment why disable_irq() is necessary
> >>
> >> ---
> >>  drivers/mmc/host/sunxi-mmc.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc=
=2Ec
> >> index e747259..8e7f3e3 100644
> >> --- a/drivers/mmc/host/sunxi-mmc.c
> >> +++ b/drivers/mmc/host/sunxi-mmc.c
> >> @@ -1446,6 +1446,7 @@ static int sunxi_mmc_runtime_resume(struct devic=
e *dev)
> >>         sunxi_mmc_init_host(host);
> >>         sunxi_mmc_set_bus_width(host, mmc->ios.bus_width);
> >>         sunxi_mmc_set_clk(host, &mmc->ios);
> >> +       enable_irq(host->irq);
> >>
> >>         return 0;
> >>  }
> >> @@ -1455,6 +1456,12 @@ static int sunxi_mmc_runtime_suspend(struct dev=
ice *dev)
> >>         struct mmc_host *mmc =3D dev_get_drvdata(dev);
> >>         struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> >>
> >> +       /*
> >> +        * When clocks are off, it's possible receiving
> >> +        * fake interrupts, which will stall the system.
> >> +        * Disabling the irq  will prevent this.
> >> +        */
> >> +       disable_irq(host->irq);
> >=20
> > No, this doesn't work for shared IRQs.
>=20
> Well, in this case, it does work, because that interrupt line cannot be
> shared with anything else, if I understand how the SoC is wired: each
> MMC controller has a dedicated interrupt line to the GIC, and it isn't
> shared with anything (that's on the A20 though, and I don't know about
> other SoCs integrating the same IP).

Yeah, and I've never seen a shared interrupt line within the Allwinner
SoCs, so I guess we're pretty safe from that regard.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ru7c7wdsakc2z2iq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAls8s+cACgkQ0rTAlCFN
r3Q1GA/+LKa52m8o/rn9qqLMPNb78v/VtPvWYtYmjR6jH+NNGduqH90o1SxEy33S
pRuZHrV/wxcqhFHhksrADzjJyFh3StCep0LMke4h8XzoIfM8xbyk7RRnQfUs2rSu
sX5FOkk22/efA8wJ1ktxjqbyKcLFbbyLk1GkyG2g52FVfQ6T6gMq1yJEq7DOnGTu
8itlb04q4znqLezZF+6gL2NgPSDLR27r9Yu98IUQsckWQI9d97OgYkr8cfZgYBY9
tFJDzPijEBwOCfz8DJe9keb28PuPi/7kLM7Am3aTHWqGZ8nwQQOP/kV18txu1Nb8
W9BPpaAYOgZZie+wI6TSN5vV0XnfSzktzaBykqRoUrANI6UPeYEVCcMlbW5Cv2DH
TM0D4X92Ny5aRCD14gtf8/0boEpeoYr1dzmtWwJtpBCXr9nGIGoTethI6t+KDHZt
2gLVLkmnuzxQgQfF8Q6chNFPoJ0wdybrqXzzzzYWXvho3usNHY76rAHYptsVy5EE
5Ln/LpT+361Km46tGv7WOuSGEOMKyjFT0h3IOXuhLIgTQpCtwFBh4IywFshkxViY
n8y+yN9ffGlJ5JIG82wsYgnKgGDN/hS7gtpbIsJFq+f9OI7vUnI+S3dI00WzR3zN
u+nqH73gPvwnrFNeAhbdZcOjQ5G6oPeL+dnl2gvfsWQ+x4Xrd5E=
=6DST
-----END PGP SIGNATURE-----

--ru7c7wdsakc2z2iq--
