From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 2/4] mmc: sdhci-msm: Add and use voltage regulator
 related APIs
Date: Wed, 2 May 2018 10:49:40 +0200
Message-ID: <CAPDyKFo9MpwjfF6jz2H-fRVMsCbsiHVHKYjEkQjD4WWcDU8FXg@mail.gmail.com>
References: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org> <1525171153-24476-3-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525171153-24476-3-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Jeremy McNicoll <jeremymc@redhat.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Harjani Ritesh <riteshh@codeaurora.org>, vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>, sayalil@codeaurora.org, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 1 May 2018 at 12:39, Vijay Viswanath <vviswana@codeaurora.org> wrote:
> From: Asutosh Das <asutoshd@codeaurora.org>
>
> Some platforms require that the voltage switching happen only after
> the register write occurs and controller is ready for the switch. When
> the controller is ready, it will inform through power irq.
>
> Add voltage regulator APIs and use them during power irq to switch
> voltage instead of relying on core layer voltage switching.

This is way to simplified. 529 lines of new code deserves some more
explanations.

>
> Change-Id: Iaa98686e71a5bfe0092c68e9ffa563b060c5ac60

Remove this.

> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  27 +-

Split DT changes and add DT maintainers.

>  drivers/mmc/host/sdhci-msm.c                       | 537 +++++++++++++++++++--
>  2 files changed, 529 insertions(+), 35 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index c2b7b2b..c454046 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -23,6 +23,22 @@ Required properties:
>         "xo"    - TCXO clock (optional)
>         "cal"   - reference clock for RCLK delay calibration (optional)
>         "sleep" - sleep clock for RCLK delay calibration (optional)
> +- <supply-name>-supply: phandle to the regulator device tree node if voltage
> +               regulators needs to be handled from within sdhci-msm layer.
> +               Supported "supply-name" are "vdd" and "vdd-io".
> +
> +Optional Properties:
> +       - qcom,<supply>-always-on - specifies whether supply should be kept
> +               "on" always.
> +       - qcom,<supply>-lpm_sup - specifies whether supply can be kept in low
> +               power mode (lpm).
> +       - qcom,<supply>-voltage_level - specifies voltage levels for supply.
> +               Should be specified in pairs (min, max), units uV.
> +       - qcom,<supply>-current_level - specifies load levels for supply in lpm
> +               or high power mode (hpm). Should be specified in
> +               pairs (lpm, hpm), units uA.
> +
> +

This looks really weird.

What's so special here that requires you to have your own specific
regulator bindings?

>
>  Example:
>
> @@ -33,8 +49,15 @@ Example:
>                 bus-width = <8>;
>                 non-removable;
>
> -               vmmc-supply = <&pm8941_l20>;
> -               vqmmc-supply = <&pm8941_s3>;
> +               vdd-supply = <&pm8941_l20>;
> +               qcom,vdd-voltage-level = <2950000 2950000>;
> +               qcom,vdd-current-level = <9000 800000>;
> +
> +               vdd-io-supply = <&pm8941_s3>;
> +               qcom,vdd-io-always-on;
> +               qcom,vdd-io-lpm-sup;
> +               qcom,vdd-io-voltage-level = <1800000 2950000>;
> +               qcom,vdd-io-current-level = <6 22000>;
>
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index d4d432b..0e0f12d 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -213,6 +213,33 @@ struct sdhci_msm_offset sdhci_msm_offset_mci_present = {
>         .core_ddr_config_2 = 0x1BC,
>  };
>
> +/* This structure keeps information per regulator */
> +struct sdhci_msm_reg_data {
> +       /* voltage regulator handle */
> +       struct regulator *reg;
> +       /* regulator name */
> +       const char *name;
> +       /* voltage level to be set */
> +       u32 low_vol_level;
> +       u32 high_vol_level;
> +       /* Load values for low power and high power mode */
> +       u32 lpm_uA;
> +       u32 hpm_uA;
> +       /* is this regulator enabled? */
> +       bool is_enabled;
> +       /* is this regulator needs to be always on? */
> +       bool is_always_on;
> +       /* is low power mode setting required for this regulator? */
> +       bool lpm_sup;
> +       bool set_voltage_sup;
> +};
> +
> +struct sdhci_msm_pltfm_data {
> +       /* Change-Id: Ide3a658ad51a3c3d4a05c47c0e8f013f647c9516 */
> +       struct sdhci_msm_reg_data *vdd_data;
> +       struct sdhci_msm_reg_data *vdd_io_data;
> +};
> +
>  struct sdhci_msm_host {
>         struct platform_device *pdev;
>         void __iomem *core_mem; /* MSM SDCC mapped address */
> @@ -234,6 +261,8 @@ struct sdhci_msm_host {
>         u32 caps_0;
>         bool mci_removed;
>         const struct sdhci_msm_offset *offset;
> +       bool pltfm_init_done;
> +       struct sdhci_msm_pltfm_data pdata;
>  };
>
>  /*
> @@ -298,6 +327,336 @@ void sdhci_msm_vendor_writel_relaxed(u32 val, struct sdhci_host *host,
>         writel_relaxed(val, base_addr + offset);
>  }
>
> +enum vdd_io_level {
> +       /* set vdd_io_data->low_vol_level */
> +       VDD_IO_LOW,
> +       /* set vdd_io_data->high_vol_level */
> +       VDD_IO_HIGH,
> +       /*
> +        * set whatever there in voltage_level (third argument) of
> +        * sdhci_msm_set_vdd_io_vol() function.
> +        */
> +       VDD_IO_SET_LEVEL,
> +};
> +
> +#define MAX_PROP_SIZE 32
> +static int sdhci_msm_dt_parse_vreg_info(struct device *dev,
> +               struct sdhci_msm_reg_data **vreg_data, const char *vreg_name)
> +{
> +       int len, ret = 0;
> +       const __be32 *prop;
> +       char prop_name[MAX_PROP_SIZE];
> +       struct sdhci_msm_reg_data *vreg;
> +       struct device_node *np = dev->of_node;
> +
> +       snprintf(prop_name, MAX_PROP_SIZE, "%s-supply", vreg_name);
> +       if (!of_parse_phandle(np, prop_name, 0)) {
> +               dev_warn(dev, "No internal vreg data found for %s\n",
> +                               vreg_name);
> +               ret = -EINVAL;
> +               return ret;
> +       }
> +       vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
> +       if (!vreg) {
> +               ret = -ENOMEM;
> +               return ret;
> +       }
> +       vreg->name = vreg_name;
> +       snprintf(prop_name, MAX_PROP_SIZE,
> +                       "qcom,%s-always-on", vreg_name);
> +       if (of_get_property(np, prop_name, NULL))
> +               vreg->is_always_on = true;
> +
> +       snprintf(prop_name, MAX_PROP_SIZE,
> +                       "qcom,%s-lpm-sup", vreg_name);
> +       if (of_get_property(np, prop_name, NULL))
> +               vreg->lpm_sup = true;
> +       snprintf(prop_name, MAX_PROP_SIZE,
> +                       "qcom,%s-voltage-level", vreg_name);
> +       prop = of_get_property(np, prop_name, &len);
> +       if (!prop || (len != (2 * sizeof(__be32)))) {
> +               dev_warn(dev, "%s %s property\n",
> +                               prop ? "invalid format" : "no", prop_name);
> +       } else {
> +               vreg->low_vol_level = be32_to_cpup(&prop[0]);
> +               vreg->high_vol_level = be32_to_cpup(&prop[1]);
> +       }
> +       snprintf(prop_name, MAX_PROP_SIZE,
> +                       "qcom,%s-current-level", vreg_name);
> +       prop = of_get_property(np, prop_name, &len);
> +       if (!prop || (len != (2 * sizeof(__be32)))) {
> +               dev_warn(dev, "%s %s property\n",
> +                               prop ? "invalid format" : "no", prop_name);
> +       } else {
> +               vreg->lpm_uA = be32_to_cpup(&prop[0]);
> +               vreg->hpm_uA = be32_to_cpup(&prop[1]);
> +       }
> +       *vreg_data = vreg;
> +       dev_dbg(dev, "%s: %s %s vol=[%d %d]uV, curr=[%d %d]uA\n",
> +                       vreg->name, vreg->is_always_on ? "always_on," : "",
> +                       vreg->lpm_sup ? "lpm_sup," : "", vreg->low_vol_level,
> +                       vreg->high_vol_level, vreg->lpm_uA, vreg->hpm_uA);

So again, I don't get why this isn't being implemented as a regular
regulator and why is this code in the mmc driver?

> +
> +       return ret;
> +}
> +
> +/* Regulator utility functions */
> +static int sdhci_msm_vreg_init_reg(struct device *dev,
> +                                       struct sdhci_msm_reg_data *vreg)
> +{
> +       int ret = 0;
> +
> +       /* check if regulator is already initialized? */
> +       if (vreg->reg)
> +               goto out;
> +
> +       /* Get the regulator handle */
> +       vreg->reg = devm_regulator_get(dev, vreg->name);
> +       if (IS_ERR(vreg->reg)) {
> +               ret = PTR_ERR(vreg->reg);
> +               pr_err("%s: devm_regulator_get(%s) failed. ret=%d\n",
> +                       __func__, vreg->name, ret);
> +               goto out;
> +       }
> +
> +       if (regulator_count_voltages(vreg->reg) > 0) {
> +               vreg->set_voltage_sup = true;
> +               /* sanity check */
> +               if (!vreg->high_vol_level || !vreg->hpm_uA) {
> +                       pr_err("%s: %s invalid constraints specified high_vol_level: %d hpm_uA: %d\n",
> +                              __func__, vreg->name, vreg->high_vol_level,
> +                              vreg->hpm_uA);
> +                       ret = -EINVAL;
> +               }
> +       }
> +
> +out:
> +       return ret;
> +}
> +
> +static void sdhci_msm_vreg_deinit_reg(struct sdhci_msm_reg_data *vreg)
> +{
> +       if (vreg->reg)
> +               devm_regulator_put(vreg->reg);
> +}
> +
> +static int sdhci_msm_vreg_set_optimum_mode(struct sdhci_msm_reg_data
> +                                                 *vreg, int uA_load)
> +{
> +       int ret = 0;
> +
> +       /*
> +        * regulators that do not support regulator_set_voltage also
> +        * do not support regulator_set_optimum_mode
> +        */

If that's the case, the regulator core should return proper error
codes and you should need to have these kind of checks here. Right?

Or at least there should be a helper function telling what you can do
with your regulator, instead of encoding it at in the mmc driver.

> +       if (vreg->set_voltage_sup) {
> +               ret = regulator_set_load(vreg->reg, uA_load);
> +               if (ret < 0)
> +                       pr_err("%s: regulator_set_load(reg=%s,uA_load=%d) failed. ret=%d\n",
> +                              __func__, vreg->name, uA_load, ret);
> +               else
> +                       /*
> +                        * regulator_set_load() can return non zero
> +                        * value even for success case.
> +                        */
> +                       ret = 0;
> +       }
> +       return ret;
> +}
> +
> +static int sdhci_msm_vreg_set_voltage(struct sdhci_msm_reg_data *vreg,
> +                                       int min_uV, int max_uV)
> +{
> +       int ret = 0;
> +
> +       if (vreg && vreg->set_voltage_sup) {

Ditto.

> +               ret = regulator_set_voltage(vreg->reg, min_uV, max_uV);
> +               if (ret) {
> +                       pr_err("%s: regulator_set_voltage(%s)failed. min_uV=%d,max_uV=%d,ret=%d\n",
> +                              __func__, vreg->name, min_uV, max_uV, ret);
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int sdhci_msm_vreg_enable(struct sdhci_msm_reg_data *vreg)
> +{
> +       int ret = 0;
> +
> +       /* Put regulator in HPM (high power mode) */
> +       ret = sdhci_msm_vreg_set_optimum_mode(vreg, vreg->hpm_uA);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (!vreg->is_enabled) {
> +               /* Set voltage level */
> +               ret = sdhci_msm_vreg_set_voltage(vreg, vreg->high_vol_level,
> +                                               vreg->high_vol_level);
> +               if (ret)
> +                       return ret;
> +       }
> +       ret = regulator_enable(vreg->reg);
> +       if (ret) {
> +               pr_err("%s: regulator_enable(%s) failed. ret=%d\n",
> +                               __func__, vreg->name, ret);
> +               return ret;
> +       }
> +       vreg->is_enabled = true;
> +       return ret;

Why don't you use the mmc_regulator_*() APIs? It seems like lots of
open coding here.

> +}
> +
> +static int sdhci_msm_vreg_disable(struct sdhci_msm_reg_data *vreg)
> +{
> +       int ret = 0;
> +
> +       /* Never disable regulator marked as always_on */
> +       if (vreg->is_enabled && !vreg->is_always_on) {
> +               ret = regulator_disable(vreg->reg);
> +               if (ret) {
> +                       pr_err("%s: regulator_disable(%s) failed. ret=%d\n",
> +                               __func__, vreg->name, ret);
> +                       goto out;
> +               }
> +               vreg->is_enabled = false;
> +
> +               ret = sdhci_msm_vreg_set_optimum_mode(vreg, 0);
> +               if (ret < 0)
> +                       goto out;
> +
> +               /* Set min. voltage level to 0 */
> +               ret = sdhci_msm_vreg_set_voltage(vreg, 0, vreg->high_vol_level);
> +               if (ret)
> +                       goto out;
> +       } else if (vreg->is_enabled && vreg->is_always_on) {
> +               if (vreg->lpm_sup) {
> +                       /* Put always_on regulator in LPM (low power mode) */
> +                       ret = sdhci_msm_vreg_set_optimum_mode(vreg,
> +                                                             vreg->lpm_uA);
> +                       if (ret < 0)
> +                               goto out;
> +               }
> +       }
> +out:
> +       return ret;
> +}

Ditto.

[...]

> +
> +/* Parse platform data */
> +static void sdhci_msm_populate_pdata(struct device *dev,
> +               struct sdhci_msm_pltfm_data *pdata)
> +{
> +       int ret = 0;
> +
> +       ret = sdhci_msm_dt_parse_vreg_info(dev, &pdata->vdd_data, "vdd");
> +       if (ret)
> +               dev_warn(dev, "failed parsing vdd data (%d)\n", ret);
> +
> +       ret = sdhci_msm_dt_parse_vreg_info(dev, &pdata->vdd_io_data, "vdd-io");
> +       if (ret)
> +               dev_warn(dev, "failed parsing vdd-io data (%d)\n", ret);
> +
> +}
> +
>  static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
>                                                     unsigned int clock)
>  {
> @@ -1326,6 +1685,7 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>         u32 pwr_state = 0, io_level = 0;
>         u32 config;
>         const struct sdhci_msm_offset *msm_offset = msm_host->offset;
> +       int ret = 0;
>
>         irq_status = sdhci_msm_vendor_readl_relaxed(host,
>                         msm_offset->core_pwrctl_status);
> @@ -1358,21 +1718,54 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>
>         /* Handle BUS ON/OFF*/
>         if (irq_status & CORE_PWRCTL_BUS_ON) {
> +               ret = sdhci_msm_setup_vreg(&msm_host->pdata, true, false);
> +               if (!ret) {
> +                       ret = sdhci_msm_set_vdd_io_vol(&msm_host->pdata,
> +                                       VDD_IO_HIGH, 0);
> +                       if (ret)
> +                               pr_err("%s: error setting vdd io in BUS_ON: %d\n",
> +                                               mmc_hostname(host->mmc), ret);
> +               } else {
> +                       pr_err("%s: error setting up vreg ON : %d\n",
> +                                       mmc_hostname(host->mmc), ret);
> +               }
>                 pwr_state = REQ_BUS_ON;
>                 io_level = REQ_IO_HIGH;
>                 irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
>         }
>         if (irq_status & CORE_PWRCTL_BUS_OFF) {
> +               if (msm_host->pltfm_init_done)
> +                       ret = sdhci_msm_setup_vreg(&msm_host->pdata,
> +                                       false, false);
> +               if (!ret) {
> +                       ret = sdhci_msm_set_vdd_io_vol(&msm_host->pdata,
> +                                       VDD_IO_LOW, 0);
> +                       if (ret)
> +                               pr_err("%s: error setting vdd io in BUS_OFF: %d\n",
> +                                               mmc_hostname(host->mmc), ret);
> +               } else {
> +                       pr_err("%s: error setting up vreg OFF: %d\n",
> +                                       mmc_hostname(host->mmc), ret);
> +               }
>                 pwr_state = REQ_BUS_OFF;
>                 io_level = REQ_IO_LOW;
>                 irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
>         }
>         /* Handle IO LOW/HIGH */
>         if (irq_status & CORE_PWRCTL_IO_LOW) {
> +               ret = sdhci_msm_set_vdd_io_vol(&msm_host->pdata, VDD_IO_LOW, 0);
> +               if (ret)
> +                       pr_err("%s: error setting up vdd io low: %d\n",
> +                                       mmc_hostname(host->mmc), ret);
>                 io_level = REQ_IO_LOW;
>                 irq_ack |= CORE_PWRCTL_IO_SUCCESS;
>         }
>         if (irq_status & CORE_PWRCTL_IO_HIGH) {
> +               ret = sdhci_msm_set_vdd_io_vol(&msm_host->pdata,
> +                               VDD_IO_HIGH, 0);
> +               if (ret)
> +                       pr_err("%s: error setting up vdd io high: %d\n",
> +                                       mmc_hostname(host->mmc), ret);
>                 io_level = REQ_IO_HIGH;
>                 irq_ack |= CORE_PWRCTL_IO_SUCCESS;
>         }
> @@ -1380,7 +1773,7 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>         /*
>          * The driver has to acknowledge the interrupt, switch voltages and
>          * report back if it succeded or not to this register. The voltage
> -        * switches are handled by the sdhci core, so just report success.
> +        * switches may be handled by the sdhci core, so just report success.
>          */
>         sdhci_msm_vendor_writel_relaxed(irq_ack, host,
>                         msm_offset->core_pwrctl_ctl);
> @@ -1612,6 +2005,74 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>         pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
>  }
>
> +static void sdhci_msm_set_default_hw_caps(struct device *dev,
> +               struct sdhci_msm_host *msm_host,
> +               struct sdhci_host *host)
> +{
> +       u32 version, config;
> +       u16 minor;
> +       u8 major;
> +       const struct sdhci_msm_offset *msm_offset = msm_host->offset;
> +       struct sdhci_msm_reg_data *vdd_io_reg = msm_host->pdata.vdd_io_data;
> +       u32 caps = 0;
> +
> +       version =  sdhci_msm_vendor_readl_relaxed(host,
> +                       msm_offset->core_mci_version);
> +       major = (version & CORE_VERSION_MAJOR_MASK) >>
> +               CORE_VERSION_MAJOR_SHIFT;
> +       minor = version & CORE_VERSION_MINOR_MASK;
> +       dev_dbg(dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
> +                       version, major, minor);
> +
> +       /*
> +        * If voltage regulators are controlled by msm host layer and
> +        * IO voltage regulator can support 1.8V, we need to
> +        * update the capabilities here before sdhci host is added.
> +        */
> +       if (vdd_io_reg && (vdd_io_reg->low_vol_level < 1950000))
> +               caps |= CORE_1_8V_SUPPORT;
> +       if (vdd_io_reg && (vdd_io_reg->low_vol_level > 2700000))
> +               caps |= CORE_3_0V_SUPPORT;
> +       if (caps) {
> +               msm_host->caps_0 |= caps;
> +               config =  readl_relaxed(host->ioaddr +
> +                               msm_offset->core_vendor_spec);
> +               config |= CORE_IO_PAD_PWR_SWITCH_EN;
> +               writel_relaxed(config,
> +                               host->ioaddr + msm_offset->core_vendor_spec);
> +       }
> +
> +       caps = readl_relaxed(host->ioaddr + SDHCI_CAPABILITIES);
> +
> +       if (major == 1 && minor >= 0x42)
> +               msm_host->use_14lpp_dll_reset = true;
> +       /*
> +        * SDCC 5 controller with major version 1, minor version 0x34 and later
> +        * with HS 400 mode support will use CM DLL instead of CDC LP 533 DLL.
> +        */
> +       if (major == 1 && minor < 0x34)
> +               msm_host->use_cdclp533 = true;
> +
> +       /*
> +        * Support for some capabilities is not advertised by newer
> +        * controller versions and must be explicitly enabled.
> +        */
> +       if (major >= 1 && minor != 0x11 && minor != 0x12) {
> +
> +               vdd_io_reg = msm_host->pdata.vdd_io_data;
> +               caps |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
> +               if (msm_host->caps_0 & CORE_1_8V_SUPPORT)
> +                       caps |= CORE_1_8V_SUPPORT;
> +       }
> +       msm_host->caps_0 |= caps;
> +       writel_relaxed(msm_host->caps_0, host->ioaddr +
> +                       msm_offset->core_vendor_spec_capabilities0);
> +
> +       /* Set more host capabilities */
> +       msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +       msm_host->mmc->caps2 |= MMC_CAP2_BOOTPART_NOACC;

Is really all above only related to regulators, as according to the
change log? Probably not.

Reaching this point in the review, it certainly seems like the change
needs to be split up in quite a few smaller pieces. Can you please do
that!?

[...]

Kind regards
Uffe
