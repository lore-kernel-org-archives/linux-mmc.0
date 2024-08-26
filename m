Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1D78281
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654099; cv=none; b=IL9sxVPoQjSfwJPVdOTlH5rejJnpJpbKvtDhL3EFoD1nwK6vQ6lCgsVn6nHsm7Pyg69WJcv7EbTMrX1VJQZP/VGF9DO6tsndHDgvl+tVh2wJw81g2o7kZxdnr3D8LZ3MJccW24LsMIXaocO6d4myfVjo3W9ENVZj6+08r2Zskws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654099; c=relaxed/simple;
	bh=FewD7xvmTZaZ1Xcj/tX8dYw5kMa+P+IcNYAKe9UbOkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0gHzHLOgdoYZvDBOk3Whukn/yrzL+nBZ//0cZkKjtDW8sd2jL6CW9cZIdKjF0z/UvVl7GYzBk9tc4+QoccVpOj6QZEaKQCB/j+3EgKty5Lufw1Y6aaxX2+vR4KT77/N21a4BzMhi+0wShXDJgLMtvOpgP3J020VuKTbTkfunaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVe1QYmp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVe1QYmp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724654096; x=1756190096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FewD7xvmTZaZ1Xcj/tX8dYw5kMa+P+IcNYAKe9UbOkc=;
  b=eVe1QYmpGGuVtjCkbM5OC9DGfgJgc1/zVPs757y1Ygb7QJ4uABJkHvR/
   PXlZkvzkFYz3YuHZWN1PXpjI0QQBFCZ0D9L3GBgFHLPuTbjOycjenV6Xd
   UMYOJrDMj2LrAUYTMpfTi4EaKl6d/prkS79vcBieZ0u6PRatE5hWk4+gK
   M5JNUDUoAd9wVs5faYI9wJNI8Xoe/+M5qzdt1v53pYama1O08Ggoi/UEi
   paYG5BZ2xUR1e8/uCMaSKofEM55I6U42FjlwKckHv6fWC19APHNYntC/r
   E9G19TVObl4XdIV5flqYcj2bA2c/56DT8UduZHHv1W679OIbjYtExwUmH
   g==;
X-CSE-ConnectionGUID: d5DrMpfRQOeS0ZafVA4Gnw==
X-CSE-MsgGUID: PZ0jgVPhS5OJO5q/mR9Qmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="26852304"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="26852304"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 23:34:55 -0700
X-CSE-ConnectionGUID: pPV/AFy6SIqOoLyj3aB9Ow==
X-CSE-MsgGUID: FSl3hgdJT1ukjhvvR0TQJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="67338500"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 23:34:54 -0700
Message-ID: <9e2bf183-17a6-42a0-ba60-4a2384e53ca8@intel.com>
Date: Mon, 26 Aug 2024 09:34:49 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] mmc: core: Adjust ACMD22 to SDUC
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <20240825074141.3171549-10-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240825074141.3171549-10-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/08/24 10:41, Avri Altman wrote:
> ACMD22 is used to verify the previously write operation.  Normally, it
> returns the number of written sectors as u32.  SDUC, however, returns it
> as u64.  This is not a superfluous requirement, because SDUC writes may
> exceeds 2TB.  For Linux mmc however, the previously write operation
> could not be more than the block layer limits, thus we make room for a
> u64 and cast the returning value to u32.
> 
> Moreover, SD cards expect to be allowed the full 500msec busy period
> post write operations.  This is true for standard capacity SD, and even
> more so for high volume SD cards, specifically SDUC.  If CMD13 return an
> error bit, the recovery flow is entered regardless of the busy period.
> Thus, better enforce the busy period for SDUC, otherwise it might return
> a bogus bytes written.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ace701273230..b73fdef1cb0d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -48,6 +48,7 @@
>  #include <linux/mmc/sd.h>
>  
>  #include <linux/uaccess.h>
> +#include <asm/unaligned.h>
>  
>  #include "queue.h"
>  #include "block.h"
> @@ -948,13 +949,20 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>  	int err;
>  	u32 result;
>  	__be32 *blocks;
> -
> +	u8 resp_sz;
>  	struct mmc_request mrq = {};
>  	struct mmc_command cmd = {};
>  	struct mmc_data data = {};
> -
>  	struct scatterlist sg;
>  
> +	/*
> +	 * SD cards, specifically high volume cards, expect to be allowed with the
> +	 * full 500msec busy period post write. Otherwise, they may not indicate
> +	 * correctly the number of bytes written.
> +	 */
> +	if (mmc_card_ult_capacity(card))
> +		mmc_delay(500);

To get here, it should have had to go through:

	/* Try to get back to "tran" state */
	if (!mmc_host_is_spi(mq->card->host) &&
	    (err || !mmc_ready_for_data(status)))
		err = mmc_blk_fix_state(mq->card, req);

which would mean the card is not indicating "busy".
Either that is not working, or it seems like an issue
with the card, in which case it could be a card quirk
perhaps.

> +
>  	err = mmc_app_cmd(card->host, card);
>  	if (err)
>  		return err;
> @@ -963,7 +971,14 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>  	cmd.arg = 0;
>  	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>  
> -	data.blksz = 4;
> +	/*
> +	 * Normally, ACMD22 returns the number of written sectors as u32.
> +	 * SDUC, however, returns it as u64.  This is not a superfluous
> +	 * requirement, because SDUC writes may exceed 2TB.
> +	 */
> +	resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
> +
> +	data.blksz = resp_sz;
>  	data.blocks = 1;
>  	data.flags = MMC_DATA_READ;
>  	data.sg = &sg;
> @@ -973,15 +988,25 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>  	mrq.cmd = &cmd;
>  	mrq.data = &data;
>  
> -	blocks = kmalloc(4, GFP_KERNEL);
> +	blocks = kmalloc(resp_sz, GFP_KERNEL);
>  	if (!blocks)
>  		return -ENOMEM;
>  
> -	sg_init_one(&sg, blocks, 4);
> +	sg_init_one(&sg, blocks, resp_sz);
>  
>  	mmc_wait_for_req(card->host, &mrq);
>  
> -	result = ntohl(*blocks);
> +	if (mmc_card_ult_capacity(card)) {
> +		u64 blocks_64 = get_unaligned_be64(blocks);
> +		/*
> +		 * For Linux mmc however, the previously write operation could
> +		 * not be more than the block layer limits, thus just make room
> +		 * for a u64 and cast the response back to u32.
> +		 */
> +		result = blocks_64 > UINT_MAX ? UINT_MAX : (u32)blocks_64;
> +	} else {
> +		result = ntohl(*blocks);
> +	}
>  	kfree(blocks);
>  
>  	if (cmd.error || data.error)

