Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476EAC11F69
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248366141A
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 15:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhGAPze (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jul 2021 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGAPze (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jul 2021 11:55:34 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90C4C061762
        for <linux-mmc@vger.kernel.org>; Thu,  1 Jul 2021 08:53:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w11so9220234ljh.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Jul 2021 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHc2ICTREwq8ELgOSIh87j3E/E7rBMUWqfc5vu1EG64=;
        b=t6k1rDpYHH9aC2qKj/DSzssytWqMmFWuqMS7VoTnm6hMwy728bOTsaJoOIpFQRWBo/
         JBSy+G6OADx6Tpr2+2mWtVVZNTJ/WsSKHgCn2oCaptAqKv8mDKTOUCKr2NvAi448A0Jz
         m7GiJg23ZZsccVx0wGIQ0rBf0n5/3S4rg1hlF9zIYv5A6DxUOuWhLze8cbUTB9xL1Zc2
         baawV4e72JoLF48ywFcnzLuceMRRKe/+YJVu+145jEh6toO6nsH2r+v3V23vX0s4054k
         y1H+kL1NwFvDDLh5Oj11fwWWFkRoASLnnogEB4cjHL0gke7kPF0LqN6mURuzS6MjNPtr
         CjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHc2ICTREwq8ELgOSIh87j3E/E7rBMUWqfc5vu1EG64=;
        b=oqwIv5Jy60XYslkaBdJ3ogdt2JQtULSficakgLM7zJan35hLfCPmfU5rL+doVKKT3B
         kwd5st4vtdo1D4/BaXbbgUEjOSH0qge5uZYs7VAvUDHgDS+nDtg4Zddj32QJdoccL0+r
         kmsAJFhRl1LdERSZ83YLWE4qH+A6I2CkAshKIada0C4i/iYtKqUsvyuJ/Pil88yu9/KK
         rbKsIxZk9DHV/Qw6cDVeKt0ph14h1tTgo4kozEbRJzhIV0amBvUf+aw8/pgmqqRwMgAP
         tTiIfy8upFofz5uIovo/Qc0dftDUI3SH2gy+/WaFcah1v3APG+LjccB6y2iEoR45sfcB
         jS7w==
X-Gm-Message-State: AOAM532Ew8LtCDxGwxX5PSHc8w39OurjmzBCXTaQEOwdTVUmAXpiBe1/
        m8bvTMAvA52InQbSogbq/vzg4pUi3GgAs4jYuMs6PQ==
X-Google-Smtp-Source: ABdhPJyI5Rrkz6yMXvWDNguDPZvnkUgTfKDTkqJq78HcCLmu9D/n2Z8ffm/3kXqy32+xzad4vstO3XBB66AObV2jiVg=
X-Received: by 2002:a2e:8748:: with SMTP id q8mr176487ljj.438.1625154781956;
 Thu, 01 Jul 2021 08:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210628232955.3327484-1-linus.walleij@linaro.org>
 <CAPDyKFpfJC=KAZ5dGAso2zcgBic4uCkOiDFQ0ZA5Zi7UDUeEug@mail.gmail.com>
 <CACRpkdY4kegTzeqPHNEd3=hOdqSXAvJq+LehLbf09mUybU0VfA@mail.gmail.com>
 <CAPDyKFoj47-4XuKbV6jYkJ2pesAfHK999vudWDGTQA-J5eQXrg@mail.gmail.com>
 <CACRpkdYX5RiUy7u_SeCqhytbyL1Ta9iVmx500uwAq8sNmW+3Ug@mail.gmail.com>
 <CAPDyKForEi09uyXL4nDn27bth+btEYAhzd6+YusMrRBygCdtEA@mail.gmail.com>
 <CACRpkda7m6HnA7y9coYoXd9YFNjSzAfuYiLNURHe1geb8rF++Q@mail.gmail.com> <CAPDyKFrK85hCTQwSy114JUqx+As_y6Z567a-Gvqdji7iN1=A-A@mail.gmail.com>
In-Reply-To: <CAPDyKFrK85hCTQwSy114JUqx+As_y6Z567a-Gvqdji7iN1=A-A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Jul 2021 17:52:50 +0200
Message-ID: <CACRpkdYB+GG0uUyYhPjcjXT=9fgjQBJDt4XMoh5gM-VZ3bEnqg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add a card quirk for broken boot partitions
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ludovic Barre <ludovic.Barre@st.com>,
        Jean-Nicolas Graux <jean-nicolas.graux@st.com>,
        phone-devel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        newbyte@disroot.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jul 1, 2021 at 4:27 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Thu, 1 Jul 2021 at 00:33, Linus Walleij <linus.walleij@linaro.org> wrote:

> > > It looks like there are some race conditions in the HW busy detection
> > > path for mmci, which gets triggered by this eMMC card.
> > (...)
> > > Although, it's more optimal to receive an IRQ when busy on DAT0 is
> > > de-asserted, rather than polling with ->card_busy(). Hence we also
> > > have MMC_CAP_WAIT_WHILE_BUSY.
> >
> > Hmmmmm it kind of assumes that DAT0 will be de-asserted *before*
> > we get a command response, never after. I think that is what the card
> > is doing. If that is out-of-spec then we need to have a quirk like
> > this but if it is legal behaviour, we rather need to fix the mmci driver.
>
> That's correct and this could very well be the reason why polling
> works better for this case.
>
> On the other hand, I am still a bit puzzled why the mmci driver hangs,
> waiting for the busy completion IRQ to be raised.
>
> I did some more inspection of the code in ux500_busy_complete() and
> found that there may be a potential race condition. I tried to fix it
> up, but I don't know if it really makes any difference. Can you please
> test the below patch and see if it helps.

I tested it and sadly it does not help :(

The system hangs on CMD6 after CMD18 as before.
It looks like this with my debug prints:

[   53.940399] mmc_host mmc2: start CMD13 arg 00010000
[   53.940490] mmc_host mmc2: start CMD18 arg 0000d010
[   53.940765] mmc_host mmc2: start CMD18 arg 0000d028
[   53.941162] mmc_host mmc2: start CMD18 arg 0000d048
[   53.941864] mmc_host mmc2: start CMD18 arg 0000d088
[   53.943878] mmc_host mmc2: start CMD18 arg 0000d108
[   53.946563] mmc_host mmc2: start CMD18 arg 00004810
[   53.947174] mmc_host mmc2: start CMD18 arg 00015018
[   53.947357] mmc_host mmc2: start CMD18 arg 0005e078
[   53.947845] mmc2: modify EXT_CSD, index 179, value: 1, set 1, timing 0
[   53.947875] mmc_host mmc2: start CMD6 arg 03b30101
[   53.947937] mmc2 modify EXT_CSD completed (0)
[   53.947967] mmc_host mmc2: start CMD13 arg 00010000
[   53.948059] mmc_host mmc2: start CMD18 arg 00001c70
[   53.948364] mmc2: modify EXT_CSD, index 179, value: 0, set 1, timing 0
[   53.948394] mmc_host mmc2: start CMD6 arg 03b30001
[   53.948455] mmc2 modify EXT_CSD completed (0)
[   53.948486] mmc_host mmc2: start CMD13 arg 00010000
[   53.948516] mmc_host mmc2: start CMD18 arg 00004ff8
[   53.949005] mmc_host mmc2: start CMD18 arg 0005e010
[   53.949340] mmc_host mmc2: start CMD18 arg 0005e028
[   53.949707] mmc_host mmc2: start CMD18 arg 0005e048
[   53.950378] mmc_host mmc2: start CMD18 arg 0005e088
[   53.951812] mmc_host mmc2: start CMD18 arg 0005e108
[   53.954589] mmc_host mmc2: start CMD18 arg 00015038
[   53.955047] mmc2: modify EXT_CSD, index 179, value: 1, set 1, timing 0
[   53.955078] mmc_host mmc2: start CMD6 arg 03b30101
[   53.955169] mmc2 modify EXT_CSD completed (0)
[   53.955169] mmc_host mmc2: start CMD13 arg 00010000
[   53.955627] mmc_host mmc2: start CMD18 arg 00001c30
[   53.956115] mmc2: modify EXT_CSD, index 179, value: 0, set 1, timing 0
[   53.956146] mmc_host mmc2: start CMD6 arg 03b30001

Here it hangs forever, this last CMD6 never completes.

Yours,
Linus Walleij
