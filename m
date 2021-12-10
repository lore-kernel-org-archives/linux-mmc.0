Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89113C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Dec 2021 20:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbhLJUQX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Dec 2021 15:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344066AbhLJUQW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Dec 2021 15:16:22 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723FAC0617A1
        for <linux-mmc@vger.kernel.org>; Fri, 10 Dec 2021 12:12:47 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id o4so14721181oia.10
        for <linux-mmc@vger.kernel.org>; Fri, 10 Dec 2021 12:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slzGBePYCrgaDRnlPEDIBIMYbsbR6khnbp5/bRRqlbA=;
        b=cgXPDoiQUDpeq4SoOZku+p8ATEz18iL0zuiQKUBqGKXZmWLg7N1xkBU7LxNzEr5n9C
         NlSafWcjVHHsq/jSot7wUqy68WmnXBHH7t2G0ORUHaCHWjrNaJn8tdeT+eEzlaC/dGXv
         Zh+4PNLER4mqQ0AxF+WAX0Lz/opfSGHBLeB8jPEA62LRIEzPwu3W9KuDQXpk7EytOcTI
         CjX0JWg9VsIt497fo1SNCZBUfS5NmHy17dcyghuw7wFYB+nEUP98Yc/TvX7VWGj+Z06N
         wu0Y471tKEkarz22PSdgrFT/Z5/8hGbuVhiTi6lpEV3/IgE1lXLji6ATu9jzOulRAPik
         x8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slzGBePYCrgaDRnlPEDIBIMYbsbR6khnbp5/bRRqlbA=;
        b=FB7Z13mFlA0KQJBuomGFMOi/l8tjl5qA9OZrSF2ACE2nGaU5rw6K1LSBgd16FG18mI
         Uy63kWtFAYsE/bMqFmICEhsh2MSrVIEBJjkf5+UblZuL2SzPRSSCaP0q8MdS8bKQ7s9k
         aKt5h0rHnwA7J6WTrjVOSduS5GUS6Xs+hpV3cdpOoJdD7Lc7U7lwgDsy4PCMtcOO1guo
         eBim8yv58QyZApI3JXvijY8bW5IvLj60nZhK2LvgO4jBgrv3USc3l7Y4IrTr2jBPqN2y
         +tub6PCh/t0PRtZsjkJUuk5p/wAihvAcI7AKUV6Dt+c/BKCN24Veg1B4QF418HjVwQQv
         r4Lg==
X-Gm-Message-State: AOAM533oj3AH1lXFJC/4dJef2KCwX40JCCePGIPulWxmiERwUgmFGoxb
        AG2xGRrhDbH18pQeVMB1XcYfCZvkIF+m8a5cnYSWsQ==
X-Google-Smtp-Source: ABdhPJzMR2vznEDF8swuHq63lynTYGhs4v11eF+LAnUSFHWHggwuzwRmt93CPGXvBFj9Zfzps2o47kI7iQ/XPRY7uE4=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr13991533oih.162.1639167166807;
 Fri, 10 Dec 2021 12:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20211210091834.28958-1-yann.gautier@foss.st.com>
In-Reply-To: <20211210091834.28958-1-yann.gautier@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Dec 2021 21:12:34 +0100
Message-ID: <CACRpkdZtRqr0xnS849ZEsDGMtnDNKgOZu=7ww5H_fvxoTDQpag@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: add st,stm32-sdmmc2 compatible
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.pallardy@foss.st.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Dec 10, 2021 at 10:19 AM Yann Gautier <yann.gautier@foss.st.com> wrote:

> Although this compatible is not used in kernel, as we use the common
> MMCI driver, it is used by bootloaders. The U-Boot driver was merged
> before the kernel driver and uses this compatible.
> To avoid issues when aligning device tree files between kernel and
> boot loader, the ST dedicated compatible is added to bindings file.
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

Why not
Acked-by: Linus Walleij <linus.walleij@linaro.org>

> +      - description: Entry for STMicroelectronics variant of PL18x.
> +          This dedicated compatible is used by bootloaders.
> +        items:
> +          - const: st,stm32-sdmmc2
> +          - const: arm,pl18x
> +          - const: arm,primecell

You *could* mark it deprecated if it's not supposed to be used.
But no strong opinion.

Yours,
Linus Walleij
