Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BE5C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 15:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62EE460232
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 15:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhKHPPJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 10:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240994AbhKHPNs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 10:13:48 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCFAC0432E4
        for <linux-mmc@vger.kernel.org>; Mon,  8 Nov 2021 07:09:25 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u11so36981951lfs.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Nov 2021 07:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h52OyuezneY+HfFCDz2455oumulI2OIMcxced9CiUKI=;
        b=sbXMXPE1fe3Rl8GIZha8hEcDly/0oYq8PgDTmFs0eqJy4Pa3TOAgxCFsBPe4PJEuHb
         w/F+Vj4yNe4h7FaDCQgUQmLIXX/P4c4BbXiSxC0ufNDrNUjBVxVB3ej+RnQNIzwE2lKl
         shPecTdYaRk69ZOI7aL4lEHHFgpMABT5xr+VG6PTqUZ3J8UChte/0nCO0EZFzsW+J1Rk
         mWTH1b9Q7LYN1rYV43cUXr5gfCcH18FhcenYmrdoEMXIMn8FsMTd1/n6fvWOqc++tP8l
         iTGgLOOffoBpVTL1BEQ3zr+YDRgD7KT9aBhEQreOkxPo63LpJUP7IdeHhOUMhuHxT8uF
         PZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h52OyuezneY+HfFCDz2455oumulI2OIMcxced9CiUKI=;
        b=lPi+oNpg+gZ3eR9fldTuZzEFBqUyP++NZwJxSAzJLMSruUbuH12vA4kaTzIuQv1uCV
         y01fiA4rCpIWabx50Q4YAbskJ8ms4A5CJSLosnIUbdfsT6i5AutAiOiO8Xr3DdBwOqGr
         R8EjaITY+3wm+tNxITe2GXtAdYoDh5DeU2BEwdr+hM9a3wtpUrX+D5F19mbClZayGpAW
         v9mftXIgcG3At6nXqDkvosH9U/PC0FZ6zbPrFUEO/27x05kzsV7mq3gB/aKL0TbXYkvO
         mpVdGKyfFAfByYPlITsp2lcMFr07sG7/wCWH3pnYFMZWY7tVoqfBfyXguoWkYEjHfvcV
         A0vg==
X-Gm-Message-State: AOAM533OY+DDqA6VJZ9BhTCn/yiW8FrBR4ygBEuJEJSlPrBHSmR6DeM8
        DYkA2FR1zO2CnmnzfNzB7TdFc0Bjd+yGGjAUoouhPA==
X-Google-Smtp-Source: ABdhPJzeeT3o/8LSqc0j2G6spIXsGKs/UCua3HwxGXYZTntnLMf07iJnNQIrLUo5mRwFBMMiGz2gO/6oEiBJM1ZaWoQ=
X-Received: by 2002:a05:6512:3d15:: with SMTP id d21mr139607lfv.233.1636384163698;
 Mon, 08 Nov 2021 07:09:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1636103151.git.hns@goldelico.com> <73440c0f227778e57167dd9fedd350637a1d737a.1636103151.git.hns@goldelico.com>
In-Reply-To: <73440c0f227778e57167dd9fedd350637a1d737a.1636103151.git.hns@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Nov 2021 16:08:47 +0100
Message-ID: <CAPDyKFr5=sQsb2KEh_nkDZY5ThjMTOZWzwN7mkd4AS5jWDYtWg@mail.gmail.com>
Subject: Re: [RFC v4 4/6] mmc: core: add new calls to mmc_fixup_device(sdio_card_init_methods)
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 5 Nov 2021 at 10:06, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> This allows to add quirks based on device tree instead of having
> card specific code in the host ops.
>
> We call it just after where host->ops->init_card() can be optionally
> called.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/mmc/core/mmc.c  | 1 +
>  drivers/mmc/core/sd.c   | 2 ++
>  drivers/mmc/core/sdio.c | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 29e58ffae3797..19cd138acaec9 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1634,6 +1634,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>          */
>         if (host->ops->init_card)
>                 host->ops->init_card(host, card);
> +       mmc_fixup_device(card, sdio_card_init_methods);
>
>         /*
>          * For native busses:  set card RCA and quit open drain mode.
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 4646b7a03db6b..0d174fdf47164 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -23,6 +23,7 @@
>  #include "host.h"
>  #include "bus.h"
>  #include "mmc_ops.h"
> +#include "quirks.h"
>  #include "sd.h"
>  #include "sd_ops.h"
>
> @@ -1427,6 +1428,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>          */
>         if (host->ops->init_card)
>                 host->ops->init_card(host, card);
> +       mmc_fixup_device(card, sdio_card_init_methods);
>
>         /*
>          * For native busses:  get card RCA and quit open drain mode.
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 68edf7a615be5..cf8ee66990508 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -707,6 +707,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>          */
>         if (host->ops->init_card)
>                 host->ops->init_card(host, card);
> +       mmc_fixup_device(card, sdio_card_init_methods);
>
>         /*
>          * If the host and card support UHS-I mode request the card
> --
> 2.33.0
>

As the quirk is for SDIO cards, we don't need to call
mmc_fixup_device(card, sdio_card_init_methods) - other than from
mmc_sdio_init_card(). Additionally, for sd/mmc we should not be using
'sdio_card_init_methods'.

That said, it looks also reasonable to me, to squash $subject patch with patch3.

Kind regards
Uffe
