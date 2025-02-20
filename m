Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2932B1EEA38;
	Thu, 20 Feb 2025 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049563; cv=none; b=uZfOQQRk+NaOeJz/w7KnXIxE3d8Xu2YnF4WFtJ49fOixCnDgFOICMfxZPs4TEKFVO+Nh1fPhM+a6BvM2DWInb9sMPTE/nXTTBPa4tC5jHm5oG8HCpCYoEXgKkVJHIU10jEtqGCMW2LkRaCH7KMi3Mtm4qe09290Rg1gSxmxc6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049563; c=relaxed/simple;
	bh=WrdTh8dVQUQWXU6nxG0TkMEVHuE3SktHH/1l5KM9bW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBIvI9VGH2GQN9pFxzncUYw81cMvSKyfqPUNHQqXC/0Vp+p0sh2sDhaC3SXA5ji6SwhNfYpejCXn6SUtzM7ZG/HGLpYrONtrCFnK4NHot1ss+HMz3IO3BTY8YqvjjsfbCKSSsDA0jb6GxTq2P3dbMkCsYvqcwUS3k1PA0+vfQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7996F16A3;
	Thu, 20 Feb 2025 03:06:19 -0800 (PST)
Received: from [10.1.35.44] (e127648.arm.com [10.1.35.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 675503F5A1;
	Thu, 20 Feb 2025 03:05:59 -0800 (PST)
Message-ID: <0be29875-3254-411e-8b21-58620d68de7b@arm.com>
Date: Thu, 20 Feb 2025 11:05:57 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mmc: core: refactor _mmc_suspend() for
 undervoltage handling
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20250220074429.2906141-1-o.rempel@pengutronix.de>
 <20250220074429.2906141-4-o.rempel@pengutronix.de>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250220074429.2906141-4-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 07:44, Oleksij Rempel wrote:
> Introduce an is_undervoltage parameter to _mmc_suspend() to apply a
> short power-off sequence and optionally flush the cache. This refactoring
> prepares for undervoltage support in a follow-up patch.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/mmc/core/mmc.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6a23be214543..86b608843232 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2104,20 +2104,27 @@ static int _mmc_flush_cache(struct mmc_host *host)
>  	return err;
>  }
>  
> -static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
> +static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
> +			bool is_undervoltage)

I see, sorry about missing this on 4/6 :/

>  {
> +	unsigned int notify_type;
>  	int err = 0;
> -	unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
> -					EXT_CSD_POWER_OFF_LONG;
> +
> +	if (is_undervoltage || is_suspend)
> +		notify_type = EXT_CSD_POWER_OFF_SHORT;
> +	else
> +		notify_type = EXT_CSD_POWER_OFF_LONG;
>  
>  	mmc_claim_host(host);
>  
>  	if (mmc_card_suspended(host->card))
>  		goto out;
>  
> -	err = _mmc_flush_cache(host);
> -	if (err)
> -		goto out;
> +	if (is_undervoltage) {
> +		err = _mmc_flush_cache(host);
> +		if (err)
> +			goto out;
> +	}

This is supposed to be !is_undervoltage, isn't it?

>  
>  	if (mmc_can_poweroff_notify(host->card) &&
>  	    ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
> @@ -2144,7 +2151,7 @@ static int mmc_suspend(struct mmc_host *host)
>  {
>  	int err;
>  
> -	err = _mmc_suspend(host, true);
> +	err = _mmc_suspend(host, true, false);
>  	if (!err) {
>  		pm_runtime_disable(&host->card->dev);
>  		pm_runtime_set_suspended(&host->card->dev);
> @@ -2191,7 +2198,7 @@ static int mmc_shutdown(struct mmc_host *host)
>  		err = _mmc_resume(host);
>  
>  	if (!err)
> -		err = _mmc_suspend(host, false);
> +		err = _mmc_suspend(host, false, false);
>  
>  	return err;
>  }
> @@ -2215,7 +2222,7 @@ static int mmc_runtime_suspend(struct mmc_host *host)
>  	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
>  		return 0;
>  
> -	err = _mmc_suspend(host, true);
> +	err = _mmc_suspend(host, true, false);
>  	if (err)
>  		pr_err("%s: error %d doing aggressive suspend\n",
>  			mmc_hostname(host), err);

