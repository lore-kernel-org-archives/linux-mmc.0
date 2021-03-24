Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD744C433E2
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 10:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90852619F7
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 10:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhCXKVy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Mar 2021 06:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhCXKVd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Mar 2021 06:21:33 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC480C061763
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 03:21:32 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id r8so3760515ual.9
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XayKDtDXvEdZGrqBW/sK+ORClel9QKflJZq6BfD6cBg=;
        b=kAjKT4pTY2Ero8J9KCorkvqiLZ95Qx/0dVfmPKOxxlyA28iZj7mOHrCbUj26zrZMF7
         9MFjrZrumcd+zNxom+Xr+WxAKVlSlcTL9dcTm+Ia3T6UXTREj+SIH1HHUuF9P2usm5kU
         MHN8woxvLBXA+2XsVIorN8IZYTpNzgIy+sXUgou+chLUk25PCEtQdVUDgGmh/LzwCV5O
         tEGOiLA/UgFK41ZbNNgil2dWurbbrplt3KnxfUrv4xhYiPUVJ5o99IwJLDclj22IUF+t
         cWLPiewLbOEWT+V2B3zt0zRaSQgkm6euDgR5639QxP//ULeTUWt3cdrrsLNPE6GWxbAy
         bcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XayKDtDXvEdZGrqBW/sK+ORClel9QKflJZq6BfD6cBg=;
        b=E3/vMyodZW3+ijiohXvqQyFMG1CSpiFFZUK2mDBX17vaW4OJJE4R3cMSO61A2XBVDI
         I6oxEVWvkB28J48Dutmwwowpwoxzhs09pfxIMwpU6duoe4lO2s/SxL7SKYNwqhqO/Y5n
         YJo9HjjmMNsq/zHR2prYr7f3lq8Cvd9EpfSdMrhWfGCbhVTfc3ZRPkTA6g6UcHNG9jPC
         JiY5ljZa+BSgKwDW4KoIJPamrmDtNUKGQA7V8WuGJkjJfxtyfCd8bJgGcmOZwWZHcBK1
         /LldfYNwvdjFTcNX1p1ak09LMGXMeFGeRXaIr0WJouXwrOaAfDeul/za0ON/xRTnfHXE
         GD1Q==
X-Gm-Message-State: AOAM532HdJ0bynFQhfpEBOaLSv/Fe9Z9M8Af8h0GRYMqyC4p85K7qPdq
        BA3tWHriLx4VJzb5p/CRcTnv6SKt9W9FPgIaNTW9nA==
X-Google-Smtp-Source: ABdhPJwk9yHrwv+ZZuTWISnejtACKpGQ13OwcJr6v4U57ofjuB/FM3rDMW4Ipolc5KG3Z/RmNvjkyNEvYW9C7Yaew3Q=
X-Received: by 2002:ab0:7a68:: with SMTP id c8mr982878uat.104.1616581292200;
 Wed, 24 Mar 2021 03:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210324154703.69f97fde@xhacker.debian>
In-Reply-To: <20210324154703.69f97fde@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Mar 2021 11:20:55 +0100
Message-ID: <CAPDyKFrxJvDgNQ4V33YzhCf_7i0owffAKHxUZN0y8AuC6pA4Gw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: set MMC_CAP_WAIT_WHILE_BUSY
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 24 Mar 2021 at 08:47, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> The host supports HW busy detection of the device busy signaling over
> dat0 line. Set MMC_CAP_wAIT_WHILE_BUSY host capability.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 06873686d5e9..b6ceb1b92b3f 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -393,6 +393,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>                         goto err_clk;
>         }
>
> +       host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +
>         err = sdhci_add_host(host);
>         if (err)
>                 goto err_clk;
> --
> 2.31.0
>
