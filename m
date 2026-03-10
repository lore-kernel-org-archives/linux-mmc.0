Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA0119644B
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773103042; cv=none; b=TD5vdc5LWPQBqQNHAeeGS7HZQ05+H9NchtFH3Vvc1cboRJq4mrgNxKAGRKL6S91IrdgFJYWvkMgoCM80iqjqjiHmNuSKmab1WfuHZXO/UCxG1tCMlqiun3aSrEGgJpLE6xF6SrnfvQMY6DJ7FwBy6ynWs4vVN6etKwqREa6bitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773103042; c=relaxed/simple;
	bh=mQcN65DcwiSHRZ3mASsLo6cRlyL8LiL5y9HN9m0lCNU=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=beKR6mHp37G8gyoqXnHxJllqfzHjOacay02mbQgCCg9WKLwMGZtv/j9oWeL1p/dVO36lwm3jNcvHcvI+qPpxtNPFFR5+NIWoW8rDUiPrBliWvTvP+Ev5MegY58mx7DZ1LZIdJ7VL3HXO3ZwDz7f0hJ/FupW0fOGcqda/Pow7vVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JKplKUec; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JKplKUec"
Cc: shawn.lin@linux.dev, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luke Wang <ziniu.wang_1@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773103039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iy9yGbypJD7EgmEJLihI0ozU9PEDNhoBVrPB8+9OksA=;
	b=JKplKUecGnmBpi6tbwfPtFAvFj19WvR/hlfpyvjfed+YDID6UHAl0644dPE8SiYqxvYSaL
	F8tFP1fjqZqRbiDUa1+3HIBROJLVrCtVVqAJDbFRp98r9w1oZglOxSKVVGU3e8ihXJtsO/
	Xw9Hm13IL1ao7SaoTR8kK4RVN7yaS1g=
Subject: Re: [PATCH 1/2] mmc: core: Validate UHS/DDR/HS200 timing selection
 for 1-bit bus width
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <20260306124812.332098-1-shawn.lin@linux.dev>
 <20260306124812.332098-2-shawn.lin@linux.dev>
 <CAPDyKFpKBU9woEd8EfLAxuHWgyDqL=nKCPVdC687u6n-vE0duQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shawn Lin <shawn.lin@linux.dev>
Message-ID: <933a0192-3994-5c34-1981-887ff01bcec4@linux.dev>
Date: Tue, 10 Mar 2026 08:37:04 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpKBU9woEd8EfLAxuHWgyDqL=nKCPVdC687u6n-vE0duQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Ulf,

在 2026/03/09 星期一 22:57, Ulf Hansson 写道:
> On Fri, 6 Mar 2026 at 13:48, Shawn Lin <shawn.lin@linux.dev> wrote:
>>
>> From: Luke Wang <ziniu.wang_1@nxp.com>
>>
>> UHS/DDR/HS200 modes require at least 4-bit bus support. Host controllers
>> that lack relevant capability registers rely on paring properties provided
>> by firmware, which may incorrectly set these modes. Now that mmc_validate_host_caps()
>> has been introduced to validate such configuration violations, let's also
>> add checks for UHS/DDR/HS200 modes.
>>
>> This fixes an issue where, if the HS200/HS400 property is set while only a
>> 1-bit bus width is used, mmc_select_hs200() returns 0 without actually performing
>> the mode switch. Consequently, mmc_select_timing() proceeds without falling back to
>> mmc_select_hs(), leaving the eMMC device operating in legacy mode (26 MHz) instead
>> of switching to High Speed mode (52 MHz).
>>
>> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
>> [Shawn: reword the commit msg and drop HS400 change]
>> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
>> ---
>>
>>   drivers/mmc/core/host.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 88c95db..d1d4870 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -624,6 +624,15 @@ static int mmc_validate_host_caps(struct mmc_host *host)
>>                  return -EINVAL;
>>          }
>>
>> +       /* UHS/DDR/HS200 modes require at least 4-bit bus */
>> +       if (!(caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) &&
>> +           ((caps & (MMC_CAP_UHS | MMC_CAP_DDR)) || (caps2 & MMC_CAP2_HS200))) {
>> +               dev_warn(dev, "drop UHS/DDR/HS200 support since 1-bit bus only\n");
>> +               host->caps = caps = caps & ~(MMC_CAP_UHS | MMC_CAP_DDR);
>> +               host->caps2 = caps2 = caps2 & ~MMC_CAP2_HS200;
> 
> Hmm.
> 
> How about just updating the temporary variables, caps and caps2, here?
> 
> Then at the end of the function when we have validated all "caps", we
> can update the variables in the host, like:
> host->caps = caps;
> host->caps2 = caps2;

It looks better. Will update v2 based on your suggestion.

> 
>> +       }
>> +
>> +       /* HS400 and HS400ES modes require 8-bit bus */
>>          if (caps2 & (MMC_CAP2_HS400_ES | MMC_CAP2_HS400) &&
>>              !(caps & MMC_CAP_8_BIT_DATA) && !(caps2 & MMC_CAP2_NO_MMC)) {
>>                  dev_warn(dev, "drop HS400 support since no 8-bit bus\n");
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
