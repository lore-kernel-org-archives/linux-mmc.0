Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CB1C1B0E3
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E14B22B3B
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbgLDOkH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbgLDOkH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 09:40:07 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84BC08E860
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 06:38:55 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id w18so3333506vsk.12
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 06:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GV+kKzzENTLM81eJGjHI5vXFYGkDKepyqPMdHRVRsqM=;
        b=nlpic3k+eRJKdSyxMwep0JNGCTo4BhJQfBExsSrFBkjK7krEYgYqjrlcCNfASJJcwX
         9Vgf1wU4wsoPfmiay0B800n7nkptbI/Qnn256zlqsNtZeh+ISe3I7gNy9d3ulxoI8BJS
         YOHs7FLJOBd/YCczyV4QHslhd9NFyRiz6MbY4ipqOZkduqJUq9HFzx2ynPbkUwiCE7WA
         1t4ayQyJ50YpJgERxQ/QJ8Z0W9Z8hAykeK0NAC8YW5iRWK8s5Xo/4eJ72Er2bdZZ2J1K
         tblBEqGKVFHTzeyN82/MfE8gLwwAHzT2vpfrY/CdIHVFl69xiAkusWTxcGD9sn4Yvu88
         ymqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GV+kKzzENTLM81eJGjHI5vXFYGkDKepyqPMdHRVRsqM=;
        b=tQmbz87gu/W95KmCjdPrJvumlVgEECkkJV0ckAW3byYPr4r8Qvh08jCc5zoVj7qFtD
         8/z52bNbG5fnGPlZhiSLVH4pIKJbcE62k5ixfL35G0wQG4n1vtFJQt4g+j5VduV6yL9r
         hAXt4qW66GesGxtGODTPIb6TBOBp37oe9+yqkBQKXMKqzSobJN2nOmf891GvAIp4XCv4
         JpIzSU03+qtRDEWmdC8RKSY+9flLYRHXf6g3RK1z9WfeMuWB6KOkJYrpYGLT+6vV2Rpy
         ZjMyYtJ8FPCg36U9TkIgmSd0tMytYWMzspvZz13qXxK9hqOQE9/I8bOulx158+Swxhxw
         QaRg==
X-Gm-Message-State: AOAM532D8+I55Si2ZEJ8YVNj1MC96Tsspgtdr1Z5qZlBjH1GPbXtXyIb
        rdjdKLvDAkF2ZIW+/7NBQc0k71Gq4l3O/NvjfrDeJQ==
X-Google-Smtp-Source: ABdhPJxcEhwvF6bfH3CXkhhxoYBwkL+UeuLiVzx6UiZL4XPyY728h8req9rj4UgHGJNlF8DW/PtA063oqMx6K7c5y7s=
X-Received: by 2002:a67:8c44:: with SMTP id o65mr3185882vsd.55.1607092734320;
 Fri, 04 Dec 2020 06:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20201125213001.15003-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20201125213001.15003-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 15:38:14 +0100
Message-ID: <CAPDyKFp3gt9AJkOMBDT_OsJ9QfPCS-Q3Bx7RBq6QWS-QP-mx4g@mail.gmail.com>
Subject: Re: [PATCH 0/3] tmio: set max_busy_timeout
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Nov 2020 at 22:30, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> This is a follow-up to the series "mmc: tmio: honor busy timeouts
> properly" which I sent out a few days ago. One of the patches there
> needs more discussion, so I regrouped the series with another one, and
> this is the first outcome. It is solely about max_busy_timeout:
>
> Patch 1 is from the previous series (with the comment from Shimoda-san
> addressed) and sets max_busy_timeout with what TMIO always did. Patch 2
> introduces a hook and a default fallback for extended timeout ranges.
> Patch 3 uses the hook for the extended range of R-Car Gen3 SDHIs.
>
> It has been tested that the applied values make sense. I have not
> measured if the MMC core really sends R1 instead of R1B when the desired
> timeout value is exceeded. All on a Salvator-XS with R-Car M3N.
>
> The patches are based on mmc/next as of today. The branch is here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/extop
>
> Looking forward to comments!
>
> Happy hacking,
>
>    Wolfram
>
>
> Wolfram Sang (3):
>   mmc: tmio: set max_busy_timeout
>   mmc: tmio: add hook for custom busy_wait calculation
>   mmc: renesas_sdhi: populate hook for longer busy_wait
>
>  drivers/mmc/host/renesas_sdhi_core.c | 23 +++++++++++++++++++++++
>  drivers/mmc/host/tmio_mmc.h          |  5 +++++
>  drivers/mmc/host/tmio_mmc_core.c     | 22 ++++++++++++++++++++++
>  drivers/mmc/host/uniphier-sd.c       |  1 +
>  include/linux/mfd/tmio.h             |  7 ++++++-
>  5 files changed, 57 insertions(+), 1 deletion(-)
>
> --
> 2.28.0
>

Applied for next, by amending "from" to "Wolfram Sang
<wsa+renesas@sang-engineering.com>", thanks!

Kind regards
Uffe
