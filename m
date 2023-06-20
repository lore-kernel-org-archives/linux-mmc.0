Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA727EB64D8
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjFTKO0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjFTKOZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:14:25 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450B7A3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:14:24 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bcd0226607bso8270984276.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687256063; x=1689848063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cmMYox2vIOHcAya1yfArnEkv6hZhFde8bBx6JYLJt/w=;
        b=RMqM5TjjJq+lwE60Jp8oaqL3hFQksfqsOMdVagxGZhN0TZauO6GrHHm/9Uhw1g7CUM
         +Ez84DoN4umhLM6Kd1vGlUyzj/QHEt378t7sOMm15hWaze90RmsaAzNaVy40us8YgkfQ
         qqHjRVv3d22KT449N31k+5RnXWl8beONGk/HDYAAhxe8vnrukBn/XSu0FNYwQl0B46mM
         YTEZoEzs2cQw/RAd2rn2x5Hu5Crnlq/5xTXPFksfsgiqSaJCuqXBblT+umjrnyXLhgID
         268K1KnyYf79fE7ke1r2ZCIAhA9eOhGwNPIc9LnMtr/eZ6JF2YP5sooSFtSAGAEXg9EL
         gqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687256063; x=1689848063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmMYox2vIOHcAya1yfArnEkv6hZhFde8bBx6JYLJt/w=;
        b=HpwJDCwkaU7ZMHV5KHXU8O/T75hGGE+ZFsifDvIYf9IleQAlM9n2Uxc1X9LsSC/tDT
         0bjNaSIT2FhCcno7q4MXasrJzr2cq9JnUho+1y1NRDISQ6azA+auQbtRpsFbmDtkF5cx
         s84M9/dcR8CMVXpbicxvY47V/AMP/4fhHeQVshadJan38XINmdmtXlFvqzAvNwBJUb+b
         mfQNc/U01112dY0Y1tvm1KI+Uimj6HtYQnvJm+kaLHYiOpBU0f30lYAKgnvN+eApKHft
         2JtNvWeWI23GUjVT7NzKb9dEdHsZ7aHV7/IgK3DZM/p2TtDBEa9bWOJGGSL1Uonk+UEl
         QYSQ==
X-Gm-Message-State: AC+VfDzaCzIXwrHZQBCLWb3D/8xDrQYeUjjnvxPzVC99kspVkveOOYwx
        0VOBdYWukbsikuy29OnGAiu/y8wQvmyFaasXrjECyw==
X-Google-Smtp-Source: ACHHUZ7R1vmGwa+/KwmRz9xEHYwaMbUOB4SSovI5F8z7gLh4bp20XdVYyLH7P2IT0WYQuZYSkKDvL1Ffeo1ZRelZEpo=
X-Received: by 2002:a25:ab2a:0:b0:bc5:b1f7:7953 with SMTP id
 u39-20020a25ab2a000000b00bc5b1f77953mr9118972ybi.0.1687256063492; Tue, 20 Jun
 2023 03:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230620013956.111275-1-marex@denx.de>
In-Reply-To: <20230620013956.111275-1-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Jun 2023 12:13:47 +0200
Message-ID: <CAPDyKFrBAjK4ps3dqeSOqHwubq++_eeFciEKYk-Aq3xrZgMQog@mail.gmail.com>
Subject: Re: [PATCH] mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go
 Plus from 11/2019
To:     Marek Vasut <marex@denx.de>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Brian Norris <briannorris@chromium.org>,
        ChanWoo Lee <cw9316.lee@samsung.com>,
        Liang He <windhl@126.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Xander Li <xander_li@kingston.com.tw>,
        Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Jun 2023 at 03:40, Marek Vasut <marex@denx.de> wrote:
>
> This microSD card never clears Flush Cache bit after cache flush has
> been started in sd_flush_cache(). This leads e.g. to failure to mount
> file system. Add a quirk which disables the SD cache for this specific
> card from specific manufacturing date of 11/2019, since on newer dated
> cards from 05/2023 the cache flush works correctly.
>
> Fixes: 08ebf903af57 ("mmc: core: Fixup support for writeback-cache for eMMC and SD")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: ChanWoo Lee <cw9316.lee@samsung.com>
> Cc: Liang He <windhl@126.com>
> Cc: Seunghui Lee <sh043.lee@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Xander Li <xander_li@kingston.com.tw>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: linux-mmc@vger.kernel.org

[...]

> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 72b664ed90cf6..99ff6e754017a 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1170,7 +1170,7 @@ static int sd_parse_ext_reg_perf(struct mmc_card *card, u8 fno, u8 page,
>                 card->ext_perf.feature_support |= SD_EXT_PERF_HOST_MAINT;
>
>         /* Cache support at bit 0. */
> -       if (reg_buf[4] & BIT(0))
> +       if ((reg_buf[4] & BIT(0)) && !mmc_card_broken_sd_cache(card))
>                 card->ext_perf.feature_support |= SD_EXT_PERF_CACHE;

If the bit in card->ext_perf.feature_support doesn't get set,
according to the above, the cache will never be used.

In other words, there is no need for any of the additional
bail-out-points below, so please drop them.

>
>         /* Command queue support indicated via queue depth bits (0 to 4). */
> @@ -1306,6 +1306,8 @@ static int sd_read_ext_regs(struct mmc_card *card)
>
>  static bool sd_cache_enabled(struct mmc_host *host)
>  {
> +       if (mmc_card_broken_sd_cache(host->card))
> +               return 0;
>         return host->card->ext_perf.feature_enabled & SD_EXT_PERF_CACHE;
>  }
>
> @@ -1366,6 +1368,9 @@ static int sd_enable_cache(struct mmc_card *card)
>         u8 *reg_buf;
>         int err;
>
> +       if (mmc_card_broken_sd_cache(card))
> +               return 0;
> +
>         card->ext_perf.feature_enabled &= ~SD_EXT_PERF_CACHE;
>
>         reg_buf = kzalloc(512, GFP_KERNEL);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index c726ea7812552..daa2f40d9ce65 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -294,6 +294,7 @@ struct mmc_card {
>  #define MMC_QUIRK_TRIM_BROKEN  (1<<12)         /* Skip trim */
>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
>  #define MMC_QUIRK_BROKEN_SD_DISCARD    (1<<14) /* Disable broken SD discard support */
> +#define MMC_QUIRK_BROKEN_SD_CACHE      (1<<15) /* Disable broken SD cache support */
>
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>

Other than the minor thing above, this looks good to me!

Kind regards
Uffe
