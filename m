From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v3 3/3] mmc: sdhci-cadence: Update PHY delay configuration
Date: Sat, 18 Mar 2017 02:34:56 +0900
Message-ID: <CAK7LNATM95AFiC0n5hO+Pv5T5w55kKh0bpVynkSTwtLLy6MMMg@mail.gmail.com>
References: <1489754302-10996-1-git-send-email-piotrs@cadence.com> <1489754503-16559-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489754503-16559-1-git-send-email-piotrs@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Piotr,



Sorry, one more nit.


2017-03-17 21:41 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:

> +
> +static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
> +       { "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
> +       { "cdns,phy-input-delay-sd-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
> +       { "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
> +       { "cdns,phy-input-delay-sd-uhs-sdr25", SDHCI_CDNS_PHY_DLY_UHS_SDR25, },
> +       { "cdns,phy-input-delay-sd-uhs-sdr50", SDHCI_CDNS_PHY_DLY_UHS_SDR50, },
> +       { "cdns,phy-input-delay-sd-uhs-ddr50", SDHCI_CDNS_PHY_DLY_UHS_DDR50, },
> +       { "cdns,phy-input-delay-mmc-highspeed", SDHCI_CDNS_PHY_DLY_EMMC_SDR, },
> +       { "cdns,phy-input-delay-mmc-ddr", SDHCI_CDNS_PHY_DLY_EMMC_DDR, },
> +       { "cdns,phy-dll-delay-sdclk", SDHCI_CDNS_PHY_DLY_SDCLK, },
> +       { "cdns,phy-dll-delay-sdclk-hsmmc", SDHCI_CDNS_PHY_DLY_HSMMC, },
> +       { "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
> +};
> +
> +


Only one blank line, please.




-- 
Best Regards
Masahiro Yamada
