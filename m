From: Piotr Sroka <piotrs@cadence.com>
Subject: (unknown)
Date: Tue, 21 Mar 2017 06:58:21 +0000
Message-ID: <201703210658.v2L6wLPU009645@lvloginb.cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:44688 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756144AbdCUG6i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Mar 2017 02:58:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Piotr <piotrs@cadence.com>

Subject: RE: [v4 3/3] mmc: sdhci-cadence: Update PHY delay configuration
In-reply-to: <CAK7LNARTMF2F1_3QWqF87qV6FzeYHguWbRC5DEDnvYV1M-=9TQ@mail.gmail.com>
References: <1490008372-16372-1-git-send-email-piotrs@cadence.com> <1490008855-27135-1-git-send-email-piotrs@cadence.com> <CAK7LNARTMF2F1_3QWqF87qV6FzeYHguWbRC5DEDnvYV1M-=9TQ@mail.gmail.com>


Hi Masahiro 

2017-03-21 02:46 AM Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Piotr,
> 
> 
> 2017-03-20 20:20 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> > DTS properties are used instead of fixed data
> > because PHY settings can be different for different chips/boards.
> >
> > Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> 
> 
> I found this version is a problem for me.
> 
> 
> > +
> > +static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
> > +       { "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
> > +       { "cdns,phy-input-delay-sd-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
> > +       { "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
> > +       { "cdns,phy-input-delay-sd-uhs-sdr25", SDHCI_CDNS_PHY_DLY_UHS_SDR25, },
> > +       { "cdns,phy-input-delay-sd-uhs-sdr50", SDHCI_CDNS_PHY_DLY_UHS_SDR50, },
> > +       { "cdns,phy-input-delay-sd-uhs-ddr50", SDHCI_CDNS_PHY_DLY_UHS_DDR50, },
> > +       { "cdns,phy-input-delay-mmc-highspeed", SDHCI_CDNS_PHY_DLY_EMMC_SDR, },
> > +       { "cdns,phy-input-delay-mmc-ddr", SDHCI_CDNS_PHY_DLY_EMMC_DDR, },
> > +       { "cdns,phy-dll-delay-sdclk", SDHCI_CDNS_PHY_DLY_SDCLK, },
> > +       { "cdns,phy-dll-delay-sdclk-hsmmc", SDHCI_CDNS_PHY_DLY_HSMMC, },
> > +       { "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
> > +};
> > +
> 
> 
> I see mmc-legacy property in v1,
> but it is missing now.
> 
> 
> >  static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> >                                     u8 addr, u8 data)
> >  {
> > @@ -90,13 +113,26 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> >         return 0;
> >  }
> >
> > -static void sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> > +static int sdhci_cdns_phy_init(struct device_node *np,
> > +                              struct sdhci_cdns_priv *priv)
> >  {
> > -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_HS, 4);
> > -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_DEFAULT, 4);
> > -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_LEGACY, 9);
> > -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_SDR, 2);
> > -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_DDR, 3);
> 
> 
> I need to set SDHCI_CDNS_PHY_DLY_EMMC_LEGACY to 9 for my SoC.
> 
> Maybe, do we need a DT property for this, too?
> 
I can add it but could you check if you realy need it? There is no selection MMC legacy mode
in this driver. 


Best Regards
Piotr Sroka
