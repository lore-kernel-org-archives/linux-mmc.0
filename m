Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD99EDE9A4
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 11:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbjINLwI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 07:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbjINLwH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 07:52:07 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F537CC3
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 04:52:03 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59bc956b029so9742667b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694692323; x=1695297123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOUEoWCoocBtSGgV6FK5TFmlWuuWLandTZ80F2DQ2rk=;
        b=q++ZGo1B47W/LTNaEjZTX2l+ByO3OEB8Nbz+LgAh9yVwtMVRj4g1cnVKa5yLj4O4WK
         2AIBpQxT1g88bfEAYY/WdBSl88K6uTd7RCFfa99vtllffVXyNCE3SMOAcczkMkPeZADT
         uIcSGwINQJOHsAWiLva3bDo/R5i6X1eNnlDG4B8d3ak73p/INWpKOTMBJ9qg9O+TCTel
         1npKkSgFABY5+3B1frpuEMqxfv6wKU0nTggcZMtq4Y/3JTNUET9+cZ5dFWllQlDQjbUR
         mkD5VyOEDawj7HzcY8ZWpXFnfsRi3JcmLRBjUyKid4f1FCLT4NXUwlARATaFN6LeE2N7
         3CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694692323; x=1695297123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOUEoWCoocBtSGgV6FK5TFmlWuuWLandTZ80F2DQ2rk=;
        b=IZmvnFF4Mqlf6EgJnKj/8D2GFjaV8J4Nn8lzsV/FrRISgws1klQ4rGY4GMdnxMMiY0
         FtjQlQlp6p4JDCATy95z8VuFWmS1tvL0VuUNceKzYgKnZ2fxZxK8NMnp+W2TSlUGv/xP
         iOXxkHa4dfby5qX2Xpby+Hf1nOnkiVZf0lo1loiQN/o9zkBg/H7C93TWxzjyS9wzBFG7
         A3oq7FE895Hjv8jWejogNt7xOylxg4jhZRtu/zN4GTCbGUznmW844DPKf6aV3FvNylbT
         r9VJp9vDTEVgrYrO0QfgvRZKqrjJSk0S8cgoibtKW0ZgCsqk8t9Z0PB4DmlcFHRD5RjR
         nCXQ==
X-Gm-Message-State: AOJu0Yzfy5NAqjHHK3xXiFUKXsXjRTx5CXxTIibySvurmgW0v9EnXuvh
        4rUz2LscUq6wdU32YcWFC5Omsdpd/st8o6V1fjMQ0FsaHemlBHww
X-Google-Smtp-Source: AGHT+IHD8VvcoE47pb1lIcfSKbtIiW7ws0imUaLM67I3lgZ6IbvqTW/m+pTULfW+iNfibDtFe9PuifpTuzvff1x23T0=
X-Received: by 2002:a25:109:0:b0:d00:cc5b:8a9f with SMTP id
 9-20020a250109000000b00d00cc5b8a9fmr4681660ybb.16.1694692322860; Thu, 14 Sep
 2023 04:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230901120836.1057900-1-yann.gautier@foss.st.com>
 <CACRpkdacRe5cPoSFJyEdo6nZrtmUHTNqMxf55CntvsdpFqhhrQ@mail.gmail.com>
 <CAPDyKFqJzoBiG4c2NbXA_6YDNsAh4W0TO-SP9+C2Qw40TKVH7g@mail.gmail.com> <ab2f88c3-2f80-a0ae-3a74-d90dd2a6ccf3@foss.st.com>
In-Reply-To: <ab2f88c3-2f80-a0ae-3a74-d90dd2a6ccf3@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Sep 2023 13:51:51 +0200
Message-ID: <CACRpkdY1cU4D_qbC3g6wV5hcKVCL6uMJu9mH=byw+2RgQTPicQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: add SDIO in-band interrupt mode
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 14, 2023 at 11:08=E2=80=AFAM Yann Gautier <yann.gautier@foss.st=
.com> wrote:
> On 9/4/23 14:21, Ulf Hansson wrote:
> > On Fri, 1 Sept 2023 at 16:10, Linus Walleij <linus.walleij@linaro.org> =
wrote:
> >>
> >> Hi Yann/Christophe,
> >>
> >> thanks for your patch!
> >>
> >> On Fri, Sep 1, 2023 at 2:08=E2=80=AFPM Yann Gautier <yann.gautier@foss=
.st.com> wrote:
> >>
> >>> From: Christophe Kerello <christophe.kerello@foss.st.com>
> >>>
> >>> Add the support of SDIO in-band interrupt mode for STM32 variant.
> >>> It allows the SD I/O card to interrupt the host on SDMMC_D1 data line=
.
> >>>
> >>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> >>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> >> (...)
> >>> +++ b/drivers/mmc/host/mmci.h
> >>> @@ -332,6 +332,7 @@ enum mmci_busy_state {
> >>>    * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOW=
ER register
> >>>    * @dma_lli: true if variant has dma link list feature.
> >>>    * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
> >>> + * @use_sdio_irq: allow SD I/O card to interrupt the host
> >>
> >> The documentation tag should be one line up (compare to the members...=
)
> >>
> >>> @@ -376,6 +377,7 @@ struct variant_data {
> >>>          u32                     start_err;
> >>>          u32                     opendrain;
> >>>          u8                      dma_lli:1;
> >>> +       u8                      use_sdio_irq:1;
> >>
> >> 1. bool use_sdio_irq;
> >>
> Hi,
>
> Should it really be changed to a bool?
> Other boolean likes in the structure are u8:1.

Yes, two wrongs does not make one right.

Using u8:1 is a way of trying to outsmart the compiler
which is generally a bad idea.

> > That said, the out-of-band IRQs is what works best for the ux500 varian=
ts.
>
> What I understand here is that in-band interrupts are not properly
> working on ux500, and then the feature shouldn't be enabled for this
> platform.
> Am I correct?

I think we can flag the feature as available and implement the handling
but add a comment that this is unstable and that Ux500 users should
prefer to use out-of-band IRQs.

Yours,
Linus Walleij
