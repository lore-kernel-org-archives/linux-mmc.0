Return-Path: <SRS0=X25L=C3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0391FC43463
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Sep 2020 10:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C37222072E
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Sep 2020 10:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuOVvGLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRKug (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Sep 2020 06:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRKug (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Sep 2020 06:50:36 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DD5C06174A;
        Fri, 18 Sep 2020 03:50:36 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h206so3972043ybc.11;
        Fri, 18 Sep 2020 03:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=I3G3khIWUlWhQUlaFkWi9beNmaTHarXOA3fj1sr8voA=;
        b=XuOVvGLuEBSGLqmcT234C1pVwvWhauxGpWof3PdOCoICAsJSISjuYshBKn1gA9mrta
         wHowlVYnoKJ9aK6wC0wMwuFoMAj68pyg5HehFzwh2NkJpt+tf1Crs/JvGM96rCxkG7XJ
         C1hMI8ZH6dfmKrsP3bxlDU4FfEVR09aB4g2/JxCNElR4bOYUcOmgnNTdzxDHrxJvB7aj
         8OLj4MnYV7z7IxXH2WLsQLf+8uTXhUrrEgBe+3v2lxhiBujiAWfCi+YALpKk1iQSnuoa
         P6whW2xWwfBhnPYR277AtEaEdooLTZhyREnWtMeXWMRSpTWZsihTbwUyBPlVMIdwU82n
         VoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=I3G3khIWUlWhQUlaFkWi9beNmaTHarXOA3fj1sr8voA=;
        b=VMFIM6zx/+7fLNTLTCn4I/WUf2CfMvvrGp4V29v8Q9vQjv+lt0C1Lw1MHjnGoQymla
         0Zr2n7t/sXDBS6R0xTlAWDKxtdxYgZzb1ckdJbwfk4E43/opa93M9opxtp6az4C69p3g
         bQNBDb0CAz1ieeqYWWkXKXiLwkK4/bEefGEXBqbB8G388/M/Gd/FveDtGdIIftX4xXJd
         IeJFLtuQpKxyb3Ip0i18SQumDIgNvg6hTsxEfD1Rwa06i6QZND6ZE8/Eg3afu7TTwhzW
         YoKQwh5Bd9NPabUoygiqPUu7JA88Vukh59ey1It5CvO+5lnWKcD2nbKzSer3pySxC4M7
         qo3w==
X-Gm-Message-State: AOAM532TicX1nAcwTg2LppB0/KasSQrsLKEzgmRhGaiia99EnLuNGx0P
        mD1SgitaSfBOUCftPhKKSZnly1bZ5Nkve4w218g=
X-Google-Smtp-Source: ABdhPJysduosPEsYaciEhTZCGHHSaJW7/p57KdMA6INnopS4i+d5nom0fCx2+NJbInFM7j5511OiVi8t3xQbyLOCmqQ=
X-Received: by 2002:a25:44:: with SMTP id 65mr8427789yba.6.1600426235320; Fri,
 18 Sep 2020 03:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200710111054.29562-1-benchuanggli@gmail.com>
 <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com> <20200918063843.GA46229@laputa>
In-Reply-To: <20200918063843.GA46229@laputa>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Fri, 18 Sep 2020 18:50:24 +0800
Message-ID: <CACT4zj-Uo6v_H_G0_LtYjDEN1jKsssjwN-utcZH2y-zqpV1Y3Q@mail.gmail.com>
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, Renius.Chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Sep 18, 2020 at 2:38 PM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Adrian, Ben,
>
> Regarding _set_ios() function,
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
>
>   (snip)
>
> > > @@ -2261,6 +2324,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > >  {
> > >     struct sdhci_host *host = mmc_priv(mmc);
> > >     u8 ctrl;
> > > +   u16 ctrl_2;
> > >
> > >     if (ios->power_mode == MMC_POWER_UNDEFINED)
> > >             return;
> > > @@ -2287,6 +2351,10 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > >             sdhci_enable_preset_value(host, false);
> > >
> > >     if (!ios->clock || ios->clock != host->clock) {
> > > +           if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > +               ios->timing == MMC_TIMING_UHS2)
> > > +                   host->timing = ios->timing;
> > > +
> > >             host->ops->set_clock(host, ios->clock);
> > >             host->clock = ios->clock;
> > >
> > > @@ -2308,6 +2376,18 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > >     else
> > >             sdhci_set_power(host, ios->power_mode, ios->vdd);
> > >
> > > +   /* 4.0 host support */
> > > +   if (host->version >= SDHCI_SPEC_400) {
> > > +           /* UHS2 Support */
> > > +           if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > +               host->mmc->flags & MMC_UHS2_SUPPORT &&
> > > +               host->mmc->caps & MMC_CAP_UHS2) {
> > > +                   if (sdhci_uhs2_ops.do_set_ios)
> > > +                           sdhci_uhs2_ops.do_set_ios(host, ios);
> > > +                   return;
> > > +           }
> > > +   }
> > > +
> >
> > Please look at using existing callbacks instead, maybe creating uhs2_set_ios(), uhs2_set_clock(), uhs2_set_power()
>
> I think that we will create uhs2_set_ios() (and uhs2_set_power()
> as we discussed on patch#15/21), but not uhs_set_clock().
>
> Since we have a hook only in struct mmc_host_ops, but not in struct
> sdhci_ops, all the drivers who want to support UHS-II need to
> set host->mmc_host_ops->set_ios to sdhci_uhs2_set_ios explicitly
> in their own init (or probe) function.
> (Again, sdhci_uhs2_set_ios() seems to be generic though.)
>
> Is this okay for you?
>         -> Adrian
>
> During refactoring the code, I found that sdhci_set_power() is called
> twice in sdhci_set_ios():
>         sdhci_set_ios(host, power_mode, vdd1, -1); in sdhci_set_ios(), and
>         sdhci_set_ios(host, power_mode, vdd1, vdd2) in ush2_do_set_ios()
>
> Can you please confirm that those are redundant?

Yes, uhs2 set power is independent with uhs1.
But set  uhs2 power process  should meet  uhs2 spec.

>         -> Ben
>
> I also wonder why we need spin locks in uhs2_do_set_ios() while
> not in sdhci_set_ios().

You can check if  spin locks in uhs2_do_set_ios() is necessary.
If set/clear irq can be execute safely without spin locks, you can
remove spin locks.

>
>         -> Ben
>
> -Takahiro Akashi
