Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F937288D6
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767107912; cv=none; b=FJ+sx1l4b/mLfc0KSWct1uFqIySPZPk1SZEieTagCcwKCGpR+Tc0JEocGaQjm8jqGo1KiDbpdPodgYiOtnsHki6sxDU6Z3sn1ZSDcBD9Ag52m34ppMqQZFco9+XxOXWVJq31mzuGjkVbUsQbsNEYqTN74oTiD6hWuzCEpCUzNPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767107912; c=relaxed/simple;
	bh=+gKgDwYYKlFxiM1d+fE93Zpnzzu6oyiW358H5BNiJQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0vDLYxymZef0oEOjZgsclrhnpCSgNfQgOMO6Hjlsg9PODHBUjCgugPUIz/bwvMb3YDH23SqdFMxh0EWSnKs2lLlNbhlNUJczcA2a50zlE3wBYlVI1TD9dtbjUTtSDO19RFP1g5Zoi0bcwxN3k3vVtbnFNjd97MPdH0UahQE1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFZAL6DX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFZAL6DX"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-595819064cdso15961282e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 07:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767107908; x=1767712708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RRBtK3JNhggUM1K73zNRNw8Bzd7ElXh/Sim1R9PRqIo=;
        b=fFZAL6DXyFU+cFFQDdQd6V1VsOsgCIcaS4momw8W9F+PMxytWEihWJ8CC8hcidwnFD
         pmuYfGCm/QbDhwDgDgWV2WWufWPcEeApuc3MOwB7POr4JTIYQpyosXlOdVFZsvpVxFy/
         Kd0WGj9W0xKW3oWlrzqLld2lhW9qHGkTjLdXvDEJMemtID+eE5Y0mDWdTAXZxtvSJRzJ
         iPDVJq6Q+ka81iWT8ud3qtFdvCKk6Mv2XtPe6N8U2Py/P4BGu3WSiowTqSav0GWcAm69
         BhKSs3rTkYzTUZ0nN4W4TeBgmUCn7Jo9YWNX1oZRM1e/IxOA8hsWlIvzktDM2qwSGvwu
         KTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767107908; x=1767712708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRBtK3JNhggUM1K73zNRNw8Bzd7ElXh/Sim1R9PRqIo=;
        b=fYDztS4BCddOv0Sy7fM0x3u+TguICuH/LQ9lPsRw9bVRrLI5jIQZ5Sy1nZrGlZeE0z
         pA93uX6oqseP12TIq/Un5MhHFwEVpeIpa5R0W3eAKe4QoZUdRJb/OdyQRwYFcSHYWuzg
         GHp96x9cuulMDFKamaqd3oJcHX39IuLd6oiJWY/85sKXk5gwXqBpGn6u5uQcn3c4nybh
         yT2qpC/Ah0suGkgC/3KUMchDK+If1Ef07OzPS49zcIBY8/RngeDMeOhP/tOyTdVtock0
         lx9xWvYGyKNTFuoaNdG8uwCrhiIb/OLVaAwYr0d2PijoWJ7U0UUvmGtHJT7iSzSimPBO
         ftpw==
X-Forwarded-Encrypted: i=1; AJvYcCWnfgQQDvI74yw4zFxOgqu+Ob3Wx4/WOjX8+0e2mI6bRwJ40Z+Zj89SNTlEO9Zxty3rPbO4xvdtqIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5H98E6BH4UR7Mk+0AjWHR2q5lX+TpHIwkSbvNh7dCSeHJ0HMw
	Xt0BATuVeanQk7M9TpZMxNGf7gM7PxZs/m5RyHep5NoZIz3SBVvq7MRzqEplegYeA2AzaXNJj+q
	H92phq/ne0Vm8fRK/LceB6YYi25IKlH1t0sWwOHBBQg==
X-Gm-Gg: AY/fxX5NmXaJPayr8YUAfCjpVi5VUs+vDMiAWQU3zEWA7N0ZDeY7ueaSkowYexAOhsC
	now9J0TR7DecuIXoGrqTg7Xbup7G7FjZv6M08fvVQqHhsAa+qc+CVLf0EN3Bwc2ePzcT7so+Q0h
	ILzQhTdTMrfviTnJDazoePlmA5zlK8hX9IAd88wRBsYBETpjOurCpI5a5yfg16D6uIzXBNFH55T
	E+95J6ktcldHo+RhassqLREuXGwBDJ+gWqMenD1kTAXfs4GH00WsD9BLnN0rz2gwy6Sg2+f45WC
	6mjqRJ8=
X-Google-Smtp-Source: AGHT+IGLdQzmsFUOaslDp4bPOX42OhRqMaPM6fexcK5h/1BBrcmh/irU+XvZYMqW+MDYb4bkjrOekUINuva9hscHHIg=
X-Received: by 2002:a05:6512:220d:b0:59a:108a:c8bb with SMTP id
 2adb3069b0e04-59a126e5014mr10417019e87.12.1767107908408; Tue, 30 Dec 2025
 07:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20251223044225epcas5p2b5afed35eec4ba996a5a223e4b8779c9@epcas5p2.samsung.com>
 <20251223044621.3352567-1-ping.gao@samsung.com>
In-Reply-To: <20251223044621.3352567-1-ping.gao@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Dec 2025 16:17:52 +0100
X-Gm-Features: AQt7F2qJo4yOQcd4Su8WE-5MKXg_lQvKjqPaCdiAmQtthaeUWfEPt71YLgBoS7s
Message-ID: <CAPDyKFr_gs+KuKkSOYMUpKJyqKB3VnrRL9KPpDKiCAjwUy80fQ@mail.gmail.com>
Subject: Re: [PATCH] MMC:dw_mmc:when enable biu_clk should check whether this
 clk is normal
To: "ping.gao" <ping.gao@samsung.com>
Cc: jh80.chung@samsung.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Dec 2025 at 05:42, ping.gao <ping.gao@samsung.com> wrote:
>
> exynos doesn't use biu_clk , enable it will panic

Please elaborate a bit more on what the patch does.

>
> Signed-off-by: ping.gao <ping.gao@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c5db92bbb094..61f6986f15ef 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3633,9 +3633,15 @@ int dw_mci_runtime_resume(struct device *dev)
>         if (host->slot &&
>             (mmc_host_can_gpio_cd(host->slot->mmc) ||
>              !mmc_card_is_removable(host->slot->mmc))) {
> -               ret = clk_prepare_enable(host->biu_clk);
> -               if (ret)
> -                       return ret;
> +               if (IS_ERR(host->biu_clk)) {
> +                       dev_dbg(host->dev, "biu clock not available\n");
> +               } else {
> +                       ret = clk_prepare_enable(host->biu_clk);
> +                       if (ret) {
> +                               dev_err(host->dev, "failed to enable biu clock\n");
> +                               goto err;
> +                       }
> +               }

Rather than making the change in dw_mci_runtime_resume(), I suggest we
set "host->biu_clk = NULL" in dw_mci_probe(), rather than keeping its
error code.

In this way, clk_prepare_enable() will not return an error code above.

>         }
>
>         ret = clk_prepare_enable(host->ciu_clk);
> --
> 2.50.1
>

Kind regards
Uffe
