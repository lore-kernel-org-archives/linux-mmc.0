Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B81C3F2D7
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE6E2467F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9MoWggo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbgCDPfT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:35:19 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38274 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388181AbgCDPfQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 10:35:16 -0500
Received: by mail-vs1-f65.google.com with SMTP id r18so1409901vso.5
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2020 07:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Giq5UF1F/w38AbHK6DfEKwRi63lSe756DNZSfzRh6gc=;
        b=B9MoWggoUREkbaq0Aww3Hd0IV/FZbz//+eDkWHFvrVyN1hNCb59mGB+n69EaUIyiFT
         XInxog98hJoXhkPlCWuBh80LPvporHdZ6sAHxGAWoa9OCU1ncIOQEEf46h+CX9gBq6iT
         MnX70EKAh4VGozk/sEH32c9LygkTgAcHneDxChqd6MnCqm0Jjp07yHyeKJ6vAmqnOjea
         egqa0l8s0B0qd5x4bIQAx0KP2wbL2gfZlzmYfNWIXp1NX+IWbYeueZm6RMUb17HEiYQb
         251NTxJzu0Lob8ZrUSK9cdqyUFrhc/wkmyOe7GhjN81WEPgIM6r22WSFgcOh3YKXE9C/
         0FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Giq5UF1F/w38AbHK6DfEKwRi63lSe756DNZSfzRh6gc=;
        b=jjLK+0NNrtlwsiEPc5WZBatcTC1d66Lav0+jsC7O1Y3a6JEnLI7TC/Iwbdyr1/13DK
         23V9x/rMMa7o2vbjYmUseoJER6ZMevEvkxBQjlZ9J3KtEx22ShRJsBymmZ+kgj6OM7ap
         xRDAWJhbYeC7TmcYEqGA593TPBsPBkYtVEMCV59EKHWA5GGDmemi8Qrm1XrYEb5nNvdU
         cGPvKqbTeNhc+JTEb1AU20NVr5lyWnvd0XdpxkWjaxDF5KnD5Pmz1pMDVUvhJ91P4ktF
         3ff0OHnVwGHr4DQ8j+45+2Hh41QgUgEj1xjPewcbUkzMEiW2LYqtM34k9r2Q2wqfPpLC
         ZF1A==
X-Gm-Message-State: ANhLgQ0GOoUu66s8TkvX5Hr41kFW+OuqQLJcWuVuSLOork/C6S8+keCf
        dPwLEJ1rsRnzjUNcEmytUYA0iRSV1JfeUlx+5o/7DQ==
X-Google-Smtp-Source: ADFU+vsb4+c9j0dv5e9XgeArN/34Z+PnfNpjvCDZOLbyY4rsxq8FgCgrfC7M5L0T2U0XF0QE/B0An2pW1WtcCZZclUQ=
X-Received: by 2002:a05:6102:4af:: with SMTP id r15mr1988389vsa.35.1583336115345;
 Wed, 04 Mar 2020 07:35:15 -0800 (PST)
MIME-Version: 1.0
References: <96f16647f6a6e8cb058c44e46c61b122df027059.1582535202.git.baolin.wang7@gmail.com>
In-Reply-To: <96f16647f6a6e8cb058c44e46c61b122df027059.1582535202.git.baolin.wang7@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 16:34:39 +0100
Message-ID: <CAPDyKFr+BRhCQd70L8hMTtq8hfq8N-Z5+PAEmJhPy-rtuP3jMA@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-sprd: Set the missing
 MMC_CAP_WAIT_WHILE_BUSY flag
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 24 Feb 2020 at 10:09, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> The Spreadtrum host controller supports HW busy detection for I/O
> operations, which means when the host gets a transfer complete event,

I assume HW busy detection also works for R1B commands, so I am adding
that information to changelog to clarify this.

Please have a look at the next branch to see that it looks good to you.

> that always indicates the busy signal is released. Thus we can set
> the MMC_CAP_WAIT_WHILE_BUSY flag to remove some redundant software
> busy polling.
>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

So, applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index d346223..2ab42c5 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -556,7 +556,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>                 sdhci_sprd_voltage_switch;
>
>         host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> -               MMC_CAP_ERASE | MMC_CAP_CMD23;
> +               MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
>         ret = mmc_of_parse(host->mmc);
>         if (ret)
>                 goto pltfm_free;
> --
> 1.9.1
>
