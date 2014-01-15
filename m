From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: dw_mmc: Fix card detection regression
Date: Wed, 15 Jan 2014 15:09:02 +0530
Message-ID: <CAK9yfHzZo82oN5+UiXzo47190JKiVwwEh8ikTfz_==_A1PdNLA@mail.gmail.com>
References: <1389774667-18309-1-git-send-email-sachin.kamat@linaro.org>
	<52D649C3.4020003@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38662 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbaAOJjD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 04:39:03 -0500
Received: by mail-ob0-f174.google.com with SMTP id wo20so873462obc.19
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2014 01:39:03 -0800 (PST)
In-Reply-To: <52D649C3.4020003@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, chris@printf.net, Seungwon Jeon <tgih.jun@samsung.com>, Patch Tracking <patches@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>

Hi Zhangfei,

On 15 January 2014 14:11, zhangfei <zhangfei.gao@linaro.org> wrote:
> Hi, Sachin
>
>
>
>
> On 01/15/2014 04:31 PM, Sachin Kamat wrote:
>>
>> mmc_gpio_get_cd returns a negative error value upon failure.
>> However gpio_cd was initialised with the negated return value
>> of the above function. This negation resulted in losing of the
>> error value thereby triggering the code to take a wrong path as
>> IS_ERR_VALUE(gpio_cd) now returned 0 even when mmc_gpio_get_cd
>> returned an error value. This issue introduced by commit bf626e5550f2
>> ("mmc: dw_mmc: use slot-gpio to handle cd pin") caused card detection
>> failure on Exynos5 boards which is now fixed by this patch.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> ---
>
>
> Thanks for the patch
> I just submitted one patch to fix the issue, in case you missed it.

Yes I did as I am not subscribed to mmc list.

> Also spin_lock is required for atomic accessing DW_MMC_CARD_PRESENT.
> Otherwise sd detect may be failed sometimes.
>
> Could you help take a look.

I looked at and tested your patch [1] (which is similar to mine except
for the locking part).

Since I do not have your patch in my mailbox, FWIW,

Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
Tested-by: Sachin Kamat <sachin.kamat@linaro.org>

[1] http://permalink.gmane.org/gmane.linux.kernel.mmc/24600
---
With warm regards,
Sachin
