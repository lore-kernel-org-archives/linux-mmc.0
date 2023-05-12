Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDE5C77B7C
	for <linux-mmc@archiver.kernel.org>; Fri, 12 May 2023 11:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbjELLnb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 May 2023 07:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbjELLn3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 May 2023 07:43:29 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DCE1BFB
        for <linux-mmc@vger.kernel.org>; Fri, 12 May 2023 04:43:28 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-55a83e80262so144402147b3.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 May 2023 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683891807; x=1686483807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dROUuEn234GUwFHzxv2PsiONLhCK2rIULZuNe326W5c=;
        b=uNnDTno5mHbK59YbOkUj/zAVImCzgAKQc52FuEN2nR6yjCzWZWXpZ+Gf2ZKBEGqDS7
         M/8O4OwqT8TGsFlRWbnaodbJSDNA2vjgYPvMsSsbjE02mXBvaGrlFkm/xZLsDq7xsqw2
         xaJC1udHa6FnbsWFLxsc5Yzo8KjLLFQmnys9RP4SxzudwmRDBC9F2FaZCs12fFaLmIhM
         t+mfkzNlhUjTvSfxyFRClYRis0I2ZN7nk+CMZHyidfbkVKSyvKmShebYKQpEXffVfFuU
         KR+aTvoYfEg9UgtRqYbwHYlq1nYvCSvKyk5RkCQac3PXxrepOHdCAitjk4bU/hF0z4Rr
         015A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683891807; x=1686483807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dROUuEn234GUwFHzxv2PsiONLhCK2rIULZuNe326W5c=;
        b=f4PLtgMi5aFLOHDRKRTbV2p1awtIRVtsi/qvT0579O4Emoak83y7HjXMOcfnYYfpgm
         5nshPUI+pyg0MUQRjBm/gktPq8jxmfKSNFMFzEnbxCcsuAo7rpIfEgWhdxbVpRYzxRYm
         B60PU08Cc15S3fdbxQMMXZP52w2h+O7wPfsOfxH8a3xI///l+fp+u33BCH3JrGSlxkS3
         0Iv8Z25nBTfzBtAlyyQd1z7BcGT4r4y02sloAoF9y63La9qdrq8dEduUhtSgwBgMSCT4
         zpOd8StEVY44FU6q5OwGFZgaL5O0nO5pGs5hF1qpWu819HSgGyUvjKQQQ56TPr3poCHd
         CTtw==
X-Gm-Message-State: AC+VfDxxyHUey8pTc2Io6WIaqs+wqptPOgRqh7IGrdSZQA+TAmtyTCaY
        JVjqYcS189h6zepL+x4OURA204jThpVk38h6oAj5jQ==
X-Google-Smtp-Source: ACHHUZ5TwF4SLeqGMJ/05m1sidbCphq0GfoFEP9N0AI63S7ERZVzFi59F69TNvaHU1pgqOL9mb+IxUCxZmsZ0VN3hXo=
X-Received: by 2002:a0d:d942:0:b0:55a:a57e:7de6 with SMTP id
 b63-20020a0dd942000000b0055aa57e7de6mr24819681ywe.15.1683891807584; Fri, 12
 May 2023 04:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202148.71107-1-dennis@kernel.org> <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAPDyKFrcdJuyA9B-JDReacT2z1ircDoY4oTXZQ8AVFk6UEFYsw@mail.gmail.com>
 <ZCclEE6Qw3on7/eO@snowbird> <CAPDyKFqc33gUYXpY==jbNrOiba2_xUYLs-bv0RTYYU5d8T0VBA@mail.gmail.com>
In-Reply-To: <CAPDyKFqc33gUYXpY==jbNrOiba2_xUYLs-bv0RTYYU5d8T0VBA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 May 2023 13:42:51 +0200
Message-ID: <CAPDyKFos3i60U0g0vJstetvLMyouiTpUP8-Jop_LMB9T-ZNU=w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Linus,

Hi Dennis,

On Mon, 3 Apr 2023 at 11:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 31 Mar 2023 at 20:23, Dennis Zhou <dennis@kernel.org> wrote:
> >
> > Hi Ulf,
> >
> > On Fri, Mar 31, 2023 at 02:43:10PM +0200, Ulf Hansson wrote:
> > > On Thu, 30 Mar 2023 at 01:48, Dennis Zhou <dennis@kernel.org> wrote:
> > > >
> > > > When using dm-verity with a data partition on an emmc device, dm-verity
> > > > races with the discovery of attached emmc devices. This is because mmc's
> > > > probing code sets up the host data structure then a work item is
> > > > scheduled to do discovery afterwards. To prevent this race on init,
> > > > let's inline the first call to detection, __mm_scan(), and let
> > > > subsequent detect calls be handled via the workqueue.
> > >
> > > In principle, I don't mind the changes in $subject patch, as long as
> > > it doesn't hurt the overall initialization/boot time. Especially, we
> > > may have more than one mmc-slot being used, so this needs to be well
> > > tested.
> > >
> >
> > I unfortunately don't have a device with multiple mmcs available. Is
> > this something you could help me with?
>
> Yes, I can help to test. Allow me a few days to see what I can do.
>
> Note that, just having one eMMC and one SD card should work too. It
> doesn't have to be multiple eMMCs.
>
> >
> > > Although, more importantly, I fail to understand how this is going to
> > > solve the race condition. Any I/O request to an eMMC or SD requires
> > > the mmc block device driver to be up and running too, which is getting
> > > probed from a separate module/driver that's not part of mmc_rescan().
> >
> > I believe the call chain is something like this:
> >
> > __mmc_rescan()
> >     mmc_rescan_try_freq()
> >         mmc_attach_mmc()
> >             mmc_add_card()
> >                 device_add()
> >                     bus_probe_device()
> >                         mmc_blk_probe()
> >
> > The initial calling of this is the host probe. So effectively if there
> > is a card attached, we're inlining the device_add() call for the card
> > attached rather than waiting for the workqueue item to kick off.
> >
> > dm is a part of late_initcall() while mmc is a module_init(), when built
> > in becoming a device_initcall(). So this solves a race via the initcall
> > chain. In the current state, device_initcall() finishes and we move onto
> > the late_initcall() phase. But now, dm is racing with the workqueue to
> > init the attached emmc device.
>
> You certainly have a point!
>
> This should work when the mmc blk module is built-in. Even if that
> doesn't solve the entire problem, it should be a step in the right
> direction.
>
> I will give it some more thinking and run some tests at my side, then
> I will get back to you again.
>
> Kind regards
> Uffe
>
> > >
> > > >
> > > > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > > > ---
> > > > Sigh.. fix missing static declaration.
> > > >
> > > >  drivers/mmc/core/core.c | 15 +++++++++++----
> > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > > index 368f10405e13..fda7ee57dee3 100644
> > > > --- a/drivers/mmc/core/core.c
> > > > +++ b/drivers/mmc/core/core.c
> > > > @@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
> > > >  }
> > > >  EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
> > > >
> > > > -void mmc_rescan(struct work_struct *work)
> > > > +static void __mmc_rescan(struct mmc_host *host)
> > > >  {
> > > > -       struct mmc_host *host =
> > > > -               container_of(work, struct mmc_host, detect.work);
> > > >         int i;
> > > >
> > > >         if (host->rescan_disable)
> > > > @@ -2249,6 +2247,14 @@ void mmc_rescan(struct work_struct *work)
> > > >                 mmc_schedule_delayed_work(&host->detect, HZ);
> > > >  }
> > > >
> > > > +void mmc_rescan(struct work_struct *work)
> > > > +{
> > > > +       struct mmc_host *host =
> > > > +               container_of(work, struct mmc_host, detect.work);
> > > > +
> > > > +       __mmc_rescan(host);
> > > > +}
> > > > +
> > > >  void mmc_start_host(struct mmc_host *host)
> > > >  {
> > > >         host->f_init = max(min(freqs[0], host->f_max), host->f_min);
> > > > @@ -2261,7 +2267,8 @@ void mmc_start_host(struct mmc_host *host)
> > > >         }
> > > >
> > > >         mmc_gpiod_request_cd_irq(host);
> > > > -       _mmc_detect_change(host, 0, false);
> > > > +       host->detect_change = 1;
> > > > +       __mmc_rescan(host);
> > > >  }
> > > >
> > > >  void __mmc_stop_host(struct mmc_host *host)
> > > > --
> > > > 2.40.0
> > > >

My apologies for the long delay. I finally managed to test this.

I decided to pick an old arm32 based platform. An ST-Ericsson HREF,
based upon the ux500 SoC. It's quite good to use for these types of
tests as it has two eMMCs soldered, an embedded SDIO (for WiFi) and an
SD-card slot. So in total there are 4 devices that get probed.

The SDIO card isn't detected properly, but always fails in the similar
way (thus I left it out from the below data). I tested both with and
without an SD card inserted during boot, to get some more data to
compare. These are the summary from my tests:

v6.4-rc1 without SD card:
~2.18s - MMC1 (eMMC)
~3.33s - MMC3 (eMMC)
~5.91s - kernel boot complete

v6.4-rc1 with an SD card:
~2.18s - MMC1 (eMMC)
~3.45s - MMC3 (eMMC)
~3.57s - MMC2 (SD)
~5.76s - kernel boot complete

v6.4-rc1 + patch without SD card:
~2.24s - MMC1 (eMMC)
~3.58s - MMC3 (eMMC)
~5.96s - kernel boot complete

v6.4-rc1 + patch with an SD card:
~2.24s - MMC1 (eMMC)
~3.73s - MMC2 (SD)
~3.98s - MMC3 (eMMC)
~6.73s - kernel boot complete

By looking at these results, I was kind of surprised. I was thinking
that the asynchronous probe should address the parallelism problem.
Then I discovered that it in fact, hasn't been enabled for the mmci
driver that is being used for this platform. Huh, I was under the
assumption that it has been enabled for all mmc hosts by now. :-)

Okay, so I am going to run another round of tests, with async probe
enabled for the mmci driver too. I will let you know the results as
soon as I can.

Kind regards
Uffe
