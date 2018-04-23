From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] mmc: disable card sleep via device-tree
Date: Mon, 23 Apr 2018 16:11:13 +0200
Message-ID: <20180423161113.463d4f0e@jawa>
References: <20180422213126.32756-1-lukma@denx.de>
        <CAPDyKFqaV0ehiHCNdt0i4sWE9cskBa9AQHdRZmzCphPzCdm9ow@mail.gmail.com>
        <20180423113619.6f557d8e@jawa>
        <CAPDyKFrhzVcST2SYjJaLb1vLTG3Rv+X7tmh7E-78A8xTYQyXOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ill8oKdg65MtHaRN_LooEhz"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrhzVcST2SYjJaLb1vLTG3Rv+X7tmh7E-78A8xTYQyXOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Chanho Min <chanho.min@lge.com>, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
List-Id: linux-mmc@vger.kernel.org

--Sig_/Ill8oKdg65MtHaRN_LooEhz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

> On 23 April 2018 at 11:36, Lukasz Majewski <lukma@denx.de> wrote:
> > Hi Ulf,
> > =20
> >> On 22 April 2018 at 23:31, Lukasz Majewski <lukma@denx.de> wrote: =20
> >> > From: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
> >> >
> >> > On a TQMa53 module the mmc_sleep leaves the eMMC card in a state
> >> > that the imx53 rom boot code is unable to probe, resulting in
> >> > reboot hanging. Add a device tree property to disable sleeping
> >> > on suspend.
> >> >
> >> > For TQMa53 modules the exact commit to cause hang after reboot
> >> > (v3.10 -> v3.11):
> >> > commit 486fdbbc1483 ("mmc: core: Add shutdown callback for (e)MMC
> >> > bus_ops")
> >> >
> >> > [The exact discussion can be found here:
> >> > https://patchwork.kernel.org/patch/8881401/
> >> > "i.MX53 restart via watchdog does not work"
> >> >
> >> > Signed-off-by: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
> >> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >> > ---
> >> >  Documentation/devicetree/bindings/mmc/mmc-card.txt | 4 ++++
> >> >  drivers/mmc/core/mmc.c                             | 7 +++++--
> >> >  include/linux/mmc/card.h                           | 2 +-
> >> >  3 files changed, 10 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt
> >> > b/Documentation/devicetree/bindings/mmc/mmc-card.txt index
> >> > 8d2d71758907..c3ee151edd7c 100644 ---
> >> > a/Documentation/devicetree/bindings/mmc/mmc-card.txt +++
> >> > b/Documentation/devicetree/bindings/mmc/mmc-card.txt @@ -12,6
> >> > +12,9 @@ Required properties: Optional properties:
> >> >  -broken-hpi : Use this to indicate that the mmc-card has a
> >> > broken hpi implementation, and that hpi should not be used
> >> > +-no-sleep-on-suspend : Do not put the card to sleep when
> >> > suspending.
> >> > +              There are boards with bootloaders that are unable
> >> > +              to probe such card when rebooting.
> >> >
> >> >  Example:
> >> >
> >> > @@ -26,5 +29,6 @@ Example:
> >> >                 reg =3D <0>;
> >> >                 compatible =3D "mmc-card";
> >> >                 broken-hpi;
> >> > +               no-sleep-on-suspend;
> >> >         };
> >> >  };
> >> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >> > index 208a762b87ef..a3b74b5c8893 100644
> >> > --- a/drivers/mmc/core/mmc.c
> >> > +++ b/drivers/mmc/core/mmc.c
> >> > @@ -381,8 +381,11 @@ static int mmc_decode_ext_csd(struct
> >> > mmc_card *card, u8 *ext_csd) }
> >> >
> >> >         np =3D mmc_of_find_child_device(card->host, 0);
> >> > -       if (np && of_device_is_compatible(np, "mmc-card"))
> >> > +       if (np && of_device_is_compatible(np, "mmc-card")) {
> >> >                 broken_hpi =3D of_property_read_bool(np,
> >> > "broken-hpi");
> >> > +               card->no_sleep_on_suspend =3D
> >> > +                       of_property_read_bool(np,
> >> > "no-sleep-on-suspend");
> >> > +       }
> >> >         of_node_put(np);
> >> >
> >> >         /*
> >> > @@ -1990,7 +1993,7 @@ static int _mmc_suspend(struct mmc_host
> >> > *host, bool is_suspend) if (mmc_can_poweroff_notify(host->card)
> >> > && ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE)
> >> > || !is_suspend)) err =3D mmc_poweroff_notify(host->card,
> >> > notify_type);
> >> > -       else if (mmc_can_sleep(host->card))
> >> > +       else if (mmc_can_sleep(host->card)
> >> > && !host->card->no_sleep_on_suspend) =20
> >>
> >> No, this is wrong.
> >>
> >> This means that the mmc_power_off() a few lines below would start
> >> to violate the eMMC spec.
> >> That via powering off the card, without first
> >> sending the sleep or power-off-notify command.
> >> You are probably just lucky, as your particular eMMC card still
> >> copes with this in-correct sequence (I know there are these kind
> >> of cards).
> >>
> >> Well, what is also interesting in this regards, is what is
> >> happening during mmc_power_off(). =20
> >
> > The mmc_power_off() -> mmc_pwrseq_power_off() -> here the *pwrseq is
> > null, so we do nothing with the power.
> >
> > In mmc_power_off() function we call mmc_set_initial_state(host);
> > =20
> >> Does your host driver cut power to VMMC and/or
> >> VQMMC? =20
> >
> > The esdhci3 controller uses 'vmm-supply' which is a
> > 'regulator-fixed' with 'regulator-always-on' attribute. =20
>=20
> Assume you mean vmmc-supply.
>=20
> Anyway, it seems a bit weird to have this regulator as fixed and
> always on. Of course it's possible, but it's more common to have vqmmc
> fixed and always on. Maybe double check the schematics.
>=20
> >
> > It seems like the eMMC is always powered with 3.3V. =20
>=20
> What about vqmmc then?

It seems like the vqmmc is not added/used in dts (imx53.dtsi). Only the
vmmc-supply is used.

>=20
> >
> > Considering the above it seems like the card is still powered - the
> > HW design also supports some backup powering (so the voltage from
> > the board is not took immediately). =20
>=20
> I think you need to verify that the CMD5 (sleep) is actually sent and
> successfully completed.
>=20
> In regards to that, do your host support MMC_CAP_WAIT_WHILE_BUSY?

No. This flag is not supported (set) on this host.

> If
> not, there is a delay (specific to the card) after the CMD5.

Yes, the delay is used (mmc.c Line 1890).
The delay is 7ms (as read from card->ext_csd.sa_timeout).

Increasing it by 10 (or 100) ms doesn't solve the problem.

>=20
> So the support in your host driver for MMC_CAP_WAIT_WHILE_BUSY could
> be broken, or the delay may be too short. Perhaps forcing to use the
> delay and use a delay that for sure should work is worth to test.
>=20
> >
> >
> > To be even more strange the suspend to mem works without any issues
> > (without this patch).
> > With "reboot -f" it seems like we hang in imx53 BootROM (as I can
> > read it from my JTAG debugger). =20
>=20
> So clearly there is a difference during reboot.
>=20
> A wild guess... Probably vmmc supply is turned on/off in this path,
> while perhaps the CMD5 support has failed when the kernel issued
> it...=20

This needs to be checked.

It may be also possible that the BootROM expects that the eMMC would
not be in SLEEP state (after CMD5 issuing).

>=20
> >
> > As written in the commit message - problems started after sending
> > suspend sequence of eMMC commands to the eMMC device.
> >
> >
> > [The eMMC memory itself is Micron 4GiB - 4.4.1] =20
>=20
> [...]
>=20
> Kind regards
> Uffe




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/Ill8oKdg65MtHaRN_LooEhz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlrd6YEACgkQAR8vZIA0
zr2/Tgf/QLl9IssceC6exun5bJr+b8iZheqJcw1mm4LKtWZCrBnYLnRwkxmvxyVx
q3ge9oj3uEXPuz3bKQe9SRuXZxGs46SEpmyhGm3QqERgdNuIrASM9iBagB+2eY7m
tBYtWcE5T9/BhKQSxnxUOiYiW8qfA7NFJVtxBknOThbz0jQV0LBigahZCcOQNzC0
LH1aUaD8VSjW5pXcbu0LBGFWxOkOLtpiOTwLeuQJpZ4PBzlg+3XiyVHqkjyY+qYu
55+FKhB2OMTS8+5YqMlEblDRSNMH5jdJGr9aDIfuK8nuHnQUdC/rNrMruA7Y5ptP
0KkNqajtazm9bNRM4hjjypX2QkZsYg==
=dR5g
-----END PGP SIGNATURE-----

--Sig_/Ill8oKdg65MtHaRN_LooEhz--
