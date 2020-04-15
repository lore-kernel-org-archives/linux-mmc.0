Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA01BC3815B
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 10:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E2A20784
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 10:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tW7oCY6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896513AbgDOKnO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896480AbgDOKXj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 06:23:39 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D85C03C1A7
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 03:22:34 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 1so1862084vsl.9
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lx1VtRilkF7eVbuL1lMqV+lLLP1ngAUmM+HAJ1wt5Ac=;
        b=tW7oCY6NwuTzovEpooLhKVX7j8WKfh5I1vB6sw1WLBd9zIz77/iJkudKEhHSGTJNxL
         OjE580GfYKLnOJQcweMM1PZ2y+AT+yRvwIKeG9+lvZbhR7JApqPAMv+HvyObHNAgkx6E
         K/FbxLIBh7urxHYuTqpAeIqugWaEqA42RGhIQFCiv0jhj9PkEJvHO8GViTOzI56sUqv4
         qZQgMlO/qrAyuRZfqSp2x/oKDru01OSr/iSju8lUPTUrvDOPSIi3jW7x5ZtHVeLwaQtP
         9Iwc8rdE2Mc6njZh4BuQ6/PlfcvlDBhU/186nOUNq5XucCrLHVm1Tr3LtLusVO0TMk/L
         z95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lx1VtRilkF7eVbuL1lMqV+lLLP1ngAUmM+HAJ1wt5Ac=;
        b=ZEl4PN8ykOuRD9M0iNULRo8+g4KXflMGcGrvO+R8kf0I+9TZUGzHWpIUdiSCpMj47l
         5mNdbTSGsAw5hbDQjqBUtH1XOB5wW+LaQrfcphXn4uiWkl7xhmL+YtjCnJT5e3Yu+vo9
         Va3D/cAJEtVs6fun5FnQrd/dSqvOllYEtApvIgl9Z+QLAOkGmnWtDvDUAi5DlRPUzMCW
         VzQgdgzvNm5istr/nbB4fjl3cYPxaEb/24ugg5DoNuskTXymGRwYcQOkf9R6TFbhqwhA
         tDCLuHsaX8Yl/MvCLum6TupvZrWZIvq8NOIG7v0EsNCBC2FlfpJdEwQj50N3SmjdVP0f
         ii8A==
X-Gm-Message-State: AGi0Puao0gYQ+uwH4nS8HSZo/paHS4NWB3Gbirx6ET1osdun0lavHhJd
        msgM76gJLy5Xzx8OV1C1K/nIFu3+gSdlRKyQPiX3NQRy
X-Google-Smtp-Source: APiQypIbijlX9DyYWKgWSpyuEFwcw+h84LGo/fGmFldPGwraTKeTj6jXND30tteV2M70rzj9h1IaZ6kAqvQBbyL8Vj8=
X-Received: by 2002:a67:f24b:: with SMTP id y11mr3768618vsm.165.1586946153713;
 Wed, 15 Apr 2020 03:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200408142252.21958-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200408142252.21958-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 12:21:57 +0200
Message-ID: <CAPDyKFork=TB3GEfLhfdhGzneJ75p2fiQp3Qv4TAOPrpScVE4A@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: simplify summary output
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Apr 2020 at 16:25, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> No need to call platform_get_resource twice when we still have the
> pointer from before. Also, use '%pa' for a resource_size_t pointer.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index c002e9fb67fb..de7f4fc9bc21 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -933,10 +933,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>                         goto eirq;
>         }
>
> -       dev_info(&pdev->dev, "%s base at 0x%08lx max clock rate %u MHz\n",
> -                mmc_hostname(host->mmc), (unsigned long)
> -                (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
> -                host->mmc->f_max / 1000000);
> +       dev_info(&pdev->dev, "%s base at %pa, max clock rate %u MHz\n",
> +                mmc_hostname(host->mmc), &res->start, host->mmc->f_max / 1000000);
>
>         return ret;
>
> --
> 2.20.1
>
