From: Eric Miao <eric.miao@linaro.org>
Subject: Re: [PATCH V4] mmc: Enable the ADMA2 on esdhc imx driver
Date: Wed, 10 Aug 2011 16:08:53 +0800
Message-ID: <CAMPhdO8QiODg6sTKe2N2b4xT8ZHXSh1DvRn57J8JfLx6+QAD4w@mail.gmail.com>
References: <1312792204-7652-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64702 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab1HJIJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Aug 2011 04:09:13 -0400
Received: by vws1 with SMTP id 1so651786vws.19
        for <linux-mmc@vger.kernel.org>; Wed, 10 Aug 2011 01:09:13 -0700 (PDT)
In-Reply-To: <1312792204-7652-1-git-send-email-richard.zhu@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, pma@sysgo.com, linux-mmc@vger.kernel.org, w.sang@pengutronix.de, kernel@pengutronix.de, avorontsov@ru.mvista.com

On Mon, Aug 8, 2011 at 4:30 PM, Richard Zhu <richard.zhu@linaro.org> wr=
ote:
> Eanble the ADMA2 mode for freescale esdhc imx driver,
> tested on MX25 3DS board, MX51 BBG board and MX53 LOCO board.
>
> This patch is only used to enable the ADMA2 for MX51/53 platforms.
> MX25/35 can't support the ADMA2 mode, set BROKEN_ADMA quirk on
> MX25/35 platforms.
>
> The ADMA mode supported or not can be distinguished by the
> bit20 of Capability Register(offset 0x40) in FSL eSDHC module.
>
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>

Tested-and-acked-by: Eric Miao <eric.miao@linaro.org>

> ---
> =C2=A0drivers/mmc/host/sdhci-esdhc-imx.c | =C2=A0 45 ++++++++++++++++=
+++++++++++++++++--
> =C2=A01 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sd=
hci-esdhc-imx.c
> index e62d33f..a966d5c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -30,6 +30,14 @@
> =C2=A0#define SDHCI_VENDOR_SPEC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00xC0
> =C2=A0#define =C2=A0SDHCI_VENDOR_SPEC_SDIO_QUIRK =C2=A00x00000002
>
> +/*
> + * There is INT DMA ERR mis-match between eSDHC and STD SDHC SPEC
> + * Bit25 is used in STD SPEC, and is reserved in fsl eSDHC design,
> + * but bit28 is used as the INT DMA ERR in fsl eSDHC design.
> + * Define this macro DMA error INT for fsl eSDHC
> + */
> +#define =C2=A0SDHCI_INT_VENDOR_SPEC_DMA_ERR 0x10000000
> +
> =C2=A0#define ESDHC_FLAG_GPIO_FOR_CD =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 <=
< 0)
> =C2=A0/*
> =C2=A0* The CMDTYPE of the CMD register (offset 0xE) should be set to
> @@ -79,6 +87,27 @@ static u32 esdhc_readl_le(struct sdhci_host *host,=
 int reg)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0val |=3D SDHCI_CARD_PRESENT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 if (unlikely(reg =3D=3D SDHCI_CAPABILITIES)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* In FSL esdhc IC=
 module, only bit20 is used to indicate the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ADMA2 capa=
bility of esdhc, but this bit is messed up on some
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* SOCs (e.x =
MX25,MX35 this bit is set, but it can't support the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ADMA2 actu=
ally). So set the BROKEN_ADMA quirk on MX25/35
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* paltforms.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val & SDHCI_CA=
N_DO_ADMA1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 val &=3D ~SDHCI_CAN_DO_ADMA1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 val |=3D SDHCI_CAN_DO_ADMA2;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (unlikely(reg =3D=3D SDHCI_INT_STATUS)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val & SDHCI_IN=
T_VENDOR_SPEC_DMA_ERR) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 val &=3D ~SDHCI_INT_VENDOR_SPEC_DMA_ERR;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 val |=3D SDHCI_INT_ADMA_ERROR;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return val;
> =C2=A0}
>
> @@ -125,6 +154,14 @@ static void esdhc_writel_le(struct sdhci_host *h=
ost, u32 val, int reg)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 if (unlikely((reg =3D=3D SDHCI_INT_ENABLE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || (reg =3D=3D SDHCI_SIGNAL_ENABLE)=
)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val & SDHCI_IN=
T_ADMA_ERROR) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 val &=3D ~SDHCI_INT_ADMA_ERROR;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 val |=3D SDHCI_INT_VENDOR_SPEC_DMA_ERR;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(val, host->ioaddr + reg);
> =C2=A0}
>
> @@ -225,9 +262,10 @@ static struct sdhci_ops sdhci_esdhc_ops =3D {
> =C2=A0};
>
> =C2=A0static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata =3D {
> - =C2=A0 =C2=A0 =C2=A0 .quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK=
_BROKEN_ADMA
> + =C2=A0 =C2=A0 =C2=A0 .quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK=
_NO_HISPD_BIT
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
> - =C2=A0 =C2=A0 =C2=A0 /* ADMA has issues. Might be fixable */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.ops =3D &sdhci_esdhc_ops,
> =C2=A0};
>
> @@ -284,7 +322,8 @@ static int __devinit sdhci_esdhc_imx_probe(struct=
 platform_device *pdev)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu_is_mx25() || cpu_is_mx35()) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Fix errata =
ENGcm07207 present on i.MX25 and i.MX35 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->quirks |=3D =
SDHCI_QUIRK_NO_MULTIBLOCK;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->quirks |=3D =
SDHCI_QUIRK_NO_MULTIBLOCK
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | SDHCI_QUIRK_BROKEN_ADMA;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* write_prote=
ct can't be routed to controller, use gpio */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhci_esdhc_op=
s.get_ro =3D esdhc_pltfm_get_ro;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> --
> 1.7.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
