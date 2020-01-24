Return-Path: <SRS0=bXXM=3N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DAFC47409
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 13:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58822077C
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 13:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gins8z7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbgAXNUS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:20:18 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45836 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387888AbgAXNUS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2020 08:20:18 -0500
Received: by mail-vs1-f65.google.com with SMTP id b4so1149619vsa.12
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jan 2020 05:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t65RoraJ97XSNifH3nJWhcpZY1lN6qjNaU0+rNtB6VA=;
        b=gins8z7JzejJQal9gDEbPpdg5XvecgftPkBOzZDn61Udldh3usgTviD1RSeTs/khVg
         P6QL2wdgjepWpZPu2K07a0Gi2j30WxCH8luSM9XeXKn2a0tOlWNsCiBvesNyFuoRTa2l
         l+vIULJyGGwlTBlM48w/mQcMBP9WP2/M/8BvfKaietFwyHD4quO4EfSzZuZDebmtJUKO
         N78p+V3i2PTQYXQaBm9DxrHQdcBOrL5nyx5ZvfkLk7TND7MMNM/kXvpRBQCuqtQn+Mxh
         S+P6c2mXdalbk8iIrd+uIIUDrn+lJsAfuy8AVqcNxmXZb29qZ7+MytSuK9cABHt20/c6
         vbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t65RoraJ97XSNifH3nJWhcpZY1lN6qjNaU0+rNtB6VA=;
        b=jF6hieIzFReyOVru5O1sgqqvR7HSyMNgcTLTPEdsb2YcD2ZO4kGKchWBmu5F7vyleI
         XsdABqilS0Feo+hx9ZfuWo/sXRZWe9iK/0G0AGFGM1hLDLkYMgGxYFxXqsl1/55yIDhK
         Uq2Cyn1RQ6fy0M1ke5oSz0UvSbsCVmK1+HbPVFtB7T/GHt3+kujKn5Tj1u7qpj5bqoJm
         bat02K/DQN3AGHkhePbmdbZPidycx6IyjfaqCOcz7batrq8Y70aazu3Hk54JmDtF0fWl
         QzClxiyZwPIWqwHvjSHvPYUE0dmVVBZM00fR83as9RZtW8CXzUD+OwcSra8Qcopok0PO
         sOWg==
X-Gm-Message-State: APjAAAUvzN2EceZUCWBrHarOtPH8EkLG6WA4NLCOcMoF6fFOoDhIwtkB
        n+kABN4HC99tdlRe7kM+O6jCug35GSt5fD/0h5c10g==
X-Google-Smtp-Source: APXvYqwPiZbZvXR+rHIvNUYilWv/U2EOOXMt8apmM26fWaq/fAZpxuaFlhAeSj98ruAwNOVdB6HsKU61mDEy2b2ThPA=
X-Received: by 2002:a67:cc3:: with SMTP id 186mr2203033vsm.200.1579872016966;
 Fri, 24 Jan 2020 05:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20200110134823.14882-1-ludovic.barre@st.com> <6d859def-351e-abd7-0d5f-962ad935dff2@st.com>
In-Reply-To: <6d859def-351e-abd7-0d5f-962ad935dff2@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jan 2020 14:19:40 +0100
Message-ID: <CAPDyKFo+4qTZbE=4Zgj3VN9BPYUHGskPSnYEJRo1TpARzg5zJg@mail.gmail.com>
Subject: Re: [PATCH 0/9] mmc: mmci: sdmmc: add sdr104 support
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 24 Jan 2020 at 13:55, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> Just a "gentleman ping" on this series
> https://lkml.org/lkml/2020/1/10/392

I was just reviewing :-) Thanks for pinging!

One overall comment is that I think you can try to work a bit on the
changelogs. In some cases you described what the patch does, which is
good, but it may lack information about *why* the change is wanted.

Overall, the series looks nice.

Kind regards
Uffe
