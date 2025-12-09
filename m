Received: from mail-m19731104.qiye.163.com (mail-m19731104.qiye.163.com [220.197.31.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00B2DA74D;
	Tue,  9 Dec 2025 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765272367; cv=none; b=iY2JlZ1UJKYt/vdf3cPr56lPo7V6UtLtkaqL5vhxIICAmQzNE6jBm8pgQ30jJNwm3JmPUm5WzpgTWI3OfDnvs5DNCVVvi3ldaS+3kNywDxKopGOnuzgKJzykVOTOvMHDwWddfsiMQl1E/vUq5+po1ys67QjrpFeBvEZYRu+cbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765272367; c=relaxed/simple;
	bh=x6fNxFHvgu6ENNZx02Dn0jgmIldMzFrsdk2FGYottpc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qAnwEGPmehzaLZXJpYYE5VsDrcH5xyM9ngSLrIM5s0u710zoODyfPRZsIOJMyRlf6ShWYWriuw/QGKoho3OvqTComkGNKrlAU9GcXDA7wWFqdQ4os1jFj/BTy9sBIC83nRdQImnS2NOEm3+h/Pn4nGmC9ZZaTNoxE/3ZkKaZ0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=U33g/3Y+; arc=none smtp.client-ip=220.197.31.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="U33g/3Y+"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2c861f113;
	Tue, 9 Dec 2025 15:03:36 +0800 (GMT+08:00)
Message-ID: <1eb94100-32eb-45fa-9dd9-6c5c96d9c0e4@rock-chips.com>
Date: Tue, 9 Dec 2025 15:03:34 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, jh80.chung@samsung.com,
 linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: dw_mmc: Use pre_request & post_request_end helper
To: "ping.gao" <ping.gao@samsung.com>
References: <CGME20251209064525epcas5p4904259a2a7fb971c077bfa03acce8c79@epcas5p4.samsung.com>
 <20251209064910.3643039-1-ping.gao@samsung.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251209064910.3643039-1-ping.gao@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9b01ec35ac09cckunmdbaff696320cc89
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU0dH1ZNTkwdTUNPSEJLSUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=U33g/3Y+g2SOqjI0t1myZv1q4wUbfC2uLZzuIrHc2aRKe2j6DQ3uO1gD0Mez6ZWdL7bLOgt5m/hnMLSeB5VPSl3UYoVtLh5gkFJKiSdJPWUjAnTfxaE02Q8elUTQxwT+EIJfz6uTGfRY9/6QzYf1uD90BuCy9diyOW2pVHqsxbg=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=zWN5JoOvS4v0pYW5AmL4Etd99MMip5+J52ETVAQ5qaM=;
	h=date:mime-version:subject:message-id:from;

On 2025/12/09 Tuesday 14:49, ping.gao wrote:
> Use vendor drv function to let other vendor can add some vendor function
> before and after request
> 

Without a real user, these are dead code.
Please add a driver using it, and explain how the variant driver use it.

> Signed-off-by: ping.gao <ping.gao@samsung.com>
> ---
>   drivers/mmc/host/dw_mmc.c | 7 ++++++-
>   drivers/mmc/host/dw_mmc.h | 2 ++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c5db92bbb094..5f1353b7f8d6 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1416,6 +1416,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>   {
>   	struct dw_mci_slot *slot = mmc_priv(mmc);
>   	struct dw_mci *host = slot->host;
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
>   
>   	WARN_ON(slot->mrq);
>   
> @@ -1430,7 +1431,8 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>   		mmc_request_done(mmc, mrq);
>   		return;
>   	}
> -
> +	if (drv_data && drv_data->pre_request)
> +		drv_data->pre_request(host);
>   	spin_lock_bh(&host->lock);
>   
>   	dw_mci_queue_request(host, slot, mrq);
> @@ -1897,6 +1899,7 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
>   {
>   	struct dw_mci_slot *slot;
>   	struct mmc_host	*prev_mmc = host->slot->mmc;
> +	const struct dw_mci_drv_data *drv_data = host->drv_dat
>   
>   	WARN_ON(host->cmd || host->data);
>   
> @@ -1921,6 +1924,8 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
>   
>   	spin_unlock(&host->lock);
>   	mmc_request_done(prev_mmc, mrq);
> +	if (drv_data && drv_data->post_request_end)
> +		drv_data->post_request_end(host);
>   	spin_lock(&host->lock);
>   }
>   
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 648b4a5641bf..6c258e0865e7 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -618,5 +618,7 @@ struct dw_mci_drv_data {
>   					  unsigned int timeout_ns);
>   	u32		(*get_drto_clks)(struct dw_mci *host);
>   	void		(*hw_reset)(struct dw_mci *host);
> +	void		(*pre_request)(struct dw_mci *host);
> +	void		(*post_request_end)(struct dw_mci *host);
>   };
>   #endif /* _DW_MMC_H_ */

