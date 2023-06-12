Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68409C7EE43
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Jun 2023 20:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjFLUSx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFLUSw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jun 2023 16:18:52 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0ED134
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 13:18:51 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-56d2b950447so15508347b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 13:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686601130; x=1689193130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TNPo9gKXIL4FCpDh6KTWP9fJLG0HuZNVGLsd8ABIfyw=;
        b=sucSs72FE91fgODM716hBYJIj5Novjkk/eRMtJTSdAxf4jKNdzzbr+xxAQaaTTVLgc
         771823PRDVgskAvOtoC8/vZtkoe00UM+J7W+hAQ/doOdvUnUViT1U1XRZTkRqSo4lCIX
         aWkjvp06+1XE7WNN/wmLz1gzxTBd9Fqfl3b79xRwz9RYQkXDw9lRuX6cdbN9jIazGFso
         1gwKcqzFXBtLYParwJGwQ6tVsa5Qq31eocKODxIsKBlMW3BEfFHc3cSs6VcKSc0LLUoA
         oKip20Cy0TdkSd7DSC6YzYgl4NV4eNnnB6u8O4mLmgBk6bzpALsuw4eW1fBB9S7ZgTbj
         lfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686601130; x=1689193130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNPo9gKXIL4FCpDh6KTWP9fJLG0HuZNVGLsd8ABIfyw=;
        b=h4O5LwWKtejq3Ank9UVgZ/c/N7P3kjxGYe7ZqJG/t/dXVDVN4cHJM7uI1qjToUZfio
         fcX6Aatqf58IweZpKrhT6FeviAJpQZCC7L3M5Ni666+9Qg3RdfTvDigG8+WVJC6c85B8
         5onQAOr6XqVgfwnUyfxzNciKkGIqvG+PG8rtUafyn5xe56sUBZyUwCmMMBiALkgs+kaP
         kTcUr4Pikdc3sVnG2zbRPr1EriY6LImm74YmbpGovBoZktCmEKt9gdsaa/t9CDtHY0dL
         fw5T51qr3SIGSMX02tjoFX6P+KnZpBw8jwXvqScT9+ox/Ty6bcoqND3wFjU9K+UV0boX
         dG7A==
X-Gm-Message-State: AC+VfDz6Ppsz/6doPWygJeFU7nGKoifaTM59j4HNqmMzKacnYnQE1KeM
        8FMF/ZSMSIb+FO39+M+ytBxEALIa65rG2o8YfeWp7JH20oOYTxBg
X-Google-Smtp-Source: ACHHUZ5yU0OZsN8TFzvY057V31gV2r5pmNLk64HFq+soOXoy4thsX4Q65R2FsYpjpp4EOXPBhvs+7FKkfUVAQuyThD4=
X-Received: by 2002:a25:73c8:0:b0:ba1:d8a6:d2b2 with SMTP id
 o191-20020a2573c8000000b00ba1d8a6d2b2mr10199839ybc.7.1686601130523; Mon, 12
 Jun 2023 13:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230608194519.10665-1-s.shtylyov@omp.ru> <CAPDyKFqHXqs7rcJQgBzGh_k-9023vopjcxowMLaHsFd7TykS5w@mail.gmail.com>
 <c03bfce0-64b2-02b8-3679-85a682000c8e@omp.ru>
In-Reply-To: <c03bfce0-64b2-02b8-3679-85a682000c8e@omp.ru>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Jun 2023 22:18:14 +0200
Message-ID: <CAPDyKFokbAB6G6=3cEe0nVq8CD2jqbRStOhiJdkRSPjTX5tGfQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Fix deferred probing in the MMC/SD drivers
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 12 Jun 2023 at 21:48, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> On 6/12/23 5:16 PM, Ulf Hansson wrote:
> [...]
> >> Here are 12 patches against the 'fixes' branch of Ulf Hansson's 'mmc.git' repo.
> >> The affected MMC/SD drivers call platform_get_irq[_byname]() but override its
> >> result in case of error which prevents the deferred probing from working. Some
> >> of these patches logically depend on commit ce753ad1549c ("platform: finally
> >> disallow IRQ0 in platform_get_irq() and its ilk")...
> >
> > The above patch is available in v5.19. If someone wants any of the
> > patches in $subject series to be backported to an older kernel
> > version, the commit above needs backporting too.
>
>    Mmm... not quite correct: the abovementioned commit matters only when
> the IRQ check in the driver is changed from <= 0 to < 0 (there's an extra
> passage about IRQ0 at the end of the patch description).
>
> > Therefore I am adding the tag below for the series and leaving
> > anything that older to be managed separately.
> >
> > Cc: stable@vger.kernel.org # v5.19+
>
>    Please only add such tag where it is _actually_ needed. TIA!

Seems reasonable to me!

Perhaps it's best if you can resend the series with the correct stable
tags then, so I don't screw up?

Kind regards
Uffe
