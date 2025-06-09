Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073D259CBB
	for <linux-mmc@vger.kernel.org>; Mon,  9 Jun 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479131; cv=none; b=OCKl6yAXnqovU9slHXcTuX/ClleqfZ6rGjXbKRFeDIhLnTmHHFJ52JhJMGmK0gVXqalJpaWqWaF953XSLvblbTcnXX8u1qct6FU9+pUOHjaG4E8e/B+ov6ffMhN2HFEet0lWjd0zNNqZ0abd56ARhXUXNhtMo2dfyREJlPHGsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479131; c=relaxed/simple;
	bh=KBeLUMh2iQI2RMf+hlDrl9qPxrBpsEO7zs58t+tgiRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkGrjWhYcZdnLoWPvuWZ+OZKBFts7HJu18EyCkBS59QwfSRweF4+8O56hRd+3F+IJPQD83DHKHROAut2tglDk/KyrlTbqWoyH1+aelNBhSgMIwVa7z46p9n82EjaTihpsStt2TEMJYm883dNskw0W6GSMQ00uzRb4jgmLcekyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bqHrh5PL; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqHrh5PL"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e73e9e18556so4139937276.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jun 2025 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749479129; x=1750083929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZykcNbDimAS4m5zQC6qPpRpEexn6V57y3u83AlFoEMA=;
        b=bqHrh5PL5Bjt3Rsyv455EOJhdn9fynbLkL+/qbaUHVVLC0XFunB1vXsQpwzEq+W2jR
         eDDt1dOkOIaETShV+iVBMjzL848CSOVASYxqBfEEXgwVQLOl15jnhDWGC1JCFFTfIlqi
         una24V9+/vcsXyVh2GStd2CfE7YJO2mJcUSPRXjRogvHBWmXxdDieRuJ64oiIbFgXKTk
         i5G3zpswX+I7nHS7C8tWslR2lLECHCeWi39y7X6iwI8e7KXITfGE3Cqj2RWbQ2vx0uzA
         TvD0cBIuRykPLxY0ggXJOFZcuUcWxO65IDF1xAzb3upXprbujqddyK5itpcAY7c/BBXu
         EslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479129; x=1750083929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZykcNbDimAS4m5zQC6qPpRpEexn6V57y3u83AlFoEMA=;
        b=CRnGrD4vUMGg4RxyLMpktwPaC7sxtpqITLiPnmdAImskdubJQDTohPANaDse/noR2y
         OHQYFFDJBbb0VPwC/k5fW0FrfWkctqmK8/V50zQyR6oO8pahfEmvwmhdQhq8WTuEYapf
         WihoLogvrNmwJOlacCCNCC8j/41C8smrcXyIwKDIau7tkf8g8C5eNQeetTxC4QpsD9Om
         o/r5/5IjGCoqMbR4AmrpULRJ956u+trOQNNxuq4NaL+j2hvgH8f36Ph3WQ+I6txyk3Na
         c//LN87s+09XQLpVrK58cd2kwnlxGmT1YQg6ll57h7oDfFH8bFDQJ1+mA2Odfn1bzyHs
         xlcA==
X-Forwarded-Encrypted: i=1; AJvYcCW5L9H/uur3t3BZsVf+0o30fxmVz0gCDhYuKuahb0pU3rZveF5KfgzuRzVJp31t/oKo/IOZGZuGwzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPRZf45WsHzG+J1cQaa2HUnQ4mBZYHopS9OoU9LRCwEx3oV0uU
	1G97ZtPYAvrxfcIkKSn4BxZ9izi5dzW0ug5jlRivNRkuvTup7Zo96bzSbm0FU56EPN4sZknDAWQ
	MVeshSj0Fi5t3qHvYIilhckvSUPRmsbQndbzM/P9STA==
X-Gm-Gg: ASbGncsi7anNSiRcHrQD0bxumKSpWENZt5Z5qcsQTgRHCROiv0CUXtslDJWBpXHf8DU
	Yw/rmbywWR6//RJdCHTNVbHSqdASiHg7Hc2e42SYUATApGrw79arixvigHGHVrjdHoffyqm9Eif
	fGTo+Uj0krQjtORG4L1/Ygan0gb625d6cKZ+vD1KivXixY
X-Google-Smtp-Source: AGHT+IFWaAnhSSW8nsxLfCEosbsRw/tkQutL1OqIK5lEepaSoyu2whvGXaIfcmmuI2AXH/opMexpg40eXSqxjteyUS4=
X-Received: by 2002:a05:6902:a86:b0:e81:8305:b8d9 with SMTP id
 3f1490d57ef6-e81efdccd06mr92199276.1.1749479128789; Mon, 09 Jun 2025 07:25:28
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521025502.112030-1-ziniu.wang_1@nxp.com>
In-Reply-To: <20250521025502.112030-1-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Jun 2025 16:24:52 +0200
X-Gm-Features: AX0GCFstYtrysknkf_NKK6FH3sANBz-IA2dFPtq7J8l2XlDrZ3cHyVOBugoqvZI
Message-ID: <CAPDyKFrk3B-ZSTgEGqtfuTNa8yqcq55ueUGfoGdTLk6139Rrgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-esdhc-imx: refactor clock loopback
 selection logic
To: ziniu.wang_1@nxp.com
Cc: haibo.chen@nxp.com, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, s32@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 May 2025 at 04:53, <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> i.MX reference manual specifies that internal clock loopback should be
> used for SDR104/HS200/HS400 modes. Move ESDHC_MIX_CTRL_FBCLK_SEL
> configuration into the timing selection function to:
>
> 1. Explicitly set internal loopback path for SDR104/HS200/HS400 modes
> 2. Avoid redundant bit manipulation across multiple functions
>
> Preserve ESDHC_MIX_CTRL_FBCLK_SEL during system resume for SDIO devices
> with MMC_PM_KEEP_POWER and MMC_PM_WAKE_SDIO_IRQ flag, as the controller
> might lose register state during suspend while skipping card
> re-initialization.
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7611682f10c3..c448a53530a5 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -728,23 +728,17 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>                 writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
>                 if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>                         u32 v = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> -                       u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
> -                       if (val & SDHCI_CTRL_TUNED_CLK) {
> +                       if (val & SDHCI_CTRL_TUNED_CLK)
>                                 v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
> -                       } else {
> +                       else
>                                 v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> -                               m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> -                       }
>
> -                       if (val & SDHCI_CTRL_EXEC_TUNING) {
> +                       if (val & SDHCI_CTRL_EXEC_TUNING)
>                                 v |= ESDHC_MIX_CTRL_EXE_TUNE;
> -                               m |= ESDHC_MIX_CTRL_FBCLK_SEL;
> -                       } else {
> +                       else
>                                 v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> -                       }
>
>                         writel(v, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> -                       writel(m, host->ioaddr + ESDHC_MIX_CTRL);
>                 }
>                 return;
>         case SDHCI_TRANSFER_MODE:
> @@ -1082,7 +1076,6 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>                 ctrl &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
>                 if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
>                         ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> -                       ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
>                         writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
>                         writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>                 } else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
> @@ -1177,8 +1170,7 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
>                 "warning! RESET_ALL never complete before sending tuning command\n");
>
>         reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
> -       reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
> -                       ESDHC_MIX_CTRL_FBCLK_SEL;
> +       reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL;
>         writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
>         writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK, val),
>                host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> @@ -1432,6 +1424,15 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>                 break;
>         }
>
> +       if (timing == MMC_TIMING_UHS_SDR104 ||
> +           timing == MMC_TIMING_MMC_HS200 ||
> +           timing == MMC_TIMING_MMC_HS400)
> +               m |= ESDHC_MIX_CTRL_FBCLK_SEL;
> +       else
> +               m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> +
> +       writel(m, host->ioaddr + ESDHC_MIX_CTRL);
> +
>         esdhc_change_pinstate(host, timing);
>  }
>
> --
> 2.34.1
>
