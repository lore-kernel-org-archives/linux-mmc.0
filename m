Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE10C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 12:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86EB32256F
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 12:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbhAOMWr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jan 2021 07:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbhAOMWr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2021 07:22:47 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ADDC061757
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 04:22:07 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id o19so4901847vsn.3
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 04:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijanfrn4HLw1PV8yIpNMyzh/KD5ZhkMn64d56nCsjBU=;
        b=JgKxbMbDioWMyFHUcV68hsic40sJTbdKoY7BEmbhxBmQBHLBd7SzM5wsBHjg4NqsJ2
         Mq8g6mfkt2x71G2p2Mly+o7iQ2b3gYRJQizYcprqsgBf1kRpMToSRHAoVm3f6LVSJTyc
         FIJMnhKH/vLuzPxSdhDmXlWgAc0X82zIEjdwgkmUIlUxT+rhyfImd8fwPonVCS6bo7QV
         buApqO2pP2LYgEBTvniGIKDe8qGcCCEApj+AH/wqoDvrm/CNMP2A3P1tQoUH0KnJLRF7
         O2eANLo2GaVifyDffWHDnFnG2QU4qXiqrvt4ta/q7UqVHg8PNdmgk6euUycCNE7J7Umn
         cJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijanfrn4HLw1PV8yIpNMyzh/KD5ZhkMn64d56nCsjBU=;
        b=oXwgixpIh0CrSjvqH/L3SPDQb3H4Uodmt1dFcTbRdFJjq023M4SfKqSL3y9FR0Jtbd
         DdyiFuo7+vP3knEl/g0Iajc4UIQGOyqhD7sjvdEMc322eA5lPjFexzOHKey/NHxxVoZu
         EZxW/s48qpGimqv78Xey6gmHCLQ2Yab3huBLXMNZe1OtHegt36v4M9xsP7BCarvIoa7i
         B/rWFg01rAYT5InM35b2mc84BJYBBsZFAnPWu5ss6d3uJEU2rf9IVyZMHMTuYYVCCS1g
         SAC+TgDcCBF8GoBjD+qqtxSPBG07u1MhehlWrl1dZizInBfTst2agvTzWlkCVberhq0Z
         03fQ==
X-Gm-Message-State: AOAM531WQRzZlHvRpRQPbN57ZPdqr3jHMJQp55CX54fZUmJgqixLxWQa
        8OOV+srX0tV5mfnYGBfoEOzfD0EY1K48ZTTrB+kgew==
X-Google-Smtp-Source: ABdhPJxZee1q+Q7m5ohCnrJrjHnRacfhERV6puh7GFyYNM9ZYLU99195TutCaKwpIZcRuOUlWeH3RD8uHZgAwqF2lZo=
X-Received: by 2002:a67:facb:: with SMTP id g11mr2932291vsq.19.1610713326101;
 Fri, 15 Jan 2021 04:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20210115034506.646-1-zbestahu@gmail.com>
In-Reply-To: <20210115034506.646-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Jan 2021 13:21:29 +0100
Message-ID: <CAPDyKFpn9zCdiKzkEaO+uVeEmmc_G5o2O4Za+wLijLpdXueRDg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: remove redundant card null check to mmc_can_sleep()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Jan 2021 at 04:46, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> Note that only _mmc_suspend() will call mmc_can_sleep(). And card is
> checked before in mmc_can_poweroff_notify().
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index ff3063c..49e5487 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1899,7 +1899,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>
>  static int mmc_can_sleep(struct mmc_card *card)
>  {
> -       return (card && card->ext_csd.rev >= 3);
> +       return card->ext_csd.rev >= 3;
>  }
>
>  static int mmc_sleep(struct mmc_host *host)
> --
> 1.9.1
>
