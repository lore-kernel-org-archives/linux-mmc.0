Return-Path: <SRS0=Yb6F=6F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AF1C54FC9
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Apr 2020 10:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 348B42071C
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Apr 2020 10:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZb0j1AD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgDUKkC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDUKkB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Apr 2020 06:40:01 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD897C061A41
        for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2020 03:39:59 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id y185so8085297vsy.8
        for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2020 03:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWOnko77txal0K7pJvRHJBebpvxdOfp3TVzw/ZvqiSM=;
        b=sZb0j1ADnFw2pQCOR1I1/JAIJ2vP4Lj+6zzr6vrUr1JZpY+SKjo0VNeVwo35qRCV+F
         1PPJMFAXIMfTGbxOXoZVrDf4gUZcRWtESA1GBPl60kn1gEdf5gq6fuwNsXgGh4eG28Yz
         ZCr/66YuuY54OOylETzfZ17pWqnkCBWP/fxDWULm5idzduPopFhWtKSajwoZg2GehXJx
         nbIQcoW8hWGVGSw73GXi1zBuTqJzyH0yKhBtjNENJlQ/1Hhp6xz73dZStiIjb+jT/Jkd
         KedNNlRpRTAdqOhMd/jZ2wkg5Fv6T82MGFWxWfAM8S9LMNKw6ywmJ9bqrBm6MTtBi3tb
         CRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWOnko77txal0K7pJvRHJBebpvxdOfp3TVzw/ZvqiSM=;
        b=ty9dXPQWFWEwJnlj79zQFo6C6CMy7+jqxzanRvwJU9m6tB8PSCKAWJ4svC3uKSq2i0
         aqYgajO7farDEAyCmTU5oNx35mNdhQZ6s62kLYpV9QS8sR9Qhrnsq9Bjv7R6bMZSm3uG
         2Wf/17KfsY6xAisiBfQ8E15L+/DWp8g7T6y9AbQTtdQV+rbuiMVsDGoVv6c6t3vQX9bm
         6QOZUQ+AjFhbLx6A1DVux6AICySR6l/YvxGiSwgMlH6EEQfKe6/F+YDq/p9qESII69DE
         Y5W/9iixA6+06Kp444ukhKytV7Mvd+RgM05DnOYhqlpId+Jy8k7N0JMUp5yxvvipWXRK
         KcKw==
X-Gm-Message-State: AGi0PubOUlaoEwzduy/OK/zmD0vbzG38F3P1VKF4F7WUB1KUh4t1Hi47
        Xv0J7zo+lC9PNaWjYCEUk+iODzwBCxMP+CWjm9yMZQ==
X-Google-Smtp-Source: APiQypKISV66Pw/5T+dsPNqBQ+0UbOK10keNAQzmOGZsGfLJ0yfsb04HQOYUoTZ32K7OtcDuVGegOMCuwdmU2fcyQrk=
X-Received: by 2002:a67:ead1:: with SMTP id s17mr14820744vso.200.1587465598574;
 Tue, 21 Apr 2020 03:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200413123207.74552-1-paul@crapouillou.net> <20200413123207.74552-3-paul@crapouillou.net>
In-Reply-To: <20200413123207.74552-3-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Apr 2020 12:39:22 +0200
Message-ID: <CAPDyKFrRMzzodhWSC2tgMSSNBwLcowd7q48_6dFPGuHUD_CUZg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: jz4740: Use pm_ptr() macro
To:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        od@zcrc.me,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Apr 2020 at 14:32, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Use the newly introduced pm_ptr() macro to simplify the code.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

To me, the series is a step in the right direction. Perhaps there is a
better name than "pm_ptr", but that's just a nitpick.

That said, feel free to add (for all three patches in the series):
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Let's see what Rafael thinks about this.

Kind regards
Uffe

> ---
>
> Notes:
>     v2: Use pm_ptr() macro instead of pm_sleep_ptr()
>
>  drivers/mmc/host/jz4740_mmc.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index fbae87d1f017..2d41e7e5ec43 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -1099,24 +1099,18 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM_SLEEP
> -
> -static int jz4740_mmc_suspend(struct device *dev)
> +static int __maybe_unused jz4740_mmc_suspend(struct device *dev)
>  {
>         return pinctrl_pm_select_sleep_state(dev);
>  }
>
> -static int jz4740_mmc_resume(struct device *dev)
> +static int __maybe_unused jz4740_mmc_resume(struct device *dev)
>  {
>         return pinctrl_select_default_state(dev);
>  }
>
>  static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
>         jz4740_mmc_resume);
> -#define JZ4740_MMC_PM_OPS (&jz4740_mmc_pm_ops)
> -#else
> -#define JZ4740_MMC_PM_OPS NULL
> -#endif
>
>  static struct platform_driver jz4740_mmc_driver = {
>         .probe = jz4740_mmc_probe,
> @@ -1124,7 +1118,7 @@ static struct platform_driver jz4740_mmc_driver = {
>         .driver = {
>                 .name = "jz4740-mmc",
>                 .of_match_table = of_match_ptr(jz4740_mmc_of_match),
> -               .pm = JZ4740_MMC_PM_OPS,
> +               .pm = pm_ptr(&jz4740_mmc_pm_ops),
>         },
>  };
>
> --
> 2.25.1
>
