Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3E1AF0C8;
	Thu, 20 Feb 2025 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048428; cv=none; b=bHZf1CFEjlEnfMVXmjZYHN8OwJ8bQicpsZClLTnQ2/dZ4zVMua6yaWjtomIHzEeOkDqBJ/AJLbInQ1E8p+LqLd/LEU12COw9sQSFb3pBkRV+0ABUZP9uKcqss8iGeOXtiSdmUiKHwmr3bfOASvSDqigTcXxot4yFDbqQTowv73o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048428; c=relaxed/simple;
	bh=8W28hdqjALpHKjZm3d/cnDoQbK3oKUu92wa37Lh/QAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iifK8FcghAe2yVGHLN2cn6tvWQe6DtzucmopZn3Lh19b3AtkmznA7h8KMhIetJBlsZc+ZhflLRP6XKTdKGLrSuPEfm7tNgEGZzwCGMgA2tAiDcK2vVu1GIsP91iRaXCqUkTv4n2w0JqwAqKPJLK5NSNQo/WV11YYuoti5i6rGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF54E16A3;
	Thu, 20 Feb 2025 02:47:23 -0800 (PST)
Received: from [10.1.35.44] (e127648.arm.com [10.1.35.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1FB33F59E;
	Thu, 20 Feb 2025 02:47:03 -0800 (PST)
Message-ID: <be715535-8931-489f-a2be-50aa6ec423a1@arm.com>
Date: Thu, 20 Feb 2025 10:47:01 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] mmc: core: add undervoltage handler for MMC/eMMC
 devices
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20250220074429.2906141-1-o.rempel@pengutronix.de>
 <20250220074429.2906141-5-o.rempel@pengutronix.de>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250220074429.2906141-5-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 07:44, Oleksij Rempel wrote:
> Introduce _mmc_handle_undervoltage() to handle undervoltage events for
> MMC/eMMC devices. This function interrupts ongoing operations using HPI
> and performs a controlled suspend. After completing the sequence, the card
> is marked as removed to prevent further interactions.
> 
> To support this, introduce __mmc_suspend() and __mmc_resume() as internal
> helpers that omit mmc_claim_host()/mmc_release_host(), allowing them to be
> called when the host is already claimed. Update mmc_shutdown() to skip the
> normal shutdown sequence if the host is flagged as undervoltage to avoid
> repeating of the shutdown procedure.

"of" can be removed here.

Given that this introduces large parts of the mmc handling IMO this commit
deserves a lot more explanation of what steps exactly do for which cards
and why.

> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/mmc/core/mmc.c | 81 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 68 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 86b608843232..e626213e7a52 100644
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

The is_undervoltage doesn't do anything? Did you forget something here?

>  {
>  	unsigned int notify_type;
>  	int err = 0;
> @@ -2115,8 +2115,6 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
>  	else
>  		notify_type = EXT_CSD_POWER_OFF_LONG;
>  
> -	mmc_claim_host(host);
> -
>  	if (mmc_card_suspended(host->card))
>  		goto out;
>  
> @@ -2140,7 +2138,18 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
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
> @@ -2160,6 +2169,20 @@ static int mmc_suspend(struct mmc_host *host)
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
> @@ -2169,16 +2192,9 @@ static int _mmc_resume(struct mmc_host *host)
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
> @@ -2189,6 +2205,9 @@ static int mmc_shutdown(struct mmc_host *host)
>  {
>  	int err = 0;
>  
> +	if (host->undervoltage)
> +		return 0;
> +

Probably deserves a comment.

>  	/*
>  	 * In a specific case for poweroff notify, we need to resume the card
>  	 * before we can shutdown it properly.
> @@ -2280,6 +2299,41 @@ static int _mmc_hw_reset(struct mmc_host *host)
>  	return mmc_init_card(host, card->ocr, card);
>  }
>  
> +static int _mmc_handle_undervoltage(struct mmc_host *host)
> +{
> +	struct mmc_card *card = host->card;
> +	int err = 0;
> +
> +	mmc_claim_host(host);
> +
> +	if (!host->card)
> +		goto out;
> +
> +	if (mmc_can_poweroff_notify(host->card) &&
> +		!(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
> +		err = __mmc_resume(host);

I'm not sure I follow this.
Why would we power-up a card that currently doesn't have power when we
know we are about to powerfail it?

> +
> +	if (!err) {
> +		err = mmc_interrupt_hpi(card);
> +		if (err)
> +			pr_err("%s: Interrupt HPI failed, error %d\n",
> +				mmc_hostname(host), err);

There's no point in calling this for SD but I don't see why it currently
wouldn't be called for SD.

> +
> +		err = __mmc_suspend(host, false, true);
> +	}
> +
> +	if (err)
> +		pr_err("%s: Undervoltage emergency stop failed\n",
> +			mmc_hostname(host));
> +
> +	mmc_card_set_removed(host->card);
> +
> +out:
> +	mmc_release_host(host);
> +
> +	return err;
> +}
> +
>  static const struct mmc_bus_ops mmc_ops = {
>  	.remove = mmc_remove,
>  	.detect = mmc_detect,
> @@ -2292,6 +2346,7 @@ static const struct mmc_bus_ops mmc_ops = {
>  	.hw_reset = _mmc_hw_reset,
>  	.cache_enabled = _mmc_cache_enabled,
>  	.flush_cache = _mmc_flush_cache,
> +	.handle_undervoltage = _mmc_handle_undervoltage,
>  };
>  
>  /*

