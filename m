From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] mmc: disable card sleep via device-tree
Date: Mon, 23 Apr 2018 11:36:19 +0200
Message-ID: <20180423113619.6f557d8e@jawa>
References: <20180422213126.32756-1-lukma@denx.de>
        <CAPDyKFqaV0ehiHCNdt0i4sWE9cskBa9AQHdRZmzCphPzCdm9ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IF+H5faWthBKBtwH87VFZRl"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqaV0ehiHCNdt0i4sWE9cskBa9AQHdRZmzCphPzCdm9ow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Chanho Min <chanho.min@lge.com>, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
List-Id: linux-mmc@vger.kernel.org

--Sig_/IF+H5faWthBKBtwH87VFZRl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

> On 22 April 2018 at 23:31, Lukasz Majewski <lukma@denx.de> wrote:
> > From: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
> >
> > On a TQMa53 module the mmc_sleep leaves the eMMC card in a state
> > that the imx53 rom boot code is unable to probe, resulting in
> > reboot hanging. Add a device tree property to disable sleeping
> > on suspend.
> >
> > For TQMa53 modules the exact commit to cause hang after reboot
> > (v3.10 -> v3.11):
> > commit 486fdbbc1483 ("mmc: core: Add shutdown callback for (e)MMC
> > bus_ops")
> >
> > [The exact discussion can be found here:
> > https://patchwork.kernel.org/patch/8881401/
> > "i.MX53 restart via watchdog does not work"
> >
> > Signed-off-by: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  Documentation/devicetree/bindings/mmc/mmc-card.txt | 4 ++++
> >  drivers/mmc/core/mmc.c                             | 7 +++++--
> >  include/linux/mmc/card.h                           | 2 +-
> >  3 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt
> > b/Documentation/devicetree/bindings/mmc/mmc-card.txt index
> > 8d2d71758907..c3ee151edd7c 100644 ---
> > a/Documentation/devicetree/bindings/mmc/mmc-card.txt +++
> > b/Documentation/devicetree/bindings/mmc/mmc-card.txt @@ -12,6 +12,9
> > @@ Required properties: Optional properties:
> >  -broken-hpi : Use this to indicate that the mmc-card has a broken
> > hpi implementation, and that hpi should not be used
> > +-no-sleep-on-suspend : Do not put the card to sleep when
> > suspending.
> > +              There are boards with bootloaders that are unable
> > +              to probe such card when rebooting.
> >
> >  Example:
> >
> > @@ -26,5 +29,6 @@ Example:
> >                 reg =3D <0>;
> >                 compatible =3D "mmc-card";
> >                 broken-hpi;
> > +               no-sleep-on-suspend;
> >         };
> >  };
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 208a762b87ef..a3b74b5c8893 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -381,8 +381,11 @@ static int mmc_decode_ext_csd(struct mmc_card
> > *card, u8 *ext_csd) }
> >
> >         np =3D mmc_of_find_child_device(card->host, 0);
> > -       if (np && of_device_is_compatible(np, "mmc-card"))
> > +       if (np && of_device_is_compatible(np, "mmc-card")) {
> >                 broken_hpi =3D of_property_read_bool(np,
> > "broken-hpi");
> > +               card->no_sleep_on_suspend =3D
> > +                       of_property_read_bool(np,
> > "no-sleep-on-suspend");
> > +       }
> >         of_node_put(np);
> >
> >         /*
> > @@ -1990,7 +1993,7 @@ static int _mmc_suspend(struct mmc_host
> > *host, bool is_suspend) if (mmc_can_poweroff_notify(host->card) &&
> >                 ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE)
> > || !is_suspend)) err =3D mmc_poweroff_notify(host->card, notify_type);
> > -       else if (mmc_can_sleep(host->card))
> > +       else if (mmc_can_sleep(host->card)
> > && !host->card->no_sleep_on_suspend) =20
>=20
> No, this is wrong.
>=20
> This means that the mmc_power_off() a few lines below would start to
> violate the eMMC spec.=20
> That via powering off the card, without first
> sending the sleep or power-off-notify command.
> You are probably just lucky, as your particular eMMC card still copes
> with this in-correct sequence (I know there are these kind of cards).
>=20
> Well, what is also interesting in this regards, is what is happening
> during mmc_power_off().

The mmc_power_off() -> mmc_pwrseq_power_off() -> here the *pwrseq is
null, so we do nothing with the power.

In mmc_power_off() function we call mmc_set_initial_state(host);

> Does your host driver cut power to VMMC and/or
> VQMMC?

The esdhci3 controller uses 'vmm-supply' which is a 'regulator-fixed'
with 'regulator-always-on' attribute.

It seems like the eMMC is always powered with 3.3V.

Considering the above it seems like the card is still powered - the HW
design also supports some backup powering (so the voltage from the
board is not took immediately).


To be even more strange the suspend to mem works without any issues
(without this patch).
With "reboot -f" it seems like we hang in imx53 BootROM (as I can read
it from my JTAG debugger).

As written in the commit message - problems started after sending
suspend sequence of eMMC commands to the eMMC device.


[The eMMC memory itself is Micron 4GiB - 4.4.1]

>=20
> >                 err =3D mmc_sleep(host);
> >         else if (!mmc_host_is_spi(host))
> >                 err =3D mmc_deselect_cards(host);
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index 279b39008a33..c64d88e6de3b 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -304,8 +304,8 @@ struct mmc_card {
> >         struct dentry           *debugfs_root;
> >         struct mmc_part part[MMC_NUM_PHY_PARTITION]; /* physical
> > partitions */ unsigned int    nr_parts;
> > -
> >         unsigned int            bouncesz;       /* Bounce buffer
> > size */
> > +       bool    no_sleep_on_suspend;
> >  };
> >
> >  static inline bool mmc_large_sector(struct mmc_card *card)
> > --
> > 2.11.0
> > =20
>=20
> My impression is that it seems like there are still some uncertainties
> around what actually happens when the failure occurs during re-boot. I
> am guessing this boils done to how VMMC and VQMMC are being managed.
>=20
> BTW, in the the pwrseq_emmc, we register a restart handler to pull the
> reset GPIO for the eMMC. Perhaps that can help to fix this problem as
> well!?
>=20
> Kind regards
> Uffe




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/IF+H5faWthBKBtwH87VFZRl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlrdqRMACgkQAR8vZIA0
zr016gf/U3BMmug4/3JHoJvLnmWsn9Q/uhjNGsQb+5QKjnS5K3SWIGGYKraSStG/
A9sv3YR7x/WFE+GAB//u9g0zhkAPd6b+fTDxmbWnn2PmaY4JpRp1M/aTXg+oHIQm
qZcBUKYpgkTxaxybEmdzjZryupVv/X8Nojoxftmx3OrZ2dMQVk1FveR8avVlG3/5
RnCHesIqhBZNxv90j0bn5B5kVae+PyLyDg3w4pNmiaHZEaVbVvlMz8lI4+bcJNoM
pHSuW01yPos6FTXIQgO8BWIr1obUR8YYi8fqnQF9gBWqPpvXp0Sxy9rhJk91N5Ec
TvyTBn0TCZezMQR5rFEjHxlZDEmEag==
=rntX
-----END PGP SIGNATURE-----

--Sig_/IF+H5faWthBKBtwH87VFZRl--
