Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883BF770E5
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655111; cv=none; b=KbC/VNX8eUDDMcuhIwD/uDss/3g5erpxXUUQAz4LxlWsJBMDVsZOk5C+coUH/QmlHgdGoEc6ctkPImeITl8GSk7ZuDMB4I5grh6rPPl4YajADrRTRdbuCbKciNOa7XzLUo82cNYzc2Ecv9kEH/uwsyJgNP+yyighJQf/SYj5KxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655111; c=relaxed/simple;
	bh=f/Ncd3jKfrO632y3KORnVMxUVyPuwkvtRsIZxdJHhgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLWcOS+eCX9P+NFMgS0g5aIkDyJql9mE2OnXZUkKMpg2227hKr956JN+3EHUrvX6JcTYB/UCBM1Qg6sd/11fJ3aROlnDVzFvD8FTICTgNiMzHNs+qaX1Qi0Py7KxRsdncu8HNWRqJBybZhxkXVz+H6sZfrXM0tEqlatT9ugo9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUTX8+mk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUTX8+mk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724655108; x=1756191108;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f/Ncd3jKfrO632y3KORnVMxUVyPuwkvtRsIZxdJHhgM=;
  b=DUTX8+mk4uXlyFzY0Ige4dI+okkfhFE6Wl1h9zxzRibZW4qfX5Os/jjy
   Fx/bG4O52WHh6GQghw6J8Kbg52CT2ASJhP5Fmh4G/LfVQwGyxKElr7RmD
   rEQlTiRu4ZdF7Oa5Gfaxs7fP0A5XPpWHl26rORN/su1db+uEyLyS6/Yj4
   Z1VVQ483au+gXYIKN0FC9HmiVUMlPjWbmuVK5IzM+MqjgKBxcalHPq5a5
   LysENDwMFDUNdb/eSD3ufZRSm3BBgMTgXdGTtniQzLoqkVx/V6/c/CXZh
   QJvH+y8g5MufjDUEPp8IY0MuscwKeB8jQoPRogd9O8BGzSd3ZxhkSPVaT
   w==;
X-CSE-ConnectionGUID: 9LaynhMTRXiSLWBwKy4nWw==
X-CSE-MsgGUID: yhWOdXihSxqSLVwERMsACw==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33625151"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="33625151"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 23:51:48 -0700
X-CSE-ConnectionGUID: jUr1xT1fQBWjneKkhD2Quw==
X-CSE-MsgGUID: jMSyf7b+S7m1pGwDcCqBSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="93139412"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 23:51:46 -0700
Message-ID: <636d4b90-d195-498d-b2ca-886c86517ee5@intel.com>
Date: Mon, 26 Aug 2024 09:51:41 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] mmc: core: Add close-ended Ext memory addressing
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ricky WU <ricky_wu@realtek.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <20240825074141.3171549-5-avri.altman@wdc.com>
 <DM6PR04MB657566FAC186AE1A9698AF5DFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB657566FAC186AE1A9698AF5DFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/24 08:32, Avri Altman wrote:
>> In a multi-block data transfer, CMD23 shall precede CMD22. Prepare CMD22
>> in advance as an additional extension of the mrq, to be handle by the host
>> once CMD23 is done.
> I am floundering about the close-ended part of this series.
> My main concern is an amid stream of fixes & quirks of bogus hw,
> that tends to apply extra logic specifically around acmd12 & acmd23.
> 
> Unless someone think it's absolutely necessary to be included,
> I would like to drop patches 4, 5, and 6.
> What do you think?

What are the downsides to supporting open-ended only?

> 
> Thanks,
> Avri
> 
>>
>> Tested-by: Ricky WU <ricky_wu@realtek.com>
>> Signed-off-by: Avri Altman <avri.altman@wdc.com>
>> ---
>>  drivers/mmc/core/block.c |  7 +++++++
>>  drivers/mmc/core/core.c  | 18 ++++++++++++++++++
>> drivers/mmc/core/queue.h |  1 +  include/linux/mmc/core.h |  1 +
>>  4 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
>> 8816b3f0a312..7020a568fb79 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -1713,6 +1713,13 @@ static void mmc_blk_rw_rq_prep(struct
>> mmc_queue_req *mqrq,
>>  			(do_data_tag ? (1 << 29) : 0);
>>  		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>>  		brq->mrq.sbc = &brq->sbc;
>> +
>> +		if (mmc_card_ult_capacity(card)) {
>> +			brq->ext.opcode = SD_ADDR_EXT;
>> +			brq->ext.arg = (u32)((blk_rq_pos(req) >> 32) & 0x3F);
>> +			brq->ext.flags = MMC_RSP_R1 | MMC_CMD_AC;
>> +			brq->mrq.ext = &brq->ext;
>> +		}
>>  	} else if (mmc_card_ult_capacity(card)) {
>>  		mmc_blk_wait_for_idle(mq, card->host);
>>  		mmc_send_ext_addr(card->host, blk_rq_pos(req)); diff --git
>> a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>> d6c819dd68ed..4808e42d7855 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -184,6 +184,14 @@ void mmc_request_done(struct mmc_host *host,
>> struct mmc_request *mrq)
>>  				mrq->sbc->resp[2], mrq->sbc->resp[3]);
>>  		}
>>
>> +		if (mrq->ext) {
>> +			pr_debug("%s: req done <CMD%u>: %d: %08x %08x
>> %08x %08x\n",
>> +				 mmc_hostname(host), mrq->ext->opcode,
>> +				 mrq->ext->error,
>> +				 mrq->ext->resp[0], mrq->ext->resp[1],
>> +				 mrq->ext->resp[2], mrq->ext->resp[3]);
>> +		}
>> +
>>  		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x
>> %08x\n",
>>  			mmc_hostname(host), cmd->opcode, err,
>>  			cmd->resp[0], cmd->resp[1],
>> @@ -270,6 +278,12 @@ static void mmc_mrq_pr_debug(struct mmc_host
>> *host, struct mmc_request *mrq,
>>  			 mrq->sbc->arg, mrq->sbc->flags);
>>  	}
>>
>> +	if (mrq->ext) {
>> +		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
>> +			 mmc_hostname(host), mrq->ext->opcode,
>> +			 mrq->ext->arg, mrq->ext->flags);
>> +	}
>> +
>>  	if (mrq->cmd) {
>>  		pr_debug("%s: starting %sCMD%u arg %08x flags %08x\n",
>>  			 mmc_hostname(host), cqe ? "CQE direct " : "", @@ -
>> 309,6 +323,10 @@ static int mmc_mrq_prep(struct mmc_host *host, struct
>> mmc_request *mrq)
>>  		mrq->sbc->error = 0;
>>  		mrq->sbc->mrq = mrq;
>>  	}
>> +	if (mrq->ext) {
>> +		mrq->ext->error = 0;
>> +		mrq->ext->mrq = mrq;
>> +	}
>>  	if (mrq->data) {
>>  		if (mrq->data->blksz > host->max_blk_size ||
>>  		    mrq->data->blocks > host->max_blk_count || diff --git
>> a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h index
>> 1498840a4ea0..7e191d7f0461 100644
>> --- a/drivers/mmc/core/queue.h
>> +++ b/drivers/mmc/core/queue.h
>> @@ -40,6 +40,7 @@ struct mmc_blk_ioc_data;  struct mmc_blk_request {
>>  	struct mmc_request	mrq;
>>  	struct mmc_command	sbc;
>> +	struct mmc_command	ext;
>>  	struct mmc_command	cmd;
>>  	struct mmc_command	stop;
>>  	struct mmc_data		data;
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h index
>> 2c7928a50907..5560e70cb8d4 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -142,6 +142,7 @@ struct mmc_data {
>>  struct mmc_host;
>>  struct mmc_request {
>>  	struct mmc_command	*sbc;		/* SET_BLOCK_COUNT for
>> multiblock */
>> +	struct mmc_command	*ext;		/* SD_ADDR_EXT for SDUC */
>>  	struct mmc_command	*cmd;
>>  	struct mmc_data		*data;
>>  	struct mmc_command	*stop;
>> --
>> 2.25.1
> 

