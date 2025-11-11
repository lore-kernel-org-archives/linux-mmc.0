Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311F36C5BA
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880167; cv=none; b=O9uL8idN7hJXUeV0Ck1BVaE+powyaAaSiTYRs5MZDERUVqAGJJ8/OY5CREE2fbzh0w/4h8Kmu5onc/elZXtOD20vT3DDm0jejlwdlGu9AfxkLW1z7Ppoq4kZWKgoVCAgzO92LOwvagnQEtQq+a6SCoi/rvIbayO6PJIOrcH3R5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880167; c=relaxed/simple;
	bh=oDf2wJ5rd4DY8q4v8q8pvYH3GLI21z5lS3z0W2kYbbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxoRQaLVCZCwn8abE/PciOARxVA7JrFmJUQyZIn3JJ287cSmDvB/lUH3Arjp5CbuAvp4sYXWERnbq7/kmIktW+f0hu0HlWBHxcHlNRtAWjbDGANNEfUyswYT2iW7M9dz1WJv4NeBlxtYz6PFIyNny5WOCwb2w+iPX0CWLUz5EnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJtLGn05; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJtLGn05"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-640d790d444so2358825d50.0
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762880164; x=1763484964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/lkozkdwY8SKpZI3ECZUvG3SVnMfa32+h2Cja3WdtpQ=;
        b=VJtLGn05qZhDZVeYA8GVwiSku1TNrv6RqAOyqqYohAG3tcBEaCwMMmXqrMu58D1uAW
         29xi+bMl9IluyfNrfmAOM/qmAHxCS3Pd2F15yPLZ2b3Kyj3iBLkQAn50cEA/MPcRoQhf
         XJTpD0IlrO0S0ic37Mq4kKtD9/rIndpGllsqNUQyn0RhetHWWIzRGxvIagi+vz2meXaK
         nP2FXMLnKwG+zlmGhTDZgEHCSineiwK5WILUbVnJzQXcx6aJJvrJgbXJmrfU7x7OuPb+
         zsPjQpG7dXn3ueItW+tR3+kH/RSIkDfp0gw/tFpo+IoaawIxoutj9zZlZgIpfsSjWfry
         r/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762880164; x=1763484964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lkozkdwY8SKpZI3ECZUvG3SVnMfa32+h2Cja3WdtpQ=;
        b=IjemZBgPgPtKFAZQzNMXNBLGvkRvrrJl1Wf4WlPYZ2mn9F8HvcGPyF9LpzL8gSFRVL
         BVEahWjISykiAG0BF+dniXZ/MXqQHImIYyDixKPmnmAbNgHqAKg6HhHzk0gueoL8QQpX
         DN2xddpx0v/sTCf/imb3J6eRnRWbzk6vJ/0fsqFEvXlvg4BwFlEsxYCijDQjD3D0rySJ
         mosEgzqn9o4Bx+/eh1WKLrb/+KRSM4i3rFlgAt+D8xY+K41+88YYeEycjDJRGmhy2xir
         wUoAQPPyo1KvYS/Zl1SJcr4XlJlXSBuexuiv+a7cT0G8LbdbuBunFwuxrln1SXxH3j8A
         gQrA==
X-Forwarded-Encrypted: i=1; AJvYcCVoU6xYnnC1GSdCbA56BI0vuZ+qFfIv9pVcolYY9NW4xXlzJyVmqLKdlnZMBySxyZk1PVTvM9VoxsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9uWvalRFUgyLaD3RdfACR1IvRQhSiVi6ZC5vGyyxEktj4zLyV
	kmxcFqIQVo+tIHkpy8Va6MIQt9EkwXsRWAj7eAP0gSzyyPUJM7IN+m1hMDENXLRKjqxa+4avkWo
	0pSWwITvog+bCOiWKAlcFxNG7fWNvV8/CJx7/psIl4w==
X-Gm-Gg: ASbGncuDRCQWF/hjkbUkwTD/gbGRinqoLpdaSJtQpTFAGqL3eCYfIM3LZdb1lMzpxub
	96BkRMkhsozh8HF7I5iSRxDhMtSVU5BwVk0vRie+c0JVvHo8rUR6L6aVFdXJZ4snuQnbG0iNdJB
	x0SZ1HNVphe6C415bDeuIfsFuHJ/7aHjRtDJbUeYkcZ1eNhhSJA8qIycjBoPN3U2Wg3zSKblnKr
	Vw/4ocQzUd5PWN2Lwt5mRR8ZOxWQpkFQQY1ml9yJBUMintWLRTIULTLZOeuW8DevqFzSvK8
X-Google-Smtp-Source: AGHT+IGvRCqd/OL63Rxlm4IFMcnUphHaaf/QtJsk/lkAsXIwq8+zXIkVaSNcI+uL08VDy46A0CBrAaEYCoBDes3EquU=
X-Received: by 2002:a05:690c:9b06:b0:786:4fd5:e5de with SMTP id
 00721157ae682-787d54753b0mr125132587b3.67.1762880163893; Tue, 11 Nov 2025
 08:56:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1762242094-55346-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1762242094-55346-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 17:55:26 +0100
X-Gm-Features: AWmQ_blPfWvVh-ptTSUET-1YXEua6fSi2bYi9nD74s6XK49CzD93AdBqSoGJklY
Message-ID: <CAPDyKFpLp--cn4T3ifL8zB=GqptHZtnRH+V8Z370LNsj7n3wNA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Add memory clock auto-gating support
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 08:41, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Per design recommendations, the memory clock can be gated when there
> is no in-flight transfer, which helps save power. This feature is
> introduced alongside internal phase support, and this patch enables it.

Just to make sure, does this work if the controller is used for SDIO
and has SDIO irqs enabled?

Or perhaps that is taken care of in dw_mci_prepare_sdio_irq()?

>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/dw_mmc-rockchip.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 6813549..62c68cd 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -19,6 +19,8 @@
>  #define RK3288_CLKGEN_DIV              2
>  #define SDMMC_TIMING_CON0              0x130
>  #define SDMMC_TIMING_CON1              0x134
> +#define SDMMC_MISC_CON                 0x138
> +#define MEM_CLK_AUTOGATE_ENABLE                BIT(5)
>  #define ROCKCHIP_MMC_DELAY_SEL         BIT(10)
>  #define ROCKCHIP_MMC_DEGREE_MASK       0x3
>  #define ROCKCHIP_MMC_DEGREE_OFFSET     1
> @@ -470,6 +472,7 @@ static int dw_mci_rk3576_parse_dt(struct dw_mci *host)
>
>  static int dw_mci_rockchip_init(struct dw_mci *host)
>  {
> +       struct dw_mci_rockchip_priv_data *priv = host->priv;
>         int ret, i;
>
>         /* It is slot 8 on Rockchip SoCs */
> @@ -494,6 +497,9 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>                         dev_warn(host->dev, "no valid minimum freq: %d\n", ret);
>         }
>
> +       if (priv->internal_phase)
> +               mci_writel(host, MISC_CON, MEM_CLK_AUTOGATE_ENABLE);
> +
>         return 0;
>  }
>
> --
> 2.7.4
>
