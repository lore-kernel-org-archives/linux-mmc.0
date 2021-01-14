Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06155C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 06:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB36F238E7
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 06:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbhANGLo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 01:11:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:61091 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbhANGLo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Jan 2021 01:11:44 -0500
IronPort-SDR: oCAYHts5DnsdHyG5O96lRzvsZY5RjJbJPO8jqXth2YL1VwPisMe6R/1yg+cSKu1JPsxkUSM6K0
 D+gRbRIqv5sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="239855646"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="239855646"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 22:10:59 -0800
IronPort-SDR: i5EMlFPHPGQIqxISEejOfg1qR5df+jGLcWc9QMaMScPMrimQnJz/tJD7y1Ox83E+/zEkp1zFEZ
 BRmXLkDMKpDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="424840834"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2021 22:10:57 -0800
Subject: Re: [PATCH] mmc: core: don't initialize block size from ext_csd if
 not present
To:     Peter Collingbourne <pcc@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
References: <20210112210944.605953-1-pcc@google.com>
 <34278e68-d69f-0440-858e-b2079b8ac7bb@intel.com>
 <CAMn1gO5Yuy3c48Rscny6mnQAycZeUy-aCwex_r=h_XTMF6Lh-g@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2bba99d2-3c57-d96e-090b-c223372a12c9@intel.com>
Date:   Thu, 14 Jan 2021 08:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMn1gO5Yuy3c48Rscny6mnQAycZeUy-aCwex_r=h_XTMF6Lh-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/01/21 9:46 pm, Peter Collingbourne wrote:
> On Wed, Jan 13, 2021 at 2:43 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 12/01/21 11:09 pm, Peter Collingbourne wrote:
>>> If extended CSD was not available, the eMMC driver would incorrectly
>>> set the block size to 0, as the data_sector_size field of ext_csd
>>> was never initialized. This issue was exposed by commit 817046ecddbc
>>> ("block: Align max_hw_sectors to logical blocksize") which caused
>>> max_sectors and max_hw_sectors to be set to 0 after setting the block
>>> size to 0, resulting in a kernel panic in bio_split when attempting
>>> to read from the device. Fix it by only reading the block size from
>>> ext_csd if it is available.
>>>
>>> Fixes: 817046ecddbc ("block: Align max_hw_sectors to logical blocksize")
>>
>> I would go with the original commit i.e.
>>
>> Fixes: a5075eb94837 ("mmc: block: Allow disabling 512B sector size emulation")
> 
> Sure, makes sense.
> 
>>> Signed-off-by: Peter Collingbourne <pcc@google.com>
>>> Link: https://linux-review.googlesource.com/id/If244d178da4d86b52034459438fec295b02d6e60
>>> ---
>>>  drivers/mmc/core/queue.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
>>> index de7cb0369c30..735cdbf1145c 100644
>>> --- a/drivers/mmc/core/queue.c
>>> +++ b/drivers/mmc/core/queue.c
>>> @@ -20,6 +20,7 @@
>>>  #include "core.h"
>>>  #include "card.h"
>>>  #include "host.h"
>>> +#include "mmc_ops.h"
>>>
>>>  #define MMC_DMA_MAP_MERGE_SEGMENTS   512
>>>
>>> @@ -384,7 +385,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>>>                    "merging was advertised but not possible");
>>>       blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
>>>
>>> -     if (mmc_card_mmc(card))
>>> +     if (mmc_card_mmc(card) && mmc_can_ext_csd(card))
>>>               block_size = card->ext_csd.data_sector_size;
>>
>> Might as well be:
>>
>>         if (mmc_card_mmc(card) && card->ext_csd.data_sector_size)
>>                 block_size = card->ext_csd.data_sector_size;
> 
> Can we rely on this data structure to be zero initialized? I suppose
> so, provided that it was allocated with mmc_alloc_card which uses
> kzalloc. But it isn't entirely obvious and I figure it may be a little
> better to be explicit in our intent here. But either way works for me.

The only valid values are 512 and 4096, so you could add WARN_ON(block_size
!= 512 && block_size != 4096) if you want.
