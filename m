Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91550C433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Oct 2022 11:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJFL4m (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Oct 2022 07:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiJFL4m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Oct 2022 07:56:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2ED9DDA7
        for <linux-mmc@vger.kernel.org>; Thu,  6 Oct 2022 04:56:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso1703390pjv.0
        for <linux-mmc@vger.kernel.org>; Thu, 06 Oct 2022 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8YdW5ZQbSsoCbC8A2Cj5s8heroqHeLv0q4xh8hgvQKE=;
        b=PFRG+MxDk09uWfW10TE42OouXuAgJ+hLSfoWdWy+xe9ybDy8K65C6RCvP+r8DCbXoZ
         KPSZRzBYrgH+y8lCGbq3yoeVqsC5t8DL1MHXL7oDASaukWc4+XEpFXLeY/e452wwCwAq
         Ri/qypTiazjFlyhkEFUeOwhcFZztfY3Dn3Hjbevki8G7SnqKG/qUQyGx1CoS1VZscsFm
         +rKSm+kcwGggA6TyB/vFNL9E6p0APcCdeiJyDZaaWy6FOp0UFCY6Tbk5gm0REJCuQ68a
         IDFr5Di020IpKwq17rkicTGX2XKuhC1abunNJkFoiD7kHEV5MJi1EnqIPmhXcQGZXH8G
         dYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8YdW5ZQbSsoCbC8A2Cj5s8heroqHeLv0q4xh8hgvQKE=;
        b=vEoI63mcKV87Te7stj+UD4woonFmxWx+fjgbVB2xia2VVE+GhtKOmHspV+5AJSN71N
         Q1G9pbV5QPJMiKLNQfcY2kW5Jl0J4j50TGN65RnSVj/u72fislNnCPU9302FJmPbDDKK
         tJPzT7MPBkT64OjO+yMvOuTAk6VutWeia9JI4fa4SNof1qvIB3FcpmO6NtK1zfAFzyV5
         9qalKmF6mh9IDmOd5T6k1PEDQ3y/l6HOcDZtq95psoYvBok0o9emy5EsfzabfqUkQa47
         GrgSsAfQY/gQIo3xb5AnsGQZfyTRAtdYnIyy9+ZdDd4mBekN5O6wlRC3jFNv4RIy7IrA
         kgFw==
X-Gm-Message-State: ACrzQf36KbtvskkaKI5tJKp9rZ+KOx0HxyeL50YIbdp+Nqas249cosrq
        A6G2EfHlpSlbUj9jlg9U4b36/ExV3WurqeuCStxbE8A98kE=
X-Google-Smtp-Source: AMsMyM6jv6u+JSiYTlBvUO4GayIy7bQOiKh4B35gs8ljPy9X6RIwXKXpDd+O5WfQNtcvyhTl0S8k8z62SwoWDz6x9is=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr10525380pjb.164.1665057400668; Thu, 06
 Oct 2022 04:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220928095744.16455-1-avri.altman@wdc.com>
In-Reply-To: <20220928095744.16455-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 Oct 2022 13:56:04 +0200
Message-ID: <CAPDyKFp4fUJAaad4Onao68xefrHojF_kd716ipnFJjxrfDv32Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: SD: Add BROKEN-SD-DISCARD quirk
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Sept 2022 at 11:58, Avri Altman <avri.altman@wdc.com> wrote:
>
> v1 -> v2:
>  - Address Ulf's suggestions
>
> Some SD-cards that are SDA-6.0 compliant reports they supports discard
> while they actually don't.  This might cause mk2fs to fail while trying
> to format the card and revert it to a read-only mode.
>
> While at it, add SD MID for SANDISK. This is because eMMC MID is assign
> by JEDEC and SD MID is assigned by SD 3c-LLC.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c  | 6 +++++-
>  drivers/mmc/core/card.h   | 6 ++++++
>  drivers/mmc/core/quirks.h | 6 ++++++
>  include/linux/mmc/card.h  | 1 +
>  4 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce89611a136e..54cd009aee50 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1140,8 +1140,12 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_blk_data *md = mq->blkdata;
>         struct mmc_card *card = md->queue.card;
> +       unsigned int arg = card->erase_arg;
>
> -       mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, card->erase_arg);
> +       if (mmc_card_broken_sd_discard(card))
> +               arg = SD_ERASE_ARG;
> +
> +       mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, arg);
>  }
>
>  static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 99045e138ba4..cfdd1ff40b86 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -73,6 +73,7 @@ struct mmc_fixup {
>  #define EXT_CSD_REV_ANY (-1u)
>
>  #define CID_MANFID_SANDISK      0x2
> +#define CID_MANFID_SANDISK_SD   0x3
>  #define CID_MANFID_ATP          0x9
>  #define CID_MANFID_TOSHIBA      0x11
>  #define CID_MANFID_MICRON       0x13
> @@ -258,4 +259,9 @@ static inline int mmc_card_broken_hpi(const struct mmc_card *c)
>         return c->quirks & MMC_QUIRK_BROKEN_HPI;
>  }
>
> +static inline int mmc_card_broken_sd_discard(const struct mmc_card *c)
> +{
> +       return c->quirks & MMC_QUIRK_BROKEN_SD_DISCARD;
> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index be4393988086..29b9497936df 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -100,6 +100,12 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> +       /*
> +        * Some SD cards reports discard support while they don't
> +        */
> +       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
> +                 MMC_QUIRK_BROKEN_SD_DISCARD),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 8a30de08e913..c726ea781255 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -293,6 +293,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_IRQ_POLLING   (1<<11) /* Polling SDIO_CCCR_INTx could create a fake interrupt */
>  #define MMC_QUIRK_TRIM_BROKEN  (1<<12)         /* Skip trim */
>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
> +#define MMC_QUIRK_BROKEN_SD_DISCARD    (1<<14) /* Disable broken SD discard support */
>
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>
> --
> 2.17.1
>
