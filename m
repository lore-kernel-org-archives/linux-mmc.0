Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4714AC05027
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 12:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjBNMTL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 07:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjBNMTJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 07:19:09 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019B82749C
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 04:19:04 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id ja21so9270988plb.13
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 04:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676377144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1WzS6VPcyP/6opcQNFoZ1phcotBjwqVN1tSszwsZD2g=;
        b=OfG8GT8Sx4a83BqgvCTp5wEACt/vwX+rkakSLH5KJOsm+0TlAhMDpUaG0hfcbHhTE4
         gOBPmySbxguF2ojn0k7AHmLaW7tfFdyizHgKIZ2kk0MJvqs+OquHZGu2TYIUAcn2FByy
         swnDTvy3KA+ndY7MpXeCn8TCZsZnTw4sLEeTyoLNxMVZxQjqRJC9OgdWWUG5w2gOq2os
         iUE7Vw4HjRE/vHYgH6lB7THX0VflR8TrLji+7KNocmdtEUituCKxipOobgEJ+jb2B+3g
         0drDcdFjpGFqWJYdE8xccEZyXqPavVxMbE0iYizJAKJVUNw+baRwWPngIcrNx/rvIxEg
         tBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676377144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WzS6VPcyP/6opcQNFoZ1phcotBjwqVN1tSszwsZD2g=;
        b=2Rb02DiTmoKzf0RCcJ9FrGSHqLq9RuHWO2XXBt0BT/t9dCg09GqgkMtLXJS+ODdXEr
         v4HZDwWViUuqOod+nf2akL9X3YqzbzAg+zajSxgqevOM8QATaZgRm7x8e8nw7wSBFLrO
         NV13IuB6fv/f8JzA5enbN7+XBEdDoP3is2bm1uFhrpYqgZ7Lr+ufzYUYVixt0lolcQBj
         ha/+ZQf3X6Mc9nLGQA27lYBCY0BCTQp6N1zPx9Zkd5W04ep7smbgJLfTFdecScnClFr6
         pTr9FY3sUvSrlJnQX6DoqG29SfM4zCufHVETTFzWZ04XTRc5087KdqnO4WZQFEC2H7uP
         E74Q==
X-Gm-Message-State: AO0yUKXZ256oEyU9qFnNiB+xYq/OeEFuEuz+FsCkYNkYlCwLVlOU0ow0
        JOHsnVOjHAkIdBLUx94tsEiWxBVvxWW/3RA/ixaTrPn64wBVNQ==
X-Google-Smtp-Source: AK7set8OlHY9s1D3pQ/SqG80jXWRcX+pmmsZd4D1HLLkiUEm4Scc10pIxJGVGroUZI8DgaHWkJyXVV+nZTTUkX4BAwo=
X-Received: by 2002:a17:902:d506:b0:198:99b5:cabf with SMTP id
 b6-20020a170902d50600b0019899b5cabfmr616842plg.25.1676377144348; Tue, 14 Feb
 2023 04:19:04 -0800 (PST)
MIME-Version: 1.0
References: <16502040-3beb-a3cc-b28d-28184fba0f10@gmail.com>
In-Reply-To: <16502040-3beb-a3cc-b28d-28184fba0f10@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 13:18:28 +0100
Message-ID: <CAPDyKFqtrTNV8AMHmZHbmyP=P4csMh=ESKwJxyq17gnNmRn7DQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: remove meson_mmc_get_cd
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 12 Feb 2023 at 22:54, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> MMC core only checks whether return value of .get_cd() equals zero.
> Therefore -ENOSYS and 1 are effectively the same and the function
> can be removed.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 6d5caf233..1d761f33d 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1064,20 +1064,6 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> -/*
> - * NOTE: we only need this until the GPIO/pinctrl driver can handle
> - * interrupts.  For now, the MMC core will use this for polling.
> - */
> -static int meson_mmc_get_cd(struct mmc_host *mmc)
> -{
> -       int status = mmc_gpio_get_cd(mmc);
> -
> -       if (status == -ENOSYS)
> -               return 1; /* assume present */
> -
> -       return status;
> -}
> -
>  static void meson_mmc_cfg_init(struct meson_host *host)
>  {
>         u32 cfg = 0;
> @@ -1146,7 +1132,7 @@ static void meson_mmc_ack_sdio_irq(struct mmc_host *mmc)
>  static const struct mmc_host_ops meson_mmc_ops = {
>         .request        = meson_mmc_request,
>         .set_ios        = meson_mmc_set_ios,
> -       .get_cd         = meson_mmc_get_cd,
> +       .get_cd         = mmc_gpio_get_cd,
>         .pre_req        = meson_mmc_pre_req,
>         .post_req       = meson_mmc_post_req,
>         .execute_tuning = meson_mmc_resampling_tuning,
> --
> 2.39.1
>
