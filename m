From: Haibo Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: reset tuning circurt when insert sd
 card
Date: Fri, 26 Aug 2016 10:54:41 +0000
Message-ID: <AM4PR0401MB23241FE0505D4C074C1EEF4B90EC0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <1471255318-10933-1-git-send-email-haibo.chen@nxp.com>
 <20160816090440.GC9211@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0047.outbound.protection.outlook.com ([104.47.2.47]:47968
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751646AbcHZN1i (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 26 Aug 2016 09:27:38 -0400
In-Reply-To: <20160816090440.GC9211@shlinux2>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Aisheng Dong <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Aisheng,

> -----Original Message-----
> From: Dong Aisheng [mailto:dongas86@gmail.com]
> Sent: Tuesday, August 16, 2016 5:05 PM
> To: Haibo Chen <haibo.chen@nxp.com>
> Cc: adrian.hunter@intel.com; ulf.hansson@linaro.org; Aisheng Dong
> <aisheng.dong@nxp.com>; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: reset tuning circurt when inse=
rt sd
> card
>=20
> Hi Haibo,
>=20
> On Mon, Aug 15, 2016 at 06:01:58PM +0800, Haibo Chen wrote:
> > Current driver do not clear the tuning related register after plug out
> > SD3.0 card. This will impact the timing and let other
> > SD3.0 card inserted later meet CRC error.
> >
> > e.g., after plug out a SDR104 card, and then plug in a DDR50 card, CRC
> > error shows up:
> >
> > mmc2: new ultra high speed DDR50 SDHC card at address aaaa
> > mmcblk2: mmc2:aaaa SE08G 7.40 GiB
> > mmcblk2: error -84 transferring data, sector 0, nr 8, cmd response
> > 0x900, card status 0xb00
> > mmc2: tried to reset card
> >  mmcblk2: p1 p2
> >
> > Logictally, we should reset USDHC include tuning circurt first when we
> > plug in a sd/mmc/sdio card.
>=20
> I'm thinking a bit more about the issue.
>=20
> Can you check if the voltage setting will clear tuning bits during
> mmc_power_up()?
> Because the esdhc_writew_le(SDHCI_HOST_CONTROL2) seems will clear it if
> no tuning bits set for a normal card.
>=20
> And did you reproduce the issue with latest kernel?
> If yes, please paste log and register dump which shows the issue is cause=
d by
> tuning bits.

For the lastest kernel, DDR50 card will also execute tuning, so for DDR50 c=
ard, now no this issue. And for High-speed SD2.0 card, I tried several card=
s, they can work without this patch. But I dump the register, the tuning re=
lated bit set wrongly.

I test on i.MX6UL-14x14-EVK board, first, I insert one SDR104 card, then  p=
lug out this card, and dump the register:
Reading 0x34 count starting at address 0x02190000

0x02190000:  9CE9E200 00010200 000020A0 113A0000
0x02190010:  00000900 00F15D7F 325B5900 00000900
0x02190020:  00000000 FF888008 08800022 008F000F
0x02190030:  00000000 00000000 00000000 00800000
0x02190040:  07F3B407 10401040 03000013 00000000
0x02190050:  00000000 00000000 9F046208 00000000
0x02190060:  00000000 00000200 16220000 0800FF80
0x02190070:  00000000 00000000 00000000 00000000
0x02190080:  00000000 00000000 00000000 00000000
0x02190090:  00000000 00000000 00000000 00000000
0x021900A0:  00000000 00000000 00000000 00000000
0x021900B0:  00000000 00000000 00000000 00000000
0x021900C0:  3000790B 00000000 00001006 01212801

For SDR104 card, the SMP_CLK_SEL( bit23 of 0x3c) is set, FBCLK_SEL(bit25 of=
 0x48) is set, and the register TUNE_CTRL_STATUS(0x68) is 0x16220000.


Then, I insert a High-speed SD2.0 card, it can work well, and I dump the re=
gister:
Reading 0x34 count starting at address 0x02190000

0x02190000:  9D0FF000 00010200 0000520F 113A0000
0x02190010:  00000900 001D8A7F 325B5900 00400E00
0x02190020:  00000000 FF888008 08800022 008F007F
0x02190030:  00000000 00000000 00000000 00800000
0x02190040:  07F3B407 10401040 03000013 00000000
0x02190050:  00000000 00000000 9F046208 00000000
0x02190060:  00000000 00000200 16220000 0800FF80
0x02190070:  00000000 00000000 00000000 00000000
0x02190080:  00000000 00000000 00000000 00000000
0x02190090:  00000000 00000000 00000000 00000000
0x021900A0:  00000000 00000000 00000000 00000000
0x021900B0:  00000000 00000000 00000000 00000000
0x021900C0:  30007909 00000000 00001006 01212801

For SD2.0 card, we do not execute tuning, but here, we can see SMP_CLK_SEL(=
 bit23 of 0x3c) and FBCLK_SEL(bit25 of 0x48) is still set. TUNE_CTRL_STATUS=
(0x68) is 0x16220000.  This is not right.

Besides, now in this driver, we use TUNING_MOD_3, and use auto retuning, tu=
ning will not execute every runtime resume. But if we change to use TUNING_=
MOD_1, then when usdhc runtime resume, tuning will be execute.  In this cas=
e, when plug out a SD3.0 card, it will call runtime resume, then tuning exe=
cute without a sd card, usdhc tuning circuit logic is wrong. At this time, =
if we insert a DDR50 card, and DDR50 card do not execute tuning(just like b=
efore), the issue describe in this path will happen, CRC error will shows u=
p, because the tuning related bit is not clear and wrongly setted.

Now, DDR50 card will do tuning, and for i.MX usdhc, we only use TUNING_MOD_=
3, so the issue described in this patch is gone. But potential risk still e=
xist in this driver. This patch still can avoid this risk.
So I will change the commit message and send V2 patch.=20

Best Regards
Haibo

>=20
> Regards
> Dong Aisheng
>=20
> >
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index ea7d086..2783a4b 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -924,6 +924,30 @@ static void esdhc_reset(struct sdhci_host *host, u=
8
> mask)
> >  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);  }
> >
> > +static void esdhc_hw_reset_for_init(struct sdhci_host *host) {
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
> > +	u16 ctrl;
> > +
> > +	sdhci_reset(host, SDHCI_RESET_ALL);
> > +
> > +	/* Rest the tuning circurt */
> > +	if (esdhc_is_usdhc(imx_data)) {
> > +		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
> > +			ctrl =3D readl(host->ioaddr + ESDHC_MIX_CTRL);
> > +			ctrl &=3D ~(ESDHC_MIX_CTRL_SMPCLK_SEL |
> > +					ESDHC_MIX_CTRL_FBCLK_SEL);
> > +			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
> > +			writel(0 << 8, host->ioaddr +
> ESDHC_TUNE_CTRL_STATUS);
> > +		} else if (imx_data->socdata->flags &
> ESDHC_FLAG_STD_TUNING) {
> > +			ctrl =3D readl(host->ioaddr + SDHCI_ACMD12_ERR);
> > +			ctrl &=3D ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> > +			writel(ctrl, host->ioaddr + SDHCI_ACMD12_ERR);
> > +		}
> > +	}
> > +}
> > +
> >  static unsigned int esdhc_get_max_timeout_count(struct sdhci_host
> > *host)  {
> >  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host); @@ -958,6
> > +982,7 @@ static struct sdhci_ops sdhci_esdhc_ops =3D {
> >  	.set_bus_width =3D esdhc_pltfm_set_bus_width,
> >  	.set_uhs_signaling =3D esdhc_set_uhs_signaling,
> >  	.reset =3D esdhc_reset,
> > +	.hw_reset =3D esdhc_hw_reset_for_init,
> >  };
> >
> >  static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata =3D { @@
> > -1223,7 +1248,7 @@ static int sdhci_esdhc_imx_probe(struct
> > platform_device *pdev)
> >
> >  	if (esdhc_is_usdhc(imx_data)) {
> >  		host->quirks2 |=3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> > -		host->mmc->caps |=3D MMC_CAP_1_8V_DDR;
> > +		host->mmc->caps |=3D MMC_CAP_1_8V_DDR |
> MMC_CAP_HW_RESET;
> >  		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
> >  			host->quirks2 |=3D SDHCI_QUIRK2_BROKEN_HS200;
> >
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
