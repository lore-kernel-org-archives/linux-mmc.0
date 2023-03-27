Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCEFC7619A
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Mar 2023 10:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjC0KaI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Mar 2023 06:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjC0K3b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Mar 2023 06:29:31 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E6F5FC8
        for <linux-mmc@vger.kernel.org>; Mon, 27 Mar 2023 03:29:13 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-53d277c1834so160953547b3.10
        for <linux-mmc@vger.kernel.org>; Mon, 27 Mar 2023 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679912953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCgemJkNZ/8ZgReBw5RuknBsH/Lb1un6tIfXEsMBnRE=;
        b=T00DmUmQp4s6UJXSNo0z/g9VGiq2k8xZhpFTtnhRtcYMNQc1J5qpvxUodlAPFIe16b
         gn9+CU1y2TlepUNOHJ3YB4XZ1rShk9QQTSNGdK5GY+VV/Bu3UtAzV0n50rdSDLAv4Yvy
         ZDlGHHVABW649/cEc3amrO62uMG9SGMYHNESCjrY/eEOwQLE3Cq0FgmRDxgMSrswO2pz
         xHzLIanMq/1UImwlJaE7cnQa/tZDFWS3pyhE9Hvnkg6N6ijqGpl2W3hq+XQoD15ebWE9
         oZo44FlqxqnQxfXyb2Xh+ELIrxnEKNEDHiiWTJT7J4kxUsEFnvZoo0GHfJDznRYnrHoX
         bJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCgemJkNZ/8ZgReBw5RuknBsH/Lb1un6tIfXEsMBnRE=;
        b=vRT//d+YakFNc7V40sX+6oPO/h6RQYUhR4+rPiVhqISDfnosB0v83DtFMZHFMldTUU
         W4lDRKaACPmTt/T+EUnPI1oFHPxOqq9XUXKSGzHahkwPnfslw7dahb4cpUMOvga8byA7
         e7c/eAAVy8UVA/fePQFvyBtLLed1fZGDWRJVOCVVng8iiCL8d6PHTuYq2RzlDnTqCye+
         +EWExLtE+wxMQikpcjh3uS2xzESoxB8M1WIZvHK6iu5xiqrJqEhQVY8ERuUxrHJ6ue3+
         8Udv6jIpJdMRD9KwWGr4XLfUEbT4vEykIs7UrHeoKYHq6TykixeV/frF/uo6k3U8qq0W
         r8/Q==
X-Gm-Message-State: AAQBX9cN5gdISQ1rdapsM6L/JewNjogoeNYTLWUfpNqm6egxbnc/bQsT
        WtL4VVrdxyEDahIIoVUw+07z/nuIgRZGbjvkWGSuag==
X-Google-Smtp-Source: AKy350bpIkiOD9NGwPAFRgO5XvcrGL/wWfDMctgQnrZkQBHmjQb68cIUjLdR/JMWVPkuYrjGAYx0KqUp2kS3fqG5Oyo=
X-Received: by 2002:a81:ae23:0:b0:52e:e095:d840 with SMTP id
 m35-20020a81ae23000000b0052ee095d840mr5152153ywh.0.1679912952661; Mon, 27 Mar
 2023 03:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <95083698.3076.1679882851720@127.0.0.1>
In-Reply-To: <95083698.3076.1679882851720@127.0.0.1>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Mar 2023 12:28:37 +0200
Message-ID: <CAPDyKFpLBz0_fRko2vQK8h4XSGtJFyK4a4YtRCym02oPXZWiew@mail.gmail.com>
Subject: Re: Re: [PATCH] mmc: core: remove unnecessary (void*) conversions
To:     yuzhe@nfschina.com
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        liqiong <liqiong@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 27 Mar 2023 at 04:07, yuzhe <yuzhe@nfschina.com> wrote:
>
> <p><br /><br /><br />=E5=9C=A8 2023-03-24, =E6=98=9F=E6=9C=9F=E4=BA=94, 2=
3:47:08 ,Ulf Hansson =E5=86=99=E5=88=B0=EF=BC=9A</p>
> <pre>On Fri, 24 Mar 2023 at 14:28, Marek Szyprowski <m.szyprowski@samsung=
.com> wrote:
> >
> > On 17.03.2023 07:47, Yu Zhe wrote:
> > > Pointer variables of void * type do not require type cast.
> > >
> > > Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> > > ---
> > > drivers/mmc/core/debugfs.c | 2 +-
> > > drivers/mmc/core/host.c | 2 +-
> > > drivers/mmc/core/mmc_test.c | 6 +++---
> > > 3 files changed, 5 insertions(+), 5 deletions(-)
> > ...
> > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > index 096093f7be00..76900f67c782 100644
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -590,7 +590,7 @@ EXPORT_SYMBOL(mmc_alloc_host);
> > >
> > > static void devm_mmc_host_release(struct device *dev, void *res)
> > > {
> > > - mmc_free_host(*(struct mmc_host **)res);
> > > + mmc_free_host(res);
> >
> > The above chunk is wrong and causes following regression on today's
> > Linux next-20230324:
> >
> > Unable to handle kernel paging request at virtual address 0000000000001=
020
> > Mem abort info:
> > meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
> > ...
> > [0000000000001020] user address but active_mm is swapper
> > Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 3 PID: 10 Comm: kworker/u12:0 Not tainted 6.3.0-rc3-next-20230324+
> > #13452
> > Hardware name: Khadas VIM3 (DT)
> > Workqueue: events_unbound async_run_entry_fn
> > pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > pc : mmc_pwrseq_free+0x1c/0x38
> > lr : devm_mmc_host_release+0x1c/0x34
> > ...
> > Call trace:
> > mmc_pwrseq_free+0x1c/0x38
> > devm_mmc_host_release+0x1c/0x34
> > release_nodes+0x5c/0x90
> > devres_release_all+0x8c/0xdc
> > device_unbind_cleanup+0x18/0x68
> > really_probe+0x11c/0x2b4
> > __driver_probe_device+0x78/0xe0
> > driver_probe_device+0xd8/0x160
> > __device_attach_driver+0xb8/0x138
> > bus_for_each_drv+0x84/0xe0
> > __device_attach_async_helper+0xb0/0xd4
> > async_run_entry_fn+0x34/0xe0
> > process_one_work+0x288/0x5c0
> > worker_thread+0x74/0x450
> > kthread+0x124/0x128
> > ret_from_fork+0x10/0x20
> > Code: f9000bf3 aa0003f3 f9424c00 b4000080 (f9401000)
> > ---[ end trace 0000000000000000 ]---
> >
> > Ulf: do You want me to send a partial revert or will you handle it by
> > dropping this patch?
>
> Thanks for the report, I will simply drop the patch!
>
> Kind regards
> Uffe
> </pre>
>
> sorry for making this mistake, I will check seriously next time.

Np, things go wrong sometimes, even in the simple cases. Feel free to
post an updated patch.

Kind regards
Uffe
