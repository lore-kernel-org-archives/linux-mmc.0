Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCFEC11F6A
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Jun 2021 15:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B0361DD9
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Jun 2021 15:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhF2PMU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Jun 2021 11:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbhF2PMO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jun 2021 11:12:14 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85963C0617AD
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 08:09:47 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id k140so1782174vkk.6
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MUGKjtNRcx2eQ6IHM1cr+oQJwylnW07251DtlqM0fc=;
        b=ysiCYap2U1/6EUncE0LGKvkF+rVElDPWfP7kwvHTtlqpQsCBb8TnwjtT03+OXA4rdg
         CKEuBvoV5RgZEjdemSMQIfcjU8terlcsNOCsrgWxSSahvBe/FJ/78odEEEupr325YG7+
         JcTtm58U+qczxurz6XvxSlKj6RifeVZkvpznoZTvlr22yh8zmbwMciM8rha0ZxCCBV1N
         YsQ/OXycYoBidXcrfrw/pkrKQkG8A5N3Pnpp88IcjEoC6YDtHWowOEgapRMnA9D6G2vc
         TRBPOh5oTYBx/Jbr6G5ajFvuhtFUZsW2d+O2Op4M/sNFYM8CWFXBVX/Mzc6HH85xMJ83
         7m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MUGKjtNRcx2eQ6IHM1cr+oQJwylnW07251DtlqM0fc=;
        b=RUNiKXpCz4gVOuXuD5MjZRnJ8d6R50MaaRTiGov2OqYyQe4EUeGROhC4dvYqFZ6rOC
         /dww8oqLdYGu8rgH6Rwsy2/ZvbJc3JpSez+/Ny/03Bngu9moeOB31tfZQlIaG5xNbMa9
         kHNB62Irj3d3HsVZVILess6ylDKmPP/VV5wN5r6ZcZFVOoj4hD6KFWIMBEuiihb9BXuQ
         pFiso3PJwNF4Ph7A5kqndyUoqzDxyy1Wbb+046f1wl+3tV/3wgk5MjkeB8t2PF8EOqqz
         fJjYyYmUYT9209bpiFoaMQLDJ4u2OG23SAFRvBd/+lTTYh4V/piTAz7pg/fty6eqjsKg
         5dbA==
X-Gm-Message-State: AOAM530idLe3RRR2j3CPDNn0YEXuFzX65p7QqSGEYrnIXUVtbV7NT2pC
        dfhuJjTZbYoht4oyNohkNNbtqtKDlP00t1acbIrNg6/e3NlDIA==
X-Google-Smtp-Source: ABdhPJxkLDJljK6CEHzij6Q39AgIRzFKnDf086DJILJcwdTSvxxoJmp/lL5dchVFlRfR9xnsEdcdlv1TGj0AZ2ZBdv0=
X-Received: by 2002:a1f:960a:: with SMTP id y10mr22482299vkd.8.1624979386744;
 Tue, 29 Jun 2021 08:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210623095734.3046-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210623095734.3046-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Jun 2021 17:09:10 +0200
Message-ID: <CAPDyKFqM5_Xd3KPG7kO_Hqg4=i2cNg6nZqMNcDKZk4eSzBchRA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: use proper DMAENGINE API for termination
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Jun 2021 at 11:57, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> dmaengine_terminate_all() is deprecated in favor of explicitly saying if
> it should be sync or async. Update the drivers I audited.
>
>
> Wolfram Sang (3):
>   mmc: renesas_sdhi_sys_dmac: : use proper DMAENGINE API for termination
>   mmc: sh_mmcif: : use proper DMAENGINE API for termination
>   mmc: usdhi6rol0: : use proper DMAENGINE API for termination
>
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 4 ++--
>  drivers/mmc/host/sh_mmcif.c              | 4 ++--
>  drivers/mmc/host/usdhi6rol0.c            | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>

Queued up for v5.15 (temporary on the devel branch), thanks!

Kind regards
Uffe
