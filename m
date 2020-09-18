Return-Path: <SRS0=X25L=C3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85404C43463
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Sep 2020 10:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9FF208DB
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Sep 2020 10:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsXdCIVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgIRK1O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Sep 2020 06:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRK1O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Sep 2020 06:27:14 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6AAC06174A;
        Fri, 18 Sep 2020 03:27:14 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id c17so3985240ybe.0;
        Fri, 18 Sep 2020 03:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nzp8DCeYKSYKyxMrpDylEus5nomgwPu5kUUY/cdGC0g=;
        b=RsXdCIVnUSM3u1z9uyvUtQibChVkNkl4vZPjB+obLbfd/xPHQxwOeDy+D+sCwmpTOI
         LPGez1fHGuD7UjYeb/n9OBf4jQ8sa5bihx/Vb9mRAPv/0rUSahlrkzuROjztoIA/wc9m
         Bru5InmbPw6xqQHRNPL1oYZXJxUuSl2IasRGTw60j8R2To/wG9Gio0Bo0VOMAHQitNlE
         WSYL367u83YXUbI2Abt0VMUKBQv553NA8GFxJGaF4rbGQTKUsOsHRC/JdvfRjSd34AZC
         9dPG0DNSU0989nqtQ/TZgcTPgI9elDj4aiRfG3+V4a5JcDw/GgMtIBKYouE8OMjV/UBF
         oL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nzp8DCeYKSYKyxMrpDylEus5nomgwPu5kUUY/cdGC0g=;
        b=gubWffag0Ui2ALyPXOgYDuP5Vpw40iVe+8eAKOtqyWkeHdwVKMz/nXTog6AmWiEvQE
         vrbZhIjmyT0yxhT7WcReckeX91bRkLudrUeRvVt9S4nhr9gC3v/d2BDV+umpIZYetkYS
         UvmvDsU8N7HhvYlwgI0dZC3NbOivJMP55clrUjJoSTup9EZIX7LUunAm9J4hEHQmuqo5
         zGFoBukiOHldrc8V2tfzn2TDBWZ8e7eff/WbcwJfK5ynoxNdXayK2N/lVYTuBiw3ikoT
         Vgt4qObYkihY+9P9MHUFN4kr024mK98jMp16AcyfMecgQNyrDfgmkzzOSV5hc+JSpvyP
         vgEw==
X-Gm-Message-State: AOAM533oGr7K7juqzhypqKBWiS2gLsDVEndxnjQy7+mrz/ju5HCxWwS2
        AEWBgVBApY/7yO7+cW+Pl411vfLv1YXzzRkwfFQ=
X-Google-Smtp-Source: ABdhPJyJ17oxOp8BkS289M7+uQwbCWXfx5flLJgieSYkHOrOjxbNZcNA/tzxRLJ7Ll0KuLcNrhnfPFQIokIsVBH5C7M=
X-Received: by 2002:a25:c842:: with SMTP id y63mr46092748ybf.135.1600424833001;
 Fri, 18 Sep 2020 03:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200710111054.29562-1-benchuanggli@gmail.com>
 <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com> <20200917051253.GA3094018@laputa>
 <CACT4zj9LuJoy9mX4Fqm+jZf1bDa5oUZcR6mPa-otW1mXfNLh1g@mail.gmail.com> <20200918011502.GA27646@laputa>
In-Reply-To: <20200918011502.GA27646@laputa>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Fri, 18 Sep 2020 18:27:01 +0800
Message-ID: <CACT4zj9L0zk1UaYLjsBpt8_tLPbfou-WDv0XwXbQE146bsT0+Q@mail.gmail.com>
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

On Fri, Sep 18, 2020 at 9:15 AM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Ben,
>
> On Thu, Sep 17, 2020 at 06:12:27PM +0800, Ben Chuang wrote:
> > Hi Takahiro,
> >
> > On Thu, Sep 17, 2020 at 1:12 PM AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > Adrian, Ben,
> > >
> > > Regarding _reset() function,
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
> > > > > ---
> > > > >  drivers/mmc/host/sdhci.c | 152 ++++++++++++++++++++++++++++++++++-----
> > > > >  1 file changed, 136 insertions(+), 16 deletions(-)
> > > > >
> > >
> > >   (snip)
> > >
> > > > >     if (host->ops->platform_send_init_74_clocks)
> > > > >             host->ops->platform_send_init_74_clocks(host, ios->power_mode);
> > > > >
> > > > > @@ -2331,7 +2411,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > > > >     }
> > > > >
> > > > >     if (host->version >= SDHCI_SPEC_300) {
> > > > > -           u16 clk, ctrl_2;
> > > > > +           u16 clk;
> > > > >
> > > > >             if (!host->preset_enabled) {
> > > > >                     sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > > > > @@ -3173,11 +3253,19 @@ static bool sdhci_request_done(struct sdhci_host *host)
> > > > >                     /* This is to force an update */
> > > > >                     host->ops->set_clock(host, host->clock);
> > > > >
> > > > > -           /* Spec says we should do both at the same time, but Ricoh
> > > > > -              controllers do not like that. */
> > > > > -           sdhci_do_reset(host, SDHCI_RESET_CMD);
> > > > > -           sdhci_do_reset(host, SDHCI_RESET_DATA);
> > > > > -
> > > > > +           if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > > +               host->mmc->flags & MMC_UHS2_INITIALIZED) {
> > > > > +                   if (sdhci_uhs2_ops.reset)
> > > > > +                           sdhci_uhs2_ops.reset(host,
> > > > > +                                                SDHCI_UHS2_SW_RESET_SD);
> > > > > +           } else {
> > > > > +                   /*
> > > > > +                    * Spec says we should do both at the same time, but
> > > > > +                    * Ricoh controllers do not like that.
> > > > > +                    */
> > > > > +                   sdhci_do_reset(host, SDHCI_RESET_CMD);
> > > > > +                   sdhci_do_reset(host, SDHCI_RESET_DATA);
> > > > > +           }
> > > >
> > > > Please look at using the existing ->reset() sdhci host op instead.
> > >
> > > Well, the second argument to those reset functions is a bit-wise value
> > > to different "reset" registers, SDHCI_SOFTWARE_RESET and SDHCI_UHS2_SW_RESET,
> > > respectively.
> > >
> > > This fact raises a couple of questions to me:
> > >
> > > 1) Does it make sense to merge two functionality into one, i.e.
> > >    sdhci_do_reset(), which is set to call ->reset hook?
> > >
> > >         -> Adrian
> > >
> > > 2) UHS2_SW_RESET_SD is done only at this place while there are many callsites
> > >    of reset(RESET_CMD|RESET_DATA) in sdhci.c.
> > >    Why does the current code work?
> > >
> > >    I found, in sdhci-pci-gli.c,
> > >    sdhci_gl9755_reset()
> > >         /* reset sd-tran on UHS2 mode if need to reset cmd/data */
> > >         if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))
> > >                 gl9755_uhs2_reset_sd_tran(host);
>
> (A)
>
> > >
> > >    Is this the trick to avoid the issue?
> > >    (It looks redundant in terms of the hack above in sdhci_request_done()
> > >    and even quite dirty to me. Moreover, no corresponding code for gl9750
> > >    and gl9763.)
> >
> > GL9755 currently does SD reset and UHS-II reset together.
>
> Do you mean that, in UHS-II operations, you need only the reset on
> SDHCI_UHS2_SW_RESET register?

No, GL9755 does SD reset and UHS-II reset together.

> But the hunk above (A) does the UHS-II reset along with UHS-I reset.
>
> > There is no UHS-II interface on gl9750 and gl9763e.
> >
> > >
> > >         -> Ben
> > >
> > > 3) (More or less SD specification issue)
> > >    In UHS-II mode, do we have to call reset(SHCI_RESET_ALL) along with
> > >    reset(UHS2_SW_RESET_FULL)?
> > >    Under the current implementation, both will be called at the end.
> > >
> >
> > As I know, the UHS2_SW_RESET_FULL is only for UHS-II.
> > Can you list the lines that reset(SHCI_RESET_ALL) and
> > reset(UHS2_SW_RESET_FULL) are both called?
>
> I was not clear here. (The above is also another example.)
>
> Look at sdhci_remove_host() and shdci_uhs2_remote_host().
> If the argument 'dead' is 0, we will do both of the resets for UHS-II.

 Do UHS2_SW_RESET_FULL in sdhci_uhs2_remove_host() and then do
SDHCI_RESET_ALL in sdhci_remove_host() is ok.


>
> -Takahiro Akashi
>
> > >         -> Adrian, Ben
> > >
> > > 4) (Not directly linked to UHS-II support)
> > >   In some places, we see the sequence:
> > >         sdhci_do_reset(host, SDHCI_RESET_CMD);
> > >         sdhci_do_reset(host, SDHCI_RESET_DATA);
> > >   while in other places,
> > >         sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> > >
> > >   If the statement below is true,
> > > > > -           /* Spec says we should do both at the same time, but Ricoh
> > > > > -              controllers do not like that. */
> > >   the latter should be wrong.
> > >
> > >         -> Adrian
> > >
> > > -Takahiro Akashi
> > >
> > >
> > >
> > > > >             host->pending_reset = false;
> > > > >     }
> > > > >
> > > > > @@ -3532,6 +3620,13 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
> > > > >                               SDHCI_INT_BUS_POWER);
> > > > >             sdhci_writel(host, mask, SDHCI_INT_STATUS);
> > > > >
> > > > > +           if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > > +               intmask & SDHCI_INT_ERROR &&
> > > > > +               host->mmc->flags & MMC_UHS2_SUPPORT) {
> > > > > +                   if (sdhci_uhs2_ops.irq)
> > > > > +                           sdhci_uhs2_ops.irq(host);
> > > > > +           }
> > > > > +
> > > >
> > > > Please look at using the existing ->irq() sdhci host op instead
> > > >
> > > > >             if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> > > > >                     u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> > > > >                                   SDHCI_CARD_PRESENT;
> > > > > @@ -4717,6 +4812,14 @@ int sdhci_setup_host(struct sdhci_host *host)
> > > > >             /* This may alter mmc->*_blk_* parameters */
> > > > >             sdhci_allocate_bounce_buffer(host);
> > > > >
> > > > > +   if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > > +       host->version >= SDHCI_SPEC_400 &&
> > > > > +       sdhci_uhs2_ops.add_host) {
> > > > > +           ret = sdhci_uhs2_ops.add_host(host, host->caps1);
> > > > > +           if (ret)
> > > > > +                   goto unreg;
> > > > > +   }
> > > > > +
> > > >
> > > > I think you should look at creating uhs2_add_host() instead
> > > >
> > > > >     return 0;
> > > > >
> > > > >  unreg:
> > > > > @@ -4738,6 +4841,8 @@ void sdhci_cleanup_host(struct sdhci_host *host)
> > > > >  {
> > > > >     struct mmc_host *mmc = host->mmc;
> > > > >
> > > > > +   /* FIXME: Do we have to do some cleanup for UHS2 here? */
> > > > > +
> > > > >     if (!IS_ERR(mmc->supply.vqmmc))
> > > > >             regulator_disable(mmc->supply.vqmmc);
> > > > >
> > > > > @@ -4766,6 +4871,14 @@ int __sdhci_add_host(struct sdhci_host *host)
> > > > >             mmc->cqe_ops = NULL;
> > > > >     }
> > > > >
> > > > > +   if ((mmc->caps & MMC_CAP_UHS2) && !host->v4_mode) {
> > > > > +           /* host doesn't want to enable UHS2 support */
> > > > > +           mmc->caps &= ~MMC_CAP_UHS2;
> > > > > +           mmc->flags &= ~MMC_UHS2_SUPPORT;
> > > > > +
> > > > > +           /* FIXME: Do we have to do some cleanup here? */
> > > > > +   }
> > > > > +
> > > > >     host->complete_wq = alloc_workqueue("sdhci", flags, 0);
> > > > >     if (!host->complete_wq)
> > > > >             return -ENOMEM;
> > > > > @@ -4812,6 +4925,9 @@ int __sdhci_add_host(struct sdhci_host *host)
> > > > >  unled:
> > > > >     sdhci_led_unregister(host);
> > > > >  unirq:
> > > > > +   if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > > +       sdhci_uhs2_ops.remove_host)
> > > > > +           sdhci_uhs2_ops.remove_host(host, 0);
> > > > >     sdhci_do_reset(host, SDHCI_RESET_ALL);
> > > > >     sdhci_writel(host, 0, SDHCI_INT_ENABLE);
> > > > >     sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
> > > > > @@ -4869,6 +4985,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
> > > > >
> > > > >     sdhci_led_unregister(host);
> > > > >
> > > > > +   if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > > +       sdhci_uhs2_ops.remove_host)
> > > > > +           sdhci_uhs2_ops.remove_host(host, dead);
> > > > > +
> > > >
> > > > I think you should look at creating uhs2_remove_host() instead
> > > >
> > > > >     if (!dead)
> > > > >             sdhci_do_reset(host, SDHCI_RESET_ALL);
> > > > >
> > > > >
> > > >
