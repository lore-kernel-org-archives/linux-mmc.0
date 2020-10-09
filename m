Return-Path: <SRS0=zmAv=DQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F326C43457
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Oct 2020 07:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF33722248
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Oct 2020 07:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlG3sqIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbgJIHAn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Oct 2020 03:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbgJIHAn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Oct 2020 03:00:43 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AE8C0613D4
        for <linux-mmc@vger.kernel.org>; Fri,  9 Oct 2020 00:00:42 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id j21so2726031uak.5
        for <linux-mmc@vger.kernel.org>; Fri, 09 Oct 2020 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6LxvX5EGSR5dzBeJZ4icU2Yz0a2U6qxuATeWZPemrZs=;
        b=HlG3sqIPhShbJ5Cx3vwfnebC0xgxM/SxHaKUwe8bETaqPD5Z/NXCAWb89YCDemgs/R
         ZBujRadVWfw/hFjUNCeWgO569J8i4SyBb+ukBZzrjCIAwUBEQ38OY5gjZGokBdt127oF
         T0XuYvwEfXOprlg4MpgFi1yUMGp77gF8oIg2qe7UdMuUACeFH+aGe5Gmyu66slvG9bHH
         EgnEa1K3sRE8xzC+f6wMrajp2abARwCz0rJzUaDG2wL6RfOVLQ4bf04Yyz/P8OaTVNT9
         98UC0K1rY3tkH2qF5zbCvDPB4/4yzdI9qgRipqm5A70MBFy8hu7Dmq8CTs/ncYiFQd1J
         wXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LxvX5EGSR5dzBeJZ4icU2Yz0a2U6qxuATeWZPemrZs=;
        b=StCb8P4rFDnt1fisVLqSk4VfacJk51tn6u6ZNLOEPn4teRXiWjkBdMUXQJyQEXGn5H
         cDH4690hqX7sSjC3TsCACMrqRdIBWdUYEBBUEEWFLb2OzaPwS47RGvYyyFmkJdnTdGR/
         7LYcvvMJ6n0+s3KatzRwY5r3BTiPKXppDZcF46KJWTU+PesA9nwnP151F2y8a01kbiBR
         9mgI4I8aEtu09PvTnvmZpZeu2OK3X1b87SxHaZoWR0HSllCvGj8tuFgVgv7QbX90inV9
         /miCjofE8N56Uzm7FediY6L2ADLEM2UoUw8u64b7BwjZaEqH5mXHoNc+q6mHdRXB60N5
         zmWw==
X-Gm-Message-State: AOAM532AUNxk8igzx5bOIm7jd/SnMYo0mCcC1mfS87LHucHnVlHEZOM+
        04m/9sCInRpC9HViYG8am5riB2lXE0m3yU0JYZNKtg==
X-Google-Smtp-Source: ABdhPJxP48s9Fi3PvzMHTIKhwWE5xo6W5AMzluAvP/iw7yZfHQsSa0wuItjNoe6316/TEnRWyUg3tzmN+NBKagVDQq0=
X-Received: by 2002:a9f:31ce:: with SMTP id w14mr7428678uad.104.1602226841942;
 Fri, 09 Oct 2020 00:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201008100129.13917-1-faiz_abbas@ti.com>
In-Reply-To: <20201008100129.13917-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Oct 2020 09:00:05 +0200
Message-ID: <CAPDyKFpixCO35ARA9QBfhcdkhFpiqqWCxDrJnOF7g+AiY_P9Kg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Fix module autoload
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 8 Oct 2020 at 12:01, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Add a MODULE_DEVICE_TABLE() entry so that the driver is autoloaded
> when built as a module.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci_am654.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 2bce962bf7e4..a64ea143d185 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -739,6 +739,7 @@ static const struct of_device_id sdhci_am654_of_match[] = {
>         },
>         { /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, sdhci_am654_of_match);
>
>  static int sdhci_am654_probe(struct platform_device *pdev)
>  {
> --
> 2.17.1
>
