Return-Path: <SRS0=9Cpo=BG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8872FC433E3
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 11:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617C520786
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595850911;
	bh=2LpVQb22XDP5zM/7Q/xAJAKLUUWulMeGGzIIPzgP68o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EJnlS5viWWjwbXLc/Dp84b05/GmdAZ7HStFAtfdNuewzMP0KHiBlX1RQFAioOSDPD
	 P4oDkn0N5ltgVEWpZHR4qqMv7kswPTI2vavPIges9y9T0jpKp5tpbnukEWqDahfjs/
	 LJbkO2q2az7YqmcMi7iMYGfQMafucNmTZvzxPHCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgG0LzF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:55:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44981 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgG0LzF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jul 2020 07:55:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id k6so14060699oij.11;
        Mon, 27 Jul 2020 04:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+nMscq6n0UM4f049oAnE2J85xvPdNxrPg8zduxodr20=;
        b=ZqpdNN5aPdbLPhCaHe1P+3sn7Gf0+2QUC0450JpfxOipBWk2D0JXIfd/ZPCq/IPHfv
         fsAbcTh9ltH3J4AgNxPMbXRCPJ0+ERrOHGlfkBjfbbxkKrZaa8kYlBdb15abZsWVf+IO
         LwD/H01jN6UWIWkgPkJdD2M4qoFfxTa++dwAMEuVIht0QTCjotY9BJdVX1ZRl9dZxz6m
         fNl7VhWm8EUz7pxsyYHetSZase1Q/kKtivsS5BBfqmkA8nu0yUr0AFywPwJBR/lNrPNp
         20guLKfKB3GwBERDs8mqtGE5dCdmAsCOhxZk5u9rimZblXMJf9cqG0bbkq8BDlOyTdGz
         b3WQ==
X-Gm-Message-State: AOAM530DZFkk6EcBcS/W0u7Quw43zUzsm+cp1A5cih0G2b40Lv2tL0G7
        jJDR51VgU29xDfvwxYNeQB4T+CBimW7EW/CXAJGHvw==
X-Google-Smtp-Source: ABdhPJzLcKyAF3Dl+QDQe69GM5quHd38ofFnHcNd4Wk3jS8Fyhn6THBfHPLb95IImnttADRoc1kFXBoiwyiIAfoIPWE=
X-Received: by 2002:a05:6808:34e:: with SMTP id j14mr18450437oie.110.1595850904464;
 Mon, 27 Jul 2020 04:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200716124250.9829-1-paul@crapouillou.net>
In-Reply-To: <20200716124250.9829-1-paul@crapouillou.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 13:54:35 +0200
Message-ID: <CAJZ5v0ju0KhXdfniZYqmZs+EmMx4U01RJZu3DVYazPYk6pK=Cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: introduce pm_ptr() macro
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>, od@zcrc.me,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jul 16, 2020 at 2:43 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> This macro is analogous to the infamous of_match_ptr(). If CONFIG_PM
> is enabled, this macro will resolve to its argument, otherwise to NULL.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Notes:
>     v2: Remove pm_sleep_ptr() macro
>     v3: Rebase on 5.8-rc5 and add Ulf's Reviewed-by
>
>  include/linux/pm.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 121c104a4090..1f227c518db3 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -374,6 +374,12 @@ const struct dev_pm_ops name = { \
>         SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>  }
>
> +#ifdef CONFIG_PM
> +#define pm_ptr(_ptr) (_ptr)
> +#else
> +#define pm_ptr(_ptr) NULL
> +#endif
> +
>  /*
>   * PM_EVENT_ messages
>   *
> --

Applied along with the [2-3/3] as 5.9 material, thanks!
