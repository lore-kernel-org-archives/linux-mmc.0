Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D159C433C1
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 10:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C78619A1
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 10:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCVK0L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCVK0A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Mar 2021 06:26:00 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A281C061756
        for <linux-mmc@vger.kernel.org>; Mon, 22 Mar 2021 03:26:00 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id e7so7155578vsq.3
        for <linux-mmc@vger.kernel.org>; Mon, 22 Mar 2021 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlgBwg2/OpoiuLdTjiONySB1mOVhMpjYXASTM5AYXtc=;
        b=vKw7B+Wu8kUfIj79tr/6OWZCUMbwLLOqWrzzSbvl5AgKPINw+l3P2PAd12yQ95ycO9
         PJCedxj3+roD8V0WlEcxBRwiqZqOPVWFj5jiYEmnkjEL2eQfN7x5JHGxPr3uK1ZhuvLz
         CL2vnURayg/QDXlUeS1+8qFazYLHbcEZxNMO0BAbORU0GYJOyE/MbNq2Fni3Hvoqkjjk
         J4zRn38kAlV3Na8cyxpNZ4lXVhPR9kbvTAN1/aPESqg6Dsqbq2lXxMRpq3RkCS7rDhNB
         MOSmCrmJel+Sfu1pNZwg2NUX5JY8Zvvzoh2Ztt0cgxtmDQURymgvcnhgg4Ch59cPf/Mb
         lveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlgBwg2/OpoiuLdTjiONySB1mOVhMpjYXASTM5AYXtc=;
        b=jiRnuGri+cfcwvoohkvD3f7cgGCFBHU2TTyqlHLTVdEh+L+R61v6hZqsUiHpquT92q
         XwEA5gUdlOeDAbORprFta+7m9bwL3YDr9tjdan6KPd4KdSJKkcA4Wf+nZesGY5sJQQTz
         gXwIBBtvUamSvtqKvVpJc/PFzGZVP5oNDa1DN0gdR9UwvpJaizkrP7lcXpnwmH2slvsF
         irXBkFk8FfRMj9bqT26TQEFNB431Gdqm0jy1cIu76LUVBhehuXa5ZKzSDvGPrBTaqQA3
         1afMaKyG88LyfNMQrAr8QUuhlrToOKznqN+2CrvtMY3//IJcaTiqP6adBteuBSWx9knZ
         u9mA==
X-Gm-Message-State: AOAM530J9aa9bIvudeXm5nA3Nak9VgxrRAhAl6v690wZ1ewILTssjXuC
        mJz0LY/6Q1DpCuH+J5l5tpCJSRlENPiTdDvATCw8JpMNMYIIgEH0
X-Google-Smtp-Source: ABdhPJzzKFkpgT2QJlRkBleFqHPf6IQZzE/sYVHJ46Tfs8wrpgPq1bPGl5XLoyve//kAW6Uh5KEmxbAwdw5EduVrROo=
X-Received: by 2002:a67:77c1:: with SMTP id s184mr8066406vsc.55.1616408759303;
 Mon, 22 Mar 2021 03:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210320045720.11872-1-chgokhl@gmail.com>
In-Reply-To: <20210320045720.11872-1-chgokhl@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Mar 2021 11:25:23 +0100
Message-ID: <CAPDyKFqXtKPngfnQZXXaF=rvqw0=nWzDc7P++QxNHPwGHHSxUA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Mark mmc_host device with pm_runtime_no_callbacks
To:     kehuanlin <chgokhl@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kehuanlin@fishsemi.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 20 Mar 2021 at 05:57, kehuanlin <chgokhl@gmail.com> wrote:
>
> The rpm_resume() will call parent's resume callback recursively.
> Since mmc_host has no its own pm_runtime callbacks, the mmc devices
> may fail to resume (-ENOSYS in rpm_callback) sometimes. Mark mmc_host
> device with pm_runtime_no_callbacks can fix the issue.

Can you please elaborate more on this? What do you mean by "sometimes"?

More precisely, how do you trigger the rpm_callback() for mmc class
device to return -ENOSYS?

Don't get me wrong, the patch is fine, but I want to understand if it
actually solves a problem for you - or that it's better considered as
an optimization?

Kind regards
Uffe

>
> Signed-off-by: kehuanlin <chgokhl@gmail.com>
> ---
>  drivers/mmc/core/host.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 9b89a91b6b47..177bebd9a6c4 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pagemap.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/pm_wakeup.h>
>  #include <linux/export.h>
>  #include <linux/leds.h>
> @@ -480,6 +481,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         host->class_dev.class = &mmc_host_class;
>         device_initialize(&host->class_dev);
>         device_enable_async_suspend(&host->class_dev);
> +       pm_runtime_no_callbacks(&host->class_dev);
>
>         if (mmc_gpio_alloc(host)) {
>                 put_device(&host->class_dev);
> --
> 2.30.0
>
