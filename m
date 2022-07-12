Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C18C43334
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 11:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiGLLJZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiGLLJY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 07:09:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29F8AEF7F
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:09:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id e28so9753172lfj.4
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GtGgLrxNDhgvI+v91Xovps7msOe7jAt3sd0zY52IjMA=;
        b=t5g/R6Cvxremka/ngioUBUxrLfcHv38NZoo7Rn0q2Lk4elrTfMleQk/4uutnjOAvlo
         TCNJD6Nr3WAGC1HNyQarKTWNoP7u0L7dXuUjEc1CQHyNKFNN87hUCwpoZFuDOdpbEyI6
         uHECB+yw2Kt2tpyFu+RFfV7rOneCyg2938xlusajEZEDYx1hTPsLKwU8TtJ4YyACHeJ/
         gjhvUTInwOmvZLacj1QRBvTJwgHAn/2NZfvo+rgdt8UNlovsv5QV7YR/gUf6VsRtXhzM
         AUqPtq06bms/W2UORSjknX7RG6MjmJqywzjOwYp3HWfegguDTPuL5/ZAqmh/UmjI9i9g
         k5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtGgLrxNDhgvI+v91Xovps7msOe7jAt3sd0zY52IjMA=;
        b=MYOVk7QGsGbm5lN9g6xxhGfW0Vm2VDdc8VAbqwCE9PKW4prlNcfYZzaz59QxRj8LQp
         vfwr3R/aoiG7r3YTWu1S0ilrPaCO2gOmsIcLpGchtODIqwrQ7QyexXxk5Jz4P7FLfcPq
         u0wJuw03mK59MPqMzFlnWQO3nkj2j2+GCWEhVUHXDaa58mVTUqizNrJGAYzvcJOrbbNI
         SjS42ZGF2cSIfwKQ/U9m7tF7iXFQGmIuZENNvA62vXKLMuo0esURvH1ZpFNje6pf9TQv
         MsCWpLTLXQSqOQh8Hl45i9EhDebnJ8IyF05QPNp4gp+Oj6SEFFnHEJ+aTG9zLL8vYfgG
         11ZQ==
X-Gm-Message-State: AJIora+lyKPf/qpultMcW0JKfNR6kP2bTtPXfFVyjkr+9Q27XZvqepcX
        luHFXVkDQst9frcFA+TkMwiZGpGilWltfdOc4tGn5Q==
X-Google-Smtp-Source: AGRyM1uD9PTLxT7S3witbZ69cn8djykXJyQX+Yil2WB3puDpqBIZz/kTrVAoqdgMsDjFKJyib2hTZvrIZ/bHJs7bUPQ=
X-Received: by 2002:a05:6512:15a8:b0:489:ed48:24 with SMTP id
 bp40-20020a05651215a800b00489ed480024mr2184751lfb.184.1657624162065; Tue, 12
 Jul 2022 04:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220624181438.4355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220624181438.4355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 13:08:45 +0200
Message-ID: <CAPDyKFpEsL1i5pikDmGdsjg-q-HbpMGWbxytB=8XEgTYJ_rOzA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: renesas_sdhi: Trivial fixes
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 24 Jun 2022 at 20:14, Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Hi All,
>
> This patch series adds trivial fixes to renesas mmc driver.
>
> v2->v3
> * Fixed Review comments pointed by Wolfram.
> * Included RB tags from Geert.
>
> v1->v2
> * Fixed review comments pointed by Geert and Wolfram.
>
> v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> 20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (2):
>   mmc: renesas_sdhi: Get the reset handle early in the probe
>   mmc: renesas_sdhi: Fix typo's
>
>  drivers/mmc/host/renesas_sdhi_core.c          | 8 ++++----
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
