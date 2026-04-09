Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7EC313523
	for <linux-mmc@vger.kernel.org>; Thu,  9 Apr 2026 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750027; cv=pass; b=HftnSIqzzV28yTnIqhbzPeVqf5TYlWW8CwR+Njyd2Z2Z1cLPcbEca+c/UIL/FVprD1rjP6Wa4xNe2+JRBwsEIJx2dNDYDhLUcHrHhjFBgaJ/eYMG0MvWfds+u4St7cSSykeKXhiw9wuq/EKgS1eZuu2X8Dd9KxHVf8dRONe302s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750027; c=relaxed/simple;
	bh=wk+hqJ0iUTT+wwqkPfh8Q7mvsmKh/oz7GCJX6dFdqD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0EHUgu9tdSDQwqKq3jJ4ytBV9oU4hepZhf/4TAOS1XNm6lCOGILV0UJ1jXREulN6vk8pYSaezL0hexfpHK6OFnmi0kFt0fAlCUFJoGMA/f1uTAxn1uiBMazgFEzM4InlliUlqSR+RUmD+ut++37YeoaBuGzV7A1vSuUBmBkCTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M6PdEhvo; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6PdEhvo"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a3d1561e38so882834e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 08:53:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775750024; cv=none;
        d=google.com; s=arc-20240605;
        b=aGat9mz4cF+Sz6s5/WL5CX4RsxMvSsq/eEB/c5vkvnbLvYFDEvc0MFBAix9/lYPHFA
         gEwqPzzSpi4YthaWikuSQwrs5dQvGthH+Regd9fK509rtFcpVp5PAGWnSfWmjzlsfAfN
         w0sisCT9bHfDk1VmYw4VnIY0XfW0CzS3cjZUkDCl9cBP/Tszuq7qLCGSa3D/DpYNZGH+
         SphpomSB2R/NjE/Tv9xitvHDzniaFiXTux2N32lN8PGx6DBZcY/hcmVuZ9CF9jYwcHDX
         20re6DhRzwQ+x3aHo3H5Remsyoa5QlzL0hWX1SJSooKDZYYtE8MFpEYWE4UbjlnEDuyU
         vgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dv4qdWsse2g6Hs6kPBq8xuq0aEEIapLlZcENiVgDIrA=;
        fh=XUTH3/pakn0EbziEwKPiNj3dOek/KFAb2cz/QfFMQQ8=;
        b=WDE8YS0ySlPmGhCluaP6Bp9O24HPWX8r0fomKZvodOMb2ASOsyzvb2cmxwYvGVlj2P
         I7kqnPrdBANDPrvTe3991NeFYV0uLG3fz8/xESGfB3/3O1PRr+IvQAg1J+V6X5pYSJxC
         iqhAaXIVyIAhzX4GcrQpdkXDgwTMw31Qul5Yiyg8mLcZtfD5rl8ctXOGW3UXFI1MEM/P
         u8MMqv84hyqtsIm5uxaf3Y8KMTbpJDS7xTqvc58tJwLFPzchnxCwPfnLc7SKn+GzRvRa
         eq33Ed91DOcEgPfJChSjLVCzJuezlrVtQOivh/UYb5WBOEnmOhBhTUVanyI2gSUNmNnR
         SZxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775750024; x=1776354824; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv4qdWsse2g6Hs6kPBq8xuq0aEEIapLlZcENiVgDIrA=;
        b=M6PdEhvo4f8MXyR+Pv4ed9jICMJFpxnHbhAWH7PosHK/C35QLr+4syZfBWvGw9Z3bO
         Glt+1sHAOASw5U6YMoOwoea7pLb9WqYAdlcy8z9yrvNYXY7JAi7OK5jm4o74zWo4sR/A
         WP12HiuCt63nrl1pfPBcuAAL8poTOhum6OvZrDPj6xxWO3/VPbBlm4iX7yMvvBC6g3f8
         axBjPpqQkEqvNBnvgEf8C08CtVyuqf31ZuA4xJNuogvc7nHeuQZ1nKBL529xLzk25UaT
         8+KQloLUU5l/IiNOcr4qq1jnDxl6H4O+tWVhQ74N18OMiOm7YiOgvLhbQL5zJAi1Jv3n
         OxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775750024; x=1776354824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dv4qdWsse2g6Hs6kPBq8xuq0aEEIapLlZcENiVgDIrA=;
        b=XVlIlDVbvz9E2IP05yrVWgDOB9tpzKURmz2ACacJj1fau46E09TxynXtrmnJFgjtFN
         D8anF+SroQg2oI/Yzdw6pzZpdkWXjh0TGn9dsHJjSHnaEYIThrtPQHC5JMD+YszCOjTJ
         bcGN1tYYiOJBa3dFWJCEKVuZentoG9xTXhpw1jLS0D25ffhQA2QmEWePThvkyRlXCMtz
         mfV9OeASTNuHriV/sK83N+3CWBTgEbKgRhzEprt+LAlPjIQhvxvARxe1TxOc2JzwNnv+
         vDmMGF19hm9FZWbhtwqT3X1UR3JeDureGJ50rEIOLCYJpYo5f8/f1kFRcVmBN29yJZJE
         o9dw==
X-Gm-Message-State: AOJu0Yz7/C3U+w/LfSaQMHAXhRIw5iSqos9Jxv2yrtA30FfOWiSphOA2
	pcGLqtz7quoCiPgJVj5xiOcx1mgzhAKokMiqg/Im57dk82yO7VdCSOjQaVP1uEdFfsVspjGz5W1
	WJdse9TuimXyurmGjI/iJMUHMc80aiumZj3yAROQgrw==
X-Gm-Gg: AeBDiev1GhUfVPoh1UU1+XxJWBXVj7EJqNoD990YfPDu/l49CeuRtlutIgoZDpZD2RU
	4U65SLeeQiKnHXN51yPfK4eAcpylZbDACWh6yq8IfmS439GsBupRlNaxElWpBTGsdPw18cS78eh
	1VUUdBtKeCQnSaYBeHv+Lyto/6wZxvKf4NukiT0OR4XlhTgNygv8vYuevu9ljYXKCvLR4x02mp4
	tC3sbMfPrhOXIaH6aS+0N4dzSvXKJC58Zg8cAJMYpJT1T0rR+yQzWMOIlHQzyGOo+akcYKP9b0E
	J5gBOzJH
X-Received: by 2002:a05:6512:3b20:b0:5a1:381b:fae1 with SMTP id
 2adb3069b0e04-5a33755cd01mr8745197e87.10.1775750023584; Thu, 09 Apr 2026
 08:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1775632729-22841-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1775632729-22841-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 9 Apr 2026 17:53:07 +0200
X-Gm-Features: AQROBzDtN6BuSpifx1kELMTA0xEfm1HADbBZ4h8KffOIIm2mDqIQjdmC0mk4g-w
Message-ID: <CAPDyKFobhyGx6yCX6GEA5sCxXnsaB4_5JQN-K6wghOXU=Q502w@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-dwcmshc: Disable clock before DLL configuration
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Apr 2026 at 09:19, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> According to the ASIC design recommendations, the clock must be
> disabled before operating the DLL to prevent glitches that could
> affect the internal digital logic. In extreme cases, failing to
> do so may cause the controller to malfunction completely.
>
> Adds a step to disable the clock before DLL configuration and
> re-enables it at the end.
>
> Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform support")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

It's getting too late for fixes (unless we get an rc8), so I decided
to apply this for next instead, thanks!

Kind regards
Uffe


> ---
>
> Changes in v3:
> - Fix compile error while amending the patch file by mistake
> - Add Adrian's tag
>
> Changes in v2:
> - Add a comment about why passing zero to sdhci_enable_clk()
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 6139516..0b2158a 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -783,12 +783,15 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>         extra |= BIT(4);
>         sdhci_writel(host, extra, reg);
>
> +       /* Disable clock while config DLL */
> +       sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
>         if (clock <= 52000000) {
>                 if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
>                     host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>                         dev_err(mmc_dev(host->mmc),
>                                 "Can't reduce the clock below 52MHz in HS200/HS400 mode");
> -                       return;
> +                       goto enable_clk;
>                 }
>
>                 /*
> @@ -808,7 +811,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>                         DLL_STRBIN_DELAY_NUM_SEL |
>                         DLL_STRBIN_DELAY_NUM_DEFAULT << DLL_STRBIN_DELAY_NUM_OFFSET;
>                 sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
> -               return;
> +               goto enable_clk;
>         }
>
>         /* Reset DLL */
> @@ -835,7 +838,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>                                  500 * USEC_PER_MSEC);
>         if (err) {
>                 dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
> -               return;
> +               goto enable_clk;
>         }
>
>         extra = 0x1 << 16 | /* tune clock stop en */
> @@ -868,6 +871,16 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>                 DLL_STRBIN_TAPNUM_DEFAULT |
>                 DLL_STRBIN_TAPNUM_FROM_SW;
>         sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
> +
> +enable_clk:
> +       /*
> +        * The sdclk frequency select bits in SDHCI_CLOCK_CONTROL are not functional
> +        * on Rockchip's SDHCI implementation. Instead, the clock frequency is fully
> +        * controlled via external clk provider by calling clk_set_rate(). Consequently,
> +        * passing 0 to sdhci_enable_clk() only re-enables the already-configured clock,
> +        * which matches the hardware's actual behavior.
> +        */
> +       sdhci_enable_clk(host, 0);
>  }
>
>  static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
> --
> 2.7.4
>
