Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85038C04FF3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6A46108E
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhEXONS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhEXOND (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:13:03 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9295DC061347
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 131so33774756ljj.3
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oVkqiUNC05WGekjk5abJeJoD4B7Y5rec3Y08fM9/NU=;
        b=XXbvJx2PdKqEf9U/G/+w//9RJ4JJ9aBe6lybA6mrteKFL+FuDmTsAuzuDfyL4SvPAJ
         Vsi2O+Q8v/NGr0oKiZD/deoilFeOlW8SQuhoEee4ao7Cvubda/z+KDc24DsCML53OcIe
         TcwALIkjuABdJYvw7BfU6NSUdNKai0HTFkrpzVsYZ4ime38MX2PMayGzeHnmOm19J3fi
         MUUWmcLKMLLfqaTStMRifdfGH7PStCiVk81GC3pmkFtw16pYtMvFHU8Kv9aaSvFecaAU
         9yhS1s2Mkd2DPA8Na9KML3Y3oXQ96xGTzXAsCYGwdRAK0jm4ey1mkucRlE6xL156dY0m
         cAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oVkqiUNC05WGekjk5abJeJoD4B7Y5rec3Y08fM9/NU=;
        b=WdKRr12MCMrSlhv4Ydz/utSbSZx2wiYNPOaJ5QYio20AErY3/1muf7tUg+fBqOBgWg
         Cu9dQhpFEm06GmKIEUtfhWrccnTO/6XAeNDHv5FXjkYeBEMz6J6QI1DwdIxw2v6QmAdu
         cUlw1VL2uiU+c/XRIc4H4cFI67L4kyt0t0dGPvBabsAOBb3xZI2N8C2wME9bP4wz0zlg
         khtORD2YTWUgTjVE6GUJyMnrWBogQkFIbErG4OmHjIhfByZ4z8cWyWC0w8L7jDW3EvVX
         1kmuz1ssk2Eo7CyBQWpV3nSFxJIJtfpNg7mH/YpA2QWMiq6kNynzlYGvOOXmOE8x5ltI
         UOAA==
X-Gm-Message-State: AOAM532LY8x3RnCEJVVk5XvxFpHdfZZV0vmGfXqz3PP1LClDxX7twzQ4
        DWe+9eeQf6qDgdzgs/hNq4OQel5xBxyIvCBcnV0gmhHu1enxRA==
X-Google-Smtp-Source: ABdhPJxv/j1I6P+9y/Q+b7xa/Pmg5EMIaVn+FNdnivOWqiYRZYNBeUJXTdfJbhoq/+mZhwEtIOa5VSYStG0brOaI7/A=
X-Received: by 2002:a2e:b819:: with SMTP id u25mr16749270ljo.182.1621865493304;
 Mon, 24 May 2021 07:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <1621558775-31185-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1621558775-31185-1-git-send-email-tiantao6@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:54 +0200
Message-ID: <CAPDyKFr+qo35FgBufCWhAgefyREhFgxMdzwCxDg1FAJHOLv0Tw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Use pm_runtime_resume_and_get() to
 replace open coding
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 21 May 2021 at 02:59, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> use pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. this change is just to simplify the code, no
> actual functional changes.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 1fad6e4..f654afb 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -809,11 +809,9 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>
>         /* Clocks are enabled using pm_runtime */
>         pm_runtime_enable(dev);
> -       ret = pm_runtime_get_sync(dev);
> -       if (ret < 0) {
> -               pm_runtime_put_noidle(dev);
> +       ret = pm_runtime_resume_and_get(dev);
> +       if (ret)
>                 goto pm_runtime_disable;
> -       }
>
>         base = devm_platform_ioremap_resource(pdev, 1);
>         if (IS_ERR(base)) {
> --
> 2.7.4
>
