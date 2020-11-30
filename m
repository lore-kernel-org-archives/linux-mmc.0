Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D4BC63777
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 07:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8383A20709
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 07:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgK3Hie (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 02:38:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:22249 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgK3Hid (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Nov 2020 02:38:33 -0500
IronPort-SDR: t9KOsXKynBOkTvPxLmsMrfKI9PKIELAU2rq6eSxAr/EtioAgbD8DZnxCir4e5oWC6VPiWaPFsA
 xrpaN1QdF6qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="236720095"
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="236720095"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 23:37:50 -0800
IronPort-SDR: Y7AQECkXbJHbbM3cZvKpb2N7C+ifUkwH3siFUpbYjl478HQJC8Xopmgs7JimNCc9hbtsde/4KK
 01ozh9YOeNWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="329483080"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2020 23:37:47 -0800
Subject: Re: [RFC PATCH v3.1 12/27] mmc: sdhci-uhs2: add reset function
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-13-takahiro.akashi@linaro.org>
 <ed1e3497-4deb-49ad-22b0-ed74fb0ef7ec@intel.com>
 <20201130062016.GC48535@laputa>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <073c9cc8-24bb-5efc-48bc-cc66f5024923@intel.com>
Date:   Mon, 30 Nov 2020 09:37:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201130062016.GC48535@laputa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/11/20 8:20 am, AKASHI Takahiro wrote:
> On Thu, Nov 26, 2020 at 10:16:11AM +0200, Adrian Hunter wrote:
>> On 6/11/20 4:27 am, AKASHI Takahiro wrote:
>>> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
>>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci-uhs2.c | 49 +++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci-uhs2.h |  1 +
>>>  drivers/mmc/host/sdhci.c      |  3 ++-
>>>  drivers/mmc/host/sdhci.h      |  1 +
>>>  4 files changed, 53 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>>> index 08905ed081fb..e2b9743fe17d 100644
>>> --- a/drivers/mmc/host/sdhci-uhs2.c
>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>>> @@ -10,6 +10,7 @@
>>>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>   */
>>>  
>>> +#include <linux/delay.h>
>>>  #include <linux/module.h>
>>>  
>>>  #include "sdhci.h"
>>> @@ -49,6 +50,54 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>>>  
>>> +/*****************************************************************************\
>>> + *                                                                           *
>>> + * Low level functions                                                       *
>>> + *                                                                           *
>>> +\*****************************************************************************/
>>> +
>>> +/**
>>> + * sdhci_uhs2_reset - invoke SW reset
>>> + * @host: SDHCI host
>>> + * @mask: Control mask
>>> + *
>>> + * Invoke SW reset, depending on a bit in @mask and wait for completion.
>>> + */
>>> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>>> +{
>>> +	unsigned long timeout;
>>> +
>>> +	if (!(host->mmc->caps & MMC_CAP_UHS2))
>>
>> Please make a helper so this can be like:
>>
>> 	if (!sdhci_uhs2_mode(host))
>>
>> The capability will be always present for hosts that support UHS2, but not
>> all cards support UHS2 mode.  I suggest just adding a bool to struct
>> sdhci_host to keep track of when the host is in UHS2 mode.
> 
> Given the fact that UHS-2 host may (potentially) support a topology like
> a ring, this kind of status should be attributed to a card (structure)
> rather than a host.

It is very unlikely we would ever need to support that, so don't let it make
things more complicated.
