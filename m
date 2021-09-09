Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAFEC433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Sep 2021 14:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5284F611C4
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Sep 2021 14:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhIIOwS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbhIIOwR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Sep 2021 10:52:17 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D29AC061574
        for <linux-mmc@vger.kernel.org>; Thu,  9 Sep 2021 07:51:08 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i3-20020a056830210300b0051af5666070so2800105otc.4
        for <linux-mmc@vger.kernel.org>; Thu, 09 Sep 2021 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHiuE2OiEXe434H1xcWuo0fgF0pvMhHeANpuYRG86uk=;
        b=TJZR5fyjjKCP6sE6kBKth3oqDI5bvePDlzAtu3WZ/DUz8oxFyLNKUc+8ldEWbsB20m
         VjMZNdVvacpdvJtxqP5++lHldHQVQjqaNyR+YXw0b1DFKtQcSQE3JKNs/sZLX3sWNp7k
         FCyYZVkz37NfwGvmi0J19R1aK4CUzn9QKipk6gVo14kDzhPmIGm66ElWNyDUrazoPfsN
         Pag04bnAIk0i4fBikT79Z5WJTSQrYkB+LaLHNg6hvKgX45T/Wy5r2jBp26huJcbpR5g5
         /YXT8PsaW6C/RenNWjhbfMrYQON/pu8onVPkQoy8S7LGrcN7P6cHEBiUyFtLuftedf1E
         k4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHiuE2OiEXe434H1xcWuo0fgF0pvMhHeANpuYRG86uk=;
        b=s+a8htkBRMEGxO6cOYmIkbo3qtDPE2/9ppExZRkOyMNlWKVDzehAqMnOaVlteyRdp6
         XcBURq8VMXZF5HBNHBfIOypQCfNKp4AVeQ7Jte4t0XF/kelyxkZJfzxVzntxiMpDmwbR
         GLRQDyIy/A8IjDdz2L6/LppFcjPskhzg+KvOPVumzRvd77Cf9c92uHdzB42XoXV6EoOf
         RBFN0Qc40wNCogLCBOUTRdTbIzZsLqHHenQe8XRfLIoNhmCjHluNjcBbKI1cppWmoTkD
         uOXwGJBDkLkS28uvjKBbwWMlkDJAT/PVNg5W0bAgfgnvj1G9+cQ8UbRQzBGskm1ugyRR
         3v9w==
X-Gm-Message-State: AOAM531KrjDDQMvJRkJH7oeVTVJlQHAjuL+w/7OrDGhjCyLyGNkUYzmy
        coBierFsw5srh00sNZXmQMw1yo4+CDfSSNLMzDPfGw==
X-Google-Smtp-Source: ABdhPJweezDPGeY3ZyJBi0eplFeYrpL4I+fJ1nvgj7GoFMZNLvwoyIoq/QtEUcmQvRXlPHkn02d9XTMwWqoUV8oZEIg=
X-Received: by 2002:a9d:17c5:: with SMTP id j63mr231177otj.208.1631199067794;
 Thu, 09 Sep 2021 07:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210907025940.1535-1-caihuoqing@baidu.com>
In-Reply-To: <20210907025940.1535-1-caihuoqing@baidu.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Sep 2021 16:50:31 +0200
Message-ID: <CAPDyKFrWdXBc8WncS=8AeoAGLeEUjbnOsG0cmimTz46GCn2C5Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: omap_hsmmc: Make use of the helper macro SET_RUNTIME_PM_OPS()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 7 Sept 2021 at 04:59, Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> Use the helper macro SET_RUNTIME_PM_OPS() instead of the verbose
> operators ".runtime_suspend/.runtime_resume", because the
> SET_RUNTIME_PM_OPS() is a nice helper macro that could be brought
> in to make code a little more concise.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Queued for v5.16 on the temporary devel branch, thanks!

Kind regards
Uffe


> ---
> v1->v2: *Add "#ifdef CONFIG_PM" around runtime_suspend|resume().
>         *Remove the unused implementation of omap_hsmmc_context_restore()
>
>  drivers/mmc/host/omap_hsmmc.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 2f8038d69f67..7a29ad542e4a 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -702,11 +702,6 @@ static void omap_hsmmc_context_save(struct omap_hsmmc_host *host)
>
>  #else
>
> -static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
> -{
> -       return 0;
> -}
> -
>  static void omap_hsmmc_context_save(struct omap_hsmmc_host *host)
>  {
>  }
> @@ -2086,6 +2081,7 @@ static int omap_hsmmc_resume(struct device *dev)
>  }
>  #endif
>
> +#ifdef CONFIG_PM
>  static int omap_hsmmc_runtime_suspend(struct device *dev)
>  {
>         struct omap_hsmmc_host *host;
> @@ -2153,11 +2149,11 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
>         spin_unlock_irqrestore(&host->irq_lock, flags);
>         return 0;
>  }
> +#endif
>
>  static const struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
> -       .runtime_suspend = omap_hsmmc_runtime_suspend,
> -       .runtime_resume = omap_hsmmc_runtime_resume,
> +       SET_RUNTIME_PM_OPS(omap_hsmmc_runtime_suspend, omap_hsmmc_runtime_resume, NULL)
>  };
>
>  static struct platform_driver omap_hsmmc_driver = {
> --
> 2.25.1
>
