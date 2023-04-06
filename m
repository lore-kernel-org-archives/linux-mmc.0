Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B29C76196
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Apr 2023 10:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbjDFKS4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Apr 2023 06:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbjDFKSz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Apr 2023 06:18:55 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AFD3C0B
        for <linux-mmc@vger.kernel.org>; Thu,  6 Apr 2023 03:18:53 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f188so27119789ybb.3
        for <linux-mmc@vger.kernel.org>; Thu, 06 Apr 2023 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680776332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pU74o8K5k/VR2MmyjAiwWF+BGAxTRRi712Y0xDR8RJg=;
        b=BuH5HiP2BOCjdEolw+aqgOB45v4qu9ln4+jP8/XNh9YR05aF6CkAGOwTdtGixL38Jt
         rURlmm5UUpGQgD2w/dnQAkVbiHy1BLaZB1r+TFYgXYZi7ICPsAlncw8/NdacvtQywarC
         H9YEGXsy2vbF63zs6jUxrvQW7U6ncCof8egc7YbjBStcQL1ncSckJSd9pqaHFHwGxCLr
         KrcrZfN4LRrgZ7BjCQf1HKbsaTqEIXoQuhPwEVmkm7DIO+tbVrQDECoX10a65KU8tQdu
         aidNy/JZb0hL1zV+YSoB+zvYxbCNgIj2Xp4S3z9Sjvm5aUU/HM9HvTSB7cidFevEDqWz
         jgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680776332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pU74o8K5k/VR2MmyjAiwWF+BGAxTRRi712Y0xDR8RJg=;
        b=yNQ/D5Vc3ER6fwb0XfIxjlpQZSKQXxj2fadQmT9e46BVSR5T2a/L7cGG+fNBuyx0wQ
         UAszpQUyU9THXaoYR/EEkunAEhO89surDo3Fh0jebBlplxj1oc6d8O3meS+bgjOj74C9
         2Y/Ng6m9w9Qkyabd7m5Jkyg/lezsVEtw+VdYphVRDxN2yjCGoyiPWaaYYybU7cmb0Fcd
         r79AEnsJ80wFfB4ikaUi6GLMMBLDV0ujttRZBWhlV9QG1G8sX4kQd/Pkg3018Hx8Ua00
         c91GkLEE++nVGBl0eviiqNz49cDBM2ZpF+UokKO6CA0DhDq9rwhgmPYCtpwTfKkY/uZc
         MHsg==
X-Gm-Message-State: AAQBX9enokdT3r7akTLmeUlFa25j92wxdNHJIunM9qi6Jupm97/TdU7W
        pQ01gZHbEM1aUiyCWnEtc88tU0XNHCHzHKO/zk/mJDZH26pKSMyRPMY=
X-Google-Smtp-Source: AKy350ZIUFJOrd7FcJmrHGvKBp5m29rWMOMSg9mdQoeGGTfG0GUrsNXZZ4k40R/H846LzJ21vVY0KtUYyz7S2eci/uY=
X-Received: by 2002:a25:7748:0:b0:b8b:f373:4c91 with SMTP id
 s69-20020a257748000000b00b8bf3734c91mr1425673ybc.3.1680776332161; Thu, 06 Apr
 2023 03:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org> <20230405-pl180-busydetect-fix-v1-3-28ac19a74e5e@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v1-3-28ac19a74e5e@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 Apr 2023 12:18:16 +0200
Message-ID: <CAPDyKFq80tJ4z6yWW-1edpkxYd7TH81zgh=PTRXkD-46hEHgXg@mail.gmail.com>
Subject: Re: [PATCH 03/13] mmc: mmci: Unwind big if() clause
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 5 Apr 2023 at 08:50, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This does two things: firsr replace the hard-to-read long
> if-expression:
>
>   if (!host->busy_status && !(status & err_msk) &&
>       (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
>
> With the more readable:
>
>   if (!host->busy_status && !(status & err_msk)) {
>      status = readl(base + MMCISTATUS);
>      if (status & host->variant->busy_detect_flag) {

If I am reading the code below, this isn't what is being done. See more below.

>
> Second notice that the re-read MMCISTATUS register is now
> stored into the status variable, using logic OR because what
> if something else changed too?
>
> While we are at it, explain what the function is doing.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/mmci.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 3e08b2e95550..3c1e11266fa9 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -654,6 +654,13 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
>         return MCI_DPSM_ENABLE | (host->data->blksz << 16);
>  }
>
> +/*
> + * ux500_busy_complete() - this will wait until the busy status
> + * goes off, saving any status that occur in the meantime into
> + * host->busy_status until we know the card is not busy any more.
> + * The function returns true when the busy detection is ended
> + * and we should continue processing the command.
> + */
>  static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>  {
>         void __iomem *base = host->base;
> @@ -671,14 +678,17 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>          * while, to allow it to be set, but tests indicates that it
>          * isn't needed.
>          */
> -       if (!host->busy_status && !(status & err_msk) &&
> -           (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
> -               writel(readl(base + MMCIMASK0) |
> -                      host->variant->busy_detect_mask,
> -                      base + MMCIMASK0);
> -
> +       if (!host->busy_status && !(status & err_msk)) {
>                 host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);

I wonder if this change is intentional. According to the commit
message, I assume not.

So, this may lead to that we end up giving host->busy_status a value,
even if the busy_detect_flag bit isn't set in the status register. In
other words, we could end up waiting for busy completion, while we
shouldn't.

> -               return false;
> +               status = readl(base + MMCISTATUS);
> +               if (status & host->variant->busy_detect_flag) {
> +                       writel(readl(base + MMCIMASK0) |
> +                              host->variant->busy_detect_mask,
> +                              base + MMCIMASK0);
> +
> +                       host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
> +                       return false;
> +               }
>         }
>

Kind regards
Uffe
