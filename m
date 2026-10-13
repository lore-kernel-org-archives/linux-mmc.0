Received: from mail-m15599.qiye.163.com (mail-m15599.qiye.163.com [101.71.155.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0413C7DEB;
	Tue, 13 Oct 2026 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882647; cv=none; b=T7u5L9GTgeLPOEZ+mpnFCIkBlHiSsMaJ8UYQ07+ICUgJk30n/VdK7HArd1kze2Uo1Cvr0yJYhMM8m20VYcVqKXvZKqVJm/EbLRdhHrxGnqADr3gKQP/ueA/DFAWbINDiDFs4j7p6uY4hIheV9jeRoQ4nlQVdqwxK9TTNqPPV1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882647; c=relaxed/simple;
	bh=+A5rM5nul/qVEMnGB3L4YcbBECC9pN/mZtMqKAgGMP8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XsMs7JaOmpA16qeLKxERDSyT9mtO+EwBRNSCUqKmnYZW7H7O7qJ3mwZOD9JF7biaulEu2ElAA6nFL8+iJGG2WSqJVT/HUp1ndzqG9g8lWwuLCvJAHEbbsd2gFah1uJePO1Y1rgUM94U08OiV3Nd1Mp5HEGE+58nbh5W3g4igLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XjRm8gCq; arc=none smtp.client-ip=101.71.155.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XjRm8gCq"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 50dc42bd7;
	Tue, 13 Oct 2026 17:05:25 +0800 (GMT+08:00)
Message-ID: <2a29adf5-2a59-4287-8b10-68a62f317421@rock-chips.com>
Date: Tue, 13 Oct 2026 17:05:23 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: downgrade HS200/HS400 clock-reduce
 message to dev_dbg
To: Jun Yan <jerrysteve1101@gmail.com>
References: <20261009084604.385664-1-jerrysteve1101@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261009084604.385664-1-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa134826bd403a4kunmdb6e1c8e27d5c7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTUIZVh8fTkkaGB5PSEMZHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XjRm8gCq5oo8/+aTfVq3gyvd5pwz955UVSIvjT16tDQMbmWgnWeiZzOj1xIH15DrxtZOvC6eCFMlIv31LZOMijrhVHvL+Jbzq6oms28fakrXHE1A6IbVAwqPeL+MmBiWM8F4Kz/EzVG2F+KYsHbQ+iIfB6Wi1Z9MjgYOgdknNiM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=WiaJHlPPwn3yO4hvyZolRZvDDzjb6V8u/pwfkykJyXo=;
	h=date:mime-version:subject:message-id:from;

Hi Jun

在 2026/10/09 星期五 16:46, Jun Yan 写道:
> dwcmshc_rk3568_set_clock() refuses to lower the bus clock below 52 MHz
> when the eMMC is in HS200/HS400 mode, since those modes require a
> minimum 52 MHz bus clock.  This is expected behaviour, but it is
> currently reported at dev_err level and therefore fires on every boot
> and on every suspend/resume cycle, cluttering the kernel log.
> 
> Demote the message to dev_dbg so it stays out of the default log while
> remaining available via dynamic debug.
> 

ios.clock and ios.timing are independent fields, updated by the MMC core
through separate calls. During card init, the core will hit this that
clock <= 52 MHz  but timing in {HS200, HS400}, so it is a normal,
intermediate state, not an error. So the message on every boot.

Changes it to dev_dbg is fine to me:
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks.

> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> ---
>   drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index c688f3eaf468..b4fb1c1e6d99 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -790,7 +790,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>   	if (clock <= 52000000) {
>   		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
>   		    host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
> -			dev_err(mmc_dev(host->mmc),
> +			dev_dbg(mmc_dev(host->mmc),
>   				"Can't reduce the clock below 52MHz in HS200/HS400 mode");
>   			goto enable_clk;
>   		}

