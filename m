Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31130C11F65
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 10:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D36161CF6
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 10:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhF3KUO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 06:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhF3KUJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2021 06:20:09 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1ACC061768
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 03:17:36 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id x141so1377609vsx.2
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XQq8LhZlNnALz3pFI8gIgvstZwDYOAnl3T8aM2MQRE=;
        b=KRgV2hM6boFZ/d5kVntdo7xbG+zQLyxb+SKB/xdJ/H0JtBAFFrB1OK0lm+L4SijANG
         io7nIdxsM1fC/K9P0D9WOQ41EFFUojUA3T+y9m6U6l47MAVFzj1duSjvYO9C/vgZuOTd
         YEdJlkcfspG4aRGSsJ9ZBLJL7l0rTrVMJ1NPPu9Na7Ui0ye87v4As2KUcZJEIdRU/6V0
         +B21B9CJS4k3I+zB979moUtcjh8nQShtnOeApr08SAngz5k9AcSmmzBWbTXrRV6v9bop
         PCmZzgugAXvDcQiQ+RfJiOTO+6GYJC+Q6cs/c4liiGm52JaJAmj1qzcK6/IGy8bjfD6X
         9tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XQq8LhZlNnALz3pFI8gIgvstZwDYOAnl3T8aM2MQRE=;
        b=ZxumXozUcI6efcZB/wLrRbMHF18aXxfAt23ySFddo6eHD6vJwxGkUvp4TnRa2OpNgR
         uH7rCbqq6WMQMrazZrlaq5JZVnhSRCt5ZH8aoGeVChH0prDVYPQZSxXq67Ega4zCPGps
         HJnZxkAEmk9V7V7rTxEY86V32i0MaiAhb3dJjKbYRiitVZrJrtanW2h8ddfBt1mWbyhj
         RNacUEPGooPxAQBjk1/b1kkRSDdCvceVU0iLLQMmzOF83CAWZWCdS5Z6QZkQhB1FWPBo
         IakkiX7y42fLEHDFIFF+TJT69tdwRmroElyxopqXXv/qJUUH6fBGqK5JWSPe4cPSgTEn
         LLig==
X-Gm-Message-State: AOAM5323wOys4GcLtdmmmoYVYGpjIhEj+EZeP88+tBNUAa7gzEHVB3Az
        rvOZgDx/tjp2v1dl1gk/w7k0eprqHyEFaB1LWxoXLw==
X-Google-Smtp-Source: ABdhPJxhuEU0Oad9j/Ms149ah74go00YH1YXcXHKW2msldlNBvLDKm3iYjVsi0OHw5VL0DhegL7U8ZzvhsOjTRNf1uc=
X-Received: by 2002:a67:6a85:: with SMTP id f127mr28499045vsc.34.1625048253862;
 Wed, 30 Jun 2021 03:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210619225118.1862634-1-linus.walleij@linaro.org>
 <20210619225118.1862634-2-linus.walleij@linaro.org> <CAPDyKFppUJWcmHHzP4V1WQPRmMYe50M721kwtaLkkp6M9rz2Gg@mail.gmail.com>
 <CACRpkdahDF=fO8DZCCV+QhOjsG=NPB9WDEjsUrjOCUofgYriog@mail.gmail.com>
In-Reply-To: <CACRpkdahDF=fO8DZCCV+QhOjsG=NPB9WDEjsUrjOCUofgYriog@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Jun 2021 12:16:57 +0200
Message-ID: <CAPDyKFoJorhoa0fn+8Jgj_Rm3v_bPCFMxP3-GqpML+bVMv3xyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: mmci: Implement .hw_reset() callback
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Jun 2021 at 02:32, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Jun 29, 2021 at 1:47 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > > +static void mmci_hw_reset(struct mmc_host *mmc)
> > > +{
> > > +       struct mmci_host *host = mmc_priv(mmc);
> > > +
> > > +       reset_control_assert(host->rst);
> > > +       udelay(2);
> > > +       reset_control_deassert(host->rst);
> > > +}
> >
> > Unfortunately, this is not the purpose of the ->hw_reset() ops.
> > Instead, it's supposed to be used to make a HW reset of the card, not
> > the controller.
>
> OK I see, let's skip this patch.
>
> I think patch 1 & 3 should be fine though?

Yes. I have a minor comment on patch 1 though.

Kind regards
Uffe
