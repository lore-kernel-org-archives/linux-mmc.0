Return-Path: <SRS0=rnDB=C2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48115C433E2
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Sep 2020 01:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2CF206F7
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Sep 2020 01:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDn0arJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIQBID (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Sep 2020 21:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgIQBIB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2020 21:08:01 -0400
X-Greylist: delayed 709 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:08:00 EDT
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8DFC06178A
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 17:56:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gf14so338189pjb.5
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 17:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=i7xug9MBkRiIDvaRrpUcg4p+BTLKaAhkMGj4CBz4SSM=;
        b=dDn0arJWoWAP1S1t/hE0KiPiQl4hJEm0SGZ8fmhttsIYIH0AVBk3+Rlb+OR0yrMt+b
         XQ5mMw5ruTeIzRYv5GwkNiTS+WiwKa/NUSuZRSSYvFxCes9lYLt8lhuhohPDA/LcvVWp
         XfYvT6QaqwS8Qir3FyAj6shoUDEJK3F31xd4yokQKoO2bmZTWLzOpo/ijtVLmpSwPDR2
         CJCqDZhF8QH/pUMrapUtOiARkdnM6KGVWmy0y9+1W+yhpAuz/CnLXmk4Iqstnqo6y/Td
         IF92F88+6hygQc8jg6MNXE/a9dtQfwllMxJpbs5EU3Yj0N3TF8mwVutdidVYwTsWKbsS
         Albg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=i7xug9MBkRiIDvaRrpUcg4p+BTLKaAhkMGj4CBz4SSM=;
        b=dBAL5A2cP5oTvugXNNnaHLc6i+QPssi1uVEUsJYpgOmyRln+O0oUQfH+oxKPIdLW4z
         rdK4s57iOhArxIbE10yHPFljIyPt6vWinfqWVgPzc79h1XrWDJvNTSiV9MU6Bd13mpTB
         3bA8PimgUEkdWton/jFkrkY5buHA9wREXD1kK06q9WavMjcuCiZstZMNwMUGLo9v6aZR
         20Ox0SyxuGowLFQ0faTcLckjCCxgIqUGUes8m0E32nbzcTBg/tHHA86pyyFprASST8al
         yyIlIqruLpLgbBslJlU1q7KHyBwWF9U+0aPgXSm2BlEJ/dNZBO+7Rmc2ieps8usBstcF
         9tew==
X-Gm-Message-State: AOAM532IIN7nNeCKnDtV+3KF8JxocXmgzZFhv+WJIxwOuOiTVrUyC7no
        SW0WAWnY8L8X0CHz7YKOY+oQUA==
X-Google-Smtp-Source: ABdhPJyqq423XtwYiwUt/KzDphwax1oNuoNHU38Lb/sXZkyvBNTZmA3TdmFweTFNnepLtDBRb8o2Gg==
X-Received: by 2002:a17:90a:4803:: with SMTP id a3mr6164330pjh.192.1600304170395;
        Wed, 16 Sep 2020 17:56:10 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id x27sm4056299pfp.128.2020.09.16.17.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 17:56:09 -0700 (PDT)
Date:   Thu, 17 Sep 2020 09:56:05 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 13/21] mmc: sdhci: UHS-II support, skip
 signal_voltage_switch()
Message-ID: <20200917005605.GA3071249@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
References: <20200710111104.29616-1-benchuanggli@gmail.com>
 <9ab64a9d-cd78-785c-b48f-561048cfe2ed@intel.com>
 <20200914064001.GA2743583@laputa>
 <a0000661-a0e1-8813-0672-c0eb73184079@intel.com>
 <20200915060306.GA2860208@laputa>
 <CACT4zj-sZaKxyPGL=wm28Bdwq5G7R8-XfDnd=U7=vrNXnXAQVA@mail.gmail.com>
 <20200916005213.GA2942982@laputa>
 <CACT4zj8QH2wPRL8=zDTWyAvzCRtqqqSQp4X-b83COxY6yB4bXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4zj8QH2wPRL8=zDTWyAvzCRtqqqSQp4X-b83COxY6yB4bXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ben,

On Wed, Sep 16, 2020 at 05:42:07PM +0800, Ben Chuang wrote:
> On Wed, Sep 16, 2020 at 8:52 AM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > On Tue, Sep 15, 2020 at 07:36:14PM +0800, Ben Chuang wrote:
> > > Hi Takahiro,
> > >
> > > On Tue, Sep 15, 2020 at 2:03 PM AKASHI Takahiro
> > > <takahiro.akashi@linaro.org> wrote:
> > > >
> > > > Ben, Adrian,
> > > >
> > > > On Mon, Sep 14, 2020 at 11:08:14AM +0300, Adrian Hunter wrote:
> > > > > On 14/09/20 9:40 am, AKASHI Takahiro wrote:
> > > > > > Adrian,
> > > > > >
> > > > > > On Fri, Aug 21, 2020 at 05:09:01PM +0300, Adrian Hunter wrote:
> > > > > >> On 10/07/20 2:11 pm, Ben Chuang wrote:
> > > > > >>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > > >>>
> > > > > >>> sdhci_start_signal_voltage_switch() should be called only in UHS-I mode,
> > > > > >>> and not for UHS-II mode.
> > > > > >>>
> > > > > >>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > > > >>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > > >>> ---
> > > > > >>>  drivers/mmc/host/sdhci.c | 7 ++++++-
> > > > > >>>  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > > >>>
> > > > > >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > > > >>> index 5511649946b9..7f2537648a08 100644
> > > > > >>> --- a/drivers/mmc/host/sdhci.c
> > > > > >>> +++ b/drivers/mmc/host/sdhci.c
> > > > > >>> @@ -2623,8 +2623,13 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> > > > > >>>   /*
> > > > > >>>    * Signal Voltage Switching is only applicable for Host Controllers
> > > > > >>>    * v3.00 and above.
> > > > > >>> +  * But for UHS2, the signal voltage is supplied by vdd2 which is
> > > > > >>> +  * already 1.8v so no voltage switch required.
> > > >
> > > > I have been confused with this comment.
> > > > (I know it came from the original Intel code, not from Ben.)
> > > >
> > > > If this comment is true,
> > > >
> > > > > >>>    */
> > > > > >>> - if (host->version < SDHCI_SPEC_300)
> > > > > >>> + if (host->version < SDHCI_SPEC_300 ||
> > > > > >>> +     (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > > >>> +      host->version >= SDHCI_SPEC_400 &&
> > > > > >>> +      host->mmc->flags & MMC_UHS2_SUPPORT))
> > > >
> > > > the condition above must be wrong since 'flags & MMC_UHS2_SUPPORT'
> > > > is one of capabilities for a host controller, not a card
> > > > while the selection of voltage depends on a card type.
> > >
> > > The flag MMC_UHS2_SUPPORT is set at the beginning of mmc_uhs2_rescan_try_freq().
> > > In UHS-II flow, it stays set.
> > > If the attempt to UHS-II fails finally, it will be unset.
> >
> > Right, but MMC_UHS2_SUPPORT is also set, at least initially,
> > in sdhci_uhs2_add_host(). It is confusing, isn't it?
> 
> I think it can be removed from sdhci_uhs2_add_host() to avoid making confusion.

Okay,

> >
> > As we discussed before, any card-specific properties, like UHS-II mode,
> > should be placed in a card structure, not a host structure.

Do you have any idea on this?
I remember that Ulf also made a similar comment on the "core" side.

-Takahiro Akashi

> >
> > > >
> > > > So I wonder why this code still works.
> > > > I guess that it is because set_signal_voltage(), or other variant functions,
> > > > will never be called for UHS-II cards under the current implementation.
> > > >
> > > > Looking at mmc_sd_init_card(), we have added some hack:
> > > > mmc_sd_init_card()
> > > > {
> > > >         ...
> > > >         /* For UHS2, skip the UHS-I initialization. */
> > > >         if ((host->flags & MMC_UHS2_SUPPORT) &&
> > > >             (host->flags & MMC_UHS2_INITIALIZED))
> > > >                 goto done;
> > > >         ...
> > > >                 if (mmc_sd_card_using_v18(card)) {
> > > >                         if (mmc_host_set_uhs_voltage(host) ||
> > > >                             mmc_sd_init_uhs_card(card)) {
> > > >                 ...
> > > > }
> > > >
> > > > Ben, can you confirm this?
> > > > (There is another callsite of mmc_host_set_uhs_voltage() though.)
> > >
> > > UHS-II cards use differential signals and don't need to signal voltage switch.
> > > But the main task is to set the parameters of UHS-II card interface.
> >
> > Whoever sets MMC_UHS2_SUPPORT (and MMC_UHS2_INITIALIZED), my assertion above
> > (mmc_host_set_uhs_voltage, and hence [sdhci_]start_signal_voltage_switch(), is
> > never called for UHS-II cards) will be valid, isn't it?
> >
> > -Takahiro Akashi
> >
> > > >
> > > > > >> Please look at hooking ->start_signal_voltage_switch() instead
> > > > > >
> > > > > > Do you mean that you want every platform driver who wants to support UHS-II
> > > > > > to set NULL to start_signal_voltage_switch hook even if this hack is
> > > > > > platform agnostic?
> > > > >
> > > > > No, I see UHS-II as a separate layer i.e.
> > > > >
> > > > >  UHS-II host controller driver
> > > > >   |   |
> > > > >   |   v
> > > > >   |   sdhci-uhs2 e.g. sdhci_uhs2_start_signal_voltage_switch
> > > > >   |   |
> > > > >   v   v
> > > > >   sdhci e.g. sdhci_start_signal_voltage_switch
> > > > >
> > > > > Most things should go through sdhci-uhs2 but not nessarily everything.
> > > >
> > > > What I meant by my previous comment is that we don't have to
> > > > call any function, sdhci_uhs2_start_signal_voltage_switch in above example,
> > > > for UHS-II cards in any case since it is always simply empty.
> > > >
> > > > -Takahiro Akashi
