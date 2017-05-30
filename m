From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/5] mmc: sdhci-esdhc-imx: Fix some English mistakes
 and typos
Date: Tue, 30 May 2017 11:55:06 +0200
Message-ID: <CAPDyKFqRCFvXNLAoXDrZbx8VGfHhTDG0tb558t3aZbLH7iyc-g@mail.gmail.com>
References: <1496135651-90007-1-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33791 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdE3JzS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 May 2017 05:55:18 -0400
Received: by mail-qk0-f178.google.com with SMTP id y201so64291786qka.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 May 2017 02:55:18 -0700 (PDT)
In-Reply-To: <1496135651-90007-1-git-send-email-benoit@wsystem.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Wolfram Sang <wsa@the-dreams.de>

On 30 May 2017 at 11:14, Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com> w=
rote:
> Fix various English mistakes and typos in comments and in printed
> strings.
>
> Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

I have dropped the earlier series and applied this one instead - for
next, thanks!

Kind regards
Uffe

> ---
> Changes v1 -> v2: new patch.
> Changes v2 -> v3:
>  - Two more typos fixed (suggested by Adrian Hunter).
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 49 +++++++++++++++++++-------------=
------
>  1 file changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index b5c7241..4dbc5c0 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -95,7 +95,7 @@
>  #define ESDHC_CTRL_BUSWIDTH_MASK       (0x3 << 1)
>
>  /*
> - * There is an INT DMA ERR mis-match between eSDHC and STD SDHC SPEC:
> + * There is an INT DMA ERR mismatch between eSDHC and STD SDHC SPEC:
>   * Bit25 is used in STD SPEC, and is reserved in fsl eSDHC design,
>   * but bit28 is used as the INT DMA ERR in fsl eSDHC design.
>   * Define this macro DMA error INT for fsl eSDHC
> @@ -110,12 +110,12 @@
>   * In exact block transfer, the controller doesn't complete the
>   * operations automatically as required at the end of the
>   * transfer and remains on hold if the abort command is not sent.
> - * As a result, the TC flag is not asserted and SW  received timeout
> - * exeception. Bit1 of Vendor Spec registor is used to fix it.
> + * As a result, the TC flag is not asserted and SW received timeout
> + * exception. Bit1 of Vendor Spec register is used to fix it.
>   */
>  #define ESDHC_FLAG_MULTIBLK_NO_INT     BIT(1)
>  /*
> - * The flag enables the workaround for ESDHC errata ENGcm07207 which
> + * The flag enables the workaround for ESDHC erratum ENGcm07207 which
>   * affects i.MX25 and i.MX35.
>   */
>  #define ESDHC_FLAG_ENGCM07207          BIT(2)
> @@ -131,7 +131,7 @@
>  /* The IP has SDHCI_CAPABILITIES_1 register */
>  #define ESDHC_FLAG_HAVE_CAP1           BIT(6)
>  /*
> - * The IP has errata ERR004536
> + * The IP has erratum ERR004536
>   * uSDHC: ADMA Length Mismatch Error occurs if the AHB read access is sl=
ow,
>   * when reading data from the card
>   */
> @@ -141,7 +141,7 @@
>  /* The IP supports HS400 mode */
>  #define ESDHC_FLAG_HS400               BIT(9)
>
> -/* A higher clock ferquency than this rate requires strobell dll control=
 */
> +/* A clock frequency higher than this rate requires strobe dll control *=
/
>  #define ESDHC_STROBE_DLL_CLK_FREQ      100000000
>
>  struct esdhc_soc_data {
> @@ -197,7 +197,7 @@ struct pltfm_imx_data {
>         struct clk *clk_ahb;
>         struct clk *clk_per;
>         enum {
> -               NO_CMD_PENDING,      /* no multiblock command pending*/
> +               NO_CMD_PENDING,      /* no multiblock command pending */
>                 MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process *=
/
>                 WAIT_FOR_INT,        /* sent CMD12, waiting for response =
INT */
>         } multiblock_status;
> @@ -286,7 +286,7 @@ static u32 esdhc_readl_le(struct sdhci_host *host, in=
t reg)
>                  * ADMA2 capability of esdhc, but this bit is messed up o=
n
>                  * some SOCs (e.g. on MX25, MX35 this bit is set, but the=
y
>                  * don't actually support ADMA2). So set the BROKEN_ADMA
> -                * uirk on MX25/35 platforms.
> +                * quirk on MX25/35 platforms.
>                  */
>
>                 if (val & SDHCI_CAN_DO_ADMA1) {
> @@ -351,7 +351,7 @@ static void esdhc_writel_le(struct sdhci_host *host, =
u32 val, int reg)
>                 if ((val & SDHCI_INT_CARD_INT) && !esdhc_is_usdhc(imx_dat=
a)) {
>                         /*
>                          * Clear and then set D3CD bit to avoid missing t=
he
> -                        * card interrupt.  This is a eSDHC controller pr=
oblem
> +                        * card interrupt. This is an eSDHC controller pr=
oblem
>                          * so we need to apply the following workaround: =
clear
>                          * and set D3CD bit will make eSDHC re-sample the=
 card
>                          * interrupt. In case a card interrupt was lost,
> @@ -604,7 +604,7 @@ static void esdhc_writeb_le(struct sdhci_host *host, =
u8 val, int reg)
>                  * Do not touch buswidth bits here. This is done in
>                  * esdhc_pltfm_bus_width.
>                  * Do not touch the D3CD bit either which is used for the
> -                * SDIO interrupt errata workaround.
> +                * SDIO interrupt erratum workaround.
>                  */
>                 mask =3D 0xffff & ~(ESDHC_CTRL_BUSWIDTH_MASK | ESDHC_CTRL=
_D3CD);
>
> @@ -763,7 +763,7 @@ static void esdhc_prepare_tuning(struct sdhci_host *h=
ost, u32 val)
>         writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
>         writel(val << 8, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>         dev_dbg(mmc_dev(host->mmc),
> -               "tunning with delay 0x%x ESDHC_TUNE_CTRL_STATUS 0x%x\n",
> +               "tuning with delay 0x%x ESDHC_TUNE_CTRL_STATUS 0x%x\n",
>                         val, readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS)=
);
>  }
>
> @@ -807,7 +807,7 @@ static int esdhc_executing_tuning(struct sdhci_host *=
host, u32 opcode)
>         ret =3D mmc_send_tuning(host->mmc, opcode, NULL);
>         esdhc_post_tuning(host);
>
> -       dev_dbg(mmc_dev(host->mmc), "tunning %s at 0x%x ret %d\n",
> +       dev_dbg(mmc_dev(host->mmc), "tuning %s at 0x%x ret %d\n",
>                 ret ? "failed" : "passed", avg, ret);
>
>         return ret;
> @@ -847,15 +847,15 @@ static int esdhc_change_pinstate(struct sdhci_host =
*host,
>  }
>
>  /*
> - * For HS400 eMMC, there is a data_strobe line, this signal is generated
> + * For HS400 eMMC, there is a data_strobe line. This signal is generated
>   * by the device and used for data output and CRC status response output
>   * in HS400 mode. The frequency of this signal follows the frequency of
> - * CLK generated by host. Host receive the data which is aligned to the
> + * CLK generated by host. The host receives the data which is aligned to=
 the
>   * edge of data_strobe line. Due to the time delay between CLK line and
>   * data_strobe line, if the delay time is larger than one clock cycle,
> - * then CLK and data_strobe line will misaligned, read error shows up.
> + * then CLK and data_strobe line will be misaligned, read error shows up=
.
>   * So when the CLK is higher than 100MHz, each clock cycle is short enou=
gh,
> - * host should config the delay target.
> + * host should configure the delay target.
>   */
>  static void esdhc_set_strobe_dll(struct sdhci_host *host)
>  {
> @@ -895,7 +895,7 @@ static void esdhc_reset_tuning(struct sdhci_host *hos=
t)
>         struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
>         u32 ctrl;
>
> -       /* Rest the tuning circurt */
> +       /* Reset the tuning circuit */
>         if (esdhc_is_usdhc(imx_data)) {
>                 if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
>                         ctrl =3D readl(host->ioaddr + ESDHC_MIX_CTRL);
> @@ -976,7 +976,7 @@ static unsigned int esdhc_get_max_timeout_count(struc=
t sdhci_host *host)
>         struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>         struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
>
> -       /* Doc Errata: the uSDHC actual maximum timeout count is 1 << 29 =
*/
> +       /* Doc Erratum: the uSDHC actual maximum timeout count is 1 << 29=
 */
>         return esdhc_is_usdhc(imx_data) ? 1 << 29 : 1 << 27;
>  }
>
> @@ -1032,10 +1032,10 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_h=
ost *host)
>
>                 /*
>                  * ROM code will change the bit burst_length_enable setti=
ng
> -                * to zero if this usdhc is choosed to boot system. Chang=
e
> +                * to zero if this usdhc is chosen to boot system. Change
>                  * it back here, otherwise it will impact the performance=
 a
>                  * lot. This bit is used to enable/disable the burst leng=
th
> -                * for the external AHB2AXI bridge, it's usefully especia=
lly
> +                * for the external AHB2AXI bridge. It's useful especiall=
y
>                  * for INCR transfer because without burst length indicat=
or,
>                  * the AHB2AXI bridge does not know the burst length in
>                  * advance. And without burst length indicator, AHB INCR
> @@ -1045,7 +1045,7 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_hos=
t *host)
>                         | ESDHC_BURST_LEN_EN_INCR,
>                         host->ioaddr + SDHCI_HOST_CONTROL);
>                 /*
> -               * errata ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6D=
L
> +               * erratum ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6=
DL
>                 * TO1.1, it's harmless for MX6SL
>                 */
>                 writel(readl(host->ioaddr + 0x6c) | BIT(7),
> @@ -1104,7 +1104,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pd=
ev,
>
>         mmc_of_parse_voltage(np, &host->ocr_mask);
>
> -       /* sdr50 and sdr104 needs work on 1.8v signal voltage */
> +       /* sdr50 and sdr104 need work on 1.8v signal voltage */
>         if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data) &&
>             !IS_ERR(imx_data->pins_default)) {
>                 imx_data->pins_100mhz =3D pinctrl_lookup_state(imx_data->=
pinctrl,
> @@ -1116,7 +1116,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pd=
ev,
>                         dev_warn(mmc_dev(host->mmc),
>                                 "could not get ultra high speed state, wo=
rk on normal mode\n");
>                         /*
> -                        * fall back to not support uhs by specify no 1.8=
v quirk
> +                        * fall back to not supporting uhs by specifying =
no
> +                        * 1.8v quirk
>                          */
>                         host->quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;
>                 }
> @@ -1272,7 +1273,7 @@ static int sdhci_esdhc_imx_probe(struct platform_de=
vice *pdev)
>                 dev_warn(mmc_dev(host->mmc), "could not get default state=
\n");
>
>         if (imx_data->socdata->flags & ESDHC_FLAG_ENGCM07207)
> -               /* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
> +               /* Fix erratum ENGcm07207 present on i.MX25 and i.MX35 */
>                 host->quirks |=3D SDHCI_QUIRK_NO_MULTIBLOCK
>                         | SDHCI_QUIRK_BROKEN_ADMA;
>
> --
> 2.7.4
>
