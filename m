Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0BE13B5A1;
	Mon,  2 Sep 2024 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272418; cv=none; b=TobE9oFaq96HZpwXudM70UxISDPeC8V5A3jBNiVcm3yNx/OvtfmEbDR/Ogt11lOpKIWYQEvkgAo8Pk5Ylu5yQBxkSJfei3Je4fNhtazq7dcAKJgyMH0N5013Hpnvk6jjBEoXF17o60ysHlsgcifnGv3t3g9amkNOgScO0zMJQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272418; c=relaxed/simple;
	bh=V9IewD54Zu/07gNpQ40Oz2Kkoe9Qhos7HCLxIX7/ozQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6Y+m3DnGIYH/ulw15ebbbo1tLu4FeiDN73xH9ejJtMPtGCH+kzbYJDhAx75piP+KhW+Zu52cx4PAfeV+EFMR0OYslCOOzez8YuGYpqjHQAneSYMBNn5+GPSB4uCvTIs6TQfibXTltihX/hMO1CG0VVYozWxqTlNAkI5qMWJLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXRFEDkR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXRFEDkR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725272417; x=1756808417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V9IewD54Zu/07gNpQ40Oz2Kkoe9Qhos7HCLxIX7/ozQ=;
  b=fXRFEDkRJuUr5dkw2UwuDZ2WSeC/R6udVrv4RNeqqhG2Sw8R2pAtA0zY
   JSZMxYveQ+b6zLpYWcpX5t1k8NFzeJrCJkVm861JJ4dP94WfoJOJOEtvi
   R2KaSxNiRzAgG+If2X1LKfNtUELZt1vhxt8pG+AmM5VJQ1djqrmpzWOZo
   UYPuWF+oo9kIL4qyf6Vclab653wibR4//TFlbqAxTTOQcilD1hXxuBzaE
   G7MZH/Xa6aWkt2Eh62jdNTdyK36YjptWJYYcxkkYpa6fD/Qu4HtHfjnVP
   I412jKv6/5pWp5XVtpebtIGrRSq1OaQvBkDa04vq5c4zHYBUVyrMj057k
   w==;
X-CSE-ConnectionGUID: RMsagRkCQWiyKRCR/1m2jQ==
X-CSE-MsgGUID: GYmK68qeQtWdEbK915Uo0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="35211910"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="35211910"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:20:17 -0700
X-CSE-ConnectionGUID: s8irNmHUTmaepMz97nM/5Q==
X-CSE-MsgGUID: /S9ewjWnQ8yGPjOJXuP98Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64572489"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:20:14 -0700
Message-ID: <cddc7c8c-c6d9-4c84-973b-06be282b4081@intel.com>
Date: Mon, 2 Sep 2024 13:19:19 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mmc: sdhci_am654: Add retry tuning
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240826210454.3928033-1-jm@ti.com>
 <20240826210454.3928033-2-jm@ti.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240826210454.3928033-2-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/08/24 00:04, Judith Mendez wrote:
> Add retry tuning up to 10 times if we fail to find
> a failing region or no passing itapdly. This is
> necessary since some eMMC has been observed to never
> find a failing itapdly on the first couple of tuning
> iterations, but eventually does. Keep count of current
> tuning iteration using tuning_loop. It has been observed
> that the tuning algorithm does not need to loop more
> than 10 times before finding a failing itapdly.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>

Still doesn't compile:

  CC [M]  drivers/mmc/host/sdhci_am654.o
drivers/mmc/host/sdhci_am654.c: In function ‘sdhci_am654_calculate_itap’:
drivers/mmc/host/sdhci_am654.c:453:24: error: unused variable ‘dev’ [-Werror=unused-variable]
  453 |         struct device *dev = mmc_dev(host->mmc);
      |                        ^~~
cc1: all warnings being treated as errors

Fix that and you can add:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes since v2:
> - Use do while loop instead of while in patch 1/2
> - Move initialization of tuning_loop to sdhci_am654_init
> - Separate error path in patch 1/2
> ---
>  drivers/mmc/host/sdhci_am654.c | 46 ++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 64e10f7c9faa3..13da003363e1d 100644
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
> @@ -443,7 +445,7 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  #define ITAPDLY_LENGTH 32
>  #define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
>  
> -static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
> +static int sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
>  			  *fail_window, u8 num_fails, bool circular_buffer)
>  {
>  	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
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
> @@ -494,8 +498,8 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
>  	return (itap > ITAPDLY_LAST_INDEX) ? ITAPDLY_LAST_INDEX >> 1 : itap;
>  }
>  
> -static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
> -					       u32 opcode)
> +static int sdhci_am654_do_tuning(struct sdhci_host *host,
> +				 u32 opcode)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> @@ -532,13 +536,30 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>  	if (fail_window[fail_index].length != 0)
>  		fail_index++;
>  
> -	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
> -					  sdhci_am654->dll_enable);
> +	return sdhci_am654_calculate_itap(host, fail_window, fail_index,
> +					 sdhci_am654->dll_enable);
> +}
>  
> -	sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
> +static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
> +					       u32 opcode)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +	unsigned char timing = host->mmc->ios.timing;
> +	int itapdly;
>  
> +	do {
> +		itapdly = sdhci_am654_do_tuning(host, opcode);
> +		if (itapdly >= 0)
> +			break;
> +	} while (++sdhci_am654->tuning_loop < RETRY_TUNING_MAX);
> +
> +	if (itapdly < 0)
> +		return -1;
> +
> +	sdhci_am654_write_itapdly(sdhci_am654, itapdly, sdhci_am654->itap_del_ena[timing]);
>  	/* Save ITAPDLY */
> -	sdhci_am654->itap_del_sel[timing] = itap;
> +	sdhci_am654->itap_del_sel[timing] = itapdly;
>  
>  	return 0;
>  }
> @@ -742,6 +763,9 @@ static int sdhci_am654_init(struct sdhci_host *host)
>  	regmap_update_bits(sdhci_am654->base, CTL_CFG_3, TUNINGFORSDR50_MASK,
>  			   TUNINGFORSDR50_MASK);
>  
> +	/* Use to re-execute tuning */
> +	sdhci_am654->tuning_loop = 0;
> +
>  	ret = sdhci_setup_host(host);
>  	if (ret)
>  		return ret;

