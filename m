Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EE2C4361B
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 10:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C2123104
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 10:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgLPKpo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Dec 2020 05:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgLPKpo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2020 05:45:44 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0D8C06179C
        for <linux-mmc@vger.kernel.org>; Wed, 16 Dec 2020 02:45:03 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id j140so12669638vsd.4
        for <linux-mmc@vger.kernel.org>; Wed, 16 Dec 2020 02:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4w2SA5vPpjO5u4tlq8Tsp94JRz6/I+Ka0PxbTOuLso=;
        b=cfvgrCVgPuNBVhsKCsTpEL1k/uCT97mg050CjQLRuVWf7JMltHg8VjQvXSREDLcyZx
         Ke64bF84W5J7QAGc3WEvd/DBYcNZwvKxxNTt/h5YtwI91om5FI2tsT2bs98TtM+dOe/d
         lCQMnizyBbthfwLP13QycbJj431UFsb9AN5bfM8rLl3mrgvjKTQfR4yy17v54Rh8rln+
         ZXJ9eYqzusM2PTkhnJ/jEZCNkRQQA+wVZ2qyjA22eBzAOX4Unrwjp8oR/e+R+3B885su
         3Q7fhe/SdyIUIGRDDrxv5Yfm+eOiiYDqzqADICX0dh/IIjoo8zBBvgK2hv5jfvLhaAnv
         gQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4w2SA5vPpjO5u4tlq8Tsp94JRz6/I+Ka0PxbTOuLso=;
        b=uVB1Ce3wZ0EMjjYumyV+SqEitIwoIVHjYizfMKfQRHgD7xc49+mIxOdTHW+DLXY/Ty
         PcGNSBEiQRao1iioQ+Pb+QdWtd0z0l/XOMOORCfC0cNVyZLnCe9yGcNbleE2qUrmyBWA
         axBE3iR2IWI4EMxanuruUhHY5w2GR4Z2gdan9rXt+LTR/Qk/Oc2l7ZOzlNKMbjDg4lNQ
         7za9PbvwMXoX6rKbFIBSeC4XQWibZQGDnQi6lbXBv5x1tKms9WjS7Ehz4i8d6mbl2g4h
         QGz0AYGBcVItUE5bamzs6FZSjxhVyiDS+bVSKHU4LbOa8CXVwq//NDq8QpKYVOUXsO/r
         RawQ==
X-Gm-Message-State: AOAM533apCsybvmbhHZDYI+aqqNt/a4+na/BiZTCAbDv3eGWwRTUW7bT
        68E3DEfRIJI0l5FEGLok07YN+JKRJho32PAy655R1Q==
X-Google-Smtp-Source: ABdhPJy3B48WTkBRNGWmS9WFf7NJdY1I0lQO7A89L/9gNufMHNDNc4jsr+zcHAfIGie4X/bZ2j/u5bD165YzLHymoCI=
X-Received: by 2002:a05:6102:2127:: with SMTP id f7mr32024818vsg.48.1608115502915;
 Wed, 16 Dec 2020 02:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20201207115753.21728-1-bbudiredla@marvell.com>
 <20201207115753.21728-2-bbudiredla@marvell.com> <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
 <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com> <202012151232.843EB2CB49@keescook>
In-Reply-To: <202012151232.843EB2CB49@keescook>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Dec 2020 11:44:26 +0100
Message-ID: <CAPDyKFp=T2uqWsSTij_K=yXSffpPOKcWTqNrVxfatkncCZzaMQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on pstore/blk
To:     Kees Cook <keescook@chromium.org>
Cc:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Dec 2020 at 21:37, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Dec 15, 2020 at 12:42:58PM +0100, Ulf Hansson wrote:
> > In principle, for non atomic path, I would rather see that the pstore
> > file system should be able to be mounted on top of any generic block
> > device partition - without requiring the block device driver to
> > implement specific pstore ops.
> > [...]
> > Exactly. That's why I wonder if it's really worth it to support the
> > panic writes at all.
>
> pstore/blk already provides the generic hooking -- but it can't do
> the panic write part (which that's very device/driver-specific). The
> design was for individual backing devices to provide that directly
> (which would needed read/write support too). And for those that don't
> have panic/read/write support, they could still use the generic hooks
> but they wouldn't be able to reliably (or at all?) catch panics (just
> console writes, ftrace, pmsg, etc).

I understand the motivation behind pstore's hook for panic-writes.
It's a special thing and perhaps it's easier to support this via a
specific hook, rather than adopting the regular block device request
path to cope with some special I/O request. On the other hand, in the
discussion I have had with Bhaskara, I have pointed out several severe
implications for mmc to support these panic writes (and believe me,
there are even more than those I have brought up). So I am starting to
think that, perhaps there is a better option.

In any case, I didn't catch *why* pstore needs to force block device
drivers to implement specific pstore hooks to support the pstore file
system. I don't think this is the way it should work, for many
reasons. The pstore file system should be able to be extended, to
support the regular block device request path, no?

Kind regards
Uffe
