Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18388C6FA92
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 11:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiI0LqC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 07:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiI0LqA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 07:46:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D9DCE87
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 04:45:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso9246041wmq.4
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cW0PFtHcH315+P0IZunq5r81rk9eIqO6kj1c7fq1huU=;
        b=Th7sqnFELyColCbuae7tXbk4PnDEkUn3Ig4VEp9sVP1gllvkr+Qa3B7E95QONDpJ1v
         RZ+YW48X3RpnSobBhdthpGZXx2sSyZFrA8kXTmrPbFdnrx8LhmyKSGWRmBzfIptwdYmo
         D8qYQy9TVogvtTd63dsfCiipqCfHpqQ2mSO7rAKHlp/3O/dHL/Bo780OAyDHwZtx0008
         V8QEj/sKh74wIr9KaOaMx8ypw3evK8Pm10SNvXjVoRo6COYv5gjrsIb4d9Nrb1IvuFgy
         nD5DVkgLJ8kJCbLWMmtgDvWKvBwMSL17T6DWISLISg+n6+v0HH+idm2tx3u2hoWbOgoS
         RVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cW0PFtHcH315+P0IZunq5r81rk9eIqO6kj1c7fq1huU=;
        b=zf81O8t3JtN7FmKWDy/sd1lBneg0mZSLpIv07X/U48exAuvlNjw1fVMRabKGiojbcR
         NE6QCdnMtVH6A2nVdTOg3bpCqxXhJOwnMRdUBJXrCK9W2Mf78jvSzffLBf0XDvC7AP14
         j8N1Q0IRzjspLOkAz3a4gbDC9Lmw4JJvRtdd5CRCOCamME/i29X3RoNE4XFHwgmLEAkr
         ZpFLtlx38V/NZJEjRpmEbiT/7u/1ZHRwOeU5x7M2CC0QEMffwMEzCgpAVXiS3Fv4klxQ
         87DrT+dn0lk3m+mDj0ntPmrkp0yaIB+FGjBXAIl2Nbc3GOj3TzJeTUPt1Zk7e+fajIq2
         9zow==
X-Gm-Message-State: ACrzQf2tF6UfVPbYYvGBKkv2DGFN691PLfVYtC/TM3DVGAiKV0RPbRzM
        DqWaSgH0pKGrz+rKjThgGDGiDMuqr8Yx8d8ILMMbzQ==
X-Google-Smtp-Source: AMsMyM7P+f509M72pNs5+zL9lV4mgm5EFtN+3jo5Pk3JHiE+HZ1cILCZDE6oXX9GIq/dkHnMZc+AJ6PahlgLSMV5hNc=
X-Received: by 2002:a05:600c:4f8d:b0:3b4:9f2f:4311 with SMTP id
 n13-20020a05600c4f8d00b003b49f2f4311mr2262067wmq.17.1664279157160; Tue, 27
 Sep 2022 04:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220923135617.46-1-avri.altman@wdc.com>
In-Reply-To: <20220923135617.46-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Sep 2022 13:45:20 +0200
Message-ID: <CAPDyKFr2+PmmmOoOo-YzaogdaCRCW=CB2PdZcSGdoMjOj0zA_A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: SD: Add BROKEN-SD-DISCARD quirk
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

On Fri, 23 Sept 2022 at 15:56, Avri Altman <avri.altman@wdc.com> wrote:
>
> Some SD-cards that are SDA-6.0 compliant reports they supports discard
> while they actually don't.  This might cause mk2fs to fail while trying
> to format the card and revert it to a read-only mode.
>
> While at it, add SD MID for SANDISK. This is because eMMC MID is assign
> by JEDEC and SD MID is assigned by SD 3c-LLC.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c  | 6 +++++-
>  drivers/mmc/core/card.h   | 1 +
>  drivers/mmc/core/quirks.h | 6 ++++++
>  include/linux/mmc/card.h  | 1 +
>  4 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce89611a136e..a31dc915c5ec 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1140,8 +1140,12 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_blk_data *md = mq->blkdata;
>         struct mmc_card *card = md->queue.card;
> +       unsigned int arg = card->erase_arg;
>
> -       mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, card->erase_arg);
> +       if (mmc_card_sd(card) && (card->quirks & MMC_QUIRK_BROKEN_SD_DISCARD))

There's no need for the mmc_card_sd() here, as the quirk can't be set
unless it's the SD card type (see add_quirk_sd()).

Moreover, I would prefer if we can use a helper function
(mmc_card_broken_sd_discard()), that checks the new quirk bit. Similar
helpers are already available in drivers/mmc/core/card.h.

> +               arg = SD_ERASE_ARG;
> +
> +       mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, arg);
>  }
>
>  static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 99045e138ba4..881432309b46 100644
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

Other than the minor nitpicks above, this looks good to me!

Kind regards
Uffe
