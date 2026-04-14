Received: from mail-m15566.qiye.163.com (mail-m15566.qiye.163.com [101.71.155.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E382237713;
	Tue, 14 Apr 2026 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157569; cv=none; b=tTu6rrPeBY/DKwUEWtq6zOR3d2122ro7JtLE9QXg0DNmlvlYKKwMG3vnLbQcqT6iOgsIKnfQSH8cJ1cGV+25d4CmZsP6p8D1UB7xOhaHVrX715iojbadV5bh2zYb3X5yRBkTN9Uv/2SnaLL7KMNFZL5hjKOgJGYTnzgo4Lzf/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157569; c=relaxed/simple;
	bh=hh7Q5tTGk1U4KuBhZyXECSx/y/AhCeYvTGVPDj0og14=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=orMXLoFPuIsisvCO7AtyqO9/y7UWj6SSKVPeU7ZvD4XLtMBEIAspok7DlsiBttXE2agCTR45+f28TO9ZrMTX9X4MAJjAAQg0ZaDIxuXydwR5o/m5+6MaLB591Q87h3XqJJ27vU8PAwZ9TwGg9Y2ypmqV2KAYzPh4kbPEavg8WFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DnfYRACS; arc=none smtp.client-ip=101.71.155.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DnfYRACS"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3aaac6a97;
	Tue, 14 Apr 2026 16:50:41 +0800 (GMT+08:00)
Message-ID: <cec99f99-5ac4-7f0d-8e2a-947edfef8930@rock-chips.com>
Date: Tue, 14 Apr 2026 16:50:28 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mmc: dw_mmc: implement option for configuring DMA
 threshold
To: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
References: <20260414-dwmmc-dma-thr-v2-0-4058078f5361@disroot.org>
 <20260414-dwmmc-dma-thr-v2-1-4058078f5361@disroot.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260414-dwmmc-dma-thr-v2-1-4058078f5361@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d8b2f889c09cckunmdcb2a6d389aa93
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5KTFZPGR9IGkhPTENNGhhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DnfYRACSDZpJK0lRuJ8/WtbnW7oXUzViIm/tnTTDD7BEWELh5zkgF2TQmLVECg4cXDzZqHyTu9CiyYsWf+Gmmk8DWKUU8NN5FE4pWHtyT32pHvbvK3sai0iqRsnGm0LeLjlzDiw4x84Ay2xKD0tAXZhJP9bvO22ApCB9Aqh23B8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=fR/8RZWrpTM8A7/i1nFhInIAo0qgMM9hFmLDHafoS1Q=;
	h=date:mime-version:subject:message-id:from;

在 2026/04/14 星期二 16:36, Kaustabh Chakraborty 写道:
> Some controllers, such as certain Exynos SDIO ones, are unable to
> perform DMA transfers of small amount of bytes properly. Following the
> device tree schema, implement the property to define the DMA transfer
> threshold (from a hard coded value of 16 bytes) so that lesser number of
> bytes can be transferred safely skipping DMA in such controllers. The
> value of 16 bytes stays as the default for controllers which do not
> define it. This value can be overridden by implementation-specific init
> sequences.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>   drivers/mmc/host/dw_mmc.c | 5 +++--
>   drivers/mmc/host/dw_mmc.h | 2 ++
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 20193ee7b73eb..9dd9fed4ccf49 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -40,7 +40,6 @@
>   				 SDMMC_INT_RESP_ERR | SDMMC_INT_HLE)
>   #define DW_MCI_ERROR_FLAGS	(DW_MCI_DATA_ERROR_FLAGS | \
>   				 DW_MCI_CMD_ERROR_FLAGS)
> -#define DW_MCI_DMA_THRESHOLD	16
>   
>   #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
>   #define DW_MCI_FREQ_MIN	100000		/* unit: HZ */
> @@ -821,7 +820,7 @@ static int dw_mci_pre_dma_transfer(struct dw_mci *host,
>   	 * non-word-aligned buffers or lengths. Also, we don't bother
>   	 * with all the DMA setup overhead for short transfers.
>   	 */
> -	if (data->blocks * data->blksz < DW_MCI_DMA_THRESHOLD)
> +	if (data->blocks * data->blksz < host->dma_threshold)
>   		return -EINVAL;
>   
>   	if (data->blksz & 3)
> @@ -3245,6 +3244,8 @@ int dw_mci_probe(struct dw_mci *host)
>   		goto err_clk_ciu;
>   	}
>   
> +	host->dma_threshold = 16;

I'd prefer to set it in dw_mci_alloc_host() instead of picking up
a random place to put it, for better code management.

> +
>   	if (host->rstc) {
>   		reset_control_assert(host->rstc);
>   		usleep_range(10, 50);
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 42e58be74ce09..fc7601fba849f 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -164,6 +164,8 @@ struct dw_mci {
>   	void __iomem		*fifo_reg;
>   	u32			data_addr_override;
>   	bool			wm_aligned;
> +	/* Configurable data byte threshold value for DMA transfer. */

No here, there is a long section of comment before struct dw_mci{ } that
describes each member of it, please add it there.

> +	u32			dma_threshold;
>   
>   	struct scatterlist	*sg;
>   	struct sg_mapping_iter	sg_miter;
> 
