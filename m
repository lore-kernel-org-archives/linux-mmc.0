From: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3 1/2] Documentation: mmc: sdhci-of-arasan: add
 description of power domain
Date: Tue, 20 Sep 2016 10:29:44 +0800
Message-ID: <1ec66aea-10b4-4208-369e-9ef5feb800df@rock-chips.com>
References: <20160917023250.1159-1-xzy.xu@rock-chips.com>
 <20160917023250.1159-2-xzy.xu@rock-chips.com>
 <CAPDyKFrgdsppLg9RkCsSh4nhjUiJR6D4u+E8qnzfbtNxhwLOmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFrgdsppLg9RkCsSh4nhjUiJR6D4u+E8qnzfbtNxhwLOmw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, zhangqing <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

hi Ulf,


On 2016年09月17日 16:49, Ulf Hansson wrote:
> On 17 September 2016 at 04:32, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> Add power domain as a optional property for sdhci-of-arasan, which can
>> be turned off in the so-called unused condition, such as suspend and
>> remove. Aim to lower power requirements.
> I assume runtime suspend make sense as well?

Sorry to reply this mail after a long time.

On rk3399 platform, there is a eMMC-phy which is in charge of eMMC's 
logic interface. We should guarantee that phy is ready before cmd/data 
transfer.
I mean that I need to consider about the resume latency, so that I can 
land RPM for arasan-of-sdhci.
I intend to use auto-suspend for arasan-of-sdhci.

>
> Moreover, perhaps you could share a little information here about what
> needs to be done at the driver level which controls the mmc IP. More
> precisely, what do you need to do at runtime_suspend, suspend,
> runtime_resume, and resume?

Invoke sdhci_runtime_suspend_host, disable relevant clock in 
rumtime_suspend, deprocessing in runtime_resume.
Is that ok?

>
> Kind regards
> Uffe
>
>> Signed-off-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>
>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> ---
>>
>> Changes in v3:
>> - fix a typo
>> - add Rob's ack-tag
>>
>> Changes in v2:
>> - fix a typo
>> - add an example code for power-domain
>>
>>   Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index 3404afa..eb84d29 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -1,12 +1,14 @@
>>   Device Tree Bindings for the Arasan SDHCI Controller
>>
>> -  The bindings follow the mmc[1], clock[2], interrupt[3] and phy[4] bindings.
>> +  The bindings follow the mmc[1], clock[2], interrupt[3], phy[4] and power
>> +  domain[5] bindings.
>>     Only deviations are documented here.
>>
>>     [1] Documentation/devicetree/bindings/mmc/mmc.txt
>>     [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
>>     [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>     [4] Documentation/devicetree/bindings/phy/phy-bindings.txt
>> +  [5] Documentation/devicetree/bindings/power/power_domain.txt
>>
>>   Required Properties:
>>     - compatible: Compatibility string.  One of:
>> @@ -36,6 +38,8 @@ Optional Properties:
>>     - #clock-cells: If specified this should be the value <0>.  With this property
>>       in place we will export a clock representing the Card Clock.  This clock
>>       is expected to be consumed by our PHY.  You must also specify
>> +  - power-domains: A phandle and PM domain as specifier defined by bindings
>> +    of the power controller specified by phandle.
>>
>>   Example:
>>          sdhci@e0100000 {
>> @@ -71,5 +75,6 @@ Example:
>>                  phys = <&emmc_phy>;
>>                  phy-names = "phy_arasan";
>>                  #clock-cells = <0>;
>> +               power-domains = <&power RK3399_PD_EMMC>;
>>                  status = "disabled";
>>          };
>> --
>> 2.9.2
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
