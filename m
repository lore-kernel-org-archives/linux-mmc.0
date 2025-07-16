Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2D2F363A
	for <linux-mmc@vger.kernel.org>; Wed, 16 Jul 2025 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660552; cv=none; b=pkXlPZn0dB/FnBM+jKUrRtNWDU2n0WWNPTuEwTwtWTjvaFoDGa19VOp33zPf12r8MGvXGnuB0oSn8GGXhiPd3PKC5qoC3aylFumyXoMqq7LlonJsVkwZsHKThd1CpMGxhYadX9CI23ZXYzvPKuMEud8hQCMJYt2hSZYTBwpvCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660552; c=relaxed/simple;
	bh=bYR1c9LIUL6l7D6Wuh18sl8qUWFTwYdOeejSsA0iDBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbDEB85QG3iWjzR66F3K6WsCs1XO4oZuvvbRX1N0TUXru3F1KMn74RH2sVqVNFQaI0YyUrtfFnTw0KzQ2btbfZwdASZ7UuOUW4+qeE7ffc8e1kFOiUebNOukq2yhuOG4AzA32g6ZNjVkkdDN5SJPC7UFeGHh6RUVVXIBdAbXziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sb7cT2DB; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sb7cT2DB"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8bb69cdb90so1688231276.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Jul 2025 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752660549; x=1753265349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aaSlIX5JSMkPDXYG9OHGWw9rTnf4dMbBtDMCUX1oXGk=;
        b=Sb7cT2DBKzu0dLJA4pKIFaNSayrw3zi+x/xQ1PZ07iSCbQWylfToz1gQ5LJTB+4eMk
         mBPS1BqqFR7JQDvuySXht3HTE1SOXSmNG9+dw8v0ny+BMr1M82EF4s/0gUIpuj/jXM5Q
         3uotcC4RsxC+YZ+DpnpxkHRX/NUYBOTxzaXh5npZtBtvwWPTipOUMqXkbCp026HlODlb
         Nzh4HmVpUcq+e9Jhf3miiQQ1Z6Xh/2Yq3iQNZ+FVgiM4X7AfkX+dMyvL0NNPbNOMKxec
         t6WUe9qhAxRCNbunJn/TdNP8v8OrA1ncgobXzOmB42NPXfT2aYp3cfWWSnPhAbDKCc6Z
         joOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660549; x=1753265349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaSlIX5JSMkPDXYG9OHGWw9rTnf4dMbBtDMCUX1oXGk=;
        b=NfIaOUyWjx3FO+Ut1gdJ/dOODtg1/DyLFqWiBCIEIeV08/C/0F9ntKhO5XmdyCZZ0n
         KAf6DsPQTPLzk+cjPYhFbupE0NEoJ6jXSF2zegmFXsm90RHqbQTYRkRdOkl63Dbluc0Z
         Ta3JeTRVOk0LJXmsxajp4s64VyX8uPypxGmZkwNbLCm0kOMq5gFTuEJcBwsHJ5CLT4EK
         WCls98gJ6J/uESTqYgJqs5hy7vC/PPwnlUgVSGwdts7Uc/9jUqSMkMX2XEjIJlCBuz6J
         g/uzoer4q5a76UE4p8M60RereDer33J+ZH5ej6fbO5HFZQBP62x++8LzcMmiM6xmkGcY
         f44w==
X-Forwarded-Encrypted: i=1; AJvYcCWNHEqFsPy/Sfo2P0wQK5J5hP2wcI6y15D/EO+iM4zNxUbPbz8thQeXyQhRqNKCBFt2O012fLlCRuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc2mZ6pK5ixDlj3HjPODFAg0cmXYNfnevgYhsTGpnYcc6tQ3/w
	LuVG/1VcpGdtqd/w4w9aov4z9YDQaRQSJQ2kG8c0AHU7yrE1/I25jqHI0Cx4oCnYKfE13sJANcw
	2/JHJSPjImJRmy1PIFK/HAKi+EZF7jZCa5Psxpp7vMw==
X-Gm-Gg: ASbGnctaYnHBVvBw0l7+igYrIVivrMLNwUlP6CCjz5ZcMH6yE20NaMejPgBACAxPNp9
	IhxJ8j3HD7VIjj0OgGTg3cb/acM8Z3mHO1G/NLQGG/yOweQyyojCx7QbBuCTTXTW0w4fhcjUSYk
	sPKQ4gNxH0W9s7tF+rZBEPlQAnyW67auJRhDSD+reoFn/gNn26U1mMOnxkhF+7QEfQjy6RG/PkN
	bOYNIMN
X-Google-Smtp-Source: AGHT+IEVrqdnzjgna0nPf8/QlqPaakZ0z/Y4vr73ndJXG6lcTCHSif5oJvQaIYU9G6d6AxqzY4LsoRudWzSfDn6eIO8=
X-Received: by 2002:a05:690c:22c5:b0:70e:2ba2:659d with SMTP id
 00721157ae682-7183747da57mr24628487b3.23.1752660548791; Wed, 16 Jul 2025
 03:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <847bf395-6d62-49c9-a39d-8e82c5b17bf7@sabinyo.mountain>
In-Reply-To: <847bf395-6d62-49c9-a39d-8e82c5b17bf7@sabinyo.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 16 Jul 2025 12:08:33 +0200
X-Gm-Features: Ac12FXzW2XIbQtUDaHN3eu8QGSaXiZ3-1JrKO6jE043zd7_dvv1edcxvTnJN-Gw
Message-ID: <CAPDyKFqsP7bHrN6oBi0Wvy-MRZNko3uOq6wiH8vf9QxOeJuEug@mail.gmail.com>
Subject: Re: [PATCH next] mmc: loongson2: Fix error code in loongson2_mmc_resource_request()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 01:01, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> There is a cut and paste bug so we accidentally return the wrong
> variable.  It should be "ret" instead of PTR_ERR(host->clk).
>
> Fixes: 2115772014bd ("mmc: loongson2: Add Loongson-2K SD/SDIO controller driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/loongson2-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
> index ba6bb8fd5535..63d01d2cd978 100644
> --- a/drivers/mmc/host/loongson2-mmc.c
> +++ b/drivers/mmc/host/loongson2-mmc.c
> @@ -887,7 +887,7 @@ static int loongson2_mmc_resource_request(struct platform_device *pdev,
>         if (host->clk) {
>                 ret = devm_clk_rate_exclusive_get(dev, host->clk);
>                 if (ret)
> -                       return PTR_ERR(host->clk);
> +                       return ret;
>
>                 host->current_clk = clk_get_rate(host->clk);
>         } else {
> --
> 2.47.2
>
