Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54A7C433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 10 May 2021 14:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F64613C0
	for <linux-mmc@archiver.kernel.org>; Mon, 10 May 2021 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhEJOpQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 May 2021 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbhEJOnD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 May 2021 10:43:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E317C08EACB
        for <linux-mmc@vger.kernel.org>; Mon, 10 May 2021 07:01:50 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y9so20945509ljn.6
        for <linux-mmc@vger.kernel.org>; Mon, 10 May 2021 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQsuL10ttGgvUSSdwEEABCcNLhZF92QzGWTDfsTdZC0=;
        b=qNtWaLjGIXQMeTIChrMNYPp2/WjHnGPearQQprE05w3lsIY390FY2r1cFDsNdyxCNZ
         jrXtwIa2MpTAokF2DjIfBEnGEnFcNeKYhs/jcoPOwoWKck8/JKhBYwPkLF+7hPxoCSie
         WvdtEleVqiDOuLhvesR3tOU4j8ErY0Hxzn6dCO2MZ8Pr0I7BabiZpd1qQwKAE/+hxSY3
         nknoLINClx20aEJImVjqx37XthuTT1uHfzMX2Tt5c37QBi00j991nCh0BrlPoRevPo55
         I4W84RAKkx+qkHsUG7mmdZpFhUW4jCYGkFJ0Nxhg+ZFFjj6pOIzn5jPKD89sKNyn1/xB
         z6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQsuL10ttGgvUSSdwEEABCcNLhZF92QzGWTDfsTdZC0=;
        b=TOyJ8oLXUft3LI2pPDcsXk2xRD0ZX8R1z6PFdaw1R4FFa5LulGlsyuq4nl/pxVQyNU
         pswb+L/z8r30fmGLKsAOVFmQfYEbv3HAwjyvwks+a8f2tlF4EVfrSnhU442kmBojR2mK
         mA2oMBavcQA5/PiKR4eB4Le6bJDI6dM0F4MS62vULzfT1bguom4vxyKb0T+T5WlE0AkJ
         2oz1rXknbBB+G6HbkAUMW1Kq+SDdhbemn+J5OiIgJnCOimRVuQgarCwWIZ1J9vnhdGQt
         6NJmBzzEBdsTDmv64Y5r72E3jl54MLp97qcl9CiMpFRr+Z7iZqST+2zmtVsWCsWX2fZ0
         ArMw==
X-Gm-Message-State: AOAM533iErKBWaShqeW1RF3QE1gKys6I2/sN9pfjXrtyK+zMn9DR8LLV
        01MJ6Nwm1zdHToSaEv/Xaau/0NrQZAlKhML4SPN7mQ==
X-Google-Smtp-Source: ABdhPJzTAghL8Sdb1Gw9MPXcbmOW24XGnOJcMCgtYTxm5f97ovoej8TmEINBWT+FiI25beskbGWOdasTt0AKNmWY6l8=
X-Received: by 2002:a05:651c:22b:: with SMTP id z11mr19730326ljn.182.1620655306896;
 Mon, 10 May 2021 07:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210319121357.255176-1-huobean@gmail.com> <20210319121357.255176-3-huobean@gmail.com>
 <CAPDyKFrU591aeH5GyuuQW8tPeNc9wav=t8wqF1EdTBbCc9xheg@mail.gmail.com>
 <79ec60974875d4ac17589ea4575e36ec1204f881.camel@gmail.com> <9b7ecf8a74e7e04174181aed0c5f0e356d0ed280.camel@gmail.com>
In-Reply-To: <9b7ecf8a74e7e04174181aed0c5f0e356d0ed280.camel@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 May 2021 16:01:10 +0200
Message-ID: <CAPDyKFqd03GZVtxmoiY3NFS_EggLQLMGk62AneZLoOn_20BDJQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: cavium: Remove redundant if-statement checkup
To:     Bean Huo <huobean@gmail.com>
Cc:     rric@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Apr 2021 at 22:30, Bean Huo <huobean@gmail.com> wrote:
>
> On Fri, 2021-03-19 at 16:42 +0100, Bean Huo wrote:
> > On Fri, 2021-03-19 at 15:09 +0100, Ulf Hansson wrote:
> >
> > > On Fri, 19 Mar 2021 at 13:14, Bean Huo <huobean@gmail.com> wrote:
> > > > From: Bean Huo <beanhuo@micron.com>
> > > > Currently, we have two ways to issue multiple-block read/write
> > > > the
> > > > command to the eMMC. One is by normal IO request path fs->block-
> > > > > mmc.
> > > > Another one is that we can issue multiple-block read/write
> > > > through
> > > > MMC ioctl interface. For the first path, mrq->stop, and mrq-
> > > > >stop-
> > > > > opcode
> > > > will be initialized in mmc_blk_data_prep(). However, for the
> > > > second
> > > > IO
> > > > path, mrq->stop is not initialized since it is a pre-defined
> > > > multiple
> > > > blocks read/write.
> > > As a matter of fact this way is also supported for the regular
> > > block
> > > I/O path. To make the mmc block driver to use it, mmc host drivers
> > > need to announce that it's supported by setting MMC_CAP_CMD23.
> > > It looks like that is what your patch should be targeted towards,
> > > can
> > > you have a look at this instead?
> >
> >
> > Hi Ulf,
> >
> > Thanks for your comments. I will look at that as your suggestion.
> >
> > The patch [1/2] is accepted, so I will just update this patch to
> >
> > the next version.
> >
> >
> >
> > Kind regards,
> >
> > Bean
>
>
> Hi Uffe,
> Could you please firstly accept this patch? let the customer update
> their kernel. As I tried to develop the next version of the patch
> according to your suggestion, more changes will be involved. Also, no
> matter how to make the change general, below mrq->stop checkup should
> be deleted since it is obsolete. In the data transmission completion
> interrupt, mrq->stop will be checked again.
>
> -       if (!mrq->data || !mrq->data->sg || !mrq->data->sg_len ||
> -           !mrq->stop || mrq->stop->opcode != MMC_STOP_TRANSMISSION) {
> +       if (!mrq->data || !mrq->data->sg || !mrq->data->sg_len) {
>

Well, I don't think the above checks are incorrect. Instead I think it
points out that the cavium mmc driver lacks support for CMD23, while
only open ended data transfers are supported.

The proper way forward is instead to implement CMD23 support to the
cavium mmc driver. In the same patch adding that support, you should
be able to remove the above checks.

Kind regards
Uffe
