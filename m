Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A868C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 08:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A56E61391
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 08:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhKPIRO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:17:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:60808 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhKPIRO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 16 Nov 2021 03:17:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="297070465"
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="297070465"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 00:14:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="548520039"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga008.fm.intel.com with ESMTP; 16 Nov 2021 00:14:15 -0800
Subject: Re: [PATCH] mmc: sdhci: Fix ADMA for PAGE_SIZE >= 64KiB
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bough Chen <haibo.chen@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
References: <20211115082345.802238-1-adrian.hunter@intel.com>
 <CAPDyKFrADwgb_xeVDmdPETcFnbqRqvKKav_Gr+oGf-4E3Tfj6w@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8a76ac63-48a8-e36c-5138-ad8b4cade179@intel.com>
Date:   Tue, 16 Nov 2021 10:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrADwgb_xeVDmdPETcFnbqRqvKKav_Gr+oGf-4E3Tfj6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/11/2021 16:54, Ulf Hansson wrote:
> On Mon, 15 Nov 2021 at 09:24, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> The block layer forces a minimum segment size of PAGE_SIZE, so a segment
>> can be too big for the ADMA table, if PAGE_SIZE >= 64KiB. Fix by writing
>> multiple descriptors, noting that the ADMA table is sized for 4KiB chunks
>> anyway, so it will be big enough.
>>
>> Reported-and-tested-by: Bough Chen <haibo.chen@nxp.com>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Applied for next, thanks!
> 
> Should we perhaps tag this for stable and/or queue it as a fix for v5.16?

Could do.  I thought I would leave it up to Haibo Chen.

> 
> Kind regards
> Uffe
> 
> 
> 
>> ---
>>  drivers/mmc/host/sdhci.c | 21 ++++++++++++++++++---
>>  drivers/mmc/host/sdhci.h |  4 +++-
>>  2 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 269c86569402..07c6da1f2f0f 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -771,7 +771,19 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
>>                         len -= offset;
>>                 }
>>
>> -               BUG_ON(len > 65536);
>> +               /*
>> +                * The block layer forces a minimum segment size of PAGE_SIZE,
>> +                * so 'len' can be too big here if PAGE_SIZE >= 64KiB. Write
>> +                * multiple descriptors, noting that the ADMA table is sized
>> +                * for 4KiB chunks anyway, so it will be big enough.
>> +                */
>> +               while (len > host->max_adma) {
>> +                       int n = 32 * 1024; /* 32KiB*/
>> +
>> +                       __sdhci_adma_write_desc(host, &desc, addr, n, ADMA2_TRAN_VALID);
>> +                       addr += n;
>> +                       len -= n;
>> +               }
>>
>>                 /* tran, valid */
>>                 if (len)
>> @@ -3968,6 +3980,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>>          * descriptor for each segment, plus 1 for a nop end descriptor.
>>          */
>>         host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1;
>> +       host->max_adma = 65536;
>>
>>         host->max_timeout_count = 0xE;
>>
>> @@ -4633,10 +4646,12 @@ int sdhci_setup_host(struct sdhci_host *host)
>>          * be larger than 64 KiB though.
>>          */
>>         if (host->flags & SDHCI_USE_ADMA) {
>> -               if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
>> +               if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) {
>> +                       host->max_adma = 65532; /* 32-bit alignment */
>>                         mmc->max_seg_size = 65535;
>> -               else
>> +               } else {
>>                         mmc->max_seg_size = 65536;
>> +               }
>>         } else {
>>                 mmc->max_seg_size = mmc->max_req_size;
>>         }
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index bb883553d3b4..d7929d725730 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -340,7 +340,8 @@ struct sdhci_adma2_64_desc {
>>
>>  /*
>>   * Maximum segments assuming a 512KiB maximum requisition size and a minimum
>> - * 4KiB page size.
>> + * 4KiB page size. Note this also allows enough for multiple descriptors in
>> + * case of PAGE_SIZE >= 64KiB.
>>   */
>>  #define SDHCI_MAX_SEGS         128
>>
>> @@ -543,6 +544,7 @@ struct sdhci_host {
>>         unsigned int blocks;    /* remaining PIO blocks */
>>
>>         int sg_count;           /* Mapped sg entries */
>> +       int max_adma;           /* Max. length in ADMA descriptor */
>>
>>         void *adma_table;       /* ADMA descriptor table */
>>         void *align_buffer;     /* Bounce buffer */
>> --
>> 2.25.1
>>

