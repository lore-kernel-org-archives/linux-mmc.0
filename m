Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35021C43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 12:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D572146E
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 12:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576670699;
	bh=ncgLHEYzzJo419YIH+V7O7bf5VirYYlUAxUXG/vuyN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PAFKMz+MG5gZrjKhIqjG4qSbumPF+9uXyVxyq/GH1FzyMr2RtHDBP9T5/DPYAAzRQ
	 6o68w3CvsJADMJ497KSZUiiFhl9R4k6DL0XCaTPWuuaXVViS+O1cpCLcG8rdb1B73+
	 5sLpaY54JG9hRFpkbNDA6bjanY8kuLKC9MvQA4zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfLRME6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:04:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfLRME6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Dec 2019 07:04:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F34C62072B;
        Wed, 18 Dec 2019 12:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576670697;
        bh=ncgLHEYzzJo419YIH+V7O7bf5VirYYlUAxUXG/vuyN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WL4ZpdQnkfqBmzrmks8aQ976YIwAYsFeecl9Doe7lhjxt228Uzzn7xDBXrxtYiOJh
         WLORn+tBbR/3/9xWHe8BTjr6vXuns1AjnqEksNH88fz5/N+yS8mD8s7DWfrFgWBXOY
         zoJcrHEbIYCOUl1pOUZuGpWIpKTvjdiNL+yMg/gI=
Date:   Wed, 18 Dec 2019 13:04:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Bao D. Nguyen" <nguyenb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>, cang@codeaurora.org,
        Sujith Reddy Thumma <sthumma@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Xiaonian Wang <xiaonian@codeaurora.org>
Subject: Re: [<PATCH v1> 7/9] mmc: core: Skip frequency retries for SDCC slots
Message-ID: <20191218120454.GA15400@kroah.com>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
 <68b936a67e67cd25597915cbd76b73ed046d1ce4.1576540908.git.nguyenb@codeaurora.org>
 <20191218083448.GE1554871@kroah.com>
 <CAPDyKFr2t3w1wXY+DD27vHF23mSjnUwCh7iZyuQ=ua=s+KvyVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr2t3w1wXY+DD27vHF23mSjnUwCh7iZyuQ=ua=s+KvyVA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Dec 18, 2019 at 12:48:20PM +0100, Ulf Hansson wrote:
> On Wed, 18 Dec 2019 at 09:34, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Dec 16, 2019 at 06:50:40PM -0800, Bao D. Nguyen wrote:
> > > From: Sujith Reddy Thumma <sthumma@codeaurora.org>
> > >
> > > Qualcomm SDCC controller supports minimum SD clock frequency
> > > which is required for card initialization. This information is
> > > exported through platform data for each SDCC controller. There is
> > > no need of retrying higher frequencies than the minimum supported
> > > by controller for Qualcomm chipsets which inturn add delay in
> > > detection process if there is no card during suspend/resume cycles.
> > > Hence, skip multiple frequency retries.
> > >
> > > Signed-off-by: Sujith Reddy Thumma <sthumma@codeaurora.org>
> > > Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> > > Signed-off-by: Xiaonian Wang <xiaonian@codeaurora.org>
> > > Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> > > ---
> > >  drivers/mmc/core/core.c | 9 +--------
> > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > index 1e37f78..38b0cec 100644
> > > --- a/drivers/mmc/core/core.c
> > > +++ b/drivers/mmc/core/core.c
> > > @@ -2281,7 +2281,6 @@ void mmc_rescan(struct work_struct *work)
> > >  {
> > >       struct mmc_host *host =
> > >               container_of(work, struct mmc_host, detect.work);
> > > -     int i;
> > >
> > >       if (host->rescan_disable)
> > >               return;
> > > @@ -2332,13 +2331,7 @@ void mmc_rescan(struct work_struct *work)
> > >               mmc_release_host(host);
> > >               goto out;
> > >       }
> > > -
> > > -     for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> > > -             if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
> > > -                     break;
> > > -             if (freqs[i] <= host->f_min)
> > > -                     break;
> > > -     }
> > > +     mmc_rescan_try_freq(host, host->f_min);
> >
> > What about for non-qualcomm controllers?  Did this just break their
> > functionality?
> 
> Yes it does, obviously.
> 
> Greg, thanks for providing some valuable feedback for Bao for a couple
> of the patches in this series.
> 
> I have also browsed through the series, but stopped providing feedback
> after patch1, when I realized that these are all just downstream
> vendor specific hacks.

That's all kernel drivers are, vendor-specific quirks/hacks around
broken hardware :)

Splitting this out into logical fixes, like some of these are here, is
great.  But breaking non-qualcomm hardware like this patch would do, is
obviously not ok.

> Sure, I guess most of the patches can be reworked as upstreamable
> solutions,

They have to be upstreamable, you don't want these in random vendor
trees as they go no where and atrophy and break users.  We want them in
our main tree for everyone to use for the obvious reason that they are
needed to get real hardware working.

thanks,

greg k-h
