Return-Path: <SRS0=/Wn+=DB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF6C4727D
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 09:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F94023977
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 09:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5nf+mBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgIXJ5y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Sep 2020 05:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgIXJ5x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2020 05:57:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3805C0613D3
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 02:57:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z18so1605912pfg.0
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 02:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EbUDDRztOho/LdfQyTgpNeVyP/mZKu/UYpSCwgslo+g=;
        b=w5nf+mBNL4RRvIotNEfxFX/T57av6jzqMm1wcEPGbsYhXExbCr0LHZ/7N7e7fqvPZM
         gb7viv+f2M1C95XAYzYoHgMAOysku1U/mUVpYehapI2RIxvzcoNEJNcNR1AWQEDYzX1l
         VdZYB/SUCnlkdgl2DcZVejLv2oSpD44aj36WW/MgcFZMWx+FPoKJlKWivFYxpOAV1cZ3
         cC0Fb23Xqtz6JNxppB3/LG9+rZYmS/TWCDyMw5Cwvg97N71Hd5iAkCxRjuJX6jptUQcP
         UWmFrupIcsE6zIdhW7uXV4b4ipJf8QeG49+Z4Bi6Q+NqhsO+hstHEdzBDrIlNWfySaXt
         InEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EbUDDRztOho/LdfQyTgpNeVyP/mZKu/UYpSCwgslo+g=;
        b=DE4l7p2SFw/oW+pPHu4VuReD8efyU/F9WkzzBMJ8C4EzVkaaDBnW9o0eBi2ObJan9b
         pvuwr/ZxWkEkKaA3S+8kjFJWE+PnQb/Aulj+i9/vfxVRNijtg75hFVqPln6bt8UzelPt
         OmTA3EYbH6ndoNo59quEO9SJXba/YL4aMMYY/7xdEvTC3scpwldptuhcBe4tgjKVn29z
         nNXS3/oiyE9xteGszICjUVBIXbQvydn+xWC8q4SUnWGw5T63NLF0XorV3HdDSJnWE4uQ
         t1SfZ/FyzCkccudbpQKuDExlolCOUg4pcwEQPoI+Czoq1Ctv8FVqp28vWC5R4kSGv+uI
         NOIg==
X-Gm-Message-State: AOAM533DcCTyg+Q35bRiZqCdNh3Qz65dpAvPsfF+4l4g5N9WeQFHNLRX
        RL55kRBizJZ7P9pxUWiScrEZFXIy67ky7GHW
X-Google-Smtp-Source: ABdhPJxx355zD05xBk282NDC+7w83cVDHajfy/crJtlVQ79QdcPvc8tCzu03w837VwonucV6OQRd5w==
X-Received: by 2002:a63:4416:: with SMTP id r22mr3402312pga.248.1600941472206;
        Thu, 24 Sep 2020 02:57:52 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id g206sm2339973pfb.178.2020.09.24.02.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:57:51 -0700 (PDT)
Date:   Thu, 24 Sep 2020 18:57:47 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, Renius.Chen@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
Message-ID: <20200924095747.GB38298@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, Renius.Chen@genesyslogic.com.tw
References: <20200710111054.29562-1-benchuanggli@gmail.com>
 <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com>
 <20200918063843.GA46229@laputa>
 <CACT4zj-Uo6v_H_G0_LtYjDEN1jKsssjwN-utcZH2y-zqpV1Y3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4zj-Uo6v_H_G0_LtYjDEN1jKsssjwN-utcZH2y-zqpV1Y3Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ben,

On Fri, Sep 18, 2020 at 06:50:24PM +0800, Ben Chuang wrote:
> On Fri, Sep 18, 2020 at 2:38 PM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Adrian, Ben,
> >
> > Regarding _set_ios() function,
> >
> > On Fri, Aug 21, 2020 at 05:08:32PM +0300, Adrian Hunter wrote:
> > > On 10/07/20 2:10 pm, Ben Chuang wrote:
> > > > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > >
> > > > In this commit, UHS-II related operations will be called via a function
> > > > pointer array, sdhci_uhs2_ops, in order to make UHS-II support as
> > > > a kernel module.
> > > > This array will be initialized only if CONFIG_MMC_SDHCI_UHS2 is enabled
> > > > and when the UHS-II module is loaded. Otherwise, all the functions
> > > > stay void.
> > > >
> > > > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >
> >   (snip)
> >
> > > > @@ -2261,6 +2324,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > > >  {
> > > >     struct sdhci_host *host = mmc_priv(mmc);
> > > >     u8 ctrl;
> > > > +   u16 ctrl_2;
> > > >
> > > >     if (ios->power_mode == MMC_POWER_UNDEFINED)
> > > >             return;
> > > > @@ -2287,6 +2351,10 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > > >             sdhci_enable_preset_value(host, false);
> > > >
> > > >     if (!ios->clock || ios->clock != host->clock) {
> > > > +           if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > +               ios->timing == MMC_TIMING_UHS2)
> > > > +                   host->timing = ios->timing;
> > > > +
> > > >             host->ops->set_clock(host, ios->clock);
> > > >             host->clock = ios->clock;
> > > >
> > > > @@ -2308,6 +2376,18 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > > >     else
> > > >             sdhci_set_power(host, ios->power_mode, ios->vdd);
> > > >
> > > > +   /* 4.0 host support */
> > > > +   if (host->version >= SDHCI_SPEC_400) {
> > > > +           /* UHS2 Support */
> > > > +           if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > +               host->mmc->flags & MMC_UHS2_SUPPORT &&
> > > > +               host->mmc->caps & MMC_CAP_UHS2) {
> > > > +                   if (sdhci_uhs2_ops.do_set_ios)
> > > > +                           sdhci_uhs2_ops.do_set_ios(host, ios);
> > > > +                   return;
> > > > +           }
> > > > +   }
> > > > +
> > >
> > > Please look at using existing callbacks instead, maybe creating uhs2_set_ios(), uhs2_set_clock(), uhs2_set_power()
> >
> > I think that we will create uhs2_set_ios() (and uhs2_set_power()
> > as we discussed on patch#15/21), but not uhs_set_clock().
> >
> > Since we have a hook only in struct mmc_host_ops, but not in struct
> > sdhci_ops, all the drivers who want to support UHS-II need to
> > set host->mmc_host_ops->set_ios to sdhci_uhs2_set_ios explicitly
> > in their own init (or probe) function.
> > (Again, sdhci_uhs2_set_ios() seems to be generic though.)
> >
> > Is this okay for you?
> >         -> Adrian
> >
> > During refactoring the code, I found that sdhci_set_power() is called
> > twice in sdhci_set_ios():
> >         sdhci_set_ios(host, power_mode, vdd1, -1); in sdhci_set_ios(), and
> >         sdhci_set_ios(host, power_mode, vdd1, vdd2) in ush2_do_set_ios()
> >
> > Can you please confirm that those are redundant?
> 
> Yes, uhs2 set power is independent with uhs1.
> But set  uhs2 power process  should meet  uhs2 spec.

Can you elaborate a bit more about the last sentence, please?

What I meant above is that
         sdhci_set_ios(host, power_mode, vdd1, vdd2) in ush2_do_set_ios()

this code will 'set_power' both vdd and vdd2 anyway and so
         sdhci_set_ios(host, power_mode, vdd1, -1); in sdhci_set_ios(), and
is just redundant.


> >         -> Ben
> >
> > I also wonder why we need spin locks in uhs2_do_set_ios() while
> > not in sdhci_set_ios().
> 
> You can check if  spin locks in uhs2_do_set_ios() is necessary.

I'm asking you.

While calling set_ios() doesn't require spin locks, are you aware of
any cases where we need spin locks in calling set_ios() for uhs-2?
(I mean that callers/contexts are the same either for uhs or uhs-2.)

-Takahiro Akashi

> If set/clear irq can be execute safely without spin locks, you can
> remove spin locks.
> 
> >
> >         -> Ben
> >
> > -Takahiro Akashi
