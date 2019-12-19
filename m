Return-Path: <SRS0=Rhqe=2J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4ABC43603
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 06:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5189621582
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 06:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfLSG2k (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:28:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbfLSG2k (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Dec 2019 01:28:40 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 61B6D702EAF8926871A8;
        Thu, 19 Dec 2019 14:28:38 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Dec 2019
 14:28:28 +0800
From:   Pan Zhang <zhangpan26@huawei.com>
To:     <ulf.hansson@linaro.org>, <p.zabel@pengutronix.de>,
        <jh80.chung@samsung.com>, <zhangpan26@huawei.com>,
        <hushiyuan@huawei.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] mmc: host: fix a possible null pointer access.
Date:   Thu, 19 Dec 2019 14:28:09 +0800
Message-ID: <1576736889-4430-1-git-send-email-zhangpan26@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAPDyKFr8aVWVydT5U6mpuZr5_waH=bn6F8rjryfDJ15FDaAXUw@mail.gmail.com>
References: <CAPDyKFr8aVWVydT5U6mpuZr5_waH=bn6F8rjryfDJ15FDaAXUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Dec 2019 at 7:52 p.m., Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> 3419     if (host->slot &&
>> 3420         (mmc_can_gpio_cd(host->slot->mmc) ||
>> 3421          !mmc_card_is_removable(host->slot->mmc))) {
>> 3422         ret = clk_prepare_enable(host->biu_clk);
>> 3423         if (ret)
>> 3424             return ret;
>> 3425     }
>>
>> We previously assumed 'host->slot' could be null (see line 3419).
>>
>> The following situation is similar, so add a judgement.
>>
>> Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c 
>> index fc9d4d0..8e27c52 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -3454,7 +3454,7 @@ int dw_mci_runtime_resume(struct device *dev)
>>         mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
>>
>>
>> -       if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
>> +       if (host->slot && (host->slot->mmc->pm_flags & 
>> + MMC_PM_KEEP_POWER))
>>                 dw_mci_set_ios(host->slot->mmc, 
>> &host->slot->mmc->ios);

>This shouldn't be a problem as the ->runtime_resume() callback can't be invoked, unless there is a slot.

>>
>>         /* Force setup bus to guarantee available clock output */
>> --
>> 2.7.4
>>

If so, there is no need to assume host->slot pointer previously(line 3419)?

