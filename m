Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4727B2144AF;
	Thu, 13 Feb 2025 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445204; cv=none; b=MErwvVFdbMY1vZhFblAch3s/4tVuQCi7mzR0MT/t4ROoMCHqwxaS3pLB1M0Sq2iU+jY7rOPHdmzaIKzFuUFPabddlzpfg0Y2SHwqlf2fQ1+kr3pyFJpRbbEF3YeMFBC25pWWUeeyoeneELA+f9QKNCsMYuT/W80wp1/yfuY37fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445204; c=relaxed/simple;
	bh=arRIVSK6KM+bn9LPg+TCwveAAMQvWokH45zS6QwuOOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7TP/giT72SSoejWGCU1WAVlvao6rNEGkj7VRUzOiHQ8N7PKrlvwpl6j4F+U5uuONFAzs3IRm5R9qZlJjKVE9iUJjgyhKeXYpPXwTR71RATAIIcW+PbWMTez9TFsZHPJHM2V/uaB3vwuT7UMl9Z/dxM5qo+QXvGdx1efZSFaFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1109B113E;
	Thu, 13 Feb 2025 03:13:42 -0800 (PST)
Received: from [10.57.37.151] (unknown [10.57.37.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B8743F6A8;
	Thu, 13 Feb 2025 03:13:19 -0800 (PST)
Message-ID: <21ba3465-9e24-4b5a-a239-4a3ed5bf2309@arm.com>
Date: Thu, 13 Feb 2025 11:13:17 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: core: Handle undervoltage events and register
 regulator notifiers
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250212132403.3978175-1-o.rempel@pengutronix.de>
 <96959ef4-2287-4601-85fb-2ce457c605d2@arm.com>
 <Z620Ei5FwhhPfBu9@pengutronix.de>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <Z620Ei5FwhhPfBu9@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 08:57, Oleksij Rempel wrote:
> On Wed, Feb 12, 2025 at 11:47:08PM +0000, Christian Loehle wrote:
>> On 2/12/25 13:24, Oleksij Rempel wrote:
>>> Extend the MMC core to handle undervoltage events by implementing
>>> infrastructure to notify the MMC bus about voltage drops.
>>>
>>> Background & Decision at LPC24:
>>>
>>> This solution was proposed and refined during LPC24 in the talk
>>> "Graceful Under Pressure: Prioritizing Shutdown to Protect Your Data in
>>> Embedded Systems" which aimed to address how Linux should handle power
>>> fluctuations in embedded devices to prevent data corruption or storage
>>> damage.
>>>
>>> At the time, multiple possible solutions were considered:
>>>
>>> 1. Triggering a system-wide suspend or shutdown: when undervoltage is
>>>    detected, with device-specific prioritization to ensure critical
>>>    components shut down first.
>>>    - This approach was disliked by Greg Kroah-Hartman, as it introduced
>>>      complexity and was not suitable for all use cases.
>>>
>>> 2. Notifying relevant devices through the regulator framework: to allow
>>>    graceful per-device handling.
>>>    - This approach was agreed upon as the most acceptable: by participants
>>>      in the discussion, including Greg Kroah-Hartman, Mark Brown,
>>>      and Rafael J. Wysocki.
>>>    - This patch implements that decision by integrating undervoltage
>>>      handling into the MMC subsystem.
>>>
>>> This patch was tested on iMX8MP based system with SDHCI controller.
>>
>> Any details here? How long does it take from undervoltage to
>> poweroff notification.
> 
> On this system, with current implementation, it takes 4.5 millisecond
> from voltage drop detection to mmc_poweroff_notify.
> 
>> Roughly how long of a heads up would that yield in realistic
>> undervoltage scenarios?
> 
> It depends on the board implementation and attached power supply.
> In my case, the testing system provides about 100ms capacity on board.
> The power supply provides additional 1-2 seconds.
> 
> If the power is cut between power supply and board, we will have max
> 100ms.

Thanks, that's not too bad then.

> 
>>> +static int _mmc_handle_undervoltage(struct mmc_host *host)
>>> +{
>>> +	return mmc_shutdown(host);
>>> +}
>>> +
>>
>> The poweroff notification part I understand, because it polls for busy
>> (i.e. hopefully until the card thinks it's done committing to flash).
>> Poweroff isn't always available though, the other paths of
>> _mmc_suspend() are:
>>
>> 	else if (mmc_can_sleep(host->card))
>> 		err = mmc_sleep(host);
>> 	else if (!mmc_host_is_spi(host))
>> 		err = mmc_deselect_cards(host);
>>
>> 	if (!err) {
>> 		mmc_power_off(host);
>>
>> So we may also just deselect, which AFAIR succeeds as a FSM (i.e.
>> doesn't mean anything was committed to flash) and then we just
>> poweroff.
>> Is that what we want in an undervoltage scenario?
> 
> Yes. In an undervoltage scenario, our primary priority is to protect the
> hardware from damage. Data integrity is secondary in this case. The most
> critical action is to immediately stop writing to the card.  

Protect hardware from damage by not having the powerfail during a
host-write? An active host-write command doesn't sound like the
actual cause, any writing metadata to flash more likely, which in the
deselect->poweroff case isn't ensured at all to not be the case.

While I still think this should be handled at procurement instead of the
kernel (especially if you don't even care about data integrity?), I'd
still be interested how we would ensure we aren't doing more harm than
good here.
Any info from some vendors how they implement any of these? IME only
poweroff notify would do anything at all to help and if that isn't
available we should leave the voltage up for the card and idle.

FWIW poweroff notify should probably be
EXT_CSD_POWER_OFF_SHORT
instead of the current EXT_CSD_POWER_OFF_LONG for your intended use case.

