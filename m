Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928BFC388F7
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 12:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3616120731
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 12:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMlxFkj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgKJM05 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbgKJM05 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Nov 2020 07:26:57 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F08C0613CF
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 04:26:55 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id m16so6908621vsl.8
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 04:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5rWcam3/Tj7i1qRqps//Nxp3iCwXN4YIqqlBccMrD4=;
        b=zMlxFkj299IZ9zJoiSFMDil1GUKl8v5Q4TSgARJdeUpCc6nPDp+97cS8KfihiXzwX/
         rSAUbGmqY6pgVJIfopwJBY5qgcNeiXXf/9FxKH1cWMNxMI1MKSTmYJ4ys1XxklcXJ/IG
         HWJ7SA/bGp18rxs3fVJ1XbnEHaKvX1cBH17qsdMyYFtRpEs9dIK0Q91XJbvhPnzjRZV4
         kmelbZd+QESjDGpvDVgPvLhuZrHtxFmvqj7v9ekAwDz/IhMd6EuyWeD9+2pgknJ6mruG
         w7NMaJfYv36IYHlZQpP5sN7A73taarqKETc+c5m4HmdBrzsp4mNa13/cH/ADmkk77hWE
         16Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5rWcam3/Tj7i1qRqps//Nxp3iCwXN4YIqqlBccMrD4=;
        b=VaCb5VSlqOfd9Vf6v+PLkZc9zSEaArz1m2kz9TvnpPk2wZxp41bNW1DHyvg3bQL2oP
         kAXBYQyoQJE54/G6rSAiPdgrMQm1ukG1GaZLUx6fP93ZTqOsfjvUBLcuZRCWw1o9Hcrs
         oql6nZ08aASk2Cu31TX6Z6XffomR9fRRAZ/ABs1NXuT9VPiAmMNGdQitbePPfFpRjj5O
         gh3i6v+aAf0LMXcxGrg0rklU13D70pF09ZAREJrzti+JdOcCm/DOMYBOx1k0XpTT3Yp9
         a5gc4bEX8XE78XVOUdYhe9i/BLjijIk1c5Z2AFJRa+cQwtzcF79a8/JvV9gXKm3wC3j3
         5Wmw==
X-Gm-Message-State: AOAM530qxER3SxNcLrCjR9POrxCXC8j680ZM47lv3But6ki+Tyycc/5x
        vyQn40uZKJmO5smedmtoDXkcpGq1c0vV786utkgOsA==
X-Google-Smtp-Source: ABdhPJzZlrbKKEs8EsQtHLavZLj70uwyIxmjfA+L+h5kIdcdqBLC0zZJ13Bz/pCWmbOHrPu0jY/+kRMr/eJT1wBwpZw=
X-Received: by 2002:a67:3256:: with SMTP id y83mr11926671vsy.48.1605011214776;
 Tue, 10 Nov 2020 04:26:54 -0800 (PST)
MIME-Version: 1.0
References: <1604847648-13036-1-git-send-email-kaixuxia@tencent.com>
In-Reply-To: <1604847648-13036-1-git-send-email-kaixuxia@tencent.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Nov 2020 13:26:18 +0100
Message-ID: <CAPDyKFq-zhbxffORvi1hokFH-eMkoZdyTioFBmbOC1JEd=BDQA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Make pic32_sdhci_probe_platform() void
To:     xiakaixu1987@gmail.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 8 Nov 2020 at 16:00, <xiakaixu1987@gmail.com> wrote:
>
> From: Kaixu Xia <kaixuxia@tencent.com>
>
> pic32_sdhci_probe_platform() always returned 0, so there's no reason for
> a return value.  In addition, pic32_sdhci_probe() checked the return value
> for possible error which is unnecessary.
>
> Convert pic32_sdhci_probe_platform() to a void function and remove the
> return value check. Fix the following Coccinelle warning:
>
> ./drivers/mmc/host/sdhci-pic32.c:127:5-8: Unneeded variable: "ret". Return "0" on line 137
>
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pic32.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
> index 6ce1519ae177..6696b6bdd88e 100644
> --- a/drivers/mmc/host/sdhci-pic32.c
> +++ b/drivers/mmc/host/sdhci-pic32.c
> @@ -121,10 +121,9 @@ static void pic32_sdhci_shared_bus(struct platform_device *pdev)
>         writel(bus, host->ioaddr + SDH_SHARED_BUS_CTRL);
>  }
>
> -static int pic32_sdhci_probe_platform(struct platform_device *pdev,
> +static void pic32_sdhci_probe_platform(struct platform_device *pdev,
>                                       struct pic32_sdhci_priv *pdata)
>  {
> -       int ret = 0;
>         u32 caps_slot_type;
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>
> @@ -133,8 +132,6 @@ static int pic32_sdhci_probe_platform(struct platform_device *pdev,
>         caps_slot_type = (host->caps & SDH_CAPS_SDH_SLOT_TYPE_MASK) >> 30;
>         if (caps_slot_type == SDH_SLOT_TYPE_SHARED_BUS)
>                 pic32_sdhci_shared_bus(pdev);
> -
> -       return ret;
>  }
>
>  static int pic32_sdhci_probe(struct platform_device *pdev)
> @@ -193,11 +190,7 @@ static int pic32_sdhci_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_base_clk;
>
> -       ret = pic32_sdhci_probe_platform(pdev, sdhci_pdata);
> -       if (ret) {
> -               dev_err(&pdev->dev, "failed to probe platform!\n");
> -               goto err_base_clk;
> -       }
> +       pic32_sdhci_probe_platform(pdev, sdhci_pdata);
>
>         ret = sdhci_add_host(host);
>         if (ret)
> --
> 2.20.0
>
