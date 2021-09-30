Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B350C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 11:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECAC619E2
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 11:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350428AbhI3L1Q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Sep 2021 07:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350445AbhI3L1P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2021 07:27:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4345C06176A
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2021 04:25:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e15so23822745lfr.10
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2021 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuWajK2Vii41SiDlh9TTWWF0mw4w25Q0O4RAtrkwQRE=;
        b=tFDH3e22bxO1f/FW2NFzaUcXTUhaogzBYzqVOQueZE9qXFWpZLs6dUg5VihT5BeeIC
         X/8HCmmgjGub64eLEQ5+ZARJyMSbSZC2Xnm4Mq458PK7jNkIdqOiNao9PY7x7dSFte1a
         8VcZ/33yci0z0aBUq5zryWBCGaUmefCgCBB/JLNGdvtR/7hlFIhcMSoUm8vQyT2gkVjZ
         /OInZhBmO2vZhOiHnVzSh76Y3898705zSEQe5wS/q1s12bFjVqS8UoWblw/RvKKfPe2d
         Bd/NTjGbEB4SzyWZoRmC4vEm3C5ELdEozRiSO2naa/iC2J3XylmE2xtPSR7btOwwqpw3
         IPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuWajK2Vii41SiDlh9TTWWF0mw4w25Q0O4RAtrkwQRE=;
        b=7AW4XavL/yZaiawlpKm7ltRWcamAUbY2FWdrHiAHOxwefAO+f3ZnaMlt1GRq3xT9xh
         Y9yGnTOZII3ji7I0dokaKjaTxwb/ocId5p6A0uaZ79Ny0Wg/ioIqvHamlDiu9TxyS/GV
         w7oUZxD/cR5eXgnColZFb8uHWCgBqmNBv/5/gKqXZiqSiDHREt2FsHv0IdmnSAbLDZaf
         Is0aWAHidvdDm2IDq7wmLR/gHh2OzrkXyFUMFTAqgRNQqoxBsI1c4z6pn9EbH/zT3pai
         HA04qj5K6/ogJwFvFaQx0AfO4wdgBJNm0IMJFnBjCttfzKCuivlMIdrMY9vLHD7X+ELv
         Mrdw==
X-Gm-Message-State: AOAM5311Ydn8lq/EUvg3IlvSUiq/ZqIUv2DGoQ3zz06oaUeg77/hl7F9
        A3+hXcX1Dzt2OF9B6737ri0QIWXh1WGMaoiyiR8xFw==
X-Google-Smtp-Source: ABdhPJyPFP3Fvxf55MEWXbcgZbyXPCmbmefXEfcokkOYmtHBZ6fdxo0S9lTY6Wvb5Xoeb3x/hORezmvGdDeSzBYzXfQ=
X-Received: by 2002:a05:651c:20b:: with SMTP id y11mr5594997ljn.463.1633001131038;
 Thu, 30 Sep 2021 04:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210929111757.52625-1-andriy.shevchenko@linux.intel.com> <20210929111757.52625-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210929111757.52625-2-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Sep 2021 13:24:54 +0200
Message-ID: <CAPDyKFr+Y-fjKvjOg_W=+hHPABTHdApZ8=WWwXn6gQy0tn6+bQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: slot-gpio: Update default label when no
 con_id provided
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 29 Sept 2021 at 13:17, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Currently default label of GPIO is assigned to the device name,
> when no con_id provided. Instead, let's update it to reflect
> what it's about (use already prepared template).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/slot-gpio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index e365d328f43c..dd2a4b6ab6ad 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -178,6 +178,10 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>         if (IS_ERR(desc))
>                 return PTR_ERR(desc);
>
> +       /* Update default label if no con_id provided */
> +       if (!con_id)
> +               gpiod_set_consumer_name(desc, ctx->cd_label);
> +
>         if (debounce) {
>                 ret = gpiod_set_debounce(desc, debounce);
>                 if (ret < 0)
> @@ -226,6 +230,10 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
>         if (IS_ERR(desc))
>                 return PTR_ERR(desc);
>
> +       /* Update default label if no con_id provided */
> +       if (!con_id)
> +               gpiod_set_consumer_name(desc, ctx->ro_label);
> +
>         if (debounce) {
>                 ret = gpiod_set_debounce(desc, debounce);
>                 if (ret < 0)
> --
> 2.33.0
>
