Received: from mail-m3296.qiye.163.com (mail-m3296.qiye.163.com [220.197.32.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC4284B3B;
	Fri,  9 Jan 2026 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767942210; cv=none; b=spgXDsx0UdmcSvJazbon0ctf2KlCCVxQv1HrPD4ax5pugCrpXTpcc0SPNUt2oKZXr+9JUJHm0dP9S/v0YGg4XbHlLYb33qhycNNLSSvh35SuzhVtyg7+r8zuPuPeMVhcLdIwFTuOfGOEKeKnBL8HimvovtTZXk9wmzy0XmqCpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767942210; c=relaxed/simple;
	bh=/31omN2S+q6t42XwDyYBLscq7D9giyPlOI8o8YUlZp8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XGNN3iYfh6kcz7KSrT0GyFK8rbq1TgqmIKxrZ1w2m2RQJSawwoC3MuePksJPMiDh147UJyiVeFrIR0Oy+dt3PquTxwy78fCEYX8OiQEjvaF+1Cpcb+oEX+LQyuv4u/hjKPRIDRtjVZnVYMkXwAaVYWb//ZH+EZ5PHuI1R96gpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=M+Gudacv; arc=none smtp.client-ip=220.197.32.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="M+Gudacv"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 300e72906;
	Fri, 9 Jan 2026 15:03:16 +0800 (GMT+08:00)
Message-ID: <0bd26d36-04da-4139-84fd-d62a5cb3f6a0@rock-chips.com>
Date: Fri, 9 Jan 2026 15:03:15 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, ningyu@eswincomputing.com,
 linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
 xuxiang@eswincomputing.com, adrian.hunter@intel.com,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org
Subject: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: fix init for AXI clock and DMA
 128MB boundary
To: hehuan1@eswincomputing.com
References: <20260109032810.204-1-hehuan1@eswincomputing.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260109032810.204-1-hehuan1@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ba1910bfc09cckunm23c17c67a957f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MdS1ZOGR1OT0wdGhhIHRlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=M+GudacvrBKXvDmjE8cbkIWQhnSWzsbLWDOrhpensbTApTjrrzmQbq54gHZfK68ExVSlDowZSUD3FUebv04cQpPEboqPuvpFCcOgfabCIltW8IRCMDZXDab8RWjeXmGIwAGNKlCAgDkXqqHqMTwswqti08x2/fW75sZQAU95rag=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=QspKio3/KHmxsKC7/jUm0yN9+Bx1zsaBKI07SSGP80Q=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/09 星期五 11:28, hehuan1@eswincomputing.com 写道:
> From: Huan He <hehuan1@eswincomputing.com>
> 
> 1.Accessing the High-Speed registers requires the AXI clock to be enabled.
> 2.This DWC MSHC has a 128MB limitation where the data buffer size and
>    start address must not exceed the 128MB boundary. Registering the
>    missing 'adma_write_desc' callback function.
> 

This looks like you should split it into two patches with
proper Fixes tags.

> Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> ---
>   drivers/mmc/host/sdhci-of-dwcmshc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 51949cde0958..147f8046707f 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -1588,6 +1588,7 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
>   {
>   	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>   	unsigned int val, hsp_int_status, hsp_pwr_ctrl;
> +	static const char * const clk_ids[] = {"axi"};
>   	struct of_phandle_args args;
>   	struct eic7700_priv *priv;
>   	struct regmap *hsp_regmap;
> @@ -1605,6 +1606,11 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
>   		return ret;
>   	}
>   
> +	ret = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
> +					    ARRAY_SIZE(clk_ids), clk_ids);
> +	if (ret)
> +		return ret;
> +
>   	ret = of_parse_phandle_with_fixed_args(dev->of_node, "eswin,hsp-sp-csr", 2, 0, &args);
>   	if (ret) {
>   		dev_err(dev, "Fail to parse 'eswin,hsp-sp-csr' phandle (%d)\n", ret);
> @@ -1726,6 +1732,7 @@ static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
>   	.set_uhs_signaling = sdhci_eic7700_set_uhs_wrapper,
>   	.set_power = sdhci_set_power_and_bus_voltage,
>   	.irq = dwcmshc_cqe_irq_handler,
> +	.adma_write_desc = dwcmshc_adma_write_desc,
>   	.platform_execute_tuning = sdhci_eic7700_executing_tuning,
>   };
>   

