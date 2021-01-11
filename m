Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693C6C43332
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 18:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7C322CBE
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 18:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbhAKSHo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jan 2021 13:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389299AbhAKSHo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jan 2021 13:07:44 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF0C0617B1
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2021 10:06:49 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id a31so116894uae.11
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2021 10:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWiH05HuaGWdRbA9U5L//orrI8G7vM7uoQMJxI3AypY=;
        b=UYbp94mGeQYkBROkU3bvrAvpFFf4nVlbW5Vhlat17xqFjsNegXtz30bz3EI9akwZmg
         qZs7MPAYdHs7UmBcBbJStXA9ahnnX88PLO62wS0rXjaWrbbtZUy8uht8h8Ukjq7SR80T
         D5BCnKGKZ4Ewf/GlqkOpdlHEecDqwFG6MkKZfAnM+DZfgDe6b1B9bFwMEXYfFeZ4xPYw
         4aaQ9hohj0w16piLZryWdDnnifPJ1uqeRDPWjdOES2tAFaGVZnSCTuMCPitzxu5LmHlU
         Y1sP0qBdAwNWKaGm22sif3vwaHmpl61avubzrlqLaHRFW288o9RHh4Klag5TnR2rLTGK
         8XCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWiH05HuaGWdRbA9U5L//orrI8G7vM7uoQMJxI3AypY=;
        b=kpsbPUcXfU5hpuEzzjQ2+q96p5WRlMf4B3c8R8xTcdpDl+0tIoWd0OJ5R1d8l0PM/a
         WdrxGkYBxo5oq9avt5bORjw4elJSFxC3I8qay6mZ0m80oDRW37k8dZ41dUGpfO4nJ+zf
         9V6B/yAwTppfva4HGo1FfkRzmoIBf6CwU2keYxvGKNwkTqUvJ8HZpw6FwoEQomDj29nQ
         OJE1JPHQWotd3a/e+71rTYgOzgqPWFn84/O/jecP2EoMMAqc5sqO5rJbD499wyaoJHQ9
         E8dopjxRn4oeSfI/AaJH6PAc8VQkLR5CI3evkd8G/xEUSiIFT5zSGadZfjESPSKNx1Mw
         lkXg==
X-Gm-Message-State: AOAM530JuVoqnG4RX3uZa619l2DgFdGzEWBB9xP+Q/0TG1oWESL2c6WO
        WK1hPdf5FjlzfY1HFkqiuUcnH/uLGvVlk3Lknln2lQ==
X-Google-Smtp-Source: ABdhPJy6k5BPXea4aijRSzb9FWxF8qw7DLALO/1gvHOZKC29+FYABLx5yMtCIB55CBVS1dmY1otNdJYl8fuFMcHN8wM=
X-Received: by 2002:a9f:204e:: with SMTP id 72mr659337uam.19.1610388408471;
 Mon, 11 Jan 2021 10:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20201229161625.38255233@xhacker.debian>
In-Reply-To: <20201229161625.38255233@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Jan 2021 19:06:05 +0100
Message-ID: <CAPDyKFqWMFpe=y5dO1pguTFnffDTp-b_9yF=+Ev5PhDbYSKUMA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: fix rpmb access
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 29 Dec 2020 at 09:19, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> Commit a44f7cb93732 ("mmc: core: use mrq->sbc when sending CMD23 for
> RPMB") began to use ACMD23 for RPMB if the host supports ACMD23. In
> RPMB ACM23 case, we need to set bit 31 to CMD23 argument, otherwise
> RPMB write operation will return general fail.
>
> However, no matter V4 is enabled or not, the dwcmshc's ARGUMENT2
> register is 32-bit block count register which doesn't support stuff
> bits of CMD23 argument. So let's handle this specific ACMD23 case.
>
> From another side, this patch also prepare for future v4 enabling
> for dwcmshc, because from the 4.10 spec, the ARGUMENT2 register is
> redefined as 32bit block count which doesn't support stuff bits of
> CMD23 argument.
>
> Fixes: a44f7cb93732 ("mmc: core: use mrq->sbc when sending CMD23 for RPMB")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 4b673792b5a4..d90020ed3622 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -16,6 +16,8 @@
>
>  #include "sdhci-pltfm.h"
>
> +#define SDHCI_DWCMSHC_ARG2_STUFF       GENMASK(31, 16)
> +
>  /* DWCMSHC specific Mode Select value */
>  #define DWCMSHC_CTRL_HS400             0x7
>
> @@ -49,6 +51,29 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
>         sdhci_adma_write_desc(host, desc, addr, len, cmd);
>  }
>
> +static void dwcmshc_check_auto_cmd23(struct mmc_host *mmc,
> +                                    struct mmc_request *mrq)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       /*
> +        * No matter V4 is enabled or not, ARGUMENT2 register is 32-bit
> +        * block count register which doesn't support stuff bits of
> +        * CMD23 argument on dwcmsch host controller.
> +        */
> +       if (mrq->sbc && (mrq->sbc->arg & SDHCI_DWCMSHC_ARG2_STUFF))
> +               host->flags &= ~SDHCI_AUTO_CMD23;
> +       else
> +               host->flags |= SDHCI_AUTO_CMD23;
> +}
> +
> +static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       dwcmshc_check_auto_cmd23(mmc, mrq);
> +
> +       sdhci_request(mmc, mrq);
> +}
> +
>  static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
>                                       unsigned int timing)
>  {
> @@ -133,6 +158,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>
>         sdhci_get_of_property(pdev);
>
> +       host->mmc_host_ops.request = dwcmshc_request;
> +
>         err = sdhci_add_host(host);
>         if (err)
>                 goto err_clk;
> --
> 2.30.0.rc2
>
