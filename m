From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: dw_mmc: Fix card detection regression
Date: Wed, 15 Jan 2014 15:24:05 +0530
Message-ID: <CAK9yfHwCxc2X4Q+xHFd_Xy3cQjMzNdxVrvgbpVjYijaOad+GBw@mail.gmail.com>
References: <1389774667-18309-1-git-send-email-sachin.kamat@linaro.org>
	<52D649C3.4020003@linaro.org>
	<CAK9yfHzZo82oN5+UiXzo47190JKiVwwEh8ikTfz_==_A1PdNLA@mail.gmail.com>
	<52D6584E.2020606@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:50192 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbaAOJyH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 04:54:07 -0500
Received: by mail-ob0-f170.google.com with SMTP id uy5so898807obc.15
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2014 01:54:05 -0800 (PST)
In-Reply-To: <52D6584E.2020606@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, chris@printf.net, Seungwon Jeon <tgih.jun@samsung.com>, Patch Tracking <patches@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>

On 15 January 2014 15:13, zhangfei <zhangfei.gao@linaro.org> wrote:
>
>
> On 01/15/2014 05:39 PM, Sachin Kamat wrote:
>>>
>>> Thanks for the patch
>>> I just submitted one patch to fix the issue, in case you missed it.
>>
>>
>> Yes I did as I am not subscribed to mmc list.
>>
>>> Also spin_lock is required for atomic accessing DW_MMC_CARD_PRESENT.
>>> Otherwise sd detect may be failed sometimes.
>>>
>>> Could you help take a look.
>>
>>
>> I looked at and tested your patch [1] (which is similar to mine except
>> for the locking part).
>>
>> Since I do not have your patch in my mailbox, FWIW,
>>
>> Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Tested-by: Sachin Kamat <sachin.kamat@linaro.org>
>
>
> Thanks Sachin,  that's great it works, all my mistake.
> Then I resumit the patch with this and cc you.

If you are planning to re-submit, then you may please consider
revising the commit message as follows:

s/Introdeced/Introduced
Please provide patch title after the commit Id in braces ("<patch title>").
s/ingored/ignored

You may also elaborate on why IS_ERR_VALUE(!mmc_gpio_get_cd(mmc)) does not work.

-- 
With warm regards,
Sachin
