Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09EFEE57E1
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Sep 2023 07:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjIHHbM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Sep 2023 03:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIHHbM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Sep 2023 03:31:12 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20021990;
        Fri,  8 Sep 2023 00:31:07 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4935f87ca26so660516e0c.3;
        Fri, 08 Sep 2023 00:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694158267; x=1694763067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gclUsf36eX8Zu/F0aBv6Pp4DYKTZJM56puvJkHceqCU=;
        b=OrouDuYrHQ1CWJ/oRmoFOulwiYo/1S7UR22UeeNjFC91gbImoZWRkaoOaTVeD2Fr8y
         cRvaUZheaJls+zPwJ2aoFENZIroU1BzPJ16JziYFhcJMN9gpzCrzOXgO4rA8n7y44W0h
         OT0zK3uJNnUsxHKVs/SzPrAG2KOisGYJGcEArIXlpAGSAHOJ/pw7p5vOmR6Zbb4QwFkQ
         YsN74rsctFrnDMlreBaBBdnjldaCbPggY9sxxmQ0SCLfvIwdJO4d2F4ZXHwKsNSXQmOr
         Ocl9W0RzkBI+h7BU/FcT8IuyzPYCviHRbdDtatQKByJysLWmmU0JFv/APP3TUdB9nTzq
         kAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694158267; x=1694763067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gclUsf36eX8Zu/F0aBv6Pp4DYKTZJM56puvJkHceqCU=;
        b=pKO+WQ9cK0KeFU2A0TW8vrdtXN6shoWP8qN2+ObMazzBqJK8qptBZI6dMsrGu/wgl0
         uLH4PMJHKwnKbFbdtkaRWRuqzRbYosTrtebuUYJc+RTKkqdJowG8ltHrIdyvwIx4UEOE
         V7Nc8b+aG8QNHsIdpbnP6Q1khNEXQz4g6G3KlBg5weacru5ukPWZvbkminZ9j7AFfXsl
         iUw5gL8ZleDGTJzHvvQh6mW0Og/JrDwF6SYPrjRNaAj676BdNY5fJSwctimlyj1NzjRd
         pcqYV7opKIy0AJ0a45YWYV6kPLkkpc90cZO3yY6XPXYvBfnnvSwIkcZXJKa+JcNTh8Og
         kUzg==
X-Gm-Message-State: AOJu0Yyj3VTbeLabSXNefvq1sSYbnxffQ0Y/t/O+rtM+c2eb2+blTmXb
        tvMb7FiYQ5npZAhJBq39beDb30qBP9jFY3B1nRA=
X-Google-Smtp-Source: AGHT+IEEExJtkKBBo1N76ecCfx3+ZsZRnKOibJhy7JvGjB5M7X4ybTKEmbQu71sLVXWYVZ+aIJt7ncY7Gv4WjEaF+ms=
X-Received: by 2002:a1f:4a41:0:b0:48f:8f80:8bf4 with SMTP id
 x62-20020a1f4a41000000b0048f8f808bf4mr1491450vka.16.1694158266697; Fri, 08
 Sep 2023 00:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <a8af0a08-8405-43cc-bd83-85ff25f572ca@moroto.mountain>
In-Reply-To: <a8af0a08-8405-43cc-bd83-85ff25f572ca@moroto.mountain>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 8 Sep 2023 15:30:30 +0800
Message-ID: <CAAfSe-tMK=4D3=JTw-tLDz8OL0BPgzCd35eUFx7gxD49BHLOrA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix error code in sdhci_sprd_tuning()
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        "wenchao.chen666@gmail.com" <wenchao.chen666@gmail.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Wenchao's gmail

On Thu, 7 Sept 2023 at 17:54, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Return an error code if sdhci_sprd_get_best_clk_sample() fails.
> Currently, it returns success.
>
> Fixes: d83d251bf3c2 ("mmc: sdhci-sprd: Add SD HS mode online tuning")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This is from static analysis and has not been tested.
> ---
>  drivers/mmc/host/sdhci-sprd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 649ae075e229..6b84ba27e6ab 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -644,6 +644,7 @@ static int sdhci_sprd_tuning(struct mmc_host *mmc, struct mmc_card *card,
>         best_clk_sample = sdhci_sprd_get_best_clk_sample(mmc, value);
>         if (best_clk_sample < 0) {
>                 dev_err(mmc_dev(host->mmc), "all tuning phase fail!\n");
> +               err = best_clk_sample;
>                 goto out;
>         }
>
> --
> 2.39.2
>
