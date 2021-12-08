Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7073C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Dec 2021 10:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhLHKbW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Dec 2021 05:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhLHKbU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Dec 2021 05:31:20 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03747C0617A1
        for <linux-mmc@vger.kernel.org>; Wed,  8 Dec 2021 02:27:49 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l22so4634774lfg.7
        for <linux-mmc@vger.kernel.org>; Wed, 08 Dec 2021 02:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9Ad+pXBcw17WjnzQIAyHTe6XfhUYPNxm9plte3UEx8=;
        b=VMpe0kdEsp7QL9SErgbxlyHE7MKjhFr88GwxPazqrZZvmUYi/HWg/rYbN8al0y/NAM
         2q9gvxaj2ZeWaH204Ptz9gp7o8lNH21ysADVWMOTw8ZyfwMiHDodCys3MzeVwir7SPtE
         aUhi7TKcw3/4MGwCsBuHVSDlIOWveytNqkfOxrC2ukbD14Tukl73tUBntG9m7kRNlWwo
         HwdUd6U9wKaKGqVHDDAQFHbZKarJ3tE9DGVS10U+THm0sUwGqTUibjvzsB5SS+6ugPGo
         xzAyejRhlhNFgE6GSAC4SubdwqKkeuK5SdaAyrPvTite+f33q4ibY/McoF9FI6wxvbua
         Ajjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9Ad+pXBcw17WjnzQIAyHTe6XfhUYPNxm9plte3UEx8=;
        b=2IVvaXdlCnfdh3hvAtKfM9NPmGnQZH+656pCtokrDnouuFwky7gRzlRIosYzqsbXHB
         oJk5yTQjcSPSJlgOFh5ue7MYpWyupivtr1Cx8sqUvr1CD+NP2iBfck1YZ1zZd8sZp8tj
         64bDG/WjTcKbEAHUSDGFNcVE4ZNh6p+PND0zhhY9VAOYLg5MBDqPHJf6Mk/EbyT7mXKL
         t65QwO1BjXS6KrH5I7sNKnDndKhUs/wtoOMoptfPrS8DtsCghbnx1wObyFTACn2tj8yJ
         vZwhjssMU9bLpY3JHRUIXpOZ2eDRMiLf7xSs+O/ps3HT0C+FEvItRs+M5o7Q99lzAfio
         qm5Q==
X-Gm-Message-State: AOAM532Uf1CBuuF9nfcjquoUQloPFZsV5hn+QqYX/7F64Udg62DPeSlO
        0/Ii8SBMndVGiX+NGlPZGuX91A97A9LJnN57sXZncaAvTv+wBA==
X-Google-Smtp-Source: ABdhPJyFjFheseBA2d0c00MuxmssaZ36xiZWiYqlIztk0lqfxHYEC4BtV/lI5+zP6oA2x0w2fZFgcbOkodPYGUHkXxU=
X-Received: by 2002:ac2:5607:: with SMTP id v7mr46477524lfd.71.1638959267283;
 Wed, 08 Dec 2021 02:27:47 -0800 (PST)
MIME-Version: 1.0
References: <5a38e5eb9fdc4b53ba4a11602e2cef0d@realtek.com> <CAPDyKFrC1JGCAAQZOOKe4VZS7g2Sg4MZKXr9WyMPeYDdQ3ht8g@mail.gmail.com>
 <b55390bd4a9942f3b37bd5bb8245ab25@realtek.com>
In-Reply-To: <b55390bd4a9942f3b37bd5bb8245ab25@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Dec 2021 11:27:10 +0100
Message-ID: <CAPDyKFpAACVTNcf5ckAVqn53envxDaG6x=RvNq=hGW7mEn+9MA@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: improve rw performance
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 6 Dec 2021 at 13:09, Ricky WU <ricky_wu@realtek.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Friday, December 3, 2021 10:33 PM
> > To: Ricky WU <ricky_wu@realtek.com>
> > Cc: gregkh@linuxfoundation.org; tommyhebb@gmail.com;
> > linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] mmc: rtsx: improve rw performance
> >
> > On Fri, 3 Dec 2021 at 11:43, Ricky WU <ricky_wu@realtek.com> wrote:
> > >
> > > sd_check_seq() to distinguish sequential rw or normal rw if this data
> > > is sequential call to sd_rw_sequential()
> >
> > Can you please extend this commit message? This doesn't answer why or what
> > this change really does, please try to do that, as to help me to review this.
> >
>
> This patch is for improving sequential read/write performance.

I would not use the term "sequential", but rather "multi-block read/writes".

> Before this, whether CMD is muti-RW or single-RW the driver do the same flow.
> This patch distinguishes the two and do different flow to get more performance
> on sequential RW.

Alright, thanks for clarifying.

So to be clear, please update the commit message to say that it's
improving performance for multi-block read/write. Then please add also
some information about how that is achieved.

Moreover, please rename the functions in the code according to this as
well, as to make it more clear. For example, use sd_rw_multi() (and
sd_rw_single() if that is needed), rather than sd_rw_sequential().

> sd_check_seq() to distinguish sequential RW (CMD 18/25) or normal RW (CMD 17/24)
> if the data is sequential call to sd_rw_sequential()

I will wait for a v2 from you, then I will give it another try to review.

[...]

Kind regards
Uffe
