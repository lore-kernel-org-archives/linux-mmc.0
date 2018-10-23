From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH V2 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated
 dynamically
Date: Tue, 23 Oct 2018 17:43:19 +0530
Message-ID: <f816f58d-19f0-b0c9-40bb-3e436f0968a7@codeaurora.org>
References: <1539005138-32560-1-git-send-email-vbadigan@codeaurora.org>
 <1539005138-32560-3-git-send-email-vbadigan@codeaurora.org>
 <CAE=gft4tWoMTUwvLWLL6k0x1AqbBTM=5=dAckEEHiu6zLXskGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft4tWoMTUwvLWLL6k0x1AqbBTM=5=dAckEEHiu6zLXskGA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org, Doug Anderson <dianders@google.com>, asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayali <sayalil@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 10/17/2018 3:58 AM, Evan Green wrote:
> On Mon, Oct 8, 2018 at 6:26 AM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>> On few SDHCI-MSM controllers, the host controller's clock tuning
>> circuit may go out of sync if controller clocks are gated which
>> eventually will result in data CRC, command CRC/timeout errors.
>> To overcome this h/w limitation, the DLL needs to be re-initialized
>> and restored with its old settings once clocks are ungated.
>>
>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> ---
>>   drivers/mmc/host/sdhci-msm.c | 67 ++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 6918e70..1eb70c0 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -234,6 +234,7 @@ struct sdhci_msm_variant_ops {
>>    */
>>   struct sdhci_msm_variant_info {
>>          bool mci_removed;
>> +       bool uses_sdcdc10;
> What does that flag mean? Couldn't this just be called something like
> restore_dll_config?

'sdcdc10' is the DLL code-name that is being used in SDHC controller on 
SDM845.
I should have named it as uses_sdcdc10_dll.
I will update the name to be more meaningful.

>
>>          const struct sdhci_msm_variant_ops *var_ops;
>>          const struct sdhci_msm_offset *offset;
>>   };
>> @@ -264,6 +265,8 @@ struct sdhci_msm_host {
>>          u32 vmmc_level[2];
>>          bool vqmmc_load;
>>          u32 vqmmc_level[2];
>> +       bool uses_sdcdc10_dll;
>> +       bool restore_sdr_dll_cfg;
> restore_sdr_dll_cfg appears to not be used.

Yes, this needs to be removed, will remove it. Thanks for pointing.

>>   };
>>
>>   static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
>> @@ -1031,6 +1034,36 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
>>          return ret;
>>   }
>>
>> +static int sdhci_msm_restore_sdr_dll_config(struct sdhci_host *host)
>> +{
>> +       struct mmc_ios ios = host->mmc->ios;
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +       int ret;
>> +
>> +       /*
>> +        * SDR DLL comes into picure only if clock frequency is greater than
>> +        * 100MHz. And its needed only for SDR104, HS200 and HS400 cards.
>> +        * Its not needed for HS400es cards.
>> +        */
>> +       if (host->clock <= CORE_FREQ_100MHZ ||
>> +           !(ios.timing == MMC_TIMING_MMC_HS400 ||
>> +           ios.timing == MMC_TIMING_MMC_HS200 ||
>> +           ios.timing == MMC_TIMING_UHS_SDR104) ||
>> +           ios.enhanced_strobe)
>> +               return 0;
>> +
>> +       /* Reset the tuning block */
>> +       ret = msm_init_cm_dll(host);
> Is this reinit required? It's kind of meaty.

DLL re-initialization is very-much needed.
Its as per DLL h/w team instructions to support sdcdc10 DLL (10nm DLL)

>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Restore the tuning block */
>> +       ret = msm_config_cm_dll_phase(host, msm_host->saved_tuning_phase);
>> +
>> +       return ret;
>> +}
>> +
>>   static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>   {
>>          struct sdhci_host *host = mmc_priv(mmc);
>> @@ -1075,7 +1108,6 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>                  if (rc)
>>                          return rc;
>>
>> -               msm_host->saved_tuning_phase = phase;
>>                  rc = mmc_send_tuning(mmc, opcode, NULL);
>>                  if (!rc) {
>>                          /* Tuning is successful at this tuning point */
>> @@ -1100,6 +1132,7 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>                  rc = msm_config_cm_dll_phase(host, phase);
>>                  if (rc)
>>                          return rc;
>> +               msm_host->saved_tuning_phase = phase;
>>                  dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
>>                           mmc_hostname(mmc), phase);
>>          } else {
>> @@ -1807,19 +1840,39 @@ static int sdhci_msm_start_signal_voltage_switch(struct mmc_host *mmc,
>>
>>   static const struct sdhci_msm_variant_info sdhci_msm_mci_var = {
>>          .mci_removed = false,
>> +       .uses_sdcdc10 = false,
>> +       .var_ops = &mci_var_ops,
>> +       .offset = &sdhci_msm_mci_offset,
>> +};
>> +
>> +static const struct sdhci_msm_variant_info sdhci_msm_mci_sdcdc10_var = {
>> +       .mci_removed = false,
>> +       .uses_sdcdc10 = true,
>>          .var_ops = &mci_var_ops,
>>          .offset = &sdhci_msm_mci_offset,
>>   };
>>
>>   static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
>>          .mci_removed = true,
>> +       .uses_sdcdc10 = false,
>> +       .var_ops = &v5_var_ops,
>> +       .offset = &sdhci_msm_v5_offset,
>> +};
>> +
>> +static const struct sdhci_msm_variant_info sdhci_msm_v5_sdcdc10_var = {
>> +       .mci_removed = true,
>> +       .uses_sdcdc10 = true,
>>          .var_ops = &v5_var_ops,
>>          .offset = &sdhci_msm_v5_offset,
>>   };
>>
>>   static const struct of_device_id sdhci_msm_dt_match[] = {
>>          {.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
>> +       {.compatible = "qcom,sdhci-msm-v4-sdcdc10",
>> +                                           .data = &sdhci_msm_mci_sdcdc10_var},
>>          {.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
>> +       {.compatible = "qcom,sdhci-msm-v5-sdcdc10",
>> +                                           .data = &sdhci_msm_v5_sdcdc10_var},
>>          {},
>>   };
>>
>> @@ -1880,6 +1933,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>          var_info = of_device_get_match_data(&pdev->dev);
>>
>>          msm_host->mci_removed = var_info->mci_removed;
>> +       msm_host->uses_sdcdc10_dll = var_info->uses_sdcdc10;
>>          msm_host->var_ops = var_info->var_ops;
>>          msm_host->offset = var_info->offset;
>>
>> @@ -2124,9 +2178,18 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>>          struct sdhci_host *host = dev_get_drvdata(dev);
>>          struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>          struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +       int ret;
>>
>> -       return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>> +       ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>>                                         msm_host->bulk_clks);
> It might be nicer to just put an if (ret) return ret; here, instead of
> rolling it into the next conditional.

Sure. Will update it.

>
>> +       /*
>> +        * Whenever core-clock is gated dynamically, it's needed to
>> +        * restore the SDR DLL settings when the clock is ungated.
>> +        */
>> +       if (!ret && msm_host->uses_sdcdc10_dll && msm_host->clk_rate)
>> +               ret = sdhci_msm_restore_sdr_dll_config(host);
>> +
>> +       return ret;
>>   }
>>   #endif
>>
>> --
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>
