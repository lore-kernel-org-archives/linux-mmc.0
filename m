Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E615749A
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620266; cv=none; b=ad9O8i/XyVGaLSunTyoEurWpqfpjy3VcrVmzcrAAS4EBrPEEF0+j7ObJqez8ebIIyiwGtdogTlgswvRyjsEEIvrbL6+vP87Q6RhHmJhv4NI0zpthfjFwiG1OaKYviFV7il9+Y/q0BRs5MH0ZSKgzeSEapJwv8rIQaZhYihKzlB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620266; c=relaxed/simple;
	bh=Bio1b4zO10BlAR9QAv4hzn7OvDqCLypWybdsBkKWx6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLG/jteCPYLoDd+oFeERlOLd9IvpVxp410vR/djgopPNVLSskZnDqeVWS/q6VocBMcPZPGnhoPPYlI4q1YCzu6JXn2ZsdqXAQ3WbuUUwChMQKfpr0+6LnXVRix8aF447LWIzJznJVWSNe4/Xr502NuYDe1EIKgiq1bDdkrogpDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1c45ZFW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1c45ZFW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725620265; x=1757156265;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bio1b4zO10BlAR9QAv4hzn7OvDqCLypWybdsBkKWx6k=;
  b=W1c45ZFWSLVCijFpLSLSMjmZA22rhAqidRT5OJx5vSJBYwfG0GF2/ufz
   QxH+xa2cr8/JsSh0ztiLJIc6HsippkuiyAH3nzNvU7ERn1WCihswMsTri
   B2jNhMlbFDpMDtqO/ySuPY8jMUJ0YzVLEXmmcVnc/1nryoCutiWI000hg
   KbQotgrPk1esUPgrWt8bLteCRXIjdVShmxbGhyV9WWkF0Tq58qPYqLaRT
   PK6QgJINWX8+IchI0afx4dae6Sj3z82wBeKXPGNUZ1q4u4mXCM0uQkHsY
   OaGL3cznvbjmisjctc9NgodGXlyleXHxeQ+Xgq2+vb8Zlwb9OdQ3Oa/SI
   g==;
X-CSE-ConnectionGUID: vp00diOET2SYxNLySbzF9A==
X-CSE-MsgGUID: DlmJVm8lTBiYpK+0MBxIzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24529355"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="24529355"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 03:57:45 -0700
X-CSE-ConnectionGUID: GtaXTRz8TjK4xOIUkfVDSw==
X-CSE-MsgGUID: TJ85YPkySxe03kvRtnhdFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="70859473"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 03:57:42 -0700
Message-ID: <3016fd71-885b-4ef9-97ed-46b4b0cb0e35@intel.com>
Date: Fri, 6 Sep 2024 13:57:21 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] mmc: core: Adjust ACMD22 to SDUC
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-8-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240904145256.3670679-8-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/09/24 17:52, Avri Altman wrote:
> ACMD22 is used to verify the previously write operation.  Normally, it
> returns the number of written sectors as u32.  SDUC, however, returns it
> as u64.  This is not a superfluous requirement, because SDUC writes may
> exceeds 2TB.  For Linux mmc however, the previously write operation
> could not be more than the block layer limits, thus we make room for a
> u64 and cast the returning value to u32.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 50d37c4f5a50..f36611512a1d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -50,6 +50,7 @@
>  #include <linux/mmc/sd.h>
>  
>  #include <linux/uaccess.h>
> +#include <asm/unaligned.h>
>  
>  #include "queue.h"
>  #include "block.h"
> @@ -994,11 +995,10 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>  	int err;
>  	u32 result;
>  	__be32 *blocks;
> -
> +	u8 resp_sz;

Could do the initialization here i.e.

	u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;

>  	struct mmc_request mrq = {};
>  	struct mmc_command cmd = {};
>  	struct mmc_data data = {};
> -
>  	struct scatterlist sg;
>  
>  	err = mmc_app_cmd(card->host, card);
> @@ -1009,7 +1009,14 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
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
> @@ -1019,15 +1026,25 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>  	mrq.cmd = &cmd;
>  	mrq.data = &data;
>  
> -	blocks = kmalloc(4, GFP_KERNEL);
> +	blocks = kmalloc(resp_sz, GFP_KERNEL);

Separate issue, but this should probably be GFP_NOIO, or
just have the buffer in mmc_host or mmc_card

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

Perhaps:
		result = clamp_val(get_unaligned_be64(blocks), 0, UINT_MAX);

> +	} else {
> +		result = ntohl(*blocks);
> +	}
>  	kfree(blocks);
>  
>  	if (cmd.error || data.error)

