Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2A3C5519F
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840AE238E6
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AFWLA+79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgKQLuz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgKQLuz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 06:50:55 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F85FC0617A6
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:53 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id l22so10898730vsa.4
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gq4awtwtwe+42elAveTI63NHsmqO5Q81Rja7faE+b54=;
        b=AFWLA+790ristxt/kCJc1HcKOy0wktlLiQAECi9QpbkFW2SRevh8ICAGIqD+ON16Xg
         ZZ1qBA9LJDr7pJz6DP1HJhMAg/mxEidRakQJF0pQS5xyhLS3i6CFydJ2RNoaDul220in
         t+kOIr05HWMbeQDBVbaYl556mUj7A0HHjXC3hgtOP18iFwUxuwsJW8hXTHVijq1IvCFn
         eUOrn2+3YG/No59+rA1EDQkM9Vedc+za9tFR/uBcjc7DmMt6YZX5FI6IXtmImEdcnZI/
         VtsWuZQfCNCC7XSl1ZOIDLHnK415TJ9+tac8d2xPFD1opoFRheuBmtG+jQTHQslbn1a0
         t+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gq4awtwtwe+42elAveTI63NHsmqO5Q81Rja7faE+b54=;
        b=GJHexbPvDR1pFsZ9bYLTqblElGcoe8+7ggfakNP+FC//mK2odk1N3ITRtk7c/UbKzn
         FpHVtN90+D4eIOehUBrJjMkIu7MnUenLB0UVR/iRbj1lRmNWYMNRSoBXdl/YA2PLuOdd
         HLAAQIOwnmAamDBcTrDEetUKCAqHqzpP0421yUmKwcpOmGd1nSOqdvJei5sPWdZbZB4o
         ObyufqINfpY85607STen5jiE0Q5kF0vswNc7Nt9UdCmKIsdLlXg0y8oiZxrpdcorEy6t
         fz5AN5JWuMnqlO6JD0fQHzjusQuIxkt61PKMpY6u7k/z02eb0TfwruyFVv3PLeWuXQHz
         Wxqw==
X-Gm-Message-State: AOAM532Smh0o006DFDOtaKZXKaKQ93I+gLrPPBa8yOrJ73IAsQq9K7go
        XhG7fkpa1ivOaXekpgW41zRatWn8aNaYqTqixzscdg==
X-Google-Smtp-Source: ABdhPJzzBQNaTzVjzhO7R8CpIuSG7UXe3q1rFsbVtNyyRKvtbf1P8EewU5WXXCH8IeTff5cD+ahoNF/8TvGhVFVt/Wg=
X-Received: by 2002:a67:683:: with SMTP id 125mr223849vsg.34.1605613852868;
 Tue, 17 Nov 2020 03:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20201114120819.416311-1-colin.king@canonical.com>
In-Reply-To: <20201114120819.416311-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:50:16 +0100
Message-ID: <CAPDyKFpwFTEPLHZC9uT9mff64Axo-2bBjGVv4TGEcV4pGwWmig@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: Kconfig: fix spelling mistake "hardare" -> "hardware"
To:     Colin King <colin.king@canonical.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 14 Nov 2020 at 13:08, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the Kconfig file. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 310e546e5898..7324a61d7416 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -664,7 +664,7 @@ config MMC_S3C_PIO
>  config MMC_S3C_DMA
>         bool "Use DMA transfers only"
>         help
> -         Use DMA to transfer data between memory and the hardare.
> +         Use DMA to transfer data between memory and the hardware.
>
>           Currently, the DMA support in this driver seems to not be
>           working properly and needs to be debugged before this
> --
> 2.28.0
>
