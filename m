Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327193CE497
	for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604216; cv=pass; b=gtbB4gfXPEZr+fHcf9jiWzDThGj5Cgf4aUa1BtIEhX0XbB+1grjSl0EaPMwbqlmfMcPTeoDcBZC0Fs8YJQc0e7lXH1x2DxfGzBSD+rxsxGaG3j5NZbeX+plUrHp9jT4IRcnZcyrnkh7mIS2kJWbWoWzKmeOZ1phJ2V9JEmvVnrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604216; c=relaxed/simple;
	bh=8Jaamk/JUprispzc5CuGrhCZ1Vvmop6kJ+uQ9arHFqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Db8QBlFT69h7H0eFlCB99p+9Y5oz44dZ4kTn+LjHwbMYh3HNrxa9fRynfeibM3XRF2CHWZIBvdlKSaZ1JQ2P0TGQbKOJCqROBcsXOwWA7BKmOXWbWwkfW3yAfKz9Hwtj3oL95siXaGQPwgf/Px0cHKzIh/+WRlXe4YrXeByIuXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tWcTCA0E; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWcTCA0E"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38c551f2497so16811981fa.2
        for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 02:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774604212; cv=none;
        d=google.com; s=arc-20240605;
        b=aw4UJfjW/5BxC75cswWZ8iuPX9z4xvtdSn2fi9ZKygyPNXg/mQH/EVurHIuC0T8YhE
         HWioOozINBI4ObVipAuxIvEUNYL1wMtnAjc+FGnzJLzIrAxTIR5iApYSDPIkzMdfGM1w
         kNAEcuczo6GgsarYXZTlLnIB3/Yw2diB/wE+kr3zLX5NLdN2uOhbBhpJC/a0iGEvFHPs
         U1SN5/5pnfvcEMhLsHmQS9zWMvdZ9bQ63uboBVn/x3MIxcFcN0AJs0RrBTlrRCIlBARZ
         pmVvbhNZYKx+XNw6PLNlucujdeu3F6AJG9y1hiBGQBTuzKl3HmCAjf1WnvtQvY3uT46l
         XX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XOZEOcfpw3m9rcu3ZVGKiqfOqODaKLVWBUZGiHWTa+o=;
        fh=F09gXjuBfAinjRGqtSdI7PBlpEv7aCugp05ZKB1d0tc=;
        b=EP/suS7uCBtNJs/y/Vj9uY7L78D6bkCGUYoGVc2vG4RAaSmbEdU5zuRleepgmLbHL9
         kTinFGAX2wcGAmtJX6pmiTAv1Nr0CM2nVWv/7feYscd38ZqwcO13qOxhXKJiilxM5Urv
         P/C06e+vGY64+NVIRY6sv+2P+ORxIJnv8fcjvQsiXTpoNwJrC0twVwCUd6lKb/SzZLgQ
         ZnjaiNrwddtKJca8Fz0lFIJADa1vnyNGFAl58MGnd+rNNwsbtNgOezjtsKXjZpfTLk90
         vz8NC8ukTepP370eswtdjQOBuIxGMFluBZEwwp2pU57TQHzfCJq009rUO8A5dGPTdK2z
         kE4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774604212; x=1775209012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XOZEOcfpw3m9rcu3ZVGKiqfOqODaKLVWBUZGiHWTa+o=;
        b=tWcTCA0E2ScScujkN21oQHgJ8Phs9+z0EBx5bsgOxCvizhJgCdO2kMIRGC7EgKQ7A0
         ze58nSV5qnM5c8mNrRJZXLEF+oKKqkbYmgEoOIT9yt6QeMshcAh5xkRKI4sETuKTS5+5
         lYIyiU+9lFRuxaMgOP4JkGK5Dqw1QyU4WJd28DY2+wC4buV3AqANqVY3CJygdUA4mFwL
         vV31ZCA00u3tdjiX9Ep1oBf3X5zrVcYA011Vhvs0x3dg2q2c6rQpqiZMq3j1z42yU975
         2uxu1dK56atQcw3pAFKZZkPBqnwvIU5e87uA+64lGAotqQB4MzCC/9sxpmNBzEIHiBe8
         V/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774604212; x=1775209012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOZEOcfpw3m9rcu3ZVGKiqfOqODaKLVWBUZGiHWTa+o=;
        b=MfYHk/gMT4aJ9TN6PRvtYl4ytBNAYo/+qv/2Cm9BHT3jAD5Eao8SnAM1UwnDOEgZup
         IY9ZLzF1fk959cINCP9EwtUdpvO/ZlyoJbJsZIvGcsAXLxmhduUmZ9ynLrblsr3blWYa
         V8mPR/PEofFe8Ii/InLe5XhvWqgcQRCs0jiJn/kFYchRF6YY+iJexsRs4/rny3MEg5ij
         V8i4A6U+EyeghVH0bWZVjwJw/ipVbSNf/FDSPKsarW7HbleZBXeRjFZpGr/9F+aypnQ6
         RTwG04oTp+H2edMxSSGYB696J/jtYorJwy+iFpAT/+f1ZxNPE2AKnotr3X4JS+m34PG8
         8lsQ==
X-Gm-Message-State: AOJu0YzuCdFOj2z9VX3BpfpbykS7RgXzo8WuIjbmSXwFUSM+HlQCRF2S
	0XnpM8DCIZGdMKWEff49/cIhiY1rDNA66A3d+KJovEjPSlwOZtA5R2XqPyNSXxjWMM/0vzOT+ts
	oN8A12FdD1GKftRNz+fiU9qyrS0CRvcUeHNrlRZZWJQ==
X-Gm-Gg: ATEYQzy/VWksMxPSvUcxqPReOct3gYaiOMp7/lR4+9IJKeAjOJjgJB54XSg4pDDANJ5
	AtMjCTweZe/3SboBPF12th8mqkIC7H8k7pB0czAx0Xg000XvZf1MglqO39BwfQ+JszyUPJTnw0P
	/A22gi+uDGknc25iXqgMqc7ZaKuYzZOO9fTfnHE7P/MIaLJpMu0vvSxVKLwDEFgY+nErJIm/RoV
	HPTQDRpGzQHeFHgM+ZcbIvoxDnegywgykRcz/3JP1M+Ld66f+mrSNtoIRebTQ1rqcva2mbLXNvq
	FiRRfVGD
X-Received: by 2002:a05:6512:3d0f:b0:5a1:17db:aaea with SMTP id
 2adb3069b0e04-5a2ab920f8amr779072e87.24.1774604212257; Fri, 27 Mar 2026
 02:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1774584449-130249-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1774584449-130249-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 27 Mar 2026 10:36:15 +0100
X-Gm-Features: AQROBzB1dmTFH38ZaZPyemv2mYtRf2Yklh9o8CclVKnpHd23PpuWwngo-Pgwxak
Message-ID: <CAPDyKFpgnpFj4ZQ_wmRGQ1Eu+6ngfNs+cw=iEiwozrEbqsV5PQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove legacy 'enable-sdio-wakeup' DT property support
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 05:07, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> The 'enable-sdio-wakeup' device tree property was marked as legacy and
> superseded by the standard 'wakeup-source' property in commit 71a0151c5c82
> ("Documentation: devicetree: fix reference to legacy wakeup properties")
> back in 2015.
>
> Since it has been a decade and the migration to the standard property
> has long been completed, remove this obsolete legacy support.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/core/host.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index a457c88..4e1514b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -379,8 +379,7 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND;
>         if (device_property_read_bool(dev, "keep-power-in-suspend"))
>                 host->pm_caps |= MMC_PM_KEEP_POWER;
> -       if (device_property_read_bool(dev, "wakeup-source") ||
> -           device_property_read_bool(dev, "enable-sdio-wakeup")) /* legacy */
> +       if (device_property_read_bool(dev, "wakeup-source"))
>                 host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>         if (device_property_read_bool(dev, "mmc-ddr-3_3v"))
>                 host->caps |= MMC_CAP_3_3V_DDR;
> --
> 2.7.4
>
