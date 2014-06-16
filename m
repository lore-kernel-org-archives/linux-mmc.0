From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv7 2/2] ARM: dts: unuse the slot-node and deprecated
 supports-highspeed for dw-mmc.
Date: Mon, 16 Jun 2014 16:47:05 +0900
Message-ID: <539EA0F9.60508@samsung.com>
References: <1402633867-25155-1-git-send-email-jh80.chung@samsung.com>
 <1402633867-25155-3-git-send-email-jh80.chung@samsung.com>
 <CAPDyKFr46gaAnZc34ELv4GYaK+XjuiAcewTmgJU=iyC3WgxWVg@mail.gmail.com>
 <CAELcNGSOV2GD_uLO5HHuJgN2_pNoXtFrCmbPJh4RGc2pEaaYUA@mail.gmail.com>
 <CAPDyKFo18wi-kZHsoF4k_U9G8jK9maRj0DNs=3ciqUuDfxAHcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:39144 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbaFPHrK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 03:47:10 -0400
In-reply-to: <CAPDyKFo18wi-kZHsoF4k_U9G8jK9maRj0DNs=3ciqUuDfxAHcw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Heiko St.bner" <heiko@sntech.de>, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, Tushar Behera <tushar.behera@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 06/16/2014 03:56 PM, Ulf Hansson wrote:
> On 13 June 2014 15:31, Jae hoon Chung <jh80.chung@gmail.com> wrote:
>> Hi, Ulf.
>>
>>
>> 2014-06-13 20:14 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>>
>>> On 13 June 2014 06:31, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>> dw-mmc controller can support multiple slots.
>>>> But, there are no use-cases anywhere. So we don't need to support the
>>>> slot-node for dw-mmc controller.
>>>> And "supports-highspeed" property in dw-mmc is deprecated.
>>>> "supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
>>>
>>> This looks good to me.
>>>
>>> Though, you need to help me understand how to handle this patch.
>>>
>>> 1) Is it to consider as a fix for 3.16?
>>
>> Right..It's related with "mmc: dw_mmc: use the mmc_of_parse() instead of
>> local parser"
>> DW-MMC didn't parse the subnode, so it didn't set to correct bus-width.
>>
>>> 2 ) I am not sure if there are a dependency to patch 1 - if not this
>>> patch is better suited for ARM SoC.
>>
>> It's not a dependency on patch 1.
>> Let me know how i do, plz.
> 
> I would suggest you to re-send it to the ARM lits and the ARM SoC guys
> and keeping the respective SoC maintainer on the to list of course.
> 
> Add a note that it's intended as fix for 3.16 and you may also add my
> reviewed by tag.
Ok. I will resend the patch..Thanks

Best Regards,
Jaehoon Chung
> 
> Kind regards
> Uffe
> 

