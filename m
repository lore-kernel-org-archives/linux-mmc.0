Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368420B7E7
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041929; cv=none; b=atkHTzn9RagzuraOZh+b4PR/OoBm9YfgLVPUpgk1ecaaOP8LOAkj2YedNFrdrho6/jD1FAc66OR9jX6OcivcviXI1d8bOvH7fZ18em4wmQh+h2AIL0M+jr4Y3HFR7CcY1dAcC9KSh9i8paphKeMeviifkZ5aV2ndsLAxSAqWdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041929; c=relaxed/simple;
	bh=xrTzkc7YdxcC+6FYZPlkBFv3OzxHgu7qRTtdTCjrXOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCRPGyO5/1q+2oKKxKv2qq00Aa2WZOm0SXPTITsVGb5gWixj401EKGecwvkxc2buVFD3euId+xM9VNoOo/zmw4NyT0j2Bh4uGdx7+8oSwAuyZ6v1m3eYtq3NrRAuW6z/SVhAxuF0wsCPTdKVV3TSjIPPhIOvbr/Co3m0dJIhSVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KZ2gx/hw; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZ2gx/hw"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fead015247so40607577b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2025 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744041927; x=1744646727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLRj1sR6XZayxwe9+ZhgcF90lKSx3ALzl5aR/HdVwNQ=;
        b=KZ2gx/hwN3qkD87K+3s8GN7i0MJqAUoMCsVNtAsAr2cXGd8tbSOESlM7+NkebnZQ3A
         fJPhXec0dzcvqXG8KzLCJvQJ99qwpYVZKDtDWn88GmKZ5Zmg7XJA6/O4u3eLYYN5k0+I
         sinTiofuRgWrBCelpBcVDe5yyhIfgNlbO3YH+NSUgRJtg2ImvfM+ItIsAyqN+xMXP7l2
         StgUeOqUxKuEDO0oGQQuLYa8WkU4XvrGq2VmsqJwhTvtbzYJTt2uIkwHyI6KwwTVlp0N
         gZ4WRmqT8G3cXii4QRjyShX1Fw42A93Q40sCAwRWuKR23yyojpdy+uXruZNqAPhkzojU
         emFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041927; x=1744646727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLRj1sR6XZayxwe9+ZhgcF90lKSx3ALzl5aR/HdVwNQ=;
        b=uWrLKbGPXBG/YVjc4TdtO93mCP7WZl/4rHFdQwEepEt7RPe4g/FWRmu8bRVX8bYE8s
         h2TRj5ho+j4q6FZGLmp8zMtGlF6NQlMIaNsOuHdcdFVTfBXt+0Fz0X8TIJ+YZ9zSNfEn
         BouOlZ2LQfeo69TD9t1CgYC8tLw3dG+O13pPwnLUs9HJ/BJ43wCakquaskjfFGnWow0v
         xYhvH1Ckp34Mgx0j0SyGAFmGIUCW+Zxpg03IxmybQOnR3AwxmZ8et6d5blDJJRGo+h0Z
         AutJhi0/QKo7xZpwy1F6rrSwYdqmx21Tv3To+AdXUuSsOMgxAuccVdKERlWqmsrbI5uB
         YLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVInQ44hTsrbUbzLJFTh29KBJFXlVQAG2KnvmyXsWhYmPaMtkmU6QSK8caZLwSa0PZZytJo6EbGhto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR05PycA2UAUwgLoPuKeklWQn2DDuJchQZSPM8s0qd6tMvXrQ6
	vzqUBCT9hIKTGrrDp0+9kY89Fcbkr9KSBthZm7ObjYGpinv5FdVt4I+LpWgiHPlyksO4NCHRG/l
	iJPHyaqlJW4dvLQRf4ChS9gAevIPUMxdwJTyKjw==
X-Gm-Gg: ASbGncvDLPatRDJoF8WkLM4m4iyJZsiz2tt55rZV9Ywm8nN/0R/LWsroTEPZzrPAXA+
	R5RmqpkYFfbtvWDxZWBimNYt3nLe1Bs/FZHTv0ayprL9qr6YbdqNUf1hRCX+h0og6cyN+aVyoxR
	U9NvjE4Z6IK8cx89kmyKqxzIfGpcA=
X-Google-Smtp-Source: AGHT+IGs9MJHAtcyu6zJo6IuqlKW0/r4nwiirsWiWEsDSZ9AYWO1k7oxhb6Zl8qgsQIsxC3tDiFhKxf9oSk0D+xMkuA=
X-Received: by 2002:a05:690c:6707:b0:6f9:7d7d:a725 with SMTP id
 00721157ae682-703e162980fmr230644897b3.33.1744041927155; Mon, 07 Apr 2025
 09:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329164145.3194284-1-arnd@kernel.org>
In-Reply-To: <20250329164145.3194284-1-arnd@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Apr 2025 18:04:51 +0200
X-Gm-Features: ATxdqUEcQlE855_cKO5w4MhJh52G9cKHEC6Ko0duh0ZSHBzqQdxU_lvLAM7zM0g
Message-ID: <CAPDyKFqgL28W+u2OCnaLSdOakkyH6sn-a_qkf0jmuU9NXGb1cA@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: renesas_sdhi: add regulator dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Arnd Bergmann <arnd@arndb.de>, 
	Adrian Hunter <adrian.hunter@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 29 Mar 2025 at 17:41, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The driver started using the regulator subsystem and fails to build without
> a dependeny on CONFIG_REGULATOR:
>
> ERROR: modpost: "rdev_get_drvdata" [drivers/mmc/host/renesas_sdhi_core.ko] undefined!
> ERROR: modpost: "devm_regulator_register" [drivers/mmc/host/renesas_sdhi_core.ko] undefined!
>
> The 'select RESET_CONTROLLER' needs to either go away or get changed to a dependency
> in order to avoid Kconfig dependency loops here. It also turns out the the superh
> version needs neither RESET_CONTROLLER nor REGULATOR, and this works because
> CONFIG_OF is not set there.
>
> Change both to a 'depends on', but add '|| OF' for the superh case.
>
> Fixes: fae80a99dc03 ("mmc: renesas_sdhi: Add support for RZ/G3E SoC")
> Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for fixes and by fixing the typo pointed out by Geert, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index c3a9e856053b..c9e067b5ba94 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -694,8 +694,8 @@ config MMC_TMIO_CORE
>  config MMC_SDHI
>         tristate "Renesas SDHI SD/SDIO controller support"
>         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> +       depends on (RESET_CONTROLLER && REGULATOR) || !OF
>         select MMC_TMIO_CORE
> -       select RESET_CONTROLLER if ARCH_RENESAS
>         help
>           This provides support for the SDHI SD/SDIO controller found in
>           Renesas SuperH, ARM and ARM64 based SoCs
> --
> 2.39.5
>
