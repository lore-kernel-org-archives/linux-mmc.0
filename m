From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] mmc: sdhci-omap: Workaround errata regarding SDR104/HS200
 tuning failures (i929)
Date: Mon, 10 Dec 2018 18:55:46 +0530
Message-ID: <d1ae4e93-4b17-9574-00b1-bfa268cb7574@ti.com>
References: <20181129190503.6040-1-faiz_abbas@ti.com>
 <cb1e8e88-4c9d-741d-79cd-57b03c5e0808@ti.com>
 <c4704766-7a58-8aa4-6bc0-b9373b15096c@ti.com>
 <CAPDyKFqMW+tMaVsS_c=kPztZRjX97Nzr2W0egvDkyzkpWckHRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqMW+tMaVsS_c=kPztZRjX97Nzr2W0egvDkyzkpWckHRA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon <kishon@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Uffe,

On 05/12/18 7:20 PM, Ulf Hansson wrote:
> On Fri, 30 Nov 2018 at 06:53, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>
>> Hi Kishon,
>>
>> On 30/11/18 10:10 AM, Kishon Vijay Abraham I wrote:
>>> Hi Faiz,
>>>
>>> On 30/11/18 12:35 AM, Faiz Abbas wrote:
>>>> Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
>>>> (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
>>>> unexpected tuning pattern errors. A small failure band may be present
>>>> in the tuning range which may be missed by the current algorithm.
>>>> Furthermore, the failure bands vary with temperature leading to
>>>> different optimum tuning values for different temperatures.
>>>>
>>>> As suggested in the related Application Report (SPRACA9B - October 2017
>>>> - Revised July 2018 [2]), tuning should be done in two stages.
>>>> In stage 1, assign the optimum ratio in the maximum pass window for the
>>>> current temperature. In stage 2, if the chosen value is close to the
>>>> small failure band, move away from it in the appropriate direction.
>>>>
>>>> References:
>>>> [1] http://www.ti.com/lit/pdf/sprz426
>>>> [2] http://www.ti.com/lit/pdf/SPRACA9
>>>>
>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>> ---
>>>>  drivers/mmc/host/Kconfig      |  2 +
>>>>  drivers/mmc/host/sdhci-omap.c | 90 ++++++++++++++++++++++++++++++++++-
>>>>  2 files changed, 91 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>>> index 1b58739d9744..6d3553f06f27 100644
>>>> --- a/drivers/mmc/host/Kconfig
>>>> +++ b/drivers/mmc/host/Kconfig
>>>> @@ -969,6 +969,8 @@ config MMC_SDHCI_XENON
>>>>  config MMC_SDHCI_OMAP
>>>>      tristate "TI SDHCI Controller Support"
>>>>      depends on MMC_SDHCI_PLTFM && OF
>>>> +    select THERMAL
>>>> +    select TI_SOC_THERMAL
>>>>      help
>>>>        This selects the Secure Digital Host Controller Interface (SDHCI)
>>>>        support present in TI's DRA7 SOCs. The controller supports
>>>> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
>>>> index b3cb39d0db6f..9ccce7ef3a60 100644
>>>> --- a/drivers/mmc/host/sdhci-omap.c
>>>> +++ b/drivers/mmc/host/sdhci-omap.c
>>>> @@ -27,6 +27,7 @@
>>>>  #include <linux/regulator/consumer.h>
>>>>  #include <linux/pinctrl/consumer.h>
>>>>  #include <linux/sys_soc.h>
>>>> +#include <linux/thermal.h>
>>>>
>>>>  #include "sdhci-pltfm.h"
>>>>
>>>> @@ -286,14 +287,18 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>>      struct sdhci_host *host = mmc_priv(mmc);
>>>>      struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>      struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>>>> +    struct thermal_zone_device *thermal_dev;
>>>>      struct device *dev = omap_host->dev;
>>>>      struct mmc_ios *ios = &mmc->ios;
>>>>      u32 start_window = 0, max_window = 0;
>>>> +    bool single_point_failure = false;
>>>>      u8 cur_match, prev_match = 0;
>>>>      u32 length = 0, max_len = 0;
>>>>      u32 phase_delay = 0;
>>>> +    int temperature;
>>>>      int ret = 0;
>>>>      u32 reg;
>>>> +    int i;
>>>>
>>>>      /* clock tuning is not needed for upto 52MHz */
>>>>      if (ios->clock <= 52000000)
>>>> @@ -303,6 +308,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>>      if (ios->timing == MMC_TIMING_UHS_SDR50 && !(reg & CAPA2_TSDR50))
>>>>              return 0;
>>>>
>>>> +    thermal_dev = thermal_zone_get_zone_by_name("cpu_thermal");
>>>> +    if (IS_ERR(thermal_dev)) {
>>>> +            dev_err(dev, "Unable to get thermal zone for tuning\n");
>>>> +            return PTR_ERR(thermal_dev);
>>>> +    }
>>>
>>> Can't we get thermal zone once during probe?
>>>
>>
>> Tuning is also (ideally) supposed to happen only once per enumeration.
>> Also it doesn't make sense to get a thermal zone for lower speed systems
>> that won't do tuning.
> 
> Currently sdhci-omap calls pm_runtime_get_sync() during probe, and
> then keeps the host device runtime resumed until ->remove() is called
> on it. I assume you are going to change that, at some point!?
> 
> In other words, what will happen to the host device when it becomes
> runtime suspended? Is re-tuning needed when it gets runtime resumed,
> which is the case for many other sdhci variants?

There are no plans to support runtime_suspend()/resume() any time in the
near future. If its ok with you, I would like to get this patch in
without any changes. We can change it in case a need for
runtime_suspend()/_resume() does arise.

Thanks,
Faiz
