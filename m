Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB47AC04FDF
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 18:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjHHSH2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbjHHSHG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 14:07:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 453565F87C
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 10:07:26 -0700 (PDT)
Received: from dggpemm500015.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKr5s50NFzrSPN;
        Tue,  8 Aug 2023 19:08:33 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 19:09:44 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 19:09:43 +0800
Subject: Re: [PATCH -next 0/4] mmc: remove unnecessary set_drvdata() function
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <yangyingliang@huawei.com>
References: <20230807141704.3486854-1-yangyingliang@huawei.com>
 <CAPDyKFpqZOSvZQ=8jLcsn3DHzo=i_-RugSdZOgos057gErc59Q@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <a35f1a62-6b0d-cfea-11b3-86bca8c15be0@huawei.com>
Date:   Tue, 8 Aug 2023 19:09:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpqZOSvZQ=8jLcsn3DHzo=i_-RugSdZOgos057gErc59Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 2023/8/8 19:01, Ulf Hansson wrote:
> On Mon, 7 Aug 2023 at 16:20, Yang Yingliang <yangyingliang@huawei.com> wrote:
>> The driver data will be set to NULL in device_unbind_cleanup() in driver
>> core code. So the set_drvdata(..., NULL) called in remove and error path
>> in probe can be removed.
>>
>> Yang Yingliang (4):
>>    mmc: via-sdmmc: remove unnecessary dev_set_drvdata()
>>    mmc: block: remove unnecessary dev_set_drvdata()
>>    mmc: moxart: remove unnecessary dev_set_drvdata()
>>    mmc: sunplus: remove unnecessary platform_set_drvdata()
>>
>>   drivers/mmc/core/block.c       | 1 -
>>   drivers/mmc/host/moxart-mmc.c  | 2 --
>>   drivers/mmc/host/sunplus-mmc.c | 1 -
>>   drivers/mmc/host/via-sdmmc.c   | 2 --
>>   4 files changed, 6 deletions(-)
> Can you please squash these trivial patches into one patch for mmc?
OK.

Thanks,
Yang
>
> Kind regards
> Uffe
> .
