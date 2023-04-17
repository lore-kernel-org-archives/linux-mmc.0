Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB14C77B70
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 13:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjDQNJc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 09:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjDQNJQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 09:09:16 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2B1BE9
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 06:08:08 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54fbb713301so174328017b3.11
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681736847; x=1684328847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw+N4lmXgksiZObWsRam9O+AwFJ+q7vEUaa4tbsG2Ys=;
        b=PU2TeZwDN3uPSlXH+LcLVdrVZj1S5sbTqA4wpoggKCCF5+QoYb2X+9fqM0sVGfvpx+
         jpkIAMV4MiOT8PrgzQz8Bvulp33QCvzkxy4n67TyrItX7B7iRdVYuZ29gh7H0HFRg1kM
         6QDd5Ma3EVEvAQ9OUQsBNU12F4WdDBmnFxG71/1iffTW0n5IMqNKmACPZfK7R5PkaqWf
         kmV8Tew4uWVMWsN0NaChfgScLQPRHlNjMaRhhl/8iQy6pz0HxZ5PlU5VqmSiD8mz/pac
         2ar2+7JzqRilKNF3WTKlctGELMj6NxNDKUq87ru1Ew3Hc0Ys9Q7SeCLTbRctDb9X8Ero
         GQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681736847; x=1684328847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kw+N4lmXgksiZObWsRam9O+AwFJ+q7vEUaa4tbsG2Ys=;
        b=RLMiyZxHrG/PhjrXid48vx+rwrhXQMlSY8H9+OW1JHWZW5UGZ2heoT5iYuaAsd4WJP
         jYbO6sJsakm0JEc/lSn7BI3V8ZNdtqS9vXoM0fCRQUBfao+tm8ujzukb9+GMzne1IYdG
         zp5mrYf4FsT6EBpHGQjGpMZBeOsqBkIxPOz/+MiT9q55rf1ClIeQbJgGv/M2NlaDPeD9
         lrHvOe8QJ2/X+ujOMLzydM5Orzvb3tXUzXnLyeIjArWv+YXfrZqTZ72CwhvC5w9/0Owt
         qTELGAG8KX0SvUZ8pDnG2NcVsaiq7wN31SCbZ2d+p1YglG9wuxBKlLEhJxnjOYCrYQam
         zNDg==
X-Gm-Message-State: AAQBX9fiWv5hXuR14EzFeAei6Ej2d3i0Sm36QZjdkD8Ywei0fellgwdg
        NHQl0AN2vagHg1bFpdyRPHflV1niWLTRGB7B3+dSDA==
X-Google-Smtp-Source: AKy350ah5IOHfHIOmiogXHScEat1z0RQz/vrpZtML3zrmIwRssYWDJHmutNvFlZ+5p/8tM9Ot8saB7BioWtG0sFhul0=
X-Received: by 2002:a81:af0c:0:b0:54c:2889:7105 with SMTP id
 n12-20020a81af0c000000b0054c28897105mr9515199ywh.0.1681736847531; Mon, 17 Apr
 2023 06:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org> <20230405-pl180-busydetect-fix-v2-1-eeb10323b546@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v2-1-eeb10323b546@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 15:06:51 +0200
Message-ID: <CAPDyKFqESKrqA7u0zg+GBLad_tqzrt+wGfT-jEqvVGruv8oR0Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] mmc: mmci: Clear busy_status when starting command
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 9 Apr 2023 at 00:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> If we are starting a command which can generate a busy
> response, then clear the variable host->busy_status
> if the variant is using a ->busy_complete callback.
>
> We are lucky that the member is zero by default and
> hopefully always gets cleared in the ->busy_complete
> callback even on errors, but it's just fragile so
> make sure it is always initialized to zero.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Unconditionally clear host->busy_status if we get a
>   busy response.
> ---
>  drivers/mmc/host/mmci.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index b9e5dfe74e5c..9b48df842425 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1238,17 +1238,21 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>                         c |= host->variant->cmdreg_srsp;
>         }
>
> -       if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
> -               if (!cmd->busy_timeout)
> -                       cmd->busy_timeout = 10 * MSEC_PER_SEC;
> +       if (cmd->flags & MMC_RSP_BUSY) {
> +               host->busy_status = 0;

To be even more safe, I don't think we should check "cmd->flags &
MMC_RSP_BUSY". Let's just reset it always instead.

>
> -               if (cmd->busy_timeout > host->mmc->max_busy_timeout)
> -                       clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
> -               else
> -                       clks = (unsigned long long)cmd->busy_timeout * host->cclk;
> +               if (host->variant->busy_timeout) {
> +                       if (!cmd->busy_timeout)
> +                               cmd->busy_timeout = 10 * MSEC_PER_SEC;
>
> -               do_div(clks, MSEC_PER_SEC);
> -               writel_relaxed(clks, host->base + MMCIDATATIMER);
> +                       if (cmd->busy_timeout > host->mmc->max_busy_timeout)
> +                               clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
> +                       else
> +                               clks = (unsigned long long)cmd->busy_timeout * host->cclk;
> +
> +                       do_div(clks, MSEC_PER_SEC);
> +                       writel_relaxed(clks, host->base + MMCIDATATIMER);
> +               }
>         }
>
>         if (host->ops->pre_sig_volt_switch && cmd->opcode == SD_SWITCH_VOLTAGE)
>

Kind regards
Uffe
