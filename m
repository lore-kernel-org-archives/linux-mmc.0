Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF8DEB64D0
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 14:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242512AbjFMO02 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242909AbjFMO01 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 10:26:27 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B126C10DF
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 07:26:24 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-56d047c92a8so35375017b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686666384; x=1689258384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7YsOURhyh/Tjgm6K44C4j1/BOMFErPA6rkAL2pqMH/M=;
        b=dO0jZ8gXTo3yU8ybfY7BIiWEeernqFV8gOIXG3ZOxjQ1er0RIEpHc3LsnEPgowgnS5
         ZQ7n/TqSP83laRH1ib2ddCSl+1L6MiGjKzz65UZw3rgSK92kMQpprHmW80AhNmy1vXrF
         bwRwMc8sWyrbocp1FypKwm+w6TaSPAL8TPu7Wmpg/cbC1qePDjNIpqaDD5+UUt10Ja1O
         s8vRYbGo1Q/joUhvxd9R1Q6QOURnUHDDxFHQvTWqBw9x5tRaxr5BXOl14MRGouVerl/D
         f6ImA7glXvoaimnPCrII9WSbykE2vU6wOLFq/eRW6RDckbqyybYfFrvgj/NJH5yNIK7g
         M8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666384; x=1689258384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YsOURhyh/Tjgm6K44C4j1/BOMFErPA6rkAL2pqMH/M=;
        b=JMNnjZXoPh/kNMkBiQ/vGIiyrot/cFDyQY2BSUzuTkk2IsThENsupjKBzJAPIMw+Qv
         Z5f+1ClTfz0ERhtA2BowF7/gXo91uFHygapAszNmTVZwOSZGELEH8g+Oz/eLB5305FtT
         EZbVTf7ZYksO20qncG3PKsfgBDLknGmKvJH1XUzsU7Wx8c7VzzTI7cC661VurQZLZy85
         8K9Bxe+CFFOXXGY4VxWmSNeBJmK7Q1XcNEmmBMqiuKse60vH5uELPYsjlPDi0+GMOmFp
         Xi4uIu0ugZl7PvG+qC5Nxs+pHpa9lJpRj/hoMonfsjc9VqQa5FSzZ/aHixtl6RymIOKu
         GbBA==
X-Gm-Message-State: AC+VfDyWN5Yg6Ah4aMNR1v78AaR/H0XyV4/xBMPZRFWJ4BrggTfWvwbr
        AraiBZka26U/4mLyWlnm89URz9ZD1JgFnR8xt9JYXwCzK6ifTx0/
X-Google-Smtp-Source: ACHHUZ4vISjM1jMiXDK60ZMB4vg3NrX7dHb5fNlJxtHrs7GejYR8ouJM9RCwhrzX4G4YpWdS5t3nffqYf7mk1SLWA9k=
X-Received: by 2002:a25:9085:0:b0:bcd:ba93:55b1 with SMTP id
 t5-20020a259085000000b00bcdba9355b1mr1658122ybl.43.1686666383783; Tue, 13 Jun
 2023 07:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230613134146.418016-1-yann.gautier@foss.st.com>
In-Reply-To: <20230613134146.418016-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 13 Jun 2023 16:25:47 +0200
Message-ID: <CAPDyKFrN1Dau5eCjhK9h193ZtKrzTHFndG4WR9jCheEVhdfa8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: fix max busy timeout calculation
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dennis Zhou <dennis@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 13 Jun 2023 at 15:42, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> From: Christophe Kerello <christophe.kerello@foss.st.com>
>
> The way that the timeout is currently calculated could lead to a u64
> timeout value in mmci_start_command(). This value is then cast in a u32
> register that leads to mmc erase failed issue with some SD cards.
>
> Fixes: 8266c585f489 ("mmc: mmci: add hardware busy timeout feature")
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index f2b2e8b0574e8..696cbef3ff7de 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1735,7 +1735,8 @@ static void mmci_set_max_busy_timeout(struct mmc_host *mmc)
>                 return;
>
>         if (host->variant->busy_timeout && mmc->actual_clock)
> -               max_busy_timeout = ~0UL / (mmc->actual_clock / MSEC_PER_SEC);
> +               max_busy_timeout = U32_MAX / DIV_ROUND_UP(mmc->actual_clock,
> +                                                         MSEC_PER_SEC);
>
>         mmc->max_busy_timeout = max_busy_timeout;
>  }
> --
> 2.25.1
>
