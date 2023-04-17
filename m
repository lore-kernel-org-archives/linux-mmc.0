Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ED2C77B7A
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjDQPpO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 11:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjDQPpN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 11:45:13 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0447CD
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 08:45:12 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id l5so5543588ybe.7
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681746312; x=1684338312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uANFHxB7VX4MKOqAT03m5zUc2hsluyqpfayDw7cl3qo=;
        b=PZF34qnfyoYRJcFP1ogjCGlY/ygSGtZD9bteKHJ8KnexMd9CA9BlfGDrXXU225+Xd3
         F+RLg+bFv5zNZ2mcKtB4HrNeKZzT3GYAVsHP7yi12puMtybiUufzFVovZDDSpUgr/Rhs
         FcsNOdqTdZmqIiiJvZnmANp3uQPcqHnqgSea1qe2tidkcDd1Cozx+tprAUwl0p8VsLA4
         WlXjeMLyV9NWblb5+o0pFHlb4GDF4kw8+HOD3RdoC2sJn9gcf0+OtCxGYND0m+ksXM3X
         Ia1wK9DN2Z3qTTDzn3jQFClR/2F3ybiqCx0DyxaVjlXsi894JBxeoWzRFrGpMbH98j4k
         192g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746312; x=1684338312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uANFHxB7VX4MKOqAT03m5zUc2hsluyqpfayDw7cl3qo=;
        b=ch/4/cXCBqKo8OKAGrwnQdNrY1IKjy5x8EfzX8JnuQghJjlAdgvyBJXwxWQ7P8YdJr
         eRCLWGVrJcpUTAfOTZYjYhai17dUfyI142BLYG/Do0Nhs1jZ8TeZOZZ1B7Yc9gdU/dsc
         i6rkR4bH5+Ym0tVzYApSlDOaw8/xAUAf0600aTIqk60jq3L+QZ34GJBQ6Bn/UgII6/e3
         O56/YIDa35K4KDAIrkWtIYf+dCzjLi95NfkGXn1SaxF4I900MtE4bnimXKvD1ZCTqmxD
         cfZl8B5JNQ03wCFsbFYo0rif95Q2rRKi8j1A6frcnPP9AYmJtvFXcDVledL7txno78E5
         49LA==
X-Gm-Message-State: AAQBX9eSZwWKoaUc2w5Z6bnRVsBSQmxCCxy+mgm8ae94xnEFE7fwi/ap
        OjRDysHFADBjrFq2QtKqMPrp9ndaGarid8SV7o7YHQ==
X-Google-Smtp-Source: AKy350aP3QOBtKNOKLMPeIj6ZU5lTp6Gy8tKj3WVIbX8o1x6LPTFlznGCtNCfBQvT4N4le9tSNlg9CG3O6I67WJchGY=
X-Received: by 2002:a25:76c4:0:b0:b75:8ac3:d5d2 with SMTP id
 r187-20020a2576c4000000b00b758ac3d5d2mr9968546ybc.4.1681746311834; Mon, 17
 Apr 2023 08:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
 <20230405-pl180-busydetect-fix-v2-4-eeb10323b546@linaro.org> <CAPDyKFpoboq68_ysEJXCWLV8k77+ULGpF6AzcnjvUqO96r5FHw@mail.gmail.com>
In-Reply-To: <CAPDyKFpoboq68_ysEJXCWLV8k77+ULGpF6AzcnjvUqO96r5FHw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Apr 2023 17:45:00 +0200
Message-ID: <CACRpkdbwD2hO7f5VWZubYoDXFHA0Zx3k9cYYG841361zFqEFYQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] mmc: mmci: Break out error check in busy detect
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 17, 2023 at 3:24=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> On Sun, 9 Apr 2023 at 00:00, Linus Walleij <linus.walleij@linaro.org> wro=
te:
> >
> > The busy detect callback for Ux500 checks for an error
> > in the status in the first if() clause. The only practical
> > reason is that if an error occurs, the if()-clause is not
> > executed, and the code falls through to the last
> > if()-clause if (host->busy_status) which will clear and
> > disable the irq. Make this explicit instead: it is easier
> > to read.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v1->v2:
> > - No changes
> > ---
> >  drivers/mmc/host/mmci.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index e742dedaca1a..7d42625f2356 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -665,6 +665,15 @@ static bool ux500_busy_complete(struct mmci_host *=
host, u32 status, u32 err_msk)
> >  {
> >         void __iomem *base =3D host->base;
> >
> > +       if (status & err_msk) {
> > +               /* Stop any ongoing busy detection if an error occurs *=
/
> > +               writel(host->variant->busy_detect_mask, base + MMCICLEA=
R);
> > +               writel(readl(base + MMCIMASK0) &
> > +                      ~host->variant->busy_detect_mask, base + MMCIMAS=
K0);
> > +               host->busy_status =3D 0;
> > +               return true;
>
> I agree that this makes the code more explicit, but unfortunately it
> also means duplicating the code from the bottom of this function.
>
> Can you instead add a helper function and call it from here and from
> the part at the bottom?

I break that out as a separate function in patch 9, can you check if
that solves the problem? The end result after all the patches should
be fine.

Yours,
Linus Walleij
