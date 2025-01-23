Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581F20C03A;
	Thu, 23 Jan 2025 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621847; cv=none; b=tvDJHvFPLArtWhnlhCp8IxF5SPyafDIRMCmNaRUxPdUBfVipxnCEn7yoFxlAGlAd4E2cmTyqe2xNakKk+/kp23mNNEi9b3Vc45uJWbNwi5B3WQaVAK1NWgwX1Q25FgHzoG0Pp4voo28Ebej1D4gqmwlJrvBAeBW54eivNBG4w2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621847; c=relaxed/simple;
	bh=X9iLHrmUCfUP0u/hzoqlgA/TZSQZ4GDtUBrIT1ITcKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhpTLrknkb22VwP8Q92q+iW19Wye/h+6teOSZ4u/vzdnj/IIpiJ/J8DJ6UMlUxyu7eF/bA9C/J4ZUmTS3AUCBJN0FCq/dJMU35ehou9F4Cr3P20HoAjc7HS8mzjKUs2xNPgc6UBzct6baQJ/SvEyCxxq/N7qPlNIwRmrdXid8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OsBivDlg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OsBivDlg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737621843;
	bh=X9iLHrmUCfUP0u/hzoqlgA/TZSQZ4GDtUBrIT1ITcKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OsBivDlg4M689K5Q0VmrPmfJVoY/rfmQfg2wL4mEAgd6RmviekHIoXogFtwHI6A78
	 PY/yfJTIA6e3ORDGUjMDfVU1HSApMsWkj7ZHg3tFIQIEA00F1wIpK8mbegxhhuRJuC
	 TsMoKdU7nGx2YIk8NlDjPYQ7jwWh2mGbN/Ot8LBo6yZ7L+jKMBf9FF+04khsvl3VLO
	 VNf7Jhfie9+CIsopJn5IzHKqu76YjD98Od9p8wO39maD9MUUSEhqN7OitsOsujrzyg
	 kvcVF8ZYN+HM8SK5KkXOMkezHpg7AseTq0kPKmXbFr1bsGp5NPu3YUcE3+8g10rUIX
	 jMGDJq2PJbn/w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AFB4A17E0E48;
	Thu, 23 Jan 2025 09:44:02 +0100 (CET)
Message-ID: <f7f414fc-1794-4e73-9b63-68df933a3244@collabora.com>
Date: Thu, 23 Jan 2025 09:44:01 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: mtk-sd: optimize register settings for hs400(es)
 mode
To: Andy-ld Lu <andy-ld.lu@mediatek.com>, ulf.hansson@linaro.org,
 matthias.bgg@gmail.com, wenbin.mei@mediatek.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250123074442.1617-1-andy-ld.lu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250123074442.1617-1-andy-ld.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/01/25 08:44, Andy-ld Lu ha scritto:
> For hs400(es) mode, the 'hs400-ds-delay' is typically configured in the
> dts. However, some projects may only define 'mediatek,hs400-ds-dly3',
> which can lead to initialization failures in hs400es mode. CMD13 reported
> response crc error in the mmc_switch_status() just after switching to
> hs400es mode.
> 
> [    1.914038][   T82] mmc0: mmc_select_hs400es failed, error -84
> [    1.914954][   T82] mmc0: error -84 whilst initialising MMC card
> 
> Currently, the hs400_ds_dly3 value is set within the tuning function. This
> means that the PAD_DS_DLY3 field is not configured before tuning process,
> which is the reason for the above-mentioned CMD13 response crc error.
> 
> Move the PAD_DS_DLY3 field configuration into msdc_prepare_hs400_tuning(),
> and add a value check of hs400_ds_delay to prevent overwriting by zero when
> the 'hs400-ds-delay' is not set in the dts. In addition, since hs400(es)
> only tune the PAD_DS_DLY1, the PAD_DS_DLY2_SEL bit should be cleared to
> bypass it.

The commit title is a bit misleading: you're not "optimizing" the settings,
but actually "fixing" a bug here!

Please fix the commit title.

> 
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>

This commit needs a Fixes tag, please add the relevant one and resend.


> ---
>   drivers/mmc/host/mtk-sd.c | 37 +++++++++++++++++++++++--------------
>   1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4b6e91372526..4e3e31ddf84b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -273,6 +273,7 @@
>   #define MSDC_PAD_TUNE_CMD2_SEL	  BIT(21)   /* RW */
>   
>   #define PAD_DS_TUNE_DLY_SEL       BIT(0)	  /* RW */
> +#define PAD_DS_TUNE_DLY2_SEL      BIT(1)	  /* RW */
>   #define PAD_DS_TUNE_DLY1	  GENMASK(6, 2)   /* RW */
>   #define PAD_DS_TUNE_DLY2	  GENMASK(11, 7)  /* RW */
>   #define PAD_DS_TUNE_DLY3	  GENMASK(16, 12) /* RW */
> @@ -317,9 +318,10 @@
>   #define PAD_CMD_TX_DLY          GENMASK(16, 12)	/* RW */
>   
>   /* EMMC50_PAD_DS_TUNE mask */
> -#define PAD_DS_DLY_SEL		BIT(16)	/* RW */
> -#define PAD_DS_DLY1		GENMASK(14, 10)	/* RW */
> -#define PAD_DS_DLY3		GENMASK(4, 0)	/* RW */
> +#define PAD_DS_DLY_SEL          BIT(16) /* RW */
> +#define PAD_DS_DLY2_SEL         BIT(15) /* RW */
> +#define PAD_DS_DLY1             GENMASK(14, 10) /* RW */
> +#define PAD_DS_DLY3             GENMASK(4, 0)   /* RW */

Why are you changing tabulations with spaces?
Please use tabs.

Cheers,
Angelo

