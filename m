Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC44EC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 11:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343814AbiDZLxb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 07:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiDZLxa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 07:53:30 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE5D9FC6
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 04:50:22 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id y2so13555110ybi.7
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQTsgDG5xvg3ntkuHtXQC4S0FZydeXEytKy0e+38lqk=;
        b=uka5+Qoo4du14UwQPhrNe0Vx3WrmjWG7q3a9X8IK333HYpFnAwyJ/3UsklWsNIcRG2
         AfXbqhYJzU/SlakNZw9JxgYlR6mjizcU95j3DBDwnPJeFVbteGMqHmrFhONW8C8TTQXM
         INUQFQB1fQOp0WKojHHLP6jSo5/i9CAs+mJBQ1sV4Pyne/CIVCKl1ZdVIIgKUyBrGYot
         HXPIcyTiafz4y6lGZOikWYoYFlG50UzdT3/yUZcB82iEaRnpXGwiLNjiakP+tjqc9BZw
         YtXhoKeWOclzyYdUtnGH16gOA/lXXePJ9II12QiaD61Sz7Q7I86TkcY8RbeqH4JPVtRX
         kRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQTsgDG5xvg3ntkuHtXQC4S0FZydeXEytKy0e+38lqk=;
        b=RpQmv7v0e11cRk0AWUik3I7klQSinSuCMqxDe+icoWxYpnjlbTmf3ZWjLVXUmxrqvi
         EbiLw4bnHJQJwBDxjpuEdxuiBz2NbpIdpx1Qya3m7beH3IzIZjL7lqBDianxqYDdBZ3t
         wH6iP+buxObRTZ3XC/WZp586au0m7IxRdwfvi+iJCBNZWTK93eibVGchaCRMGY2V4x82
         eqDV5wDzNfb6/SwvNtTwGT47HnyRG6qChweTbZtVNSCif/DVVMA7M87A9iydN2/UZpoJ
         SL6khC0lICRyI6SbI1XO/w2A38T8hFrzIkUbJRtKdqbxzJruymOevl+UTmuepM38nzQy
         1waA==
X-Gm-Message-State: AOAM532uzlE9dRflPQ9vK+ARnONQWhpWDEqVwpQbaUzXj5xKA3We1+Yl
        m4lPEp0Gb0Nu5nn+y7esepaQdCZiHB4/oivluhVpaSy3mFc=
X-Google-Smtp-Source: ABdhPJx1RR9vawo9v9RsZzQk8Jt6xAkDAw4T/5KkPE1BF2cPBB27KO1pljthwyMURq3PJLNVHf2DkbpuPsC9jIqlx6w=
X-Received: by 2002:a25:8250:0:b0:645:8834:b91f with SMTP id
 d16-20020a258250000000b006458834b91fmr19346635ybn.553.1650973820730; Tue, 26
 Apr 2022 04:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220426100605.36019-1-ulf.hansson@linaro.org>
In-Reply-To: <20220426100605.36019-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Apr 2022 13:49:43 +0200
Message-ID: <CAPDyKFp1LDYnYOuh2ub2q4P=jQzhwtN7bNWWJK5h+g2aYEb=eA@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Fix build error MMC_BLOCK_MAJOR undeclared
To:     linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Cc:     Ming Liu <liu.ming50@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 Apr 2022 at 12:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The reported build error:
> In function read_extcsd: mmc_cmds.c:72:18: error: MMC_BLOCK_MAJOR
> undeclared (first use in this function)
>
> In commit 118dc4a0909f ("mmc-utils: Remove unused MMC_BLOCK_MAJOR") the
> define for MMC_BLOCK_MAJOR was dropped. In a way this commit is still
> correct, but unfortunately it also introduced a dependency to a commit for
> the Linux kernel (83fc5dd57f86 mmc: fix compilation of user API), which
> fixes the mmc uapi header file (mmc: fix compilation of user API).
>
> Rather than relying on the commit in the kernel, let's include the missing
> header for MMC_BLOCK_MAJOR.
>
> Reported-by: Ming Liu <liu.ming50@gmail.com>
> Fixes: 118dc4a0909f ("mmc-utils: Remove unused MMC_BLOCK_MAJOR")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied to mmc-utils.git master.

Kind regards
Uffe


> ---
>  mmc.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mmc.h b/mmc.h
> index 25d6864..0796532 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -17,6 +17,7 @@
>   * those modifications are Copyright (c) 2016 SanDisk Corp.
>   */
>
> +#include <linux/major.h>
>  #include <linux/mmc/ioctl.h>
>
>  /* From kernel linux/mmc/mmc.h */
> --
> 2.25.1
>
