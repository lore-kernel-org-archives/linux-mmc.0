Received: from mail-m49204.qiye.163.com (mail-m49204.qiye.163.com [45.254.49.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A6275AE8
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764079132; cv=none; b=uL/Fv8GIZNHzUfeFpq1Od0Vo1ykU7MLPnNPWz3+4omBc8D5HD8N5I9njsk6LzwBJmawWa06IYkUhoUMldZcO3kGgwmFLAtKpx72ffVFlOScb4Wwgv4N5ZVIAnRx/e6xn/w6et4zgpeV/wUgXD5LKV8VvksmA/BDYPvl2gYdME5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764079132; c=relaxed/simple;
	bh=6T2go/mS21Pe9pt3BKQiYU0vB54ckuIh5mJckIdFa+w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p2/sTXHIPfmUcJDrslhs7EQ4OAT3RiTUU3JZk2i+Ae8lqs6w/FRzSC36DOgs6NLuEmMsbS2jiIaI6TmfszAAk30ZpZlRkp5Q54Ju2wq8aI7qOBbCzvd1yc+eExqHXEOr1EdtvDuN/oWA6cpYLne4rstEqo19m/nlyiIngtAa0D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hj7c5wSt; arc=none smtp.client-ip=45.254.49.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hj7c5wSt"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ad997f34;
	Tue, 25 Nov 2025 21:58:38 +0800 (GMT+08:00)
Message-ID: <7b05327d-fc76-471e-9148-3dfc0cd17623@rock-chips.com>
Date: Tue, 25 Nov 2025 21:58:36 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
 linux-mmc@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-dwcmshc: reduce CIT for better
 performance
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1762933460-204066-1-git-send-email-shawn.lin@rock-chips.com>
 <1762933460-204066-2-git-send-email-shawn.lin@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <1762933460-204066-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9abb4f27ad09cckunm12df2b434ad7a2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhLTlYdGR1OSExCH04aQk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hj7c5wStwSHEN1rnNOXYYhScbWfiEoaeglZx+TqNXPEQJbRkt5an2hv6FIgrrXYAJLcW7autTRrsU87x+iIxjU9W9ppxglv4ApDwNem3EHcvAswmDoxtBJI827CaGs2Vkv9kPgK6i9RJXaEH9T6kcLf/j759vmA95fp0X+rBO+Q=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=JJ6TIdpKrVgfuKBVFMvJrAS7fl67i9hCloV/D5SATc0=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/12 星期三 15:44, Shawn Lin 写道:
> CQHCI_SSC1.CIT indicates to the CQE the polling period to use for
> periodic SEND_QUEUE_STATUS (CMD13) polling. Some eMMCs have only one
> hardware queue, and CMD13 can only query one slot at a time for data
> transmission, which cannot be processed in parallel. Modifying the
> CMD13 query interval can increase the query frequency and improve
> random write performance.
> 

Ping...

Adrain acked these two patches, so will them be candidates for 6.19
given the merge windows is coming soon?

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>   drivers/mmc/host/cqhci.h            | 1 +
>   drivers/mmc/host/sdhci-of-dwcmshc.c | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index ce189a1..3668856 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -93,6 +93,7 @@
>   /* send status config 1 */
>   #define CQHCI_SSC1			0x40
>   #define CQHCI_SSC1_CBC_MASK		GENMASK(19, 16)
> +#define CQHCI_SSC1_CIT_MASK		GENMASK(15, 0)
>   
>   /* send status config 2 */
>   #define CQHCI_SSC2			0x44
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e276a4e..cad5165 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -631,6 +631,11 @@ static void rk35xx_sdhci_cqe_pre_enable(struct mmc_host *mmc)
>   	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>   	u32 reg;
>   
> +	/* Set Send Status Command Idle Timer to 10.66us (256 * 1 / 24) */
> +	reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_SSC1);
> +	reg = (reg & ~CQHCI_SSC1_CIT_MASK) | 0x0100;
> +	sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_SSC1);
> +
>   	reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
>   	reg |= CQHCI_ENABLE;
>   	sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_CFG);

