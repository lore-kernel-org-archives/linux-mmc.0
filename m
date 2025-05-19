Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7955229B01
	for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656608; cv=none; b=tpBPm6SvixuA9Hcm9jieYMOz3fmfbE+SSFS4BASiK08lsMnJibryt1U5hdvt+U/+FrdVRCn2A3pRHJm+tWIErBYL5O1wiCE/UX8LLjk1n/IVZEXtouvInFpMtmsPzdYm3Izi/FjB+SA9S4+eFGCFx11y6ANEH0PMYtBxfDv6LoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656608; c=relaxed/simple;
	bh=x5MdkypAjAqC6VVdaSVvm9ZhVBug5otYm1hx1SGsbBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfiKc2JV4m03Cl8bezL5hHaUz9cVL+u/2W9lMK5mA4q/0QwIJt3MsICg9A/+EoQmbq3dvRlwmb+cK4IBBDa7VM+Bagvv/uoCnrBnbhtZx6rXkNZ+XmBUyK/7AN+zoFAFjm7yE2PxabXJmswSOmaorsLxYt28KltAN4WNCSQOSSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dKgPAbYx; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKgPAbYx"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7c5d4709caso780305276.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747656606; x=1748261406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ujcjzl2OsuY9ii/H7l8DqEgEiJqH4rk4ZJIB8igbgM=;
        b=dKgPAbYxMpPfPF5XbaZlJc1plGmb9UJ13h8aDCpjairyrABw3vm4yx/9feBhFwtCic
         Z13oUG0vvCkCPfLRMj3c4deDiwPDvgKn/oFrISkFXM7EmdI44btu3R/jPR92Udh48sHP
         1CbrwAvki+LpIZsyZYkj5ScY/eQLvyzyoTSJN8s8NBlXv3wTUERfj8Quzr/fUXoOvXSo
         /9+ePd/I+a/7MR9tJrDDAUXtT98rlkFj+U1I7qn6NT/0MmXRQaXaTDlDGr09jEMR3Y5b
         U15UHjT/1HYn5iWXdSlWMUiXSxC7rxbno8yUHn/WiKNEt2Ai/R/RzxfQ/KXgwRkDFpEJ
         QIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747656606; x=1748261406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Ujcjzl2OsuY9ii/H7l8DqEgEiJqH4rk4ZJIB8igbgM=;
        b=AH9AZoFngVqesR2bx8UQj2SSSwDL9UWOYsK8ygoNoRwP9+8uzhgSVB3Ig70aNpzDsI
         Q2hH+Jfs5g97rqpB7Gn2jZMrSG3tOw9MVFuYBk8M9/PyMpP+JSyleuY8K1rQYpg38hmC
         h6yY/atasV3WV3MplmFTHwL59tgfCeNPG3ad5elV3wH+FbRpXymYXU2EP1Ra4W3NWj1H
         9efJ8k9W2QQpxtkYc5FlLrpzjIof9Kur6fbwwt812fGqRFb0fBSL36cvg+qzoWlqAyKT
         LJWLbJbzFCuplJTdHWG/IWNCK6K7vo773X9YifacUGDI/aW9hXCZEnvV9UyKD4LbHBPr
         obTA==
X-Forwarded-Encrypted: i=1; AJvYcCUhvLMf5tIiRh9nrghb57wBLgfo3CbhZco4WOKUwX8NJdXVtq1ybwotA96hWbn4KF04Zp9kEfs+peA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhRx/tfXPnPxBQjuLQ3ZFe62D1bIfzpCPRCzqoAaknHrNV5aJ
	YI6zSRI/O/Phdj+WmSHvrPoho93bRY0CDGjwq4GieKr6tONwFYbsZk4VM929t2zw8rztN5RUbYT
	K1jC3p0pfmo7qLvEa3wBGsEs1plknGLMPzjUqycCb+A==
X-Gm-Gg: ASbGncsFL83y3igEWFM9oES5tq2WDMpW/70/JrPMtBKeQ8eS4scStl+hyDQpTFo4iCt
	9Zt43TZeczi0cZKxgl74q5Xi/ue+EStVHhVgzlKO1BqExsFXiyc1Kie1U8dpuKN2BBPmo3U5QuQ
	LOKDXS08AlSgkV450HSN4K1DuFGqwDP4vGmC4+90/mTBCu
X-Google-Smtp-Source: AGHT+IEOp/4OAlCuuRfUfbvowUG/jmX/8U9R9YSNLFHxK1XdonfCvP/aN1Pa67AHy8pc66Zut/uLaetRuELGnBxAxw4=
X-Received: by 2002:a05:6902:1a41:b0:e7b:9525:292c with SMTP id
 3f1490d57ef6-e7b95252a90mr7684525276.32.1747656605714; Mon, 19 May 2025
 05:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516092716.3918-1-victorshihgli@gmail.com> <20250516092716.3918-2-victorshihgli@gmail.com>
In-Reply-To: <20250516092716.3918-2-victorshihgli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 14:09:29 +0200
X-Gm-Features: AX0GCFsKEuxWZEXyX5oP7nQDpYMiMx4_qRZXMZhQ_k_JThJteCMW8xB2bXrBelM
Message-ID: <CAPDyKFrKRw2kOQ9Gq=eCmm0N24hSEamNeCWGzC6X-Qg33ad-gw@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] mmc: core: Adjust some error messages for SD
 UHS-II cards
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 May 2025 at 11:27, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Adjust some error messages to debug mode to avoid causing
> misunderstanding it is an error.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/core/sd_uhs2.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index 1c31d0dfa961..58c4cef37f7c 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -36,6 +36,10 @@
>  #include "sd_ops.h"
>  #include "mmc_ops.h"
>
> +#define DRIVER_NAME "sd_uhs2"
> +#define DBG(f, x...) \
> +       pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
> +

We don't need a macro for this, just use a pr_debug() below instead.

>  #define UHS2_WAIT_CFG_COMPLETE_PERIOD_US  (1 * 1000)
>  #define UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS 100
>
> @@ -91,8 +95,8 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
>
>         err = host->ops->uhs2_control(host, UHS2_PHY_INIT);
>         if (err) {
> -               pr_err("%s: failed to initial phy for UHS-II!\n",
> -                      mmc_hostname(host));
> +               DBG("%s: failed to initial phy for UHS-II!\n",
> +                   mmc_hostname(host));
>         }
>
>         return err;
> --
> 2.43.0
>

Kind regards
Uffe
