From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 00/40] Tegra SDHCI add support for HS200 and UHS
 signaling
Date: Mon, 27 Aug 2018 17:57:11 +0200
Message-ID: <20180827155711.GA6871@ulmo>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
 <1535379056.14664.13.camel@toradex.com>
 <20180827155053.GA6458@ulmo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180827155053.GA6458@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Aapo Vienamo <avienamo@nvidia.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>, "mperttunen@nvidia.com" <mperttunen@nvidia.com>, "stefan@agner.ch" <stefan@agner.ch>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 05:50:53PM +0200, Thierry Reding wrote:
> On Mon, Aug 27, 2018 at 02:10:58PM +0000, Marcel Ziswiler wrote:
> > On Fri, 2018-08-10 at 21:08 +0300, Aapo Vienamo wrote:
> > > Hi all,
> > >=20
> > > This series implements support for faster signaling modes on Tegra
> > > SDHCI controllers. This series consist of several parts: changes
> > > requried for 1.8 V signaling and pad control, pad calibration, and
> > > tuning. Following earlies patch sets have been merged into this
> > > larger set: "Tegra PMC pinctrl pad configuration", "Tegra SDHCI
> > > enable
> > > 1.8 V signaling on Tegar210 and Tegra186", "Tegra SDHCI update the
> > > padautocal procedure". Also the patches for enabling SDHCI tuning
> > > are added.
> >=20
> > I tried your tkln/hs200 branch on Colibri T20, Apalis/Colibri T30 and
> > Apalis TK1. It at least does not seem to make things any worse but
> > HS200 on TK1 still seems to behave strangely. During boot I do get the
> > following message (mmc0 being the SDHCI instance of one of them SD card
> > slots):
> >=20
> > [    3.238360] mmc0: Internal clock never stabilised.
> > [    3.243183] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI =
REGISTER DUMP
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    3.249649] mmc0: sdhci: Sys addr:  0x00000000 |
> > Version:  0x00000303
> > [    3.256138] mmc0: sdhci: Blk size:  0x00000000 | Blk
> > cnt:  0x00000000
> > [    3.262657] mmc0: sdhci: Argument:  0x00000000 | Trn mode:
> > 0x00000000
> > [    3.269119] mmc0: sdhci: Present:   0x01fb00f0 | Host ctl:
> > 0x00000000
> > [    3.275580] mmc0: sdhci: Power:     0x0000000f | Blk
> > gap:  0x00000000
> > [    3.282041] mmc0: sdhci: Wake-up:   0x00000000 |
> > Clock:    0x00000401
> > [    3.288485] mmc0: sdhci: Timeout:   0x00000000 | Int stat:
> > 0x00000000
> > [    3.295037] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab:
> > 0x00fc0003
> > [    3.301559] mmc0: sdhci: AC12 err:  0x00000000 | Slot int:
> > 0x00000000
> > [    3.308022] mmc0: sdhci: Caps:      0x376fd080 |
> > Caps_1:   0x10000f70
> > [    3.314527] mmc0: sdhci: Cmd:       0x00000000 | Max curr:
> > 0x00000000
> > [    3.321159] mmc0: sdhci: Resp[0]:   0x00000000 |
> > Resp[1]:  0x00000000
> > [    3.327642] mmc0: sdhci: Resp[2]:   0x00000000 |
> > Resp[3]:  0x00000000
> > [    3.334144] mmc0: sdhci: Host ctl2: 0x00000000
> > [    3.338613] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
> > 0x00000000
> > [    3.345110] mmc0: sdhci:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > And it subsequently stalls waiting for interrupt for more than 8
> > seconds before continuing to mount the rootfs as follows (mmc2 being
> > the SDHCI instance of the eMMC):
> >=20
> > [    4.874017] tegra-hdmi 54280000.hdmi: cannot set audio to 48000 Hz
> > at 297000000 Hz pixel clock
> > [   13.930136] mmc2: Timeout waiting for hardware interrupt.
> > [   13.935603] mmc2: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI =
REGISTER DUMP
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   13.942071] mmc2: sdhci: Sys addr:  0x00000000 |
> > Version:  0x00000303
> > [   13.948511] mmc2: sdhci: Blk size:  0x00007080 | Blk
> > cnt:  0x00000001
> > [   13.954948] mmc2: sdhci: Argument:  0x00000000 | Trn mode:
> > 0x00000013
> > [   13.961385] mmc2: sdhci: Present:   0x01fb00f0 | Host ctl:
> > 0x00000031
> > [   13.967821] mmc2: sdhci: Power:     0x00000001 | Blk
> > gap:  0x00000000
> > [   13.974263] mmc2: sdhci: Wake-up:   0x00000000 |
> > Clock:    0x00000007
> > [   13.980692] mmc2: sdhci: Timeout:   0x0000000e | Int stat:
> > 0x00000000
> > [   13.987119] mmc2: sdhci: Int enab:  0x02ff000b | Sig enab:
> > 0x02fc000b
> > [   13.993546] mmc2: sdhci: AC12 err:  0x00000000 | Slot int:
> > 0x00000000
> > [   13.999974] mmc2: sdhci: Caps:      0x376fd080 |
> > Caps_1:   0x10000f70
> > [   14.006415] mmc2: sdhci: Cmd:       0x0000153a | Max curr:
> > 0x00000000
> > [   14.012845] mmc2: sdhci: Resp[0]:   0x00000b00 |
> > Resp[1]:  0x048062bf
> > [   14.019272] mmc2: sdhci: Resp[2]:   0x314a8000 |
> > Resp[3]:  0x00000240
> > [   14.025697] mmc2: sdhci: Host ctl2: 0x0000000b
> > [   14.030132] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
> > 0xfbc6b208
> > [   14.036561] mmc2: sdhci:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   14.044332] mmc2: new HS200 MMC card at address 0001
> > [   14.050656] mmcblk2: mmc2:0001 016G30 14.7 GiB
> > [   14.056376] mmcblk2boot0: mmc2:0001 016G30 partition 1 4.00 MiB
> > [   14.063563] mmcblk2boot1: mmc2:0001 016G30 partition 2 4.00 MiB
> > [   14.069589] mmcblk2rpmb: mmc2:0001 016G30 partition 3 4.00 MiB,
> > chardev (247:0)
> > [   14.078260]  mmcblk2: p1 p2
> >=20
> > After that it actually seems to work quite nicely:
> >=20
> > root@apalis-tk1-mainline:~# cat /sys/kernel/debug/mmc2/ios
> > clock:          200000000 Hz
> > actual clock:   163200000 Hz
> > vdd:            21 (3.3 ~ 3.4 V)
> > bus mode:       2 (push-pull)
> > chip select:    0 (don't care)
> > power mode:     2 (on)
> > bus width:      3 (8 bits)
> > timing spec:    9 (mmc HS200)
> > signal voltage: 1 (1.80 V)
> > driver type:    0 (driver type B)
> > root@apalis-tk1-mainline:~# hdparm -t /dev/mmcblk2
> >=20
> > /dev/mmcblk2:
> >  Timing buffered disk reads: 408 MB in  3.01 seconds =3D 135.39 MB/sec
> >=20
> > Have you ever observed similar behaviour? What could cause this?
> >=20
> > Anybody else tried it on TK1?
>=20
> I can't reproduce this on Jetson TK1. Things boot normally and I don't
> see the controllers switch into HS200 for either eMMC or SD card.
>=20
> Did you update the device tree to enable HS200 on Apalis?
>=20
> Aapo, isn't there a mechanism to prevent HS200 on devices where it
> hasn't explicitly been tested (and enabled)? I thought we had discussed
> that this was going to depend on pinmux DTS entries, but I can't find
> the actual code where any of that would be checked. I only see checking
> NVQUIRK_NEEDS_PAD_CONTROL in tegra_sdhci_is_pad_and_regulator_valid(),
> but since we don't enable that quirk on Tegra124, it would seem to me
> that we always enable fast modes on boards that don't need pad control.
> Is that really what we want?
>=20
> Also, if the above is correct, then why am I not seeing faster modes
> getting enabled on Jetson TK1?

I also just ran into what seems to be a typo. Do we want the below fix?

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index ef18a0c6ed3a..a6053e5004da 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -336,7 +336,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, =
u8 mask)
                        misc_ctrl |=3D SDHCI_MISC_CTRL_ENABLE_DDR50;
                if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
                        misc_ctrl |=3D SDHCI_MISC_CTRL_ENABLE_SDR104;
-               if (soc_data->nvquirks & SDHCI_MISC_CTRL_ENABLE_SDR50)
+               if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
                        clk_ctrl |=3D SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRID=
E;
        }
=20

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluEH1cACgkQ3SOs138+
s6Eg4w//YemcQEEmCD0N2vXKchQ3HoXyOuvTinqUuV+1X5pwxr5Wsjno2ECk6GCG
PJt2YaXBfBFCteo8rLTVVp3Tt6ZUQeCkhdvIxFqS7FFrJQz72QjNlZYcyUgmTmhG
SqVpdItHp093eO+gT3qZPZaLjHVVQr9UgIaM9Uw7s1ISD2KeMn7C5weEY9OOFE14
6x2t2R/1pamfRq6NWruRMktZ++vgSx9gfexbsuN4tRpyefn11mtIju+pDb/+eXlC
49Hiiaf6xN4Ip5qBd84b9aybN62y7WWjIN9E1E1v7NAhhUhIM8w0xHvCiB8P9Npe
RHpH9eyzNPnge40ecLRaZf2/j7Td+KXCDNGD0ML3imYH9mh5zzghpqhBOqizUIan
aoRZGiktb1F5+TPRMC6+E/YsmoRLwDHKsvmB4WTz5UF22lF1oFfzArIdKY7xr0fT
hvg+5FFCIDkltPjSlWXgFPG85AWdLpQy+TEoYZJSNAhkpk6gDQvCdFLodzqnW+w9
VZnukOCaH275KkLSQiCixdqSFydgiDS7Vr2F1u9VTsQnlCg//JHW3YZMxmz2D8pD
ZtyXFgnxo0byIeh7n06lr47LDEg7qKJGbJ5NvsFQ5TFkv+/q+uQPJiA2OrDOI3LQ
DC9wDMbZgimazYVLXoIKxDnu/pekUmq+b5/7NWnxrUjgfdc+cz0=
=y6D7
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
