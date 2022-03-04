Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A21C433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Mar 2022 10:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbiCDKKZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiCDKKY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2022 05:10:24 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DCCDEA22
        for <linux-mmc@vger.kernel.org>; Fri,  4 Mar 2022 02:09:36 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id w27so13308315lfa.5
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2022 02:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTlQzouujxjklNSmEgJUOKvgbuMUOxIuYP4op7FfZLA=;
        b=pAFN1ddFQ/E0y4qv64XFp85SwQmgi+xcXmt8nmEAyVvhOOMI31LQPQCS/a1PE0+UOR
         8B6J4criYegIzpwIp+e1b1HmTbtkzHcGAs5ZyQOdxacbmgFA/fpe5AbXnnDevZda50dS
         EZJR3k9eSSXr5V4VvA87/xXJ4pfGx+caGTcevot0QzO1mSssbAJRojnBDufVSA/kOPGt
         p+U3vDF/BtqLBkNqJh9DEoJj+OlPhIoYTWoDg4kPtO6vYLnILn1ITvcuu0ryU63AHrin
         fImJq8o1zghEWqk4pDVH39DADSbHcquLL2wN2vSwi/XRXqfz88Yo81gjv72HZy9LuE10
         IUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTlQzouujxjklNSmEgJUOKvgbuMUOxIuYP4op7FfZLA=;
        b=yYnfy4/4s5y+KwbnP0RgYHZbeGRh0c4TChOwDap1Q0PXL9ndX5IuHZLbWEZy3psng5
         NeQtVCms1fUCDPxuKZlupohJIynFrsMCs0LYFiyffBCKKKOcfFFPUzJMT33DWG8j7lap
         1XlcJuGBUo8DZsQf6ZPwwkGL8IOb4aab6yzacsjW/idJC3ib8iRvR9HFZ0W3HlqHzQOD
         mTFw3z2XHwHVjXbiP8rPUpBYm/XT3hvd53Gcad8psE15ymFBwoK9eVG0jFhfjOY8Fn1J
         9U1hzDRlDYX9atWX029KmIY4U9HImzG93QlRuMzUVWNXit5iYJW3cCu4g5UfQMMhd5NK
         nY2g==
X-Gm-Message-State: AOAM532/32pID3vuw0XrLdiTef63NPLwE6NMtMnero9jO9Fo2VF/eK9y
        ZljHmOg/4yrlhIhUbInK/XFPoFL2Nq70z8BLGxhhaEUr2mg=
X-Google-Smtp-Source: ABdhPJxioaW/kEbNRDMpwSwzMDNKpC0oQLgEd/3aJooMgZrQOKmA3ksjnvQNOly3P47CFSn8dG3kvRr5mCQf1ZAIY9Q=
X-Received: by 2002:a05:6512:ea5:b0:43b:3603:69d9 with SMTP id
 bi37-20020a0565120ea500b0043b360369d9mr24172397lfb.71.1646388575210; Fri, 04
 Mar 2022 02:09:35 -0800 (PST)
MIME-Version: 1.0
References: <27DDB061-1235-4F4C-B6A8-F035D77AC9CF@goldelico.com>
 <CAPDyKFrz_2Vp64SUzB8CiHJLTjO8Hx8m3QEhY1VU2ksZhVEx7A@mail.gmail.com>
 <20220302082034.GA5723@math.uni-bielefeld.de> <6715A5BE-CA64-4A3D-8EE5-5BEEB63F268A@goldelico.com>
 <CAPDyKFqMs6FsJHVOoVmZxzBPgUdLoqa-xeLfvkQi1pn=8k1h6Q@mail.gmail.com> <20220304092811.GA20284@math.uni-bielefeld.de>
In-Reply-To: <20220304092811.GA20284@math.uni-bielefeld.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Mar 2022 11:08:58 +0100
Message-ID: <CAPDyKFq1G6uYz_3mMj3ZU54vDuzVDYw09rXCxx2rLAPeoXoFJA@mail.gmail.com>
Subject: Re: [BUG] mmc: core: adjust polling interval for CMD1
To:     Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Huijin Park <huijin.park@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 4 Mar 2022 at 10:28, Jean Rene Dawin
<jdawin@math.uni-bielefeld.de> wrote:
>
> Ulf Hansson wrote on Thu  3/03/22 11:40:
> > On Wed, 2 Mar 2022 at 10:40, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >
> > Alright, it starts to sound like we might need a revert (or at least a
> > way to restore the previous behaviour) - even if that would just paper
> > over the real problem. The real problem is more likely related to how
> > the host driver manages restoring of the power to the card, which
> > happens when runtime resuming it.
> >
> > In any case, just to make sure the loop timeout itself isn't the
> > problem, can you run the below debug patch please? The intent is to
> > figure out how long the worst case timeout is, when it's working with
> > CMD1. As soon as the timeout exceeds the worst case, there is a
> > message printed to the log.
> >
> > The below patch is based upon that the offending commit has been reverted.
> >
> > Kind regards
> > Uffe
> >
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Date: Thu, 3 Mar 2022 11:00:04 +0100
> > Subject: [PATCH] mmc: core: DEBUG - Measure and log worst case CMD1 loop
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/mmc_ops.c | 11 +++++++++++
> >  include/linux/mmc/host.h   |  1 +
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > index 9946733a34c6..3f03d9e8a3a4 100644
> > --- a/drivers/mmc/core/mmc_ops.c
> > +++ b/drivers/mmc/core/mmc_ops.c
> > @@ -177,11 +177,15 @@ int mmc_send_op_cond(struct mmc_host *host, u32
> > ocr, u32 *rocr)
> >  {
> >         struct mmc_command cmd = {};
> >         int i, err = 0;
> > +       s64 cmd1_ms;
> > +       ktime_t time_start;
> >
> >         cmd.opcode = MMC_SEND_OP_COND;
> >         cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
> >         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
> >
> > +       time_start = ktime_get();
> > +
> >         for (i = 100; i; i--) {
> >                 err = mmc_wait_for_cmd(host, &cmd, 0);
> >                 if (err)
> > @@ -211,6 +215,13 @@ int mmc_send_op_cond(struct mmc_host *host, u32
> > ocr, u32 *rocr)
> >                         cmd.arg = cmd.resp[0] | BIT(30);
> >         }
> >
> > +       cmd1_ms = ktime_to_ms(ktime_sub(ktime_get(), time_start));
> > +       if (!err && cmd1_ms > host->cmd1_ms) {
> > +               pr_warn("%s: CMD1 timeout increased to %lld ms, loop=%d\n",
> > +                       mmc_hostname(host), cmd1_ms, i);
> > +               host->cmd1_ms = cmd1_ms;
> > +       }
> > +
> >         if (rocr && !mmc_host_is_spi(host))
> >                 *rocr = cmd.resp[0];
> >
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 7afb57cab00b..c2ca3bb05620 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -301,6 +301,7 @@ struct mmc_host {
> >         unsigned int            f_min;
> >         unsigned int            f_max;
> >         unsigned int            f_init;
> > +       s64                     cmd1_ms;
> >         u32                     ocr_avail;
> >         u32                     ocr_avail_sdio; /* SDIO-specific OCR */
> >         u32                     ocr_avail_sd;   /* SD-specific OCR */
> > --
> > 2.25.1
>
> Hi,
>
> thanks. With this patch applied with reverted 76bfc7ccc2fa9d382576f6013b57a0ef93d5a722
> I don't get the "stuck" errors in __mmc_poll_for_busy and only one message of
>
> [    1.095194] mmc1: CMD1 timeout increased to 64 ms, loop=98

Okay, so for some reason polling doesn't work, if we poll too
frequently. Clearly the 1s total timeout should be sufficient.

I will prepare a patch that restores the old behaviour and post it
within a few minutes.

Kind regards
Uffe
