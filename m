Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863445BE3
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611597; cv=none; b=XNgSaid/f9pISg1hyNHqmfrAghBuZFTvxloEY467bRKJRgSSE9ecDoXRSSwNnMxXXjlGKMHFwvCHVu7gbwafWcMq27ZPMKHJYVxYyi+6PWcVi3nbKxB8s9tx8OionwCcxkGnxC/3KyfvqXUqBz4JdeRztzixM4jaZmsmc2D1DYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611597; c=relaxed/simple;
	bh=zmIzBGzPhAHx+Euq/bqrWY8v0HnZGvvLQuM0MmZFwNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngPmuQp1/HEQSyJdRswx5WPJBQp1zvlI9ROB2xJaOt24wi6gPK4y2jUwMgYrBYwxbT/TiUvWG82FeUJi1nDaPQl/P5S5W14D0pKOlqnn99xtlH9uNShxKOr9DqQ2DzjsrL4FcX/sEruh/ksMHWoqnk+Ao3GCrM/0Rvs65crWW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNN66PJi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNN66PJi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725611596; x=1757147596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zmIzBGzPhAHx+Euq/bqrWY8v0HnZGvvLQuM0MmZFwNE=;
  b=RNN66PJiaLKbb5THIctvuDeFS1BTd4bP6wabdFDs8JCEKQqmftls/cGJ
   yB0QntWVK9vZGhiRtSFJsDkdYTgCHUAHFeMB2kx80XbE09YlDbxJgkUQd
   SO3wCjygWW+fMU9IJTOYK8K40N5SmZ00IT229dx/dVmolzwEbfu7Q6ViI
   rXlYE7676wMJbnHpSO/vTOzXaU+PQT/r2dinK7uM3J2tqH+EluF2Z71TO
   pE0IDgkRbukzO3sa0/kKRyHqiI067hB5Cg0x63Y5zwmTlpdH6ihUZu5dq
   ukvH4d5RBaQu1aIYCwONJYdO68EkVAPyf3WxmEn+FEMelTbXorccR1NfQ
   w==;
X-CSE-ConnectionGUID: BqiIABtGSkuOnnKTB8nM6Q==
X-CSE-MsgGUID: R8IHWz3eSMqOKQF3SFte8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="28246463"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="28246463"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 01:33:15 -0700
X-CSE-ConnectionGUID: Qe6zzl1GTz2FnEzc5EoIRw==
X-CSE-MsgGUID: +M+0jYE4SiCI6hIiLWTTfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="65937907"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 01:33:13 -0700
Message-ID: <4a4dc281-34b7-473b-892b-7227530f6d56@intel.com>
Date: Fri, 6 Sep 2024 11:33:08 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-4-avri.altman@wdc.com>
 <fc704a6e-962e-4294-9d97-ca43144adbc6@intel.com>
 <DM6PR04MB6575CF2F7CBDEB87949965D7FC9E2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB6575CF2F7CBDEB87949965D7FC9E2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/09/24 11:20, Avri Altman wrote:
>>
>> On 4/09/24 17:52, Avri Altman wrote:
>>> For open-ended read/write - just send CMD22 before issuing the command.
>>> While at it, make sure that the rw command arg is properly casting the
>>> lower 32 bits, as it can be larger now.
>>>
>>> Signed-off-by: Avri Altman <avri.altman@wdc.com>
>>> ---
>>>  drivers/mmc/core/block.c | 6 +++++-
>>>  drivers/mmc/core/core.c  | 3 +++
>>>  include/linux/mmc/core.h | 5 +++++
>>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
>>> cc7318089cf2..54469261bc25 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -226,6 +226,7 @@ static void mmc_blk_rw_rq_prep(struct
>>> mmc_queue_req *mqrq,  static void mmc_blk_hsq_req_done(struct
>>> mmc_request *mrq);  static int mmc_spi_err_check(struct mmc_card
>>> *card);  static int mmc_blk_busy_cb(void *cb_data, bool *busy);
>>> +static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct
>>> +mmc_host *host);
>>
>> Not using mmc_blk_wait_for_idle() anymore.
> Done.
> 
>>
>>>
>>>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)  { @@
>>> -1710,7 +1711,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req
>>> *mqrq,
>>>
>>>       brq->mrq.cmd = &brq->cmd;
>>>
>>> -     brq->cmd.arg = blk_rq_pos(req);
>>> +     brq->cmd.arg = blk_rq_pos(req) & 0xFFFFFFFF;
>>
>> arg is 32 bits so not needed
> Done.
> 
>>
>>>       if (!mmc_card_blockaddr(card))
>>>               brq->cmd.arg <<= 9;
>>>       brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>> @@
>>> -1758,6 +1759,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req
>> *mqrq,
>>>                       (do_data_tag ? (1 << 29) : 0);
>>>               brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>>>               brq->mrq.sbc = &brq->sbc;
>>> +     } else if (mmc_card_ult_capacity(card)) {
>>
>> The 'else' isn't actually needed, is it?  Might as well keep sbc and ext_addr
>> separate in this patch.
> Sorry - I don't follow what you mean.
> Doesn't the else implies open-ended?

Disallowing SDUC with close-ended seems like a separate
issue.  The 'else' is not actually required, is it?

> 
>>
>>> +             brq->cmd.ext_addr = (blk_rq_pos(req) >> 32) & 0x3F;
>>
>> '& 0x3f' should not be needed. i.e. we either validate blk_rq_pos(req) (no point)
>> or we assume it is valid.
> Done.
> 
>>
>>> +             brq->cmd.has_ext_addr = 1;
>>
>> If you switch to bool, that could use 'true' instead of '1'
> Done.
> 
> Thanks,
> Avri
> 
>>
>>>       }
>>>  }
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>>> d6c819dd68ed..a0b2999684b3 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -336,6 +336,9 @@ int mmc_start_request(struct mmc_host *host,
>>> struct mmc_request *mrq)  {
>>>       int err;
>>>
>>> +     if (mrq->cmd && mrq->cmd->has_ext_addr)
>>> +             mmc_send_ext_addr(host, mrq->cmd->ext_addr);
>>> +
>>>       init_completion(&mrq->cmd_completion);
>>>
>>>       mmc_retune_hold(host);
>>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h index
>>> f0ac2e469b32..41c21c216584 100644
>>> --- a/include/linux/mmc/core.h
>>> +++ b/include/linux/mmc/core.h
>>> @@ -76,6 +76,11 @@ struct mmc_command {
>>>   */
>>>  #define mmc_cmd_type(cmd)    ((cmd)->flags & MMC_CMD_MASK)
>>>
>>> +     /* for SDUC */
>>> +     u8 has_ext_addr;
>>> +     u8 ext_addr;
>>> +     u16 reserved;
>>> +
>>>       unsigned int            retries;        /* max number of retries */
>>>       int                     error;          /* command error */
>>>
> 

