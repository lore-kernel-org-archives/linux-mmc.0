Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C47C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Feb 2022 17:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiB1RGw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiB1RGw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2022 12:06:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28D257B0D
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 09:06:12 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bu29so22615369lfb.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 09:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCqSJLVmzSiAQCZuGWx3jdcx0OAjD7prrRZYblRmLXk=;
        b=biJj7wivuUwsykg3cCHNhf5pu9DOv2jbE6fUXHgxl5AXqJvtb2ehNXEpFdBsjf5qD4
         vkHTAQcKYQZBp7geavn1aVx7d+zborulBdlwD7Z9JRROJb12Mj6rRHX0cdfRhdrBzE0T
         /VohSnvjl3cAMBB76kxjvj0WUoNEYnotB2u9aY4x3HQ8MsPfk5guRYXgM9MGsq6586hO
         P3k48kII6PkFhXlZjZdrwpfYsUaBAhs1H81yb5JvQCu2e5fNvNljwd6rz18hGoRAllT7
         8vpUEGH8aPTJnoNzpFlbD5QQcpiY4id2uDJYhd0pnDZxqOyuc1WlmXodzzdBd3L88bUq
         P45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCqSJLVmzSiAQCZuGWx3jdcx0OAjD7prrRZYblRmLXk=;
        b=BCdwZNp6naruCqiW4rjuFlnRyPjVKT+ncRnNseDaWfO96uox7Kzsjtyku3T5RILlqC
         q65WI8nLznpODN21lcxsG0uI4zE/fhbv+gShf8Qa+mIBEIPEbgMcifjpWz/X1wrqvYBp
         Y3G5In+/VIgYtKXIPAPxNqsyImuLVTQMeEsm72abL7Tw0/BjFy7hl/XW73q/UNDtsXG7
         fIuueWpqLIB1VDNndvmrA5JUkW6WN0mgCSIxzkrYKvnWcgRXC45YU2cR9A7XvXYYfhJO
         vHKmQJYDDkIcff1/rp6Y9p4XZ92OHxdrEgbUefRzOu1mXeP4D9driRSAvZmjV9SJuESl
         G7cQ==
X-Gm-Message-State: AOAM530ZgmEVS3kD+ZTsCtFKUU90tzZD/XIreYPyhgk6fqQHL/y3z9Ye
        ncS26E2QE4y0t4M/Rdgagk2TVwiZ/Oiv2gQ+usdbDA==
X-Google-Smtp-Source: ABdhPJyiqgn7SIzkaA0Z4EPVWwcwg577znE0wY62h7WlddpNO9W0l3Jz/eBXTKgDKMBrXh7YF6zOLSFPqFGqc/Yec0M=
X-Received: by 2002:a19:9144:0:b0:43b:86a4:1497 with SMTP id
 y4-20020a199144000000b0043b86a41497mr13291435lfj.254.1646067971343; Mon, 28
 Feb 2022 09:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20220216124239.4007667-1-rong.chen@amlogic.com>
In-Reply-To: <20220216124239.4007667-1-rong.chen@amlogic.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Feb 2022 18:05:35 +0100
Message-ID: <CAPDyKFq797hihSwtX00V6tW2c035FLPnWonbBGcuh4L-zWqHTw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: meson: Fix usage of meson_mmc_post_req()
To:     Kevin Hilman <khilman@baylibre.com>,
        Rong Chen <rong.chen@amlogic.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        1131046452@qq.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        45581586@qq.com, Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Hainer

On Wed, 16 Feb 2022 at 13:42, Rong Chen <rong.chen@amlogic.com> wrote:
>
> Currently meson_mmc_post_req() is called in meson_mmc_request() right
> after meson_mmc_start_cmd(). This could lead to DMA unmapping before the request
> is actually finished.
>
> To fix, don't call meson_mmc_post_req() until meson_mmc_request_done().
>
> Signed-off-by: Rong Chen <rong.chen@amlogic.com>

We should probably add a fixes tag to this, right?
Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mode")

Moreover, you want this tagged for stable kernels too, right?

I have applied it for fixes and added the above tags, please tell if
you want me to change it.

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 8f36536cb1b6..58ab9d90bc8b 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -173,6 +173,8 @@ struct meson_host {
>         int irq;
>
>         bool vqmmc_enabled;
> +       bool needs_pre_post_req;
> +
>  };
>
>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> @@ -663,6 +665,8 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
>         struct meson_host *host = mmc_priv(mmc);
>
>         host->cmd = NULL;
> +       if (host->needs_pre_post_req)
> +               meson_mmc_post_req(mmc, mrq, 0);
>         mmc_request_done(host->mmc, mrq);
>  }
>
> @@ -880,7 +884,7 @@ static int meson_mmc_validate_dram_access(struct mmc_host *mmc, struct mmc_data
>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>         struct meson_host *host = mmc_priv(mmc);
> -       bool needs_pre_post_req = mrq->data &&
> +       host->needs_pre_post_req = mrq->data &&
>                         !(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
>
>         /*
> @@ -896,22 +900,19 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 }
>         }
>
> -       if (needs_pre_post_req) {
> +       if (host->needs_pre_post_req) {
>                 meson_mmc_get_transfer_mode(mmc, mrq);
>                 if (!meson_mmc_desc_chain_mode(mrq->data))
> -                       needs_pre_post_req = false;
> +                       host->needs_pre_post_req = false;
>         }
>
> -       if (needs_pre_post_req)
> +       if (host->needs_pre_post_req)
>                 meson_mmc_pre_req(mmc, mrq);
>
>         /* Stop execution */
>         writel(0, host->regs + SD_EMMC_START);
>
>         meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> -
> -       if (needs_pre_post_req)
> -               meson_mmc_post_req(mmc, mrq, 0);
>  }
>
>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
> --
> 2.25.1
>
