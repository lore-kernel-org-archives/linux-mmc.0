Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AAEC76196
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Apr 2023 10:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjDFK2S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Apr 2023 06:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbjDFK2K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Apr 2023 06:28:10 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F89B6E89
        for <linux-mmc@vger.kernel.org>; Thu,  6 Apr 2023 03:28:06 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536af432ee5so731570577b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 06 Apr 2023 03:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680776885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RoXgglZIfQhudHLJxv0A5RSgyPp/erNGMXhuk4PLJ9Q=;
        b=E8acmpg9nF7ySxUb63bohkgR17wqLcBO5mZL8MDeJmfeTt+vrDCsKUp745NhtHne7l
         iuovXZefAm4Z6m31J48ecxlIkZleXZ/8YoDHZpxAVaIessCxZFby40gr4xJIwzTjsLvC
         H0tUsdsOTzhs+4sQBXZuMcaZCvhbksIx69/u7AoEtweGVn7t4GXZokx5sftK6yzFO4QJ
         S0Q5kf1HhFuLrHQ0pINp31GbcpFrxTYtz3ncl7/TbXOLbz86K/9lxYZ1Onzao+RB7Wk8
         gSQk8i6UlmEwVR+aJ7qz4lH9Qoyr9qalIJ0HZpWgKJYHCz0AyosqBIQzFC8nSVFYEWxP
         q+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680776885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoXgglZIfQhudHLJxv0A5RSgyPp/erNGMXhuk4PLJ9Q=;
        b=CkVj3LU0CbhiK/v6pw4ZITDRX2Ha7nM1ivS+hNI7+Ji0rxVfof2UkApsWYrL699HME
         /hTgVYp55Z+4dXMfwDBreDJ3TvRTQFI4/mdhH7PrYn598kx67IirqdLH57fVBfXMK8CK
         ZCPSJdKRkZvZiUi7KvN5i4VhrvB8hyJGIo5kqEjtPkZiT2226ITbK8eRCQ9iSmMYa6vh
         qQ6NonF+yg80BKdCpme6MN/gqySws7DXLkqG4lubEINMx3AEziRUgwvfAJLdd3ltVVfs
         oQ4Oot5Z+czi0xzdhALz0h22xPaR3vNAuNYnB0cfnGUBfowt6t5ZL+JPokIDJYf/+FRF
         bIzA==
X-Gm-Message-State: AAQBX9f1fR0flqmUJYpUMdSdnBDpXQ9vPc7GHeA6pT5cn4TOAKqcPvrQ
        RVi//717Jyson3I2pC6q7+LMo5PJH+c+3lW+395twQ==
X-Google-Smtp-Source: AKy350aNbMwkykd0tG0ybDsA1+cKD4wjl7c4OcpaxCNaRs8g/3LeLfgy0rHGfUqI6S0TMvtDqQmS1blm/8gkiwyEwJc=
X-Received: by 2002:a05:690c:714:b0:54c:88:64a1 with SMTP id
 bs20-20020a05690c071400b0054c008864a1mr2198949ywb.0.1680776885459; Thu, 06
 Apr 2023 03:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org> <20230405-pl180-busydetect-fix-v1-2-28ac19a74e5e@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v1-2-28ac19a74e5e@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 Apr 2023 12:27:29 +0200
Message-ID: <CAPDyKFp0x9y-eQDACpessg55R3MMjqHeOCVbEtFMZ1-bSANXhQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] mmc: mmci: Clear busy_status when starting command
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
>  drivers/mmc/host/mmci.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index bc150c0d5eed..3e08b2e95550 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1238,17 +1238,22 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>                         c |= host->variant->cmdreg_srsp;
>         }
>
> -       if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
> -               if (!cmd->busy_timeout)
> -                       cmd->busy_timeout = 10 * MSEC_PER_SEC;
> +       if (cmd->flags & MMC_RSP_BUSY) {
> +               if (host->ops->busy_complete)
> +                       host->busy_status = 0;

I think it would be even more safe to clear host->busy_status, even if
"cmd->flags & MMC_RSP_BUSY" isn't set.  Don't you think?

>
> -               if (cmd->busy_timeout > host->mmc->max_busy_timeout)
> -                       clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
> -               else
> -                       clks = (unsigned long long)cmd->busy_timeout * host->cclk;
> +               if (host->variant->busy_timeout) {
> +                       if (!cmd->busy_timeout)
> +                               cmd->busy_timeout = 10 * MSEC_PER_SEC;
> +
> +                       if (cmd->busy_timeout > host->mmc->max_busy_timeout)
> +                               clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
> +                       else
> +                               clks = (unsigned long long)cmd->busy_timeout * host->cclk;
>
> -               do_div(clks, MSEC_PER_SEC);
> -               writel_relaxed(clks, host->base + MMCIDATATIMER);
> +                       do_div(clks, MSEC_PER_SEC);
> +                       writel_relaxed(clks, host->base + MMCIDATATIMER);
> +               }
>         }
>
>         if (host->ops->pre_sig_volt_switch && cmd->opcode == SD_SWITCH_VOLTAGE)

Kind regards
Uffe
