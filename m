Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA36FC433DB
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Feb 2021 09:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F6C64FB9
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Feb 2021 09:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhBEJ45 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhBEJyw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Feb 2021 04:54:52 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F7FC061786
        for <linux-mmc@vger.kernel.org>; Fri,  5 Feb 2021 01:54:12 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id x201so3292093vsc.0
        for <linux-mmc@vger.kernel.org>; Fri, 05 Feb 2021 01:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOysVJ3sc7xfuiW0Rozz11xFIhIOvQEqlfXvKMKI1kE=;
        b=smBQR3aBgWeBFd64gORBzsMxGKt7oPm7N0W0lZQlaRziRjATBtYwrMi4/E0Qs07PXp
         pRtTueio2f/poVlGW0iLrG2KfQSMoZduWof1OBkTkuoacHgiZkpWPPpzNNGACzJKM7kJ
         2ZtZ5jq3Z85Kwm8xNHoIEiBnLMrHQXV99vvXQDxkfd/y9miXo2kAtQlCgLOuB5qiS2+K
         pV3RuotkRfyv6rRQf9xXg76BJDmTdnjgx/RHjjx3KyJpEYer7b6QZs3qSfVU5L+zo5xu
         Lg9GlEXQ9+hjcC3T7haTH/wa1MHYcAXA9dLT6wf0VT4mt2PzTDXlx1uoVkN8YoKVnQ50
         G6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOysVJ3sc7xfuiW0Rozz11xFIhIOvQEqlfXvKMKI1kE=;
        b=MkP2rpnNzTqMOGgwEMpF/IH02u6cK+mAcSQbSLg5S6QdB1XE/neXGyeUfuVPch7ZxT
         2dM9Uddh6pVMjIChRxBoLViXq8Yvf959xuNLihMYeepHxK8LjJrairEJgaWIUWy9gY9F
         7MqOyvxK3psQ6ww0NMUvYiZisX4hRvyiRlJ4fJac8Yn9c9wtzpTLWKzGCCgJzMZPYlkX
         IPUsFkSuSzvPvrKY9aic8ijQVembNaO+hWtgWsfXx9kie0xzRCt/b31WFTW6Vdc0llF3
         BKbgP8YLIE1nDgNMo3QnWWBttV4cmqaYgTfnzORckfgbFLNtUSFH8tMYODhGoN5OisBZ
         mJlA==
X-Gm-Message-State: AOAM53103HY4A59KcuZb0DyvaZI83DyQTN/lnBUnVHmX+06QjKksDoBH
        0SaF3QpROEWdXGXnxtcl/SfBXJmbkPt8Aneg1rNZ/g==
X-Google-Smtp-Source: ABdhPJxDXLpo/rd6h4QfQjHmOl/racHSh6PBUgr50UsoEIi71tGvlqB8NUlEGXf78G0883FCvc7XKzBeh9BryR0cKaI=
X-Received: by 2002:a67:7d54:: with SMTP id y81mr2778856vsc.42.1612518851229;
 Fri, 05 Feb 2021 01:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20210204120547.15381-1-yann.gautier@foss.st.com> <20210204120547.15381-2-yann.gautier@foss.st.com>
In-Reply-To: <20210204120547.15381-2-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 5 Feb 2021 10:53:34 +0100
Message-ID: <CAPDyKFqdtK33HSW_AM0s9172V=cBM6wnKuHubXSOGCVqJ8nzFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mmci: enable MMC_CAP_NEED_RSP_BUSY
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        ludovic.barre@foss.st.com,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

- trimmed cc-list

On Thu, 4 Feb 2021 at 13:08, <yann.gautier@foss.st.com> wrote:
>
> From: Yann Gautier <yann.gautier@foss.st.com>
>
> To properly manage commands awaiting R1B responses, the capability
> MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for variants that
> manage busy detection.
> This R1B management needs both the flags MMC_CAP_NEED_RSP_BUSY and
> MMC_CAP_WAIT_WHILE_BUSY to be enabled together.

Would it be possible for you to share a little bit more about the
problem? Like under what circumstances does things screw up?

Is the issue only occurring when the cmd->busy_timeout becomes larger
than host->max_busy_timeout. Or even in other cases?

>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
>  drivers/mmc/host/mmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 1bc674577ff9..bf6971fdd1a6 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2148,7 +2148,7 @@ static int mmci_probe(struct amba_device *dev,
>                 if (variant->busy_dpsm_flag)
>                         mmci_write_datactrlreg(host,
>                                                host->variant->busy_dpsm_flag);
> -               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;

This isn't correct as the ux500 (and likely also other legacy
variants) don't need this. I have tried it in the past and it works
fine for ux500 without MMC_CAP_NEED_RSP_BUSY.

The difference is rather that the busy detection for stm32 variants
needs a corresponding HW busy timeout to be set (its
variant->busy_timeout flag is set). Perhaps we can use that
information instead?

Note that, MMC_CAP_NEED_RSP_BUSY, means that cmd->busy_timeout will
not be set by the core for erase commands, CMD5 and CMD6.

By looking at the code in mmci_start_command(), it looks like we will
default to a timeout of 10s, when cmd->busy_timeout isn't set. At
least for some erase requests, that won't be sufficient. Would it be
possible to disable the HW busy timeout in some way - and maybe use a
software timeout instead? Maybe I already asked Ludovic about this?
:-)

BTW, did you check that the MMCIDATATIMER does get the correct value
set for the timer in mmci_start_command() and if
host->max_busy_timeout gets correctly set in
mmci_set_max_busy_timeout()?

[...]

Kind regards
Uffe
