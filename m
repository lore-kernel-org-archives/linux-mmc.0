Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A06BC49EA6
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 18:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCF960234
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhFXSCu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXSCu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2021 14:02:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A29C061756
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 11:00:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i13so11761106lfc.7
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Kwj1QVd2jDusMQC8gwXFpHAaH6OWMrxw5QqC/i3GEc=;
        b=ZvlAH+2XrG33AkkWLeySsdyAhMe+zndJGCq97RXX8FNBxVn/QFKSKBS/WQDciMKoi0
         2UWwwdo2k2OpIiljEH57P/K7FzQXg5l5M+YbWDaDlFVqz985ucWewefublUs3fgJJF8X
         fLk0g9rIyzFsVOABL1tk77nnK/ENlWeLT/J/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Kwj1QVd2jDusMQC8gwXFpHAaH6OWMrxw5QqC/i3GEc=;
        b=l3+DtGsk84HqjppQfwGt4LK70Q8+m3BYAnOmTbGXZzUt0qb8NJuY/zFTKRkAJpv0bd
         nEYwarfduRJPAwpEMqlRIL2WV/B8E0d/6qzCDSOnQ2CV5oRFKwUXNRS2x1pNGM+CiS9d
         EofQuy0xjqMGmW7c6J678PFOW4mtjc571vaKFdLtdV6PFvAi4EMTeJHdUwpVSHxyjItl
         FuUq0F7uP/mLDL6SUJxu1rQpVLZbDFJji1XnzF7rLawjRWjyaOyGg+d1mTJOPA4T3f5A
         blNxGb0gvDr8PbCgZqzOIBoOQX48RnWoHke+ECUsCM/KV73v7nZKIi+H6Q1Nvr0O8mCu
         2WGg==
X-Gm-Message-State: AOAM532wHWlNfwk2CXgnIB/mlaiTB+cRBpOCi5cCdx5Tq6IK4X32PZZX
        0izUzu9Ow2duErvVDz0d97frIQdtcCIWFFUf
X-Google-Smtp-Source: ABdhPJx10CWKwHw8+k7JeqwHEpQta2YISewJGF88K1w8xi4u/5KJaFn6GjIS44/7q7BUe5rx7pFNng==
X-Received: by 2002:a05:6512:3499:: with SMTP id v25mr2439427lfr.612.1624557628447;
        Thu, 24 Jun 2021 11:00:28 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id l9sm287135lfe.86.2021.06.24.11.00.27
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 11:00:28 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id i13so11760875lfc.7
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 11:00:27 -0700 (PDT)
X-Received: by 2002:a05:6512:15a2:: with SMTP id bp34mr4614034lfb.40.1624557627041;
 Thu, 24 Jun 2021 11:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210624123251.191299-1-ulf.hansson@linaro.org>
In-Reply-To: <20210624123251.191299-1-ulf.hansson@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Jun 2021 11:00:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whn_yTjV=YAU4xMBkLEb+E76zUKM_Xy5ZwMp_504wqR9A@mail.gmail.com>
Message-ID: <CAHk-=whn_yTjV=YAU4xMBkLEb+E76zUKM_Xy5ZwMp_504wqR9A@mail.gmail.com>
Subject: Re: [GIT PULL] MMC fixes for v5.13-rc8
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jun 24, 2021 at 5:32 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Neil Armstrong (1):
>       mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk

Ugh. How horribly ugly.

Why is that 'host->dram_access_quirk' test _inside_ the loop, rather
than be something like

        if (host->dram_access_quirk)
                return sg_copy_to_buffer(data->sg, data->sg_len,
                                host->bounce_buf, xfer_bytes);

at the top of the function, with meson_mmc_copy_buffer() then only
handling the mmio case?

No, I don't know this code, I'm just looking at the patch and going
"that looks really ugly".

Anyway, I've pulled it, but I thought I'd voice my reaction to it..

              Linus
