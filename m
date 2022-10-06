Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB1BC433FE
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Oct 2022 07:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJFHXQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Oct 2022 03:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJFHXP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Oct 2022 03:23:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE5D558CB
        for <linux-mmc@vger.kernel.org>; Thu,  6 Oct 2022 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665040993; x=1696576993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jO5U5XK68Y8XyZPfD2WXOypDM26Xka2rS8lpWvVmcqA=;
  b=mthGwPvcp1rmAhmy2C0RXH1c/av8TUDlP/JI2RsOj6GA4kqX6U54QO6X
   SFeGbN0+kwtWPNFbxHG9A3wcSXnSm/FET4piGpnIsIykhKDm4Z68ZmgzZ
   IkbQm86h0K1TzNqDPBQRsm4XIjefpWIATKQZehFKtlhW8F2IqvvL1yESi
   3SYsurGTmKHxh4jn0MdT/iDvD+m2dhvF84Pq6WyvdXOhq3/p/jDe9XUJW
   Urc5gAJ5ZefGE2RvyHSCweW1TddyioBymZJURMw3qMZZ3kgtrrl3BrWU+
   B3mtwyU5hlC6pgU79M2Lk8q3aAymD7OzWRCUgdyo1zg0N8W2JhKFDFtzX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="286596175"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="286596175"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 00:23:12 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="602328994"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="602328994"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.93])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 00:23:08 -0700
Message-ID: <33dd4b37-6da8-ecd7-4603-b9122d0bc950@intel.com>
Date:   Thu, 6 Oct 2022 10:23:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 03/14] mmc: sdhci: Replace kmap_atomic() with
 kmap_local_page()
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20221005101951.3165-1-adrian.hunter@intel.com>
 <20221005101951.3165-4-adrian.hunter@intel.com>
 <DM6PR04MB6575FDD9B40D5EE3C9239822FC5C9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB6575FDD9B40D5EE3C9239822FC5C9@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/10/22 10:03, Avri Altman wrote:
>> kmap_local_page() is equivalent to kmap_atomic() except that it does not
>> disable page faults or preemption. Where possible kmap_local_page() is
>> preferred to kmap_atomic() - refer kernel highmem documentation.
>>
>> In this case, there is no need to disable page faults or preemption, so replace
>> kmap_atomic() with kmap_local_page(), and, correspondingly,
>> kunmap_atomic() with kunmap_local().
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
>> 31d87ec7d055..fb6e9a81f198 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -697,12 +697,12 @@ static int sdhci_pre_dma_transfer(struct sdhci_host
>> *host,
>>
>>  static char *sdhci_kmap_atomic(struct scatterlist *sg)  {
>> -       return kmap_atomic(sg_page(sg)) + sg->offset;
>> +       return kmap_local_page(sg_page(sg)) + sg->offset;
>>  }
>>
>>  static void sdhci_kunmap_atomic(void *buffer)  {
>> -       kunmap_atomic(buffer);
>> +       kunmap_local(buffer);
> kmap_local_page documentation, indicates that the unmapping should be done in reverse order.
> Isn't it something that the callers of sdhci_kunmap_atomic now needs to attend?

Nesting is strictly ordered in either case, so there is no change there.
i.e. the map management is stack based
