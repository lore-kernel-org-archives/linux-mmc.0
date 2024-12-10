Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551FD1AF0D8
	for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847019; cv=none; b=qidVnZsx8M+2SPh1vFngE/0FWPL3t7pgmHfRMK3hbRI+sqZTF6GWde3+I//BV3o14gF/J5MhcprIWowx7pJvLrU4eRysKIWcXqUT2BwrQf/p+5WxfDCvXbwqf4GmBB4CeijBmCg5AF0nmSFUbtmA0gzVTWQEmFFblBMZc6VygO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847019; c=relaxed/simple;
	bh=BbxjbBE9EY/vTzfnxGy/h8oVMvXpnYp8R9PBrp8qVko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDqQo7h9va3sXVIvNKKycYoorRYpCKCBDcjdQg+KBbt9Ia7fyT2Xx0iHa85k5BqE+ZjJFJCtfjCwmpN9vjwJr+rOGOGyXiT9xGhDjTlvRAy0ldvJKnjSZbMmY+mpqX7nzIZEW9Wc0ngdKH88079U67Z/8QoPLJPE+vcnXMHTh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FraOQ7la; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FraOQ7la"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3983426f80so4497975276.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 08:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733847016; x=1734451816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cxEsjJZdgUz/mL0/yG8G0yeVvzImsKQynZFt9bIQYPM=;
        b=FraOQ7laT/TqYRDWq59VNLs0tldsdbBMXjb7Z0zqiBAggjFavwBgbc+Z/pPAqIsi7A
         RaQGZN49rIqoqAW53pcuW07d9R1Z5+xRKzDWIXWU54d39l0a2quJu8gqbTbzIpNM9hD3
         HGabXji93PLhoIlkSTBq26L/rFchiAMQ2KvGqYcef1+oT2ULi0fbaTyTS0Q2AeRIuU+e
         +bSyPv4KvY5yhxXhlG0TQy01W/VpKqnSl1DRUWr3DOjBdU8yK4UaLXIb7H/IGdpuTCnz
         Xhzc0sAja/VmZPPYVaZHScD58LUTAonLFJ91GbwKtTPBcq8KzK2up9rMoW3pAsrXjXPx
         Rz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847016; x=1734451816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxEsjJZdgUz/mL0/yG8G0yeVvzImsKQynZFt9bIQYPM=;
        b=DKgZjFxLbtljiQSRaQDexJ/zAFxXIcPqIm5MA9/e9UOGvK/O6LLbuyocBUdT1aVt7Z
         1qLIjCE1Ib8NnB6bJWc5BMPRrFaxCiYPPIwUUR7ARrxdzg43XM8cg0SuiSCeP/Lpdmx6
         1L1PhSc00QHbvlxXTiU5LXY856LeB10hX768J4hkIIiNTJvbOaMzhpaouV1518oJQURU
         jFmOPzYiHfmHpV2j1iu5yLAJLec76mkFpKGU/WBDXYI+O9Kp2WB8Mys+PnxeFMbIzJQ4
         qZp17Gy2YXRo8938hbx0ul5slriDb6m6cLL3ZqlfxRXm/7CuOmeaqQ79p3NRqk2gQKf8
         8qkw==
X-Forwarded-Encrypted: i=1; AJvYcCXUPGRE+soe973b4aJ2S8OQazMvtyskxHBH+zpjjtxRGtoH50peTgUjZn/jRbpJ42kSCdkpXwdddmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3kymzHHsVX+PoQYeDNcFXc2MORtf2H9NzlMEo+3MS4yQdsEZ
	qNphT7PCjWucoAPGe3M+9FdAI7/z5kiY2O2XPSYGNoS5iheyLK94YqRShpWz7FyiHq41ujjaorZ
	CHw9hnuSZuBJuuJ8Mw3Sp/dQnDOBEioXPyn4FgQ==
X-Gm-Gg: ASbGncuKa3LJHhmJ6W7AvWj6ljiAlEWmm2I1vAdPP/im8xPvIRoiREKDftqJTOmUMu5
	UdGolinoS+9B+2AdUuAi0p+givx2bqQhcDd+U
X-Google-Smtp-Source: AGHT+IFNDYQwgGxPY21TM51+IaEJVIKNukjD//zZqKizVHjoXfP5g2KINmrq5zBjn12o/Cd1twqkaondPOWReLN4iBs=
X-Received: by 2002:a05:6902:240b:b0:e39:9b9f:7f87 with SMTP id
 3f1490d57ef6-e3a59b27141mr4893458276.29.1733847016550; Tue, 10 Dec 2024
 08:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209101009.22710-1-pshete@nvidia.com>
In-Reply-To: <20241209101009.22710-1-pshete@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Dec 2024 17:09:40 +0100
Message-ID: <CAPDyKFpmTs7ZqK0ZCDB6tuaUi6gXdTxOkidVpAz8JpgWO4SK3Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-tegra: Remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
 quirk
To: Prathamesh Shete <pshete@nvidia.com>
Cc: adrian.hunter@intel.com, thierry.reding@gmail.com, jonathanh@nvidia.com, 
	linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, anrao@nvidia.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 11:10, Prathamesh Shete <pshete@nvidia.com> wrote:
>
> Value 0 in ADMA length decsriptor is interpretated as 65536 on new Tegra
> chips, remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk to make sure
> max ADMA2 length is 65536
>
> Fixes: 4346b7c7941d ("mmc: tegra: Add Tegra186 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 1ad0a6b3a2eb..7b6b82bec855 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1525,7 +1525,6 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>         .quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>                   SDHCI_QUIRK_SINGLE_POWER_WRITE |
>                   SDHCI_QUIRK_NO_HISPD_BIT |
> -                 SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>                   SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>         .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>                    SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
> --
> 2.17.1
>
