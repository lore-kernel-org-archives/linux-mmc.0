From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-at91: set clocks and presets after
 resume from deepest PM
Date: Thu, 6 Jul 2017 10:59:41 +0300
Message-ID: <80b5ee91-fa5b-3196-2a19-c89be03a3bfa@intel.com>
References: <20170616072929.3266-1-quentin.schulz@free-electrons.com>
 <20170616072929.3266-2-quentin.schulz@free-electrons.com>
 <6acdfd61-afb8-e0cf-b8d3-b2e81bd71569@intel.com>
 <1989e4f4-6aed-563f-5750-51ddddeb4739@free-electrons.com>
 <20170620094943.j3qfjocjcjle6sqa@rfolt0960.corp.atmel.com>
 <b616ff3c-1f2d-4a81-33e9-845506d7af4e@free-electrons.com>
 <e48f0c5c-5b73-721b-194c-55dec4da89e8@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e48f0c5c-5b73-721b-194c-55dec4da89e8@free-electrons.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, alexandre.belloni@free-electrons.com, nicolas.ferre@microchip.com
List-Id: linux-mmc@vger.kernel.org

On 07/05/2017 09:45 AM, Quentin Schulz wrote:
> Better with the link.
> 
> On 05/07/2017 08:23, Quentin Schulz wrote:
>> Hi Adrian and Ludovic,
>>
>> On 20/06/2017 11:49, Ludovic Desroches wrote:
>>> On Tue, Jun 20, 2017 at 10:07:06AM +0200, Quentin Schulz wrote:
>>>> Hi Adrian,
>>>>
>>>> On 20/06/2017 09:39, Adrian Hunter wrote:
>>>>> On 16/06/17 10:29, Quentin Schulz wrote:
>>>>>> This adds deepest (Backup+Self-Refresh) PM support to the ATMEL SAMA5D2
>>>>>> SoC's SDHCI controller.
>>>>>>
>>>>>> When resuming from deepest state, it is required to restore preset
>>>>>> registers as the registers are lost since VDD core has been shut down
>>>>>> when entering deepest state on the SAMA5D2. The clocks need to be
>>>>>> reconfigured as well.
>>>>>>
>>>>>> The other registers and init process are taken care of by the SDHCI
>>>>>> core.
>>>>>>
>>>>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>>>>> ---
>>>>>>  drivers/mmc/host/sdhci-of-at91.c | 34 ++++++++++++++++++++++++++++++++--
>>>>>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
>>>>>> index fb8c6011f13d..300513fc1068 100644
>>>>>> --- a/drivers/mmc/host/sdhci-of-at91.c
>>>>>> +++ b/drivers/mmc/host/sdhci-of-at91.c
>>>>>> @@ -207,6 +207,37 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>>>>>>  }
>>>>>>  
>>>>>>  #ifdef CONFIG_PM
>>>>>
>>>>> Should be CONFIG_PM_SLEEP for suspend / resume callbacks.
>>>>>
>>>>
>>>> So I let this CONFIG_PM around the runtime_suspend/resume but put
>>>> another CONFIG_PM_SLEEP around the suspend/resume functions?
>>>>
>>>>>> +static int sdhci_at91_suspend(struct device *dev)
>>>>>> +{
>>>>>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>>>>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>> +	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	ret = sdhci_suspend_host(host);
>>>>>> +
>>>>>> +	if (host->runtime_suspended)
>>>>>> +		return ret;
>>>>>
>>>>> Suspending while runtime suspended seems like a bad idea.  Have you
>>>>> considered just adding sdhci_at91_set_clks_presets() to
>>>>> sdhci_at91_runtime_resume()?
>>>>>
>>>>
>>>> Adding sdhci_at91_set_clks_presets() to runtime_resume() seems a bad
>>>> idea as well. You don't need to recompute the clock rate, set it and set
>>>> the presets registers each time you do a runtime_resume. As the
>>>> runtime_pm of sdhci has a quite aggressive policy of activation, this
>>>> seems like a bad idea on the optimization side.

What is the runtime resume time with and without sdhci_at91_set_clks_presets()?

>>>
>>> So maybe increment/decrement the device's usage counter. It should be
>>> safer.
>>>
>>
>> From what I've understood from the runtime_pm documentation[1], it seems
>> that there is no need in my case to test if the system has been runtime
>> suspended before being suspended. So I think we can safely remove the
>> test and leave the rest as is.
>>
>> My understanding is the following:
>> If the system is not runtime suspended before doing suspend, then it
>> just does suspend and then resume.
>> => enable and disable clocks are called once each so it is balanced.
>>
>> If the system is already runtime suspended when suspending, the resume
>> will be called and once the device will be used, the runtime resume will
>> be called.
>> => enable and disable clocks are called twice each (once in runtime and
>> system suspend/resume) so it is balanced.
>>
>> A few quick tests on my sama5d2_xplained seem to be validating those
>> hypothesis.
>>
>> Do we agree on removing the `if (host->runtime_suspended)`?
>>
> 
> [1]
> http://elixir.free-electrons.com/linux/latest/source/Documentation/power/runtime_pm.txt#L613

In the future we may want to rationalize sdhci pm functions or make other
changes.  That means they must be used correctly.  In particular, they must
not be interleaved or nested. i.e. it is not acceptable to call
sdhci_suspend_host() in between calls to sdhci_runtime_suspend_host() and
sdhci_runtime_resume_host().

Also use pm_runtime_suspended() not host->runtime_suspended.

> 
>> Thanks,
>> Quentin
>>
>>> Ludovic
>>>
>>>>
>>>> Thanks,
>>>> Quentin
>>>>
>>>>>> +
>>>>>> +	clk_disable_unprepare(priv->gck);
>>>>>> +	clk_disable_unprepare(priv->hclock);
>>>>>> +	clk_disable_unprepare(priv->mainck);
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int sdhci_at91_resume(struct device *dev)
>>>>>> +{
>>>>>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	ret = sdhci_at91_set_clks_presets(dev);
>>>>>> +	if (ret)
>>>>>> +		return ret;
>>>>>> +
>>>>>> +	return sdhci_resume_host(host);
>>>>>> +}
>>>>>> +
>>>>>>  static int sdhci_at91_runtime_suspend(struct device *dev)
>>>>>>  {
>>>>>>  	struct sdhci_host *host = dev_get_drvdata(dev);
>>>>>> @@ -256,8 +287,7 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>>>>>>  #endif /* CONFIG_PM */
>>>>>>  
>>>>>>  static const struct dev_pm_ops sdhci_at91_dev_pm_ops = {
>>>>>> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>>>>>> -				pm_runtime_force_resume)
>>>>>> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_at91_suspend, sdhci_at91_resume)
>>>>>>  	SET_RUNTIME_PM_OPS(sdhci_at91_runtime_suspend,
>>>>>>  			   sdhci_at91_runtime_resume,
>>>>>>  			   NULL)
>>>>>>
>>>>>
>>>>
>>>> -- 
>>>> Quentin Schulz, Free Electrons
>>>> Embedded Linux and Kernel engineering
>>>> http://free-electrons.com
>>
> 
