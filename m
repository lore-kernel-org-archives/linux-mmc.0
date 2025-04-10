Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F138202F71;
	Thu, 10 Apr 2025 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295890; cv=none; b=rzEmG0xp4dtRIXg1eKtQ7UHPg3irH18iEGj5wlhIKiYjFagghDTA+pBvhwy78lUMraLFKdHFVDKtUt0Stuwv7OKDh2bjMO/uD8397ctUWB1I5v5Y/kLMGyqrquZR6MkIIyXFTgXKWvpvadCvGIou2Kh81tCqBM9dcVQSNzJnNFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295890; c=relaxed/simple;
	bh=YIlYBspB5X+XSsa4+3taaxhNn00GpJC566S6ta2+o6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFlkknGs6hRwIYUNUXqHreyb5EY4OucQ5qKe1nQFrdQeCgzYumH/27sAci2vvy7bu3AqT+5wrhS/6Nlb97JlcAy43/V8ftIxgjVNC+t7VVtToYryNnw1Q0VBt1xqCgvuebBsGR5v/S2asBhSzxFXMRzM/FB7eLAveAa7JIGG4BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z4nj2Sp8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z4nj2Sp8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744295884;
	bh=YIlYBspB5X+XSsa4+3taaxhNn00GpJC566S6ta2+o6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z4nj2Sp8Tf9VIOV5k2nhD7NoAInQRKFJD+8YdNvg6jTh/3j8kLnWQU04ynl8hDRyr
	 gbTqLMoGfErFpSUnnVc6i7n1C3eQZn16X4OhICBZdT4Fj8VUQ2fbbtpry9Ou3gccyf
	 ao4qtKRRpgXp7ISs/+VkfudlB8pn4onEKm5OC8wAEXWxoelDzA+abhAX8uFdgRTpFb
	 CU+JNHU0SFW2K457DDauJENLNg/udLbLCAnRyG08pdLN99/pNbaw5mngPtdvX9w9Rs
	 FfY+70JYDEK72dlFbuUzFY9I7Tk6g+pPQpyIRbikveDOMZyTvcuh9Z3zqpEzyNiB7U
	 x95FUNMGqnlWA==
Received: from [192.168.33.15] (fi-19-199-243.service.infuturo.it [151.19.199.243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6819517E078A;
	Thu, 10 Apr 2025 16:38:02 +0200 (CEST)
Message-ID: <d725bafb-8cd9-4f40-b708-2760776bda72@collabora.com>
Date: Thu, 10 Apr 2025 16:38:00 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: mtk-sd: Add condition to enable 'single' burst
 type
To: Axe Yang <axe.yang@mediatek.com>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, yong.mao@mediatek.com,
 qingliang.li@mediatek.com, andy-ld.lu@mediatek.com,
 Wenbin Mei <wenbin.mei@mediatek.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250410075314.6439-1-axe.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250410075314.6439-1-axe.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/04/25 09:52, Axe Yang ha scritto:
> This change add a condition for 'single' burst type selection.
> 
> Read AXI_LEN field from EMMC50_CFG2(AHB2AXI wrapper) register, if the
> value is not 0, it means the HWIP is using AXI as AMBA bus, which do
> not support 'single' burst type.
> 

You're missing a Suggested-by tag :-)

After adding it,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
> This change dependents on 'mmc: mtk-sd: Cleanups for register R/W':
> 
> https://patchwork.kernel.org/project/linux-mediatek/cover/20250325110701.52623-1-angelogioacchino.delregno@collabora.com/
> ---
>   drivers/mmc/host/mtk-sd.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index ceeae1aeac94..2e4bd5166c17 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -84,6 +84,7 @@
>   #define EMMC51_CFG0	 0x204
>   #define EMMC50_CFG0      0x208
>   #define EMMC50_CFG1      0x20c
> +#define EMMC50_CFG2      0x21c
>   #define EMMC50_CFG3      0x220
>   #define SDC_FIFO_CFG     0x228
>   #define CQHCI_SETTING	 0x7fc
> @@ -306,7 +307,10 @@
>   /* EMMC50_CFG1 mask */
>   #define EMMC50_CFG1_DS_CFG        BIT(28)  /* RW */
>   
> -#define EMMC50_CFG3_OUTS_WR       GENMASK(4, 0)  /* RW */
> +/* EMMC50_CFG2 mask */
> +#define EMMC50_CFG2_AXI_SET_LEN   GENMASK(27, 24) /* RW */
> +
> +#define EMMC50_CFG3_OUTS_WR       GENMASK(4, 0)   /* RW */
>   
>   #define SDC_FIFO_CFG_WRVALIDSEL   BIT(24)  /* RW */
>   #define SDC_FIFO_CFG_RDVALIDSEL   BIT(25)  /* RW */
> @@ -1917,9 +1921,13 @@ static void msdc_init_hw(struct msdc_host *host)
>   	pb1_val |= FIELD_PREP(MSDC_PATCH_BIT1_CMDTA, 1);
>   	pb1_val |= MSDC_PB1_DDR_CMD_FIX_SEL;
>   
> -	/* Set single burst mode, auto sync state clear, block gap stop clk */
> -	pb1_val |= MSDC_PB1_SINGLE_BURST | MSDC_PB1_RSVD20 |
> -		   MSDC_PB1_AUTO_SYNCST_CLR | MSDC_PB1_MARK_POP_WATER;
> +	/* Support 'single' burst type only when AXI_LEN is 0 */
> +	sdr_get_field(host->base + EMMC50_CFG2, EMMC50_CFG2_AXI_SET_LEN, &val);
> +	if (!val)
> +		pb1_val |= MSDC_PB1_SINGLE_BURST;
> +
> +	/* Set auto sync state clear, block gap stop clk */
> +	pb1_val |= MSDC_PB1_RSVD20 | MSDC_PB1_AUTO_SYNCST_CLR | MSDC_PB1_MARK_POP_WATER;
>   
>   	/* Set low power DCM, use HCLK for GDMA, use MSDC CLK for everything else */
>   	pb1_val |= MSDC_PB1_LP_DCM_EN | MSDC_PB1_RSVD3 |


