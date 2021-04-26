Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68828C433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 09:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2614361040
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 09:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhDZJpW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Apr 2021 05:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhDZJpW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2021 05:45:22 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DC7C061574
        for <linux-mmc@vger.kernel.org>; Mon, 26 Apr 2021 02:44:41 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id z34so897490uac.12
        for <linux-mmc@vger.kernel.org>; Mon, 26 Apr 2021 02:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdc4NGpyhSPI0l8P0rAkrFsxEyB9PvJbldlNpyk6qiw=;
        b=Kl5/ZzkJ9EV2ugj/FBuCtAzsCK5u4BnciggCrSmn2qLVdL2oqJI9IwMYUo1b5kg20q
         4Io75xTCjVechg87eHqaJhvHG5OCXDKz/HXK1tjdQifqLVvdqs7HRWksnM8QPyMQDfOR
         Ew6YQLqhhC85vvhhfIU4qsm2LWg4OX66KhmIfUkH5bmdnLWD1dZ5f5/Ru9XLKIZFT3Ty
         W7dSqpkR6DQFfQYhCfHTf4d151c9gE25JH6t22vV+vsvwXggW//4IjaDX4hclxtlCKTt
         RPxwheSetgvl78CPkQ/51GHkU7x7zyscULwvJN86MJIdbGk3BIF/hgO91vOoMWBo4NIW
         4ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdc4NGpyhSPI0l8P0rAkrFsxEyB9PvJbldlNpyk6qiw=;
        b=Ow/5X9AjwbfNd+0trEy9BRzhOtZwF85FZxEajm08f4b/9Uf9huesmiMG8dZWnRQjZB
         59xJQ5RCiQLm8eOkhV03HH1rXYBz4UkwrxWjhq0Kw8+vv4r5CQ4rCpPiavUXNW+/rIfQ
         q8goB4/KGUAd9orPwC8z4jvhOVqlJFno9tOFfaLC9/jlG/twK/nUGpHaHOw2QsX1iklO
         lPrNKmsJvgdM8YMbCiiYa1TYt51q3FXOxYNxaLuZpA1fbXzZyCBOpEN+dgZiSLxqD1/6
         rToPDWEVqJtBOLCgl5QOmYDg6KlWhAHH2sGdt9DlWtBJ5Z93aN6nsKi5L+MAD4WW5CVV
         WT7A==
X-Gm-Message-State: AOAM530jhEUcqBPNx7JB1nUslCZfKMu9fKvuFhay48L2jSIV/sWOcSUV
        7YrVoJBuS37qvuzvbSgf+G2GzP5BQCj0gBsfQNd7Og==
X-Google-Smtp-Source: ABdhPJxXSAA0ghiUOYW0SZ5vU/6S9+Kwa5/yEDnRiDEqeGQMWO1ZaO1iCxx+cGxz6cjwDs2ixcN1ykwBs+8ZvjhHPx8=
X-Received: by 2002:a9f:37c8:: with SMTP id q66mr11124562uaq.129.1619430279926;
 Mon, 26 Apr 2021 02:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210425060207.2591-1-avri.altman@wdc.com>
In-Reply-To: <20210425060207.2591-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 26 Apr 2021 11:44:03 +0200
Message-ID: <CAPDyKFpZhk-kDpuA1m-E4RXHMXbG72S=OW07XrLzP0-9Q_Gu9g@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Do not flush cache when it is disabled
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 25 Apr 2021 at 08:02, Avri Altman <avri.altman@wdc.com> wrote:
>
> v4 -> v5
>  - patche "Update ext_csd.cache_ctrl if it was written" accepted
>  - Add one more patch: "Add cache_enabled bus ops"
>  - Add Acked-by tag
>  - another rebase
>
> v3 -> v4
>  - Attend Adrian's comments
>  - Add Acked-by tag
>
> v2 -> v3:
>  - rebase onto recent cache changes
>
> v1 -> v2:
>  - Attend Adrian's comments
>
> Cache is a temporary storage space in an eMMC device. Volatile by
> nature, the cache should in typical case reduce the access time compared
> to an access to the main nonvolatile storage.
>
> Avri Altman (2):
>   mmc: Add cache_enabled bus ops
>   mmc: block: Issue flush only if allowed
>
>  drivers/mmc/core/block.c   | 9 +++++++++
>  drivers/mmc/core/core.h    | 7 +++++++
>  drivers/mmc/core/mmc.c     | 7 +++++++
>  drivers/mmc/core/mmc_ops.c | 4 +---
>  4 files changed, 24 insertions(+), 3 deletions(-)
>

Normally, I would appreciate this split of the patches, but since
these are material for stable kernels I decided to squash the patches.

I also took the opportunity of updating the commit message a bit and
did a minor cleanup in the code. Please have a look at my next branch
and yell at me if there is something you don't like.

So, applied for next and by adding a stable tag, thanks!

Kind regards
Uffe
