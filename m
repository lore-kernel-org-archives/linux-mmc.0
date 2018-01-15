From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Fix i.MX53 eSDHCv3 clock
Date: Mon, 15 Jan 2018 13:54:39 +0100
Message-ID: <CAPDyKFoBoVNvYfTpw3gA2Uzwza6hsSAKP7tV+YxKaci2GHF1og@mail.gmail.com>
References: <20180114184305.4018-1-benoit.thebaudeau.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180114184305.4018-1-benoit.thebaudeau.dev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau.dev@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "Wladimir J . van der Laan" <laanwj@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On 14 January 2018 at 19:43, Beno=C3=AEt Th=C3=A9baudeau
<benoit.thebaudeau.dev@gmail.com> wrote:
> Commit 5143c953a786 ("mmc: sdhci-esdhc-imx: Allow all supported
> prescaler values") made it possible to set SYSCTL.SDCLKFS to 0 in SDR
> mode, thus bypassing the SD clock frequency prescaler, in order to be
> able to get higher SD clock frequencies in some contexts. However, that
> commit missed the fact that this value is illegal on the eSDHCv3
> instance of the i.MX53. This seems to be the only exception on i.MX,
> this value being legal even for the eSDHCv2 instances of the i.MX53.
>
> Fix this issue by changing the minimum prescaler value if the i.MX53
> eSDHCv3 is detected. According to the i.MX53 reference manual, if
> DLLCTRL[10] can be set, then the controller is eSDHCv3, else it is
> eSDHCv2.
>
> This commit fixes the following issue, which was preventing the i.MX53
> Loco (IMX53QSB) board from booting Linux 4.15.0-rc5:
> [    1.882668] mmcblk1: error -84 transferring data, sector 2048, nr 8, c=
md response 0x900, card status 0xc00
> [    2.002255] mmcblk1: error -84 transferring data, sector 2050, nr 6, c=
md response 0x900, card status 0xc00
> [   12.645056] mmc1: Timeout waiting for hardware interrupt.
> [   12.650473] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI RE=
GISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   12.656921] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001201
> [   12.663366] mmc1: sdhci: Blk size:  0x00000004 | Blk cnt:  0x00000000
> [   12.669813] mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> [   12.676258] mmc1: sdhci: Present:   0x01f8028f | Host ctl: 0x00000013
> [   12.682703] mmc1: sdhci: Power:     0x00000002 | Blk gap:  0x00000000
> [   12.689148] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000003f
> [   12.695594] mmc1: sdhci: Timeout:   0x0000008e | Int stat: 0x00000000
> [   12.702039] mmc1: sdhci: Int enab:  0x107f004b | Sig enab: 0x107f004b
> [   12.708485] mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00001201
> [   12.714930] mmc1: sdhci: Caps:      0x07eb0000 | Caps_1:   0x08100810
> [   12.721375] mmc1: sdhci: Cmd:       0x0000163a | Max curr: 0x00000000
> [   12.727821] mmc1: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x00000000
> [   12.734265] mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> [   12.740709] mmc1: sdhci: Host ctl2: 0x00000000
> [   12.745157] mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0xc8049200
> [   12.751601] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> [   12.758110] print_req_error: I/O error, dev mmcblk1, sector 2050
> [   12.764135] Buffer I/O error on dev mmcblk1p1, logical block 0, lost s=
ync page write
> [   12.775163] EXT4-fs (mmcblk1p1): mounted filesystem without journal. O=
pts: (null)
> [   12.782746] VFS: Mounted root (ext4 filesystem) on device 179:9.
> [   12.789151] mmcblk1: response CRC error sending SET_BLOCK_COUNT comman=
d, card status 0x900
>
> Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit.thebaudeau.dev@gmail.c=
om>
> Reported-by: Wladimir J. van der Laan <laanwj@gmail.com>
> Tested-by: Wladimir J. van der Laan <laanwj@gmail.com>

Thanks, applied for fixes - adding a fixes tag as well as a stable tag!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index 85140c9af581..8b941f814472 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -687,6 +687,20 @@ static inline void esdhc_pltfm_set_clock(struct sdhc=
i_host *host,
>                 return;
>         }
>
> +       /* For i.MX53 eSDHCv3, SYSCTL.SDCLKFS may not be set to 0. */
> +       if (is_imx53_esdhc(imx_data)) {
> +               /*
> +                * According to the i.MX53 reference manual, if DLLCTRL[1=
0] can
> +                * be set, then the controller is eSDHCv3, else it is eSD=
HCv2.
> +                */
> +               val =3D readl(host->ioaddr + ESDHC_DLL_CTRL);
> +               writel(val | BIT(10), host->ioaddr + ESDHC_DLL_CTRL);
> +               temp =3D readl(host->ioaddr + ESDHC_DLL_CTRL);
> +               writel(val, host->ioaddr + ESDHC_DLL_CTRL);
> +               if (temp & BIT(10))
> +                       pre_div =3D 2;
> +       }
> +
>         temp =3D sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
>         temp &=3D ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_P=
EREN
>                 | ESDHC_CLOCK_MASK);
> --
> 2.14.1
>
