Received: from mail-m3273.qiye.163.com (mail-m3273.qiye.163.com [220.197.32.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624B4F473F;
	Wed, 30 Sep 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779905; cv=none; b=ohQbtHivtpCmniyS1ODIctSuMNL0zIfGhDEUQ12vzesouuywugWPh0lb8Tchff9Vzr3KHiYQVaUnB4URryi+2xRcqoLgdNJLjX5SvwY4QYuwul3n8YFm56XitiG51iQvCQT75fzqNaH19cOU3PjYtLNU4LXZGDhEXEysCRi2TII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779905; c=relaxed/simple;
	bh=ibWPXe6d/WlCmvRQGKjbWLi44PvbZjjGK5ZLApJEXXY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EgSUvAwPT3TDpmGD4/ZITiS+XOKiCHdAWvFFipsVKwts5jFdmH4hdUH3oL+Oz78R+sa9jXFelUswYdhK7/GEDLXn+7mcw9QC2cFnb7fXG5DaR/LOllO1IqRtif7XrE5gmW6noQt0Lw6+YqpWLFf/fq/hBEt+EEBq+Y6JKUomlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=S3TDqI2m; arc=none smtp.client-ip=220.197.32.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="S3TDqI2m"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4fa8f5751;
	Wed, 30 Sep 2026 22:46:09 +0800 (GMT+08:00)
Message-ID: <5874cbba-bf20-47c7-a29a-53ec7caa2c51@rock-chips.com>
Date: Wed, 30 Sep 2026 22:46:06 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulfh@kernel.org>,
 linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Let mmc_regulator_set_vqmmc() use ios->vdd to set
 vqmmc
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
References: <1790742751-245571-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPx+jO-8tii2kFmVQUfcYN5YUGuOpX_8aPg=BndPurt6bff2vQ@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPx+jO-8tii2kFmVQUfcYN5YUGuOpX_8aPg=BndPurt6bff2vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0f2c7b4d803a4kunm6e9e3da7910ad7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0JNVkJNGEJCHU8YQk9KH1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=S3TDqI2mOxKRZ6DAry0P+NUIv/YbiOBhHoEsnuLdctImtD7nYWLALfIZc3SY9WsTRKzUeSJb/kWN6yrnnZgLB3y9HL7Y0Xr8r8vtfOpPtFfQ0d53YYQVd0VmaoRE2CN8pauYoQB8QjtiIsG8NnqAMDKWLkNh4NpwbNZKI4wCrJk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=uhUFsxwa/FWw097QSUw/r/xeF3St4fGa/bbFmILn6Lk=;
	h=date:mime-version:subject:message-id:from;

Hi Ulf

在 2026/09/30 星期三 17:40, Ulf Hansson 写道:
> On Wed, Sep 30, 2026 at 6:33 AM Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>>
>> mmc_regulator_set_vqmmc() derives the vqmmc voltage range from
>> mmc->ios.vdd, which can be stale with respect to the ios passed by the
>> caller. patch 2 uses ios->vdd instead; patch 1 prepares sdhci-msm,
>> which passes a local ios with an uninitialized vdd.
>>
>>
>>
>> Shawn Lin (2):
>>    mmc: sdhci-msm: Initialize the local ios in msm_toggle_vqmmc()
>>    mmc: core: Use the ios vdd when calculating vqmmc for 3.3V signaling
>>
>>   drivers/mmc/core/regulator.c | 2 +-
>>   drivers/mmc/host/sdhci-msm.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> --
>> 2.7.4
>>
> 
> Not sure how you posted this, but it seems like patch1 didn't make it
> to lore nor to patchwork.
> 
> Are you using b4?

Yes, I was using b4.

I'm not at all surprised that some patches take longer than others in
the same series to hit the mailing list. I've run into it occasionally.
My guess is that certain words in the email trigger the list's
moderation filter.

But anyway, it reached lore finally:
https://lore.kernel.org/linux-mmc/1790742751-245571-2-git-send-email-shawn.lin@rock-chips.com/T/#u

> 
> Kind regards
> Uffe
> 

