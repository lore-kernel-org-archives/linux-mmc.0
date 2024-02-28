Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7AD1EB22
	for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113318; cv=none; b=TyoT1gPRRqsV2t8mFwCwBmIn1uq1yqFPRxWRHv7q4EHzztNyNl+/VwFqZTjC1VhQfvHI2crUgVxKRVvo1PQ9B8UPyhHpLXxZGTQgyzGthI9n0S9UFIAFR+bVLd1I4uWu7bFLDk0GOKXryFHTYpGX9I0m/rtP5TjbTskqzEXukGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113318; c=relaxed/simple;
	bh=LmuCXpjwIioKqpwpQZrGLyp71XEGueiwG6E3fSCVAyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RaTg2ugRupgzTNfQv6Dpr+5OXZb5YR6o0UPxNyZR2uuTn/8kRJp3b0UDG08KiCs0W/l1yWWgc0Lk6sLfK1WsrJ++tDOHp87izct6et+9IfRzQkSq+sjaiQAJWMWzh+Kn1tcMkG4Fz8S+FHTtv56nnKYbmY/UjJmer5U0Wd2VYN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPDJnFbm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPDJnFbm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709113317; x=1740649317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LmuCXpjwIioKqpwpQZrGLyp71XEGueiwG6E3fSCVAyU=;
  b=dPDJnFbmyameatmBdtXI8X3gSBIADG72bOx+W/MNRn49uCG2F1sFSYnX
   6PeLztm/61adj+Skczo/+a/e+o4x/5Syfo2/VVkh1B3yl9ZLGmmsdARNo
   iFV9/s48voqUE4a0zapuqg+tCOra3eXBWWsQnpF+RADnt5Zx9A1I11gcX
   SgDeRAvmHOa5b6gB9VZgeR3vhzwYQDqr0q6KtQCnckc9lPlI5V5syAizF
   s57mjHlFx2QslMc5KXfqKU7NB/pGxtVd4Jq51pcrrSwebFeWaZCtZ1Sfs
   d5o9N5IQL0mntMMwiiz5bhL4jGPxtvzr5JWX5WhDluBJBNlPb1A+65MtF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3621596"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3621596"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 01:41:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7409605"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.3])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 01:41:54 -0800
Message-ID: <fffdd2a1-317e-436e-95f6-e0d6da39ccdd@intel.com>
Date: Wed, 28 Feb 2024 11:41:49 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-mcf: Flag the sg_miter as atomic
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-mmc@vger.kernel.org
References: <20240228-fix-sdhci-esdhc-mcf-2-v2-1-4ebb3fd691ea@linaro.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240228-fix-sdhci-esdhc-mcf-2-v2-1-4ebb3fd691ea@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/24 11:07, Linus Walleij wrote:
> The sg_miter used to loop over the returned sglist from a
> transfer in the esdhc subdriver for SDHCI can be called
> from atomic context so the miter needs to be atomic.
> 
> sdhci_request_done() is always called from process context,
> either as a work or as part of the threaded interrupt handler,
> but the one case when we are actually calling .request_done()
> from an atomic context is in sdhci_irq().
> 
> Fix this by flaggig the miter atomic so we always use

flaggig -> flagging

> kmap_atomic().
> 
> Fixes: e8a167b84886 ("mmc: sdhci-esdhc-mcf: Use sg_miter for swapping")
> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
> - Do the simpler fix and just use an atomic iterator, it
>   will work fine since esdhc_mcf_buffer_swap32() doesn't sleep.
> - Link to v1: https://lore.kernel.org/r/20240222-fix-sdhci-esdhc-mcf-v1-1-fb87e04ca575@linaro.org
> ---
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> index 1909a11fd065..c97363e2d86c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -313,7 +313,7 @@ static void esdhc_mcf_request_done(struct sdhci_host *host,
>  	 * transfer endiannes. A swap after the transfer is needed.
>  	 */
>  	sg_miter_start(&sgm, mrq->data->sg, mrq->data->sg_len,
> -		       SG_MITER_TO_SG | SG_MITER_FROM_SG);
> +		       SG_MITER_ATOMIC | SG_MITER_TO_SG | SG_MITER_FROM_SG);
>  	while (sg_miter_next(&sgm)) {
>  		buffer = sgm.addr;
>  		esdhc_mcf_buffer_swap32(buffer, sgm.length);
> 
> ---
> base-commit: 20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e
> change-id: 20240228-fix-sdhci-esdhc-mcf-2-539cf338c3a3
> 
> Best regards,

