Return-Path: <SRS0=rnDB=C2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A96C43461
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Sep 2020 10:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B941E2087D
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Sep 2020 10:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJzPSCNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgIQKMl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Sep 2020 06:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgIQKMl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Sep 2020 06:12:41 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A662DC06174A;
        Thu, 17 Sep 2020 03:12:40 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id a2so1303419ybj.2;
        Thu, 17 Sep 2020 03:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wr0X2v6394FbdTIf6rHS1eHtFra+Zcue68b3yKpahjg=;
        b=sJzPSCNtVfQCCumhCyA7M4aTmlR9HQT7sBpUtWtd+aVLqYOu1DDOUjqpdS10pft85C
         Zim1vwPFJSQtpeM4GEF4fLV7qolZcIkOETPiPaAZJqenJvsl/kaHexHkzuB3vjNHuLX2
         v3Yypa7vr88uLv5gUTGdY9wnMCfSFo9ZQjefZYGQubw43V8VSQNx/1HkxzbH0gjkcZlu
         LCxOyJRzmL2LmE3pN0vqDPr3T0PvVzxma+TJC/XhRUtARnLK6eRPmzHhDhJE/dXBmGNC
         XwZno6rSOP0oALzGNUXKiorJjgh5oMUhB0CrCTZaan1k8XoRJYRxdDWr18YvUZD1it6z
         3ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wr0X2v6394FbdTIf6rHS1eHtFra+Zcue68b3yKpahjg=;
        b=sJkXf5ZE2DVNiz2pT8kvB6Ls5LkhkD0Jj3JZ1qUx40hCZ9dwQa1fA0Avo2WfnoI/gh
         B7sQ7HBzTInt6BXwluzFgfUd+gmFs8bPVq7rgElplnmTUwTEYSypUZTIkkRR3GrWKJG5
         HGyciBXsSGKBaCkbwZpZO2f4sxeWbjQm+KhSg7njnGMI6WrbCHYUM3Fm0wIWjk11g12i
         JWT9yfDIcvz3tjuzI0Q7mupdI9fCYvkyuNk6kXJDjbqFJxdGYJuZY3pirZOV44CMDYKU
         bXOAQhuaNbneM017kvgm+KcBCsIs1ZAl72mnhTiR6yQeh3/9gY42VaxtkQOEFw/D5Y+G
         E9yQ==
X-Gm-Message-State: AOAM532b5rB1jYYs0OEI0AefFBhW/uur7/wMGftM8r2H1LZn3Ra+fvSR
        v9fS5Cf6fTz7sFNBfFNO1uLRSW84cclVDJJVhJU=
X-Google-Smtp-Source: ABdhPJwtiRxMg5ZZenV0V64rB3KkZ+tu4NwSJkcO4Xx0UcCC2Vu+2XToymNgGe3lTnrYZsaUDDT9aojB2gxRfieDzVw=
X-Received: by 2002:a25:d10d:: with SMTP id i13mr43977913ybg.476.1600337558769;
 Thu, 17 Sep 2020 03:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200710111054.29562-1-benchuanggli@gmail.com>
 <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com> <20200917051253.GA3094018@laputa>
In-Reply-To: <20200917051253.GA3094018@laputa>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Thu, 17 Sep 2020 18:12:27 +0800
Message-ID: <CACT4zj9LuJoy9mX4Fqm+jZf1bDa5oUZcR6mPa-otW1mXfNLh1g@mail.gmail.com>
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Cc:     Renius.Chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Takahiro,

On Thu, Sep 17, 2020 at 1:12 PM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Adrian, Ben,
>
> Regarding _reset() function,
>
> On Fri, Aug 21, 2020 at 05:08:32PM +0300, Adrian Hunter wrote:
> > On 10/07/20 2:10 pm, Ben Chuang wrote:
> > > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > >
> > > In this commit, UHS-II related operations will be called via a function
> > > pointer array, sdhci_uhs2_ops, in order to make UHS-II support as
> > > a kernel module.
> > > This array will be initialized only if CONFIG_MMC_SDHCI_UHS2 is enabled
> > > and when the UHS-II module is loaded. Otherwise, all the functions
> > > stay void.
> > >
> > > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > ---
> > >  drivers/mmc/host/sdhci.c | 152 ++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 136 insertions(+), 16 deletions(-)
> > >
>
>   (snip)
>
> > >     if (host->ops->platform_send_init_74_clocks)
> > >             host->ops->platform_send_init_74_clocks(host, ios->power_mode);
> > >
> > > @@ -2331,7 +2411,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > >     }
> > >
> > >     if (host->version >= SDHCI_SPEC_300) {
> > > -           u16 clk, ctrl_2;
> > > +           u16 clk;
> > >
> > >             if (!host->preset_enabled) {
> > >                     sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > > @@ -3173,11 +3253,19 @@ static bool sdhci_request_done(struct sdhci_host *host)
> > >                     /* This is to force an update */
> > >                     host->ops->set_clock(host, host->clock);
> > >
> > > -           /* Spec says we should do both at the same time, but Ricoh
> > > -              controllers do not like that. */
> > > -           sdhci_do_reset(host, SDHCI_RESET_CMD);
> > > -           sdhci_do_reset(host, SDHCI_RESET_DATA);
> > > -
> > > +           if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > +               host->mmc->flags & MMC_UHS2_INITIALIZED) {
> > > +                   if (sdhci_uhs2_ops.reset)
> > > +                           sdhci_uhs2_ops.reset(host,
> > > +                                                SDHCI_UHS2_SW_RESET_SD);
> > > +           } else {
> > > +                   /*
> > > +                    * Spec says we should do both at the same time, but
> > > +                    * Ricoh controllers do not like that.
> > > +                    */
> > > +                   sdhci_do_reset(host, SDHCI_RESET_CMD);
> > > +                   sdhci_do_reset(host, SDHCI_RESET_DATA);
> > > +           }
> >
> > Please look at using the existing ->reset() sdhci host op instead.
>
> Well, the second argument to those reset functions is a bit-wise value
> to different "reset" registers, SDHCI_SOFTWARE_RESET and SDHCI_UHS2_SW_RESET,
> respectively.
>
> This fact raises a couple of questions to me:
>
> 1) Does it make sense to merge two functionality into one, i.e.
>    sdhci_do_reset(), which is set to call ->reset hook?
>
>         -> Adrian
>
> 2) UHS2_SW_RESET_SD is done only at this place while there are many callsites
>    of reset(RESET_CMD|RESET_DATA) in sdhci.c.
>    Why does the current code work?
>
>    I found, in sdhci-pci-gli.c,
>    sdhci_gl9755_reset()
>         /* reset sd-tran on UHS2 mode if need to reset cmd/data */
>         if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))
>                 gl9755_uhs2_reset_sd_tran(host);
>
>    Is this the trick to avoid the issue?
>    (It looks redundant in terms of the hack above in sdhci_request_done()
>    and even quite dirty to me. Moreover, no corresponding code for gl9750
>    and gl9763.)

GL9755 currently does SD reset and UHS-II reset together.
There is no UHS-II interface on gl9750 and gl9763e.

>
>         -> Ben
>
> 3) (More or less SD specification issue)
>    In UHS-II mode, do we have to call reset(SHCI_RESET_ALL) along with
>    reset(UHS2_SW_RESET_FULL)?
>    Under the current implementation, both will be called at the end.
>

As I know, the UHS2_SW_RESET_FULL is only for UHS-II.
Can you list the lines that reset(SHCI_RESET_ALL) and
reset(UHS2_SW_RESET_FULL) are both called?

>         -> Adrian, Ben
>
> 4) (Not directly linked to UHS-II support)
>   In some places, we see the sequence:
>         sdhci_do_reset(host, SDHCI_RESET_CMD);
>         sdhci_do_reset(host, SDHCI_RESET_DATA);
>   while in other places,
>         sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>
>   If the statement below is true,
> > > -           /* Spec says we should do both at the same time, but Ricoh
> > > -              controllers do not like that. */
>   the latter should be wrong.
>
>         -> Adrian
>
> -Takahiro Akashi
>
>
>
> > >             host->pending_reset = false;
> > >     }
> > >
> > > @@ -3532,6 +3620,13 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
> > >                               SDHCI_INT_BUS_POWER);
> > >             sdhci_writel(host, mask, SDHCI_INT_STATUS);
> > >
> > > +           if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > +               intmask & SDHCI_INT_ERROR &&
> > > +               host->mmc->flags & MMC_UHS2_SUPPORT) {
> > > +                   if (sdhci_uhs2_ops.irq)
> > > +                           sdhci_uhs2_ops.irq(host);
> > > +           }
> > > +
> >
> > Please look at using the existing ->irq() sdhci host op instead
> >
> > >             if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> > >                     u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> > >                                   SDHCI_CARD_PRESENT;
> > > @@ -4717,6 +4812,14 @@ int sdhci_setup_host(struct sdhci_host *host)
> > >             /* This may alter mmc->*_blk_* parameters */
> > >             sdhci_allocate_bounce_buffer(host);
> > >
> > > +   if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > +       host->version >= SDHCI_SPEC_400 &&
> > > +       sdhci_uhs2_ops.add_host) {
> > > +           ret = sdhci_uhs2_ops.add_host(host, host->caps1);
> > > +           if (ret)
> > > +                   goto unreg;
> > > +   }
> > > +
> >
> > I think you should look at creating uhs2_add_host() instead
> >
> > >     return 0;
> > >
> > >  unreg:
> > > @@ -4738,6 +4841,8 @@ void sdhci_cleanup_host(struct sdhci_host *host)
> > >  {
> > >     struct mmc_host *mmc = host->mmc;
> > >
> > > +   /* FIXME: Do we have to do some cleanup for UHS2 here? */
> > > +
> > >     if (!IS_ERR(mmc->supply.vqmmc))
> > >             regulator_disable(mmc->supply.vqmmc);
> > >
> > > @@ -4766,6 +4871,14 @@ int __sdhci_add_host(struct sdhci_host *host)
> > >             mmc->cqe_ops = NULL;
> > >     }
> > >
> > > +   if ((mmc->caps & MMC_CAP_UHS2) && !host->v4_mode) {
> > > +           /* host doesn't want to enable UHS2 support */
> > > +           mmc->caps &= ~MMC_CAP_UHS2;
> > > +           mmc->flags &= ~MMC_UHS2_SUPPORT;
> > > +
> > > +           /* FIXME: Do we have to do some cleanup here? */
> > > +   }
> > > +
> > >     host->complete_wq = alloc_workqueue("sdhci", flags, 0);
> > >     if (!host->complete_wq)
> > >             return -ENOMEM;
> > > @@ -4812,6 +4925,9 @@ int __sdhci_add_host(struct sdhci_host *host)
> > >  unled:
> > >     sdhci_led_unregister(host);
> > >  unirq:
> > > +   if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > +       sdhci_uhs2_ops.remove_host)
> > > +           sdhci_uhs2_ops.remove_host(host, 0);
> > >     sdhci_do_reset(host, SDHCI_RESET_ALL);
> > >     sdhci_writel(host, 0, SDHCI_INT_ENABLE);
> > >     sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
> > > @@ -4869,6 +4985,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
> > >
> > >     sdhci_led_unregister(host);
> > >
> > > +   if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > +       sdhci_uhs2_ops.remove_host)
> > > +           sdhci_uhs2_ops.remove_host(host, dead);
> > > +
> >
> > I think you should look at creating uhs2_remove_host() instead
> >
> > >     if (!dead)
> > >             sdhci_do_reset(host, SDHCI_RESET_ALL);
> > >
> > >
> >
