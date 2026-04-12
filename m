Received: from mail-m32117.qiye.163.com (mail-m32117.qiye.163.com [220.197.32.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D843264CA;
	Sun, 12 Apr 2026 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775994705; cv=none; b=eiZtJEdKV0+NPrjAYh6uERNVvTh4YmKZp3ad9UUbYE4YjPw3ZQKGf+1BDdZlJXCnNTnak0bOtPSfE1bXpY/GzzqxTfsm9r/d+iJxWVs7N0y1eXu4zQNOQxLkN1ZpJxByBs1tdgLy9SlHVxmFMV1arC23igmZBbZN9a3M2JWbGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775994705; c=relaxed/simple;
	bh=bbNNDxywwudPYLTI00IG7ejPCt7R5ePvNWXHZdSoULY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PjAuc0U7+3XZHbax0lPjsjFm7xMQaFzbSQomgtGKYNG09oPDS+GWwt07VptO/cvbe2ExOft8xRaAXFMzfdaDW7oWs4VhfF6VG5hQDLl8QBEPetxHTdrtC/lUFkFApZhlNbEzKHyWBtC+vsKdzhYgSgpEmBauvtbkDBYTTZcbH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jwXqD5B8; arc=none smtp.client-ip=220.197.32.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jwXqD5B8"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a65754ba;
	Sun, 12 Apr 2026 19:16:02 +0800 (GMT+08:00)
Message-ID: <c5b299e2-63e1-fd06-6688-6403d6c513e2@rock-chips.com>
Date: Sun, 12 Apr 2026 19:15:55 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: dw_mmc: implement option for configuring DMA
 threshold
To: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
References: <20260412-dwmmc-dma-thr-v1-0-75a2f658eee3@disroot.org>
 <20260412-dwmmc-dma-thr-v1-2-75a2f658eee3@disroot.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260412-dwmmc-dma-thr-v1-2-75a2f658eee3@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d8167e22c09cckunm2beba7a66dbc77
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01LHlZMSUpNGk1LH08YTBhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jwXqD5B8pGZJlEBERB3ADy6afbsSzyqI+RpFSyX90n17LafdxMVm53qtVk2/iP2ZA6RyhGAILonqSUpi/4qQqlGT0AYS1S7tWfmqm9Vy+N07nBMeHnrpYzaWB2+L8YaCpky973O7cAR0aVxtMyFa3r9yJu4TyL3Zw8UiyjG+/KI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=RJ9td/PsGU8X4Vc5N0lfmNUCEHzbnQRcQ44jdnBQanA=;
	h=date:mime-version:subject:message-id:from;

Hi Kaustabh

在 2026/04/12 星期日 3:43, Kaustabh Chakraborty 写道:
> Some controllers, such as certain Exynos SDIO ones, are unable to
> perform DMA transfers of small amount of bytes properly. Following the
> device tree schema, implement the property to define the DMA transfer
> threshold (from a hard coded value of 16 bytes) so that lesser number of
> bytes can be transferred safely skipping DMA in such controllers. The
> value of 16 bytes stays as the default for controllers which do not
> define it.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>   drivers/mmc/host/dw_mmc.c | 6 ++++--
>   drivers/mmc/host/dw_mmc.h | 1 +
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 20193ee7b73eb..0c0d269b5e033 100644
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
> @@ -3137,6 +3136,9 @@ static int dw_mci_parse_dt(struct dw_mci *host)
>   	if (!host->data_addr_override)
>   		device_property_read_u32(dev, "data-addr", &host->data_addr_override);
>   
> +	if (device_property_read_u32(dev, "dma-threshold-bytes", &host->dma_threshold) < 0)
> +		host->dma_threshold = 16;
> +
>   	if (device_property_present(dev, "fifo-watermark-aligned"))
>   		host->wm_aligned = true;
>   
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 42e58be74ce09..5cdd342d01b68 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -163,6 +163,7 @@ struct dw_mci {
>   	void __iomem		*regs;
>   	void __iomem		*fifo_reg;
>   	u32			data_addr_override;
> +	u32			dma_threshold;

In addition to fixing the issue mentioned in patch 1, please add a 
comment for this new member.

>   	bool			wm_aligned;
>   
>   	struct scatterlist	*sg;
> 
