Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CFEC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Jan 2022 12:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245408AbiAJMUL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Jan 2022 07:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245395AbiAJMTz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jan 2022 07:19:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D73AC061757
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jan 2022 04:19:54 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x7so43582762lfu.8
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jan 2022 04:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDC9MBEjp6c17/86zespiJo5xQbtvKHVX6cjPao7rRQ=;
        b=jGIUfvfOPF0OmVBWIwKao22Tzp6qqKbnrVBOE7wsH9EKtNgh/m0jtKgy+ci411bce0
         NbeWz5FN6rmmWvGIhO5GHluJdD9rHbB92oUcD2cIaGw5WUpGsnmbLMWuBpq763QNe4lj
         lfuccdhmlBRR4pQMIwp2GzklPb0fxOL0lmotLOiLCjoagyy0FIINqFXKRqRo+Uba5Ypr
         eqQ9Qjq72SfhDaZbYC+enhPdedTkOhK39vZOB8o/YhKEV6d9Ub0VW+/7ZgtTSaGqGlXN
         ot1OPFD/lFiISlylg774qwTh0czw0HqARYvc0/I3B3ApQOgbIr4e1J5t/MBw2D17JK0m
         Mqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDC9MBEjp6c17/86zespiJo5xQbtvKHVX6cjPao7rRQ=;
        b=RbnIiE3s6QdYyjYPkRvW6Kg+y399AaRifRt6aylEQ7eXKJdmXroTDgYue+LywRDkfS
         x5h/sZBLLUKAwiJUUDk5Rv6RiHjV7CSKhrUkKoD2lLIV+dUV2MlVmRPWkDWnVbYC8I/W
         Dm81xKpOqWIdtzMZdxvr+YIvUX4RPV4Jatbax1dC0skyGPZslsJlZ6Aw4D2FcnspUCcg
         GZj7oK3PCDxA6TC4jyPO89tunIDVIm7y1bcAC065oDA8Cl4nSYo1fxrHH2Vpr8iqicGJ
         OHhb8BuuGN8vd3wYukAI2ar+BBRhu670rJoZr2z3svAoRwBBXo3zSLFjgWh+tZv3wWND
         95tA==
X-Gm-Message-State: AOAM530iuv2NjidyR/b0AFhigiYBpXqGZt8TSHsxaD3fZ07h/jCN5GAp
        tU7hY7BnI7D38FOwucFb8JuLVSF34qi1/t8X4Jb9gw==
X-Google-Smtp-Source: ABdhPJy1C50fectbijLg4DCD2D5ERyiL+ri6Nr17WrnwGBIfoqEH4v11ebD4j6YRrSJcQVjIPoUW6mX/5tyJbrqH8HY=
X-Received: by 2002:a19:6748:: with SMTP id e8mr35584329lfj.358.1641817192502;
 Mon, 10 Jan 2022 04:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20220107181723.54392-1-paul@crapouillou.net> <20220107181723.54392-6-paul@crapouillou.net>
In-Reply-To: <20220107181723.54392-6-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jan 2022 13:19:16 +0100
Message-ID: <CAPDyKFozm+w+vhbeChzdh4PN73Xra3V0+ip7NBTG4Cnb9grGxg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] PM: runtime: Add EXPORT[_GPL]_RUNTIME_DEV_PM_OPS macros
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 7 Jan 2022 at 19:17, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Similar to EXPORT[_GPL]_SIMPLE_DEV_PM_OPS, but for users with runtime-PM
> suspend/resume callbacks.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Notes:
>     v2: No change
>     v3: Add comment about the necesity to use the new export macro when
>         the dev_pm_ops has to be exported
>
>  include/linux/pm_runtime.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 4af454d29281..9f09601c465a 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -30,12 +30,22 @@
>   * macro, which uses the provided callbacks for both runtime PM and system
>   * sleep, while DEFINE_RUNTIME_DEV_PM_OPS() uses pm_runtime_force_suspend()
>   * and pm_runtime_force_resume() for its system sleep callbacks.
> + *
> + * If the underlying dev_pm_ops struct symbol has to be exported, use
> + * EXPORT_RUNTIME_DEV_PM_OPS() or EXPORT_GPL_RUNTIME_DEV_PM_OPS() instead.
>   */
>  #define DEFINE_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
>         _DEFINE_DEV_PM_OPS(name, pm_runtime_force_suspend, \
>                            pm_runtime_force_resume, suspend_fn, \
>                            resume_fn, idle_fn)
>
> +#define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> +       _EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> +                          suspend_fn, resume_fn, idle_fn, "")
> +#define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> +       _EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> +                          suspend_fn, resume_fn, idle_fn, "_gpl")
> +
>  #ifdef CONFIG_PM
>  extern struct workqueue_struct *pm_wq;
>
> --
> 2.34.1
>
