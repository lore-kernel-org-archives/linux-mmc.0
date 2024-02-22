Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E2A17BA1
	for <linux-mmc@vger.kernel.org>; Thu, 22 Feb 2024 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708582952; cv=none; b=AbEfwhSD3e6M2eI4N1wxiQxSjKdoEmKAtm8w2i22elJKPUPKLRXmUu61UaPzSONmz0vhbIB+0beNCfqIelESGzXcrzlnNrHvIriS51zGSRAN4kzEjGPlHfBXdigFd+e0ebSZmQGeqXhQd2VDNA8AdBo4finHqzpzu2rp4Ez/NFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708582952; c=relaxed/simple;
	bh=ftpV/5JLcFXqvKNRuP7RF/wiCIiGwkJERQVKiFhuuqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfXZegmea+jwyX7L124a0xAHwK09F/PTHRkGAZGohSGsrkrDCksCwR24FT00YO795WaZz4FjqgE6XTppfVtUEZODD9lMUJ/3xg9fHOwtrROGEV2s+Jiyj+qrfHxr9yNhVE4F8UFZqdCEESj+edLiBiXxBCz9VfCCQKcjWoIXIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6QAL/Yy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6QAL/Yy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708582950; x=1740118950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ftpV/5JLcFXqvKNRuP7RF/wiCIiGwkJERQVKiFhuuqI=;
  b=c6QAL/YyH++B4mwoLvSTSmBoPq1qM1oikmIpDqixi6jzSheSYGw5qrFc
   GmoHsMzaMrXb+IgxvDJ294eUVMhGokRsrdOw+q2tkjNh5udzXx/nlffaA
   53Nph3hXOnF06lmpDtDp+m1C90KYKa79JDSB/bvBKB8Nm66c/EttxIySo
   95XlZbKRfyYT2TRcItddyo4FIRAXTsZNtpsnslBMKv5Gb05k7oh/UHVgC
   BfsHCg8Id9yX3DwJHTFsLRWUlXKbsKXSywlmlbeKySRgJSFKojDqtTFC2
   7mMcEaga0dWex/VrSBcfaQ3zeFyNtVVV3Zjhqc0OXGYE5uUFNLI4G6kUu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2651471"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2651471"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 22:22:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5396187"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.18])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 22:22:27 -0800
Message-ID: <5c88e3f7-22e7-44d1-bf2e-5440e4de3b12@intel.com>
Date: Thu, 22 Feb 2024 08:22:22 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-esdhc-mcf: Flag if the sg_miter is atomic
To: Linus Walleij <linus.walleij@linaro.org>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-mmc@vger.kernel.org
References: <20240222-fix-sdhci-esdhc-mcf-v1-1-fb87e04ca575@linaro.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240222-fix-sdhci-esdhc-mcf-v1-1-fb87e04ca575@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/24 02:00, Linus Walleij wrote:
> The sg_miter used to loop over the returned sglist from a
> transfer in the esdhc subdriver for SDHCI needs to know if
> it is being used in process or atomic context.
> 
> This creates a problem because we cannot unconditionally
> add SG_MITER_ATOMIC to the miter, as that can create
> scheduling while atomic dmesg splats.
> 
> Bit the bullet and make the .request_done() callback in
> struct sdhci_ops aware of whether it is called from atomic
> context or not, and only add the flag when actually called
> from atomic context.
> 
> sdhci_request_done() is always called from process context,
> either as a work or as part of the threaded interrupt handler,
> so this will pass false for is_atomic, and the one case when
> we are actually calling .request_done() from an atomic context
> is in sdhci_irq().
> 
> Fixes: e8a167b84886 ("mmc: sdhci-esdhc-mcf: Use sg_miter for swapping")

I notice, in fact, that the driver is already using a bounce
buffer always:

static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
...
	if (!host->bounce_buffer) {
		dev_err(&pdev->dev, "bounce buffer not allocated");
		err = -ENOMEM;
		goto cleanup;
	}
...

Doesn't that mean the original patch is not needed?

> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 8 ++++++--
>  drivers/mmc/host/sdhci-pxav2.c     | 2 +-
>  drivers/mmc/host/sdhci-sprd.c      | 3 ++-
>  drivers/mmc/host/sdhci.c           | 4 ++--
>  drivers/mmc/host/sdhci.h           | 3 ++-
>  5 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> index 1909a11fd065..7b0686701c6e 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -297,8 +297,10 @@ static void esdhc_mcf_pltfm_set_bus_width(struct sdhci_host *host, int width)
>  }
>  
>  static void esdhc_mcf_request_done(struct sdhci_host *host,
> -				   struct mmc_request *mrq)
> +				   struct mmc_request *mrq,
> +				   bool is_atomic)
>  {
> +	unsigned int miter_flags = SG_MITER_TO_SG | SG_MITER_FROM_SG;
>  	struct sg_mapping_iter sgm;
>  	u32 *buffer;
>  
> @@ -312,8 +314,10 @@ static void esdhc_mcf_request_done(struct sdhci_host *host,
>  	 * On mcf5441x there is no hw sdma option/flag to select the dma
>  	 * transfer endiannes. A swap after the transfer is needed.
>  	 */
> +	if (is_atomic)
> +		miter_flags |= SG_MITER_ATOMIC;
>  	sg_miter_start(&sgm, mrq->data->sg, mrq->data->sg_len,
> -		       SG_MITER_TO_SG | SG_MITER_FROM_SG);
> +		       miter_flags);
>  	while (sg_miter_next(&sgm)) {
>  		buffer = sgm.addr;
>  		esdhc_mcf_buffer_swap32(buffer, sgm.length);
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index b75cbea88b40..c1b49c2feea8 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -120,7 +120,7 @@ static u32 pxav1_irq(struct sdhci_host *host, u32 intmask)
>  	return intmask;
>  }
>  
> -static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq)
> +static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq, bool is_atomic)
>  {
>  	u16 tmp;
>  	struct sdhci_pxav2_host *pxav2_host;
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index bed57a1c64b5..a2b244e13451 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -411,7 +411,8 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
>  }
>  
>  static void sdhci_sprd_request_done(struct sdhci_host *host,
> -				    struct mmc_request *mrq)
> +				    struct mmc_request *mrq,
> +				    bool is_atomic)
>  {
>  	/* Validate if the request was from software queue firstly. */
>  	if (mmc_hsq_finalize_request(host->mmc, mrq))
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c79f73459915..3c6a9ba573cc 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3184,7 +3184,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	if (host->ops->request_done)
> -		host->ops->request_done(host, mrq);
> +		host->ops->request_done(host, mrq, false);
>  	else
>  		mmc_request_done(host->mmc, mrq);
>  
> @@ -3639,7 +3639,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  			continue;
>  
>  		if (host->ops->request_done)
> -			host->ops->request_done(host, mrqs_done[i]);
> +			host->ops->request_done(host, mrqs_done[i], true);
>  		else
>  			mmc_request_done(host->mmc, mrqs_done[i]);
>  	}
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index a20864fc0641..c2ff327e2c96 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -666,7 +666,8 @@ struct sdhci_ops {
>  					 struct mmc_data *data,
>  					 unsigned int length);
>  	void	(*request_done)(struct sdhci_host *host,
> -				struct mmc_request *mrq);
> +				struct mmc_request *mrq,
> +				bool is_atomic);
>  	void    (*dump_vendor_regs)(struct sdhci_host *host);
>  };
>  
> 
> ---
> base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
> change-id: 20240222-fix-sdhci-esdhc-mcf-aa062c072800
> 
> Best regards,

