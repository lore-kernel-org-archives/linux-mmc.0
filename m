From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH v2] mmc: tegra: Mark 64-bit DMA broken on Tegra124
Date: Fri, 02 Sep 2016 00:52:22 +0200
Message-ID: <1472770342.3813.11.camel@paulk.fr>
References: <20160901114617.19416-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4WHpBx1NBqLLtam0GUgH"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160901114617.19416-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--=-4WHpBx1NBqLLtam0GUgH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 01 septembre 2016 =C3=A0 13:46 +0200, Thierry Reding a =C3=A9crit=
=C2=A0:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> According to the TRM, the SD/MMC controller on Tegra124 supports 34-bit
> addressing, but testing shows that this doesn't work. On a device which
> has more than 2 GiB of RAM and LPAE enabled, buffer allocations can use
> addresses above the 32-bit boundary.
>=20
> One way to work around this would be to enable IOMMU physical to virtual
> address translations for the SD/MMC controllers, but that's not easy to
> implement without breaking existing use-cases. It's also not obvious why
> 34-bit addressing doesn't work as advertised. In order to fix this for
> existing users, add the SDHCI_QUIRK2_BROKEN_64_BIT_DMA quirk for now.

I finally took time to test this and it sadly doesn't fix the issue I have =
on
tegra124 with 4 GiB RAM and LPAE.

dmesg when the issue happens (with the patch applied and some debug added)
follows:

sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
sdhci-tegra 700b0000.sdhci: allocated mmc-pwrseq
sdhci-tegra 700b0400.sdhci: Got CD GPIO
sdhci-tegra 700b0400.sdhci: Got WP GPIO
mmc0: Unknown controller version (3). You may experience problems.
random: fast init done
sdhci_set_dma_mask(): broken 64bit dma
sdhci_set_dma_mask(): use 32bit dma
mmc0: Invalid maximum block size, assuming 512 bytes
input: Elan Touchpad as /devices/soc0/7000c400.i2c/i2c-1/1-0015/input/input=
1
using ADMA
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
tegra-mc 70019000.memory-controller: hdar: read @0x000000007c058000: EMEM a=
ddress decode error (EMEM decode error)
tegra30-i2s 70301100.i2s: DMA channels sourced from device 70300000.ahub
max98090 0-0010: MAX98090 REVID=3D0x43
max98090 0-0010: use default 2.8v micbias
tegra-snd-max98090 sound: HiFi <-> 70301100.i2s mapping ok
input: GoogleNyanBig Headphones as /devices/soc0/sound/sound/card1/input2
input: GoogleNyanBig Mic Jack as /devices/soc0/sound/sound/card1/input3
tegra-mc 70019000.memory-controller: sdmmcrab: read @0x000000007c050200: EM=
EM address decode error (EMEM decode error)
mmc0: ADMA error

A usual dmesg without LPAE enabled follows:
[=C2=A0=C2=A0=C2=A013.593724] mmc0: Unknown controller version (3). You may=
 experience problems.
[=C2=A0=C2=A0=C2=A013.600934] sdhci_set_dma_mask(): broken 64bit dma
[=C2=A0=C2=A0=C2=A013.605716] sdhci_set_dma_mask(): use 32bit dma
[=C2=A0=C2=A0=C2=A013.610262] mmc0: Invalid maximum block size, assuming 51=
2 bytes
[=C2=A0=C2=A0=C2=A013.622382] input: Elan Touchpad as /devices/soc0/7000c40=
0.i2c/i2c-1/1-0015/input/input1
[=C2=A0=C2=A0=C2=A013.675562] mmc0: SDHCI controller on 700b0600.sdhci [700=
b0600.sdhci] using ADMA

which shows the same other two errors about controller version and block si=
ze.

> Reported-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Changes in v2:
> - add comment with rationale for the quirk
> - add various Acked-bys
>=20
> =C2=A0drivers/mmc/host/sdhci-tegra.c | 27 ++++++++++++++++++++++++++-
> =C2=A01 file changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 1e93dc4e303e..20b6ff5b4af1 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -391,6 +391,31 @@ static const struct sdhci_tegra_soc_data
> soc_data_tegra114 =3D {
> =C2=A0	.pdata =3D &sdhci_tegra114_pdata,
> =C2=A0};
> =C2=A0
> +static const struct sdhci_pltfm_data sdhci_tegra124_pdata =3D {
> +	.quirks =3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +		=C2=A0=C2=A0SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +		=C2=A0=C2=A0SDHCI_QUIRK_SINGLE_POWER_WRITE |
> +		=C2=A0=C2=A0SDHCI_QUIRK_NO_HISPD_BIT |
> +		=C2=A0=C2=A0SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
> +		=C2=A0=C2=A0SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		=C2=A0=C2=A0=C2=A0/*
> +		=C2=A0=C2=A0=C2=A0=C2=A0* The TRM states that the SD/MMC controller fo=
und on
> +		=C2=A0=C2=A0=C2=A0=C2=A0* Tegra124 can address 34 bits (the maximum su=
pported by
> +		=C2=A0=C2=A0=C2=A0=C2=A0* the Tegra memory controller), but tests show=
 that DMA
> +		=C2=A0=C2=A0=C2=A0=C2=A0* to or from above 4 GiB doesn't work. This is=
 possibly
> +		=C2=A0=C2=A0=C2=A0=C2=A0* caused by missing programming, though it's n=
ot obvious
> +		=C2=A0=C2=A0=C2=A0=C2=A0* what sequence is required. Mark 64-bit DMA b=
roken for
> +		=C2=A0=C2=A0=C2=A0=C2=A0* now to fix this for existing users (e.g. Nya=
n boards).
> +		=C2=A0=C2=A0=C2=A0=C2=A0*/
> +		=C2=A0=C2=A0=C2=A0SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
> +	.ops=C2=A0=C2=A0=3D &tegra114_sdhci_ops,
> +};
> +
> +static const struct sdhci_tegra_soc_data soc_data_tegra124 =3D {
> +	.pdata =3D &sdhci_tegra124_pdata,
> +};
> +
> =C2=A0static const struct sdhci_pltfm_data sdhci_tegra210_pdata =3D {
> =C2=A0	.quirks =3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> =C2=A0		=C2=A0=C2=A0SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> @@ -408,7 +433,7 @@ static const struct sdhci_tegra_soc_data soc_data_teg=
ra210
> =3D {
> =C2=A0
> =C2=A0static const struct of_device_id sdhci_tegra_dt_match[] =3D {
> =C2=A0	{ .compatible =3D "nvidia,tegra210-sdhci", .data =3D &soc_data_teg=
ra210
> },
> -	{ .compatible =3D "nvidia,tegra124-sdhci", .data =3D &soc_data_tegra114
> },
> +	{ .compatible =3D "nvidia,tegra124-sdhci", .data =3D &soc_data_tegra124
> },
> =C2=A0	{ .compatible =3D "nvidia,tegra114-sdhci", .data =3D &soc_data_teg=
ra114
> },
> =C2=A0	{ .compatible =3D "nvidia,tegra30-sdhci", .data =3D &soc_data_tegr=
a30 },
> =C2=A0	{ .compatible =3D "nvidia,tegra20-sdhci", .data =3D &soc_data_tegr=
a20 },
--=20
Paul Kocialkowski, developer of low-level free software for embedded device=
s

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-4WHpBx1NBqLLtam0GUgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXyLEmAAoJEIT9weqP7pUMS5AP/2tkql9xqnW1fwocOgYkj8+c
Vus4lypykTEuV0Br8+qqOFVEViRZ6vpObiHMRPLoGBbs0kgI8gf7bwkAIELBqceK
q4PVSkvFHyHODtphqAh8XbYSp9TaXABq5dmGe3yANvD4sgoTAx7VsAOA6LS50k2a
Wl2P4nmKLxH2x5v63bCAs+IaP8raljyZsQwqS5TCXq7JFD134oiN1mmBp8rrp5Jf
wkwUP96ubNlN1UXxWtEt8vmJGTCPI9GBAqxyujRf/tLA0rQ5ucZij51XrgSDGo6Y
7lMh5BAAvGdjineMaRt5BjwJHX9z4LdOJ7XMjKAfwXX2QyctgAitmIzRoOM/pYKD
218L8GRJ+g9FAZUFm/keyNZKmePhja/EnFWRZwCGdi8FhWDdaGsCqePqfIWr3Am1
U0AQy5IVcrSZAoVMXfD73R4lI/JuhJ8kKZnwQqXlDZnm42ANWrpgG1PcZ7UfhS/M
9fhpFye/5oOwE8nLBc4BjuUZ0xPanvTkDPgufDgEz17INzkg2yhEtAkfn0Phq4i/
q2R1BsoQR4vRQ6kSBJ9RS9xMRaXZfSiXpzfChk7Mv3q2q83vPt2o8t+lQodkzJnF
LreOFdV1DZHghPuqQ4uL2uSxcL5NHefq1NVFMZPxr8w0xPnSN0fFrdUIrOkpJmaP
P5KB82eYLJODBpX4R7wJ
=/x6G
-----END PGP SIGNATURE-----

--=-4WHpBx1NBqLLtam0GUgH--
