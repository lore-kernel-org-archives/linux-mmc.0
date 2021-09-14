Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194A1C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 11:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F161D610FB
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 11:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhINLZv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Sep 2021 07:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhINLZr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Sep 2021 07:25:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E7CC061762
        for <linux-mmc@vger.kernel.org>; Tue, 14 Sep 2021 04:24:29 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s3so23129991ljp.11
        for <linux-mmc@vger.kernel.org>; Tue, 14 Sep 2021 04:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbHbzsUVfwaldp004hJ4jjr5J84FzOR0csevjsInRbE=;
        b=gLP0H+ry/SWAhT5BEiNh1FWXkOJbfVobpcuxBz39q4wP3oRce/LNh+VmwVoWCqssQa
         DiOZkRFt7gDlzMI/yco3aBYtGhFSX1cKB869NkY62py7W8IQ0eAOKtx0qf7D3nyokqZw
         Mo2tVd3rZrv22beSeWrOi76EEZn3lmeJB39Gq71SH+R7iOCMOhtXfa2yrga2lFAzeuAa
         cGOmCslsZKpFJzKih/XTy8fqctLPGdePabFqlF2QsGVYf51tLhNuKwGjZ2KKvwgm2rAf
         dGN2hioI6JVRqzjHIEivSFlpgClaAT0Nveve8xlKK3unRIZ9QOzawKPhEi11YtsLIgn6
         12Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbHbzsUVfwaldp004hJ4jjr5J84FzOR0csevjsInRbE=;
        b=0lMUei4yJEiC9JZ7VsAH8SXZUoJBZSwTR4CPvKTvIYOQ8EgQM2SWCKjlkHkG8SNQ1Q
         BLNF/fSUfrnTmQ7af1rUQ9VhgRpPpMRHLAroRYYx1Qk6LFDdv37rtOTz5kjYFGczVnDZ
         An1HsCHBC5+YVcaEl7z+6efgrlPx7ro/AaMXL8hRZhJSKwthxTHs3ihE593zL4VJh2ND
         FS8F01SNQkU53fvuBScKQEXtLufGpLzbHPFga5Cd5iio+EfpiRsxyyOZZGlMRMKRCVJE
         NaEiJsE1Wu06VMFpVj3oAj6NbDC7p9JCJqcjlRvVD3WL/a6+4PGGLc6eE2nIEd+ZWZYU
         y8xQ==
X-Gm-Message-State: AOAM5313OfBlhatGeav37PLEPdX+REKoDdt9Uz0RI4KeLGNtfN3At134
        VjUQCQcCcoCdobx9Rp9zwU1YhsRljl6GuqsWa/gz3Q==
X-Google-Smtp-Source: ABdhPJxaKAD0c0v3CBN1um+VYpA7r68/YPXn+ub5FydWZVfWWKtI+1+mvXOkDL2WdBRkUWSYEOb/Mh4tFJYHh50dXAk=
X-Received: by 2002:a05:651c:1b3:: with SMTP id c19mr15103309ljn.16.1631618668074;
 Tue, 14 Sep 2021 04:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210907151204.118861-1-huobean@gmail.com> <20210907151204.118861-2-huobean@gmail.com>
In-Reply-To: <20210907151204.118861-2-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Sep 2021 13:23:52 +0200
Message-ID: <CAPDyKFrTDc2VnKffTiHx9A7CRsgQq8FZCj8U3+8xaVtQCPAkyQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: cqhci: Print out qcnt in case of timeout
To:     Bean Huo <huobean@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 7 Sept 2021 at 17:12, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Print task count that has not been completed, this is for the
> purpose of debugging.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index 38559a956330..ca8329d55f43 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -899,8 +899,8 @@ static bool cqhci_timeout(struct mmc_host *mmc, struct mmc_request *mrq,
>         spin_unlock_irqrestore(&cq_host->lock, flags);
>
>         if (timed_out) {
> -               pr_err("%s: cqhci: timeout for tag %d\n",
> -                      mmc_hostname(mmc), tag);
> +               pr_err("%s: cqhci: timeout for tag %d, qcnt %d\n",
> +                      mmc_hostname(mmc), tag, cq_host->qcnt);
>                 cqhci_dumpregs(cq_host);
>         }
>
> --
> 2.25.1
>
