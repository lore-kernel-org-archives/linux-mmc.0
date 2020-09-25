Return-Path: <SRS0=CvS5=DC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA930C4363D
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 07:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400C4206F7
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 07:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bms69fzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgIYHza (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Sep 2020 03:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgIYHza (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Sep 2020 03:55:30 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747BFC0613CE;
        Fri, 25 Sep 2020 00:55:30 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id x8so1362597ybe.12;
        Fri, 25 Sep 2020 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iJo/1ogq0q+CXmZVEN9qkXyL/ZNzxnbVbLL8sTb+tF0=;
        b=bms69fzJWqOnBLlGtPq3geLMZqTGFHhkCMg5DPJr5ZS9jNt/gWMnCkZPaQL3xL7Cdd
         sxOaKx3HeHgqgqOiy9HruN4ayDfLBCzcgpB2WsZUBGl/mVLPPkLpxESgXYMuIXwPefST
         F6zIn0WbQVdB8AJh45RAR7CYMZqyH3910XKDCFJxsT6ITF0EvoFPJ4kVQQrm8IoPCmiG
         ZFo7t0c2ChBxEqLXGtiPJTPzlw02AA7vGYTYUqIvDR490fVbnDzdyDoulcImg5tPlfk4
         L15bOrLlNfwr7J0rQBzUaznaLyp86khr03PFGn0VDZZEq9vhR/esd2nO6nCZ3Bc3iyE/
         MEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iJo/1ogq0q+CXmZVEN9qkXyL/ZNzxnbVbLL8sTb+tF0=;
        b=Q4NeBCB58rYlR6gQ9uQpyf4Lr7m9UrZ6aRzU8T1owFu3d9oYG+Cd6TOR9zV1+INii0
         vJAKxAlA0tKyHxwvanHRd5Cg+IndundhQ/NfIvscLqeQDU3kdVfEJxCUYX+usXoF7FGx
         ToHiOjtPci3oaMjJ7fAWvfPmsryeoaGQju1wiT0UsRyEEStz/d2mQ2kcKQUQieFhQc3G
         6YCvqx/o5wZdXxe9nLXS69n//AQwJBAkgXDE9VLJ2FvAtK9fBB003MlnOpP5r0ZdyDWE
         ojbQsBVSUdHfmHM9uoA/Td5wQtCBR/0zXpW/hhVAs5NA1ZNNsG5/cqhSFhfwUC37KbJc
         vGig==
X-Gm-Message-State: AOAM530ba3HQmThRR9Syk72U6yEnedm8eHkGMDU6bkPj58KV1gaHx3Aj
        BXuz9CehqkLCXqAKENcmlt2x4SZl16TDcOmYbBw=
X-Google-Smtp-Source: ABdhPJzY22CPc7/ghzHFzBjJBI7pGHxQ+KKC6qtnqMswlxKKyWzjRWW1+9reSvrmrnowKIqcpF4bt3FNpWWrv57hmug=
X-Received: by 2002:a25:c786:: with SMTP id w128mr3533818ybe.135.1601020529448;
 Fri, 25 Sep 2020 00:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200710111054.29562-1-benchuanggli@gmail.com>
 <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com> <20200918063843.GA46229@laputa>
 <CACT4zj-Uo6v_H_G0_LtYjDEN1jKsssjwN-utcZH2y-zqpV1Y3Q@mail.gmail.com> <20200924095747.GB38298@laputa>
In-Reply-To: <20200924095747.GB38298@laputa>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Fri, 25 Sep 2020 15:55:18 +0800
Message-ID: <CACT4zj_G304iaOB1X4pumdMw=SnzSkPJHfMrWcX6trzayoTbgw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, Renius.Chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Takahiro,

On Thu, Sep 24, 2020 at 5:57 PM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Ben,
>
> On Fri, Sep 18, 2020 at 06:50:24PM +0800, Ben Chuang wrote:
> > On Fri, Sep 18, 2020 at 2:38 PM AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > Adrian, Ben,
> > >
> > > Regarding _set_ios() function,
> > >
> > > On Fri, Aug 21, 2020 at 05:08:32PM +0300, Adrian Hunter wrote:
> > > > On 10/07/20 2:10 pm, Ben Chuang wrote:
> > > > > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > > >
> > > > > In this commit, UHS-II related operations will be called via a function
> > > > > pointer array, sdhci_uhs2_ops, in order to make UHS-II support as
> > > > > a kernel module.
> > > > > This array will be initialized only if CONFIG_MMC_SDHCI_UHS2 is enabled
> > > > > and when the UHS-II module is loaded. Otherwise, all the functions
> > > > > stay void.
> > > > >
> > > > > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >
> > >   (snip)
> > >
> > > > > @@ -2261,6 +2324,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > > > >  {
> > > > >     struct sdhci_host *host = mmc_priv(mmc);
> > > > >     u8 ctrl;
> > > > > +   u16 ctrl_2;
> > > > >
> > > > >     if (ios->power_mode == MMC_POWER_UNDEFINED)
> > > > >             return;
> > > > > @@ -2287,6 +2351,10 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > > > >             sdhci_enable_preset_value(host, false);
> > > > >
> > > > >     if (!ios->clock || ios->clock != host->clock) {
> > > > > +           if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > > +               ios->timing == MMC_TIMING_UHS2)
> > > > > +                   host->timing = ios->timing;
> > > > > +
> > > > >             host->ops->set_clock(host, ios->clock);
> > > > >             host->clock = ios->clock;
> > > > >
> > > > > @@ -2308,6 +2376,18 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > > > >     else
> > > > >             sdhci_set_power(host, ios->power_mode, ios->vdd);
> > > > >
> > > > > +   /* 4.0 host support */
> > > > > +   if (host->version >= SDHCI_SPEC_400) {
> > > > > +           /* UHS2 Support */
> > > > > +           if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > > +               host->mmc->flags & MMC_UHS2_SUPPORT &&
> > > > > +               host->mmc->caps & MMC_CAP_UHS2) {
> > > > > +                   if (sdhci_uhs2_ops.do_set_ios)
> > > > > +                           sdhci_uhs2_ops.do_set_ios(host, ios);
> > > > > +                   return;
> > > > > +           }
> > > > > +   }
> > > > > +
> > > >
> > > > Please look at using existing callbacks instead, maybe creating uhs2_set_ios(), uhs2_set_clock(), uhs2_set_power()
> > >
> > > I think that we will create uhs2_set_ios() (and uhs2_set_power()
> > > as we discussed on patch#15/21), but not uhs_set_clock().
> > >
> > > Since we have a hook only in struct mmc_host_ops, but not in struct
> > > sdhci_ops, all the drivers who want to support UHS-II need to
> > > set host->mmc_host_ops->set_ios to sdhci_uhs2_set_ios explicitly
> > > in their own init (or probe) function.
> > > (Again, sdhci_uhs2_set_ios() seems to be generic though.)
> > >
> > > Is this okay for you?
> > >         -> Adrian
> > >
> > > During refactoring the code, I found that sdhci_set_power() is called
> > > twice in sdhci_set_ios():
> > >         sdhci_set_ios(host, power_mode, vdd1, -1); in sdhci_set_ios(), and
> > >         sdhci_set_ios(host, power_mode, vdd1, vdd2) in ush2_do_set_ios()
> > >
> > > Can you please confirm that those are redundant?
> >
> > Yes, uhs2 set power is independent with uhs1.
> > But set  uhs2 power process  should meet  uhs2 spec.
>
> Can you elaborate a bit more about the last sentence, please?
>
> What I meant above is that
>          sdhci_set_ios(host, power_mode, vdd1, vdd2) in ush2_do_set_ios()
>
> this code will 'set_power' both vdd and vdd2 anyway and so
>          sdhci_set_ios(host, power_mode, vdd1, -1); in sdhci_set_ios(), and
> is just redundant.
>

Yes, for uhs-2 flow,  sdhci_set_ios(host, power_mode, vdd1, -1) is redundant.

>
> > >         -> Ben
> > >
> > > I also wonder why we need spin locks in uhs2_do_set_ios() while
> > > not in sdhci_set_ios().
> >
> > You can check if  spin locks in uhs2_do_set_ios() is necessary.
>
> I'm asking you.
>
> While calling set_ios() doesn't require spin locks, are you aware of
> any cases where we need spin locks in calling set_ios() for uhs-2?
> (I mean that callers/contexts are the same either for uhs or uhs-2.)

I agree that it can be removed. I just didn't modify intel's original codes.

>
> -Takahiro Akashi
>
> > If set/clear irq can be execute safely without spin locks, you can
> > remove spin locks.
> >
> > >
> > >         -> Ben
> > >
> > > -Takahiro Akashi
