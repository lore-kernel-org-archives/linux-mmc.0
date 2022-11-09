Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E6FC433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 13:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiKINXA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 08:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKINW7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 08:22:59 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DD6FAE3
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 05:22:57 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6ltC1x9SzpWCr;
        Wed,  9 Nov 2022 21:19:15 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 21:22:55 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 21:22:55 +0800
Subject: Re: [PATCH v3 2/3] mmc: sdio: fix of node refcount leak in
 sdio_add_func()
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <yangyingliang@huawei.com>
References: <20221109025142.1565445-1-yangyingliang@huawei.com>
 <20221109025142.1565445-3-yangyingliang@huawei.com>
 <CAPDyKFrcguZWaFd51Bk-xkkVHEWG5gTVKfVHLpc2KuF06hfFug@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <774718be-ad03-8bf1-630c-a933b877cb72@huawei.com>
Date:   Wed, 9 Nov 2022 21:22:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrcguZWaFd51Bk-xkkVHEWG5gTVKfVHLpc2KuF06hfFug@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 2022/11/9 20:27, Ulf Hansson wrote:
> On Wed, 9 Nov 2022 at 03:53, Yang Yingliang <yangyingliang@huawei.com> wrote:
>> If device_add() returns error in sdio_add_func(), sdio function is not
>> presented, so the node refcount that hold in sdio_set_of_node() can not
>> be put in sdio_remove_func() which is called from error path. Fix this
>> by moving of_node_put() before present check in remove() function.
>>
>> Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/mmc/core/sdio_bus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
>> index babf21a0adeb..266639504a94 100644
>> --- a/drivers/mmc/core/sdio_bus.c
>> +++ b/drivers/mmc/core/sdio_bus.c
>> @@ -377,11 +377,11 @@ int sdio_add_func(struct sdio_func *func)
>>    */
>>   void sdio_remove_func(struct sdio_func *func)
>>   {
>> +       of_node_put(func->dev.of_node);
>>          if (!sdio_func_present(func))
>>                  return;
>>
>>          device_del(&func->dev);
>> -       of_node_put(func->dev.of_node);
>>          put_device(&func->dev);
> Seems like we should call put_device() even if sdio_func_present()
> returns false, don't you think?
>
> In this way, the corresponding sdio_release_func() will help to manage
In sdio_release_func(), sdio_free_fun_cis() is called, it put refcount of
'func->card->dev', but the refcount isn't get until sdio_init_func()
is successful. In this way, it's no need to put refcount of 
'func->card->dev',
so we can not call sdio_release_func() in patch1, and patch1 is needed.

Thanks,
yang
> the cleanup for us, so patch1 can be dropped. Or is there a problem
> with that?
>
> Kind regards
> Uffe
> .
