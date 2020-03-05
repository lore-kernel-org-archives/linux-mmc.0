Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF81C3F2D1
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 10:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EE12166E
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 10:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yl2/8epD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCEKwn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:52:43 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36278 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgCEKwn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2020 05:52:43 -0500
Received: by mail-vs1-f68.google.com with SMTP id n6so3254490vsc.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2020 02:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pi5BVwXANUu/utwdzlBNy+WEqRoY0xx0L7WnC6xkeCQ=;
        b=yl2/8epDcqpe06/Nvq5/cSiwZX9dMqTyoDAr0i1fEJOsPLh1QQvDu9Vm7LxeO337lq
         tvQY1BBAh7l+hwTqBOZ+2DgOWl305kI0twXxoyEXsNxORdxWdW6WD49uGFHx/NtaqNDb
         p72raI1yNx2uKFOEfhqWtXiT+vgR0KymVp2AKQ5Qt1zpdVbnfyyUzoWtohD971NSfl7S
         lM3gAqY9TxjHbFA+8aRolgMRpFJbpN4/4WoiFyxvifvjzsXviVB8DYW7kotA3M7rjPh3
         HYpZS07fu8Rl1rZyzCT5A/FA5QnfaFc/BjBVK9MvYqEBa4aZf1SOfSpxPFYxLPCBfZeX
         EouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pi5BVwXANUu/utwdzlBNy+WEqRoY0xx0L7WnC6xkeCQ=;
        b=LxqYEZYSRzTPDlXQ85066XGbgwAC4VoF5fis/+aR4atVdwPItY0BWTFii/7kaizQfV
         pDC6YHwHReJRiIARbAcAmZLvQfmiuUQKRTm+QKgpOLVIHzaRs06gQj9+sJ4y0d83LBRW
         V4qvQfng3FHoQP4KXIEPyN7FP3inZzuUU/y6XIY+JWmq5ThXLp9jaRK+OU2lm5YXh9F0
         e1ynqx8swBbIZlzleLZ3vamNQ+HrVuz69iORCuXh9UowAJuBcvMloubG0CnSzPWbl4yg
         NWQCHedNk2LA6P0GH7r6PUyJJ6b95y90xAp1O8ZnqsTVxFWXg2A08DlyIfB/UK9K/bpB
         xHcA==
X-Gm-Message-State: ANhLgQ1Fyxt73YeT9RUcQsgncvbdFQ9neNokl0NI6tGXMa8O3bMS1sVI
        uAK3xzXEUJCKw+ZBpDPOXRZXrGhyMPVHQVAZBevzMVKk
X-Google-Smtp-Source: ADFU+vunWTYijJe97zX4E8cuSYATIRhGHA+itsQ2qAMkuJ3+Pk7yH5mFym3/9lGuFyy9IIDetoT9dDHGIiSdg5V8v9I=
X-Received: by 2002:a05:6102:4af:: with SMTP id r15mr4431149vsa.35.1583405560439;
 Thu, 05 Mar 2020 02:52:40 -0800 (PST)
MIME-Version: 1.0
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
 <1582100757-20683-9-git-send-email-haibo.chen@nxp.com> <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com>
 <20200304162844.GA11727@lst.de>
In-Reply-To: <20200304162844.GA11727@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Mar 2020 11:52:04 +0100
Message-ID: <CAPDyKFrkwbr1n_Se+gEA3uSH+aEPawN0qLQBjppjg4y_K4-w=w@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] mmc: queue: create dev->dma_parms before call dma_set_max_seg_size()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Haibo Chen <haibo.chen@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 4 Mar 2020 at 17:28, Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Mar 04, 2020 at 02:32:42PM +0100, Ulf Hansson wrote:
> > + Christoph, Arnd
> >
> > On Wed, 19 Feb 2020 at 09:31, <haibo.chen@nxp.com> wrote:
> > >
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > To make dma_set_max_seg_size() work, need to create dev->dma_parms.
> > >
> > > Find this issue on i.MX8QM mek board, this platform config the
> > > max_segment_size to 65535, but this dma_set_max_seg_size do not
> > > actuall work, find sometimes the segment size is 65536, exceed
> > > the hardware max segment limitation, trigger ADMA error.
> >
> > Sounds like we want something along the lines of this to be tagged for
> > stable as well.
>
> It really is not the job of the upper level driver to allocate the
> dma params.  This should be done by the bus driver.

I agree that allocating the dma_parms doesn't belong in the mmc block
queue layer.

However, it seems silly that each an every mmc host driver needs to do
this themselves. So, perhaps we could manage this from
mmc_alloc_host(), which is a common interface that mmc host drivers
calls during initialization.

Would that make sense - or is there some reasons to why a host driver
really don't want to do the allocation you think?

Kind regards
Uffe
