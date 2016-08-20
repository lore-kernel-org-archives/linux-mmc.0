From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Support module reset
Date: Sat, 20 Aug 2016 14:46:32 +0300
Message-ID: <89bf1523-ee9c-48c8-3ab8-e7e4361927de@gmail.com>
References: <20160819140003.22608-1-thierry.reding@gmail.com>
 <5bb05c13-9813-6b19-3a22-77502ff3ffa6@gmail.com>
 <20160820102938.GA27552@mithrandir.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160820102938.GA27552-+E7KM1FDEuO2P7RxrfNFTMXXUOn6P5/W@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 20.08.2016 13:29, Thierry Reding wrote:
> On Fri, Aug 19, 2016 at 05:44:32PM +0300, Dmitry Osipenko wrote:
>> On 19.08.2016 17:00, Thierry Reding wrote:
>>> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>
>>> The device tree binding for the SDHCI controller found on Tegra SoCs
>>> specifies that a reset control can be provided by the device tree. No
>>> code was ever added to support the module reset, which can cause the
>>> driver to try and access registers from a module that's in reset. On
>>> most Tegra SoC generations doing so would cause a hang.
>>>
>>> Note that it's unlikely to see this happen because on most platforms
>>> these resets will have been deasserted by the bootloader. However the
>>> portability can be improved by making sure the driver deasserts the
>>> reset before accessing any registers.
>>>
>>> Since resets are synchronous on Tegra SoCs, the platform driver needs
>>> to implement a custom ->remove() callback now to make sure the clock
>>> is disabled after the reset is asserted.
>>>
>>> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  drivers/mmc/host/sdhci-tegra.c | 38 +++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 37 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>>> index 1e93dc4e303e..4c29a64721aa 100644
>>> --- a/drivers/mmc/host/sdhci-tegra.c
>>> +++ b/drivers/mmc/host/sdhci-tegra.c
>>> @@ -21,6 +21,7 @@
>>>  #include <linux/io.h>
>>>  #include <linux/of.h>
>>>  #include <linux/of_device.h>
>>> +#include <linux/reset.h>
>>>  #include <linux/mmc/card.h>
>>>  #include <linux/mmc/host.h>
>>>  #include <linux/mmc/mmc.h>
>>> @@ -65,6 +66,8 @@ struct sdhci_tegra {
>>>  	struct gpio_desc *power_gpio;
>>>  	bool ddr_signaling;
>>>  	bool pad_calib_required;
>>> +
>>> +	struct reset_control *rst;
>>>  };
>>>  
>>>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
>>> @@ -464,6 +467,16 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>>>  	clk_prepare_enable(clk);
>>>  	pltfm_host->clk = clk;
>>>  
>>> +	tegra_host->rst = devm_reset_control_get(&pdev->dev, "sdhci");
>>> +	if (IS_ERR(tegra_host->rst)) {
>>> +		rc = PTR_ERR(tegra_host->rst);
>>> +		dev_err(&pdev->dev, "failed to get reset control: %d\n", rc);
>>> +		goto err_clk_get;
>>> +	}
>>> +
>>> +	reset_control_deassert(tegra_host->rst);
>>
>> Why just not to do a proper reset here? You won't need a custom .remove then.
> 
> We could do a proper reset here, although the Tegra CAR driver currently
> doesn't implement it. I'm also not sure whether we can implement it
> safely because not all resets use the same sequence.
> 
> That said, we could do a manual assert/sleep/deassert cycle here, just
> to be on the safe side.
> 
> Also, the custom ->remove() implementation is still necessary to make
> sure that the device is held in reset after the driver's unloaded. It
> isn't strictly necessary to do that because disabling the clock might
> be enough to stop the hardware block from consuming power in most
> cases, but I think it's good practice to do so anyway, if for nothing
> else than force the next driver to deassert the reset and hence start
> from pristine hardware state.
> 

Couldn't that make more bad than good, given that it's not a proper reset sequence?

>>> +	usleep_range(2000, 4000);
>>> +
>>
>> Is this sleep after deassertion really needed?
> 
> Yeah, I think it is. There are various bits of documentation that
> suggest that a delay of at least a few microseconds is needed. 2 to 4
> milliseconds is probably a little excessive, but this isn't in a time
> critical path anyway, and the large sleep avoids any potential subtle
> timing issue. It's also in line with what other drivers do.
> 

Okay

> Thierry
> 


-- 
Dmitry
