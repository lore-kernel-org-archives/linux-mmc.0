From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH V2 3/3] mmc: sdhci-msm: Use internal voltage control
Date: Thu, 27 Sep 2018 19:43:04 +0530
Message-ID: <aa19cd49-b29c-a785-6904-85b9fad93208@codeaurora.org>
References: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
 <1537424558-17989-4-git-send-email-vbadigan@codeaurora.org>
 <CAE=gft483AkgBcF5P5EADzWFmjSqsxhzKjoQfmKxmrHyWSBApQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft483AkgBcF5P5EADzWFmjSqsxhzKjoQfmKxmrHyWSBApQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org, linux-mmc@vger.kernel.org, asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayali <sayalil@codeaurora.org>, Doug Anderson <dianders@google.com>, vviswana@codeaurora.org, venkatg@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 9/22/2018 1:39 AM, Evan Green wrote:
> On Wed, Sep 19, 2018 at 11:24 PM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>> From: Vijay Viswanath <vviswana@codeaurora.org>
>>
>> Some sdhci-msm controllers require that voltage switching be done after
>> the HW is ready for it. The HW informs its readiness through power irq.
>> The voltage switching should happen only then.
>>
>> Use the quirk for internal voltage switching and then control the
>> voltage switching using power irq.
>>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> ---
>>   drivers/mmc/host/sdhci-msm.c | 211 +++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 203 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 3cc8bfe..486462d 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -43,7 +43,9 @@
>>   #define CORE_PWRCTL_IO_LOW     BIT(2)
>>   #define CORE_PWRCTL_IO_HIGH    BIT(3)
>>   #define CORE_PWRCTL_BUS_SUCCESS BIT(0)
>> +#define CORE_PWRCTL_BUS_FAIL    BIT(1)
>>   #define CORE_PWRCTL_IO_SUCCESS BIT(2)
>> +#define CORE_PWRCTL_IO_FAIL     BIT(3)
>>   #define REQ_BUS_OFF            BIT(0)
>>   #define REQ_BUS_ON             BIT(1)
>>   #define REQ_IO_LOW             BIT(2)
>> @@ -258,6 +260,10 @@ struct sdhci_msm_host {
>>          bool mci_removed;
>>          const struct sdhci_msm_variant_ops *var_ops;
>>          const struct sdhci_msm_offset *offset;
>> +       bool vmmc_load;
>> +       u32 vmmc_level[2];
>> +       bool vqmmc_load;
>> +       u32 vqmmc_level[2];
>>   };
>>
>>   static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
>> @@ -1211,6 +1217,74 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>>                  sdhci_msm_hs400(host, &mmc->ios);
>>   }
>>
>> +static int sdhci_msm_set_vmmc(struct sdhci_msm_host *msm_host,
>> +                             struct mmc_host *mmc, int level)
>> +{
>> +       int load = msm_host->vmmc_level[level];
>> +       int ret;
>> +
>> +       if (IS_ERR(mmc->supply.vmmc))
>> +               return 0;
>> +
>> +       if (msm_host->vmmc_load) {
>> +               ret = regulator_set_load(mmc->supply.vmmc, load);
>> +               if (ret)
>> +                       goto out;
>> +       }
>> +
>> +       ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, mmc->ios.vdd);
> This is new, isn't it? Could you explain why this is needed?

This sets the regulator voltage to supplied value and
enables/disables the regulator.

>
>> +out:
>> +       if (ret)
>> +               pr_err("%s: vmmc set load/ocr failed: %d\n",
>> +                               mmc_hostname(mmc), ret);
>> +
>> +       return ret;
>> +}
>> +
>> +static int sdhci_msm_set_vqmmc(struct sdhci_msm_host *msm_host,
>> +                             struct mmc_host *mmc, int level)
>> +{
>> +       int load = msm_host->vqmmc_level[level];
>> +       int ret;
>> +       struct mmc_ios ios;
>> +
>> +       if (IS_ERR(mmc->supply.vqmmc))
>> +               return 0;
>> +
>> +       if (msm_host->vqmmc_load) {
>> +               ret = regulator_set_load(mmc->supply.vqmmc, load);
>> +               if (ret)
>> +                       goto out;
>> +       }
>> +
>> +       /*
>> +        * The IO voltage regulator maynot always support a voltage close to
> s/maynot/may not/
>
>> +        * vdd. Set IO voltage based on  capability of the regulator.
> remove extra space between on and capability.
>
>> +        */
>> +       if (level) {
>> +               if (msm_host->caps_0 & CORE_3_0V_SUPPORT)
>> +                       ios.signal_voltage = MMC_SIGNAL_VOLTAGE_330;
>> +               else if (msm_host->caps_0 & CORE_1_8V_SUPPORT)
>> +                       ios.signal_voltage = MMC_SIGNAL_VOLTAGE_180;
>> +               if (msm_host->caps_0 & CORE_VOLT_SUPPORT) {
>> +                       pr_debug("%s: %s: setting signal voltage: %d\n",
>> +                                       mmc_hostname(mmc), __func__,
>> +                                       ios.signal_voltage);
>> +                       ret = mmc_regulator_set_vqmmc(mmc, &ios);
>> +                       if (ret)
>> +                               goto out;
>> +               }
>> +               ret = regulator_enable(mmc->supply.vqmmc);
>> +       } else {
>> +               ret = regulator_disable(mmc->supply.vqmmc);
>> +       }
>> +out:
>> +       if (ret)
>> +               pr_err("%s: vqmmc failed: %d\n", mmc_hostname(mmc), ret);
>> +
>> +       return ret;
>> +}
>> +
>>   static inline void sdhci_msm_init_pwr_irq_wait(struct sdhci_msm_host *msm_host)
>>   {
>>          init_waitqueue_head(&msm_host->pwr_irq_wait);
>> @@ -1314,8 +1388,9 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>>   {
>>          struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>          struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +       struct mmc_host *mmc = host->mmc;
>>          u32 irq_status, irq_ack = 0;
>> -       int retry = 10;
>> +       int retry = 10, ret = 0;
>>          u32 pwr_state = 0, io_level = 0;
>>          u32 config;
>>          const struct sdhci_msm_offset *msm_offset = msm_host->offset;
>> @@ -1351,14 +1426,34 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>>
>>          /* Handle BUS ON/OFF*/
>>          if (irq_status & CORE_PWRCTL_BUS_ON) {
>> -               pwr_state = REQ_BUS_ON;
>> -               io_level = REQ_IO_HIGH;
>> -               irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
>> +               ret = sdhci_msm_set_vmmc(msm_host, mmc, 1);
>> +               if (!ret)
>> +                       ret = sdhci_msm_set_vqmmc(msm_host, mmc, 1);
> Should you put vmmc back to 0 if setting vqmmc to 1 fails?

Yeah, will set to back to 0.

>
>> +
>> +               if (!ret) {
>> +                       pwr_state = REQ_BUS_ON;
>> +                       io_level = REQ_IO_HIGH;
>> +                       irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
>> +               } else {
>> +                       pr_err("%s: BUS_ON req failed(%d). irq_status: 0x%08x\n",
>> +                                       mmc_hostname(mmc), ret, irq_status);
>> +                       irq_ack |= CORE_PWRCTL_BUS_FAIL;
>> +               }
>>          }
>>          if (irq_status & CORE_PWRCTL_BUS_OFF) {
>> -               pwr_state = REQ_BUS_OFF;
>> -               io_level = REQ_IO_LOW;
>> -               irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
>> +               ret = sdhci_msm_set_vmmc(msm_host, mmc, 0);
>> +               if (!ret)
>> +                       ret = sdhci_msm_set_vqmmc(msm_host, mmc, 0);
>> +
>> +               if (!ret) {
>> +                       pwr_state = REQ_BUS_OFF;
>> +                       io_level = REQ_IO_LOW;
>> +                       irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
>> +               } else {
>> +                       pr_err("%s: BUS_ON req failed(%d). irq_status: 0x%08x\n",
>> +                                       mmc_hostname(mmc), ret, irq_status);
>> +                       irq_ack |= CORE_PWRCTL_BUS_FAIL;
>> +               }
>>          }
>>          /* Handle IO LOW/HIGH */
>>          if (irq_status & CORE_PWRCTL_IO_LOW) {
>> @@ -1370,6 +1465,15 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>>                  irq_ack |= CORE_PWRCTL_IO_SUCCESS;
>>          }
>>
>> +       if (io_level && !IS_ERR(mmc->supply.vqmmc) && !pwr_state) {
>> +               ret = mmc_regulator_set_vqmmc(mmc, &mmc->ios);
>> +               if (ret)
>> +                       pr_err("%s: IO_level setting failed(%d). signal_voltage: %d, vdd: %d irq_status: 0x%08x\n",
>> +                                       mmc_hostname(mmc), ret,
>> +                                       mmc->ios.signal_voltage, mmc->ios.vdd,
>> +                                       irq_status);
>> +       }
>> +
>>          /*
>>           * The driver has to acknowledge the interrupt, switch voltages and
>>           * report back if it succeded or not to this register. The voltage
>> @@ -1605,6 +1709,91 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>>          pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
>>   }
>>
>> +static int sdhci_msm_register_vreg(struct sdhci_msm_host *msm_host)
>> +{
>> +       int ret = 0;
>> +
>> +       ret = mmc_regulator_get_supply(msm_host->mmc);
>> +       if (ret)
>> +               return ret;
>> +       if (device_property_read_u32_array(&msm_host->pdev->dev,
>> +                       "qcom,vmmc-current-level-microamp",
>> +                       msm_host->vmmc_level, 2) >= 0)
>> +               msm_host->vmmc_load = true;
>> +       if (device_property_read_u32_array(&msm_host->pdev->dev,
>> +                       "qcom,vqmmc-current-level-microamp",
>> +                       msm_host->vqmmc_level, 2) >= 0)
>> +               msm_host->vqmmc_load = true;
>> +
>> +       sdhci_msm_set_regulator_caps(msm_host);
>> +
>> +       return 0;
>> +
>> +}
>> +
>> +static int sdhci_msm_start_signal_voltage_switch(struct mmc_host *mmc,
>> +                                     struct mmc_ios *ios)
>> +{
>> +       struct sdhci_host *host = mmc_priv(mmc);
>> +       u16 ctrl;
>> +
>> +       /*
>> +        * Signal Voltage Switching is only applicable for Host Controllers
>> +        * v3.00 and above.
>> +        */
>> +       if (host->version < SDHCI_SPEC_300)
>> +               return 0;
>> +
>> +       ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +
>> +       switch (ios->signal_voltage) {
>> +       case MMC_SIGNAL_VOLTAGE_330:
>> +               if (!(host->flags & SDHCI_SIGNALING_330))
>> +                       return -EINVAL;
>> +               /* Set 1.8V Signal Enable in the Host Control2 register to 0 */
>> +               ctrl &= ~SDHCI_CTRL_VDD_180;
>> +               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>> +
>> +               /* 3.3V regulator output should be stable within 5 ms */
>> +               ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +               if (!(ctrl & SDHCI_CTRL_VDD_180))
>> +                       return 0;
>> +
>> +               pr_warn("%s: 3.3V regulator output did not became stable\n",
>> +                       mmc_hostname(mmc));
>> +
>> +               return -EAGAIN;
>> +       case MMC_SIGNAL_VOLTAGE_180:
>> +               if (!(host->flags & SDHCI_SIGNALING_180))
>> +                       return -EINVAL;
>> +
>> +               /*
>> +                * Enable 1.8V Signal Enable in the Host Control2
>> +                * register
>> +                */
>> +               ctrl |= SDHCI_CTRL_VDD_180;
>> +               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>> +
>> +               /* 1.8V regulator output should be stable within 5 ms */
>> +               ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +               if (ctrl & SDHCI_CTRL_VDD_180)
>> +                       return 0;
>> +
>> +               pr_warn("%s: 1.8V regulator output did not became stable\n",
>> +                       mmc_hostname(mmc));
>> +
>> +               return -EAGAIN;
>> +       case MMC_SIGNAL_VOLTAGE_120:
>> +               if (!(host->flags & SDHCI_SIGNALING_120))
>> +                       return -EINVAL;
> So the state of SDHCI_CTRL_VDD_180 doesn't matter when trying to set
> 1.2V? I tried looking at the SDHC spec, but it was similarly silent
> about 1.2V. So I guess it's fine?

Right.
But  SDHCI_SIGNALING_120 gets set only if the the vqmmc regulator
supports 1.2v. On all msm platforms, the minimum voltage of vqmmc is 1.8v
only. So 1.2v is not supported on sdhci-msm platforms.

>
>
>> +               return 0;
>> +       default:
>> +               /* No signal voltage switch required */
>> +               return 0;
>> +       }
>> +
>> +}
>> +
>>   static const struct sdhci_msm_variant_ops mci_var_ops = {
>>          .msm_readl_relaxed = sdhci_msm_mci_variant_readl_relaxed,
>>          .msm_writel_relaxed = sdhci_msm_mci_variant_writel_relaxed,
>> @@ -1644,6 +1833,7 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>>          .set_uhs_signaling = sdhci_msm_set_uhs_signaling,
>>          .write_w = sdhci_msm_writew,
>>          .write_b = sdhci_msm_writeb,
>> +       .set_power = sdhci_set_power_noreg,
>>   };
>>
>>   static const struct sdhci_pltfm_data sdhci_msm_pdata = {
>> @@ -1818,6 +2008,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>                                  msm_offset->core_vendor_spec_capabilities0);
>>          }
>>
>> +       ret = sdhci_msm_register_vreg(msm_host);
>> +       if (ret)
>> +               goto clk_disable;
>> +
>>          /*
>>           * Power on reset state may trigger power irq if previous status of
>>           * PWRCTL was either BUS_ON or IO_HIGH_V. So before enabling pwr irq
>> @@ -1862,11 +2056,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>                                           MSM_MMC_AUTOSUSPEND_DELAY_MS);
>>          pm_runtime_use_autosuspend(&pdev->dev);
>>
>> +       host->mmc_host_ops.start_signal_voltage_switch =
>> +               sdhci_msm_start_signal_voltage_switch;
>>          host->mmc_host_ops.execute_tuning = sdhci_msm_execute_tuning;
>>          ret = sdhci_add_host(host);
>>          if (ret)
>>                  goto pm_runtime_disable;
>> -       sdhci_msm_set_regulator_caps(msm_host);
>>
>>          pm_runtime_mark_last_busy(&pdev->dev);
>>          pm_runtime_put_autosuspend(&pdev->dev);
>> --
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>>

Thanks,
Veeera
