Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGQIXVkk"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0F2183;
	Tue,  5 Dec 2023 12:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701807151; x=1733343151;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VWt+YDT2+2XEQnfYLyBLCyZTvqe2lcEZJ569kJV6Xtk=;
  b=AGQIXVkk15zusB7+0w09d2YSbvMUzwuBPhHr8/lM9u81rJuECrSgRr86
   rX9+3iZFFMhaSFuneV57XncUsxGMLGy5DLpLus8WrRdlr2U6vL93UanLb
   ZIQYoTpPQFQvOQT3tvmjXI5CdBX1bajOVxM56rQot+4gXb3x3VocnrvfD
   k5Z0NZEUOmtUYvDgNPWx/bqS9VbczJtZiUuedWVLxLYiBTqv1iuabNrDl
   rIm0dG6lO+O4E6xcaQmVJzTePk5HIdfoyeCxIPuceYTY6Rw2zy1JoIYH1
   /dbHwof2twEbcnQSP+4V3JlZH2soqX6p+T2DqzEUNOYfxgRgeHqFpBrb5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391120033"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="391120033"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 12:12:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774742054"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="774742054"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.77])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 12:12:26 -0800
Message-ID: <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
Date: Tue, 5 Dec 2023 22:12:20 +0200
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
Cc: jinpu.wang@ionos.com, axboe@kernel.dk, beanhuo@micron.com,
 yibin.ding@unisoc.com, victor.shih@genesyslogic.com.tw, asuk4.q@gmail.com,
 hkallweit1@gmail.com, yangyingliang@huawei.com, yebin10@huawei.com,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231204150111.3320071-1-jorge@foundries.io>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231204150111.3320071-1-jorge@foundries.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
> Requesting a retune before switching to the RPMB partition has been
> observed to cause CRC errors on the RPMB reads (-EILSEQ).

There are still 2 concerns:
1) We don't really know the root cause.  Have you determined
if here are CRC errors in the main partition also?
2) Forcing this on everyone

The original idea was that because re-tuning cannot be
done in RPMB, the need to re-rune in RPMB could be avoided
by always re-tuning before switching to RPMB and then switching
straight back. IIRC re-tuning should guarantee at least 4MB
more I/O without issue.

The alternative to dropping re-tuning in this case could
be to add a retry loop for MMC_DRV_OP_IOCTL_RPMB if the error
is -EILSEQ


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

There is still a small chance that re-tuning
is needed anyway in which case it will still be done.

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

