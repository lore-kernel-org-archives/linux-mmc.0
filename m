Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262CD1DA23;
	Fri, 23 Aug 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420752; cv=none; b=bMSXWrtwXZ6bHKMNFvD6SD/UmAeRxW0pg5PGQMz3Jkx2gxs1LoFWLPCi+b7Fk7pilVkpBHuBFV+TYo9neMbiejFtlJ1dyAYkIA7aGp/CWBJPMGYePbYAaW/IOzpRRPASIs6Os53gvJjMlmhrBsfNFRDYJoTjqn94OEfUVPnnG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420752; c=relaxed/simple;
	bh=R/xkkX2hUZsj94OumiLVIhS4A5KWcMOJtBZpo2RJTrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PA5S8kiVGDF3NwK+Hb6dhFeRPXsV7wriRPtjLzcbBh2njRBs1BH4hJgKji5hRi/se33O70QRs/XomkMI/udOe1d8hkhE+hmZi54q/1Z0TfZOi4oATByYtfApTSaYHSTFii6pNu4ORSHD6Aa8SrlZ4etCVVpSSmVZ/3c8A1c/AOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiIncQkn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiIncQkn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724420750; x=1755956750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R/xkkX2hUZsj94OumiLVIhS4A5KWcMOJtBZpo2RJTrI=;
  b=WiIncQknYX33hPIWdIbj+dHumZZY3o98iOm8ZNI0UC6XUMHwFeCEvO5Q
   UtYllduEwNRop0ZNyti6qme3lKgWzy6iQttDxSEJO8xyRyndtVxIks0jP
   bjxJpkW3Jx2V9HdMUBMZ+w+dSj8NsIcTttnRAKq8Xp7YGZ5W3qQsfJOm1
   9jZT/WmI10GlrM8gyvOMHrIMe0sa/BOG8Vj/0sXQTVlaWZRKzsRHjPPRg
   zZPXar45g2S7UfXaPyFCGdS7mymciMBMt5TYxvcUUpZuQmI6uRNrFTk5U
   xdwmfPwi1DifsR+SkqVpeuKuZiaV+Ai/O7yvg3NlJkBosWE7dggAw5hSt
   Q==;
X-CSE-ConnectionGUID: KpiUf8eFTgGHwiUHeD8zmw==
X-CSE-MsgGUID: uWMVGszHRgm/RjvLf/j/XA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22410452"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="22410452"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 06:45:49 -0700
X-CSE-ConnectionGUID: cPnlL1GMRCCqHG5CnNTHBQ==
X-CSE-MsgGUID: 16RWvN6OTKazFjkrTNbsQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="66723568"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 06:45:47 -0700
Message-ID: <47ed0a0b-dfaa-40e1-825a-9a42e66b887e@intel.com>
Date: Fri, 23 Aug 2024 16:45:41 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mmc: sdhci_am654: Add retry tuning
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240821192435.1619271-1-jm@ti.com>
 <20240821192435.1619271-2-jm@ti.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240821192435.1619271-2-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/08/24 22:24, Judith Mendez wrote:
> Add retry tuning up to 10 times if we fail to find
> a failing region or no passing itapdly. This is
> necessary since some eMMC has been observed to never
> find a failing itapdly on the first couple of tuning
> iterations, but eventually does. It has been observed that
> the tuning algorithm does not need to loop more than 10
> times before finding a failing itapdly.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>

Seems to have compile errors. Looks like 'dev' lines belong in
next patch.

drivers/mmc/host/sdhci_am654.c: In function ‘sdhci_am654_calculate_itap’:
drivers/mmc/host/sdhci_am654.c:453:24: error: unused variable ‘dev’ [-Werror=unused-variable]
  453 |         struct device *dev = mmc_dev(host->mmc);
      |                        ^~~
drivers/mmc/host/sdhci_am654.c: In function ‘sdhci_am654_do_tuning’:
drivers/mmc/host/sdhci_am654.c:508:24: error: unused variable ‘dev’ [-Werror=unused-variable]
  508 |         struct device *dev = mmc_dev(host->mmc);
      |                        ^~~
drivers/mmc/host/sdhci_am654.c: In function ‘sdhci_am654_platform_execute_tuning’:
drivers/mmc/host/sdhci_am654.c:553:24: error: unused variable ‘dev’ [-Werror=unused-variable]
  553 |         struct device *dev = mmc_dev(host->mmc);
      |                        ^~~
cc1: all warnings being treated as errors

> ---
> Changes since v1:
> - Change logic in patch 1/2 from using recursive aproach
>   to calling a function iteratively for retuning
> ---
>  drivers/mmc/host/sdhci_am654.c | 54 ++++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 64e10f7c9faa3..612f29fd7dfef 100644
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

Could use a comment explaining tuning_loop usage.

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
> @@ -494,16 +498,18 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
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
>  	unsigned char timing = host->mmc->ios.timing;
>  	struct window fail_window[ITAPDLY_LENGTH];
> +	struct device *dev = mmc_dev(host->mmc);
>  	u8 curr_pass, itap;
>  	u8 fail_index = 0;
>  	u8 prev_pass = 1;
> +	int ret = 0;
>  
>  	memset(fail_window, 0, sizeof(fail_window));
>  
> @@ -532,15 +538,38 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>  	if (fail_window[fail_index].length != 0)
>  		fail_index++;
>  
> -	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
> -					  sdhci_am654->dll_enable);
> +	ret = sdhci_am654_calculate_itap(host, fail_window, fail_index,
> +					 sdhci_am654->dll_enable);
>  
> -	sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
> +	return ret;

Kernel style is to return directly i.e.

	return sdhci_am654_calculate_itap(host, fail_window, fail_index, sdhci_am654->dll_enable);

then don't need ret.

> +}
>  
> -	/* Save ITAPDLY */
> -	sdhci_am654->itap_del_sel[timing] = itap;
> +static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
> +					       u32 opcode)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +	unsigned char timing = host->mmc->ios.timing;
> +	struct device *dev = mmc_dev(host->mmc);
> +	int itapdly;
> +	int ret = 0;
>  
> -	return 0;
> +	itapdly = sdhci_am654_do_tuning(host, opcode);
> +
> +	while (sdhci_am654->tuning_loop < RETRY_TUNING_MAX && itapdly < 0) {
> +		sdhci_am654->tuning_loop++;
> +		itapdly = sdhci_am654_do_tuning(host, opcode);
> +	}

Better to try to have sdhci_am654_do_tuning() appear only once
e.g. something like:

	do {
		itapdly = sdhci_am654_do_tuning(host, opcode);
		if (itapdly >= 0)
			break;
	} while (++sdhci_am654->tuning_loop < RETRY_TUNING_MAX);


> +
> +	if (itapdly >= 0) {
> +		sdhci_am654_write_itapdly(sdhci_am654, itapdly, sdhci_am654->itap_del_ena[timing]);
> +		/* Save ITAPDLY */
> +		sdhci_am654->itap_del_sel[timing] = itapdly;
> +	} else {
> +		ret = -1;
> +	}

It is easier to read if the error path is separate e.g.

	if (itapdly < 0)
		return -1;

	sdhci_am654_write_itapdly(sdhci_am654, itapdly, sdhci_am654->itap_del_ena[timing]);
	/* Save ITAPDLY */
	sdhci_am654->itap_del_sel[timing] = itapdly;

	return 0;

Doesn't need ret then either.

> +
> +	return ret;
>  }
>  
>  static const struct sdhci_ops sdhci_am654_ops = {
> @@ -908,6 +937,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>  		goto err_pltfm_free;
>  	}
>  
> +	sdhci_am654->tuning_loop = 0;

It is a bit arbitrary having this at probe time.  Something like
putting it in an mmc card_init callback might make more sense?

>  	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>  
>  	pm_runtime_get_noresume(dev);

