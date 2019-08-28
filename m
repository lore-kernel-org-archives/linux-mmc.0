From: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-arasan: Add Support for Intel LGM
 eMMC
Date: Wed, 28 Aug 2019 09:34:15 +0800
Message-ID: <373e55ab-c76b-7657-bd47-1a5efc75a062@linux.intel.com>
References: <20190826072800.38413-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190826072800.38413-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAPDyKFrPoPqnh3_23P=wGO+QrUE9ogJzC6xgzy+0QeyuyeO=HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrPoPqnh3_23P=wGO+QrUE9ogJzC6xgzy+0QeyuyeO=HQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, DTML <devicetree@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, andriy.shevchenko@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On 27/8/2019 9:49 PM, Ulf Hansson wrote:
> On Mon, 26 Aug 2019 at 09:28, Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> From: Ramuthevar Vadivel Muruganx <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> The current arasan sdhci PHY configuration isn't compatible
>> with the PHY on Intel's LGM(Lightning Mountain) SoC devices.
>>
>> Therefore, add a new compatible, to adapt the Intel's LGM
>> eMMC PHY with arasan-sdhc controller to configure the PHY.
>>
>> Signed-off-by: Ramuthevar Vadivel Muruganx <vadivel.muruganx.ramuthevar@linux.intel.com>
>
> Applied for next, thanks!
>
> Kind regards
> Uffe
>
Thank you so much for review and applied for next.

Best Regards
Vadivel
>> ---
>>   drivers/mmc/host/sdhci-of-arasan.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index b12abf9b15f2..7023cbec4017 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -114,6 +114,12 @@ static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
>>          .hiword_update = true,
>>   };
>>
>> +static const struct sdhci_arasan_soc_ctl_map intel_lgm_emmc_soc_ctl_map = {
>> +       .baseclkfreq = { .reg = 0xa0, .width = 8, .shift = 2 },
>> +       .clockmultiplier = { .reg = 0, .width = -1, .shift = -1 },
>> +       .hiword_update = false,
>> +};
>> +
>>   /**
>>    * sdhci_arasan_syscon_write - Write to a field in soc_ctl registers
>>    *
>> @@ -373,6 +379,11 @@ static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
>>          .pdata = &sdhci_arasan_cqe_pdata,
>>   };
>>
>> +static struct sdhci_arasan_of_data intel_lgm_emmc_data = {
>> +       .soc_ctl_map = &intel_lgm_emmc_soc_ctl_map,
>> +       .pdata = &sdhci_arasan_cqe_pdata,
>> +};
>> +
>>   #ifdef CONFIG_PM_SLEEP
>>   /**
>>    * sdhci_arasan_suspend - Suspend method for the driver
>> @@ -474,6 +485,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>>                  .compatible = "rockchip,rk3399-sdhci-5.1",
>>                  .data = &sdhci_arasan_rk3399_data,
>>          },
>> +       {
>> +               .compatible = "intel,lgm-sdhci-5.1-emmc",
>> +               .data = &intel_lgm_emmc_data,
>> +       },
>>          /* Generic compatible below here */
>>          {
>>                  .compatible = "arasan,sdhci-8.9a",
>> --
>> 2.11.0
>>
