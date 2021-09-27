Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB085C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 22:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E5760FED
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 22:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbhI0Wdy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbhI0Wdy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 18:33:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C22C061575
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 15:32:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x27so84139028lfu.5
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 15:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKu0IEoODoUZIet78XIQ7gITGkb6gFdWyb3HNpoDiRY=;
        b=kpXgGEYkOKaDhkkfgBp7BBAINU+UWy4oa9d0ezLNX1RdkCrN5HQFAcEpIxYdSqaY8E
         4l+zTnannSueZmhgY3UnxmyNBaFabr0j0X2ntWtPMkfvb+VutnzecmJmXqGu0zexnRjx
         uXmSVxOUQjEHQO/mqp5FlkjS8NjpvBTAl593Q0gzCq2cbHArqKK4E9y1M1argn71WiC6
         JO2B/CXOEM7xbpGpU2P6VwrNk9BJEt5K2j4oOUF4X6Fs+MOeYgZqgEt/5NsJ1CkTTM1F
         cahMn+4wLj+ys0ZhlokvVekdhkb6slO+PCWGpOm9BNz6ndkrwQIpfKjbP7x8xOfI6lVD
         bkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKu0IEoODoUZIet78XIQ7gITGkb6gFdWyb3HNpoDiRY=;
        b=mGANGb30vFetgQQfhpBma6a58pyqsbaNzXn8YaSReyoP2+Sp+9Ef3NsxAEOxKf70Ai
         v2qRpxW6r/gG8olekC8F4j7BT/H5cBrMH9UblksLbpUxFfIUty8NHLwjvmkQdI+5pxID
         tGbQ+BbTeq4jltSBsnHX2BcqDM9hP6EPpNrwANgQcDGPb47Lb6Ie2SI08HXUcp4HAgjd
         kUjiwQmj+jVcJmPAVfgKnl/fF756pFHYvIvxdi9i/HB9TzD/UlZJ+DzIMTwuPrpTix1s
         u6ph7IAfpEoKdzB+sgi2NcJk/1lcEbf5r6a1OjFiZ/v9GNYp+yCrkHJnmech37i8rosL
         YKQw==
X-Gm-Message-State: AOAM532J3wTYdh9SSozS2Ro5Sz9IoJp6H/AcEQbUtDvX4G1fmnkacEwy
        bSnIdwDJ5Lp1HXRNUWRYZqMjB70gWaiGqfn2ylhsIA==
X-Google-Smtp-Source: ABdhPJzhJkeB4zE1uCuw+O9on0VZVgtLXjw2moy+UGvPzQgeEJy+bQMNoHXRMUWjpXTYDrUF0YGvWaKZ2x6KDD8fqxo=
X-Received: by 2002:a05:6512:2397:: with SMTP id c23mr2162094lfv.358.1632781934165;
 Mon, 27 Sep 2021 15:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210917172727.26834-1-huobean@gmail.com> <20210917172727.26834-2-huobean@gmail.com>
In-Reply-To: <20210917172727.26834-2-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:31:38 +0200
Message-ID: <CAPDyKFo+vVE_nH7b6HoZA==psx1+BiL8GqKCFXScRQKcnu+-OA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: sdhci: Return true only when timeout exceeds
 capacity of the HW timer
To:     Bean Huo <huobean@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Sept 2021 at 19:27, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Clean up sdhci_calc_timeout() a bit,  and let it set too_big to be true only
> when the timeout value required by the eMMC device exceeds the capability of
> the host hardware timer.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next (deferring patch2), thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7ae398f8d4d3..357b365bf0ec 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -930,7 +930,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
>         struct mmc_data *data;
>         unsigned target_timeout, current_timeout;
>
> -       *too_big = true;
> +       *too_big = false;
>
>         /*
>          * If the host controller provides us with an incorrect timeout
> @@ -941,7 +941,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
>         if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
>                 return host->max_timeout_count;
>
> -       /* Unspecified command, asume max */
> +       /* Unspecified command, assume max */
>         if (cmd == NULL)
>                 return host->max_timeout_count;
>
> @@ -968,17 +968,14 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
>         while (current_timeout < target_timeout) {
>                 count++;
>                 current_timeout <<= 1;
> -               if (count > host->max_timeout_count)
> +               if (count > host->max_timeout_count) {
> +                       if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
> +                               DBG("Too large timeout 0x%x requested for CMD%d!\n",
> +                                   count, cmd->opcode);
> +                       count = host->max_timeout_count;
> +                       *too_big = true;
>                         break;
> -       }
> -
> -       if (count > host->max_timeout_count) {
> -               if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
> -                       DBG("Too large timeout 0x%x requested for CMD%d!\n",
> -                           count, cmd->opcode);
> -               count = host->max_timeout_count;
> -       } else {
> -               *too_big = false;
> +               }
>         }
>
>         return count;
> --
> 2.25.1
>
