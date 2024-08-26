Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A244A28
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654601; cv=none; b=MZgwvhwZb35Kg/lUhEq2y1O0GWoNfHktL5qiWNeG5Tjod+QckT73mYpdgVjY6R/h0agzVzlRymYnVx9x2GIA1prlL5YqewUuDdKV/rZARDNjSkC23aLA72Ewz8tD6veYrPpV2mE8pid5y7eSj7R9pOEDkn5RPqhiXWY8dDNBZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654601; c=relaxed/simple;
	bh=LjFLTMD8IXDFa0EjumbNgc79K4tIhHACmyjfa+m3y/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBaNrcp6Mh5AH5N9xA5uJJAi9p2a6kDavr8+sIlNxN8waf3414iXU1l9LfswTPrO7E4jNTsMdvYWrJApJXpSMNN0Mg7VmVKGK+YFvAEUDf65L049NIM68r+rLLc5QlxRzy6PqdryJQi3CiJEOch7EWlpYPLkiV/mWLIz813nM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5nzeCXd; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5nzeCXd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724654599; x=1756190599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LjFLTMD8IXDFa0EjumbNgc79K4tIhHACmyjfa+m3y/0=;
  b=l5nzeCXdhBe3vW9WJGfNFxyEGrKhRQ2k3xx+a7y1ExXuWoWy+8eFmIeZ
   yusatVujwJj+6RgzNfHRAA+lgCjsjXzIiIC3ixQ9QSAOuL19RS+/I2Fva
   NVAXsJKoIxqQI5wpwffIoptCv4dUBfEqL+LACsN/BSF6Y0KK1DH68C7uo
   PYStdk7mto+i7CSMZSSWwAk5u+HB2b1w/JrrWQeWSAWjPGxr4OMyIOR0S
   rimR+VjAdlGLwMEuxosyCgSq/gC0R1OhZyTVxAllHED5LopCYkqezXvu5
   WExgWN61kL2OcjX0Rcyz/720JB7047eZUWoIi0fttza0OWxd3y3iYw6PD
   Q==;
X-CSE-ConnectionGUID: UHUrbSbYRbyNRyiFITHanA==
X-CSE-MsgGUID: 34ztala1TFWtBhGlZfy7hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="23188314"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="23188314"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 23:43:19 -0700
X-CSE-ConnectionGUID: fB1nGU1GSD6gkoEMiWlvRA==
X-CSE-MsgGUID: SphvCCI7TemXGvLwjiSWEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="67109551"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 23:43:16 -0700
Message-ID: <2518dcfc-452c-4464-a989-b6e4e02772e5@intel.com>
Date: Mon, 26 Aug 2024 09:43:13 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] mmc: sd: Add Extension memory addressing
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <20240825074141.3171549-3-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240825074141.3171549-3-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/08/24 10:41, Avri Altman wrote:
> SDUC memory addressing spans beyond 2TB and up to 128TB.  Therefore, 38
> bits are required to access the entire memory space of all sectors.
> Those extra 6 bits are to be carried by CMD22 prior of sending
> read/write/erase commands: CMD17, CMD18, CMD24, CMD25, CMD32, and CMD33.
> 
> CMD22 will carry the higher order 6 bits, and must precedes any of the
> above commands even if it targets sector < 2TB.
> 
> No error related to address or length is indicated in CMD22 but rather
> in the read/write command itself.
> 
> Tested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/sd_ops.c | 16 ++++++++++++++++
>  drivers/mmc/core/sd_ops.h |  1 +
>  include/linux/mmc/sd.h    |  3 +++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 8b9b34286ef3..780c5dd7266f 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -16,6 +16,7 @@
>  #include <linux/mmc/sd.h>
>  
>  #include "core.h"
> +#include "card.h"
>  #include "sd_ops.h"
>  #include "mmc_ops.h"
>  
> @@ -188,6 +189,21 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>  	return 0;
>  }
>  
> +int mmc_send_ext_addr(struct mmc_host *host, sector_t addr)
> +{
> +	struct mmc_command cmd = {
> +		.opcode = SD_ADDR_EXT,
> +		.arg = (u32)((addr >> 32) & 0x3F),

If addr were outside the acceptable range, then the command
should fail, which is what we want, so better to leave out
the mask i.e.

		.arg = (u32)(addr >> 32),


> +		.flags = MMC_RSP_R1 | MMC_CMD_AC,
> +	};
> +
> +	if (!mmc_card_ult_capacity(host->card))
> +		return 0;
> +
> +	return mmc_wait_for_cmd(host, &cmd, 0);
> +}
> +EXPORT_SYMBOL_GPL(mmc_send_ext_addr);
> +
>  static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 pcie_bits,
>  			      u32 *resp)
>  {
> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> index 7667fc223b74..462efd43acfa 100644
> --- a/drivers/mmc/core/sd_ops.h
> +++ b/drivers/mmc/core/sd_ops.h
> @@ -21,6 +21,7 @@ int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
>  int mmc_app_send_scr(struct mmc_card *card);
>  int mmc_app_sd_status(struct mmc_card *card, void *ssr);
>  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
> +int mmc_send_ext_addr(struct mmc_host *host, sector_t addr);
>  
>  #endif
>  
> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
> index 865cc0ca8543..af5fc70e09a2 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> @@ -15,6 +15,9 @@
>  #define SD_SEND_IF_COND           8   /* bcr  [11:0] See below   R7  */
>  #define SD_SWITCH_VOLTAGE         11  /* ac                      R1  */
>  
> +/* Class 2 */
> +#define SD_ADDR_EXT		 22   /* ac   [5:0]              R1  */
> +
>    /* class 10 */
>  #define SD_SWITCH                 6   /* adtc [31:0] See below   R1  */
>  

