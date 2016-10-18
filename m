From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] MAINTAINERS: mmc: Move the mmc tree to kernel.org
Date: Tue, 18 Oct 2016 12:08:45 +0800
Message-ID: <78f0352f-70a5-a836-c8df-6c4a02182c6e@rock-chips.com>
References: <1476708880-5333-1-git-send-email-ulf.hansson@linaro.org>
 <CGME20161018032019epcas1p339476a8014f5769ac897f4c1198fa3c4@epcas1p3.samsung.com>
 <e4cfb009-07a3-972c-d93c-d777c5da3899@rock-chips.com>
 <beed04c1-ba03-445f-5394-d294a98bf45d@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:48786 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbcJREI7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 00:08:59 -0400
In-Reply-To: <beed04c1-ba03-445f-5394-d294a98bf45d@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

ÔÚ 2016/10/18 11:52, Jaehoon Chung Ð´µÀ:
> On 10/18/2016 12:19 PM, Shawn Lin wrote:
>> Hi Ulf,
>>
>> On 2016/10/17 20:54, Ulf Hansson wrote:
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  MAINTAINERS | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index a009e00..e685724 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -8164,7 +8164,7 @@ F:    include/linux/mfd/
>>>  MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
>>>  M:    Ulf Hansson <ulf.hansson@linaro.org>
>>>  L:    linux-mmc@vger.kernel.org
>>> -T:    git git://git.linaro.org/people/ulf.hansson/mmc.git
>>> +T:    git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
>>
>> I cannot clone this tree, and I have tried some of my servers, although.
>>
>> remote: Total 5031043 (delta 4225582), reused 5030965 (delta 4225531)
>> Resolving deltas: 100% (4225582/4225582), done.
>> Checking connectivity... done.
>> warning: remote HEAD refers to nonexistent ref, unable to checkout.
>
> you have to checkout to "next"

yep, it does need to assign a HEAD blob after cloning.
But I never did it when cloning other maintainers' tree.

Thanks.

> e.g) git checkout next
>
> Best Regards,
> Jaehoon Chung
>
>>
>> ...then the clone process failed.
>>
>>>  S:    Maintained
>>>  F:    Documentation/devicetree/bindings/mmc/
>>>  F:    drivers/mmc/
>>>
>>
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

