Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AEAC761A6
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Apr 2023 09:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjDCJwm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Apr 2023 05:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjDCJwV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Apr 2023 05:52:21 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7AB1A947
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 02:51:28 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id d3so6122839ybu.1
        for <linux-mmc@vger.kernel.org>; Mon, 03 Apr 2023 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680515477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Myr4SOqgp/Xpahg3zCPICN65Lgc87yWnRIomS6rycc=;
        b=GPcW7yzc6Y3bgT6bww3ltcw04qeqvy7Edi1PSy8xetx51klIvNb25DddZh7qOtn3Zt
         448OEueWdAmkqADKKH62h/yzixUrtHA6dR42cFmPLzdVaBDsp/KOsRe0GAWqq1PoJXCy
         645onHrED3MlyzhcnBubHx2u0FPdbNNhO8uY/0H0lghBj1Dw1m6LdH5dOtwHKT28stVw
         AGSuCPHUldU87zv1oRIgR9R/8XG/kNdVZ01e6dpfX9CFc3h8cLXx5mHlo6LjgeAjox4N
         /nLgluJt8hJPLiDyWJO1Sym+V/I+TnNXDo5pjejXwAd/1gAwNL+0D7FudQ3hmq9CgRjV
         EBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Myr4SOqgp/Xpahg3zCPICN65Lgc87yWnRIomS6rycc=;
        b=E3+So3kbktwYwNsUOBwPlP12NTrOCJjTUMeGbdTtYqQGIs+DFh24rXY8FCLT1icJcs
         xhbVdSP7Mtb1UphUk41DZzYufSkWQtauuREEAwwhQojvznXqFoGrboLVRQw2QdvxvH7u
         /RESATacFHKK5mcCp96QJMsufKAdxJYLreEhzZ5oliZQh9wByvgy9lfyZaBtPTIVrgJK
         YqGXdX+nUIZvpa/kwKeaE7lIwWsIHqAG706/lgMrtiDWoRgTrggKwjg2jMaNscpo1KXB
         U6PGzvna75d44nMLVd5qabscpVoQ1KO68hr+pa3gprDF/QczUGhjWl0n0FayNEA/id4a
         mZiA==
X-Gm-Message-State: AAQBX9d3L1u8N+gPoAfDpWAYJXTwADUbQ9r/RrpYfCc/JxwXOoCjKbq8
        CFbWe5SyLaNOsyjcw0DnfDY51GuTl2NMHYjxjcPbtjcViiI6k+PT
X-Google-Smtp-Source: AKy350bNjes3lUCW0Puu0SEvzQIxGEKTB7f/ZKo170GPrpIIbQT+S2NOobt6fb58J1TXjFuBWJuKofuApgAGg2knmPw=
X-Received: by 2002:a25:abee:0:b0:b68:7a4a:5258 with SMTP id
 v101-20020a25abee000000b00b687a4a5258mr22948859ybi.3.1680515477454; Mon, 03
 Apr 2023 02:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202148.71107-1-dennis@kernel.org> <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAPDyKFrcdJuyA9B-JDReacT2z1ircDoY4oTXZQ8AVFk6UEFYsw@mail.gmail.com> <ZCclEE6Qw3on7/eO@snowbird>
In-Reply-To: <ZCclEE6Qw3on7/eO@snowbird>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Apr 2023 11:50:41 +0200
Message-ID: <CAPDyKFqc33gUYXpY==jbNrOiba2_xUYLs-bv0RTYYU5d8T0VBA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 31 Mar 2023 at 20:23, Dennis Zhou <dennis@kernel.org> wrote:
>
> Hi Ulf,
>
> On Fri, Mar 31, 2023 at 02:43:10PM +0200, Ulf Hansson wrote:
> > On Thu, 30 Mar 2023 at 01:48, Dennis Zhou <dennis@kernel.org> wrote:
> > >
> > > When using dm-verity with a data partition on an emmc device, dm-verity
> > > races with the discovery of attached emmc devices. This is because mmc's
> > > probing code sets up the host data structure then a work item is
> > > scheduled to do discovery afterwards. To prevent this race on init,
> > > let's inline the first call to detection, __mm_scan(), and let
> > > subsequent detect calls be handled via the workqueue.
> >
> > In principle, I don't mind the changes in $subject patch, as long as
> > it doesn't hurt the overall initialization/boot time. Especially, we
> > may have more than one mmc-slot being used, so this needs to be well
> > tested.
> >
>
> I unfortunately don't have a device with multiple mmcs available. Is
> this something you could help me with?

Yes, I can help to test. Allow me a few days to see what I can do.

Note that, just having one eMMC and one SD card should work too. It
doesn't have to be multiple eMMCs.

>
> > Although, more importantly, I fail to understand how this is going to
> > solve the race condition. Any I/O request to an eMMC or SD requires
> > the mmc block device driver to be up and running too, which is getting
> > probed from a separate module/driver that's not part of mmc_rescan().
>
> I believe the call chain is something like this:
>
> __mmc_rescan()
>     mmc_rescan_try_freq()
>         mmc_attach_mmc()
>             mmc_add_card()
>                 device_add()
>                     bus_probe_device()
>                         mmc_blk_probe()
>
> The initial calling of this is the host probe. So effectively if there
> is a card attached, we're inlining the device_add() call for the card
> attached rather than waiting for the workqueue item to kick off.
>
> dm is a part of late_initcall() while mmc is a module_init(), when built
> in becoming a device_initcall(). So this solves a race via the initcall
> chain. In the current state, device_initcall() finishes and we move onto
> the late_initcall() phase. But now, dm is racing with the workqueue to
> init the attached emmc device.

You certainly have a point!

This should work when the mmc blk module is built-in. Even if that
doesn't solve the entire problem, it should be a step in the right
direction.

I will give it some more thinking and run some tests at my side, then
I will get back to you again.

Kind regards
Uffe

> >
> > >
> > > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > > ---
> > > Sigh.. fix missing static declaration.
> > >
> > >  drivers/mmc/core/core.c | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > index 368f10405e13..fda7ee57dee3 100644
> > > --- a/drivers/mmc/core/core.c
> > > +++ b/drivers/mmc/core/core.c
> > > @@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
> > >  }
> > >  EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
> > >
> > > -void mmc_rescan(struct work_struct *work)
> > > +static void __mmc_rescan(struct mmc_host *host)
> > >  {
> > > -       struct mmc_host *host =
> > > -               container_of(work, struct mmc_host, detect.work);
> > >         int i;
> > >
> > >         if (host->rescan_disable)
> > > @@ -2249,6 +2247,14 @@ void mmc_rescan(struct work_struct *work)
> > >                 mmc_schedule_delayed_work(&host->detect, HZ);
> > >  }
> > >
> > > +void mmc_rescan(struct work_struct *work)
> > > +{
> > > +       struct mmc_host *host =
> > > +               container_of(work, struct mmc_host, detect.work);
> > > +
> > > +       __mmc_rescan(host);
> > > +}
> > > +
> > >  void mmc_start_host(struct mmc_host *host)
> > >  {
> > >         host->f_init = max(min(freqs[0], host->f_max), host->f_min);
> > > @@ -2261,7 +2267,8 @@ void mmc_start_host(struct mmc_host *host)
> > >         }
> > >
> > >         mmc_gpiod_request_cd_irq(host);
> > > -       _mmc_detect_change(host, 0, false);
> > > +       host->detect_change = 1;
> > > +       __mmc_rescan(host);
> > >  }
> > >
> > >  void __mmc_stop_host(struct mmc_host *host)
> > > --
> > > 2.40.0
> > >
