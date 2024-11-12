Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A2218D92
	for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2024 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437070; cv=none; b=pejQRF8xgUtUqelinSAFDoWXSLEtT/7IiDE0WfMtpfR+wrBWrKu7aC5UveSYNFLUQeRH30MrZlBDaLvOThzEhzie8pH4VT8rOcO0VFqsrCm3/fB4DXjiivGnhuATBMaKpnbuVQSZkr6vS2qc9dodEj/5dxkOICHF2srdkIy9EVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437070; c=relaxed/simple;
	bh=umvgPJnmoFbJOcPsEYyj2bEHoUFZgIA/ixmRZhrahOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJb+CHdyDPyUiI4bED8hHNzE9rYYkPYEXcdPS6Hrj3Ftw5hYPtxOOSdXPoJiQYDweQCNx8bgO7BVS7wJoThHfC3zlvBEb4CeRpj6c31z82p7BjNfagq7fsaQTxlmi18SRnxEmNH0FyVSJdUPfiDbKZ5DCseauS14U1mAjYaTJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kD9OQIjT; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kD9OQIjT"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e291cbbf05bso5886006276.2
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2024 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437067; x=1732041867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oxgsDspc5q1Jni5adG0LIm1mb6Zw1UKHydszhDw5eao=;
        b=kD9OQIjT67qboL5mx8m5olcM1j6SYSRxCXL+CI/AO1awYoAGRJgf1PQG77+2AQZ4yM
         7dhvTsD4BXlulCvoUAKecGJIbYhpUZr/W5DIp1+mfdr/RkKuvnCMzT448YQ793gFCRT0
         wd/jVEh3ra++BM8FDcv81WwoUFeIEv2p5xrQWlY/nfVIj0raj61EgmZs7AN1wwd+MD2F
         M3Jiai+GInlPerq7nzfIakf417I/BmkGmtkDeVVMDifs8IBs6mfqJSNQA9yS+iCEIGTT
         FMQjcvNlLL2hxoG9aj4x0FZSwnB+gDDCzgNLovbqtdIK5HH92i+YqNou46YTVnGlkhQB
         eKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437067; x=1732041867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxgsDspc5q1Jni5adG0LIm1mb6Zw1UKHydszhDw5eao=;
        b=jdNAVMagxHwRXI29YGT3UiDDOzyw/vQLnl+iKo5YBVSPpElw3qhK78878Ml/r0+Djw
         FYdvTJDxqkJluwnQTh2teYrpQkpIzzqoebE1OszdjrLrHdZekn7iO36NI7Zn5ZojAaFZ
         Ap1/bO1ZqJ/CcBX6zsxrx8UPlPgcakrag2NxUUToYqDdTvU4ND235fjGXSXZ9Vwq9Sa1
         FLzcPuml6EWmf8d411xHW4FWrdSN6areG2GT2a88584j2lCSlBHAsPCEomOoA+3P2+T2
         naXjSV6ZEXObd1yZ/LZUpJXVZBygk4IN9+AH3kAr/NlgRDV7lG++NIL8HCYlX82sGfcQ
         UAtg==
X-Forwarded-Encrypted: i=1; AJvYcCXRGiT/ZTrQYMwbs8qQlw/sz1Iecvzv73tiZZNNLSdfq+N/Crq46Kzb8f5+9EdITNTnJHIVpm1jFkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjYcr1dHIejsDslQ6LwPIwqQbVJtlN/8Mvd8Nzap5e1uUBCHbk
	s/OHEX5c/WJpZRKxC75hALMFbBmR8CiRknOqguhswTFOowNBWCehmfgoWl7kMFs3kyvOitbSjhZ
	xhGCfTGCqrDy8ALi3ooltMwECCUpjZBFn8XL6iw==
X-Google-Smtp-Source: AGHT+IFMWgRdxZRJtK+Lo3CBpB+VX1bBIjkAiyKqAQn28lKpDNF2wtZFNkKRtCi41qnWunWXbKSXnRp5CfqY5x5v/NA=
X-Received: by 2002:a05:690c:887:b0:6ea:7e37:8cc3 with SMTP id
 00721157ae682-6ecb31b89b0mr847947b3.2.1731437067438; Tue, 12 Nov 2024
 10:44:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111085039.26527-1-andy-ld.lu@mediatek.com>
In-Reply-To: <20241111085039.26527-1-andy-ld.lu@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:51 +0100
Message-ID: <CAPDyKFopLrZ2Pn66m-CtjDGOEZyiZ+_i8TnnD4KSHpFqCTN7eg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting
To: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	wenbin.mei@mediatek.com, mengqi.zhang@mediatek.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 09:50, Andy-ld Lu <andy-ld.lu@mediatek.com> wrote:
>
> Currently, the MMC_CAP2_CRYPTO flag is set by default for eMMC hosts.
> However, this flag should not be set for hosts that do not support inline
> encryption.
>
> The 'crypto' clock, as described in the documentation, is used for data
> encryption and decryption. Therefore, only hosts that are configured with
> this 'crypto' clock should have the MMC_CAP2_CRYPTO flag set.
>
> Fixes: 7b438d0377fb ("mmc: mtk-sd: add Inline Crypto Engine clock control")
> Fixes: ed299eda8fbb ("mmc: mtk-sd: fix devm_clk_get_optional usage")
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>

This didn't apply on fixes the branch, but only on next. That said, I
have queued this up for next and added a stable tag.

Note that, this means that the fix needs to be backported manually,
but I leave that to you or someone else to take care of.

Thanks and kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 022526a1f754..efb0d2d5716b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2907,7 +2907,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 host->crypto_clk = devm_clk_get_optional(&pdev->dev, "crypto");
>                 if (IS_ERR(host->crypto_clk))
>                         return PTR_ERR(host->crypto_clk);
> -               mmc->caps2 |= MMC_CAP2_CRYPTO;
> +               else if (host->crypto_clk)
> +                       mmc->caps2 |= MMC_CAP2_CRYPTO;
>         }
>
>         host->irq = platform_get_irq(pdev, 0);
> --
> 2.46.0
>
