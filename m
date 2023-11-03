Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531FAC4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Nov 2023 11:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbjKCLQ7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Nov 2023 07:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346471AbjKCLQ4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Nov 2023 07:16:56 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4643C1BF
        for <linux-mmc@vger.kernel.org>; Fri,  3 Nov 2023 04:16:53 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9ad67058fcso1930608276.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Nov 2023 04:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699010212; x=1699615012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/bnG70HwW3iO72CF0/4itOzvrNtdpkPDD7Xih6QQ8lo=;
        b=Tu0xmNWsQ4yH2sbys9vS9BOvbtpYa3ssLU0ejfBcHC+v9MEZl8bMPYk6IMZdBySPUU
         5/UUxpbJ52y53QcvamQZ+mnTSjn2jjVKSFPKUGkYJS8gXcEQNSD3aE4laBKNDQ87B2xc
         ObG9Zyh2SE70S7FDsZ7F6qn0r6Z9199RMSBcKTLn7oKomaZpE3bsSnQsUPTf9E0t7AUU
         /MfuL4QBsRF+wfyVIEIp9zx0jHWe4ioIJEHUs/Egv9ApIe7f2PkZZmGnPz0Mr610JJ/M
         0wEnUHCz7HPyXSYK+9qg2fuZmSLFNuSKj8BywJPPjknF51Mi3zD0v5orrWqFgrIGgKct
         508A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010212; x=1699615012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bnG70HwW3iO72CF0/4itOzvrNtdpkPDD7Xih6QQ8lo=;
        b=HVEpWPe00e1Na1OIFOamQJ/5Un0p6DIaRFPsIbMvnQTZcpED+PdDLGJeQTig7ifIs6
         w1751uvti/20VoSBbwbcthHudVl3ltz3piDUKwlpjd3UxHovhrgNpVL6bmIND8qzMer0
         ZPb3BK1dlzKMRv0qnwEi0X2CdsoJh0M27D6/NOT3xH88KfDdB/hnyUtIGS54LDJKaPO8
         Fbh9D8kY89A1VKAMdQ0l0JX3TUpOj5UoMrhiSq9rHiLR3uiA9YRq7QxTSW9oApxB311R
         wJEwOw1TMB88xrD6OUZ9fXcRUvAnEGTKjHYEAik1hEc04f9Qu6ZaaLNmEyPMCPP5zTls
         l99g==
X-Gm-Message-State: AOJu0YwwiWBcXTAYMso3TflHZ0oi1O9Hkqq+IErllsI2J1ndMSuZBp7w
        FmLiGSFKeJwstn4eGz+U0sm1ckhIezGZY0XV7BbSSQ==
X-Google-Smtp-Source: AGHT+IEXTzL2QO+gTiJqUA6q4a7gjIAAnUOgnpabV9KOAPQ6A0FsX2NCHedPda00oErtIg1w+Zm70o7SWllTKyODvIA=
X-Received: by 2002:a25:da0d:0:b0:d85:eac0:c7d2 with SMTP id
 n13-20020a25da0d000000b00d85eac0c7d2mr19685721ybf.6.1699010212336; Fri, 03
 Nov 2023 04:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231030224809.59245-1-beanhuo@iokpp.de>
In-Reply-To: <20231030224809.59245-1-beanhuo@iokpp.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Nov 2023 12:16:16 +0100
Message-ID: <CAPDyKFqXa_nVBTSXwUqecAAiDkFxdqHjq1QOWbe0Oa9kkvpEZA@mail.gmail.com>
Subject: Re: [v5] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron eMMC Q2J54A
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     cLoehle@hyperstone.com, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>,
        Rafael Beims <rafael.beims@toradex.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 30 Oct 2023 at 23:48, Bean Huo <beanhuo@iokpp.de> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Micron MTFC4GACAJCN eMMC supports cache but requires that flush cache
> operation be allowed only after a write has occurred. Otherwise, the
> cache flush command or subsequent commands will time out.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> Changelog:
> v4--v5:
>     1. In the case of a successful flush, set writing_flag in _mmc_flush_cache()
> v3--v4:
>     1. Add helper function for this quirk in drivers/mmc/core/card.h.
>     2. Set card->written_flag only for REQ_OP_WRITE.
> v2--v3:
>     1. Set card->written_flag in mmc_blk_mq_issue_rq().
> v1--v2:
>     1. Add Rafael's test-tag, and Co-developed-by.
>     2. Check host->card whether NULL or not in __mmc_start_request() before asserting host->card->->quirks
> ---
>  drivers/mmc/core/block.c  | 4 +++-
>  drivers/mmc/core/card.h   | 4 ++++
>  drivers/mmc/core/mmc.c    | 8 ++++++--
>  drivers/mmc/core/quirks.h | 7 ++++---
>  include/linux/mmc/card.h  | 2 ++
>  5 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 3a8f27c3e310..152dfe593c43 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2381,8 +2381,10 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>                         }
>                         ret = mmc_blk_cqe_issue_flush(mq, req);
>                         break;
> -               case REQ_OP_READ:
>                 case REQ_OP_WRITE:
> +                       card->written_flag = true;
> +                       fallthrough;
> +               case REQ_OP_READ:
>                         if (host->cqe_enabled)
>                                 ret = mmc_blk_cqe_issue_rw_rq(mq, req);
>                         else
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 4edf9057fa79..b7754a1b8d97 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -280,4 +280,8 @@ static inline int mmc_card_broken_sd_cache(const struct mmc_card *c)
>         return c->quirks & MMC_QUIRK_BROKEN_SD_CACHE;
>  }
>
> +static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
> +{
> +       return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
> +}
>  #endif
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 8180983bd402..11053f920ac4 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2086,13 +2086,17 @@ static int _mmc_flush_cache(struct mmc_host *host)
>  {
>         int err = 0;
>
> +       if (mmc_card_broken_cache_flush(host->card) && !host->card->written_flag)
> +               return err;
> +
>         if (_mmc_cache_enabled(host)) {
>                 err = mmc_switch(host->card, EXT_CSD_CMD_SET_NORMAL,
>                                  EXT_CSD_FLUSH_CACHE, 1,
>                                  CACHE_FLUSH_TIMEOUT_MS);
>                 if (err)
> -                       pr_err("%s: cache flush error %d\n",
> -                              mmc_hostname(host), err);
> +                       pr_err("%s: cache flush error %d\n", mmc_hostname(host), err);
> +               else
> +                       host->card->written_flag = false;
>         }
>
>         return err;
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 32b64b564fb1..5e68c8b4cdca 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -110,11 +110,12 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>                   MMC_QUIRK_TRIM_BROKEN),
>
>         /*
> -        * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
> -        * support being used to offload WRITE_ZEROES.
> +        * Micron MTFC4GACAJCN-1M supports TRIM but does not appear to suppor
> +        * WRITE_ZEROES offloading. It also supports caching, but the cache can
> +        * only be flushed after a write has occurred.
>          */
>         MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
> -                 MMC_QUIRK_TRIM_BROKEN),
> +                 MMC_QUIRK_TRIM_BROKEN | MMC_QUIRK_BROKEN_CACHE_FLUSH),
>
>         /*
>          * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index daa2f40d9ce6..7b12eebc5586 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -295,7 +295,9 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
>  #define MMC_QUIRK_BROKEN_SD_DISCARD    (1<<14) /* Disable broken SD discard support */
>  #define MMC_QUIRK_BROKEN_SD_CACHE      (1<<15) /* Disable broken SD cache support */
> +#define MMC_QUIRK_BROKEN_CACHE_FLUSH   (1<<16) /* Don't flush cache until the write has occurred */
>
> +       bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>
>         unsigned int            erase_size;     /* erase size in sectors */
> --
> 2.34.1
>
