Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30510172BCA
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372740; cv=none; b=RpPiX2/x2+A13l6NVQDsGA3GJow3HnbI2nspTEBgkP7+jRuzzzNnEFAfBbRJvpvZFcrL2jtN1plmGAec5gWToyX7LYq7VMm2Ew8jyizgl4iUB7tYWqRmTk1ODjUKylK3OwAH6Qm7/1Rnh+Fu4WqO5M3Yuh4NAI0i5o3E24VHGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372740; c=relaxed/simple;
	bh=+g6l24R7iYlT3jLfuSklU+YCcpUZzJymv4Cy8kThrH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWCYh5ss/IpZ/PaOpMIUt/aawvmguZrYImp+B08WvO8j+2M9xH3AoK7ACvEoHLMa4KcIsC9bfBvaaXxQ4KAbHnF4IVJLTOIyz3lfu5hLwUhlvr2dOGAShCnkyC8mcYFzf7kJaTZ7c5ktagJpyAynJE0LuOXs75dFG2Po+k03N3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7HpHQXk; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7HpHQXk"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so3852326276.2
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372738; x=1711977538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qc+iVsnT1Xzqqiyad328U5HjkOGFMt7G5z0pWYZra+o=;
        b=d7HpHQXkpBc4q1z6AF2GvvML3HuI9q/Uf0epEpxw4diM8f7yvQPuW2vrWGUS4Z/qHp
         4dK6DCBA9gXxTfivY+qARHI92rLbNTwuv+fq4iHF9YlS6iRz5wLgzowlMsZk81yzPPtl
         KLWcGtUhLIMvR0bl9KfifT/wGBfInkgyQumbEU+IPTvbIp7dc46IihrwpL/hUMAnwn3/
         AXQbbzZiuxzFK0uErN6ptFqKOIYCMniVlb4FW8PrJV6QUzZxpS69WDrRSy851QhocAeq
         CIKusO9PIHW2alRk4wffOlddKnO9zi1AJqGizexsz9knu9m3BXFnzch1FZ+VECf9VFHY
         ag5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372738; x=1711977538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qc+iVsnT1Xzqqiyad328U5HjkOGFMt7G5z0pWYZra+o=;
        b=g7k0tytKj6seYk37qyaLOJzlI+F93bpb4maCdDDCflaJt9fGcAPzVlnlw37oRgzljl
         JqSGaN4TUhmTkS7W3ds7xdw+cSdHxbTLPcQqQTw+KR+WCkaRqr3SEUXxkV4s+IjVP1tf
         mj07PiCEItkCbtBFYUEkdeNfAJnHXhRyEX6OjzPEXKFus1yi5wNt/hXaHGEB2cJtazQn
         /dAkuNPEYuKEZELOawF+HXpwXZIfq8dCqkjb3pCD9PFA4qmDOMEWas4Q9VXBepg0K/8l
         zFCGBdk/juqYWVPegBSeBE1A0b4nnAhzntTEIuRshCwkwAxyNsGpwMcIgsyOsI6rLWX0
         zyAw==
X-Forwarded-Encrypted: i=1; AJvYcCX9gb/Y33vKPxt9srKKrrxQOaDRv/dweu65ZAVoBSBqZKlkK35tg+DPPjqvIQ+HvKasnVSdspYdRWxu0TsOVNz0DaHLtZuKzfRb
X-Gm-Message-State: AOJu0YzQG+fx+zWDjyJD4ivWz6qcvQBZFQFNaacOTsNIqwpGbp3M/kfM
	th4FXuCLvbJQm6G77pLGL5XU6x1V3J6FZcRaFmB2H5fu/UEEZdTtnIPuC05aG1zqo1f4IYIvxFw
	q3dRfmtOu7/sW1vGvsthKJCmRx5YoCaft2KIOmw==
X-Google-Smtp-Source: AGHT+IEMz2pveieTRzatmvaD78PaHp+oiu25iulyM43bTmQBBxO8fIlfqLirkAWS82Cw+Pwqx/Nargo85AIivPxTPnk=
X-Received: by 2002:a25:8042:0:b0:dcc:5aa1:7ac3 with SMTP id
 a2-20020a258042000000b00dcc5aa17ac3mr5037282ybn.2.1711372738228; Mon, 25 Mar
 2024 06:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307114500.3643489-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307114500.3643489-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:22 +0100
Message-ID: <CAPDyKFpf4TEtee7bUsKEkmwzOcffXQWTH9xZz+JBk8WE1Fb5RA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-sprd: Remove unused of_gpio.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 12:45, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index bed57a1c64b5..685b1c648901 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -13,7 +13,6 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> --
> 2.43.0.rc1.1.gbec44491f096
>
