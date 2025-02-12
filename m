Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5B32046B2;
	Wed, 12 Feb 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739404035; cv=none; b=tDjzh2rQZNVZsqu81NFyhBZSXYGuDRYSFuLxgfHUZUDLx5JwxqeTwVV/3O5qBMYJWT00KLe7YMJmdnrZ2STR5OdESw0he9YHZ2Z+MiV1Dbt9f62nTDA6eUFzzPtQOT6sMFu5wM6nX3JxwCUiPHdyE9+Sd95U7rePiVJRR9o+g4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739404035; c=relaxed/simple;
	bh=hHKR+zd/LcZnjzFpifORs+YQ+3C7tKWUmFGFiBtvG/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9UIgICvZYKY9ysqutUZygZUpy+y1IVuLxle//dJDSikq+9ZP6WanccnLXrPv5oV6GSivVFhUjvXvrIHu8lQiY2q3xfIIeaMh9UO/moX8sHVCSQbxNTUSNB0/w60MijjIPgKy/47Uj7Joz73L1WLhE3Ky5VB5VoWJyOq48+PvJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF053106F;
	Wed, 12 Feb 2025 15:47:32 -0800 (PST)
Received: from [10.57.37.151] (unknown [10.57.37.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 415783F58B;
	Wed, 12 Feb 2025 15:47:10 -0800 (PST)
Message-ID: <96959ef4-2287-4601-85fb-2ce457c605d2@arm.com>
Date: Wed, 12 Feb 2025 23:47:08 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: core: Handle undervoltage events and register
 regulator notifiers
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250212132403.3978175-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250212132403.3978175-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 13:24, Oleksij Rempel wrote:
> Extend the MMC core to handle undervoltage events by implementing
> infrastructure to notify the MMC bus about voltage drops.
> 
> Background & Decision at LPC24:
> 
> This solution was proposed and refined during LPC24 in the talk
> "Graceful Under Pressure: Prioritizing Shutdown to Protect Your Data in
> Embedded Systems" which aimed to address how Linux should handle power
> fluctuations in embedded devices to prevent data corruption or storage
> damage.
> 
> At the time, multiple possible solutions were considered:
> 
> 1. Triggering a system-wide suspend or shutdown: when undervoltage is
>    detected, with device-specific prioritization to ensure critical
>    components shut down first.
>    - This approach was disliked by Greg Kroah-Hartman, as it introduced
>      complexity and was not suitable for all use cases.
> 
> 2. Notifying relevant devices through the regulator framework: to allow
>    graceful per-device handling.
>    - This approach was agreed upon as the most acceptable: by participants
>      in the discussion, including Greg Kroah-Hartman, Mark Brown,
>      and Rafael J. Wysocki.
>    - This patch implements that decision by integrating undervoltage
>      handling into the MMC subsystem.
> 
> This patch was tested on iMX8MP based system with SDHCI controller.

Any details here? How long does it take from undervoltage to
poweroff notification.
Roughly how long of a heads up would that yield in realistic
undervoltage scenarios?

> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/mmc/core/card.h      |  5 ++
>  drivers/mmc/core/core.c      | 29 ++++++++++++
>  drivers/mmc/core/core.h      |  2 +
>  drivers/mmc/core/mmc.c       |  6 +++
>  drivers/mmc/core/regulator.c | 90 ++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h     |  4 ++
>  6 files changed, 136 insertions(+)
> 
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 3205feb1e8ff..f8341e1657f0 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -24,6 +24,9 @@
>  #define MMC_CARD_REMOVED	(1<<4)		/* card has been removed */
>  #define MMC_STATE_SUSPENDED	(1<<5)		/* card is suspended */
>  #define MMC_CARD_SDUC		(1<<6)		/* card is SDUC */
> +#define MMC_CARD_UNDERVOLTAGE   (1<<7)		/* card is in undervoltage
> +						 * condition
> +						 */
>  
>  #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
>  #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
> @@ -32,6 +35,7 @@
>  #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
>  #define mmc_card_suspended(c)	((c)->state & MMC_STATE_SUSPENDED)
>  #define mmc_card_ult_capacity(c) ((c)->state & MMC_CARD_SDUC)
> +#define mmc_card_in_undervoltage(c) ((c)->state & MMC_CARD_UNDERVOLTAGE)
>  
>  #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
>  #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
> @@ -41,6 +45,7 @@
>  #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
>  #define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
>  #define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
> +#define mmc_card_set_undervoltage(c) ((c)->state |= MMC_CARD_UNDERVOLTAGE)
>  
>  /*
>   * The world is not perfect and supplies us with broken mmc/sdio devices.
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5241528f8b90..4b94017d2600 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1399,6 +1399,35 @@ void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>  	mmc_power_up(host, ocr);
>  }
>  
> +/**
> + * mmc_handle_undervoltage - Handle an undervoltage event on the MMC bus
> + * @host: The MMC host that detected the undervoltage condition
> + *
> + * This function is called when an undervoltage event is detected on one of
> + * the MMC regulators.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int mmc_handle_undervoltage(struct mmc_host *host)
> +{
> +	spin_lock(&host->lock);
> +
> +	if (!host->card || mmc_card_in_undervoltage(host->card)) {
> +		spin_unlock(&host->lock);
> +		return 0;
> +	}
> +
> +	/* Mark the card as in undervoltage condition */
> +	mmc_card_set_undervoltage(host->card);
> +	spin_unlock(&host->lock);
> +
> +	/* Call bus-specific undervoltage handler if available */
> +	if (host->bus_ops && host->bus_ops->handle_undervoltage)
> +		return host->bus_ops->handle_undervoltage(host);
> +
> +	return 0;
> +}
> +
>  /*
>   * Assign a mmc bus handler to a host. Only one bus handler may control a
>   * host at any given time.
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index fc9c066e6468..578c98e2f04d 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -31,6 +31,7 @@ struct mmc_bus_ops {
>  	int (*sw_reset)(struct mmc_host *);
>  	bool (*cache_enabled)(struct mmc_host *);
>  	int (*flush_cache)(struct mmc_host *);
> +	int (*handle_undervoltage)(struct mmc_host *);
>  };
>  
>  void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
> @@ -59,6 +60,7 @@ void mmc_power_off(struct mmc_host *host);
>  void mmc_power_cycle(struct mmc_host *host, u32 ocr);
>  void mmc_set_initial_state(struct mmc_host *host);
>  u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
> +int mmc_handle_undervoltage(struct mmc_host *host);
>  
>  static inline void mmc_delay(unsigned int ms)
>  {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6a23be214543..c8b8e7a7b7d6 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2273,6 +2273,11 @@ static int _mmc_hw_reset(struct mmc_host *host)
>  	return mmc_init_card(host, card->ocr, card);
>  }
>  
> +static int _mmc_handle_undervoltage(struct mmc_host *host)
> +{
> +	return mmc_shutdown(host);
> +}
> +

The poweroff notification part I understand, because it polls for busy
(i.e. hopefully until the card thinks it's done committing to flash).
Poweroff isn't always available though, the other paths of
_mmc_suspend() are:

	else if (mmc_can_sleep(host->card))
		err = mmc_sleep(host);
	else if (!mmc_host_is_spi(host))
		err = mmc_deselect_cards(host);

	if (!err) {
		mmc_power_off(host);

So we may also just deselect, which AFAIR succeeds as a FSM (i.e.
doesn't mean anything was committed to flash) and then we just
poweroff.
Is that what we want in an undervoltage scenario?
