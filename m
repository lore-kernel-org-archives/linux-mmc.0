Received: from mail-m155105.qiye.163.com (mail-m155105.qiye.163.com [101.71.155.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D71DE4FB;
	Fri, 12 Dec 2025 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765500254; cv=none; b=b9zMebW95pviGPy/tzi3Xl6/H4EIKylgTpvXmYKxYC9/peTPLylry5qr57VnF3QRXk1jfS9ib6UxBhY8Nke7byP/9piWDfqx4Jcy4dA85ITDM3vp+lsvYAD8lOXVwWP6gYK6fQkuDzyRn+5KUsdcpgY30+kZUHJA7rGyr9qa84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765500254; c=relaxed/simple;
	bh=sngKfupCuj2NKI6BFsg4pEtUrOF9h+ulbmZvbj5Z/G0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WaJxDuRoy/TjAJMlr6m6GOepZm2Yuer4EI6qfs4YCPg1LPjxLlP6m9eHmzgmm+g1kjw8SAJGLDVqO07rPHMD7LLRDwTbGOU20YT9wqd25gCq/TLADxbKWkkxf3gHtsBPHx41seETll/bHkucprEzGRJ1K6QANbNlp7MWnLuzUjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XZ5xyrVH; arc=none smtp.client-ip=101.71.155.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XZ5xyrVH"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ceaf0308;
	Fri, 12 Dec 2025 08:28:44 +0800 (GMT+08:00)
Message-ID: <7a24821b-d54e-4463-9274-215c027c9be2@rock-chips.com>
Date: Fri, 12 Dec 2025 08:28:41 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, jh80.chung@samsung.com, ulf.hansson@linaro.org
Subject: Re: [PATCH] mmc: dw_mmc: Add a defensive check to prevent potential
 null-pointer dereferences in dw_mci_runtime_resume()
To: Tuo Li <islituo@gmail.com>
References: <20251211161313.3994317-1-islituo@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251211161313.3994317-1-islituo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b0ff5c74c09cckunmbded2167f39ea
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRpNSVZMSx9KTxhKHR1MHUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XZ5xyrVHFQZ96VXwUrt6PoPep1GSrcM2f3qoVdCx1xW9CVhkvUglDwW9fTPWF7yqnpp6elp38Nt1bxaFSJdp9tXbn0Nf5tKV6VhFS7ekK4hXPY/reHzQzbL43jqKXUY/pNzw+HApebSElKZQ4ZRG4lFWYEWah95WEPsgyBFu8Ls=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=1sGwBwu5F1nw5XMjQFO6kho0tSEuU2FRafWbo1kKGCU=;
	h=date:mime-version:subject:message-id:from;

Hi Tuo,

在 2025/12/12 星期五 0:13, Tuo Li 写道:
> In this function, the variable host->slot is checked and then dereferenced
> in several places which indicates it can be NULL, for example:
> 
>    if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> 		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
> 
> However, in the following cases, host->slot is dereferenced without a
> preceding NULL check, which introduces a risk of null-pointer dereference:
> 
>    dw_mci_setup_bus(host->slot, true);
> 
>    if (sdio_irq_claimed(host->slot->mmc))
>      __dw_mci_enable_sdio_irq(host->slot, 1);
> 
>    dw_mci_enable_cd(host);
> 
> To prevent such issues, add a defensive check to ensure host->slot is not
> NULL before dereferencing it.
> 

Thanks for your patch. we plan to remove the slot design
entirely soon, probably this cycle.

> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>   drivers/mmc/host/dw_mmc.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9e74b675e92d..e74dea0a32d4 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3670,15 +3670,18 @@ int dw_mci_runtime_resume(struct device *dev)
>   	if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
>   		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
>   
> -	/* Force setup bus to guarantee available clock output */
> -	dw_mci_setup_bus(host->slot, true);
>   
> -	/* Re-enable SDIO interrupts. */
> -	if (sdio_irq_claimed(host->slot->mmc))
> -		__dw_mci_enable_sdio_irq(host->slot, 1);
> +	if (host->slot) {
> +		/* Force setup bus to guarantee available clock output */
> +		dw_mci_setup_bus(host->slot, true);
>   
> -	/* Now that slots are all setup, we can enable card detect */
> -	dw_mci_enable_cd(host);
> +		/* Re-enable SDIO interrupts. */
> +		if (sdio_irq_claimed(host->slot->mmc))
> +			__dw_mci_enable_sdio_irq(host->slot, 1);
> +
> +		/* Now that slots are all setup, we can enable card detect */
> +		dw_mci_enable_cd(host);
> +	}
>   
>   	return 0;
>   

