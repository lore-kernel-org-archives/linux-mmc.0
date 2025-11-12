Received: from mail-m32105.qiye.163.com (mail-m32105.qiye.163.com [220.197.32.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1432A277C9E;
	Wed, 12 Nov 2025 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931227; cv=none; b=FnpanfH3hgOhs17kchjHNFN74zbQRNEr4SR0ZjIBCCZQZR7Qnc99qh8/4hEtqLGONbKcUBceYgMS5uB+IzwEZfbjzgCfTlo6xdpFGa+al18n3GP5d3yx689+k//tjAZBGjqDT6xwCsh/AV0eHinuLd12iz7x5+lphH1ZlrYvJro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931227; c=relaxed/simple;
	bh=vXoYnW5kAEQsgEAjDCcNMhuW4BTR4GRhq6/CSa+bmLo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NF576JQ/9xZ75gC3SpnJTg2h5CcgyQ7RfvbeOFvCQLEJIo9LjKRdteBjOZiyBXpyzey9M2DwV6Ign00tSysLiRwQ5nUvf7scSlOEkP7Nknl0GfxNdAALHL+tDTeppIKsl1XSKSDfu1+V1/4QIaEEu5lLPXxNMZKeRUCBQaoI1nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FLextWC9; arc=none smtp.client-ip=220.197.32.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FLextWC9"
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 294c7eb70;
	Wed, 12 Nov 2025 15:01:44 +0800 (GMT+08:00)
Message-ID: <25d5ba5f-3f07-411a-a4d2-ae4a06a44a94@rock-chips.com>
Date: Wed, 12 Nov 2025 15:01:43 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Promote the th1520 reset handling
 to ip level
To: Jisheng Zhang <jszhang@kernel.org>
References: <20251112001426.17252-1-jszhang@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251112001426.17252-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a76decbbf09cckunm30210e6f117fe9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ08dGFZNH08ZGhpKHk9PTB5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FLextWC9JwMGkpISGFRL31MoCLj3+XrjG4T8P956+1r1ClJrlQe/Jld8zTNEzW5rqToWA4twyBugFRVTGFdvaB29f1wZOTKP/rm9yFGtr2kV89+bPO1lL20UrnCN9DdH/A8DvzpKmxA+G+OeOgWTEye6QuaT1mF4c/vB6FBbmGg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=gFNeZqI2Arrt6qqSwpmNv/ta0t/y5WTDn+owTa8wy6w=;
	h=date:mime-version:subject:message-id:from;

Hi Jisheng,

在 2025/11/12 星期三 8:14, Jisheng Zhang 写道:
> Commit 27e8fe0da3b7 ("mmc: sdhci-of-dwcmshc: Prevent stale command
> interrupt handling") clears pending interrupts when resetting
> host->pending_reset to ensure no pending stale interrupts after
> sdhci_threaded_irq restores interrupts. But this fix is only added for
> th1520 platforms, in fact per my test, this issue exists on all
> dwcmshc users, such as cv1800b, sg2002, and synaptics platforms.
> 
> So promote the above reset handling from th1520 to ip level.
 > > Fixes: 017199c2849c ("mmc: sdhci-of-dwcmshc: Add support for Sophgo 
CV1800B and SG2002")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/mmc/host/sdhci-of-dwcmshc.c | 35 ++++++++++++++++-------------
>   1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index eebd45389956..c17168edc9fd 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -289,6 +289,19 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
>   	sdhci_adma_write_desc(host, desc, addr, len, cmd);
>   }
>   
> +static void dwcmshc_reset(struct sdhci_host *host, u8 mask)
> +{
> +	sdhci_reset(host, mask);
> +
> +	/* The dwcmshc does not comply with the SDHCI specification
> +	 * regarding the "Software Reset for CMD line should clear 'Command
> +	 * Complete' in the Normal Interrupt Status Register." Clear the bit
> +	 * here to compensate for this quirk.
> +	 */
> +	if (mask & SDHCI_RESET_CMD)
> +		sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
> +}
> +
>   static unsigned int dwcmshc_get_max_clock(struct sdhci_host *host)
>   {
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -686,7 +699,7 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>   		reset_control_deassert(priv->reset);
>   	}
>   
> -	sdhci_reset(host, mask);
> +	dwcmshc_reset(host, mask);

Thanks for the patch. However, I'm afraid it's overkill for the IP used
by Rockchip at least. From the databook v1.70a released by synopsys, it
clearly says:

"The following registers and bits are cleared by this bit:
- Present State register - Command Inhibit (CMD) bit
- Normal Interrupt Status register - Command Complete bit
- Error Interrupt Status - Response error statuses related
to Command Inhibit (CMD) bit "

To be more rigorous, I askeed my IC team performed a simulation this
morning. The results confirmed that the IP's behavior complies with the 
description in the databook.

Is this a problem with an early version of the dwc IP? If so, I think it
should cc all users of this driver to have a check if making it a IP
level change.

>   }
>   
>   static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
> @@ -832,15 +845,7 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
>   	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>   	u16 ctrl_2;
>   
> -	sdhci_reset(host, mask);
> -
> -	/* The T-Head 1520 SoC does not comply with the SDHCI specification
> -	 * regarding the "Software Reset for CMD line should clear 'Command
> -	 * Complete' in the Normal Interrupt Status Register." Clear the bit
> -	 * here to compensate for this quirk.
> -	 */
> -	if (mask & SDHCI_RESET_CMD)
> -		sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
> +	dwcmshc_reset(host, mask);
>   
>   	if (priv->flags & FLAG_IO_FIXED_1V8) {
>   		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> @@ -886,7 +891,7 @@ static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>   	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>   	u32 val, emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>   
> -	sdhci_reset(host, mask);
> +	dwcmshc_reset(host, mask);
>   
>   	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
>   		val = sdhci_readl(host, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
> @@ -958,7 +963,7 @@ static void cv18xx_sdhci_post_tuning(struct sdhci_host *host)
>   	val |= SDHCI_INT_DATA_AVAIL;
>   	sdhci_writel(host, val, SDHCI_INT_STATUS);
>   
> -	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +	dwcmshc_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>   }
>   
>   static int cv18xx_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> @@ -1080,7 +1085,7 @@ static inline void sg2042_sdhci_phy_init(struct sdhci_host *host)
>   
>   static void sg2042_sdhci_reset(struct sdhci_host *host, u8 mask)
>   {
> -	sdhci_reset(host, mask);
> +	dwcmshc_reset(host, mask);
>   
>   	if (mask & SDHCI_RESET_ALL)
>   		sg2042_sdhci_phy_init(host);
> @@ -1100,7 +1105,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>   	.set_bus_width		= sdhci_set_bus_width,
>   	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
>   	.get_max_clock		= dwcmshc_get_max_clock,
> -	.reset			= sdhci_reset,
> +	.reset			= dwcmshc_reset,
>   	.adma_write_desc	= dwcmshc_adma_write_desc,
>   	.irq			= dwcmshc_cqe_irq_handler,
>   };
> @@ -1121,7 +1126,7 @@ static const struct sdhci_ops sdhci_dwcmshc_bf3_ops = {
>   	.set_bus_width		= sdhci_set_bus_width,
>   	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
>   	.get_max_clock		= dwcmshc_get_max_clock,
> -	.reset			= sdhci_reset,
> +	.reset			= dwcmshc_reset,
>   	.adma_write_desc	= dwcmshc_adma_write_desc,
>   	.irq			= dwcmshc_cqe_irq_handler,
>   	.hw_reset		= dwcmshc_bf3_hw_reset,

