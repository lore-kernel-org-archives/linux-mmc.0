Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934745948;
	Wed, 12 Jun 2024 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179890; cv=none; b=U2jurtTPjtt7xQi3F2Kc1+5lsBleCnlt85MM6Erh54qfgSv834t3L/sxHFHIK+g88kHiqEOkCdQt2EDRqOYZ299Ag7+ZlYBNwWcTXhN4c6OOlauqGJUQYWxYD+w55o1kyQ1ewTi0Tn70XBsq3YNJIs2yKTRrpM/GUJ0ys+49ELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179890; c=relaxed/simple;
	bh=xvC0pYsKju6If2He1LE0lGCBfp0CbEd4zvgJoGQEK+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pc6M9dyUG+uCnjKgr/CeHT5ZnFxRvw4A6MNIZ/g30Y5sMtHgInK/AS+pgompr1nNfVjToYpVBlt9nLmhaHvNkd6k8ilKJKDaRlNFmTG+PGTxA2xTCslqvjb4PuxACA0RYA+/1KzoKszvLmv2sZSkmVTLyM9WBfc3NuUNxnLlNyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zyxi54du; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zyxi54du"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718179890; x=1749715890;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xvC0pYsKju6If2He1LE0lGCBfp0CbEd4zvgJoGQEK+4=;
  b=Zyxi54du5tLqP04BQYyj7HzQK7HPB0U90BfGp8N8UJNq58aNxQicqM13
   zHsu0qWTzpXnYbMAHTyevXbJyWgfKuLLapGCJlaAkKBt4UNk3M2qZgFDv
   ZOkdW+aSefNBhNNpIUdKLTISdB29Vnntq1N09kCqiK8aPH1EIzsWTtx5h
   7BjtDS9K+qM5N3mwrbNTxh8tkoFYShlLn/mWdcld7Yy0oe+mWdvBVg7oI
   IqsyOJVnmP3Atd/rXw7NzEYk75yrH1LjBalI1vumHk49QPhvP1HPe/WzV
   dsIcPvCGtzuYvJ1vPFRbaPDVlNIpk4M8S07vdOg//LfV1ZBrMman8BqqB
   g==;
X-CSE-ConnectionGUID: QKONC2pCRoeRZd5SrdoE0A==
X-CSE-MsgGUID: eYr9wkSkTEGV27t/T40bPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="25505634"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="25505634"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 01:11:29 -0700
X-CSE-ConnectionGUID: lI9f8LxPSEi81r+jBhM2Bg==
X-CSE-MsgGUID: aLELKqIWQ1eac12kCawmlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39672038"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 01:11:27 -0700
Message-ID: <a5bb2bb3-efe3-461f-a3d8-88af82f29b15@intel.com>
Date: Wed, 12 Jun 2024 11:11:22 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Use inverted-wp quirk for CV18xx
 and SG200x SoCs
To: Haylen Chu <heylenay@outlook.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <SEYPR01MB42219753E4388009470D958DD7FC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <SEYPR01MB42219753E4388009470D958DD7FC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/05/24 17:13, Haylen Chu wrote:
> MMC controller integrated in Sophgo CV18xx and SG200x SoCs has an
> inverted write-protect flag, causing SDCards misdetected as read-only.

Is it the SDHCI_WRITE_PROTECT bit of the SDHCI_PRESENT_STATE
register that needs to be inverted?

> So set SDHCI_QURIK_INVERTED_WRITE_PROTECT to make write protection work
> correctly.
> 
> Fixes: 017199c2849c ("mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002")
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 39edf04fedcf..62b7f28de54f 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -962,7 +962,8 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
>  
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
>  	.ops = &sdhci_dwcmshc_cv18xx_ops,
> -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  

