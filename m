Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A5C433E9
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977D923358
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 17:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbhATR3n (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390165AbhATOJD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 09:09:03 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC55CC0613CF
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 06:08:22 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id k9so5687895vke.4
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 06:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yuYd0oPowGkxYlpvWp25gunp0Rm2AZcot0EW1oLqcA=;
        b=QeF5IRoVM/96DbzFmBtOzGI6ulIok9zjigjtK8VxGGgoPDH8H2hZmMljVyXmV16d4e
         4Yw9niP3Bp3SumCYp/oXmRBF4y73ZAFaiPFd8mczeWnJJRW97lkvtk5W176tdmk/zF5e
         y4lB2tM7w27Yr0I1rhzioyg3OqsRT7Kf/KU5HdM7X950uyilAIyV9sqjDB7s1/94+my6
         Wr7ommEraRK8O8SE8b5w6cB3CJwH4/qkhff7gKNJXPfCMR8+7GTZtpXXL3XLFkxN1Hq7
         ThCaD2fcrZ5GvacUXvKvOpro4wW2om/8o8Gf9OSpxzgzAB+8J/pq22lUHXqsd8ywCq5F
         JV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yuYd0oPowGkxYlpvWp25gunp0Rm2AZcot0EW1oLqcA=;
        b=oN/KcTfZYhVKz0cMqnTfn2RSy6heGZfTPj/HIP8w3nRHsgYWH9/kYaLz6PnRV9IOUo
         yHXuTxJpxEMBWu9xoiPbG3kBEgtwZNs/bK8WrRGbUNtd9O9VF368a6XbyBri7GumM8Mk
         Pi/0YiF1FE8N8nBz35aFqw7Iu7SkroUn3fEJv/W2OWi2Hx5rT9Zm/K6kSPLCTsEMiP/v
         DulufIhBn3PR2/MWvyq8Y2bf7RRzKbh5XN9xlqH3xCfAtPwL86G0ArMmRC09XzJrEL3Y
         qBRHnXqqsB4TwXnnrFqgT/ilTTeD/ckcz+084CL/GlGCaeiOxjfrZhN6H90U3XOD7Hx5
         VJMQ==
X-Gm-Message-State: AOAM531icKORp20SvTMOvMne3/P683VP7ockPO/r9zIn9gLfbrH1DmsL
        Lfn7hM7bRO2YqgkDDhi+JqLQMhd/gfpevVCUkgGSSw==
X-Google-Smtp-Source: ABdhPJz6M+BPmVNSztofB1Zs6zVNJhx0ylJZX8DRD5+bAXaXzsmmpFnRhJVy59llitExc/bQP68Mp6bnlSXbhvaOpKI=
X-Received: by 2002:a1f:4582:: with SMTP id s124mr6975512vka.7.1611151701878;
 Wed, 20 Jan 2021 06:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20210118084520.241-1-zbestahu@gmail.com>
In-Reply-To: <20210118084520.241-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 15:07:44 +0100
Message-ID: <CAPDyKFp4h=hLeeoCHKqGRx3V0TabiT1dDO4FTCPnkukm=Wh-ew@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: remove unused host parameter of mmc_sd_get_csd()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Yue Hu <huyue2@yulong.com>, zhangwen@yulong.com,
        zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 Jan 2021 at 09:45, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> The host parameter is not used in the body of mmc_sd_get_csd(),
> so let's remove it. Update related code at the same time.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: fix minor commit message.
>
>  drivers/mmc/core/sd.c   | 4 ++--
>  drivers/mmc/core/sd.h   | 2 +-
>  drivers/mmc/core/sdio.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6f054c4..6fa51a6 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -860,7 +860,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>         return err;
>  }
>
> -int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card)
> +int mmc_sd_get_csd(struct mmc_card *card)
>  {
>         int err;
>
> @@ -1046,7 +1046,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>         }
>
>         if (!oldcard) {
> -               err = mmc_sd_get_csd(host, card);
> +               err = mmc_sd_get_csd(card);
>                 if (err)
>                         goto free_card;
>
> diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
> index 497c026..1af5a03 100644
> --- a/drivers/mmc/core/sd.h
> +++ b/drivers/mmc/core/sd.h
> @@ -10,7 +10,7 @@
>  struct mmc_card;
>
>  int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
> -int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card);
> +int mmc_sd_get_csd(struct mmc_card *card);
>  void mmc_decode_cid(struct mmc_card *card);
>  int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>         bool reinit);
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 694a212..0fda778 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -751,7 +751,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>          * Read CSD, before selecting the card
>          */
>         if (!oldcard && card->type == MMC_TYPE_SD_COMBO) {
> -               err = mmc_sd_get_csd(host, card);
> +               err = mmc_sd_get_csd(card);
>                 if (err)
>                         goto remove;
>
> --
> 1.9.1
>
