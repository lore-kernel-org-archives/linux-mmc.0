From: Bough Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: reset tuning circuit when power on
 mmc card
Date: Tue, 18 Apr 2017 08:16:42 +0000
Message-ID: <AM4PR0401MB2324A03EEAB26B094490055F90190@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <1492429538-14996-1-git-send-email-haibo.chen@nxp.com>
 <c5c8cd17-4849-6e14-0c8d-9d2825b3af32@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve1eur01on0058.outbound.protection.outlook.com ([104.47.1.58]:1379
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755747AbdDRIQp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Apr 2017 04:16:45 -0400
In-Reply-To: <c5c8cd17-4849-6e14-0c8d-9d2825b3af32@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "A.S. Dong" <aisheng.dong@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Adrian Hunter
> Sent: Tuesday, April 18, 2017 3:16 PM
> To: Bough Chen <haibo.chen@nxp.com>; ulf.hansson@linaro.org; A.S. Dong
> <aisheng.dong@nxp.com>
> Cc: linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: reset tuning circuit when powe=
r
> on mmc card
>=20
> On 17/04/17 14:45, Haibo Chen wrote:
> > USDHC tuning circuit should be reset before every time card
> > enumeration or re-enumeration.
> >
> > SD3.0 card need tuning. For SDR104 card, when system suspend in
> > standby mode, and then resume back, the IO timing is still
> > SDR104(tuned) which may result in card re-enumeration fail in low card
> > speed(400khz) for some cards. And we did meet the issue that in
> > certain probability, SDR104 card meet mmc command CRC/Timeout error
> > when send CMD2 during mmc bus resume.
> >
> > This patch reset the tuning circuit when the ios timing is
> > MMC_TIMING_LEGACY/MMC_TIMING_MMC_HS/MMC_TIMING_SD_HS,
> which means both
> > mmc_power_up() and mmc_power_off() will reset the tuning circuit.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index abad67a..8960833 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -889,6 +889,28 @@ static void esdhc_set_strobe_dll(struct sdhci_host
> *host)
> >  	}
> >  }
> >
> > +static void esdhc_reset_tuning(struct sdhci_host *host) {
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
> > +	u16 ctrl;
> > +
> > +	/* Rest the tuning circurt */
> > +	if (esdhc_is_usdhc(imx_data)) {
> > +		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
> > +			ctrl =3D readl(host->ioaddr + ESDHC_MIX_CTRL);
> > +			ctrl &=3D ~ESDHC_MIX_CTRL_SMPCLK_SEL;
>=20
> So ESDHC_MIX_CTRL_SMPCLK_SEL is bit-23 but ctrl is 16-bit?
>=20

The bit-23 of both register ESDHC_MIX_CTRL and SDHCI_ACMD12_ERR is named ES=
DHC_MIX_CTRL_SMPCLK_SEL ,  define whether tuned clock or fixed clock is use=
d to sample data.
The bit-23 of register ESDHC_MIX_CTRL works when STD_TUNING_EN is 0, which =
means use MAN tuning.
The bit-23 of register SDHCI_ACMD12_ERR works when STD_TUNING_EN is set.

> > +			ctrl &=3D ~ESDHC_MIX_CTRL_FBCLK_SEL;
> > +			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
> > +			writel(0 << 8, host->ioaddr +
> ESDHC_TUNE_CTRL_STATUS);
>=20
> 0 << 8 is still zero.

Yes, this code want to clear the bit8~bit14 of register ESDHC_TUNE_CTRL_STA=
TUS
Here is the define of these bits in RM:
[14-8] DLY_CELL_SET_PRE[6:0]  Set the number of delay cells on the feedback=
 clock between the feedback clock and CLK_PRE.

Haibo
>=20
> > +		} else if (imx_data->socdata->flags &
> ESDHC_FLAG_STD_TUNING) {
> > +			ctrl =3D readl(host->ioaddr + SDHCI_ACMD12_ERR);
> > +			ctrl &=3D ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> > +			writel(ctrl, host->ioaddr + SDHCI_ACMD12_ERR);
> > +		}
> > +	}
> > +}
> > +
> >  static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned
> > timing)  {
> >  	u32 m;
> > @@ -932,6 +954,10 @@ static void esdhc_set_uhs_signaling(struct
> sdhci_host *host, unsigned timing)
> >  		host->ops->set_clock(host, host->clock);
> >  		esdhc_set_strobe_dll(host);
> >  		break;
> > +	case MMC_TIMING_LEGACY:
> > +	default:
> > +		esdhc_reset_tuning(host);
> > +		break;
> >  	}
> >
> >  	esdhc_change_pinstate(host, timing);
> >
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in t=
he
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
