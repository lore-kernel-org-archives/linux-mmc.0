Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D665C04FF3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07DF61370
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhEXOMg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbhEXOMf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:12:35 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF02CC061756
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:07 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id f11so14309912vst.0
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8r4bo8gsbRyIPgF8KAG8I7WkdYWQ5gt/261UAryZL4=;
        b=GHi0cPhU9oDBESG9+TM6G/GhZIln+GIfYOIA5QgOdKgxMj+qXbN+tu4hhblS2l7Ahg
         xUEdLSduawNFUyCeAZ6svc02kUjmsQxvtZvNGn0ODrHrf2QctmZcu7s48QD9a1JLY0cS
         eeam6EDEqAy5MWcA2qWqAS+QtUHSc2lDmH20/pmuuiuxa2rar1JFeo2QMXW4lCadDDiQ
         MWYQY8zA98SgyO7NHS87gqlCnkuwjl8Vv5JZsCJzhzLWpIBH5/F4SD5VjnfW+BmsJRRY
         m2hoLVFr2SDWn0lS0bTm1+eCxAz2yfo188dKAVl4CoHsPU6SFbzYqnETPRfLIKKNkYaE
         p6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8r4bo8gsbRyIPgF8KAG8I7WkdYWQ5gt/261UAryZL4=;
        b=Q2S9am8CUdkxTIGxt4varrOo0tzGTdrXQD4Nq4oVmU7W1Oke2OIhHk/LDUDkT/Ey+0
         3wYtpInFsk49Jb9DZqH13GzrsNImCgFdIMLPvHiQCvfnDTtem/g8oNFhwZ2g46CmxoEZ
         x5kUEz5lAPTSt5F40e76CjWCR5KWYpxhfhtLsG4/NPXPUUKUgxyLs7m7jF4OQ3Kt6UhP
         8stm9aRQvrZ8KXvrDR7KNxTzmKHfEkzvKmC1x7W2mCNmKaGi4HfGMlp1mXvdTmOX6BzV
         XAD1QdQTGuY+KautVhO2K9pYRKUvEGE3y0xkhPmjjzH6hI7G9p0Nnzbi2pQauISqJaQV
         5Tjg==
X-Gm-Message-State: AOAM5326udzSvmAlBUmCk+5QZ4DzKzkL4LARLsFK1dIE7dwn6AxPMNmX
        G4nTyCLU60RkEC58ax+wPhpvn8nkQcDmGDui0zbnCc6Y4L4XqA==
X-Google-Smtp-Source: ABdhPJy6WStver9UDbuFr/jJwakaTnngwpeiRYAPELp+UiVB+lu0JsfWTKagpKwQjL4zO3pUEfLg2cGGwN55/mZIlDs=
X-Received: by 2002:a05:6102:7b4:: with SMTP id x20mr22283215vsg.48.1621865466910;
 Mon, 24 May 2021 07:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFrFGo9gmG+EH2hS4oXPn5Jx9v8Pk8jKgvm9KW4Mdk+85A@mail.gmail.com>
 <20210511163944.1233295-1-ztong0001@gmail.com>
In-Reply-To: <20210511163944.1233295-1-ztong0001@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:26 +0200
Message-ID: <CAPDyKFr-_NUpAfZzwrtokRY5+yEw+iYMHoZR5QVd3dbjJV51Tg@mail.gmail.com>
Subject: Re: [PATCH v2] memstick: rtsx_usb_ms: fix UAF
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 11 May 2021 at 18:40, Tong Zhang <ztong0001@gmail.com> wrote:
>
> This patch fixes the following issues:
> 1. memstick_free_host() will free the host, so the use of ms_dev(host) after
> it will be a problem. To fix this, move memstick_free_host() after when we
> are done with ms_dev(host).
> 2. In rtsx_usb_ms_drv_remove(), pm need to be disabled before we remove
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
> Co-Developed-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: remove useless code in err_out label
>
>  drivers/memstick/host/rtsx_usb_ms.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
> index 102dbb8080da..29271ad4728a 100644
> --- a/drivers/memstick/host/rtsx_usb_ms.c
> +++ b/drivers/memstick/host/rtsx_usb_ms.c
> @@ -799,9 +799,9 @@ static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
>
>         return 0;
>  err_out:
> -       memstick_free_host(msh);
>         pm_runtime_disable(ms_dev(host));
>         pm_runtime_put_noidle(ms_dev(host));
> +       memstick_free_host(msh);
>         return err;
>  }
>
> @@ -828,9 +828,6 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
>         }
>         mutex_unlock(&host->host_mutex);
>
> -       memstick_remove_host(msh);
> -       memstick_free_host(msh);
> -
>         /* Balance possible unbalanced usage count
>          * e.g. unconditional module removal
>          */
> @@ -838,10 +835,11 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
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
