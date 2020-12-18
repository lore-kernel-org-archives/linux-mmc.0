Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA99C4361B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 13:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ADE623A9C
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 13:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgLRNsE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Dec 2020 08:48:04 -0500
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:32693 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727053AbgLRNsE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2020 08:48:04 -0500
Received: from [192.168.42.210] ([93.22.133.192])
        by mwinf5d71 with ME
        id 5pmF2400849DTe503pmFRW; Fri, 18 Dec 2020 14:46:20 +0100
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 18 Dec 2020 14:46:20 +0100
X-ME-IP: 93.22.133.192
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix some resource leaks in the remove
 function
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, billows.wu@unisoc.com,
        Wu Hongtao <wuht06@gmail.com>
References: <20201217204236.163446-1-christophe.jaillet@wanadoo.fr>
 <CA+H2tpGkv0sPQ2e6OfUVuW2xFx-KSpZy_vYY3TG_9JBWvFZxAA@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <83712f89-deb7-b266-8e8a-99f0df4c6782@wanadoo.fr>
Date:   Fri, 18 Dec 2020 14:46:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CA+H2tpGkv0sPQ2e6OfUVuW2xFx-KSpZy_vYY3TG_9JBWvFZxAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Le 17/12/2020 à 23:55, Orson Zhai a écrit :
> + cc: Billows
> 
> Hi Christophe,
> On Fri, Dec 18, 2020 at 4:50 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> 'sdhci_remove_host()' and 'sdhci_pltfm_free()' should be used in place of
>> 'mmc_remove_host()' and 'mmc_free_host()'.
>>
>> This avoids some resource leaks, is more in line with the error handling
>> path of the probe function, and is more consistent with other drivers.
>>
>> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Other adjustment may be needed.
>> I'm not sure at all of the 0 passed to 'sdhci_remove_host()'. Some drivers
>> pass 0, some have some more complicated computation.
>> ---
>>   drivers/mmc/host/sdhci-sprd.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
>> index f85171edabeb..5dc36efff47f 100644
>> --- a/drivers/mmc/host/sdhci-sprd.c
>> +++ b/drivers/mmc/host/sdhci-sprd.c
>> @@ -708,14 +708,14 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
>>   {
>>          struct sdhci_host *host = platform_get_drvdata(pdev);
>>          struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
>> -       struct mmc_host *mmc = host->mmc;
>>
>> -       mmc_remove_host(mmc);
>> +       sdhci_remove_host(host, 0);
>> +
>>          clk_disable_unprepare(sprd_host->clk_sdio);
>>          clk_disable_unprepare(sprd_host->clk_enable);
>>          clk_disable_unprepare(sprd_host->clk_2x_enable);
>>
>> -       mmc_free_host(mmc);
>> +       sdhci_pltfm_free(pdev);
> 
> I saw a lot of drivers also use mmc_free_host().
> Do you have patches elsewhere to clean them?
> 

As far as I can see, all drivers that use 'mmc_free_host' also use 
'mmc_alloc_host'. (based on 5.10.1 and unless error)

The only exception is 'sdhci-sprd.c'.

So no, I don't plan any other clean-up.



To spot it, I run one of my own cocci script which compare functions 
called in the remove function and in the error handling path of the probe.

So I caught this one because 'mmc_free_host' is used in the porbe and 
'sdhci_pltfm_free' in the remove function.


CJ

> Thanks,
> -Orson
> 
>>
>>          return 0;
>>   }
>> --
>> 2.27.0
>>
> 

