Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A2BC43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 13:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD532465E
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 13:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QS5rfGtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLRNNM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:13:12 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45053 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLRNNM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 08:13:12 -0500
Received: by mail-ua1-f65.google.com with SMTP id d6so596773uam.11
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 05:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rbi/0HS4TN9MANgwRP5JBMfuN16L4USYE1XV5828ilU=;
        b=QS5rfGtpIAE7RMx4aEDqVVyni4Jt33kyj74vqBpxxDEy0qJ56cgdREeAgUckhQjgkU
         w2pHwQ+VJsSFKxOXu3H1nUPRTeSauBTCiaaCJpi0kxfXaAXYMcY19wusHwhhkWTANvKB
         K2hLxeJt7edjP6ojGxL3drL3zHxTx/nj44PO6MDTu2sloOIEMl9+BydQeSXduSWfQ9Ij
         MRhq+RRVYg3oMw1kzq4YUIP1uNcLjW+kw/oYAie8bgtuMjjlnIayML/P1IWM8Va5/VBD
         lPjezShzglR8RFzkQjF53Z0J7932VOQkcC7WXcxV4j94etq+KVIxDGbwifBsHOjYpjI3
         yAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rbi/0HS4TN9MANgwRP5JBMfuN16L4USYE1XV5828ilU=;
        b=tnSLZ5YiNxwvYqgOWTxp8ve9GX7Ktl4qQUVumwQ1/hl/JpPhX/P8qjowvbKPYmBmg0
         yRgQNGwYYlqVMW7XufDV8qDV7hRjZcXntSaGRt7XT2gGV2s6a024KYiDxPUw4GDe6AED
         dROw+zetZ1Q1tHlxagm7ReRsgYNX3Ttwdp64ZQgRCrxfWtnFZBPgNJBDcC0IeGQSGV2s
         DbkMDwfzZ0EiJBlpZP3ZrYLf3ibwS9nJb32JVdrg+Y+m57EbHPMhSOxiSQYNDMe/FaZY
         p8rG1tQ3FDR6XQMUhjSYa7p3SbbyP9NItlGNQDV+s4mX1MhBSEiP8oUAd/yhnNbps/fW
         jqog==
X-Gm-Message-State: APjAAAXXPinsrBDUrbM+dP/B8BP3ZOCOubFM6zdMPgzmBee0QtvKAe20
        C4wa8lZ7SALEYbi7uvUVVKzqyEOn5jQWbxe/VfAtDWza
X-Google-Smtp-Source: APXvYqyR53PC7G7Sq2/BZL7+v9/D5h4WFmyLKQAuV03T6MvOhfFYh9bqmrFmZaB8B7BPsOHxDL9DdD5N3aor9uIcIao=
X-Received: by 2002:ab0:e16:: with SMTP id g22mr1208910uak.129.1576674790843;
 Wed, 18 Dec 2019 05:13:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576540906.git.nguyenb@codeaurora.org> <68b936a67e67cd25597915cbd76b73ed046d1ce4.1576540908.git.nguyenb@codeaurora.org>
 <20191218083448.GE1554871@kroah.com> <CAPDyKFr2t3w1wXY+DD27vHF23mSjnUwCh7iZyuQ=ua=s+KvyVA@mail.gmail.com>
 <20191218120454.GA15400@kroah.com>
In-Reply-To: <20191218120454.GA15400@kroah.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 14:12:34 +0100
Message-ID: <CAPDyKFo929cnz9GS23B2vdDdd1RpJpYFeRwXaMFcTCEMxjS-5g@mail.gmail.com>
Subject: Re: [<PATCH v1> 7/9] mmc: core: Skip frequency retries for SDCC slots
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Bao D. Nguyen" <nguyenb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>, cang@codeaurora.org,
        Sujith Reddy Thumma <sthumma@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Xiaonian Wang <xiaonian@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Dec 2019 at 13:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 18, 2019 at 12:48:20PM +0100, Ulf Hansson wrote:
> > On Wed, 18 Dec 2019 at 09:34, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Dec 16, 2019 at 06:50:40PM -0800, Bao D. Nguyen wrote:
> > > > From: Sujith Reddy Thumma <sthumma@codeaurora.org>
> > > >
> > > > Qualcomm SDCC controller supports minimum SD clock frequency
> > > > which is required for card initialization. This information is
> > > > exported through platform data for each SDCC controller. There is
> > > > no need of retrying higher frequencies than the minimum supported
> > > > by controller for Qualcomm chipsets which inturn add delay in
> > > > detection process if there is no card during suspend/resume cycles.
> > > > Hence, skip multiple frequency retries.
> > > >
> > > > Signed-off-by: Sujith Reddy Thumma <sthumma@codeaurora.org>
> > > > Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> > > > Signed-off-by: Xiaonian Wang <xiaonian@codeaurora.org>
> > > > Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> > > > ---
> > > >  drivers/mmc/core/core.c | 9 +--------
> > > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > > index 1e37f78..38b0cec 100644
> > > > --- a/drivers/mmc/core/core.c
> > > > +++ b/drivers/mmc/core/core.c
> > > > @@ -2281,7 +2281,6 @@ void mmc_rescan(struct work_struct *work)
> > > >  {
> > > >       struct mmc_host *host =
> > > >               container_of(work, struct mmc_host, detect.work);
> > > > -     int i;
> > > >
> > > >       if (host->rescan_disable)
> > > >               return;
> > > > @@ -2332,13 +2331,7 @@ void mmc_rescan(struct work_struct *work)
> > > >               mmc_release_host(host);
> > > >               goto out;
> > > >       }
> > > > -
> > > > -     for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> > > > -             if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
> > > > -                     break;
> > > > -             if (freqs[i] <= host->f_min)
> > > > -                     break;
> > > > -     }
> > > > +     mmc_rescan_try_freq(host, host->f_min);
> > >
> > > What about for non-qualcomm controllers?  Did this just break their
> > > functionality?
> >
> > Yes it does, obviously.
> >
> > Greg, thanks for providing some valuable feedback for Bao for a couple
> > of the patches in this series.
> >
> > I have also browsed through the series, but stopped providing feedback
> > after patch1, when I realized that these are all just downstream
> > vendor specific hacks.
>
> That's all kernel drivers are, vendor-specific quirks/hacks around
> broken hardware :)
>
> Splitting this out into logical fixes, like some of these are here, is
> great.  But breaking non-qualcomm hardware like this patch would do, is
> obviously not ok.
>
> > Sure, I guess most of the patches can be reworked as upstreamable
> > solutions,
>
> They have to be upstreamable, you don't want these in random vendor
> trees as they go no where and atrophy and break users.  We want them in
> our main tree for everyone to use for the obvious reason that they are
> needed to get real hardware working.

I fully agree and I am willing to help!

Just didn't want to waste my time reviewing all at once in great
detail - if it turns out that the submitter don't care to re-spin, as
that has happened before (not by Bao).

Kind regards
Uffe
