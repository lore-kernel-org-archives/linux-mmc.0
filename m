Return-Path: <SRS0=q7gx=CZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C73FC433E2
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 00:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB95321655
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 00:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPEE1epm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIPAwk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgIPAwX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 20:52:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CABAC061788
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2020 17:52:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t7so670998pjd.3
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2020 17:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=GPeCAv+61SbaCTEFUaEZ0zdbDCaVT+T1r3F8ImmWNss=;
        b=xPEE1epm0ecAjz01c+R2GPOQNTZ1GIMbPiwagVVKat+yGoq/w0nzIwaZe7DwXL2/Hv
         6oOytHU3kBh4+msIcIhye4VC0PwkPJa4cdNBo9TOBlEh1dKiB/gvN8EAkyYAjlM979JE
         wL9mwpVyk7NOEMBrET8wjy+TtUyK56aKagqg6WkxpdqpFmEFkZelwIplDEuYDb0ygM9j
         mziil+sQ07DuJqqTj14Bd2c5Z3UFDRGBZsGbRzrDlHSh3X01Ss+3yL+X2CWgCCJziCQt
         1XoBlp9RQoJ+4y+L3dqkaVjv2Q2ECpvcQ/4wIB61x9YcRzD2UPkk/zFl22BDJEpbCykT
         pqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=GPeCAv+61SbaCTEFUaEZ0zdbDCaVT+T1r3F8ImmWNss=;
        b=Lz8ur8VcFRtNRsI8AITej3tFNsKuDE1qEZQ1tfanWVwlUWp5MPboZOzF7D92pgmJFQ
         RlIXdVn9RHrVbfbCxL0C9pkXMMQaHwv0U/Exec2CU6fs/lS7d9FWIi+gvGWcctz3lIGC
         zxICBf96syA9qODkQf4HAS1lb+eWygnZW/j/ZRVB76x2Ke2UofSKouz8ae6g6qszVCTH
         JPvzG2xxgJCGLXzxJLhDuHjBOFTNUBWax5FEMIdQUZZ6mEtRImTZArVeZl+RQi6otGc1
         R+fqu866J8fh8vbPPquP4Jnwx1FlrX8wpRelsRfszbupp9sOv0jKu54//1l72jKARmpA
         AVJg==
X-Gm-Message-State: AOAM532ysqRZ7CVe7DdpEcLn0LE6FRV4pXV/Mpin3QH/q0aHFr7mgZxn
        FPK5aUcaeHRA7W8l82q0fxhFGA==
X-Google-Smtp-Source: ABdhPJweD8TuWUq3fEBYJkmDmrGHe2ZptJWLQLVKKLAot5rdTNFOs8WPgHttoLY7TLrTtc9jOEqPeA==
X-Received: by 2002:a17:90b:1b03:: with SMTP id nu3mr1711403pjb.148.1600217537646;
        Tue, 15 Sep 2020 17:52:17 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id z4sm14925695pfr.197.2020.09.15.17.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 17:52:17 -0700 (PDT)
Date:   Wed, 16 Sep 2020 09:52:13 +0900
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
Message-ID: <20200916005213.GA2942982@laputa>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4zj-sZaKxyPGL=wm28Bdwq5G7R8-XfDnd=U7=vrNXnXAQVA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 15, 2020 at 07:36:14PM +0800, Ben Chuang wrote:
> Hi Takahiro,
> 
> On Tue, Sep 15, 2020 at 2:03 PM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Ben, Adrian,
> >
> > On Mon, Sep 14, 2020 at 11:08:14AM +0300, Adrian Hunter wrote:
> > > On 14/09/20 9:40 am, AKASHI Takahiro wrote:
> > > > Adrian,
> > > >
> > > > On Fri, Aug 21, 2020 at 05:09:01PM +0300, Adrian Hunter wrote:
> > > >> On 10/07/20 2:11 pm, Ben Chuang wrote:
> > > >>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > >>>
> > > >>> sdhci_start_signal_voltage_switch() should be called only in UHS-I mode,
> > > >>> and not for UHS-II mode.
> > > >>>
> > > >>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > >>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > >>> ---
> > > >>>  drivers/mmc/host/sdhci.c | 7 ++++++-
> > > >>>  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >>>
> > > >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > >>> index 5511649946b9..7f2537648a08 100644
> > > >>> --- a/drivers/mmc/host/sdhci.c
> > > >>> +++ b/drivers/mmc/host/sdhci.c
> > > >>> @@ -2623,8 +2623,13 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> > > >>>   /*
> > > >>>    * Signal Voltage Switching is only applicable for Host Controllers
> > > >>>    * v3.00 and above.
> > > >>> +  * But for UHS2, the signal voltage is supplied by vdd2 which is
> > > >>> +  * already 1.8v so no voltage switch required.
> >
> > I have been confused with this comment.
> > (I know it came from the original Intel code, not from Ben.)
> >
> > If this comment is true,
> >
> > > >>>    */
> > > >>> - if (host->version < SDHCI_SPEC_300)
> > > >>> + if (host->version < SDHCI_SPEC_300 ||
> > > >>> +     (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > >>> +      host->version >= SDHCI_SPEC_400 &&
> > > >>> +      host->mmc->flags & MMC_UHS2_SUPPORT))
> >
> > the condition above must be wrong since 'flags & MMC_UHS2_SUPPORT'
> > is one of capabilities for a host controller, not a card
> > while the selection of voltage depends on a card type.
> 
> The flag MMC_UHS2_SUPPORT is set at the beginning of mmc_uhs2_rescan_try_freq().
> In UHS-II flow, it stays set.
> If the attempt to UHS-II fails finally, it will be unset.

Right, but MMC_UHS2_SUPPORT is also set, at least initially,
in sdhci_uhs2_add_host(). It is confusing, isn't it?

As we discussed before, any card-specific properties, like UHS-II mode,
should be placed in a card structure, not a host structure.

> >
> > So I wonder why this code still works.
> > I guess that it is because set_signal_voltage(), or other variant functions,
> > will never be called for UHS-II cards under the current implementation.
> >
> > Looking at mmc_sd_init_card(), we have added some hack:
> > mmc_sd_init_card()
> > {
> >         ...
> >         /* For UHS2, skip the UHS-I initialization. */
> >         if ((host->flags & MMC_UHS2_SUPPORT) &&
> >             (host->flags & MMC_UHS2_INITIALIZED))
> >                 goto done;
> >         ...
> >                 if (mmc_sd_card_using_v18(card)) {
> >                         if (mmc_host_set_uhs_voltage(host) ||
> >                             mmc_sd_init_uhs_card(card)) {
> >                 ...
> > }
> >
> > Ben, can you confirm this?
> > (There is another callsite of mmc_host_set_uhs_voltage() though.)
> 
> UHS-II cards use differential signals and don't need to signal voltage switch.
> But the main task is to set the parameters of UHS-II card interface.

Whoever sets MMC_UHS2_SUPPORT (and MMC_UHS2_INITIALIZED), my assertion above
(mmc_host_set_uhs_voltage, and hence [sdhci_]start_signal_voltage_switch(), is
never called for UHS-II cards) will be valid, isn't it?

-Takahiro Akashi

> >
> > > >> Please look at hooking ->start_signal_voltage_switch() instead
> > > >
> > > > Do you mean that you want every platform driver who wants to support UHS-II
> > > > to set NULL to start_signal_voltage_switch hook even if this hack is
> > > > platform agnostic?
> > >
> > > No, I see UHS-II as a separate layer i.e.
> > >
> > >  UHS-II host controller driver
> > >   |   |
> > >   |   v
> > >   |   sdhci-uhs2 e.g. sdhci_uhs2_start_signal_voltage_switch
> > >   |   |
> > >   v   v
> > >   sdhci e.g. sdhci_start_signal_voltage_switch
> > >
> > > Most things should go through sdhci-uhs2 but not nessarily everything.
> >
> > What I meant by my previous comment is that we don't have to
> > call any function, sdhci_uhs2_start_signal_voltage_switch in above example,
> > for UHS-II cards in any case since it is always simply empty.
> >
> > -Takahiro Akashi
