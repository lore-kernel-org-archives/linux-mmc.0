From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/3] Document: dw_mmc-k3: add document of hi6220 mmc
Date: Thu, 14 May 2015 07:17:05 +0900
Message-ID: <5553CD61.6090000@samsung.com>
References: <1430985401-12202-1-git-send-email-zhangfei.gao@linaro.org>
 <1430985401-12202-2-git-send-email-zhangfei.gao@linaro.org>
 <5551AD7E.2050200@samsung.com> <5551B2E7.4030306@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47757 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbbEMWRJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 May 2015 18:17:09 -0400
In-reply-to: <5551B2E7.4030306@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

On 05/12/2015 04:59 PM, zhangfei wrote:
> 
> 
> On 05/12/2015 03:36 PM, Jaehoon Chung wrote:
>> Hi, Zhangfei.
>>
>> On 05/07/2015 04:56 PM, Zhangfei Gao wrote:
>>> Add bindings for hi6220 mmc support
>>>
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> ---
>>>   .../devicetree/bindings/mmc/k3-dw-mshc.txt         | 28 ++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>>> index 3b35449..df37058 100644
>>> --- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>>> @@ -13,6 +13,10 @@ Required Properties:
>>>
>>>   * compatible: should be one of the following.
>>>     - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extensions.
>>> +  - "hisilicon,hi6220-dw-mshc": for controllers with hi6220 specific extensions.
>>> +
>>> +Optional Properties:
>>> +- hisilicon,peripheral-syscon: phandle of syscon used to control peripheral.
>>>
>> I'm not sure..
>> but i think this patch could be added just the compatible and optional properties descriptions.
>> If SoC will be added, it need not to add every example, doesn't it?
>>
>> how about removing the below example? This is just my opinion. :)
>> If there is a special reason that add example...let me know, plz.
> 
> I am adding this example just for two reasons
> 
> 1. There is still some components need to be upstreamed before we add to dts, like pinctrl and regulator, which still need some time.
> So add here for quick reference after the component is enabled.
> Had experience before that hip04_eth is merged but dts is delayed, thanks to the document, we can add it quickly.
> 
> 2. sd has some special requirement of "hisilicon,peripheral-syscon", which used for controlling voltage
> 
> 
> What do you think?

Thanks for kindly explanation! I understood your intention.

Best Regards,
Jaehoon Chung

> 
> Thanks
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

