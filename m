Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54798C433E7
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 09:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1AF2177B
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 09:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TaaG64FI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgJHJjP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 05:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJHJjP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2020 05:39:15 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF231C061755
        for <linux-mmc@vger.kernel.org>; Thu,  8 Oct 2020 02:39:14 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id s15so2717032vsm.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2020 02:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mm/dnK6nyjUE++/nfQRum9Y7O3yymi4HN5zd5EnYbEA=;
        b=TaaG64FItcVw1JWXnfkJKiZg07MxfH+VZsmHm6nEX/4haHLWJrVaPW1DmoeMX4Zk8a
         zqZXbBIHdSvVVX2w/bq0ubgr0TLeczFx29J3RD5Vt/S9CkTz+o2cVULJbsAmUgwO+9be
         Gs1xg1KGGIHRZwH+g9+A5Af44lHdJ5tirUHCOW03srBv0qu6KGhzAmn+LEKKQ395JsBR
         C8SxELa7C/uOPS3mt9k4rI6/k+w4wUbvOD81NY3AV+L8C43eLQ+yoY38q9nTBPPLGsfF
         kkndyyKWagpKWKiUKnVxIqa8rEwulIY/03k1F/qH6EdTF3Zprx1KkKdgIeEXsRQmRV66
         ozzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mm/dnK6nyjUE++/nfQRum9Y7O3yymi4HN5zd5EnYbEA=;
        b=AW9VjK0larF2XOsF+SXJuyLwHq+ko92rJmBCeDFQebMrwaRMdX4QiYyL8wWBjoRHa6
         HJJVcT6Qc5G536/sl76V+axkQHP+Uo384rRguRPRUg7tUvZIbm5i5dNWHnGZotR7NBkQ
         vq4K8BKgL5/WCThiAjSGCOmUOzEb7gb67bPn2AQKUcCtdphVPYyVbQIBHLZQroHfYEsJ
         cXL2k9/NlAfcpp35UXbXwPXAmNM546xMr0Yoi6L8hJaI7WJQAHoVgG1CKr2Dh4+PpR7B
         8BzBQan8yxzCzDu6mft+TQtIzMQEHXFP4zHOjMB5hS1vUOUGhIm40LhETtTz/27d0as9
         NfFg==
X-Gm-Message-State: AOAM533X6Z3gNgYAfhwXQyrnCSzN02kkpg71MqBbm6LAbV9fROogdk3I
        5Ivxc7BwvsYpefGcSw21aHL6QEyPxRAztqGJobvW1q+Ai9sBcLqA
X-Google-Smtp-Source: ABdhPJz6awDRktXAdMWIlebTSGncSvSVq2A3pc+3fysf4d3OIZZ/TY1OgHQn0LOhz8U8CEPWkdrB96+AAeFi5BXW0HE=
X-Received: by 2002:a67:6b07:: with SMTP id g7mr4372068vsc.48.1602149954039;
 Thu, 08 Oct 2020 02:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201008092533.76588-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20201008092533.76588-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Oct 2020 11:38:38 +0200
Message-ID: <CAPDyKFqybhP1gXEzexdk9tOUkZdaApa-zYnny3RdN4Dk10ei=Q@mail.gmail.com>
Subject: Re: [PATCH] mmc renesas_sdhi: workaround a regression when
 reinserting SD cards
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 8 Oct 2020 at 11:25, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> After the conversions of the reset routines, re-inserting SD cards
> didn't work anymore. Apply this temporary workaround to have working SD
> cards during the merge window. The issue will be fixed properly until
> the final release.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

> ---
>
> Hi Ulf, this regression only shows up in mmc/next, so this is *not* for
> the current release. Anyhow, I'll be away for two weeks, and can't work
> on it. So, I hope we can have this patch for a while to have a working
> state.

Okay. I am a little worried that the below could cause other issues
though, but let's look at this when you are back.

>
>  drivers/mmc/host/renesas_sdhi_core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 20e5eb63caf8..414314151d0a 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -572,6 +572,17 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host)
>                                              TMIO_MASK_INIT_RCAR2);
>  }
>
> +/*
> + * This is a temporary workaround! This driver used 'hw_reset' wrongly and the
> + * fix for that showed a regression. So, we mimic the old behaviour until the
> + * proper solution is found.
> + */
> +static void renesas_sdhi_hw_reset(struct mmc_host *mmc)
> +{
> +       struct tmio_mmc_host *host = mmc_priv(mmc);
> +       renesas_sdhi_reset(host);

I wonder why you aren't using the ->set_ios() callback to do this instead?

In principle you should be able to look at host->ios.power_mode and
check if it's MMC_POWER_UP|OFF|ON to understand when a reset of the
host controller is needed. No?

> +}
> +
>  #define SH_MOBILE_SDHI_MIN_TAP_ROW 3
>
>  static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
> @@ -1009,6 +1020,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>                 if (of_data && of_data->scc_offset) {
>                         priv->scc_ctl = host->ctl + of_data->scc_offset;
>                         host->reset = renesas_sdhi_reset;
> +                       host->ops.hw_reset = renesas_sdhi_hw_reset;
> +                       host->mmc->caps |= MMC_CAP_HW_RESET;
>                 }
>         }
>
> --
> 2.28.0
>

Kind regards
Uffe
