Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A68AC432BE
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4AC61214
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbhHXO6X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbhHXO6V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:58:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA13C061764
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:37 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id c12so38232435ljr.5
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7T239jsLbsayF4aZWEjWJeLPMK9E8+LYFTW4JTLP0s=;
        b=ti+oB3vBOMMyqJa5uq/Hn58qVzWC8LgeR80juypKZJGX90tRhWFfEz+1y/aG8kAnXY
         7prtD6JiMEg3zy8ryNOBCE2r0EdM/PN757z8eqKKtlt377TSbSOxvWe76eqmrzU/sx/J
         sO3p3xoM/vzqiH+cnifvIvDpZl0E7Q4+kvc4oMf+QTfDPHa7ga0UbCHERdRylr5BPjVF
         gjHv33kVgKi3YEbZmywENx8um2oNstnU8rYh+lAaKVoiopo/4AvJ/3x8yA2bygAjLYoj
         pdfYGDL4WF4HOUhOpFkEVxdK0nS1G1fb7YL7GRfknZWX7U7wIEDy2MkhoLFBYWplqXai
         r6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7T239jsLbsayF4aZWEjWJeLPMK9E8+LYFTW4JTLP0s=;
        b=J35ui8t0yDcEKKrTi7fK1GHVC6yrkCWdSUIA4jKcthoZIoY+vzCcMMdX578MXGqU6Z
         04K/Z8Of+E4B9b4iSZVSmE/dlfM8qtTgKPnpiIB8kBLBk+adZP2vqWZeCgLxMzMGXCf5
         s6uYn2c5I8CxJ6EIgjEyLYo22o84Ldd+Kczogthj6UeWT2BTeRj1cmMwn4tv7M4BGnS2
         7s1y4OPBeLAzqnmriGnqLR+gec0szmQbsoWIIHSKrYz+zDc7c31uFb48zgWbeSsaV3hE
         L/c4ifcc6BoKncNr2pMLBw0xxrXtYIyHfbeQwGYLAJKvTr2zFqmXVwgOGy0VltXnwyU5
         4yYQ==
X-Gm-Message-State: AOAM532yNInmaFfn6Q9DoI6HPTefsVCAq3zuzhMQ/HCX2UBKh23YLOYc
        B1Tdj7CuBdDlTQLDPb7b9e87esQIUZdhxZdYozxFBw==
X-Google-Smtp-Source: ABdhPJzzIZQHBatfr+jqvETbFY5S5lhayAwi2jztkhIbN/273EBxLJcym9xRcPYkoS13Ey36043Cn/LDLk8X5lK4BEY=
X-Received: by 2002:a05:651c:83:: with SMTP id 3mr32649938ljq.341.1629817055638;
 Tue, 24 Aug 2021 07:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210817224208.153652-1-huobean@gmail.com> <20210817224208.153652-2-huobean@gmail.com>
In-Reply-To: <20210817224208.153652-2-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:58 +0200
Message-ID: <CAPDyKFrhXEA73pb1eiehFN=tqj9CqVj4jxRKVYRVnmVd4fxNvA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: core: Issue HPI in case the BKOPS timed out
To:     Bean Huo <huobean@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Aug 2021 at 00:42, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> If the BKOPS timed out, the card is probably still busy in the
> R1_STATE_PRG. Rather than let application in the userland continue
> to wait, let's try to abort it with a HPI command to get back into
> R1_STATE_TRAN.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next, thanks! I took the liberty of updating the commit
message a bit to clarify.

Kind regards
Uffe



> ---
>  drivers/mmc/core/mmc_ops.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 90d213a2203f..0c54858e89c0 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -959,8 +959,15 @@ void mmc_run_bkops(struct mmc_card *card)
>          */
>         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                          EXT_CSD_BKOPS_START, 1, MMC_BKOPS_TIMEOUT_MS);
> -       if (err)
> -               pr_warn("%s: Error %d starting bkops\n",
> +       /*
> +        * If the BKOPS timed out, the card is probably still busy in the
> +        * R1_STATE_PRG. Rather than continue to wait, let's try to abort
> +        * it with a HPI command to get back into R1_STATE_TRAN.
> +        */
> +       if (err == -ETIMEDOUT && !mmc_interrupt_hpi(card))
> +               pr_warn("%s: BKOPS aborted\n", mmc_hostname(card->host));
> +       else if (err)
> +               pr_warn("%s: Error %d running bkops\n",
>                         mmc_hostname(card->host), err);
>
>         mmc_retune_release(card->host);
> --
> 2.25.1
>
