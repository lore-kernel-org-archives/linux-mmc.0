Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B632C46467
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Jan 2023 08:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjADIgE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Jan 2023 03:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjADIfx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2023 03:35:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6A13CEC
        for <linux-mmc@vger.kernel.org>; Wed,  4 Jan 2023 00:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672821353; x=1704357353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yAbOIQZS6x+fxKK/q7k92dP7dRixNM8hVISCg7EniBk=;
  b=cGX4cMgg7+jpv+LXrPt+SqmCmR/ZKT58SqOLy8WxHX332XRbUTisYZJk
   9SBsgW0gcXm3Kpu2bGeOWksJrXn3UeLh3evSqsdazdID0/KJVfBiV4rmO
   SY+jjWjoU680klZYudN7fYeiC7bsAz7qR4PNGTW8J0SVO+vNRifldh6kc
   34VEWDYcgdlAqmm+AKs84avt/N3fekd54yYD8KThg2mvfJK+JlKrPDkDQ
   bna7WHRg7pTLL58u34hYlX1Tzxx1h06dT8o8kXNfcIaZGkolyIhbGDN5t
   KNgXC0cV8zMvyEE6r9SJWc6Ba1avYfHxNhfs8kKlL21XEiqsjNOyuUtBB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="349102698"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="349102698"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 00:35:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="983844777"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="983844777"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.246])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 00:35:50 -0800
Message-ID: <2612a51f-a103-5b6a-24f1-ae3511b66c74@intel.com>
Date:   Wed, 4 Jan 2023 10:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] mmc: core: host: fix mmc retuning
To:     Shyam Saini <shyamsaini@linux.microsoft.com>
Cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, code@tyhicks.com
References: <20221219225319.24637-1-shyamsaini@linux.microsoft.com>
 <14de0095-db93-cf5b-e843-1554a392b177@linux.microsoft.com>
 <e467c158-b298-53d1-4b12-7cbfe413af79@intel.com>
 <cacb9337-ed1b-6c5b-efa2-ae4086f9d7a9@linux.microsoft.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <cacb9337-ed1b-6c5b-efa2-ae4086f9d7a9@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/01/23 22:59, Shyam Saini wrote:
> 
> Hi Adrian,
> 
> Thank you for response.
> 
>> On 20/12/22 01:41, Shyam Saini wrote:
>>> As per the JEDEC spec, tuning(command CMD21) is not allowed in
>>> RPMB partition.
>>>
>>> To avoid retuning while switching to RPMB, hold_retune variable was
>>> introduced
>>
>> No, mmc_retune_pause() is used:
>>
>> /*
>> * Pause re-tuning for a small set of operations.  The pause begins after the
>> * next command and after first doing re-tuning.
>> */
>> void mmc_retune_pause(struct mmc_host *host)
>> {
>>     if (!host->retune_paused) {
>>         host->retune_paused = 1;
>>         mmc_retune_needed(host);
>>         mmc_retune_hold(host);
>>     }
>> }
>>
>>>            but it is not taken into account while making the tuning
>>> decision. As a consequence of this, mmc driver aborts while switching to
>>> RPMB partition:
>>>  mmc0: mmc_hs400_to_hs200 failed, error -84
>>
>> Do you normally re-tune at all?  It could just be that re-tuning
>> doesn't work.
>>
> 
> Yes, we are able to retune.
> 
> In fact this bug occurs when we iteratively switch to RPMB partition.
> 
> May be related to this, we also observed that in __mmc_blk_ioctl_cmd
> function in line 487[1] part_index is assigned target_part variable and
> on the next line EXT_CSD_PART_CONFIG_ACC_RPMB OR'ed to the target_part
> variable.
> 
> In mmc_blk_part_switch_pre function line 831 [2], part_type variable is
> compared to EXT_CSD_PART_CONFIG_ACC_RPMB without taking into account that
> the part_index variable is also OR'ed and its not separated before
> the comparision.
> 
> Same thing happens in mmc_blk_part_switch_post function.
> 
> Is it expected to be this way?, please let me know.

According to the spec, there can only be 1 RPMB partition,
so the comment and code are not very meaningful.

AFAICT rpmb->part_index is set to EXT_CSD_PART_CONFIG_ACC_RPMB
anyway, originally by mmc_decode_ext_csd():

		/*
		 * RPMB regions are defined in multiples of 128K.
		 */
		card->ext_csd.raw_rpmb_size_mult = ext_csd[EXT_CSD_RPMB_MULT];
		if (ext_csd[EXT_CSD_RPMB_MULT] && mmc_host_cmd23(card->host)) {
			mmc_part_add(card, ext_csd[EXT_CSD_RPMB_MULT] << 17,
				EXT_CSD_PART_CONFIG_ACC_RPMB,
				"rpmb", 0, false,
				MMC_BLK_DATA_AREA_RPMB);
		}

So the OR has no effect.

As for "mmc_hs400_to_hs200 failed, error -84", I suggest enabling
some dynamic debug messages to determine what command is getting
an error and what the I/O state (as per mmc_set_ios()) is.

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/tree/drivers/mmc/core/block.c?h=next#n487
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/tree/drivers/mmc/core/block.c?h=next#n831
> 
>>>
>>> To fix this, take hold_retune variable into account while making retune
>>> decision in mmc_retune() function.
>>>
>>> Fixes: 57da0c042f4a ("mmc: block: Pause re-tuning while switched to the RPMB partition")
>>> Reported-by: Judy Wang <wangjudy@linux.microsoft.com>
>>> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
>>> ---
>>>  drivers/mmc/core/host.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>> index b89dca1f15e9..342c1f5c256b 100644
>>> --- a/drivers/mmc/core/host.c
>>> +++ b/drivers/mmc/core/host.c
>>> @@ -181,6 +181,9 @@ int mmc_retune(struct mmc_host *host)
>>>      bool return_to_hs400 = false;
>>>      int err;
>>>
>>> +    if (host->hold_retune >= 1)
>>> +        return 0;
>>
>> No, hold_retune is set *before* the command *after* which
>> tuning is not permitted.
>>
>>> +
>>>      if (host->retune_now)
>>>          host->retune_now = 0;
>>>      else
>>> -- 
>>> 2.34.1
>>>
>> On 20/12/22 01:41, Shyam Saini wrote:
>>> Hi All,
>>>
>>> Cc'ing Tyler
>>>
>>> Please note that I am not 100 % sure about the fix.
>>> This issue is reproducible without this patch and the patch at least fix the issue without
>>> any regressions on our side.
>>>
>>> We observed that hold_retune is always greater or equal to 1 in mmc_retune() function,
>>>
>>> so it may always avoid  re-tuning when it is actually needed and there may
>>>
>>> be a better fix for the issue.
>>>
>>> Please let me know your any feedback or comments.
>>>
>>> Best Regards,
>>> Shyam
>>>
>>>
>>
>>

