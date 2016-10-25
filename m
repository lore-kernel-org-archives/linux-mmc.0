From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC v2 2/2] mmc: sdhci: Ignore capability register when it comes
 to speeds and use DT binding instead when sdhci-cap-speed-modes-broken is
 set.
Date: Tue, 25 Oct 2016 14:30:25 +0300
Message-ID: <d65f018e-b20e-9e87-fc07-eb2fb4b5079e@intel.com>
References: <1477085715-30213-1-git-send-email-zach.brown@ni.com>
 <1477085715-30213-3-git-send-email-zach.brown@ni.com>
 <d4547457-036a-dbb7-ddb8-b839e04949b7@intel.com>
 <20161024154820.GA16144@zach-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161024154820.GA16144@zach-desktop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 24/10/16 18:48, Zach Brown wrote:
> On Mon, Oct 24, 2016 at 10:34:46AM +0300, Adrian Hunter wrote:
>> On 22/10/16 00:35, Zach Brown wrote:
>>> When the sdhci-cap-speed-modes-broken DT property is set, the driver
>>> will ignore the bits of the capability registers that correspond to
>>> speed modes.
>>>
>>> Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 1e25b01..59c62d3 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -22,6 +22,7 @@
>>>  #include <linux/scatterlist.h>
>>>  #include <linux/regulator/consumer.h>
>>>  #include <linux/pm_runtime.h>
>>> +#include <linux/of.h>
>>>
>>>  #include <linux/leds.h>
>>>
>>> @@ -3013,10 +3014,19 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
>>>
>>>  	host->caps = caps ? *caps : sdhci_readl(host, SDHCI_CAPABILITIES);
>>>
>>> +	if (of_property_read_bool(mmc_dev(host->mmc)->of_node,
>>> +				  "sdhci-cap-speed-modes-broken"))
>>
>> It rather begs the question: if you are going to do something sdhci
>> specific, why not just read the whole of the caps register from DT?
>>
> 
> Throwing out the whole of the caps register seems like overkill. Also

What about 2 values: one for the 64-bit caps register and one for a 64-bit
mask of bits to override.  That way you can select which bits to override
and what to override them to.

> there are some things set by the caps that are not available in the DT.
> For example, SDHCI_CAN_64BIT is set by the cap register and is used in
> sdhci_setup_host to set host->flags SDHCI_USE_64_BIT_DMA.

Not sure what you mean.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
