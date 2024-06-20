Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9793E1BF53
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897470; cv=none; b=tBD3Uadn0970Y/F/4Gf7DcelHi0t9PmmR1RDrj4shlDl7P+Wl7Zsxl1FP1t4/d4Vb08UTzNdx/7lKPcTRCQcAGN8Jo/gfzvZoMP6NNgWhlebjRd3IX1O4l18v8pav+weXZJ0H11C3SS4jCTF8CaFci4nVNn5gHDd6r/xFaVhIeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897470; c=relaxed/simple;
	bh=epawaL7YtAOR416OhZF8hMy3BYtfY+G3FdfjGIWengo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHQ3GYv8iwuTWiwAMScQGYXzJHWwUd126d3+45iQe5jpqLcKmO4C67ZnF+2w7sgIMv6rmTxJUaVegDhwBOq02mZaXKYWpOSFBmAzb1sLX0/7iIfPhkuTvEeM4lNblQMN3nNODQ21tjT6AOpQPfKD6Waxp3hhlGC580/cURPQ7Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CB4DDA7;
	Thu, 20 Jun 2024 08:31:31 -0700 (PDT)
Received: from [10.1.27.54] (e127648.arm.com [10.1.27.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 027553F73B;
	Thu, 20 Jun 2024 08:31:05 -0700 (PDT)
Message-ID: <cf863ebd-df9c-4088-a273-26408c7c132a@arm.com>
Date: Thu, 20 Jun 2024 16:31:03 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mmc: core: allow detection of locked cards
To: Ulf Hansson <ulf.hansson@linaro.org>, Daniel Kucera <linux-mmc@danman.eu>
Cc: linux-mmc@vger.kernel.org
References: <20240606131222.1131880-1-linux-mmc@danman.eu>
 <CAPDyKFpuJexp_1hgKhJ3b8VCx+PwwhAQscbJT5-44Re0xmbxrg@mail.gmail.com>
 <c89d8a0c170fa3bc8593bfde25b07e4d@danman.eu>
 <CAPDyKFpLkmU-vjAaM=QDkc+3F3tMNjViOdnYSFNqyDduyfBm1g@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAPDyKFpLkmU-vjAaM=QDkc+3F3tMNjViOdnYSFNqyDduyfBm1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/24 15:32, Ulf Hansson wrote:
> On Thu, 20 Jun 2024 at 14:59, Daniel Kucera <linux-mmc@danman.eu> wrote:
>>
>> On 2024-06-20 14:38, Ulf Hansson wrote:
>>> On Thu, 6 Jun 2024 at 15:12, <linux-mmc@danman.eu> wrote:
>>>>
>>>> From: Daniel Kucera <linux-mmc@danman.eu>
>>>>
>>>> Locked SD card will not reply to SEND_SCR or SD_STATUS commands
>>>> so it was failing to initialize previously. When skipped,
>>>> the card will get initialized and CMD42 can be sent using
>>>> ioctl to unlock the card or remove password protection.
>>>> For eMMC, this is not necessary because all initialization
>>>> commands are allowed in locked state.
>>>> Until unlocked, all read/write calls will timeout.
>>>
>>> Skipping the commands above, only means the card gets partially
>>> initialized.
>>
>> Correct, but it's an improvement in comparison to current state.
> 
> Not sure I agree with that, sorry.
> 
>>
>>> Leaving a card in that state seems fragile.
>>
>> Fragile in what sense? Nothing can happen to the card as it is locked.
> 
> We may end up having a card half-way initialized that we can't really
> communicate with in a stable manner. From a system point of view, I
> would be worried.
> 
> I would rather just power off the card if initialization fails and
> remove its corresponding device from the system.
> 
>>
>>> What will
>>> happen to upper block layers and filesystems when trying to access it?
>>
>> Everything will simply time-out.
> 
> Yes, but it's uncertain what that could lead to?
> 
> What will happen with power consumption and power management support,
> for example.

Definitely an aspect that needs to be considered, probably even just
powering it off after 10ish seconds would be better, then you still
get the chance of unlocking it without having a locked card unknowingly
consuming power.
Having a saved key and sending that to any card being plugged in seems
wrong if you consider security, then again if you consider security
you should probably somewhere else than the SD/MMC LOCK/UNLOCK ;)

Kind Regards,
Christian

