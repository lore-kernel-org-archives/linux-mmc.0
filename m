Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240C204C3B
	for <linux-mmc@vger.kernel.org>; Mon,  3 Feb 2025 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591478; cv=none; b=jB9gNrnd3/EbxZ3Ka6WFDphn+Oiim5tQhEnA862fslQxvJPvc+8z4+eJzG1EoCGp63kA6cgyG/Zul/doUwlQHn8aXK+H4oUxIDV8yN4yTedSshJf18HRCc0wquTvmdubEexKGats+G6QfbvlHQ1lClTvrN96o770WdVj7aCY7Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591478; c=relaxed/simple;
	bh=2OIa1ZIrEwhXL5MsvNbrU11CTYqkfYM0Ww6BzG16qY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3tS3RnmRBcg/BPDTeQpCoEME8PxcEZjUnKRjbFKIFSXCH5uEgpznzH5G8NZ+uBk49i4O6hpvZ1SsV20blGmzcAz1lUICuxzJn/ydpL+yPTOGsOUv7F659yDrAo/1+O6tqje5ttqD4XYqTJeeSn99c5rF2yDhDfUvED75DqSuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j90kcpty; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j90kcpty"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f14626c5d3so25128537b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 03 Feb 2025 06:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738591475; x=1739196275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3MiG8ILt8Yn9LtSo8zrEP73wfD//i7MORC/NBtgshl4=;
        b=j90kcpty5ptvm7j5BK78SVi4pUcc3yTLzxSFQnNTRW8h6yd1kiLhJQ/PDC1A26hBFQ
         v2UZeUKpQEeV2miSwkgl6fk4tHbc53WR9U+HMAwpFzIRJZsU+4NK3xMsgJ+UkxqHwcS8
         0aDGFRurY61KDmaxSJwWHah6YktFQYo47bfzLqFb+9m0j9FqDbBpOrKre8PnJpuYMDvR
         bAH8TP8mAIVrnaA+ZF67W3eW92mI2a3nvjDIwxMe4kikYGJMz6Y2I3WT8EUZDfz26oga
         RjSUyHuA59F/oG9ReTf/cQ9/VSA2vSbQNWi5LDmqWRCTUQxCTpIllfVov6DppSmkkveJ
         lEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738591475; x=1739196275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MiG8ILt8Yn9LtSo8zrEP73wfD//i7MORC/NBtgshl4=;
        b=kDqwZXrd69plfJlbAEcc+QLe2XU2zN7Z7UWvJWweYr2i7LFwbANsl3TBu3QUkEewjE
         X3RisvbloTz7AsvOWg1qVqXcZh4GLfkrtMcyBPeNuSdSn7Os3txJ7V59V+FAgNvZ0CL5
         i/kAW7eK2/VZPV6tn1FBj+RFFDEDZ3vza0XhyA3jVzFWyAwAUBTO4xW6n7EkQTItyTtU
         sDH6KIK+3NX3H3ExXpfVP302CPwLEPFSEcGUbO3ESUwSSqbHODAYG5P/n3xBWvCReL6D
         OCcoFkSPEpOOkdqY7uD5Oo6sTJhnruI7PLMrrRnbocoDKKDK939c00AK4GuJu815vQRw
         8rwg==
X-Forwarded-Encrypted: i=1; AJvYcCW+ZFy/XWRF+FL7aEHnx2Tk+1/y6cmExo5tKJYnIUfXvdJ7EWc4Jj/lCdqsn3W9X9PFzOBPkSPdNuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMJjwGxrumv1OILRfh3fTEUOfxjQIf/pZ5p0WVNPG7PZUurVlh
	KDl7LfsXHhb6U2z+bkoAdOicw3lw9nN0RwfaXz1Fgb8NnRuZtyTOhPn12HfCNHDCLpjEKIyw1JO
	EFPc5CwSRTygJYRuWD3hhZ/0b+7oX/Zj6K8/hCw==
X-Gm-Gg: ASbGnctWHJiwCY1pj+yDAjuNj01gTeydKaUDRWIbqS7p/ZXXAMlA0Z8mKPx6zOPAJOw
	D5xSmL2/YHFtYx+C6tp7R7vWkCBmbQ3XdT+y3IZqBesB5pzx1C5wBhN+YlSB2vjGN4Dy4D2DFyw
	==
X-Google-Smtp-Source: AGHT+IHLs3FLituH22CBJTCC44v20E2zGZEme1CuUalIEcbSHa4S1LzyVXjnSZYtsdh38rN7Sycwz9vIj9EtGuifSjM=
X-Received: by 2002:a05:690c:994:b0:6f0:237e:fc67 with SMTP id
 00721157ae682-6f7a83fcefamr125534307b3.23.1738591475324; Mon, 03 Feb 2025
 06:04:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123092644.7359-1-andy-ld.lu@mediatek.com>
In-Reply-To: <20250123092644.7359-1-andy-ld.lu@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Feb 2025 15:03:59 +0100
X-Gm-Features: AWEUYZnk_P6e6WT5mTt4ApkOyTMWhna0dJzCdBChCmPPxEjQ9bm-vcA95IzI1VE
Message-ID: <CAPDyKFpXGoM+iYyMBtrnctPX_cJQv=tN52NunBRcfJecQzGy5A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: Fix register settings for hs400(es) mode
To: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	wenbin.mei@mediatek.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 10:26, Andy-ld Lu <andy-ld.lu@mediatek.com> wrote:
>
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

Applied for fixes and by adding a stable-tags, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Change commit title from 'optimize' to 'Fix'
> - Add a Fixes tag
> - Change spaces back to tabs
>
> ---
>  drivers/mmc/host/mtk-sd.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4b6e91372526..345ea91629e0 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -273,6 +273,7 @@
>  #define MSDC_PAD_TUNE_CMD2_SEL   BIT(21)   /* RW */
>
>  #define PAD_DS_TUNE_DLY_SEL       BIT(0)         /* RW */
> +#define PAD_DS_TUNE_DLY2_SEL      BIT(1)         /* RW */
>  #define PAD_DS_TUNE_DLY1         GENMASK(6, 2)   /* RW */
>  #define PAD_DS_TUNE_DLY2         GENMASK(11, 7)  /* RW */
>  #define PAD_DS_TUNE_DLY3         GENMASK(16, 12) /* RW */
> @@ -318,6 +319,7 @@
>
>  /* EMMC50_PAD_DS_TUNE mask */
>  #define PAD_DS_DLY_SEL         BIT(16) /* RW */
> +#define PAD_DS_DLY2_SEL                BIT(15) /* RW */
>  #define PAD_DS_DLY1            GENMASK(14, 10) /* RW */
>  #define PAD_DS_DLY3            GENMASK(4, 0)   /* RW */
>
> @@ -2504,13 +2506,23 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct msdc_host *host = mmc_priv(mmc);
> +
>         host->hs400_mode = true;
>
> -       if (host->top_base)
> -               writel(host->hs400_ds_delay,
> -                      host->top_base + EMMC50_PAD_DS_TUNE);
> -       else
> -               writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
> +       if (host->top_base) {
> +               if (host->hs400_ds_dly3)
> +                       sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
> +                                     PAD_DS_DLY3, host->hs400_ds_dly3);
> +               if (host->hs400_ds_delay)
> +                       writel(host->hs400_ds_delay,
> +                              host->top_base + EMMC50_PAD_DS_TUNE);
> +       } else {
> +               if (host->hs400_ds_dly3)
> +                       sdr_set_field(host->base + PAD_DS_TUNE,
> +                                     PAD_DS_TUNE_DLY3, host->hs400_ds_dly3);
> +               if (host->hs400_ds_delay)
> +                       writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
> +       }
>         /* hs400 mode must set it to 0 */
>         sdr_clr_bits(host->base + MSDC_PATCH_BIT2, MSDC_PATCH_BIT2_CFGCRCSTS);
>         /* to improve read performance, set outstanding to 2 */
> @@ -2530,14 +2542,11 @@ static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card
>         if (host->top_base) {
>                 sdr_set_bits(host->top_base + EMMC50_PAD_DS_TUNE,
>                              PAD_DS_DLY_SEL);
> -               if (host->hs400_ds_dly3)
> -                       sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
> -                                     PAD_DS_DLY3, host->hs400_ds_dly3);
> +               sdr_clr_bits(host->top_base + EMMC50_PAD_DS_TUNE,
> +                            PAD_DS_DLY2_SEL);
>         } else {
>                 sdr_set_bits(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY_SEL);
> -               if (host->hs400_ds_dly3)
> -                       sdr_set_field(host->base + PAD_DS_TUNE,
> -                                     PAD_DS_TUNE_DLY3, host->hs400_ds_dly3);
> +               sdr_clr_bits(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY2_SEL);
>         }
>
>         host->hs400_tuning = true;
> --
> 2.46.0
>
