Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D424226863;
	Mon, 23 Jun 2025 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672626; cv=none; b=n/iJ0Qbots1OARqmD46QPzYGcJEGtbsJLhZCMBtexIWWItpMmfAyy/5AZUaXrhWzp8pyU7I2wrSrVutc9FA5idAyVBIqYVzj1HKIN1qW/ah6Bj4qy5TXGenn89DpIPsM7FX1tHZXUA9EybRrzLEdh0mrTeXPPslMjdpoE+HSew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672626; c=relaxed/simple;
	bh=RCoJ5AZdDySs/hgx/F/bh991l9gXs7r9SpWwcCsJYtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrU5ZC7nKlL3kygBK6r0YK56uVV0PB6jYp5DHeKN/7UQ8gklRxFf1VjLmrpZhgwcX9eo8aoBYy6HpF2sH6bOJfdXLJlYSJ7PEanBbjyICeXfH8kLrKOzvxBIzk0ecJN2GYaY3xjH3oKKC2Rk9ub7Lfu/ShumuC3cSrJlniVLFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ADPjSGuw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ADPjSGuw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750672622;
	bh=RCoJ5AZdDySs/hgx/F/bh991l9gXs7r9SpWwcCsJYtc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ADPjSGuwchwiLsRJIJWOi+gMDR1l0IBj1P3S0NQkes28J5zHw0pxwAIMDuzPp7zhY
	 emkvjW5zcZp3kwUJkygjWWfXgcAuYJxd2xiW0rVEJEeQMFzmLPh923cctaXzr2f/mS
	 74qZYd44oqd80YPZ9jP0KUchH+6xLtuXzBnE4TrvM4U1/n3Im3755Pb8XnY2n3rzZA
	 JjWZJBJPSRNizhDmb/AEvPw7lI2gOOr+ZuG9uOQa0sQxG26ACHI521BfUKYIWVRa27
	 Xm5hvtefav2lWjhnsNmDiPVZQaPqrc5yGej+CReXehWFXZSwLQ7go4SLkanuh37WRt
	 ywRxw2nLCyOJQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9CD9F17E0CF7;
	Mon, 23 Jun 2025 11:57:01 +0200 (CEST)
Message-ID: <71fbe6ac-c89b-46ea-b0d2-31a829c0a2a0@collabora.com>
Date: Mon, 23 Jun 2025 11:57:01 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mmc: mtk-sd: add default tuning parameters for mt7620
To: Shiji Yang <yangshiji66@outlook.com>, linux-mmc@vger.kernel.org
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <OSBPR01MB16708176FE57F691359D0943BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
 <OSBPR01MB1670942996614E073E87077DBC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <OSBPR01MB1670942996614E073E87077DBC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/06/25 07:35, Shiji Yang ha scritto:
> The MIPS MT762x SoCs require some specific tuning parameters at
> different clock frequencies. These legacy SoCs only support max
> 48~50 MHz High-Speed SD mode. Therefore, the standard tuning step
> is not available. We have to hardcode these tuning parameters to
> make them work properly.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>   drivers/mmc/host/mtk-sd.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 53d63bb4e..52198daef 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -79,6 +79,8 @@
>   #define MSDC_PATCH_BIT2  0xb8
>   #define MSDC_PAD_TUNE    0xec
>   #define MSDC_PAD_TUNE0   0xf0
> +#define MSDC_DAT_RDDLY0  0xf0
> +#define MSDC_DAT_RDDLY1  0xf4
>   #define PAD_DS_TUNE      0x188
>   #define PAD_CMD_TUNE     0x18c
>   #define EMMC51_CFG0	 0x204
> @@ -449,6 +451,7 @@ struct mtk_mmc_compatible {
>   	bool use_internal_cd;
>   	bool support_new_tx;
>   	bool support_new_rx;
> +	bool mips_mt762x;
>   };
>   
>   struct msdc_tune_para {
> @@ -595,6 +598,7 @@ static const struct mtk_mmc_compatible mt7620_compat = {
>   	.enhance_rx = false,
>   	.support_cmd23 = false,
>   	.use_internal_cd = true,
> +	.mips_mt762x = true,

No, you can't do that - this needs to be done in a clean manner.

Please map that to something that makes sense, as in, add the register definitions
and add something like...

.tune_para = {
	.tune0_rval = FIELD_PREP_CONST(MSDC_PAD_TUNE_DATWRDLY, 16) |
		      FIELD_PREP_CONST(MSDC_PAD_TUNE_DATRDDLY, 16) |
		      FIELD_PREP_CONST(MSDC_PAD_TUNE_CMDRDLY, 16) |
		      FIELD_PREP_CONST(MSDC_PAD_TUNE_CMDRRDLY, 4) |
		      FIELD_PREP_CONST(MSDC_PAD_TUNE_CLKTDLY, 10),
	.rddly0_rval = etc etc etc :-)
};

...then, check if .tune_para is present: if it is, apply the static settings,
otherwise, don't.

Cheers,
Angelo

>   };
>   
>   static const struct mtk_mmc_compatible mt7622_compat = {
> @@ -1090,7 +1094,12 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>   	 * mmc_select_hs400() will drop to 50Mhz and High speed mode,
>   	 * tune result of hs200/200Mhz is not suitable for 50Mhz
>   	 */
> -	if (mmc->actual_clock <= 52000000) {
> +	if (host->dev_comp->mips_mt762x &&
> +	    mmc->actual_clock > 25000000) {
> +		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> +		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
> +		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
> +	} else if (mmc->actual_clock <= 52000000) {
>   		writel(host->def_tune_para.iocon, host->base + MSDC_IOCON);
>   		if (host->top_base) {
>   			writel(host->def_tune_para.emmc_top_control,
> @@ -2028,6 +2037,13 @@ static void msdc_init_hw(struct msdc_host *host)
>   				     MSDC_PAD_TUNE_RXDLYSEL);
>   	}
>   
> +	if (host->dev_comp->mips_mt762x) {
> +		/* Set default tuning parameters */
> +		writel(0x84101010, host->base + tune_reg);
> +		writel(0x10101010, host->base + MSDC_DAT_RDDLY0);
> +		writel(0x10101010, host->base + MSDC_DAT_RDDLY1);
> +	}
> +
>   	if (mmc->caps2 & MMC_CAP2_NO_SDIO) {
>   		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
>   		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);


