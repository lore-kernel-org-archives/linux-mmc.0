Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD71FC4332F
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Nov 2022 20:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiKGUOG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiKGUNv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2022 15:13:51 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D12B612
        for <linux-mmc@vger.kernel.org>; Mon,  7 Nov 2022 12:13:46 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j12so12080776plj.5
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2022 12:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob3MMNiUC2vlW5lEHB7KfWXwdlr55fOWirRPwAMtLlI=;
        b=mlGnodq/OEZbV7bHtyxPxYmWDgdUOs8WRoE9x/YW0QLeANRLG/qo/pFHQlSwwXxQXv
         LwhdrGjnQ9ypjMoT2zJamcn2ES6KYdD0CB+rHnx9c0u8odxSm07xf8NHvm9ODGNFUO5i
         4dPGEiH7Y7E3Xp/d0G5J4JLFs3lhIr6Xo4qDtFwVdmBkjmxVrgueA9LjHYy1I1rlnnil
         fAJpqs6cJ9C9UVsq2+h7uWs4W8w1ctgcT6LQmsoyuTmmBXtZD2noiKWDNPj1G0B1WP8m
         zEPuoFPPiImF/OcItBQLY2FD2rUCywNHdwediEh5pf+9kTqACmwrxKN0VIHlypyLu0iR
         xWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ob3MMNiUC2vlW5lEHB7KfWXwdlr55fOWirRPwAMtLlI=;
        b=0VbYBYISRy/U4Ej0C7JB2FUKAzEcWXlxCJDr9Pi5PbkvmfCCb+YVig+ng9y4R4xLEa
         pbs2XRDO1rc/1WlrTc0HVmsS/+FXpWdX4ferP0ouVI/j1NQ0NxLCIygLnWd8TfVRMiOZ
         ePgOErArfG0t8zHyy9HfoQfw10smEajKcTLUjYqSA1EKLcMoDCYFl2sj5zgS7S19HpqM
         B/jtwi1hl0o58H+6RYaf+Gvi4k8aRmw2YqbAXg0WqD3LcRLG+XPoKsjzQhcz9O4kNjSU
         4w10ivvs9QV+ncxKRXRbdKXnIRZoz5XxGP375ZMZh3FBtiwEyS2IsqdO9IG0sUpTo7pK
         XFTw==
X-Gm-Message-State: ACrzQf2HaqqM67mpXlgzfeR1zfgkhk0UbIIPB0ZziMUWtER9m3LyP/tM
        /T3zXjGZ0Nm5nmqCc4Jy6/pvV2HAofNEFc+xDDVcWg==
X-Google-Smtp-Source: AMsMyM44GPAF7URc2P5pI5FosDeB5qAi3FX4SCryhfWo1VFrOXczM/69ZFl/9Nj3zliTUvqVfTPd8pjg/fYeEGfufQ0=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr71862866pjb.164.1667852025837; Mon, 07
 Nov 2022 12:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20221028155633.1.I6c4bfb31e88fad934e7360242cb662e01612c1bb@changeid>
In-Reply-To: <20221028155633.1.I6c4bfb31e88fad934e7360242cb662e01612c1bb@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:08 +0100
Message-ID: <CAPDyKFqd7+ozW3=mTFzDQDz-dX_Z62mJBs1N-wf636AWrgGmjA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Set PROBE_PREFER_ASYNCHRONOUS
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 29 Oct 2022 at 00:56, Brian Norris <briannorris@chromium.org> wrote:
>
> This driver often takes on the order of 10ms to start, but in some cases
> as much as 190ms. It shouldn't have many cross-device dependencies to
> race with, nor racy access to shared state with other drivers, so this
> should be a relatively low risk change. We've done similarly with a
> variety of other MMC host drivers already.
>
> This driver was pinpointed as part of a survey of top slowest initcalls
> (i.e., are built in, and probing synchronously) on a lab of ChromeOS
> systems.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 34ea1acbb3cc..0449630acbb3 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -2281,7 +2281,8 @@ static struct pci_driver sdhci_driver = {
>         .probe =        sdhci_pci_probe,
>         .remove =       sdhci_pci_remove,
>         .driver =       {
> -               .pm =   &sdhci_pci_pm_ops
> +               .pm =   &sdhci_pci_pm_ops,
> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>         },
>  };
>
> --
> 2.38.1.273.g43a17bfeac-goog
>
