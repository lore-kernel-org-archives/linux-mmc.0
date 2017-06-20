From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 19/21] dt-bindings: mmc: dw_mmc-k3: add document of
 hi3660 mmc
Date: Tue, 20 Jun 2017 10:36:53 +0200
Message-ID: <CAPDyKFo=hqp=j=nWpO8uf_0pGTSKjN0T-ZKqD8cuKp1C3Q2_hA@mail.gmail.com>
References: <20170614082338.15673-1-guodong.xu@linaro.org> <20170614082338.15673-20-guodong.xu@linaro.org>
 <CAPDyKFpvJu8_TETWr0Vy4ubDC7NYvi7TxmSLYZyw33qHFsoNaQ@mail.gmail.com> <5947CAD8.4040607@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5947CAD8.4040607-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: Guodong Xu <guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Wei <liwei213>
List-Id: linux-mmc@vger.kernel.org

Hi Wei,

On 19 June 2017 at 15:00, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org> wrote:
> Hi Ulf,
>
> On 2017/6/19 13:43, Ulf Hansson wrote:
>> On 14 June 2017 at 10:23, Guodong Xu <guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>> Add bindings for hi3660 mmc support
>>>
>>> Signed-off-by: Li Wei <liwei213-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>> Signed-off-by: Guodong Xu <guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>>> index df37058..8af1afc 100644
>>> --- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>>> @@ -12,6 +12,7 @@ extensions to the Synopsys Designware Mobile Storage Host Controller.
>>>  Required Properties:
>>>
>>>  * compatible: should be one of the following.
>>> +  - "hisilicon,hi3660-dw-mshc": for controllers with hi3660 specific extensions.
>>>    - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extensions.
>>>    - "hisilicon,hi6220-dw-mshc": for controllers with hi6220 specific extensions.
>>>
>>> --
>>> 2.10.2
>>>
>>
>> Thanks, applied for next!
>
> Thanks!
> Last week I had applied the v4 patch set[1]
> and this patch is included.
> But it should be fine for the upper gatekeeper to merge
> since these 2 patch are same.

No, that's not how git works.

If the patch has the same hash, that would be fine, but that isn't the
case here as we have two different hashes for the same change.

To deal with this, I have just dropped the change from my tree and
leave it to you to carry the patch. Feel free to add my ack for it.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
