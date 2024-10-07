Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930D2AEE1;
	Mon,  7 Oct 2024 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287943; cv=none; b=D9umOYcH1HVZK4MKhUxfweEw9fruyWuDA3vrSH6lN0OG5vAx/E1aAhPkFKoNLdAppHsj2mgHbiBQGHutuBHLtTnixGQ6DbnTY19R51wvy48L9wpDNEM/VpRFxItbQQkxf9xrlZav8EWzu53sBwsT+2Pr8lMYKFZ/r/z/p4uyRrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287943; c=relaxed/simple;
	bh=wOh0QPI7DTVnxpT5sRYZP+/1OT7v2CLXqVlg+poKfWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTrCw9SThL8IBULxDrriKMlsAUyMgSNGp8XwgsEy5aZnA5BvLhUKx6a2hT7cYMuPAy+VZuyQAajdZp2ikYxUFYoevBxEkWvUlgphFzTvyM+szOAB6MiyshuDHFNptZVEBvQbRbQN32m0QgAH2wuELTkcgwbC8AmMvW3Pl5A8ugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UTi+cpH6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UTi+cpH6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728287934;
	bh=wOh0QPI7DTVnxpT5sRYZP+/1OT7v2CLXqVlg+poKfWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UTi+cpH66SgdTO9JjX72kICGcoj2zsDKXtG9fkd0c/XyFK1RBa4uVFrULFfu0RZOf
	 o6oOOJL0yhufT304VcUaf6gjEU7pk1WCzsRJS7LAC0587QreuuwXmDxbYb9pj3EeXB
	 bQdkn8uQe9Gs1DCtewabFWXBMPy8vIze1hbiYKCqjLRITEgKncGIS/jHwPLQzgc0cp
	 +qRzura2syXO3TRvhYUqdSfH2Adil35hsAbUnlYCIDi3qvV0bklMCoQhqjy+AUzAsZ
	 TvnL4z60r8dRl4hvNCKqS+lrCTyoK1qDPbCdrJOCAOsIQNFDvdfPHLkzkUKdg6Atyi
	 y3ia2HM8jIb2g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 821B817E1083;
	Mon,  7 Oct 2024 09:58:53 +0200 (CEST)
Message-ID: <89e54baa-0f05-47d7-8d81-68862f822c59@collabora.com>
Date: Mon, 7 Oct 2024 09:58:52 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: mtk-sd: add support for mt7988
To: Frank Wunderlich <linux@fw-web.de>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 daniel@makrotopia.org, john@phrozen.org, eladwf@gmail.com,
 ansuelsmth@gmail.com
References: <20241006153447.41377-1-linux@fw-web.de>
 <20241006153447.41377-3-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241006153447.41377-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/10/24 17:34, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add support for mmc on MT7988 SoC.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

There's no need to add yet one more duplicate mtk_mmc_compatible platform
data, nor one more compatible string to this driver, as this is exactly
the same as mt7986.

Please reuse the MT7986 compatible; in DT you'll have:

compatible = "mediatek,mt7988-mmc", "mediatek,mt7986-mmc";

Cheers,
Angelo

> ---
>   drivers/mmc/host/mtk-sd.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 89018b6c97b9..6d5afe51a61d 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -571,6 +571,19 @@ static const struct mtk_mmc_compatible mt7986_compat = {
>   	.support_64g = true,
>   };
>   
> +static const struct mtk_mmc_compatible mt7988_compat = {
> +	.clk_div_bits = 12,
> +	.recheck_sdio_irq = true,
> +	.hs400_tune = false,
> +	.pad_tune_reg = MSDC_PAD_TUNE0,
> +	.async_fifo = true,
> +	.data_tune = true,
> +	.busy_check = true,
> +	.stop_clk_fix = true,
> +	.enhance_rx = true,
> +	.support_64g = true,
> +};
> +
>   static const struct mtk_mmc_compatible mt8135_compat = {
>   	.clk_div_bits = 8,
>   	.recheck_sdio_irq = true,
> @@ -629,6 +642,7 @@ static const struct of_device_id msdc_of_ids[] = {
>   	{ .compatible = "mediatek,mt7620-mmc", .data = &mt7620_compat},
>   	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
>   	{ .compatible = "mediatek,mt7986-mmc", .data = &mt7986_compat},
> +	{ .compatible = "mediatek,mt7988-mmc", .data = &mt7988_compat},
>   	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
>   	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
>   	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},

