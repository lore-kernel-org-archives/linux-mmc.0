Received: from mail-m1973172.qiye.163.com (mail-m1973172.qiye.163.com [220.197.31.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D752288D5;
	Thu, 16 Apr 2026 01:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776303798; cv=none; b=liAiLWSpAgBl38n1RJi+Ud71IkI7kILDxsliv/LXfFm6OfDq6tVFhgZMNg/YvDU1QCcstMwqs6M2WOyrDkWD15EAtIMz1eZCI+w38RpjMgZvyoFGZmrlpZW/B64IdAiK/Owga/Xijcb8vK1krDaoULWsEl5dPEp5DwMV9cd+vOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776303798; c=relaxed/simple;
	bh=koVhQPofFJ0xf0B5h25d5ZrJpSfHdrZyeW8TD62LtVQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VBKaiP+0bPfoDIi/jwZMWOVE2nlRo9JtE15OrHbWltyCttTqr2sp/hLEy0lMUw7Qzgr+epvO81k1x7m54kexFirUq/DV3kdoPhY3VfjR3rKUqKNmmLiBDXTqYyDf4RsHC+NqIrllFxTV+cF64ZH8ImtXzE9pyfF8ci4zvK9VhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QLVWHamE; arc=none smtp.client-ip=220.197.31.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QLVWHamE"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3ae6eaf4f;
	Thu, 16 Apr 2026 08:27:29 +0800 (GMT+08:00)
Message-ID: <5243585c-2fcf-dc68-54e9-cd8afc74fb5d@rock-chips.com>
Date: Thu, 16 Apr 2026 08:27:27 +0800
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
Subject: Re: [PATCH v3 1/2] mmc: dw_mmc: implement option for configuring DMA
 threshold
To: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
References: <20260415-dwmmc-dma-thr-v3-0-31014d36b6ee@disroot.org>
 <20260415-dwmmc-dma-thr-v3-1-31014d36b6ee@disroot.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260415-dwmmc-dma-thr-v3-1-31014d36b6ee@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d93af8e1e09cckunmbbec6de61a99b1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk1DGlZKGRgeShgaTBgfQ0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QLVWHamEtWPXbOyxhHmQ1CXl+jZhKt7agdGVtiD3HhXO7faGFVEG8aNlFWSU+wKYkw3bwvLTyBCJKwBwOTisumx3PDWl3M+xF2p7rG1YWHSE8MDYPWI7uzHrlVvXHVfX1pzRJ19JFUlqEU/f1XLcmv+2iaI4nBHV5pXdZi0X8XE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=nKA5dmo91yCLapXpWOigMm3bpFe+GNmIfRh+PO4vxzk=;
	h=date:mime-version:subject:message-id:from;


在 2026/04/15 星期三 23:02, Kaustabh Chakraborty 写道:
> Some controllers, such as certain Exynos SDIO ones, are unable to
> perform DMA transfers of small amount of bytes properly. Following the
> device tree schema, implement the property to define the DMA transfer
> threshold (from a hard coded value of 16 bytes) so that lesser number of
> bytes can be transferred safely skipping DMA in such controllers. The
> value of 16 bytes stays as the default for controllers which do not
> define it. This value can be overridden by implementation-specific init
> sequences.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>   drivers/mmc/host/dw_mmc.c | 4 ++--
>   drivers/mmc/host/dw_mmc.h | 2 ++
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 20193ee7b73eb..3b4157f34d11f 100644
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
> @@ -3185,6 +3184,7 @@ struct dw_mci *dw_mci_alloc_host(struct device *dev)
>   	host = mmc_priv(mmc);
>   	host->mmc = mmc;
>   	host->dev = dev;
> +	host->dma_threshold = 16;
>   
>   	return host;
>   }
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 42e58be74ce09..f29d40158dc59 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -107,6 +107,7 @@ struct dw_mci_dma_slave {
>    * @ciu_clk: Pointer to card interface unit clock instance.
>    * @fifo_depth: depth of FIFO.
>    * @data_addr_override: override fifo reg offset with this value.
> + * @dma_threshold: data threshold value in bytes to carry out a DMA transfer.
>    * @wm_aligned: force fifo watermark equal with data length in PIO mode.
>    *	Set as true if alignment is needed.
>    * @data_shift: log2 of FIFO item size.
> @@ -163,6 +164,7 @@ struct dw_mci {
>   	void __iomem		*regs;
>   	void __iomem		*fifo_reg;
>   	u32			data_addr_override;
> +	u32			dma_threshold;
>   	bool			wm_aligned;
>   
>   	struct scatterlist	*sg;
> 
