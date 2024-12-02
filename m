Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9CD209F27
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153100; cv=none; b=tk4IyjblNv5r6er07FxgeJDAk7oKDh3OiNG2Po96G9aGMftvs7Iw8XGD0eBYl/5d8uaUiYKZExEy0Mn82XtDrWxXjpqW+rKo+kJaWJEoKdj8T3LFc2kXS6IBelUwhUQH7dktCd8+0UAOvSBu+qiO/3qVxrTpmCn+HhYhPeCEwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153100; c=relaxed/simple;
	bh=PMGnihnmxjVfL8xGmQr+urfCilgz+1Wh2VTPRzX2C1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HusR3psScSx7eZWY14AAiAgczLxcs2MUR8i9gc58bQrRtbLgRKfJm3KT2okuOQngLBpMzfJZugqfMzwWsYF1dvZwx2G9+fTc4iX+v9Jrt1mu65A1VHW3OtQEXfar+LBwqHkNpLojRiii+BMFnJjUuZ62MZcC5jXqPft56odrSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nuevsYqr; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nuevsYqr"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3983f8ff40so2763119276.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153096; x=1733757896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MwrhmBccWW8HQon2HiXiBLIuwsxbffUhpKyBJpHJ5sQ=;
        b=nuevsYqrwE3thvNPI6swgY5QL0T2yIYi1ZrNCbCvNp04GqTIvDGoOWr2Hkgf2TCTWQ
         bJ1Hq+C/SzecTlc/x48OPOdnuX2WYvsR3+4ZmbUx7lBkPvUmXevPF7a7Iolo8VOcg7Fx
         Ry3y3ZMYR61TWjRYmNxdpGhrY+WsT6t1uBSqJjnuFUAm4NiB8wyMqef0yNCWB4xbU4+2
         WDPyAlHQqUw8Q9Mr50doYLWJBk97dKTyeeZ084Ru9+d1Zn+drkADW+sc2RBczh7DdRaK
         L+e/5zv6Ys3vT10XEj7dz+VumD+LGs4bWzgozXWRoPtDDf8kUO+5eNj+effIDo/ekdAO
         deHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153096; x=1733757896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwrhmBccWW8HQon2HiXiBLIuwsxbffUhpKyBJpHJ5sQ=;
        b=W/AFt5w4R3SJsrTED78nNL1FiW0klnRv94Xk1l5h/+YsUpZRuI/EW2mHVCL7XizYnp
         IjfOd1RzhQ3U6XxdMg/P8xMGr6uUhYdZFA/5ykCjbP9h2JZ9ROH4FOwoBICVgonitlJu
         69EjY6VpwcItp+FJWDGyDMWNLvkBRxhVa1lxd0DYCWKr3gSFgP1WoMIuOFgJVGrSWoeS
         caeku0XxcB+Wehwy5lLxjoFQNyii/PAROJhFipLw1yykH70b0bu9J/YUcIqCrP3K7FOs
         AwDWGDZBYNZvPw6DYjw/BeVsXd6JvGxAf96W6Ij5I9GngUy/7dxEyEiBuIRvGVZ4UKiR
         58gw==
X-Forwarded-Encrypted: i=1; AJvYcCWYQQJPwe7bUzS3qVRAryKzKa48vq4h97LpOzl23zzLr2cNRN6OfC1zkvVx33F2YHXNDtQIoqZo4z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK76+HQaV6Rf96uXCHhbGz5Bgf7AsZvkpFScrhMrlS9E2KwyIc
	fIF/36YOq9RQW07YR0KRN0wYNBjza2mcrCxgbX7lOm8orpP+WBzMG+EDOm/+S3AJyH+LfqoHAW6
	R60gv2mavFztK4D89jtyhlSfK3aZOZryPfbn1BA==
X-Gm-Gg: ASbGnctmhEJY1FOj+VAwF13U/3N5w5t5Nysg6F3Y7m1h+hkpiSMNFATxSJEegTeMETN
	9IBmnQ77a33FWwePGD9lcisUyv+oMVjZY
X-Google-Smtp-Source: AGHT+IEcO6Su/9/8KHLlrWOggxXpEUQdnHMKRQYTMnTaorultWTg9WKUXkjBrKviPAwOh+21GGIBZJNGibWrb8sKNA4=
X-Received: by 2002:a05:6902:248a:b0:e39:8b24:65ee with SMTP id
 3f1490d57ef6-e398b24682bmr12197418276.40.1733153095668; Mon, 02 Dec 2024
 07:24:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202115140.33492-1-wahrenst@gmx.net>
In-Reply-To: <20241202115140.33492-1-wahrenst@gmx.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:24:20 +0100
Message-ID: <CAPDyKFpX2dcimEVQ8EpOFvbJ6fPybazNLT-j1yf8Uoo79UD=dg@mail.gmail.com>
Subject: Re: [PATCH V6] mmc: bcm2835: add suspend/resume pm support
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Lukas Wunner <lukas@wunner.de>, 
	Peter Robinson <pbrobinson@gmail.com>, "Ivan T . Ivanov" <iivanov@suse.de>, 
	linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 12:51, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Add a minimalistic suspend/resume PM support.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/bcm2835.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> Changes in V6:
> - split out of series because there is no dependency
> - remove unnecessary complete check
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 7847f0c8b465..e5f151d092cd 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1343,6 +1343,25 @@ static int bcm2835_add_host(struct bcm2835_host *host)
>         return 0;
>  }
>
> +static int bcm2835_suspend(struct device *dev)
> +{
> +       struct bcm2835_host *host = dev_get_drvdata(dev);
> +
> +       clk_disable_unprepare(host->clk);
> +
> +       return 0;
> +}
> +
> +static int bcm2835_resume(struct device *dev)
> +{
> +       struct bcm2835_host *host = dev_get_drvdata(dev);
> +
> +       return clk_prepare_enable(host->clk);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(bcm2835_pm_ops, bcm2835_suspend,
> +                               bcm2835_resume);
> +
>  static int bcm2835_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -1471,6 +1490,7 @@ static struct platform_driver bcm2835_driver = {
>                 .name           = "sdhost-bcm2835",
>                 .probe_type     = PROBE_PREFER_ASYNCHRONOUS,
>                 .of_match_table = bcm2835_match,
> +               .pm = pm_ptr(&bcm2835_pm_ops),
>         },
>  };
>  module_platform_driver(bcm2835_driver);
> --
> 2.34.1
>
