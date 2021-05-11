Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A835C433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA3E615FF
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhEKKlp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 06:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEKKl3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 06:41:29 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A070CC061763
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:40:23 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id x17so5627882vsc.0
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwwYKeNCyndTNAvylWwyrfKxcbGHa+q5RnfN1gDWsBE=;
        b=YUPYL0EFXqzYf8ADC9pMn6hkPniLYqWvu7nESNOp0DPCAuu8nluHe1zegt0ol++M1J
         ctjHeaw2hwb09kotwIWX/aq5BgxTgX3SdU/7r1SYkkoQ4Ko9RHtBbscvvyeNNo42ew8W
         24RGW2YffArnU3p0tVNxsRsXaIdruS9V1E+g1x7dRxds6iX0lo8Nti6oTT+LMiXgy4SE
         VLXuVyb02Lnin3tHTlClA++jE907u45LQpLDwrKAM6Ww0YRJ/e39c/F1dGucWkDRCEQ0
         vXbsZhzdmlIhckeihIjRldg5UYQkrbO2cAlgssIkYyurCu9ISrLSXVreUnlmZ2TyM/mO
         FAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwwYKeNCyndTNAvylWwyrfKxcbGHa+q5RnfN1gDWsBE=;
        b=lms5QcDdBPxQGmm/o6gHQ1WI1oy5yLM//o7HJKL1xwMSeWdjDb1yG89VHUCnDJwnYc
         EtCY+TZkoQbCfoRdwRr3FAHa8DK2KbOlp9osdvfUx0LsZ1s8NBS+SXv3XidAAXrTr1Nu
         UjbMJMb1p44E0/D9cauEnYhyJL4d1mTzE8+whWudveOtZ8chs8m3+vMfs+fMoCNhYJKE
         JmnzJ6TSw3xM8GLal/hjo7AZ99ixxiBpvwnGh2qudxQ+aCLfUZiLrwEQSRe/7eGWcd2V
         2w1h8RZIfzbKMS6c0kJNLdfZWyIoLf4mg/GMhNkSp5Su1cjS67XPs8n7MB9CYPr4EJkM
         4mvg==
X-Gm-Message-State: AOAM530yY8NalR8AKi5D6pkCuQ0D8/uUw06qsYXgneA+xoR7Q7U4dtgY
        BvAiI/umRfV6aJpGF/VXjXYHBgQ6HoY/b3KK3cEdXQ==
X-Google-Smtp-Source: ABdhPJxo1S0gZcAzYHlpyqqsVcd7walSOA63q4+N7ZZdgxKV0Dv5LEaFEs1fc2CPPn/jgbWVrlWAAG8CBMyIA4H+pWc=
X-Received: by 2002:a67:2c03:: with SMTP id s3mr24276088vss.42.1620729622695;
 Tue, 11 May 2021 03:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210509215416.950337-1-ztong0001@gmail.com>
In-Reply-To: <20210509215416.950337-1-ztong0001@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:39:46 +0200
Message-ID: <CAPDyKFrFGo9gmG+EH2hS4oXPn5Jx9v8Pk8jKgvm9KW4Mdk+85A@mail.gmail.com>
Subject: Re: [PATCH] memstick: rtsx_usb_ms: fix UAF
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 9 May 2021 at 23:54, Tong Zhang <ztong0001@gmail.com> wrote:
>
> This patch fixes the following issues:
> 1. memstick_free_host() will free the host, so the use of ms_dev(host) after
> it will be a problem. To fix this, move memstick_free_host() after when we
> are done with ms_dev(host).
> 2. if something bad happens in memstick_add_host() and we end up taking
> err_out in rtsx_usb_ms_drv_probe(), we'd better avoid running rtsx_usb_ms_drv_remove()

If the ->probe() function returns a negative error code, the driver
core will not invoke the corresponding ->remove() callback.

Looks like you may want to double check that ->probe() doesn't return
0, even in case of failure.

> 3. In rtsx_usb_ms_drv_remove(), pm need to be disabled before we remove
> and free host otherwise memstick_check will be called and UAF will
> happen.
>
> [   11.351173] BUG: KASAN: use-after-free in rtsx_usb_ms_drv_remove+0x94/0x140 [rtsx_usb_ms]
> [   11.357077]  rtsx_usb_ms_drv_remove+0x94/0x140 [rtsx_usb_ms]
> [   11.357376]  platform_remove+0x2a/0x50
> [   11.367531] Freed by task 298:
> [   11.368537]  kfree+0xa4/0x2a0
> [   11.368711]  device_release+0x51/0xe0
> [   11.368905]  kobject_put+0xa2/0x120
> [   11.369090]  rtsx_usb_ms_drv_remove+0x8c/0x140 [rtsx_usb_ms]
> [   11.369386]  platform_remove+0x2a/0x50
>
> [   12.038408] BUG: KASAN: use-after-free in __mutex_lock.isra.0+0x3ec/0x7c0
> [   12.045432]  mutex_lock+0xc9/0xd0
> [   12.046080]  memstick_check+0x6a/0x578 [memstick]
> [   12.046509]  process_one_work+0x46d/0x750
> [   12.052107] Freed by task 297:
> [   12.053115]  kfree+0xa4/0x2a0
> [   12.053272]  device_release+0x51/0xe0
> [   12.053463]  kobject_put+0xa2/0x120
> [   12.053647]  rtsx_usb_ms_drv_remove+0xc4/0x140 [rtsx_usb_ms]
> [   12.053939]  platform_remove+0x2a/0x50
>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/memstick/host/rtsx_usb_ms.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
> index 102dbb8080da..851643d007b7 100644
> --- a/drivers/memstick/host/rtsx_usb_ms.c
> +++ b/drivers/memstick/host/rtsx_usb_ms.c
> @@ -799,9 +799,10 @@ static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
>
>         return 0;
>  err_out:
> -       memstick_free_host(msh);
>         pm_runtime_disable(ms_dev(host));
>         pm_runtime_put_noidle(ms_dev(host));
> +       memstick_free_host(msh);
> +       platform_set_drvdata(pdev, NULL);
>         return err;
>  }
>
> @@ -811,6 +812,8 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
>         struct memstick_host *msh = host->msh;
>         int err;
>
> +       if (!host)
> +               return 0;

According to my comment above. You should not reach this point, unless
->probe() was successful and returned 0.

>         host->eject = true;
>         cancel_work_sync(&host->handle_req);
>
> @@ -828,9 +831,6 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
>         }
>         mutex_unlock(&host->host_mutex);
>
> -       memstick_remove_host(msh);
> -       memstick_free_host(msh);
> -
>         /* Balance possible unbalanced usage count
>          * e.g. unconditional module removal
>          */
> @@ -838,10 +838,11 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
>                 pm_runtime_put(ms_dev(host));
>
>         pm_runtime_disable(ms_dev(host));
> -       platform_set_drvdata(pdev, NULL);
> -
> +       memstick_remove_host(msh);
>         dev_dbg(ms_dev(host),
>                 ": Realtek USB Memstick controller has been removed\n");
> +       memstick_free_host(msh);
> +       platform_set_drvdata(pdev, NULL);
>
>         return 0;
>  }
> --
> 2.25.1
>

Besides the above, the change looks reasonable to me.

Kind regards
Uffe
