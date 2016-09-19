From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: mmc: dw_mmc: log spamming
Date: Mon, 19 Sep 2016 16:33:55 +0900
Message-ID: <6dd25843-3852-b059-4c42-6c720887db38@samsung.com>
References: <CGME20160915172951epcas1p13022fec9254b5903b353dff6398cbcae@epcas1p1.samsung.com>
 <57DADA85.2000200@math.uni-bielefeld.de>
 <a36ad9ba-1758-7048-d8b8-e3d85862ff08@samsung.com>
 <57DF396E.9050503@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56450 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932533AbcISHd6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2016 03:33:58 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0ODQ02DSKQCJKW90@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 19 Sep 2016 16:33:55 +0900 (KST)
In-reply-to: <57DF396E.9050503@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: sw0312.kim@samsung.com
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Tobias,

CC'd mmc mailing.

On 09/19/2016 10:03 AM, Seung-Woo Kim wrote:
> Hello Jaehoon,
> 
> On 2016년 09월 19일 09:32, Jaehoon Chung wrote:
>> Hi Tobias,
>>
>> On 09/16/2016 02:29 AM, Tobias Jakobi wrote:
>>> Hello everyone,
>>>
>>> I'm experiencing massive kernel log spamming by dw_mmc, the commit that
>>> causes this is the following one.
>>>
>>> 65257a0deed5aee66b4e3708944f0be62a64cabc
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=65257a0deed5aee66b4e3708944f0be62a64cabc
>>>
>>> I've briefly checked the commit and I think the rationale behind
>>> removing the check is incorrect. While MMC_CLKGATE was certainly
>>> removed, runtime PM has "replaced" it (the commit
>>> 9eadcc0581a8ccaf4c2378aa1c193fb164304f1d even mentions this).
>>>
>>> This is on an Exynos4412 board, kernel is 4.8-rc6. Nothing is connected
>>> to the eMMC connector.
>>
>> Thanks for reporting this.
>>
>> Seung-Woo, Could you check your patch? I will also check this.

Did you test after reverting this commit? or previous version is working fine?
Which exynos4412 board do you use? I think it's related with "broken-cd".
(If you can share which board and dts you are using, we can check in more detail.)

As you mentioned, you didn't insert the eMMC card on board.
Then it should be polling whether card is inserted/removed. (If broken-cd is set...)

I think it's not related with runtime PM.

Best Regards,
Jaehoon Chung

> 
> Ok, I will check on Exynos4412 SpC boards.
> 
> By the way, to check no condition case, when I posted after v2[1], I
> checked with Exynos5422 and Exynos5433 SoC boards and they didn't show
> duplicated log, so I agreed not to check condition for logging.
> 
> [1] https://patchwork.kernel.org/patch/9182469/
> 
> Best Regards,
> - Seung-Woo Kim
> 
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> With best wishes,
>>> Tobias
>>>
>>>
>>>
>>
>>
>>
> 

