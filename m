Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D018FA02;
	Wed, 10 Jul 2024 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611678; cv=none; b=QPgO3GCHJVpvGpUfnGW7rIl7on6Sw5g2GH7/z9qgHVwqtbyGYdYzd9B+xSa2Zm5fVGOIOodWPTLESRqfXksMThmwq5r+9G/jdirOU3bi8lGPGAR1XwEhRUoy14gqoKUWyZb+DWQfBYez3YS2WvO62IBjG6HQdorPdZ0/Zc5sk0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611678; c=relaxed/simple;
	bh=5Gc+WSgaTvQtTb2+K/MRvKwRBLP+XYM5K3LbNVGzSCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omIhe6DLQRxRo4He2GTQcOMuFbYQ7eCPuyy4CO5U459NbFBN6oxlUyTl3gGKDqbbo77hhE3Knquo26AvbCVLGsMN4YTaWVODtcMLUUzMPmONXmx6rcbnmcZOl4ojPuhZIWwvlHaLKiBPWiFFkzpkN0nzkXXNzSZ3/VV6nvjkhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQyuN10O; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQyuN10O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720611677; x=1752147677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5Gc+WSgaTvQtTb2+K/MRvKwRBLP+XYM5K3LbNVGzSCk=;
  b=FQyuN10OUauAk+T/2KyTVsPUwXqUJQnQzBgYLSuTHieQc7MrBbvwvqqj
   H1MTCFDSUTyEarcOP5hg3o3ETGY3+YFR+apRTqnpCwX/gjCtGwIGmSUii
   wsBB69fLozffqH5MHChUesXCDiNlxiDFoAsmU/MjmE9Rf1oYjU/4m7Dma
   pcRXQ8msGDL6C/hPf4JugTutPZIJJo+AY3MPuTm3Ufa/BAVnfd43sJvk+
   yfDGRDRbIMf74qrH2Ezd1H3CH+VArmVAOaUoD+DEafZAzJuJPHGtaKObU
   r4I6GLp4Cd9IGfGdcYuWr+4weR2hs/Ji0kTDzpRt0ocAroXMCYfTVXW9u
   A==;
X-CSE-ConnectionGUID: zGhJnXRcRXCmE+snZu9VFA==
X-CSE-MsgGUID: 0DUrFJu0TCW18M2awpl13Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18066862"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="18066862"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 04:41:16 -0700
X-CSE-ConnectionGUID: FyEZfcl2RR+h8h2flw7WQA==
X-CSE-MsgGUID: DeJi4XD0Q/aWHRIglF9rNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="78923789"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 04:41:13 -0700
Message-ID: <dc6d8995-3e7c-4459-b82c-8ba402fdc094@intel.com>
Date: Wed, 10 Jul 2024 14:41:08 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-pxav3: Fix potential NULL dereference in
 sdhci_pxav3_probe
To: Ma Ke <make24@iscas.ac.cn>, ulf.hansson@linaro.org,
 thomas.petazzoni@free-electrons.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240710105911.2076942-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240710105911.2076942-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/07/24 13:59, Ma Ke wrote:
> In sdhci_pxav3_probe(), mv_mbus_dram_info() returns NULL if
> CONFIG_PLAT_ORION macro is not defined[1]. Fix this bug by adding NULL 
> check.

As was commented last time, there already is a NULL check in
mv_conf_mbus_windows(). Another check is not necessary.

> 
> Fixes: aa8165f91442 ("mmc: sdhci-pxav3: do the mbus window configuration after enabling clocks")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - refined the vulnerability description;

Referencing a link not actually in the commit message

> - provided similar vulnerability's reference link[2].

Not the same because in that case dram was dereferenced
without checking first.

> Reference link:
> [1] https://github.com/torvalds/linux/blob/34afb82a3c67f869267a26f593b6f8fc6bf35905/include/linux/mbus.h#L65
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=d48d0c5fd733bd6d8d3ddb2ed553777ab4724169
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 3af43ac05825..ac89cb2eb9f6 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -375,6 +375,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  	struct sdhci_host *host = NULL;
>  	struct sdhci_pxa *pxa = NULL;
>  	const struct of_device_id *match;
> +	const struct mbus_dram_target_info *dram;
>  	int ret;
>  
>  	host = sdhci_pltfm_init(pdev, &sdhci_pxav3_pdata, sizeof(*pxa));
> @@ -406,7 +407,12 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  		ret = armada_38x_quirks(pdev, host);
>  		if (ret < 0)
>  			goto err_mbus_win;
> -		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
> +		dram = mv_mbus_dram_info();
> +		if (!dram) {
> +			ret = 0;
> +			goto err_mbus_win;
> +		}
> +		ret = mv_conf_mbus_windows(pdev, dram);
>  		if (ret < 0)
>  			goto err_mbus_win;
>  	}

