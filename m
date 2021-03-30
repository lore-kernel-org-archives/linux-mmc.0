Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDCDC433C1
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 14:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026AC619CD
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 14:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhC3Obq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Mar 2021 10:31:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15047 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhC3Obh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2021 10:31:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8sJS5cl0zPmpK;
        Tue, 30 Mar 2021 22:28:56 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.252) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 22:31:25 +0800
Subject: Re: [PATCH] mmc: dw_mmc-k3: use the correct HiSilicon copyright
To:     Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>
References: <1617086448-51054-1-git-send-email-fanghao11@huawei.com>
 <CAPDyKFoUUu=Rb0pHMZb+gKXPsKESBnXG=4U=n_XFMZJLHyY7kA@mail.gmail.com>
 <20210330134323.GA3700@duo.ucw.cz>
CC:     Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>
From:   "fanghao (A)" <fanghao11@huawei.com>
Message-ID: <dabcbb05-2d5a-f32e-a725-3dbc51c2f0d5@huawei.com>
Date:   Tue, 30 Mar 2021 22:31:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210330134323.GA3700@duo.ucw.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.252]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 2021/3/30 21:43, Pavel Machek wrote:
> Hi!
>
>> On Tue, 30 Mar 2021 at 08:43, Hao Fang <fanghao11@huawei.com> wrote:
>>>
>>> s/Hisilicon/HiSilicon/g.
>>> It should use capital S, according to
>>> https://www.hisilicon.com/en/terms-of-use.
>>>
>>> Signed-off-by: Hao Fang <fanghao11@huawei.com>
>
>>>  /*
>>>   * Copyright (c) 2013 Linaro Ltd.
>>> - * Copyright (c) 2013 Hisilicon Limited.
>>> + * Copyright (c) 2013 HiSilicon Limited.
>>
>> This change looks really silly to me, but I am not a lawyer - so I
>> can't tell if this makes sense or not.
>>
>> In any case, "Hisilicon" is being used all over the kernel - do you
>> intend to patch all places with similar changes like this one? Perhaps
>> just send a big tree-wide-patch instead and see what people think?
>
> Plus, I'd expect authors to submit changes to copyright notices.
>

Just add Reviewed-by or Acked-by! Thanks.

> Best regards,
> 								Pavel
>

