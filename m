Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2diwhM3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6403121;
	Mon, 11 Dec 2023 08:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702311483; x=1733847483;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pq3tQro7AfQqawP/TcYhRcCE5EHiRcvkpl2Wjvc64Hc=;
  b=G2diwhM3IrEbzTG7kpWneBvbpsBPECnHEAuQbKCEGUQZ6OBQDYUH1xuu
   ibJ8QWzn9hN1inCfIz/bBhCZEgLR1/52xPrBxtt8kE3Nx5HHZ3Z+gE5Uw
   WQmPg8z17F5rX5dJXOjf4d2N+Hq8owfPU8G8Keorl1MtjVI+j39czjjLh
   P16diuvHYzQ/E4drtIAwy8EY1a8ZwtaQOtv69Oapl7iFUQ1sCNnLcJlS0
   3e4iasI8aeaZoH+v2vgP58eTg3ay08qzfu6vTnTVYLwUKhn3FKfCpGpX8
   J9a8I14fOMTg24At6nuqQegMEv76C9zqMbT1l8vvB1zoml1BdUK/C2Kvz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1741822"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1741822"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 08:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="916907512"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="916907512"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.23])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 08:18:00 -0800
Message-ID: <71fad7ef-01a1-4dc5-8d02-6339ca77ca6c@intel.com>
Date: Mon, 11 Dec 2023 18:17:56 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Content-Language: en-US
To: Jorge Ramirez-Ortiz <jorge@foundries.io>, Avri.Altman@wdc.com,
 ulf.hansson@linaro.org, christian.loehle@arm.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20231204172243.3382495-1-jorge@foundries.io>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231204172243.3382495-1-jorge@foundries.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/23 19:22, Jorge Ramirez-Ortiz wrote:
> Requesting a retune before switching to the RPMB partition has been
> observed to cause CRC errors on the RPMB reads (-EILSEQ).
> 
> Since RPMB reads can not be retried, the clients would be directly
> affected by the errors.
> 
> This commit disables the request prior to RPMB switching while allowing
> the pause interface to still request a retune before the pause for other
> use cases.
> 
> This was verified with the sdhci-of-arasan driver (ZynqMP) configured
> for HS200 using two separate eMMC cards (DG4064 and 064GB2). In both
> cases, the error was easy to reproduce triggering every few tenths of
> reads.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Acked-by: Avri Altman <avri.altman@wdc.com>
> 
> ---
>  drivers/mmc/core/block.c | 2 +-
>  drivers/mmc/core/host.c  | 7 ++++---
>  drivers/mmc/core/host.h  | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f9a5cffa64b1..1d69078ad9b2 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -859,7 +859,7 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
>  			if (ret)
>  				return ret;
>  		}
> -		mmc_retune_pause(card->host);
> +		mmc_retune_pause(card->host, false);
>  	}
> 
>  	return ret;
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 096093f7be00..a9b95aaa2235 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -119,13 +119,14 @@ void mmc_retune_enable(struct mmc_host *host)
> 
>  /*
>   * Pause re-tuning for a small set of operations.  The pause begins after the
> - * next command and after first doing re-tuning.
> + * next command and, if retune is set, after first doing re-tuning.
>   */
> -void mmc_retune_pause(struct mmc_host *host)
> +void mmc_retune_pause(struct mmc_host *host, bool retune)
>  {
>  	if (!host->retune_paused) {
>  		host->retune_paused = 1;
> -		mmc_retune_needed(host);
> +		if (retune)
> +			mmc_retune_needed(host);

Better to just drop mmc_retune_needed(host);

>  		mmc_retune_hold(host);
>  	}
>  }
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index 48c4952512a5..321776b52270 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -18,7 +18,7 @@ void mmc_retune_disable(struct mmc_host *host);
>  void mmc_retune_hold(struct mmc_host *host);
>  void mmc_retune_release(struct mmc_host *host);
>  int mmc_retune(struct mmc_host *host);
> -void mmc_retune_pause(struct mmc_host *host);
> +void mmc_retune_pause(struct mmc_host *host, bool retune);
>  void mmc_retune_unpause(struct mmc_host *host);
> 
>  static inline void mmc_retune_clear(struct mmc_host *host)
> --
> 2.34.1

