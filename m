Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2101CDA02
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 04:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725339404; cv=none; b=hrfjt4otAyKAt8s4oH4emnpfQbu6A9jOv4CugipMjw9BclcQZ1rZS1qqz9+QJHVLBvJlAbcXzIfjMq1027ZadYTi52WIXz+n0qKXeBp3k1qo1/01eVN5JblF7bL/1CUCSnDzGsN898UVFGzfJZO/ArJ3mFLY/ggA1hdgy0bg7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725339404; c=relaxed/simple;
	bh=Kq+mqvBPf64p7qgffJAv0PjrIpLE2Hv2kwWjlQBQZtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCa6L3VDveHEYNJSSsn3fF0ZagvRxwj1791muutHKCA6tM3IkYaSrVxSPd8RrdsGXefB7YWO3MJxRwCi/LCGUuSsmpXo6iioj1F1PQa4qNfAh0zfAk539Hth7ClI2zT1gafuoNHOYD3RN1XwN3j2NzM1Cq/xk1Bs8HdClFTp+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2O6j3GZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2O6j3GZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725339402; x=1756875402;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kq+mqvBPf64p7qgffJAv0PjrIpLE2Hv2kwWjlQBQZtk=;
  b=X2O6j3GZdamgXd5aI4950rc784cp28Ul+MXBayb0g5WnxU9ysYjvAjFL
   lE+twxODCmuSVEgpExWLzyqr5bktKzSQDtVLIiC2Aed0kiGd5qk2/62SD
   opzRvVIz83878YTDAF0k7CRA/OJn5XqqggqjHPecpXsFCzrWe7/stJ1cX
   bYJzjfGNyZyHSkCtxiqpXqWY4+Ba3ARHnmxm3EOFGsUCxMvVkIgJzjISy
   amkRX6eB1z89unjuZnbEGVHKpNjfxDA5e3zloQeyltfHQZUwfQAcmSH2G
   dgUSIF6wurZpfeWCLxt/Vr5dWXb5Lkkl7KlYqQ4IbgTkNiMCyfbByoWRZ
   g==;
X-CSE-ConnectionGUID: oVmy7/32RDWTB67aFIXriA==
X-CSE-MsgGUID: KdLnX48eRh+Qe6lENMZZKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="23431508"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="23431508"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 21:56:42 -0700
X-CSE-ConnectionGUID: TY0E5KlbRaqdbtz0QoDPUA==
X-CSE-MsgGUID: 3n38qBSYT6+7QeMucnnoHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="69575178"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 21:56:39 -0700
Message-ID: <8c040805-e3cf-43d3-b806-206c3147052c@intel.com>
Date: Tue, 3 Sep 2024 07:56:34 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] mmc: core: Add open-ended Ext memory addressing
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20240827122342.3314173-1-avri.altman@wdc.com>
 <20240827122342.3314173-4-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240827122342.3314173-4-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/24 15:23, Avri Altman wrote:
> For open-ended read/write - just send CMD22 before issuing the command.
> While at it, make sure that the rw command arg is properly casting the
> lower 32 bits, as it can be larger now.
> 
> Tested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 2c9963248fcb..8816b3f0a312 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -180,6 +180,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
>  static int mmc_spi_err_check(struct mmc_card *card);
>  static int mmc_blk_busy_cb(void *cb_data, bool *busy);
> +static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host);
>  
>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>  {
> @@ -1664,7 +1665,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  
>  	brq->mrq.cmd = &brq->cmd;
>  
> -	brq->cmd.arg = blk_rq_pos(req);
> +	brq->cmd.arg = blk_rq_pos(req) & 0xFFFFFFFF;
>  	if (!mmc_card_blockaddr(card))
>  		brq->cmd.arg <<= 9;
>  	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> @@ -1712,6 +1713,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  			(do_data_tag ? (1 << 29) : 0);
>  		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>  		brq->mrq.sbc = &brq->sbc;
> +	} else if (mmc_card_ult_capacity(card)) {
> +		mmc_blk_wait_for_idle(mq, card->host);
> +		mmc_send_ext_addr(card->host, blk_rq_pos(req));

Did you consider having mmc_start_request() send CMD22?
e.g.

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d6c819dd68ed..22677a01c0e3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -336,6 +336,9 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
 	int err;
 
+	if (mrq->cmd && mrq->cmd->ext_addr)
+		mmc_send_ext_addr(card->host, mrq->cmd->ext_addr);
+
 	init_completion(&mrq->cmd_completion);
 
 	mmc_retune_hold(host);

>  	}
>  }
>  

