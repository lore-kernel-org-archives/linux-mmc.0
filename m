Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D813B2A8;
	Mon,  2 Sep 2024 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273322; cv=none; b=nqx9VAPkO3Kf668iE7h/dmd3F/dgDl8y/WlVLnRGiUQUneDQPq3TMuCFugD1wsjuMbRL/8OrNZ2DHWhYRoAVlQH0cCUXY/SrVZpldxQ9OiynHQZyWpFe74rWvHf+nP64BPuofz2AArSeumYL+SCUex+yPB8ZUE+o3uL+It4LByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273322; c=relaxed/simple;
	bh=Cw+TYaCrtkpShMImHhn75FMmM32Kcy/WMVCCSaCo+64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9+8EvJ71coDkweye/bAiS7rPkv0gq8SKHfm6FrP6PkeEAHRH2RZcQ/aKtWn9jddfYOAcRCYEI5FHcRc6DI4kiGOE+xI5mb8sLIMrMGZX3rTRkzhRQgKQdSqj8Ra7bIAJS7Omb8DX1DtSGXicoBYYSqSXg6A2vYFNJnS7YQTNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3AWfNU/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3AWfNU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725273320; x=1756809320;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cw+TYaCrtkpShMImHhn75FMmM32Kcy/WMVCCSaCo+64=;
  b=g3AWfNU//Ekw9U53iLMHLKimLmB7qA1fkrjpL6XQyCqPTjcWCDD89Sc6
   v251C3USIZ4y5XsMoy+1TVxTfyVp5rcf7JWIZb2cq+PFrKTpK5CFkNlX5
   xTQCToym8Okla7o+c9IF41UhD5YfnEGPltWq3WhC2hZKzDc7KLEaJOlGl
   MJMmC4d8+W8GSN4Fq6MZPCfoo6i28kTURdYfrzH6Yk8Q7cdxBUHWP0u4e
   vTxFYrk2cq9ve/XHptyXLylY57UPxqdDoyKjunSOAzTanUD3SU61yKrYs
   87zJGORcvvPGhySDEI6FJQw99MBSwkV0hTV4qRUdUJFXqvWXlYqa/PPnU
   A==;
X-CSE-ConnectionGUID: hO7o0DjbS0OcwuJx1UsdCw==
X-CSE-MsgGUID: PuEv18+vTcK/ZrT2rDIDKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23980790"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23980790"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:35:20 -0700
X-CSE-ConnectionGUID: Xda4DPLAQDGRyksF2aubNQ==
X-CSE-MsgGUID: mLlH/IfoTkuDAGM+f3C3qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69366478"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:35:15 -0700
Message-ID: <724c873c-97b8-48cd-9543-03f051cde9a3@intel.com>
Date: Mon, 2 Sep 2024 13:34:20 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cqhci-core: Make use cqhci_halted() routine
To: Seunghwan Baek <sh8267.baek@samsung.com>, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, ritesh.list@gmail.com,
 quic_asutoshd@quicinc.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com,
 dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com,
 cw9316.lee@samsung.com, wkon.kim@samsung.com
References: <20240829061823.3718-1-sh8267.baek@samsung.com>
 <CGME20240829061842epcas1p25b97a685d0946c360338adf716bfaf2b@epcas1p2.samsung.com>
 <20240829061823.3718-3-sh8267.baek@samsung.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240829061823.3718-3-sh8267.baek@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/08/24 09:18, Seunghwan Baek wrote:
> Code to check whether cqe is in halt state is modified to cqhci_halted,

'to cqhci_halted' -> to use 'cqhci_halted()'

(and re-wrap text to 75 columns)

> which has already been implemented.
> 
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>

For consistency subject could start "mmc: cqhci:" instead of "cqhci-core:"

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/cqhci-core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index a02da26a1efd..178277d90c31 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -33,6 +33,11 @@ struct cqhci_slot {
>  #define CQHCI_HOST_OTHER	BIT(4)
>  };
>  
> +static bool cqhci_halted(struct cqhci_host *cq_host)
> +{
> +	return cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT;
> +}
> +
>  static inline u8 *get_desc(struct cqhci_host *cq_host, u8 tag)
>  {
>  	return cq_host->desc_base + (tag * cq_host->slot_sz);
> @@ -282,7 +287,7 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>  
>  	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>  
> -	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
> +	if (cqhci_halted(cq_host))
>  		cqhci_writel(cq_host, 0, CQHCI_CTL);
>  
>  	mmc->cqe_on = true;
> @@ -617,7 +622,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  		cqhci_writel(cq_host, 0, CQHCI_CTL);
>  		mmc->cqe_on = true;
>  		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> -		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
> +		if (cqhci_halted(cq_host)) {
>  			pr_err("%s: cqhci: CQE failed to exit halt state\n",
>  			       mmc_hostname(mmc));
>  		}
> @@ -953,11 +958,6 @@ static bool cqhci_clear_all_tasks(struct mmc_host *mmc, unsigned int timeout)
>  	return ret;
>  }
>  
> -static bool cqhci_halted(struct cqhci_host *cq_host)
> -{
> -	return cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT;
> -}
> -
>  static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
>  {
>  	struct cqhci_host *cq_host = mmc->cqe_private;

