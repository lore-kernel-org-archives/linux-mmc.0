Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6921116;
	Mon,  4 Dec 2023 09:52:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9CF7152B;
	Mon,  4 Dec 2023 09:53:14 -0800 (PST)
Received: from [10.57.74.29] (unknown [10.57.74.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A2283F5A1;
	Mon,  4 Dec 2023 09:52:26 -0800 (PST)
Message-ID: <9747ebb3-98e6-47da-8a9b-9b7dcf7909f6@arm.com>
Date: Mon, 4 Dec 2023 17:52:24 +0000
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
 adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20231204172243.3382495-1-jorge@foundries.io>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20231204172243.3382495-1-jorge@foundries.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/2023 17:22, Jorge Ramirez-Ortiz wrote:
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

Is the difference between this mail and the previous one just Avri's Ack?
No need to resend for every tag you receive.

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

