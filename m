Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32323205501;
	Fri, 21 Feb 2025 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134403; cv=none; b=FOVipTu5L61iapn8FpiIadN+5z9z9T5/egdtYtmLPjp0zrp2g+oVKbi1qduCckLs/vKcBnEAdHyTcDaLFzSgKAfrrPiIorBkYAMwcr/t7Reqs4kUxE/KQQ2NbnyW8m4whdjnBwX1UWVd5Ac5rQU1ABFqT30uNwUgON/vk0wD7nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134403; c=relaxed/simple;
	bh=XJrwKG10QSah/ickTZ1lllQw+hW/qqeAgUpJ91gdEms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVD26oYkmari7POKVKwBuZZFPf/UvZxa+rmBiAiH794ODlCSqIMQdW2+Y971tzzYLoiIpe5mdOi/aQKb1vE3uWdPSqCUKV4phQfJ9q8MBI+tRZ++NwUzQWp9N4QbPgLaHWzfm4YymCOF/AK4pMsEwmFYXlwEflldvi5Y4nx56kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B7A3165C;
	Fri, 21 Feb 2025 02:40:19 -0800 (PST)
Received: from [10.57.85.184] (unknown [10.57.85.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18FD43F5A1;
	Fri, 21 Feb 2025 02:39:58 -0800 (PST)
Message-ID: <1c92af85-6549-4104-8db0-05cae39ea354@arm.com>
Date: Fri, 21 Feb 2025 10:39:56 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mmc: core: add undervoltage handler for MMC/eMMC
 devices
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
 Adrian Hunter <adrian.hunter@intel.com>, 'Avri Altman' <avri.altman@wdc.com>
References: <20250221093918.3942378-1-o.rempel@pengutronix.de>
 <20250221093918.3942378-5-o.rempel@pengutronix.de>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250221093918.3942378-5-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

(+CC Avri and Adrian)

On 2/21/25 09:39, Oleksij Rempel wrote:
> Introduce `_mmc_handle_undervoltage()` to handle undervoltage events for
> MMC/eMMC devices. This function interrupts ongoing operations using High
> Priority Interrupt (HPI) and performs a controlled suspend. After
> completing the sequence, the card is marked as removed to prevent
> further interactions, ensuring that no further commands are issued after
> an emergency stop.
> 
> Implementation Details:
> 1. **Interrupt ongoing operations**:
>    - If the eMMC is executing a long-running operation (e.g., erase, trim,
>      or write),
>      attempt to stop it using HPI (`mmc_interrupt_hpi()`).
>    - If HPI fails, an error is logged, but the sequence continues.
> 
> 2. **Suspend the card in an emergency state**:
>    - Call `__mmc_suspend()` with `is_undervoltage = true`, which ensures:
>      - The power-off notification uses `EXT_CSD_POWER_OFF_SHORT`.
>      - Cache flushing is skipped to minimize time delays.
>      - If power-off notify is unsupported, alternative methods like sleep
>        or deselect are used to transition the card into a safe state.
> 
> 3. **Mark the card as removed**:
>    - This prevents further commands from being issued to the card after
>      undervoltage shutdown, avoiding potential corruption.
> 
> To support this, introduce `__mmc_suspend()` and `__mmc_resume()` as
> internal  helpers that omit `mmc_claim_host()/mmc_release_host()`,
> allowing them to be  called when the host is already claimed.
> 
> The caller of `_mmc_handle_undervoltage()` is responsible for invoking
> `mmc_claim_host()` before calling this function and `mmc_release_host()`
> afterward to ensure exclusive access to the host during the emergency
> shutdown process.
> 
> Device Handling Considerations:
> - **For eMMC storage**: The new undervoltage handler applies the correct
>   power-down sequence using power-off notify or alternative methods.
> - **For SD cards**: The current implementation does not handle undervoltage
>   events for SD cards. Future extensions may be needed to implement proper
>   handling.
> 
> Testing:
> This implementation was tested on an iMX8MP-based system, verifying that
> the  undervoltage sequence correctly stops ongoing operations and
> prevents further  MMC transactions after the event. The board had
> approximately 100ms of available  power hold-up time. The Power Off
> Notification was sent ~4ms after the board  was detached from the power
> supply, allowing sufficient time for the eMMC to  handle the event
> properly.
> 
> The testing was performed using a logic analyzer to monitor command
> sequences and timing. While this method confirms that the expected
> sequence was executed, it does not provide insights into the actual
> internal behavior of the eMMC storage.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v3:
> - reword commit message.
> - add comments in the code
> - do not try to resume sleeping device
> ---
>  drivers/mmc/core/mmc.c | 115 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 102 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 9270bde445ad..a50cdd550a22 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2104,8 +2104,8 @@ static int _mmc_flush_cache(struct mmc_host *host)
>  	return err;
>  }
>  
> -static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
> -			bool is_undervoltage)
> +static int __mmc_suspend(struct mmc_host *host, bool is_suspend,
> +			 bool is_undervoltage)
>  {
>  	unsigned int notify_type;
>  	int err = 0;
> @@ -2116,8 +2116,6 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
>  	else
>  		notify_type = EXT_CSD_POWER_OFF_LONG;
>  
> -	mmc_claim_host(host);
> -
>  	if (mmc_card_suspended(host->card))
>  		goto out;
>  
> @@ -2145,7 +2143,18 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
>  		mmc_card_set_suspended(host->card);
>  	}
>  out:
> +	return err;
> +}
> +
> +static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
> +			bool is_undervoltage)
> +{
> +	int err;
> +
> +	mmc_claim_host(host);
> +	err = __mmc_suspend(host, is_suspend, is_undervoltage);
>  	mmc_release_host(host);
> +
>  	return err;
>  }
>  
> @@ -2165,6 +2174,20 @@ static int mmc_suspend(struct mmc_host *host)
>  	return err;
>  }
>  
> +static int __mmc_resume(struct mmc_host *host)
> +{
> +	int err;
> +
> +	if (!mmc_card_suspended(host->card))
> +		return 0;
> +
> +	mmc_power_up(host, host->card->ocr);
> +	err = mmc_init_card(host, host->card->ocr, host->card);
> +	mmc_card_clr_suspended(host->card);
> +
> +	return err;
> +}
> +
>  /*
>   * This function tries to determine if the same card is still present
>   * and, if so, restore all state to it.
> @@ -2174,16 +2197,9 @@ static int _mmc_resume(struct mmc_host *host)
>  	int err = 0;
>  
>  	mmc_claim_host(host);
> -
> -	if (!mmc_card_suspended(host->card))
> -		goto out;
> -
> -	mmc_power_up(host, host->card->ocr);
> -	err = mmc_init_card(host, host->card->ocr, host->card);
> -	mmc_card_clr_suspended(host->card);
> -
> -out:
> +	err = __mmc_resume(host);
>  	mmc_release_host(host);
> +
>  	return err;
>  }
>  
> @@ -2194,6 +2210,13 @@ static int mmc_shutdown(struct mmc_host *host)
>  {
>  	int err = 0;
>  
> +	/*
> +	 * In case of undervoltage, the card will be powered off by
> +	 * _mmc_handle_undervoltage()
> +	 */
> +	if (host->undervoltage)
> +		return 0;
> +
>  	/*
>  	 * In a specific case for poweroff notify, we need to resume the card
>  	 * before we can shutdown it properly.
> @@ -2285,6 +2308,71 @@ static int _mmc_hw_reset(struct mmc_host *host)
>  	return mmc_init_card(host, card->ocr, card);
>  }
>  
> +/**
> + * _mmc_handle_undervoltage - Handle an undervoltage event for MMC/eMMC devices
> + * @host: MMC host structure
> + *
> + * This function is triggered when an undervoltage condition is detected.
> + * It attempts to safely stop ongoing operations and transition the device
> + * into a low-power or safe state to prevent data corruption.
> + *
> + * Steps performed:
> + * 1. If no card is present, return immediately.
> + * 2. Attempt to interrupt any ongoing operations using High Priority Interrupt
> + *    (HPI).
> + * 3. Perform an emergency suspend using EXT_CSD_POWER_OFF_SHORT if possible.
> + *    - If power-off notify is not supported, fallback mechanisms like sleep or
> + *      deselecting the card are attempted.
> + *    - Cache flushing is skipped to reduce execution time.
> + * 4. Mark the card as removed to prevent further interactions after
> + *    undervoltage.

The good path now looks like the best bet to me.
The PON fallbacks are still questionable IMO.
Deselect, if taking the spec seriously, cannot really give a hint to FTL.
While daisy-chaining MMC and SD is rather rare these days, that's still the
behavior vendors implement AFAIK.
Sleep with it's vendor-defined timeouts can be anything, so this could even
trigger a cache flush internally, after we avoided sending one because of
undervoltage.
If we were to rely on actually getting 100ms heads-up we could check that
against the timeout reported by the card, but IME those are wild guesses
rather than measured values.

> + *
> + * Note: This function does not handle host claiming or releasing. The caller
> + *	 must ensure that the host is properly claimed before calling this
> + *	 function and released afterward.
> + *
> + * Returns: 0 on success, or a negative error code if any step fails.
> + */
> +static int _mmc_handle_undervoltage(struct mmc_host *host)
> +{
> +	struct mmc_card *card = host->card;
> +	int err = 0;
> +
> +	/* If there is no card attached, nothing to do */
> +	if (!card)
> +		return 0;
> +
> +	/*
> +	 * Try to interrupt a long-running operation (such as an erase, trim,
> +	 * or write) using High Priority Interrupt (HPI). This helps ensure
> +	 * the card is in a safe state before power loss.

I don't know about safe state before power loss, it's getting it in a
state where we can execute the below.

> +	 */
> +	err = mmc_interrupt_hpi(card);
> +	if (err)
> +		pr_err("%s: Interrupt HPI failed, error %d\n",
> +			mmc_hostname(host), err);
> +
> +	/*
> +	 * Perform an emergency suspend to power off the eMMC quickly.
> +	 * This ensures the device enters a safe state before power is lost.
> +	 * We first attempt EXT_CSD_POWER_OFF_SHORT, but if power-off notify
> +	 * is not supported, we fall back to sleep mode or deselecting the card.
> +	 * Cache flushing is skipped to minimize delay.
> +	 */
> +	err = __mmc_suspend(host, false, true);
> +	if (err)
> +		pr_err("%s: error %d doing suspend\n", mmc_hostname(host), err);
> +
> +	/*
> +	 * Mark the card as removed to prevent further operations.
> +	 * This ensures the system does not attempt to access the device
> +	 * after an undervoltage event, avoiding potential corruption.
> +	 */
> +	mmc_card_set_removed(card);
> +
> +	return err;
> +}
> +
>  static const struct mmc_bus_ops mmc_ops = {
>  	.remove = mmc_remove,
>  	.detect = mmc_detect,
> @@ -2297,6 +2385,7 @@ static const struct mmc_bus_ops mmc_ops = {
>  	.hw_reset = _mmc_hw_reset,
>  	.cache_enabled = _mmc_cache_enabled,
>  	.flush_cache = _mmc_flush_cache,
> +	.handle_undervoltage = _mmc_handle_undervoltage,
>  };
>  
>  /*

No need to resend anything at this point, I'm curious what others have
to say on the series.
