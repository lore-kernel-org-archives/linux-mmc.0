Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904913A7F41;
	Thu,  5 Feb 2026 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292054; cv=none; b=lApvmvFER/uiaNfaYBM1/aIcD1Sb/Vs1kPAE+OCm/DWt2oEPGdLDCDWCFF2lB1r5Bo4phVL0stx9OkjWsMloIAMfFif2Poqm7VTZmsRRLsJc1UIYYHAMjpE5I2Fd3uweFaDrg5oCXgRHG9+WK6GedmFbZ1VGMGbffUzQe+uzzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292054; c=relaxed/simple;
	bh=Ws6OzDQVrOxdD0jUIjuPKZPO9P+V9t/Y8YCXpYTlx3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5X0WT6wx1i97oIMw4go+pTqWDdo2NKoP/wDePDCLrK7BXlpRDam14tAvIZOoOV19dRS/9COGhsQZtUpfd1i4GRFfnz7GALbl5Oxw4PzNTlpsyjl2H1D3cN/gBrwUjkoKxXo8+nuDGjRqsqncfxAKmwq9gydkrz3LCNCNvv6XcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mql04GFJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mql04GFJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770292052;
	bh=Ws6OzDQVrOxdD0jUIjuPKZPO9P+V9t/Y8YCXpYTlx3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mql04GFJR869FmjE8II2bQN1vOz0TJZ3gFVy8SLkasH1216LF4hvRO/wokQ6kfT+y
	 tAMKmnMeP48ZNbfagP5T5B5FB8nBE16jaoyj/pxe9I0/+qvajfbmVy7FNZpdn1SsD/
	 Eklo8uEXsMxyBYhnCOUqKIoEMFNUHLd62PK/iMHqYPXAIkEqt9GfTELjssvZB19nsK
	 UOfEyjZzSn/IC6PSUAIswwAHGpFvfdOzCpmA47cm7UNx+H6ncth13hzZDNEkRtBKck
	 Iqq8RuW2Ao34OywVNZAIC1T+zUPGOjfqtewgxqoLpMTYSUqOh7dMMW/UCWOn2F9Nm1
	 ferjkv0gmPq3w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5546217E06C3;
	Thu,  5 Feb 2026 12:47:32 +0100 (CET)
Message-ID: <33719d8d-af95-49ae-bc5e-247784529d12@collabora.com>
Date: Thu, 5 Feb 2026 12:47:31 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: mtk-sd: disable new_tx/rx and modify related
 settings for mt8189
To: Cathy Xu <ot_cathy.xu@mediatek.com>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Mengqi Zhang <Mengqi.Zhang@mediatek.com>,
 Wenbin Mei <Wenbin.Mei@mediatek.com>, Andy-ld Lu <Andy-ld.Lu@mediatek.com>,
 Yong Mao <yong.mao@mediatek.com>
References: <20260204020709.24604-1-ot_cathy.xu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260204020709.24604-1-ot_cathy.xu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/02/26 03:06, Cathy Xu ha scritto:
> Disable new_tx/rx and modify related settings helps avoid data
> transmission instability, and better compatibility for mt8189.
> 
> Signed-off-by: Cathy Xu <ot_cathy.xu@mediatek.com>

Needs a fixes tag. Please add the relevant one and resend.

Thanks,
Angelo

> ---
>   drivers/mmc/host/mtk-sd.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 302ac8529c4f..b2680cc054bd 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -682,15 +682,15 @@ static const struct mtk_mmc_compatible mt8189_compat = {
>   	.needs_top_base = true,
>   	.pad_tune_reg = MSDC_PAD_TUNE0,
>   	.async_fifo = true,
> -	.data_tune = true,
> +	.data_tune = false,
>   	.busy_check = true,
>   	.stop_clk_fix = true,
> -	.stop_dly_sel = 1,
> -	.pop_en_cnt = 2,
> +	.stop_dly_sel = 3,
> +	.pop_en_cnt = 8,
>   	.enhance_rx = true,
>   	.support_64g = true,
> -	.support_new_tx = true,
> -	.support_new_rx = true,
> +	.support_new_tx = false,
> +	.support_new_rx = false,
>   	.support_spm_res_release = true,
>   };
>   

