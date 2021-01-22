Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27334C4332B
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 10:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC40B23A03
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 10:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbhAVJay (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 04:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbhAVJWh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2021 04:22:37 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13B3C06174A
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 01:21:54 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id v19so2220618vsf.9
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 01:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNl4YWwXbSeUgeeE4NjNBeE9Y46mehLnVl5f/1sLqFM=;
        b=CJ3SolmwQPIivR+cjS8Mddx8zvNblZ7j7blcJ9g640VSGUtOTUOA6D/6IvYejcsKa9
         omDiRdFxPc0jFUqWAuk83M7egYm3NNqOUD4r1PN45DXfILVg3kB/s+CSyoz2WbBDdp5q
         Erf0ZiyZhfistNnr3w4rtMmgqHgtfHs0LrCbGeVGnJuOPxOPdTyv5ra/SVzXgpvrj5js
         3Rdt3QC2eQ0x17mCTDHn/V9jKmOvBIgPS6hbjLzGGhlclTChvP1AgNEew5WOlK4JtRXx
         TPxOh9WWT/JgS81T0b6mIBtz7Rfldw+6DqST7a1vhamz0lt8wKaO084MPZW6vb+M5GYx
         LyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNl4YWwXbSeUgeeE4NjNBeE9Y46mehLnVl5f/1sLqFM=;
        b=AO5SsM0qqr1IBz13ioI8+nEb0GXewJSRT/o6ycOLuyRWsuQ672YNVb1eoTqcgZ+N2U
         iXXULMQ9zTsNjgk8y6NoO5BBhb+pEDV5/qTehW3Jx1zDDI6fD61JjmVxNfZ6AzCtkSg8
         /ZLkXZ3BEvlwI/VyLnD+blobscuGmRlHNKFLJQqSbE62OFEA71P4pX5/U/QT2ZWLdOzO
         g2gvnbiYJCEML++jaKgTymlQqpBoZSCZ5thjO7XFtAsrwBqBnxbQ1yo8qRIzT4/a+tij
         3CnEhX6bLFdpZdLRBae9Byhn16aW5A4DvscVWyHXLB1Si3QedCiNa+qNlDcPMFtL/Usu
         PBtg==
X-Gm-Message-State: AOAM5308KM5QYDZqCjvWPNnTV/iGtnHRmlCtKrSP0Iv74k9cPLIfFEPQ
        9Me2O/aRdLpuN99LdyhR3K0jyE3BjX1D4sHD4mVqrA==
X-Google-Smtp-Source: ABdhPJzlDpOkOSJ3N3bBMlhwfPt8XQXPEi5zEwg/3I5Bzwul5pVkvkMEjzifQ8FzxqpAl8T+e143Q/pKLS/6P/Efe6U=
X-Received: by 2002:a05:6102:48a:: with SMTP id n10mr267550vsa.42.1611307314186;
 Fri, 22 Jan 2021 01:21:54 -0800 (PST)
MIME-Version: 1.0
References: <20210121090140.326380-1-ebiggers@kernel.org> <20210121090140.326380-5-ebiggers@kernel.org>
 <CAPDyKFqCz=N9R6RpEoMO+zoKhJbds1rbvgzHJ2z+6k2U2Wq6Yg@mail.gmail.com> <YAnFPC0f4vJsKbuL@sol.localdomain>
In-Reply-To: <YAnFPC0f4vJsKbuL@sol.localdomain>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Jan 2021 10:21:17 +0100
Message-ID: <CAPDyKFr7OOOVh-RwQGu+VnChvf5EJjW_dW1xoD0950iMUW_ZEA@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] mmc: cqhci: add support for inline encryption
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-fscrypt@vger.kernel.org,
        Satya Tangirala <satyat@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neeraj Soni <neersoni@codeaurora.org>,
        Barani Muthukumaran <bmuthuku@codeaurora.org>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Konrad Dybcio <konradybcio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 21 Jan 2021 at 19:17, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Thu, Jan 21, 2021 at 02:04:37PM +0100, Ulf Hansson wrote:
> > > +#else /* CONFIG_MMC_CRYPTO */
> > > +
> > > +static inline int cqhci_crypto_init(struct cqhci_host *host)
> > > +{
> > > +       return 0;
> >
> > The host calling this function may have MMC_CAP2_CRYPTO set for it.
> >
> > When CONFIG_MMC_CRYPTO is set, cqhci_crypto_init() may unset
> > MMC_CAP2_CRYPTO if initialization fails. It seems like we should unset
> > MMC_CAP2_CRYPTO in this stub function as well, right?
>
> The code in sdhci-msm.c that sets MMC_CAP2_CRYPTO is conditional on
> CONFIG_MMC_CRYPTO.  So, MMC_CAP2_CRYPTO won't be set when !CONFIG_MMC_CRYPTO.
>
> I suppose we might as well do something to stop other drivers from accidentally
> getting that wrong, though.
>
> How about just defining the flag to 0 when !CONFIG_MMC_CRYPTO:
>
> #ifdef CONFIG_MMC_CRYPTO
> #define MMC_CAP2_CRYPTO         (1 << 27)       /* Host supports inline encryption */
> #else
> #define MMC_CAP2_CRYPTO         0
> #endif
>
> That would be more reliable than relying on the flag getting cleared by
> something.

Yep, this looks good to me!

Kind regards
Uffe
