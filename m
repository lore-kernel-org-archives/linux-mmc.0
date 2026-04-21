Received: from mail-m15578.qiye.163.com (mail-m15578.qiye.163.com [101.71.155.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA4640DFC1;
	Tue, 21 Apr 2026 02:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776737857; cv=none; b=eErliQ6bNvadoV1gPS8wXXp5yjAMuc+5eLghbkKTH7ov9JE1ANx6Umut/76XwWAF+jE0p6acJolSDP2e2AhqPljsSoVP+681cE2YaC80gJl1eLF3qvezbs4NO77uxEwzk+ayOETgKDNk4Rz9VSdT4dw/AvC6K+CRpHZ34X9+RsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776737857; c=relaxed/simple;
	bh=btKibB06+VcT4mINDzVY9/6awfT43LRd1wXk2y3FR/w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RsVWn0kST8zsjII0Wmo0sSEIGsTh4gwz2R0bGW8Z+sD2r4RMAMf3jbTfy7JSvLQbdGtaOPIjV4cCU8rX7FJtUWyo/gsguwLttQM17XtKH4rjllOog8iP564msKq/WA6BU/E08FhTmEs3RJz0Bl+3tebcCE6CZm0RhNplkq1i6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gut4XU7r; arc=none smtp.client-ip=101.71.155.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gut4XU7r"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b7b37283;
	Tue, 21 Apr 2026 10:02:01 +0800 (GMT+08:00)
Message-ID: <b956b5d4-d24c-ea55-8694-b512129fcf03@rock-chips.com>
Date: Tue, 21 Apr 2026 10:02:00 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Avri Altman <avri.altman@sandisk.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: fix host controller programming for fixed
 driver type
To: Kamal Dasu <kamal.dasu@broadcom.com>, Ulf Hansson <ulfh@kernel.org>
References: <20260417210225.3101961-1-kamal.dasu@broadcom.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260417210225.3101961-1-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9dadc5e63109cckunm9f8901d69263a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwfTlZPQ0JMSxhOThhMHhpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gut4XU7rmCOY5sjI3fAaxjjUmIBReBLcdAu/HYkQ4GN+ksg5WvL96BwTHajfiGpbgOh4wabALshKsXHFcliwSzEqW7NR6Hy1PYwD1JcNVZSHE5zVS8qqr70MigURMJWJIh+e39fbNHDmmbOy/kWFhZw2aN1/2u0/yLjyLt13U/s=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=nIWlvSi11zEgo5EcKST15AEIZ272WDUvm4coT/2VQgw=;
	h=date:mime-version:subject:message-id:from;

在 2026/04/18 星期六 5:02, Kamal Dasu 写道:
> When using the fixed-emmc-driver-type device tree property, the MMC core
> correctly selects the driver strength for the card but fails to program
> the host controller accordingly. This causes a mismatch where the card
> uses the specified driver type while the host controller defaults to
> Type B (since ios->drv_type remains zero).
> 
> Split the driver type programming logic to handle both fixed and dynamic
> driver type selection paths. For fixed driver types, program the host
> controller with the selected drive_strength value. For dynamic selection,
> use the existing drv_type as before.
> 
> This ensures both the eMMC device and host controller use matching driver
> strengths, preventing potential signal integrity issues.
> 

I agree the host and card drive strengths should match. However, it
highlights a deeper issue: the drv_type(A/B/C/D) is only implemented by
sdhci-based hosts. Many other controllers configure their drive strength
in their GPIO or IOMUX/Pinmux modules, which currently have no
association with ios->drv_type. Moreover, the strength levels defined by
the type A/B/C/D standard may not have a direct mapping to the drive 
strength settings of these modules.

Therefore, the fixed-emmc-driver-type property may have introduced a
"signal configuration gap" from the start: it can specify a type for the 
eMMC device side, but the corresponding drive strength configuration on
the host side may not take effect, or may not even exist. This is not
just a missing driver implementation, but a lack of coordination at the
framework level.

Nevertheless, within the existing framework, this patch is a reasonable
and positive improvement to me. With one suggestion below, feel free to add:

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>


> Fixes: 6186d06c519e ("mmc: parse new binding for eMMC fixed driver type")
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>   drivers/mmc/core/mmc.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 8846550a8892..3507a8d8610a 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1371,8 +1371,12 @@ static void mmc_select_driver_type(struct mmc_card *card)
>   
>   	card->drive_strength = drive_strength;
>   
> -	if (drv_type)
> +	if (fixed_drv_type >= 0) {

How about check in a single line: if (fixed_drv_type >= 0 && drive_strength)

> +		if (drive_strength)
> +			mmc_set_driver_type(card->host, drive_strength);
> +	} else if (drv_type) {
>   		mmc_set_driver_type(card->host, drv_type);
> +	}
>   }
>   
>   static int mmc_select_hs400es(struct mmc_card *card)
