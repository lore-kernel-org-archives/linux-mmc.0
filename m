Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B447E1F3BA4;
	Thu, 20 Feb 2025 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050571; cv=none; b=IYBQOtViEfi1kzgVrVO1njbKqqpJsf4g8X1BUdGBttViBi6xcbiUoz8+NJEtgaaniY9zAHLB4aw5h01O1Smmn8kJlKxeAUTELXt+yJtD2kQF5MzJG2MegQw+UY7ODnpaj3yOAn/F9Qa9oCjoc7QBOC93W1BK8BgleJbBHRUxxJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050571; c=relaxed/simple;
	bh=4sLQ0bJVxX1dx3hT7ZZrtPOfhhCKSRg32U8w5kmhGWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnhGv5r58U9hvhBexs75JX0Ll/6GL6oldYm0pCJvnB4w5Qll/nJNxm0EhvPyfvRyQHgwLzn6CS054txfWYG4bM9/J773t+mvwn6x/vbrc2GZhAAwSuGKH40WeFo4xWr+ZEK20BWgELUMt8un2JITA80R3BW8RmAiLGQ47HrxJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 361AE16F3;
	Thu, 20 Feb 2025 03:23:07 -0800 (PST)
Received: from [10.1.35.44] (e127648.arm.com [10.1.35.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E41F3F5A1;
	Thu, 20 Feb 2025 03:22:47 -0800 (PST)
Message-ID: <4bdc8cef-60cc-466e-986e-46cf23d96556@arm.com>
Date: Thu, 20 Feb 2025 11:22:45 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] mmc: core: add undervoltage handler for MMC/eMMC
 devices
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20250220074429.2906141-1-o.rempel@pengutronix.de>
 <20250220074429.2906141-5-o.rempel@pengutronix.de>
 <be715535-8931-489f-a2be-50aa6ec423a1@arm.com>
 <Z7cKSuKWOedGVZ5G@pengutronix.de>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <Z7cKSuKWOedGVZ5G@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 10:56, Oleksij Rempel wrote:
> On Thu, Feb 20, 2025 at 10:47:01AM +0000, Christian Loehle wrote:
>> On 2/20/25 07:44, Oleksij Rempel wrote:
>>> Introduce _mmc_handle_undervoltage() to handle undervoltage events for
>>> MMC/eMMC devices. This function interrupts ongoing operations using HPI
>>> and performs a controlled suspend. After completing the sequence, the card
>>> is marked as removed to prevent further interactions.
>>>
>>> To support this, introduce __mmc_suspend() and __mmc_resume() as internal
>>> helpers that omit mmc_claim_host()/mmc_release_host(), allowing them to be
>>> called when the host is already claimed. Update mmc_shutdown() to skip the
>>> normal shutdown sequence if the host is flagged as undervoltage to avoid
>>> repeating of the shutdown procedure.
>>
>> "of" can be removed here.
>>
>> Given that this introduces large parts of the mmc handling IMO this commit
>> deserves a lot more explanation of what steps exactly do for which cards
>> and why.
> 
> ack
> 
>>>
>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>> ---
>>>  drivers/mmc/core/mmc.c | 81 +++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 68 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 86b608843232..e626213e7a52 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -2104,8 +2104,8 @@ static int _mmc_flush_cache(struct mmc_host *host)
>>>  	return err;
>>>  }
>>>  
>>> -static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
>>> -			bool is_undervoltage)
>>> +static int __mmc_suspend(struct mmc_host *host, bool is_suspend,
>>> +			 bool is_undervoltage)
>>
>> The is_undervoltage doesn't do anything? Did you forget something here?
> 
> This was done in the previous patch "mmc: core: refactor _mmc_suspend()
> for undervoltage handling"

Sorry!

> 
>>> @@ -2189,6 +2205,9 @@ static int mmc_shutdown(struct mmc_host *host)
>>>  {
>>>  	int err = 0;
>>>  
>>> +	if (host->undervoltage)
>>> +		return 0;
>>> +
>>
>> Probably deserves a comment.
> 
> ack
> 
>>>  	/*
>>>  	 * In a specific case for poweroff notify, we need to resume the card
>>>  	 * before we can shutdown it properly.
>>> @@ -2280,6 +2299,41 @@ static int _mmc_hw_reset(struct mmc_host *host)
>>>  	return mmc_init_card(host, card->ocr, card);
>>>  }
>>>  
>>> +static int _mmc_handle_undervoltage(struct mmc_host *host)
>>> +{
>>> +	struct mmc_card *card = host->card;
>>> +	int err = 0;
>>> +
>>> +	mmc_claim_host(host);
>>> +
>>> +	if (!host->card)
>>> +		goto out;
>>> +
>>> +	if (mmc_can_poweroff_notify(host->card) &&
>>> +		!(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
>>> +		err = __mmc_resume(host);
>>
>> I'm not sure I follow this.
>> Why would we power-up a card that currently doesn't have power when we
>> know we are about to powerfail it?
> 
> It is part of the mmc_shutdown, but it is not used on my HW. So, can be
> skip it.
> 
>>> +
>>> +	if (!err) {
>>> +		err = mmc_interrupt_hpi(card);
>>> +		if (err)
>>> +			pr_err("%s: Interrupt HPI failed, error %d\n",
>>> +				mmc_hostname(host), err);
>>
>> There's no point in calling this for SD but I don't see why it currently
>> wouldn't be called for SD.
> 
> I tried to keep budget low, until we agree that it is the way to go.
> After this patch stack is accepted, i can try to request more time to
> add and test the SD handler.
If you're not implementing this for now, why not just drop the undervoltage
event at patch 1/6 if host doesn't have an eMMC attached?
