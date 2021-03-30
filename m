Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F98C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 14:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4CB361874
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 14:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhC3O1Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Mar 2021 10:27:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14646 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhC3O1S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2021 10:27:18 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8sCT2bm6znVl6;
        Tue, 30 Mar 2021 22:24:37 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.252) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 22:27:06 +0800
Subject: Re: [PATCH] mmc: dw_mmc-k3: use the correct HiSilicon copyright
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <1617086448-51054-1-git-send-email-fanghao11@huawei.com>
 <CAPDyKFoUUu=Rb0pHMZb+gKXPsKESBnXG=4U=n_XFMZJLHyY7kA@mail.gmail.com>
CC:     Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>
From:   "fanghao (A)" <fanghao11@huawei.com>
Message-ID: <c5284747-95dd-a4d5-0027-4da09bb56117@huawei.com>
Date:   Tue, 30 Mar 2021 22:27:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoUUu=Rb0pHMZb+gKXPsKESBnXG=4U=n_XFMZJLHyY7kA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.252]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 2021/3/30 18:38, Ulf Hansson wrote:
> On Tue, 30 Mar 2021 at 08:43, Hao Fang <fanghao11@huawei.com> wrote:
>>
>> s/Hisilicon/HiSilicon/g.
>> It should use capital S, according to
>> https://www.hisilicon.com/en/terms-of-use.
>>
>> Signed-off-by: Hao Fang <fanghao11@huawei.com>
>> ---
>>  drivers/mmc/host/dw_mmc-k3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
>> index 29d2494..0311a37 100644
>> --- a/drivers/mmc/host/dw_mmc-k3.c
>> +++ b/drivers/mmc/host/dw_mmc-k3.c
>> @@ -1,7 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * Copyright (c) 2013 Linaro Ltd.
>> - * Copyright (c) 2013 Hisilicon Limited.
>> + * Copyright (c) 2013 HiSilicon Limited.
>
> This change looks really silly to me, but I am not a lawyer - so I
> can't tell if this makes sense or not.
>
> In any case, "Hisilicon" is being used all over the kernel - do you
> intend to patch all places with similar changes like this one? Perhaps
> just send a big tree-wide-patch instead and see what people think?
>

Although HiSilicon has applied for two trademarks Hisilicon/HiSilicon,
there is only one English name for the company. We have consulted with
company's lawyer who suggested that should use a copyright statement
consistent with the official website.

Though the kernel has tons of "Hisilicon", I just fix the copyright,
and plan to send a commit to each subsystem where is uncorrect. Fortunately,
there are not many modules that have the problem, this is one of them.

Thanks.

Hao

>>   */
>>
>>  #include <linux/bitops.h>
>
> Kind regards
> Uffe
>
> .
>

