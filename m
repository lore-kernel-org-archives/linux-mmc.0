Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DE3C54EBE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Jan 2023 11:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbjAMLlt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241007AbjAMLlS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2023 06:41:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C6A6F961
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2023 03:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673609568; x=1705145568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hbZVTWb3BpdMaGD0uLfwamz8B6RAjZSW0dZiVXD+shM=;
  b=j8f6g7hWG1bG+wdhGOrrbxvEfHZFpzAgPhZ9tZ+TKtP8swd47SxnpBvF
   agOzGxxdX2vxpDJgZfCAMzRvToOtG0i+DFq3n8vy1KUgRxeNM4aa0rH8F
   8ICAQWggSmhpoDnG9uxeQEzwQS71yha1vqFEJUEdxNBA3BzO+/jjg92ci
   o7ZeaeAcG4tyz7DPAOj7p9TB/F8DTgOn60ZrhZ1jB+Eq+U2XAbBFph2mj
   NJ7ECJPnpNd7CLdj1zGPfsRJ5FoYznqwg5jS4M5RNQDM4ZhpC1chjln04
   YFMbQe/akfBMsbmKz7jMfrw3rp8pHA1M40nXM+s83HjPqWPbxVFs4jk4A
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="386319211"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="386319211"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:32:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="746905522"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="746905522"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.38.178])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:32:46 -0800
Message-ID: <967beb8d-93f0-55ca-8b6b-f3be96a96c6c@intel.com>
Date:   Fri, 13 Jan 2023 13:32:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] mmc: sdhci: Always apply sdhci-caps-mask and sdhci-caps
 to caps
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org
Cc:     Bough Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zach Brown <zach.brown@ni.com>
References: <20230105144628.223420-1-marex@denx.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230105144628.223420-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 5/01/23 16:46, Marek Vasut wrote:
> The original implementation in the commit referenced below only modifies
> caps in case no caps are passed to sdhci_read_caps() via parameter, this
> does not seem correct. Always modify the caps according to the properties
> from DT.
> 
> While at it, drop the always NULL caps and caps1 function parameters.

Please re-base on top of:

https://lore.kernel.org/linux-mmc/20230113110011.129835-1-adrian.hunter@intel.com/T/#t

> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Bough Chen <haibo.chen@nxp.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Zach Brown <zach.brown@ni.com>
> To: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-cadence.c |  2 +-
>  drivers/mmc/host/sdhci.c         | 23 +++++++----------------
>  drivers/mmc/host/sdhci.h         |  5 ++---
>  3 files changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 6f2de54a59877..af1bd66402cb7 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -390,7 +390,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  				sdhci_cdns_hs400_enhanced_strobe;
>  	sdhci_enable_v4_mode(host);
> -	__sdhci_read_caps(host, &version, NULL, NULL);
> +	__sdhci_read_caps(host, &version);
>  
>  	sdhci_get_of_property(pdev);
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f3af1bd0f7b95..0ed8c5b36ecb9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4090,8 +4090,7 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
>  	return ret;
>  }
>  
> -void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
> -		       const u32 *caps, const u32 *caps1)
> +void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver)
>  {
>  	u16 v;
>  	u64 dt_caps_mask = 0;
> @@ -4124,24 +4123,16 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
>  	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
>  		return;
>  
> -	if (caps) {
> -		host->caps = *caps;
> -	} else {
> -		host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> -		host->caps &= ~lower_32_bits(dt_caps_mask);
> -		host->caps |= lower_32_bits(dt_caps);
> -	}
> +	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +	host->caps &= ~lower_32_bits(dt_caps_mask);
> +	host->caps |= lower_32_bits(dt_caps);
>  
>  	if (host->version < SDHCI_SPEC_300)
>  		return;
>  
> -	if (caps1) {
> -		host->caps1 = *caps1;
> -	} else {
> -		host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> -		host->caps1 &= ~upper_32_bits(dt_caps_mask);
> -		host->caps1 |= upper_32_bits(dt_caps);
> -	}
> +	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> +	host->caps1 &= ~upper_32_bits(dt_caps_mask);
> +	host->caps1 |= upper_32_bits(dt_caps);
>  }
>  EXPORT_SYMBOL_GPL(__sdhci_read_caps);
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 605eaee805f74..19695e542161e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -757,8 +757,7 @@ static inline void *sdhci_priv(struct sdhci_host *host)
>  	return host->private;
>  }
>  
> -void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
> -		       const u32 *caps, const u32 *caps1);
> +void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver);
>  int sdhci_setup_host(struct sdhci_host *host);
>  void sdhci_cleanup_host(struct sdhci_host *host);
>  int __sdhci_add_host(struct sdhci_host *host);
> @@ -767,7 +766,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead);
>  
>  static inline void sdhci_read_caps(struct sdhci_host *host)
>  {
> -	__sdhci_read_caps(host, NULL, NULL, NULL);
> +	__sdhci_read_caps(host, NULL);
>  }
>  
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,

