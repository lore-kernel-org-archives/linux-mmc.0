Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201F8C433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 16:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15FE610CA
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 16:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhEKQmp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 12:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhEKQmn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 12:42:43 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41876C061574;
        Tue, 11 May 2021 09:41:37 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z24so18802173ioj.7;
        Tue, 11 May 2021 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAcAMBeXB+UzEqIBR9PQ8N01qh7SBVFQTz/pGB60gzc=;
        b=tfUP4XE3SfvyUX5EtSsWF9b+hMkqCy3qdlYKBIthHo/JF+Rapwovp/kPe4/efexjVj
         79sEFyVzFwaIpAlCTYOX1tSl3wS8MJjb6s7pyReU39zWctZPRS8Vy0nTtjFbPGqgkMCu
         5zpfUJpsSxqIvg4QUTBeHXX4eHmKhoIHFbP//of+9ymErtN3FwY/jGlrnq0VJOMGsL6l
         od+K1bx8MkSdRGd8D/VV07Jwd5st98ciKHG7NZkeIIiNMvW8cA4C9sEH0DGoNvrFxTEF
         KkwFYZOjynPXoRpMAJvlNnv1wleCPPuRt8oJ1ma6J86usj1IuZSOEHpu8OQysa0rGABX
         K8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAcAMBeXB+UzEqIBR9PQ8N01qh7SBVFQTz/pGB60gzc=;
        b=dBAYVlgz90J5hJh9MaWUL0G675KkR3jMtVx6o2+ACdz9LRIW5vrH5T8Bn0FacjVXu/
         9JJKYts9cAmzS/irhbFAoDaVzS/XfxUVZ84R8DaU+EY3EUJK5fHvec2JZ5wb+nXuSfRC
         VNub53/CpY4FsawQKCjYwqXcKDX8lDXcSrRU0of48Tsic7Y6tfABOX6Kansw5TY0o3vo
         2Db+rrgJkqoDXcyKMBdyRnfi12CZ7vCGItest4GIvEnDGtRt0SMzJYSNhEedk7UIziGn
         qqhWeqIPhO+whhie7NdJTspH2PMMd7gJrbLaX0cLMn5WVwsD7l8dtxQ25WAsOjtmahIt
         kNXA==
X-Gm-Message-State: AOAM533URzvUlBfy5vT9wHhXPfvLXHxJlf015hqGQ+YgGY5mWrvcIp9o
        Xo/pUhsEqrJsTHki94JrJd8IpTU1JkqQzAda20k=
X-Google-Smtp-Source: ABdhPJwQ8hOvK6/ojNkBTIZdILBedIs7PGErIHw1yqu5tVcZrYFKExLBT7TX/WkPQHh47ORMFginvAzSWDYfuGNGy/E=
X-Received: by 2002:a05:6638:3013:: with SMTP id r19mr28198356jak.36.1620751296655;
 Tue, 11 May 2021 09:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210509215416.950337-1-ztong0001@gmail.com> <CAPDyKFrFGo9gmG+EH2hS4oXPn5Jx9v8Pk8jKgvm9KW4Mdk+85A@mail.gmail.com>
In-Reply-To: <CAPDyKFrFGo9gmG+EH2hS4oXPn5Jx9v8Pk8jKgvm9KW4Mdk+85A@mail.gmail.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 11 May 2021 09:41:26 -0700
Message-ID: <CAA5qM4AJXxa+Tyx9NAUp5Au24cV76Ch0r_VYETqJAG9N8g_v=Q@mail.gmail.com>
Subject: Re: [PATCH] memstick: rtsx_usb_ms: fix UAF
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, May 11, 2021 at 3:40 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Sun, 9 May 2021 at 23:54, Tong Zhang <ztong0001@gmail.com> wrote:
> >
> > This patch fixes the following issues:
> > 1. memstick_free_host() will free the host, so the use of ms_dev(host) after
> > it will be a problem. To fix this, move memstick_free_host() after when we
> > are done with ms_dev(host).
> > 2. if something bad happens in memstick_add_host() and we end up taking
> > err_out in rtsx_usb_ms_drv_probe(), we'd better avoid running rtsx_usb_ms_drv_remove()
>
> If the ->probe() function returns a negative error code, the driver
> core will not invoke the corresponding ->remove() callback.
>
> Looks like you may want to double check that ->probe() doesn't return
> 0, even in case of failure.
>
> > 3. In rtsx_usb_ms_drv_remove(), pm need to be disabled before we remove
> > and free host otherwise memstick_check will be called and UAF will
> > happen.
> >
> > [   11.351173] BUG: KASAN: use-after-free in rtsx_usb_ms_drv_remove+0x94/0x140 [rtsx_usb_ms]
> > [   11.357077]  rtsx_usb_ms_drv_remove+0x94/0x140 [rtsx_usb_ms]
> > [   11.357376]  platform_remove+0x2a/0x50
> > [   11.367531] Freed by task 298:
> > [   11.368537]  kfree+0xa4/0x2a0
> > [   11.368711]  device_release+0x51/0xe0
> > [   11.368905]  kobject_put+0xa2/0x120
> > [   11.369090]  rtsx_usb_ms_drv_remove+0x8c/0x140 [rtsx_usb_ms]
> > [   11.369386]  platform_remove+0x2a/0x50
> >
> > [   12.038408] BUG: KASAN: use-after-free in __mutex_lock.isra.0+0x3ec/0x7c0
> > [   12.045432]  mutex_lock+0xc9/0xd0
> > [   12.046080]  memstick_check+0x6a/0x578 [memstick]
> > [   12.046509]  process_one_work+0x46d/0x750
> > [   12.052107] Freed by task 297:
> > [   12.053115]  kfree+0xa4/0x2a0
> > [   12.053272]  device_release+0x51/0xe0
> > [   12.053463]  kobject_put+0xa2/0x120
> > [   12.053647]  rtsx_usb_ms_drv_remove+0xc4/0x140 [rtsx_usb_ms]
> > [   12.053939]  platform_remove+0x2a/0x50
> >
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > ---
> >  drivers/memstick/host/rtsx_usb_ms.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
> > index 102dbb8080da..851643d007b7 100644
> > --- a/drivers/memstick/host/rtsx_usb_ms.c
> > +++ b/drivers/memstick/host/rtsx_usb_ms.c
> > @@ -799,9 +799,10 @@ static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
> >
> >         return 0;
> >  err_out:
> > -       memstick_free_host(msh);
> >         pm_runtime_disable(ms_dev(host));
> >         pm_runtime_put_noidle(ms_dev(host));
> > +       memstick_free_host(msh);
> > +       platform_set_drvdata(pdev, NULL);
> >         return err;
> >  }
> >
> > @@ -811,6 +812,8 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
> >         struct memstick_host *msh = host->msh;
> >         int err;
> >
> > +       if (!host)
> > +               return 0;
>
> According to my comment above. You should not reach this point, unless
> ->probe() was successful and returned 0.
>
> >         host->eject = true;
> >         cancel_work_sync(&host->handle_req);
> >
> > @@ -828,9 +831,6 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
> >         }
> >         mutex_unlock(&host->host_mutex);
> >
> > -       memstick_remove_host(msh);
> > -       memstick_free_host(msh);
> > -
> >         /* Balance possible unbalanced usage count
> >          * e.g. unconditional module removal
> >          */
> > @@ -838,10 +838,11 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
> >                 pm_runtime_put(ms_dev(host));
> >
> >         pm_runtime_disable(ms_dev(host));
> > -       platform_set_drvdata(pdev, NULL);
> > -
> > +       memstick_remove_host(msh);
> >         dev_dbg(ms_dev(host),
> >                 ": Realtek USB Memstick controller has been removed\n");
> > +       memstick_free_host(msh);
> > +       platform_set_drvdata(pdev, NULL);
> >
> >         return 0;
> >  }
> > --
> > 2.25.1
> >
>
> Besides the above, the change looks reasonable to me.
>
> Kind regards
> Uffe
Thanks Uffe!
I modified the patch as suggested and sent as v2.
Best,
- Tong
