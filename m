Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC91C433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813346128C
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhEKK6I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 06:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhEKK6G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 06:58:06 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26EDC061574
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:56:59 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 66so9958084vsk.9
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzuUJNlN6zFe3lbQy9UWCFGOnXngAGzdHt+g+eYNfEo=;
        b=u28Bov95aO/sH7n+9EQNFrCombDhkYlL+ScFmgE0qxMG2vr06lxfeu5tGwxlE3Emvr
         M2oYauZPM9JWNQD7fFnQFEXId+eKQyyJ66jVLlRTiBzBmjC+kG2SjqvbdKCRSe3sk0dU
         RxQQOQ61m+MEpPs4GnsS/HQYIFcFM+Syj/jjBYS73gwpOh6/RtbWoYsZjg+jn9rPm02f
         QcTbCqwE9UaLsnOdrHlGIMIB/2SY5ZoI/9aQ0BK/Fs2e2V9zcnTxsCJuhBZ8MQWeKl6W
         5YxZtah2Wx6xPGr4YGu+UcMat/VylROKEdU5DpWSdzA0V6gbNZsuQUfW20yojjmGQWVr
         RGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzuUJNlN6zFe3lbQy9UWCFGOnXngAGzdHt+g+eYNfEo=;
        b=l2K/GDpT0qimrqCB5t+BX5GH+GZc4kzKxOGVP3AD1hQdqvmXj5lcGRs1iAebwpbtU2
         hIpfPQBoyNh0rgyFPkrYKOOeskIKvRgkh8gP19H57i1neAZ31tBPGjY1OivMsXoATDu7
         vG/5VwgjkQBWlc6RfzVvwd+4r+LJFZYi1ae4YIyl1tXADTNKaedmpHs8PLED+wEmt5f8
         znwYPZAAv3OZyc9LAYTPFsjGH+IrtQTMFOLR/LYwKyOO4g/3poWE52BI53GSsKVYvKMQ
         M0fGcDv2iJrqr3O13eHeGYuhuNUEAjNTr9gcuXlnIFI6/zKAJKKVJ4+iacfW9SFt6lLm
         kX7A==
X-Gm-Message-State: AOAM53338z7n1siTR5+VzNxP7xO90DVpsMecFSQ/C1MoT2+jqj2A+8mg
        tJo95VrpN03vW+Fh2ue2dH9e+x758XPNPewZ/qhqUg==
X-Google-Smtp-Source: ABdhPJyFhD+Lh02XrPAb5mni64p9iAqg+QAwP4zu51SiNIsBwidKqvduXdsGY8kBo3hXgbz95FIw4Bdp2aA88IjPfD4=
X-Received: by 2002:a67:2c03:: with SMTP id s3mr24304488vss.42.1620730618960;
 Tue, 11 May 2021 03:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210424081652.GA16047@nyquist.nev> <20210426073251.7726-1-benchuanggli@gmail.com>
In-Reply-To: <20210426073251.7726-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:20 +0200
Message-ID: <CAPDyKFoCrFMyDEo8czEjAUPZMiUDcV3hKcYSAfdmujZPe7R58g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: increase 1.8V regulator wait
To:     Ben Chuang <benchuanggli@gmail.com>, dlbeer@gmail.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 26 Apr 2021 at 09:30, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> Hi Daniel,
>
> > Inserting an SD-card on an Intel NUC10i3FNK4 (which contains a GL9755)
> > results in the message:
> >
> >     mmc0: 1.8V regulator output did not become stable
> >
> > Following this message, some cards work (sometimes), but most cards fail
> > with EILSEQ. This behaviour is observed on Debian 10 running kernel
> > 4.19.188, but also with 5.8.18 and 5.11.15.
>
> Glad to receive your report. Thanks.
>
> >
> > The driver currently waits 5ms after switching on the 1.8V regulator for
> > it to become stable. Increasing this to 10ms gets rid of the warning
> > about stability, but most cards still fail. Increasing it to 20ms gets
> > some cards working (a 32GB Samsung micro SD works, a 128GB ADATA
> > doesn't). At 50ms, the ADATA works most of the time, and at 100ms both
> > cards work reliably.
>
> If it is convenient, can you provide the appearance pictures and product
> links of these two cards? We want to buy them.
>
> >
> > Signed-off-by: Daniel Beer <dlbeer@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > index 592d79082f58..061618aa247f 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -627,8 +627,13 @@ static void sdhci_gli_voltage_switch(struct sdhci_host *host)
> >        *
> >        * Wait 5ms after set 1.8V signal enable in Host Control 2 register
> >        * to ensure 1.8V signal enable bit is set by GL9750/GL9755.
> > +      *
> > +      * ...however, the controller in the NUC10i3FNK4 (a 9755) requires
> > +      * slightly longer than 5ms before the control register reports that
> > +      * 1.8V is ready, and far longer still before the card will actually
> > +      * work reliably.
> >        */
> > -     usleep_range(5000, 5500);
> > +     usleep_range(100000, 110000);
>
> Looks good for me.

I consider this as an ack and will add you tag to the commit. Please
tell me if I should change.

[...]

Applied for fixes and by adding the below tags, thanks!

Acked-by: Ben Chuang <benchuanggli@gmail.com>
Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
Cc: stable@vger.kernel.org

Kind regards
Uffe
