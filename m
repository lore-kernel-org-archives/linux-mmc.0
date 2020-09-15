Return-Path: <SRS0=q7gx=CZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CADEC43461
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 00:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 239F020770
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 00:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPo9UQMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIPAvk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbgIOLg1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 07:36:27 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F83CC06174A;
        Tue, 15 Sep 2020 04:36:26 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h126so2400922ybg.4;
        Tue, 15 Sep 2020 04:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=c6lrQum/YNNoSxqGKjvurQ5FEF5XBILOnwetukN/PvQ=;
        b=sPo9UQMCIBw3H9vOAmE1e+7qDEKQ9flriE11OOE4+rkN1Z3vT5ga9qNoYl25slSSK8
         KIO6vpFMNddPLLBVwXA9XI5Stpo6Z7Ui8fIlTCEZ6iOhOXd9AmuTDMDWyJknS88ywHId
         cpKMn6/fxLQAjpaZ4kMVZY7aakPCr/cu0ID278yGTNHwM6gQ3u9KJnR48XAxHzdVMFJ8
         vi96v/hgggOik/ByqjwVF6GXB7wdLQny27J5Vh9hd5J2KfsVf8fCuncci5P0d9NeWhSN
         Ky1837Pn7J7M7VyCekB6pgF9JFVIeqs2IajdBn07enq+q5GBqOPooSLoMt7eYPfvf4Tx
         gODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=c6lrQum/YNNoSxqGKjvurQ5FEF5XBILOnwetukN/PvQ=;
        b=UX17vU0hIbv1U06s07Fzh5+3/kO3VpJbF5/iEPUDiiZOFncxzjcx/+2mY52ftCoxnk
         dbPPOOzpNnJdwCGDxhQYqTQ9+nDFPg0aRIyhuYY2L96gbpaNPXFBqjb8+YRsT0nt9ucA
         QhFr+fVy7fOQRV2XDlZqKt6GKR30AXucwL4kSBwbcPgAaZgGQXdUvmCE83+PKnsGJ8yf
         zsS7/IUdPt1osaMIgaLhu9V57LA/U5Lg6dAyAUg9nUuthbGGpW2cFJsm6scK+eE777bz
         CT9YcJGz77tkpDjeDOJ/GJNypxF7Cqdzn9b+yP293Waq8xIQmZHWAGwZHW167WQi/5ww
         9aiA==
X-Gm-Message-State: AOAM532XPl2TCXIQMzxMl4+OMSGpbNCsO0TH15CM6zoAm0pFAQH2jGkG
        K8C5ZAgUkOG6GWNoh6coKw69N7etUVFuu5tR1/iE3lTeXP7PVQ==
X-Google-Smtp-Source: ABdhPJyG8sytYHx2zrzd2up0ST/yvSOCnll9sht0DR5BdjS1XfP1FYX52ngt1Lo+1UinEQ6nh4MFIv0l0/rp0gUT7QQ=
X-Received: by 2002:a25:d10d:: with SMTP id i13mr29402334ybg.476.1600169785417;
 Tue, 15 Sep 2020 04:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200710111104.29616-1-benchuanggli@gmail.com>
 <9ab64a9d-cd78-785c-b48f-561048cfe2ed@intel.com> <20200914064001.GA2743583@laputa>
 <a0000661-a0e1-8813-0672-c0eb73184079@intel.com> <20200915060306.GA2860208@laputa>
In-Reply-To: <20200915060306.GA2860208@laputa>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Tue, 15 Sep 2020 19:36:14 +0800
Message-ID: <CACT4zj-sZaKxyPGL=wm28Bdwq5G7R8-XfDnd=U7=vrNXnXAQVA@mail.gmail.com>
Subject: Re: [RFC PATCH V3 13/21] mmc: sdhci: UHS-II support, skip signal_voltage_switch()
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Takahiro,

On Tue, Sep 15, 2020 at 2:03 PM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Ben, Adrian,
>
> On Mon, Sep 14, 2020 at 11:08:14AM +0300, Adrian Hunter wrote:
> > On 14/09/20 9:40 am, AKASHI Takahiro wrote:
> > > Adrian,
> > >
> > > On Fri, Aug 21, 2020 at 05:09:01PM +0300, Adrian Hunter wrote:
> > >> On 10/07/20 2:11 pm, Ben Chuang wrote:
> > >>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >>>
> > >>> sdhci_start_signal_voltage_switch() should be called only in UHS-I mode,
> > >>> and not for UHS-II mode.
> > >>>
> > >>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > >>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >>> ---
> > >>>  drivers/mmc/host/sdhci.c | 7 ++++++-
> > >>>  1 file changed, 6 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > >>> index 5511649946b9..7f2537648a08 100644
> > >>> --- a/drivers/mmc/host/sdhci.c
> > >>> +++ b/drivers/mmc/host/sdhci.c
> > >>> @@ -2623,8 +2623,13 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> > >>>   /*
> > >>>    * Signal Voltage Switching is only applicable for Host Controllers
> > >>>    * v3.00 and above.
> > >>> +  * But for UHS2, the signal voltage is supplied by vdd2 which is
> > >>> +  * already 1.8v so no voltage switch required.
>
> I have been confused with this comment.
> (I know it came from the original Intel code, not from Ben.)
>
> If this comment is true,
>
> > >>>    */
> > >>> - if (host->version < SDHCI_SPEC_300)
> > >>> + if (host->version < SDHCI_SPEC_300 ||
> > >>> +     (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > >>> +      host->version >= SDHCI_SPEC_400 &&
> > >>> +      host->mmc->flags & MMC_UHS2_SUPPORT))
>
> the condition above must be wrong since 'flags & MMC_UHS2_SUPPORT'
> is one of capabilities for a host controller, not a card
> while the selection of voltage depends on a card type.

The flag MMC_UHS2_SUPPORT is set at the beginning of mmc_uhs2_rescan_try_freq().
In UHS-II flow, it stays set.
If the attempt to UHS-II fails finally, it will be unset.

>
> So I wonder why this code still works.
> I guess that it is because set_signal_voltage(), or other variant functions,
> will never be called for UHS-II cards under the current implementation.
>
> Looking at mmc_sd_init_card(), we have added some hack:
> mmc_sd_init_card()
> {
>         ...
>         /* For UHS2, skip the UHS-I initialization. */
>         if ((host->flags & MMC_UHS2_SUPPORT) &&
>             (host->flags & MMC_UHS2_INITIALIZED))
>                 goto done;
>         ...
>                 if (mmc_sd_card_using_v18(card)) {
>                         if (mmc_host_set_uhs_voltage(host) ||
>                             mmc_sd_init_uhs_card(card)) {
>                 ...
> }
>
> Ben, can you confirm this?
> (There is another callsite of mmc_host_set_uhs_voltage() though.)

UHS-II cards use differential signals and don't need to signal voltage switch.
But the main task is to set the parameters of UHS-II card interface.

>
> > >> Please look at hooking ->start_signal_voltage_switch() instead
> > >
> > > Do you mean that you want every platform driver who wants to support UHS-II
> > > to set NULL to start_signal_voltage_switch hook even if this hack is
> > > platform agnostic?
> >
> > No, I see UHS-II as a separate layer i.e.
> >
> >  UHS-II host controller driver
> >   |   |
> >   |   v
> >   |   sdhci-uhs2 e.g. sdhci_uhs2_start_signal_voltage_switch
> >   |   |
> >   v   v
> >   sdhci e.g. sdhci_start_signal_voltage_switch
> >
> > Most things should go through sdhci-uhs2 but not nessarily everything.
>
> What I meant by my previous comment is that we don't have to
> call any function, sdhci_uhs2_start_signal_voltage_switch in above example,
> for UHS-II cards in any case since it is always simply empty.
>
> -Takahiro Akashi
