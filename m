Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2B280CFB
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101898; cv=none; b=AMjAe8Wl2r4Dx7iSWttgGrYcjp0YmpmoRZNFwRjYo9w5m51qNd8U/P6VId0h+lRj2G9q+CfNNMGWAR9tDMycC4O65yDxFU00pIRl4d/SGH47Lq2yzjjN92ZI/5Fg7Hauw0ldu/ZoJjXkd8VUdzAsTWE+8OYoFq1CURcbwzQNFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101898; c=relaxed/simple;
	bh=Kl8lRLm9vqLihtKru0h03pGYWOyeGTEVUdW4thdRAzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1lPMSduBHDQJGMfspcgkXwUZ53jX2XQQ4gYMx61e0ld9zD+Upv6laTndYpI9LcAgi0dy0wE1bq5arZj6CUOb0iUGMh4RWdf+TRrv7+HQ8pcwTISdCP89nVlsWvqPSTErk7nw66tsmDkDfc3aq4iJ/VPmnmdlLyd0WTnnCyjBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eRSUm6dV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eRSUm6dV"
Received: from [100.65.225.115] (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id E478220B6F01;
	Mon, 13 Apr 2026 10:38:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E478220B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776101897;
	bh=mP903dU9E33eepcYpUl+fojnP5DkqKJS4SIH6D9VG4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eRSUm6dVxDM8+l8UZbS6bfvl5PP7E8vnXwL/BnbzJu+GC+gVIwbb7jojj9gJc9YcA
	 TbDemA4ZnDah8mZwqG9nUnu8SygKTWbWrjGgqSZedKmpQfnip2XoVpblI1/uJ+EHqk
	 aCJxjR91NYSzdnIe2aXfCcJ0lvYm3ozBEbKOfl30=
Message-ID: <3305684d-8517-47dd-8852-2e34d40fc712@linux.microsoft.com>
Date: Mon, 13 Apr 2026 10:38:15 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mmc: host: sdhci-iproc: implement the .hw_reset
 callback
To: rjui@broadcom.com
Cc: sbranden@broadcom.com, linux-arm-kernel@lists.infradead.org,
 tgopinath@linux.microsoft.com, adrian.hunter@intel.com,
 linux-mmc@vger.kernel.org
References: <20260327222150.2108111-1-meaganlloyd@linux.microsoft.com>
Content-Language: en-US
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
In-Reply-To: <20260327222150.2108111-1-meaganlloyd@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/27/2026 3:21 PM, Meagan Lloyd wrote:
> Implement the .hw_reset callback so that the eMMC can be reset as needed
> given cap-mmc-hw-reset is set in the devicetree and the functionality is
> enabled on the eMMC.
>
> Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
> ---
>
> SDHCI_POWER_CONTROL[4] (SD Host Controller Standard) has been repurposed
> on my Broadcomm processor to be eMMC hardware reset
> (SDIO*_eMMCSDXC_CTRL[12], HRESET).
>
> Can you confirm this repurposed bit is consistent across the Broadcomm
> iProc processors and thus the .hw_reset callback can be uniformly
> applied in this driver?

Hi Ray & Scott,

I hope you're doing well. This bit looks to have been repurposed from
the SD Host Controller Standard's VDD2 Power Control to being used for
toggling the hardware reset signal to eMMCs. Can you verify that it
applies across the iProc processors so that I may finalize this patch?

Thank you,

Meagan

>
> ---
>  drivers/mmc/host/sdhci-iproc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 35ef5c5f51467..9018ed7fe2e66 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -181,12 +181,26 @@ static unsigned int sdhci_iproc_bcm2711_get_min_clock(struct sdhci_host *host)
>  	return 200000;
>  }
>  
> +static void sdhci_iproc_hw_reset(struct sdhci_host *host)
> +{
> +	u8 val = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +
> +	/* Trigger reset and hold for at least 1us (eMMC spec requirement) */
> +	sdhci_writeb(host, val | BIT(4), SDHCI_POWER_CONTROL);
> +	usleep_range(2, 10);
> +
> +	/* Release from reset and wait for at least 200us (eMMC spec requirement) */
> +	sdhci_writeb(host, val & ~BIT(4), SDHCI_POWER_CONTROL);
> +	usleep_range(250, 300);
> +}
> +
>  static const struct sdhci_ops sdhci_iproc_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_max_clock = sdhci_iproc_get_max_clock,
>  	.set_bus_width = sdhci_set_bus_width,
>  	.reset = sdhci_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +	.hw_reset = sdhci_iproc_hw_reset,
>  };
>  
>  static const struct sdhci_ops sdhci_iproc_32only_ops = {
> @@ -201,6 +215,7 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
>  	.set_bus_width = sdhci_set_bus_width,
>  	.reset = sdhci_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +	.hw_reset = sdhci_iproc_hw_reset,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
> @@ -283,6 +298,7 @@ static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
>  	.set_bus_width = sdhci_set_bus_width,
>  	.reset = sdhci_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +	.hw_reset = sdhci_iproc_hw_reset,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
