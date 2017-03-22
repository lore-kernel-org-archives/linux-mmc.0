From: Piotr Sroka <piotrs@cadence.com>
Subject: RE: [v4 3/3] mmc: sdhci-cadence: Update PHY delay configuration
Date: Wed, 22 Mar 2017 07:08:24 +0000
Message-ID: <201703220708.v2M78ObZ029482@lvloginb.cadence.com>
References: <1490008372-16372-1-git-send-email-piotrs@cadence.com>
 <1490008855-27135-1-git-send-email-piotrs@cadence.com>
 <CAK7LNARTMF2F1_3QWqF87qV6FzeYHguWbRC5DEDnvYV1M-=9TQ@mail.gmail.com>
 <201703210701.v2L71Mct013139@lvloginb.cadence.com>
 <CAK7LNAQSUn7t4G=DrXwJVZtUFPtOoH=ophE7d8J-_yp93tb6_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from keymaster.Cadence.COM ([158.140.2.26]:41479 "EHLO
        mx-sanjose5.cadence.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932959AbdCVHJW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 03:09:22 -0400
In-Reply-To: <CAK7LNAQSUn7t4G=DrXwJVZtUFPtOoH=ophE7d8J-_yp93tb6_g@mail.gmail.com> 
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Piotr <piotrs@cadence.com>

Hi Masahiro

2017-03-21 08:3 AM  Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Piotr,
> 
> 2017-03-21 16:01 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> >
> > Hi Masahiro
> >
> > 2017-03-21 02:46 AM Masahiro Yamada <yamada.masahiro@socionext.com>:
> >> Hi Piotr,
> >>
> >>
> >> 2017-03-20 20:20 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> >> > DTS properties are used instead of fixed data
> >> > because PHY settings can be different for different chips/boards.
> >> >
> >> > Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> >>
> >>
> >> I found this version is a problem for me.
> >>
> >>
> >> > +
> >> > +static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
> >> > +       { "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
> >> > +       { "cdns,phy-input-delay-sd-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
> >> > +       { "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
> >> > +       { "cdns,phy-input-delay-sd-uhs-sdr25", SDHCI_CDNS_PHY_DLY_UHS_SDR25, },
> >> > +       { "cdns,phy-input-delay-sd-uhs-sdr50", SDHCI_CDNS_PHY_DLY_UHS_SDR50, },
> >> > +       { "cdns,phy-input-delay-sd-uhs-ddr50", SDHCI_CDNS_PHY_DLY_UHS_DDR50, },
> >> > +       { "cdns,phy-input-delay-mmc-highspeed", SDHCI_CDNS_PHY_DLY_EMMC_SDR, },
> >> > +       { "cdns,phy-input-delay-mmc-ddr", SDHCI_CDNS_PHY_DLY_EMMC_DDR, },
> >> > +       { "cdns,phy-dll-delay-sdclk", SDHCI_CDNS_PHY_DLY_SDCLK, },
> >> > +       { "cdns,phy-dll-delay-sdclk-hsmmc", SDHCI_CDNS_PHY_DLY_HSMMC, },
> >> > +       { "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
> >> > +};
> >> > +
> >>
> >>
> >> I see mmc-legacy property in v1,
> >> but it is missing now.
> >>
> >>
> >> >  static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> >> >                                     u8 addr, u8 data)
> >> >  {
> >> > @@ -90,13 +113,26 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> >> >         return 0;
> >> >  }
> >> >
> >> > -static void sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> >> > +static int sdhci_cdns_phy_init(struct device_node *np,
> >> > +                              struct sdhci_cdns_priv *priv)
> >> >  {
> >> > -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_HS, 4);
> >> > -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_DEFAULT, 4);
> >> > -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_LEGACY, 9);
> >> > -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_SDR, 2);
> >> > -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_DDR, 3);
> >>
> >>
> >> I need to set SDHCI_CDNS_PHY_DLY_EMMC_LEGACY to 9 for my SoC.
> >>
> >> Maybe, do we need a DT property for this, too?
> >>
> > I can add it but could you check if you realy need it? There is no selection MMC legacy mode
> > in this driver.
> >
> 
> Ah, you are right.
> 
> For Linux, SD-Legacy and MMC-Legacy share the same timing flag.
> The legacy mode is covered by SDHCI_CDNS_PHY_DLY_SD_DEFAULT,
> so we need not to set SDHCI_CDNS_PHY_DLY_EMMC_LEGACY.
> 
> So, I have no problem with patch.
> 
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> 
> 
> 
> From here, just my minor comments.
> The binding should not be too Linux-oriented.
> Device Tree is hardware description language, and project-neutral from
> its concept.
> I wonder if there is a project that handles SD-Legacy and MMC-Legacy separately.
> I am not sure about this, and I do not have a strong opinion, either.
> 
> I leave this to you  (and other developers).
> 

Thanks for your comments.

Because patch adding HS400 enhanced strobe support was applied 
for next branch I needed to create v5. BTW I added one extra patch modifing
probe function as you suggested.
I also modify binding to be consistent with linux MMC timing names.
The driver does not use MMC legacy at all so I think there is no need 
to distinguish between SD Legacy and MMC Legacy. So there are no contraindications
for being consistent with Linux.


Best Regards
Piotr Sroka
