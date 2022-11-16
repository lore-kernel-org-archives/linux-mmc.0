Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F8CC4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 16:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiKPQST (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiKPQSJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 11:18:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CDAD135
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:02 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so4036482pjt.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ksBVJef+BrlHHXYAlvYsMylSDtCe2NEmzHtcK4DRi1I=;
        b=kYITbS1u1MGMUwz7OcDfxAIMLt7itX2VLZ4Omg0Evbw7XG5CsLQAkKdrvtlmyvK0FL
         R2Nm50RMdv/bPXZ97UEI5W+892Bnj8juCXBl/C+InGobEXyahK1FPW1v848qP3889zu5
         yblPLIo6aWrhzkfgDzDYej5lxGYTV49/MoblAkHQhr/0eFbwN23izhBhevxcDFlRKUyl
         0fnQRT8OND6x2tO5zNHlzG4PKqB4Y4niBYDuUjxd3r2IbDd1bscogOEhqtwe6kTbbNUR
         LjRv6T3Zu3Gb00ZOjVTQMPpSykSvfZ5rL5CBx7cAy5JZz/a0ZMrui//YeywSuzlcuq5z
         q0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksBVJef+BrlHHXYAlvYsMylSDtCe2NEmzHtcK4DRi1I=;
        b=1TfLzV5So9Xw0aQVWuWxAgRqEOmM+M+4tGzoI0h/xZV7JpAEBMAVqCNNpSJ0zfGT0B
         Qmh/WvCmyOLGJPUHc83vhn+47CH8LGMuJ4uoyg2EIyx8aF+/ZCbg5TO6qm+mj+3MbdL9
         yXpwN2L+fANeuy8wOP9gKR+hHw34UrKav5DF0QFz/lDwHklbE1iDxSWmnAhiaonP10f8
         krvwzghJs1aSw8K8j8zvzBnhCXPIY3qZPi+5RFTMFYFt88fEatAwTDULUhj9zo1+GmF1
         E0M0+IWe6f617nUiQwf2tynNZprFkmNCxpDR2tFhDiAEusGmz5BYZaM6yOpxYVtZr9/O
         rcHw==
X-Gm-Message-State: ANoB5pmYG+ElagM39/2FzcdgnUqJMVd959eHdZucM157yhM87VVx57Cq
        ZIiwk7nFEF6PBgelmkOZo2/njBMOi0mLDFJpwH/HTrFkh+I=
X-Google-Smtp-Source: AA0mqf7kb4ePFZWQo8OZaVnmKDH0e7iACcrjjdkJvGr0DN9iWNKbNKpV3RpYbth9jcy7dvx63b18ByArS922OpUnNpQ=
X-Received: by 2002:a17:902:d48a:b0:188:6baf:2011 with SMTP id
 c10-20020a170902d48a00b001886baf2011mr9114689plg.165.1668615481886; Wed, 16
 Nov 2022 08:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20221109133237.3273558-1-yangyingliang@huawei.com>
In-Reply-To: <20221109133237.3273558-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 17:17:23 +0100
Message-ID: <CAPDyKFqU04TZN8OSa7UX0cXf86mQq-ZsfV1Pe2pZN2GoeOpu2Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: wbsd: fix return value check of mmc_add_host()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org, pierre@ossman.eu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 9 Nov 2022 at 14:34, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> mmc_add_host() may return error, if we ignore its return value,
> it will lead two issues:
> 1. The memory that allocated in mmc_alloc_host() is leaked.
> 2. In the remove() path, mmc_remove_host() will be called to
>    delete device, but it's not added yet, it will lead a kernel
>    crash because of null-ptr-deref in device_del().
>
>
> So fix this by checking the return value and goto error path which
> will call mmc_free_host(), besides, other resources also need be
> released.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/wbsd.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index 67ecd342fe5f..7c7ec8d10232 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -1698,7 +1698,17 @@ static int wbsd_init(struct device *dev, int base, int irq, int dma,
>          */
>         wbsd_init_device(host);
>
> -       mmc_add_host(mmc);
> +       ret = mmc_add_host(mmc);
> +       if (ret) {
> +               if (!pnp)
> +                       wbsd_chip_poweroff(host);
> +
> +               wbsd_release_resources(host);
> +               wbsd_free_mmc(dev);
> +
> +               mmc_free_host(mmc);
> +               return ret;
> +       }
>
>         pr_info("%s: W83L51xD", mmc_hostname(mmc));
>         if (host->chip_id != 0)
> --
> 2.25.1
>
