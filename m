Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7D5C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 08:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1AF46103D
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 08:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbhKIIpE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 03:45:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:34445 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244408AbhKIIpC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 9 Nov 2021 03:45:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="213136740"
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="scan'208";a="213136740"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 00:41:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="scan'208";a="601733520"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga004.jf.intel.com with ESMTP; 09 Nov 2021 00:41:54 -0800
Subject: Re: [PATCH] mmc: sdhci: disable ADMA when PAGE SIZE is 64K
To:     Bough Chen <haibo.chen@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1635302841-18997-1-git-send-email-haibo.chen@nxp.com>
 <34233159-2931-b02a-ef16-1029d8d7829a@intel.com>
 <VI1PR04MB5294AFD5A60F98A73E12A16290879@VI1PR04MB5294.eurprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <74c896b2-5e9e-b1c9-485f-9c4ffd7d7072@intel.com>
Date:   Tue, 9 Nov 2021 10:41:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB5294AFD5A60F98A73E12A16290879@VI1PR04MB5294.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/10/2021 14:40, Bough Chen wrote:
>> -----Original Message-----
>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>> Sent: 2021年10月27日 13:50
>> To: Bough Chen <haibo.chen@nxp.com>; ulf.hansson@linaro.org
>> Cc: linux-mmc@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH] mmc: sdhci: disable ADMA when PAGE SIZE is 64K
>>
>> On 27/10/2021 05:47, haibo.chen@nxp.com wrote:
>>> From: Haibo Chen <haibo.chen@nxp.com>
>>>
>>> For ADMA with quirks SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC, it
>> limit
>>> the max segment size as 64K-1. Currently, linux kernel support
>>> 4K/16K/64K PAGE_SIZE. If choose 64K PAGE_SIZE, sdhci in ADMA mode with
>>> the upper quirks will meet issue.
>>>
>>> Though mmc driver give block layer the max segment size through
>>> blk_queue_max_segment_size(), but in this function, it will compare
>>> the argument with PAGE_SIZE, and will choose PAGE_SIZE if the argument
>>> is smaller than PAGE_SIZE. When PAGE_SIZE is 64K, finally the mmc
>>> request queue will get 64K as the max segment size. Once the sg data
>>> length=64K, ADMA will meet issue. For this case, need to disable ADMA
>>> mode.
>>
>> Sorry, I didn't look closely enough at this.
>>
>> For the 64K PAGE_SIZE case, did you try blk_queue_virt_boundary() with a 32K
>> mask instead of blk_queue_max_segment_size() ?
>> e.g. a hack for testing purposes like this:
> 
> I test on my board, this do not work, I still can see sg data_length = 65536.

What about tweaking the logic to write ADMA descriptors?
Something like below for instance?



diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 269c86569402..07c6da1f2f0f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -771,7 +771,19 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 			len -= offset;
 		}
 
-		BUG_ON(len > 65536);
+		/*
+		 * The block layer forces a minimum segment size of PAGE_SIZE,
+		 * so 'len' can be too big here if PAGE_SIZE >= 64KiB. Write
+		 * multiple descriptors, noting that the ADMA table is sized
+		 * for 4KiB chunks anyway, so it will be big enough.
+		 */
+		while (len > host->max_adma) {
+			int n = 32 * 1024; /* 32KiB*/
+
+			__sdhci_adma_write_desc(host, &desc, addr, n, ADMA2_TRAN_VALID);
+			addr += n;
+			len -= n;
+		}
 
 		/* tran, valid */
 		if (len)
@@ -3968,6 +3980,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	 * descriptor for each segment, plus 1 for a nop end descriptor.
 	 */
 	host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1;
+	host->max_adma = 65536;
 
 	host->max_timeout_count = 0xE;
 
@@ -4633,10 +4646,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * be larger than 64 KiB though.
 	 */
 	if (host->flags & SDHCI_USE_ADMA) {
-		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
+		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) {
+			host->max_adma = 65532; /* 32-bit alignment */
 			mmc->max_seg_size = 65535;
-		else
+		} else {
 			mmc->max_seg_size = 65536;
+		}
 	} else {
 		mmc->max_seg_size = mmc->max_req_size;
 	}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index bb883553d3b4..d7929d725730 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -340,7 +340,8 @@ struct sdhci_adma2_64_desc {
 
 /*
  * Maximum segments assuming a 512KiB maximum requisition size and a minimum
- * 4KiB page size.
+ * 4KiB page size. Note this also allows enough for multiple descriptors in
+ * case of PAGE_SIZE >= 64KiB.
  */
 #define SDHCI_MAX_SEGS		128
 
@@ -543,6 +544,7 @@ struct sdhci_host {
 	unsigned int blocks;	/* remaining PIO blocks */
 
 	int sg_count;		/* Mapped sg entries */
+	int max_adma;		/* Max. length in ADMA descriptor */
 
 	void *adma_table;	/* ADMA descriptor table */
 	void *align_buffer;	/* Bounce buffer */
-- 
2.25.1




> 
> Best Regards
> Haibo Chen
>>
>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c index
>> b15c034b42fb..4c3a9d999500 100644
>> --- a/drivers/mmc/core/queue.c
>> +++ b/drivers/mmc/core/queue.c
>> @@ -376,8 +376,7 @@ static void mmc_setup_queue(struct mmc_queue *mq,
>> struct mmc_card *card)
>>  	 * both blk_queue_max_segment_size().
>>  	 */
>>  	if (!host->can_dma_map_merge)
>> -		blk_queue_max_segment_size(mq->queue,
>> -			round_down(host->max_seg_size, block_size));
>> +		blk_queue_virt_boundary(mq->queue, 0x7fff);
>>
>>  	dma_set_max_seg_size(mmc_dev(host),
>> queue_max_segment_size(mq->queue));
>>
>>
>>
>>
>>>
>>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
>>> dbe87995596c..47e0c0156b94 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -4187,6 +4187,12 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>  		host->flags &= ~SDHCI_USE_ADMA;
>>>  	}
>>>
>>> +	if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) &&
>>> +		PAGE_SIZE >= 65536 && (host->flags & SDHCI_USE_ADMA)) {
>>> +		DBG("Disabling ADMA as it don't support >= 64K PAGE_SIZE\n");
>>> +		host->flags &= ~SDHCI_USE_ADMA;
>>> +	}
>>> +
>>>  	if (sdhci_can_64bit_dma(host))
>>>  		host->flags |= SDHCI_USE_64_BIT_DMA;
>>>
>>>
> 

