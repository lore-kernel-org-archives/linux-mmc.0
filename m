From: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Documentation: mmc: sdhci-of-arasan: add
 description of power domain
Date: Sat, 17 Sep 2016 10:18:09 +0800
Message-ID: <d0855b38-2dd3-826b-9624-4ec1c2d00b07@rock-chips.com>
References: <20160908064905.18080-1-xzy.xu@rock-chips.com>
 <20160908064905.18080-2-xzy.xu@rock-chips.com>
 <20160916152535.GA6020@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160916152535.GA6020@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Rob,


On 2016年09月16日 23:25, Rob Herring wrote:
> On Thu, Sep 08, 2016 at 02:49:04PM +0800, Ziyuan Xu wrote:
>> Add power domain as a optional property for sdhci-of-arasan, which can
>> be truned off in the so-called unused condition, such as suspend and
> s/truned/turned/
>
>> remove. Aim to lower power requirements.
>>
>> Signed-off-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>
>> ---
>>
>> Changes in v2:
>> - fix a typo
>> - add an example code for power-domain
>>
>>   Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
> With that,
>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks, Rob. I fill fix it and send a follow up patch with your tag.

>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
>
>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
