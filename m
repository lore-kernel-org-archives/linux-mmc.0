Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D0C4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 07:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiKRHyB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiKRHyA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 02:54:00 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2778C08D
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 23:53:56 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ND8DB5px3z15MgZ;
        Fri, 18 Nov 2022 15:53:30 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 15:53:54 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 15:53:54 +0800
Subject: Re: [PATCH v4 0/2] mmc: sdio: fixes some leaks
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
References: <20221110025530.4106568-1-yangyingliang@huawei.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <cd06c6cc-fd5a-1fe4-9570-4266f34918cd@huawei.com>
Date:   Fri, 18 Nov 2022 15:53:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221110025530.4106568-1-yangyingliang@huawei.com>
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

Hi,

On 2022/11/10 10:55, Yang Yingliang wrote:
> This patchset fix a refcount leak and two memory leaks about
> SDIO function.
>
> v3 -> v4:
>    Drop patch1, keep calling put_device() to free memory,
>    set 'func->card' to NULL to avoid redundant put.
>
> v2 -> v3:
>    Change to call of_node_put() in remove() function to
>    fix node refcount leak.
>
> v1 -> v2:
>    Fix compile error in patch #2.
>
> Yang Yingliang (2):
>    mmc: sdio: fix of node refcount leak in sdio_add_func()
>    mmc: sdio: fix possible memory leak in some error path
>
>   drivers/mmc/core/sdio.c     | 1 +
>   drivers/mmc/core/sdio_bus.c | 6 +++---
>   drivers/mmc/core/sdio_cis.c | 3 ++-
>   3 files changed, 6 insertions(+), 4 deletions(-)
Is this look good to you, or any suggestions?

Thanks,
Yang
