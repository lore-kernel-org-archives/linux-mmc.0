Received: from mail-m19731119.qiye.163.com (mail-m19731119.qiye.163.com [220.197.31.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD81A5B9E
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847114; cv=none; b=fLB9S+tZEQggACx4U5vdwDOG0gGh3zs8xgH0NjEzzbDlWvT5dkUxGq881x1SUR0sOj6iWIDM+vmNAOq/ETAbwKS9U8Hsyjd7g29p7WlnISSWCGNNcoUkvWsmfe9djV3Ci2sYHbfLAWXvEAs1ZKSiyTOEcegeM6txmQxafWIW1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847114; c=relaxed/simple;
	bh=EAIoKTvxx16h+G/5Cae33mWUGONrp30iAXrcfteopzw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GA/sxjXN23EmhGbv7LooHgW5bI5rgoHWyascjwgxVeX8kJro88FVXrOuRpkBP/8NKRrr+il9qc5fL/fe+7a5GdEErij9Dn7eVAQMlIRjuRWuUgmbaYgnuG3QK2L6uKPT/ZrSSAKDVseI3/GxIVZHRX+/RCHrzZYh5HgPi/Caq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=X1arh2Pt; arc=none smtp.client-ip=220.197.31.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="X1arh2Pt"
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 292970781;
	Tue, 11 Nov 2025 15:39:52 +0800 (GMT+08:00)
Message-ID: <b749faf3-b197-4b78-a918-501a639a8f4d@rock-chips.com>
Date: Tue, 11 Nov 2025 15:39:51 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: Enable enhanced strobe for eMMC
 in HS400 for Rockchip
To: Anand Moon <linux.amoon@gmail.com>
References: <20251111072158.6686-1-linux.amoon@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251111072158.6686-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a71db5ac809cckunmad33e4f814c0d7d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkIdGlZDHkkZSU1LGkgdSB1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=X1arh2PtWFtUWPkCs5nRPPy096og/l3ytvh2PqT066btuIjc4nY07r8sYxTNi+oQdBal2r7wuC1BMtxBX8/PAS5H1Uwe79EFihbghg7zfWZUBvi4e76RaR/TMFXBfZzUefrpnf4QYvZn/1IfNnyOnu+lwJx+WtsBaJDcAyPqG2Q=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=eAvPIXmuyHRWilT05E4lpfPZgfBqMrfMSg3qyySGLpw=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/11 星期二 15:21, Anand Moon 写道:
> As per RK3588 TRM Part 2 section EMMC_EMMC_CTRL, Add code to enable
> enhanced strobe mode, set the card type to eMMC in HS400 during clock
> configuration. This bit instructs Host to sample the CMD line using data
> strobe for HS400 mode.
> 

Did you really test the latest kernel?
HS400ES for Rockchip platform has been supported for 3 years..

please see commit c6f361cba51c536e7a6af31973c6a4e5d7e4e2e4

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   drivers/mmc/host/sdhci-of-dwcmshc.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index eebd453899566..3edde4532b13c 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -77,6 +77,10 @@
>   #define CV18XX_RETRY_TUNING_MAX			50
>   
>   /* Rockchip specific Registers */
> +#define DWCMSHC_EMMC_CTRL		0x52c
> +#define  EMMC_CTRL_CARD_IS_EMMC		BIT(0)
> +#define  EMMC_CTRL_ENH_STROBE_ENABLE	BIT(8)
> +
>   #define DWCMSHC_EMMC_DLL_CTRL		0x800
>   #define DWCMSHC_EMMC_DLL_RXCLK		0x804
>   #define DWCMSHC_EMMC_DLL_TXCLK		0x808
> @@ -660,6 +664,14 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>   			DLL_CMDOUT_TAPNUM_90_DEGREES |
>   			DLL_CMDOUT_TAPNUM_FROM_SW;
>   		sdhci_writel(host, extra, DECMSHC_EMMC_DLL_CMDOUT);
> +
> +		extra = sdhci_readl(host, DWCMSHC_EMMC_CTRL);
> +		if (extra & EMMC_CTRL_CARD_IS_EMMC) {
> +			extra |= EMMC_CTRL_ENH_STROBE_ENABLE;
> +			sdhci_writel(host, extra, DWCMSHC_EMMC_CTRL);
> +		} else {
> +			dev_info(mmc_dev(host->mmc), "strobe mode not enabled!\n");
> +		}
>   	}
>   
>   	extra = DWCMSHC_EMMC_DLL_DLYENA |
> 
> base-commit: 4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8

