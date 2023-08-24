Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306AFC7113B
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Aug 2023 10:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbjHXKLv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbjHXKLv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2023 06:11:51 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2039C1985
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 03:11:49 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5920efd91c7so45112807b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692871908; x=1693476708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl1Q50iBdvCe5yXtMKZeggNf2z/kDCkF0CSNbFHkckI=;
        b=MWPeZiaV94eD0r+5t0wdUz9wReNqAYmRAENUMMJEkml4RH2wlEoFqGlDit+EWODwQA
         5ZG4ehZHT9fkISlrVp95oFTdEQwKHpkGxTsn/Oa+djoo1naBWG+DRNh9KZDx+x0uUyNL
         lkgk5aqZ8GpuvHQlymX/f19ZkYdlftRtLDWyBc2HBVNRqCi+JMwmsMdBG92IUaMytyH2
         3npp5YsqUIzJjVXp2INqN26cid6g95//+SeEsv8EuIN4g9PPEIXfjxEPPW9IYbA/V/GO
         Z6vgS6WlFMnff9hs2GXybOmJyjrcaMeF6EA4eF7cRWk/oVE7DabMtnx6g14lhoCR6srH
         zVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692871908; x=1693476708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bl1Q50iBdvCe5yXtMKZeggNf2z/kDCkF0CSNbFHkckI=;
        b=k828GN68vWfoRhDxLrm5WKP6y6YcBzUaTT1qF7UA8NnsylZ4XY1hko/Km8bRhnB33d
         oYd+iLxHzuulpLn/yla/3rVsPkZ153bdqPa8oVXiSnjCaBCfyV77PV1ZRLli6gu26Lz/
         HrHmdvWZ1EGzPLvsRzu+h4AO6MPenvm4L9fb3cszor2UZMZp4iOf278TeqYsFoTBuF3v
         pcHSNLqYXwGm5QYh+RoRGrR+gRXqBBJB6sYPjVQAcQy8V3voiiIot679XFY0QSaxUtbB
         lu8YdMPYRQa000nRqu45LyAES4nwSlogeb5/qbMMe8D9dxjEvBW/6wAymoZfMTfGfVt/
         CBQg==
X-Gm-Message-State: AOJu0YwyaEqZeNhrdqP97Pp8xbD0UAP3pkTPtD8YBL3XUY4UoUWd1p7K
        CabKKoAlObvJ9mcKvyN61Qj+xDMI8jT/ThSiBkfBFOdGvZvF2PJUIxIvtw==
X-Google-Smtp-Source: AGHT+IGvSXY7+rdDaIUHF9HjDvskEigToneQarxKPoW1CYKgFy0fTTrMflFl3uOlx1h55l1O4xnlqO1ip0o2IVD4ULk=
X-Received: by 2002:a0d:e692:0:b0:565:c21d:8ec6 with SMTP id
 p140-20020a0de692000000b00565c21d8ec6mr14885752ywe.6.1692871908391; Thu, 24
 Aug 2023 03:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230815014057.13589-1-wenchao.chen@unisoc.com> <20230815014057.13589-2-wenchao.chen@unisoc.com>
In-Reply-To: <20230815014057.13589-2-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 12:11:12 +0200
Message-ID: <CAPDyKFphAPOSj5L6Q8tdmD0S3EkxTW8EfMyXKsoUU2jqLydx=g@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] mmc: core: Add host specific tuning support for SD
 HS mode
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenchao.chen666@gmail.com,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Aug 2023 at 03:41, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Added .prepare_hs_tuning and .execute_hs_tuning host callbacks to
> support host-specific tuning for SD high speed mode.

Please clarify this is entirely optional, host specific - and that
there is nothing in the SD spec that mentions this.

>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/core/sd.c    | 12 ++++++++++++
>  include/linux/mmc/host.h |  6 ++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 246ce027ae0a..ac2da8f2fbce 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1518,6 +1518,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>                  */
>                 mmc_set_clock(host, mmc_sd_get_max_clock(card));
>
> +               if (host->ops->prepare_hs_tuning) {

Shouldn't we check if we actually succeeded to enable MMC_TIMING_SD_HS
before invoking this callback?

> +                       err = host->ops->prepare_hs_tuning(host, card);
> +                       if (err)
> +                               goto free_card;
> +               }
> +
>                 /*
>                  * Switch to wider bus (if supported).
>                  */
> @@ -1529,6 +1535,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>
>                         mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
>                 }
> +
> +               if (host->ops->execute_hs_tuning) {

Ditto.

> +                       err = host->ops->execute_hs_tuning(host, card);
> +                       if (err)
> +                               goto free_card;
> +               }
>         }
>  cont:
>         if (!oldcard) {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 461d1543893b..13cf894b9e3c 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -184,6 +184,12 @@ struct mmc_host_ops {
>         /* Execute HS400 tuning depending host driver */
>         int     (*execute_hs400_tuning)(struct mmc_host *host, struct mmc_card *card);
>
> +       /* Prepare HS tuning depending host driver */

How about rephrasing this into something along the lines of "Optional
callback to prepare for SD high-speed tuning"

> +       int     (*prepare_hs_tuning)(struct mmc_host *host, struct mmc_card *card);

To make it more clear this if for SD high-speed, maybe we should
rename the callback into:

"prepare_sd_hs_tuning"

> +
> +       /* Execute HS tuning depending host driver */

How about rephrasing this to something along the lines of "Optional
callback to execute SD high-speed tuning"

> +       int     (*execute_hs_tuning)(struct mmc_host *host, struct mmc_card *card);

Maybe execute_sd_hs_tuning instead?

> +
>         /* Prepare switch to DDR during the HS400 init sequence */
>         int     (*hs400_prepare_ddr)(struct mmc_host *host);
>

Kind regards
Uffe
