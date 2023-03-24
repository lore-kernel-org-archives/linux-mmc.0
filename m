Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65B6C761AF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Mar 2023 15:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjCXP5i (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Mar 2023 11:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjCXP5i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2023 11:57:38 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D2520D11
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2023 08:57:35 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-53d277c1834so40358267b3.10
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2023 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679673454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mhl5eyHIy4t0FxvsyFxf8GRZmHksDRlBfSPBEaaSE40=;
        b=xDsN35LVtegxj44RHs8tPGvjTUF+rNEZMIZ3yrlzqr0LZ/IZ0lG+KbciyPDnuX/0YS
         WADgbdxlk8jD8e0YGN4sH34s4CvqvBNCJ/usYATeurUNOTV6ND+cEpKAmPAl1Q/bPYl3
         4c5i760F6QnS6HOvUfA+ycOF3cd5sTECMvznRifsC3/cRXkmiA7JRcD6u3rayW2Jk2c0
         0Jvwf2mosPH72mxLagEcFYU5y2r+nq0DzxgR/23245igVvMpLi9jJA1q8dgJ4BW48lAK
         qV0va8ZreslCLhet1J2zl4ZeX9RmsG/XG4vYW1kMbvkzsLjUCupO95nzSYUSaL+UCeDZ
         6BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679673455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mhl5eyHIy4t0FxvsyFxf8GRZmHksDRlBfSPBEaaSE40=;
        b=vwG/+nR8slOhNdYOMFE8mX4GF+4tVluB9ZVM8TwU977drcN36ZrPuhrtow18xAZXW7
         xRfkJi+DoJpLAJLte3icygEh/L3jsRWA3/YsO+7WR0mXB5DA2aRUwMaiHGfcaPCbe+jW
         NqToOunJXMjbIPCjStqW5tL0pZlWiucdLhHxBst8RgTIfsCE9RQ+dKC3qxQULEVPjhjy
         wSUa7eTyOXbWr75qDLMLA2EYBnYHO9EHic5ww8WDB3E6zGanEu57A5+JcbTfVVsmKuIG
         orwA8YwNrosGR0wCzC+w7l8PYf5UrwtTuFGkBHHBWSU75JStrMU2WQBZ3ufePXV0tqOK
         2j6A==
X-Gm-Message-State: AAQBX9ff4q53fO+sMnTMFu+4XVkQS/X1SxUMF5KVplISjDwExBZctOQ0
        QTJZJK573LtZ3v5kUnIuj3VfkKpuIm+ZiI1CgC/PkQ==
X-Google-Smtp-Source: AKy350b/H8pIBbxmXogIRhsqyI3vkLXDtgv283FnFAOI0cxb5jOZgkd4shv6Id2N7NaM+TPOrcj1TjglrWTFuydgeHk=
X-Received: by 2002:a81:ac46:0:b0:544:6828:3c09 with SMTP id
 z6-20020a81ac46000000b0054468283c09mr1359311ywj.0.1679673454774; Fri, 24 Mar
 2023 08:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <d2444591-c91b-a94d-71e2-9dedc3b6c514@free.fr> <CAPDyKFo7z9c9A0ccqBja98WCvp+zJHU2Ni9AZ=UK=fy-nsuKXA@mail.gmail.com>
 <f7539a3d-655f-bdff-977e-ed10becf5d94@free.fr>
In-Reply-To: <f7539a3d-655f-bdff-977e-ed10becf5d94@free.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Mar 2023 16:56:59 +0100
Message-ID: <CAPDyKFoE6cTrxdYu5S48mZqxC4U5CmaxyPNYJnKLkz+0KT80MQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: log empty non-removable slots
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Pierre-Hugues Husson <phh@phh.me>, MMC <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Mar 2023 at 16:33, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 23/03/2023 13:13, Ulf Hansson wrote:
>
> > On Tue, 21 Mar 2023 at 19:01, Marc Gonzalez wrote:
> >
> >> An empty non-removable slot might be the symptom of probing too early.
> >
> > I took the liberty of adjusting the code and the commit message a bit.
> > Please let me know if it doesn't look good to you.
> >
> > So, applied for next, thanks!
>
> Thanks for reviewing & merging.
>
> Can you tell me (for my knowledge) why it's better to check
> host->bus_ops than host->card ?

It doesn't really matter at this point, but to keep consistency for
some other earlier code in mmc_rescan(), I decided to use
host->bus_ops instead.

>
> If the situation should not happen, perhaps we should use pr_warn?

Yes, maybe you are right.

In principle, I didn't want to use the warning level as I simply
didn't know if we would end up spamming the log with lots of prints
for various platforms. Perhaps we should change, when we know a bit
more?

Kind regards
Uffe
