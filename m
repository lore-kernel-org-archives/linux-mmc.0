Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1F167DA8;
	Wed, 21 Aug 2024 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724218634; cv=none; b=U30ZFdIo8OKqlscRUy7j9L+oJAIr77wowUYYoEHq9uUA/J+kSX2Ny74kjTXQfkITIPG+NbNDLFS8BVT/39O5szxQ6Egdm3WQnyjmY6OEcAt28xw9nMbcEc7syoUJou2Cc0/O09IGTeHmoVV9JwYcHLX9h12ove5g52mbeahQkrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724218634; c=relaxed/simple;
	bh=x5UTJZX0ZLH5C/Dce7T1iODn22VWI1qir06qAOV+O6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oakjF8ypcFYQi/AcC/1Swf/57XBciuAedOACKfv1bgyv6BDKSOkutdi7Wg2Lp9WFiJBw3RItlqHa4SfRTcDQBHa8Udaf9AoIni4LT6HE+8cdGMOlaqhIRctT5lblCn+GK0BR1ixd3e4atYufGr+tPtMDAWYJff02Fdcr6XvMHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdInEfxT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdInEfxT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724218633; x=1755754633;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x5UTJZX0ZLH5C/Dce7T1iODn22VWI1qir06qAOV+O6o=;
  b=cdInEfxTW2BnNOudVnPaIgQDm1zUFWMtdMefAxxaMdu7ZVSY+4tUqQPz
   nw4k356geAq3GTkD9UBYcmPKXedAAwZRfrwq4pwkspZ9jJzQSzK/Sudyy
   wqA/fBmib487JraMl8hua9LB+GoGLpxEfk7RtjTTeqJ/tFi45XKBiNELE
   CtY7vZTyenPJ2cv9irMg1KV7KLJjVKy3z8Xikvm7vdH+4wMOjbbZDnUFx
   DNQzkVA5/Kx6wvlA6SkBfI0LaUB10l0QUI6EFPwnhgWbCMDqR9nPBNZf7
   63VfOzzCJT+u3HfBwiGgSWKFkxCiVoC9J1H2tAvbTzgINXZC8BKWrgQuj
   g==;
X-CSE-ConnectionGUID: nkdZQHhyRx29WIn+67KyNQ==
X-CSE-MsgGUID: xfZQddbkQmSki2eS9WJpuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="13126445"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="13126445"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 22:37:12 -0700
X-CSE-ConnectionGUID: /rJ6b9s3R6KXd0bHBmvDqg==
X-CSE-MsgGUID: nbM3ILkZQ86jVvJ9vTHyNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="91759872"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 22:37:10 -0700
Message-ID: <4a563aad-e9b3-43af-8ce5-5d30dace2dd8@intel.com>
Date: Wed, 21 Aug 2024 08:37:07 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci_am654: Add retry tuning
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815201542.421653-1-jm@ti.com>
 <20240815201542.421653-2-jm@ti.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240815201542.421653-2-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/24 23:15, Judith Mendez wrote:
> Add retry tuning up to 10 times if we fail to find
> a failing region or no passing itapdly. This is
> necessary since some eMMC's have been observed to never
> find a failing itapdly on the first couple of tuning
> iterations, but eventually do. It been observed that the
> tuning algorithm does not need to loop more than 10 times
> before finding a failing itapdly.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 64e10f7c9faa3..c3d485bd4d553 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -86,6 +86,7 @@
>  
>  #define CLOCK_TOO_SLOW_HZ	50000000
>  #define SDHCI_AM654_AUTOSUSPEND_DELAY	-1
> +#define RETRY_TUNING_MAX	10
>  
>  /* Command Queue Host Controller Interface Base address */
>  #define SDHCI_AM654_CQE_BASE_ADDR 0x200
> @@ -151,6 +152,7 @@ struct sdhci_am654_data {
>  	u32 flags;
>  	u32 quirks;
>  	bool dll_enable;
> +	u32 tuning_loop;
>  
>  #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>  };
> @@ -453,12 +455,14 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
>  	int prev_fail_end = -1;
>  	u8 i;
>  
> -	if (!num_fails)
> -		return ITAPDLY_LAST_INDEX >> 1;
> +	if (!num_fails) {
> +		/* Retry tuning */
> +		return -1;
> +	}
>  
>  	if (fail_window->length == ITAPDLY_LENGTH) {
> -		dev_err(dev, "No passing ITAPDLY, return 0\n");
> -		return 0;
> +		/* Retry tuning */
> +		return -1;
>  	}
>  
>  	first_fail_start = fail_window->start;
> @@ -504,6 +508,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>  	u8 curr_pass, itap;
>  	u8 fail_index = 0;
>  	u8 prev_pass = 1;
> +	int ret;
>  
>  	memset(fail_window, 0, sizeof(fail_window));
>  
> @@ -532,10 +537,20 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>  	if (fail_window[fail_index].length != 0)
>  		fail_index++;
>  
> -	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
> -					  sdhci_am654->dll_enable);
> +	ret = sdhci_am654_calculate_itap(host, fail_window, fail_index,
> +					 sdhci_am654->dll_enable);
>  
> -	sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
> +	if (ret >= 0) {
> +		itap = ret;
> +		sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
> +	} else {
> +		if (sdhci_am654->tuning_loop < RETRY_TUNING_MAX) {
> +			sdhci_am654->tuning_loop++;
> +			sdhci_am654_platform_execute_tuning(host, opcode);

The kernel uses very small stack size, so recursive function calls
should not be used.  It would be better to put the loop in a separate
function, or add a retry: label and goto retry.

> +		} else {
> +			return -1;
> +		}
> +	}
>  
>  	/* Save ITAPDLY */
>  	sdhci_am654->itap_del_sel[timing] = itap;
> @@ -908,6 +923,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>  		goto err_pltfm_free;
>  	}
>  
> +	sdhci_am654->tuning_loop = 0;

So this is 10 retries ever, since sdhci_am654->tuning_loop is never
set back to 0.  Is that the intention?

>  	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>  
>  	pm_runtime_get_noresume(dev);

