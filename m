From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [RFC PATCH v1] mmc: sdhci-of-arasan: Add the support for
 sdhci-5.1
Date: Tue, 18 Aug 2015 07:40:47 +0800
Message-ID: <55D270FF.5030309@rock-chips.com>
References: <1439279190-9556-1-git-send-email-shawn.lin@rock-chips.com>
 <55CA0C6F.7000002@xilinx.com> <55CAD499.5070701@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55CAD499.5070701-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On 2015/8/12 13:07, Michal Simek wrote:
> +linux-mmc
>
> On 08/11/2015 04:53 PM, Michal Simek wrote:
>> On 08/11/2015 09:46 AM, Shawn Lin wrote:
>>> This patch adds the compatible string in sdhci-of-arasan.c to
>>> support sdhci-arasan5.1 version of controller. No documented
>>> controller IP version is found in the TRM, so we use ths version
>>> of command queueing engine integrated into this controller by arasan
>>> to specify our controller.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>
>>> ---
>>>
>>> Changes in v1:
>>> - Remove redundant SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN for "arasan, sdhci-5.1" since
>>>    SDHCI will check "host->max_clk == 0" and let driver get it from host->ops->get_max_clock.
>>>
>>>   Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 2 +-
>>>   drivers/mmc/host/sdhci-of-arasan.c                     | 1 +
>>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> index 7e94903..da541c3 100644
>>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> @@ -9,7 +9,7 @@ Device Tree Bindings for the Arasan SDHCI Controller
>>>
>>>   Required Properties:
>>>     - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
>>> -                'arasan,sdhci-4.9a'
>>> +                'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
>>>     - reg: From mmc bindings: Register location and length.
>>>     - clocks: From clock bindings: Handles to clock inputs.
>>>     - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>>> index ef5a7d2..75379cb 100644
>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>> @@ -217,6 +217,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>>>
>>>   static const struct of_device_id sdhci_arasan_of_match[] = {
>>>   	{ .compatible = "arasan,sdhci-8.9a" },
>>> +	{ .compatible = "arasan,sdhci-5.1" },
>>>   	{ .compatible = "arasan,sdhci-4.9a" },
>>>   	{ }
>>>   };
>>>
>>
>> Acked-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

Could you pull this patch into your repository?

>>
>> Thanks,
>> Michal
>>
>>
>
>
>
>


-- 
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
