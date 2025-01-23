Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CDB1CDFBC;
	Thu, 23 Jan 2025 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737635641; cv=none; b=MR5iBcZJc6HbVM8aQeCF/hwg2PzIKCAKEvbq/nCgqprd2L8vyXo95Oelaj3gg0uU3XElLjoy8JQP/0AVMTzN3FwtHmrAG21Pkyp5MWiVKIbsS/pmIvRrbzD68DxQtoOLhziXB3fZJUnCiWmeVtU/xFzqB2L51LpfjTkGdUSTwQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737635641; c=relaxed/simple;
	bh=n+6IUxsW4H4bSYmqPQjoTK1FHxsbX9PDXmPVfDRcSqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA5nfIIegt+2dsw7Xw1S6VcjqPRX+yS0delQRB+m4xzEOP8X+IrwszEb+xNa2LvU1uXO+eBFMoW5eg+591S8xYaQX5yzUMppIk1vFdR4A1MSRWrME3mVjrkmhadCfWm+6/tEvRi1BxVsZxMSYYqIJVP00e5ZUIKpgmIkKQid3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iKqC1TmG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iKqC1TmG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737635632;
	bh=n+6IUxsW4H4bSYmqPQjoTK1FHxsbX9PDXmPVfDRcSqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iKqC1TmGIEJd8D41d972RFZCbgfAmS39po+SUOviQ1ifkD3+wjyeNl9/FXkd6K3lB
	 YK/JeW6Kc6YGEO8cl/roK6l1s06TFVHeFMvOHcSq6tM3thdgifIRvByM3uEvrl/AV/
	 ZTHhN3bD15aa8ZZFrueQOE+HXL/lU4WkUDdDLfHpNcxaN45HNmMErGPShadqbIXopV
	 TgfO5wKw3j6cSCZB7iFzG+g+MH16Z1DN4dATwMc4E3/GaV6IXj7TFXmKteDxz0SccF
	 BzY0bcKsuAY56rIl3VHCMBEOvL7QqHt5Ji5d2ClaRZMucBC89MerMIN1LRLRodq1SX
	 deiz0N0Xq+/nQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C017517E0DD8;
	Thu, 23 Jan 2025 13:33:51 +0100 (CET)
Message-ID: <4455b317-aeea-42ff-be55-020d52330219@collabora.com>
Date: Thu, 23 Jan 2025 13:33:51 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: mtk-sd: Fix register settings for hs400(es) mode
To: Andy-ld Lu <andy-ld.lu@mediatek.com>, ulf.hansson@linaro.org,
 matthias.bgg@gmail.com, wenbin.mei@mediatek.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250123092644.7359-1-andy-ld.lu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250123092644.7359-1-andy-ld.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/01/25 10:26, Andy-ld Lu ha scritto:
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
> 
> Fixes: c4ac38c6539b ("mmc: mtk-sd: Add HS400 online tuning support")
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


