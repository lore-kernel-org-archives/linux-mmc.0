From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 3/3] mmc: tegra: SDMMC pads auto-calibration
Date: Tue, 22 Jan 2019 08:47:47 +0100
Message-ID: <CAPDyKFphCv6J-rE1HCqhmDyc1TvvmQ3qeD+bshd1pSYOt7h3PQ@mail.gmail.com>
References: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com> <1547160363-25323-3-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547160363-25323-3-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mikko Perttunen <mperttunen@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, anrao@nvidia.com, DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 10 Jan 2019 at 23:46, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Program initial drive code offsets which will be used by auto
> calibration process.
>
> Program fixed drive strengths for SDMMC pads in pad control
> register when auto cal timeouts.
> Fixed settings are based on Pre-SI analysis of the pad design.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c | 160 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 119 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index e6ace31e2a41..7d681a8fa4ba 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -75,6 +75,7 @@
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK   0x0000000f
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL    0x7
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD  BIT(31)
> +#define SDHCI_COMP_PADCTRL_DRVUPDN_OFFSET_MASK         0x07FFF000
>
>  #define SDHCI_TEGRA_AUTO_CAL_STATUS                    0x1ec
>  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE                    BIT(31)
> @@ -121,6 +122,8 @@ struct sdhci_tegra {
>         struct pinctrl *pinctrl_sdmmc;
>         struct pinctrl_state *pinctrl_state_3v3;
>         struct pinctrl_state *pinctrl_state_1v8;
> +       struct pinctrl_state *pinctrl_state_3v3_drv;
> +       struct pinctrl_state *pinctrl_state_1v8_drv;
>
>         struct sdhci_tegra_autocal_offsets autocal_offsets;
>         ktime_t last_calib;
> @@ -411,6 +414,76 @@ static void tegra_sdhci_set_pad_autocal_offset(struct sdhci_host *host,
>         sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
>  }
>
> +static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage,
> +                                  bool state_drvupdn)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +       struct sdhci_tegra_autocal_offsets *offsets =
> +                                               &tegra_host->autocal_offsets;
> +       struct pinctrl_state *pinctrl_drvupdn = NULL;
> +       int ret = 0;
> +       u8 drvup = 0, drvdn = 0;
> +       u32 reg;
> +
> +       if (!state_drvupdn) {
> +               /* PADS Drive Strength */
> +               if (voltage == MMC_SIGNAL_VOLTAGE_180) {
> +                       if (tegra_host->pinctrl_state_1v8_drv) {
> +                               pinctrl_drvupdn =
> +                                       tegra_host->pinctrl_state_1v8_drv;
> +                       } else {
> +                               drvup = offsets->pull_up_1v8_timeout;
> +                               drvdn = offsets->pull_down_1v8_timeout;
> +                       }
> +               } else {
> +                       if (tegra_host->pinctrl_state_3v3_drv) {
> +                               pinctrl_drvupdn =
> +                                       tegra_host->pinctrl_state_3v3_drv;
> +                       } else {
> +                               drvup = offsets->pull_up_3v3_timeout;
> +                               drvdn = offsets->pull_down_3v3_timeout;
> +                       }
> +               }
> +
> +               if (pinctrl_drvupdn != NULL) {
> +                       ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +                                                       pinctrl_drvupdn);
> +                       if (ret < 0)
> +                               dev_err(mmc_dev(host->mmc),
> +                                       "failed pads drvupdn, ret: %d\n", ret);
> +               } else if ((drvup) || (drvdn)) {
> +                       reg = sdhci_readl(host,
> +                                       SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +                       reg &= ~SDHCI_COMP_PADCTRL_DRVUPDN_OFFSET_MASK;
> +                       reg |= (drvup << 20) | (drvdn << 12);
> +                       sdhci_writel(host, reg,
> +                                       SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +               }
> +
> +       } else {
> +               /* Dual Voltage PADS Voltage selection */
> +               if (!tegra_host->pad_control_available)
> +                       return 0;
> +
> +               if (voltage == MMC_SIGNAL_VOLTAGE_180) {
> +                       ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +                                               tegra_host->pinctrl_state_1v8);
> +                       if (ret < 0)
> +                               dev_err(mmc_dev(host->mmc),
> +                                       "setting 1.8V failed, ret: %d\n", ret);
> +               } else {
> +                       ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +                                               tegra_host->pinctrl_state_3v3);
> +                       if (ret < 0)
> +                               dev_err(mmc_dev(host->mmc),
> +                                       "setting 3.3V failed, ret: %d\n", ret);
> +               }
> +       }
> +
> +       return ret;
> +}
> +
>  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -437,6 +510,7 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>                         pdpu = offsets.pull_down_3v3 << 8 | offsets.pull_up_3v3;
>         }
>
> +       /* Set initial offset before auto-calibration */
>         tegra_sdhci_set_pad_autocal_offset(host, pdpu);
>
>         card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
> @@ -460,19 +534,15 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>         if (ret) {
>                 dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>
> -               if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
> -                       pdpu = offsets.pull_down_1v8_timeout << 8 |
> -                              offsets.pull_up_1v8_timeout;
> -               else
> -                       pdpu = offsets.pull_down_3v3_timeout << 8 |
> -                              offsets.pull_up_3v3_timeout;
> -
> -               /* Disable automatic calibration and use fixed offsets */
> +               /* Disable automatic cal and use fixed Drive Strengths */
>                 reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
>                 reg &= ~SDHCI_AUTO_CAL_ENABLE;
>                 sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
>
> -               tegra_sdhci_set_pad_autocal_offset(host, pdpu);
> +               ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage, false);
> +               if (ret < 0)
> +                       dev_err(mmc_dev(host->mmc),
> +                               "Setting drive strengths failed: %d\n", ret);
>         }
>  }
>
> @@ -511,26 +581,46 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-3v3-timeout",
>                         &autocal->pull_up_3v3_timeout);
> -       if (err)
> +       if (err) {
> +               if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
> +                       (tegra_host->pinctrl_state_3v3_drv == NULL))
> +                       pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n",
> +                               mmc_hostname(host->mmc));
>                 autocal->pull_up_3v3_timeout = 0;
> +       }
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-down-offset-3v3-timeout",
>                         &autocal->pull_down_3v3_timeout);
> -       if (err)
> +       if (err) {
> +               if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
> +                       (tegra_host->pinctrl_state_3v3_drv == NULL))
> +                       pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n",
> +                               mmc_hostname(host->mmc));
>                 autocal->pull_down_3v3_timeout = 0;
> +       }
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-1v8-timeout",
>                         &autocal->pull_up_1v8_timeout);
> -       if (err)
> +       if (err) {
> +               if (!IS_ERR(tegra_host->pinctrl_state_1v8) &&
> +                       (tegra_host->pinctrl_state_1v8_drv == NULL))
> +                       pr_warn("%s: Missing autocal timeout 1v8-pad drvs\n",
> +                               mmc_hostname(host->mmc));
>                 autocal->pull_up_1v8_timeout = 0;
> +       }
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-down-offset-1v8-timeout",
>                         &autocal->pull_down_1v8_timeout);
> -       if (err)
> +       if (err) {
> +               if (!IS_ERR(tegra_host->pinctrl_state_1v8) &&
> +                       (tegra_host->pinctrl_state_1v8_drv == NULL))
> +                       pr_warn("%s: Missing autocal timeout 1v8-pad drvs\n",
> +                               mmc_hostname(host->mmc));
>                 autocal->pull_down_1v8_timeout = 0;
> +       }
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-sdr104",
> @@ -743,32 +833,6 @@ static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>         return mmc_send_tuning(host->mmc, opcode, NULL);
>  }
>
> -static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage)
> -{
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> -       int ret;
> -
> -       if (!tegra_host->pad_control_available)
> -               return 0;
> -
> -       if (voltage == MMC_SIGNAL_VOLTAGE_180) {
> -               ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> -                                          tegra_host->pinctrl_state_1v8);
> -               if (ret < 0)
> -                       dev_err(mmc_dev(host->mmc),
> -                               "setting 1.8V failed, ret: %d\n", ret);
> -       } else {
> -               ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> -                                          tegra_host->pinctrl_state_3v3);
> -               if (ret < 0)
> -                       dev_err(mmc_dev(host->mmc),
> -                               "setting 3.3V failed, ret: %d\n", ret);
> -       }
> -
> -       return ret;
> -}
> -
>  static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
>                                                    struct mmc_ios *ios)
>  {
> @@ -778,7 +842,7 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
>         int ret = 0;
>
>         if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> -               ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> +               ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage, true);
>                 if (ret < 0)
>                         return ret;
>                 ret = sdhci_start_signal_voltage_switch(mmc, ios);
> @@ -786,7 +850,7 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
>                 ret = sdhci_start_signal_voltage_switch(mmc, ios);
>                 if (ret < 0)
>                         return ret;
> -               ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> +               ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage, true);
>         }
>
>         if (tegra_host->pad_calib_required)
> @@ -805,6 +869,20 @@ static int tegra_sdhci_init_pinctrl_info(struct device *dev,
>                 return -1;
>         }
>
> +       tegra_host->pinctrl_state_1v8_drv = pinctrl_lookup_state(
> +                               tegra_host->pinctrl_sdmmc, "sdmmc-1v8-drv");
> +       if (IS_ERR(tegra_host->pinctrl_state_1v8_drv)) {
> +               if (PTR_ERR(tegra_host->pinctrl_state_1v8_drv) == -ENODEV)
> +                       tegra_host->pinctrl_state_1v8_drv = NULL;
> +       }
> +
> +       tegra_host->pinctrl_state_3v3_drv = pinctrl_lookup_state(
> +                               tegra_host->pinctrl_sdmmc, "sdmmc-3v3-drv");
> +       if (IS_ERR(tegra_host->pinctrl_state_3v3_drv)) {
> +               if (PTR_ERR(tegra_host->pinctrl_state_3v3_drv) == -ENODEV)
> +                       tegra_host->pinctrl_state_3v3_drv = NULL;
> +       }
> +
>         tegra_host->pinctrl_state_3v3 =
>                 pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
>         if (IS_ERR(tegra_host->pinctrl_state_3v3)) {
> --
> 2.7.4
>
