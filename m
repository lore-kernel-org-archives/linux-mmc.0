Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CFB82863
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488028; cv=none; b=qMmGQ9uL7cw2hO7PZAFz10IfSaXYEa8J3IH9YDPfIhr10sJLNneaXJGj00e+HC5khx7J/H3jeEhQtaE+oDqjTQfpcVbC9JhGLlUAjyEEr3tyl3yQXbiufrgZxwbS8+LSau5CTkczuh16SGKPycakC9iqiw/1w6TTKSKLWxZn5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488028; c=relaxed/simple;
	bh=2lSqEGIuJhIaDFVz0YjAEK1hrX8OXxlbcYlQvWRocJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrBEozaiJ4Et06uMemsjuAR+px/RhrKuS95fVMNSjw4NbgQdjEe6lY5qLJNLcm9qpKAdo0U8ielo9cz59gbz+S09tFZk3boDfnm9fDdGgIiZHs8mXR7on0a4XRDzQLjMdhZ8U/3NhvycwNR9hqIrCtW39gnp2fdTJuo8KDShtjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06BCCFEC;
	Wed,  4 Sep 2024 15:14:10 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C6B63F73F;
	Wed,  4 Sep 2024 15:13:42 -0700 (PDT)
Message-ID: <1cfe2dc9-5525-43df-9d79-98472df1d3d5@arm.com>
Date: Wed, 4 Sep 2024 23:13:39 +0100
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
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>,
 Shawn Lin <shawn.lin@rock-chips.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-4-avri.altman@wdc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240904145256.3670679-4-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/24 15:52, Avri Altman wrote:
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
>  
>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>  {
> @@ -1710,7 +1711,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  
>  	brq->mrq.cmd = &brq->cmd;
>  
> -	brq->cmd.arg = blk_rq_pos(req);
> +	brq->cmd.arg = blk_rq_pos(req) & 0xFFFFFFFF;
>  	if (!mmc_card_blockaddr(card))
>  		brq->cmd.arg <<= 9;
>  	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> @@ -1758,6 +1759,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  			(do_data_tag ? (1 << 29) : 0);
>  		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>  		brq->mrq.sbc = &brq->sbc;
> +	} else if (mmc_card_ult_capacity(card)) {
> +		brq->cmd.ext_addr = (blk_rq_pos(req) >> 32) & 0x3F;
> +		brq->cmd.has_ext_addr = 1;
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

We should check that this was actually successful, right?

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

Is there a reason for has_ext_addr being u8?
What's the reserved for?

> +
>  	unsigned int		retries;	/* max number of retries */
>  	int			error;		/* command error */
>  

