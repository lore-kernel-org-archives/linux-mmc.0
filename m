Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A76C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 12:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67E260C3E
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 12:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhBQMLb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Feb 2021 07:11:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:45928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232022AbhBQML3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Feb 2021 07:11:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9879CB95C;
        Wed, 17 Feb 2021 12:10:48 +0000 (UTC)
Subject: Re: [PATCH] sdhci: stop poking into swiotlb internals
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@lst.de>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org
References: <20210205162346.2847165-1-hch@lst.de>
 <195d7168-3be0-91ea-1c5b-e850d5c12582@intel.com>
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <c3e3c2bf-96f9-41d8-9f42-c78bce2dbdc1@suse.cz>
Date:   Wed, 17 Feb 2021 13:10:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <195d7168-3be0-91ea-1c5b-e850d5c12582@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 05. 02. 21, 19:43, Adrian Hunter wrote:
> + Jiri Slaby <jslaby@suse.cz>
> 
> On 5/02/21 6:23 pm, Christoph Hellwig wrote:
>> Use the proper API to query the max mapping size instead of guessing
>> it based on swiotlb internals.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/mmc/host/sdhci.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 646823ddd31715..2d73407ee52ec7 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -20,7 +20,6 @@
>>   #include <linux/slab.h>
>>   #include <linux/scatterlist.h>
>>   #include <linux/sizes.h>
>> -#include <linux/swiotlb.h>
>>   #include <linux/regulator/consumer.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/of.h>
>> @@ -4582,12 +4581,8 @@ int sdhci_setup_host(struct sdhci_host *host)
>>   		mmc->max_segs = SDHCI_MAX_SEGS;
>>   	} else if (host->flags & SDHCI_USE_SDMA) {
>>   		mmc->max_segs = 1;
>> -		if (swiotlb_max_segment()) {
>> -			unsigned int max_req_size = (1 << IO_TLB_SHIFT) *
>> -						IO_TLB_SEGSIZE;
>> -			mmc->max_req_size = min(mmc->max_req_size,
>> -						max_req_size);
>> -		}
>> +		mmc->max_req_size = min_t(size_t, mmc->max_req_size,
>> +					  dma_max_mapping_size(mmc_dev(mmc)));

dma_max_mapping_size() should return the same for swiotlb 
(swiotlb_max_mapping_size()), right?

I don't have the laptop, it was ThinkPad X230 if anyone wants to test 
this...

thanks,
-- 
js
suse labs
