Received: from mail-m155106.qiye.163.com (mail-m155106.qiye.163.com [101.71.155.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10F01FF7C5;
	Thu, 18 Dec 2025 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041257; cv=none; b=VGp9uruL1QjaExE5ycN8GWqk0e/UmeqNJITOrsdCIUaigLgDR5sZ153gpnQFF6iMT4tk9sP6yBmcWt5HaBwsr8rmI3TxYBqINtA7R+0DDo8/SLahw4Y9N/LbV1lVutnT0RrRRDVMzCW+5EGOaCzNgWfX4LwF50BOpzko7/Cbtj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041257; c=relaxed/simple;
	bh=yKnnvV3MATGLG5iy9ijt9y5cnAPhKtnIiSb+oN5Lgbs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sQ908sh2EHy8hputIWq3Iwef9UfQUgH3sO74mhd/4CcWA331fmzw8JKkSjemsRr+DQ3OvuTOHN4WkFj0RyrAYqqFOrJDrwnhrJ2X+mRN4B33UZj0ls1GQHhDJzJohVoelvukwLj3XI0aOnHxqQDT1/DyA7nvnwpd8fjkf0Umxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GflZQEzy; arc=none smtp.client-ip=101.71.155.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GflZQEzy"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2db67ba8e;
	Thu, 18 Dec 2025 14:55:32 +0800 (GMT+08:00)
Message-ID: <db5a89e2-9e9d-4340-b7b4-22a4c13b27e2@rock-chips.com>
Date: Thu, 18 Dec 2025 14:55:31 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, jh80.chung@samsung.com, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] MMC:dw_mmc:when disable biu_clk should check whether this
 clk is normal
To: "ping.gao" <ping.gao@samsung.com>
References: <CGME20251218064655epcas5p328ad453941deb1c60ee151b6ba11d8a0@epcas5p3.samsung.com>
 <20251218065048.1316282-1-ping.gao@samsung.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251218065048.1316282-1-ping.gao@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b303e104e09cckunm44b9b6165440d0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpJS1YaHkpJHh5MGk1CHk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=GflZQEzyXiwRzbF4Fh9C6+qCoIKiqdLXF1+p0tPWT2C7SEdJgZhmBlbeV92GoElcYnjglGpHqdPTdY+ZD82WZpClT2CPQm6Dkj4UXStn/kFtDV+rbnoTe+ShEapmrtQpn/0zVx1zcv5jQTMgVtDzgYrIoKhmMVLLeXqRf3U+eks=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=8IRvxq1tHlFZJp29RIkS9MABJ8Ds3bRXeVFIZICo+xs=;
	h=date:mime-version:subject:message-id:from;

在 2025/12/18 星期四 14:50, ping.gao 写道:
> some vendor not enable biu_clk , disable it will panic
> 

Sorry, I can't follow the below changes.
Isn't we disable biu_clk in dw_mci_runtime_suspend(()?
How could that work because biu_clk is used for register
access, FIFO access, etc.


> Signed-off-by: ping.gao <ping.gao@samsung.com>
> ---
>   drivers/mmc/host/dw_mmc.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c5db92bbb094..e737333a0727 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3633,9 +3633,15 @@ int dw_mci_runtime_resume(struct device *dev)
>   	if (host->slot &&
>   	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
>   	     !mmc_card_is_removable(host->slot->mmc))) {
> -		ret = clk_prepare_enable(host->biu_clk);
> -		if (ret)
> -			return ret;
> +		if (IS_ERR(host->biu_clk)) {
> +			dev_dbg(host->dev, "biu clock not available\n");
> +		} else {
> +			ret = clk_prepare_enable(host->biu_clk);
> +			if (ret) {
> +				dev_err(host->dev, "failed to enable biu clock\n");
> +				goto err;
> +			}
> +		}
>   	}
>   
>   	ret = clk_prepare_enable(host->ciu_clk);
> @@ -3686,9 +3692,12 @@ int dw_mci_runtime_resume(struct device *dev)
>   err:
>   	if (host->slot &&
>   	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
> -	     !mmc_card_is_removable(host->slot->mmc)))
> -		clk_disable_unprepare(host->biu_clk);
> -
> +	     !mmc_card_is_removable(host->slot->mmc))) {
> +		if (IS_ERR(host->biu_clk))
> +			dev_dbg(host->dev, "biu clock not available\n");
> +		else
> +			clk_disable_unprepare(host->biu_clk);
> +	}
>   	return ret;
>   }
>   EXPORT_SYMBOL(dw_mci_runtime_resume);

