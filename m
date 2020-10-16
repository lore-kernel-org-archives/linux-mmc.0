Return-Path: <SRS0=abg9=DX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EBFC43467
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Oct 2020 10:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C4D2084C
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Oct 2020 10:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQnevoKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395534AbgJPKyK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Oct 2020 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394145AbgJPKyE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2020 06:54:04 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E7BC061755
        for <linux-mmc@vger.kernel.org>; Fri, 16 Oct 2020 03:54:02 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id y10so524062vkl.5
        for <linux-mmc@vger.kernel.org>; Fri, 16 Oct 2020 03:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gX7X4zWON0bftlFn4XXnLtE0UHVfpOuxgLEkuD6BtH8=;
        b=dQnevoKfC82sMyf+qVuml7qjHoxc5TW0sfQ7sNI7/vcf7td84Nm8vc0D4qztkYvbjg
         D4QPcADffWm1vRbOYhu5GPyh7aNvwm/rC7m7f8sERjaUkTnVvJs+xGnxbOaz+LZ2apym
         do0c8boqX+VpXRCnVAtRmW+Qa/UvmHG7p7a+4rLJcAxRMLs62Xv+8W275WbmcAtmZuhe
         TIYuDTt/vtgtT2GymrLRh9Xjb7wmeVqB3IBkH8EHhzYC+LydEctuFGdrBoM/qUn4Ikti
         IVmi/XbUC4t9LMwnz9oPaVMBH0eeSghLb/4707vpTgnDsLheKJEBtvDkipVZiLuXpuTO
         xRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gX7X4zWON0bftlFn4XXnLtE0UHVfpOuxgLEkuD6BtH8=;
        b=L+Y3pR3pdlzTIbtP99HlgnukmJqV1cWONquXos5Sm3MqLtc5PwgZv5a0YPo57RxYak
         al7RnVuDEKVlSX8JGr750/QkAHkorx1b6bhiSvSnoB12GUeOAmHz2NG+lqkMN8j0y9cA
         T4OBvjJeAXzLq1wVY8nhIniNrGLjOB+9Bezud3zJasGSxKoBgYLFeaurjg1kqNTL/2zF
         oH4IqDZUGOC2KzBx513PSYaNe8mfYrIxFc+NBxDpZhZaaZtYOzduEy5zJq+/RaQBKLRp
         FPEasSqPS24br/Qqni6CqUUZIlM/clkcpm3AZYotrLGo2b7Nw4zsNhdaJscue2HQmQiV
         +SGQ==
X-Gm-Message-State: AOAM530zrVQvlaq/eaJdHjzXPlHcPbAbckAJ1FPHYjOXmgrbhx9+rjvY
        BeQyWAEHT5OVcuncFmg+poRLdGseeGM2dSt/pOq/rw==
X-Google-Smtp-Source: ABdhPJwRGOKSJtz3Xl/5ArDppme07QDTdwyCpTxliyHHyXa2VlbdoIaHwMP5skx9ZyNu3ZIs66hrCYviZQzcdzVjhV8=
X-Received: by 2002:ac5:c1ca:: with SMTP id g10mr1722731vkk.6.1602845641921;
 Fri, 16 Oct 2020 03:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201015231149.9333-1-michael@walle.cc>
In-Reply-To: <20201015231149.9333-1-michael@walle.cc>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Oct 2020 12:53:25 +0200
Message-ID: <CAPDyKFoMmsYhwvNDdprtWiY+EMjXQx5uFvn4+fHmCG8zj6aryQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: set timeout to max before tuning
To:     Michael Walle <michael@walle.cc>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 16 Oct 2020 at 01:12, Michael Walle <michael@walle.cc> wrote:
>
> On rare occations there is the following error:
>
>   mmc0: Tuning timeout, falling back to fixed sampling clock
>
> There are SD cards which takes a significant longer time to reply to the
> first CMD19 command. The eSDHC takes the data timeout value into account
> during the tuning period. The SDHCI core doesn't explicitly set this
> timeout for the tuning procedure. Thus on the slow cards, there might be
> a spurious "Buffer Read Ready" interrupt, which in turn triggers a wrong
> sequence of events. In the end this will lead to an unsuccessful tuning
> procedure and to the above error.
>
> To workaround this, set the timeout to the maximum value (which is the
> best we can do) and the SDHCI core will take care of the proper timeout
> handling.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Sound like this should be tagged for stable, right?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 0b45eff6fed4..baf7801a1804 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1052,6 +1052,17 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         esdhc_tuning_block_enable(host, true);
>
> +       /*
> +        * The eSDHC controller takes the data timeout value into account
> +        * during tuning. If the SD card is too slow sending the response, the
> +        * timer will expire and a "Buffer Read Ready" interrupt without data
> +        * is triggered. This leads to tuning errors.
> +        *
> +        * Just set the timeout to the maximum value because the core will
> +        * already take care of it in sdhci_send_tuning().
> +        */
> +       sdhci_writeb(host, 0xe, SDHCI_TIMEOUT_CONTROL);
> +
>         hs400_tuning = host->flags & SDHCI_HS400_TUNING;
>
>         do {
> --
> 2.20.1
>
