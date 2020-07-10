Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E930AC433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 07:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C743A206A5
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 07:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0F2RZ5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgGJHkI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgGJHkH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 03:40:07 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536D2C08C5DD
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2020 00:40:07 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id v26so1033571vkn.2
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2020 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbS7NrT88QQtzei4LIhV4jR15fEzmmczH+EWwTkx0Gc=;
        b=S0F2RZ5t6lwxkw0gw10S2nKQUqUR0kxq+ZFgzWnIqbArWFmnoTIFp2hoE/n9I7TMky
         UYZxYZK76jZwCpPuHolcsFVyPUMHA/+MlyQc3nc9K49PXc1HHJRP2te9zTe7Qx9ZOYXq
         JYZ5feuoHQe7fDKQWVsCTR6dfMeyB+3XY1zkE4ZO72ud1Amar4cIJdogSEFH61EhsRhS
         jUAPqyFz2z0LpzxYyhj+RqU8Luqkw8U373G+XHNw+qKcPlIynK/QTWK3Leeuyfx9nirz
         LsOQU4T9vHmstut2VpQ7BIlLmnsDqTQWC2SnM/4ThTrMvOkcceh/YR6rpBwyTAT5DSlu
         xetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbS7NrT88QQtzei4LIhV4jR15fEzmmczH+EWwTkx0Gc=;
        b=oyRWZbwVVNhzGEBoyF0C1y1B0XlXi9YZiEpsXxwBHFiteQBOnTx6k2gfe8uv8SsFbM
         Hvp/Ylpcm9odWWOTBkcSMXIQJtqj5JT59H1NjFilv3qMLlkmphYOPs3lAueRo6Op+2rb
         gKMMOdT4LY4RMZOB6HedeY+kdjaQ0TeiGO3bhqJRFFDhILQnrsOwnpES7Ufudd6aC/Qe
         jUfmgr8vcYLaI9SXfoO5nCUUrP9HkG4rROzi6+Y9yqQc0hq8/JaIERcFD9BkH+W3Z5x3
         BIHyUvGM0dKo4oxpystJRc/tMhdp2EfOyJypRT3oD+CKaU2miDwxst7CIbJqRSrlybbV
         XySg==
X-Gm-Message-State: AOAM530d4sph993jYtPpavyMLLl7XMsc2F3BY42/i1r2hoDIguFm4DXg
        K/6/tlfK53yvJLUyZZfMdMj/o1+KaP12pw6raumRxA==
X-Google-Smtp-Source: ABdhPJyxAUZLBoe1qaidLdrmiJXsBccoWfh2LWUPQHC4jzlNh6ot1/AAIwVeQsFJQhWrdqZv9UO9vOxkLYbd7WLwQd4=
X-Received: by 2002:a1f:3f0f:: with SMTP id m15mr49715254vka.53.1594366806470;
 Fri, 10 Jul 2020 00:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200709195706.12741-1-eajames@linux.ibm.com> <20200709195706.12741-3-eajames@linux.ibm.com>
In-Reply-To: <20200709195706.12741-3-eajames@linux.ibm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Jul 2020 09:39:30 +0200
Message-ID: <CAPDyKFozpWKt=L_hMh4ymhJ1X+TSK0vUQ5E0vy7j9EowTRywxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-aspeed: Fix clock divider calculation
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 9 Jul 2020 at 21:57, Eddie James <eajames@linux.ibm.com> wrote:
>
> When calculating the clock divider, start dividing at 2 instead of 1.
> The divider is divided by two at the end of the calculation, so starting
> at 1 may result in a divider of 0, which shouldn't happen.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Looks like I can pick this for fixes, as a standalone fix without patch1? No?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 56912e30c47e..a1bcc0f4ba9e 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -68,7 +68,7 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (WARN_ON(clock > host->max_clk))
>                 clock = host->max_clk;
>
> -       for (div = 1; div < 256; div *= 2) {
> +       for (div = 2; div < 256; div *= 2) {
>                 if ((parent / div) <= clock)
>                         break;
>         }
> --
> 2.24.0
>
