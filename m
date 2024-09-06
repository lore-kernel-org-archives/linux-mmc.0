Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856B015699E
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725609781; cv=none; b=TeZTnT3c5TbPatQx+YM0AOUScrnumX12CamSJ7On9yitOTmFrPftbxD0BA5vQ30Fdluitmhkk2AvGTzUOB/3R1uZiG83Ef2RqGyxUhU8rSlqUDb2STscGKNyfh7viGBIGulYvvYiERBR0iXlXltuUcncL2qxKvTaxlwSlHs9atc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725609781; c=relaxed/simple;
	bh=yD2INolfcaNHhi9RInezNLr9gus1Z1lICnJKqTXlQNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzfCNWCwGDdggb3qY6TwJGXxhA311scTyL1HrooL2JHrcUeK6zEGGtm093rAY7jG4c0pNz3wtF4ldsFemmM+gLKRgut+fRGqN2linrRv6faqlUnFM+mYbu+coB96yFCiGQFAE6WaVAydJpb2aBMWg8zuAePAZOUPkNLnIPd3O4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHbFAuDK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHbFAuDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725609778; x=1757145778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yD2INolfcaNHhi9RInezNLr9gus1Z1lICnJKqTXlQNg=;
  b=WHbFAuDKyeHHbSY6yOpzf+hcepP8UucycHulsz30W508FXjHu2VuqvP/
   yYWgRbM+AZtzWx/UBn/udAZN3M8CFw1mjE8FHhbL24vOvnmThd2riR8Wg
   uq1H5P9zo12liMDu+QTi8P3oZWeczgWk2hco9SLgLtkdHqgMG8lTo7A8v
   UJ1EisWhphIrIcXvGO28bpX1MQY2y5PnbFbcgD3oHavw279gH/MmFfvUc
   i+FPZRxn6yKtRLlxzrY6k7Nts4umFDzIc2gFSrpQPwHguaFgqqdb+Y13G
   8m+M1pA+4syrQsFTzuOKdRr20ROe7bc1+RLg51t/a7uJP8i14PdtO1ADz
   g==;
X-CSE-ConnectionGUID: S1YohuSaSiOIfbX4o8yU8A==
X-CSE-MsgGUID: qHnbWBumT3yeKdjUoWVKTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="35508798"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="35508798"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 01:02:57 -0700
X-CSE-ConnectionGUID: yZPvHzsaR0a6lbDjnhv/zg==
X-CSE-MsgGUID: fCqwqg8hRDqXpfBCZjgZrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="70817501"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 01:02:56 -0700
Message-ID: <fc704a6e-962e-4294-9d97-ca43144adbc6@intel.com>
Date: Fri, 6 Sep 2024 11:02:50 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-4-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240904145256.3670679-4-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/09/24 17:52, Avri Altman wrote:
> For open-ended read/write - just send CMD22 before issuing the command.
> While at it, make sure that the rw command arg is properly casting the
> lower 32 bits, as it can be larger now.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c | 6 +++++-
>  drivers/mmc/core/core.c  | 3 +++
>  include/linux/mmc/core.h | 5 +++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index cc7318089cf2..54469261bc25 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -226,6 +226,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
>  static int mmc_spi_err_check(struct mmc_card *card);
>  static int mmc_blk_busy_cb(void *cb_data, bool *busy);
> +static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host);

Not using mmc_blk_wait_for_idle() anymore.

>  
>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>  {
> @@ -1710,7 +1711,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  
>  	brq->mrq.cmd = &brq->cmd;
>  
> -	brq->cmd.arg = blk_rq_pos(req);
> +	brq->cmd.arg = blk_rq_pos(req) & 0xFFFFFFFF;

arg is 32 bits so not needed

>  	if (!mmc_card_blockaddr(card))
>  		brq->cmd.arg <<= 9;
>  	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> @@ -1758,6 +1759,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  			(do_data_tag ? (1 << 29) : 0);
>  		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>  		brq->mrq.sbc = &brq->sbc;
> +	} else if (mmc_card_ult_capacity(card)) {

The 'else' isn't actually needed, is it?  Might as well keep sbc
and ext_addr separate in this patch.

> +		brq->cmd.ext_addr = (blk_rq_pos(req) >> 32) & 0x3F;

'& 0x3f' should not be needed. i.e. we either validate blk_rq_pos(req)
(no point) or we assume it is valid.

> +		brq->cmd.has_ext_addr = 1;

If you switch to bool, that could use 'true' instead of '1'

>  	}
>  }
>  
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d6c819dd68ed..a0b2999684b3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -336,6 +336,9 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  {
>  	int err;
>  
> +	if (mrq->cmd && mrq->cmd->has_ext_addr)
> +		mmc_send_ext_addr(host, mrq->cmd->ext_addr);
> +
>  	init_completion(&mrq->cmd_completion);
>  
>  	mmc_retune_hold(host);
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index f0ac2e469b32..41c21c216584 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -76,6 +76,11 @@ struct mmc_command {
>   */
>  #define mmc_cmd_type(cmd)	((cmd)->flags & MMC_CMD_MASK)
>  
> +	/* for SDUC */
> +	u8 has_ext_addr;
> +	u8 ext_addr;
> +	u16 reserved;
> +
>  	unsigned int		retries;	/* max number of retries */
>  	int			error;		/* command error */
>  

