Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D33570D2
	for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707880; cv=none; b=ciYzn+JbO7b5VVzpq3Gi6O974oS9E1T/mRt1MnrpyazLhSmnzOrmMbXfsbkag5CW1fdc2iQyZYG/nfoQnrcP1Vi3s068Oyhc2xaMnPPjfntRdbA9l+F77c1jA4kKkd403fScN40nELimgAMKGzCp+UlLmTmHNQtaLNMOw4JFiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707880; c=relaxed/simple;
	bh=9J3gYQc0b7N83X4ObbdhI51mWDQfnawAW2aJ6+zSLLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7P9bK/977963qUw+e8odH8/n4st7XeOwdtcmDj2hliBcOvGBWsu2G9wHW0a3NBdD+62JSG7JqR4UgbdJS6rRQSdi1EOku5BJdg955H9yt2FbLrnCx2B7++RpIoHruozbnsmn3MPUS45aP42sNg4cEK9tUpzwWt1J12M1Egiemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SA02Nfsw; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SA02Nfsw"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7817c2d909cso21465537b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707877; x=1761312677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2BAJwgG2rchT5766h6wzsoqRB39jvTToguWS8dkekE=;
        b=SA02NfswANxqN5SHinNzq0BGAxKnuOy9Z4VXioXpuI0Nt1cb6bLuwPtpSWcEHHLFPg
         rAWDW0Wwop/UiDg9pDlXIQAmW2Wl/d6sa0E9v4ElENlguII8JS/GndgMJx9GE/4fYO5g
         BwR92f8Vb55sjZDO6SKiPQFQhugcYkM3gorhqInyGKIItj5p8AB1KOSMgRwfW7iAeMMH
         VY+MnZEBp35PnNRm+S65dD3mk1YCrmAe8Li/nfowqm2fsv73TpMFyd5xF7XCi8Pc38HX
         oq4Udr/+Mhe5cY7eKVoawCb8IjE0scPUNLrLHAYsb0W/1cMHVeyVWjiVzRLo8fAdrtqK
         4BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707877; x=1761312677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2BAJwgG2rchT5766h6wzsoqRB39jvTToguWS8dkekE=;
        b=kvaAmF3Ccfix/d4ezOp3ZUQPdzk0t9TpRspGca62WGlWhPFHPn02V5SIwbx63Tn4F6
         7pDYoFEdvWZNjmu7LhTIWnXdfNX8oiAoj/D/OmuFx5nSXp1/JcqNXxzlHWb6ipfG8c07
         pwaKUumPPoqF1se+ANmcDwEAI+f+wSyi5maeRVXQvtJF4q/XnRv8xSWMDsxsU1x3JSZw
         XbB5a22+Mm+zE5n1wTAOpLGFYMcBz9Q7XDO7mdv9kfsHYwVbLJXzRzHbpYOsxjsPAA0l
         7XjY4eSWx/IAgUhAln+VaXY1UdOE9s9qoJJl6KZj/NUCdVjEqjCJdHGaYEdLP75UGEqj
         sEPA==
X-Gm-Message-State: AOJu0YyeAepyHtVhTyKkOtPu048fZacL50KTtarWDFqQTKAAuYtnBg/C
	PipFOnLOm1Y4sBgMr3NRGpygkzRbAeH5cYi3/bajM/V/MXYnccoH3apfFuntOCNYPAc23xlNESv
	qzECQCaruFZ+RQ7yjiVydVgBLgtKH9suDdjNkgk0iEQ==
X-Gm-Gg: ASbGnctsExyAQSeU18T7iO2FyW/TnKqH40wPWW7vrV1Gf46gbCWO4rDNV3dTH9oDxg5
	qiX/oPa0aXO5o43b/Pl8CNyoWzaaz6fbjU6rO9aq9S7Kdcjq6yP6nixXwDxxbTwAzw8Hcrb8ErY
	kM8WVzeqpppDPb6nlpZr+Pp34V3z8YooG+ucL8INTaRZFNzfChDfCt0ayAX2eYUuZ1lTotXVBR0
	p2UzQD2G4NqpbvaZug7cr/MR0uqXcYsMY20B/MM+lc6JXhsnp2/GQ8g9aFIgg==
X-Google-Smtp-Source: AGHT+IG77y33qe+YSWiCuw+bGYaaF+09RYcnrxdmlGwlAWMUhZclurVy0LNRRN3kFjrGJM6cFb4D106JxZl8pArLwK8=
X-Received: by 2002:a05:690c:31e:b0:782:9037:1491 with SMTP id
 00721157ae682-7837780ba2dmr27683357b3.42.1760707877501; Fri, 17 Oct 2025
 06:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010133856.13167-1-johan@kernel.org>
In-Reply-To: <20251010133856.13167-1-johan@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:41 +0200
X-Gm-Features: AS18NWAoXkFnAoP3lqA8ems1jp1Az55C_wUWwzdzNqFgVrU5xVeCIfkHfuYkqhQ
Message-ID: <CAPDyKFoSCjPA8SfNuUtMfGwsyS65-qoQ=Mf3g95TLx3pnuk8FA@mail.gmail.com>
Subject: Re: [PATCH] mmc: wmt-sdmmc: fix compile test default
To: Johan Hovold <johan@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 15:40, Johan Hovold <johan@kernel.org> wrote:
>
> Enabling compile testing should not enable every individual driver (we
> have "allyesconfig" for that).
>
> Fixes: 7cd8db0fb0b2 ("mmc: add COMPILE_TEST to multiple drivers")
> Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2c963cb6724b..10d0ef58ef49 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -950,7 +950,7 @@ config MMC_USHC
>  config MMC_WMT
>         tristate "Wondermedia SD/MMC Host Controller support"
>         depends on ARCH_VT8500 || COMPILE_TEST
> -       default y
> +       default ARCH_VT8500
>         help
>           This selects support for the SD/MMC Host Controller on
>           Wondermedia WM8505/WM8650 based SoCs.
> --
> 2.49.1
>
