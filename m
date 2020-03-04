Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCF1C3F2CD
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 13:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C7721775
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 13:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXhTLmYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgCDNdV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:33:21 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34928 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCDNdV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 08:33:21 -0500
Received: by mail-vs1-f65.google.com with SMTP id u26so1125838vsg.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2020 05:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WK/SfUKJ4qLwiJfDG3bRE+m5n/e1+qy4B+5tSoOdUjI=;
        b=mXhTLmYnbxp3NGJBm2fLLwiOFpg4utL0ZvvAGrP3wws69pQd33Vqf1Vt9HWT6hxZTI
         DTsTfR4rLUCxcZE0Wo/O7/GnOqIFre0IEmwYuyUcc0plxZWhunisStVpylhR6xwPN96z
         LNyjD9X9PBXJ6OhICWmbGG43Zar6M5/hQBhTv2clJsyjDh/zY4KeRta1x9/6Mqnsj+VT
         p1+jEFbmS0TsP9twHls1AdKov0bHK0PFrOQIzkrbQ8auWwK1z+596Mt6uih3iGnSUw/G
         NBUwGE2xJgNAftSZNgIrj2zO/OHkFlZboSCjjrIPdI/VFCfLCWuPUo2lL+JxP3IKllak
         KdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WK/SfUKJ4qLwiJfDG3bRE+m5n/e1+qy4B+5tSoOdUjI=;
        b=Lle7LR6XcHgHSuMr6oL1/qVzCIrVLCZ/2RMCXk90FxX0jefUR4jV/X7i1FRyGtalVr
         pONTYPughUvzpC3PFhEoULiVDpVF2kWFYqdmNw2HmQ++zPvcaBrEsojgwocqgSAPmOU8
         ujnRHMGbAYrTkyJRvWsoljiLkI+uiZMry76OI/Zc89fugixcdtb8m34jf6DBVGT+R1DM
         7YEyNs+IZSjB806W2rva0+nJiuhuJHLRS/eKlD+i1TGknIsU4ZbgI9s7WtdbEAjsld6f
         vBOuBmulYiqUGKqviDhnilIFOAeKLI20h8uT/2TiUUPmQUL4UpPaKfsRZvoyzn3EhsLt
         V9GQ==
X-Gm-Message-State: ANhLgQ0uZSGBBoaDWl3OmYYUwT2SqRrpV3dKx9YWOBn/Cx0Ua8m+YrVb
        j7wdjaR5S0EAf7LTVt6j69ySxJys9/87P7jeZvxVPA==
X-Google-Smtp-Source: ADFU+vtkGhPWxq874jiOPuWMmWbeOF9C2L8p95YqXUtPaaS9hGfoHBz9H7CpGVMsa0Ad41AQvP/MKcnVITgI8DNnKv0=
X-Received: by 2002:a67:800e:: with SMTP id b14mr1682326vsd.191.1583328798137;
 Wed, 04 Mar 2020 05:33:18 -0800 (PST)
MIME-Version: 1.0
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com> <1582100757-20683-9-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1582100757-20683-9-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 14:32:42 +0100
Message-ID: <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] mmc: queue: create dev->dma_parms before call dma_set_max_seg_size()
To:     Haibo Chen <haibo.chen@nxp.com>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Christoph, Arnd

On Wed, 19 Feb 2020 at 09:31, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> To make dma_set_max_seg_size() work, need to create dev->dma_parms.
>
> Find this issue on i.MX8QM mek board, this platform config the
> max_segment_size to 65535, but this dma_set_max_seg_size do not
> actuall work, find sometimes the segment size is 65536, exceed
> the hardware max segment limitation, trigger ADMA error.

Sounds like we want something along the lines of this to be tagged for
stable as well.

>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/core/queue.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 9edc08685e86..91094e56f7c9 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -359,6 +359,7 @@ static const struct blk_mq_ops mmc_mq_ops = {
>  static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> +       struct device *dev = mmc_dev(host);
>         unsigned block_size = 512;
>
>         blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
> @@ -366,13 +367,12 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>         if (mmc_can_erase(card))
>                 mmc_queue_setup_discard(mq->queue, card);
>
> -       if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
> +       if (!dev->dma_mask || !*dev->dma_mask)
>                 blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
>         blk_queue_max_hw_sectors(mq->queue,
>                 min(host->max_blk_count, host->max_req_size / 512));
>         if (host->can_dma_map_merge)
> -               WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
> -                                                       mmc_dev(host)),
> +               WARN(!blk_queue_can_use_dma_map_merging(mq->queue, dev),
>                      "merging was advertised but not possible");

If we plan to send this to stable, I rather make all the changes above
as a separate clean-up patch.

>         blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
>
> @@ -389,7 +389,10 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>                 blk_queue_max_segment_size(mq->queue,
>                         round_down(host->max_seg_size, block_size));
>
> -       dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
> +       if (!dev->dma_parms)
> +               dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
> +                                               GFP_KERNEL);

I think this normally should be managed by the host driver, typically
while it runs its ->probe() function.

On the other hand, it seems like not many host drivers does this,
which makes me wonder a bit of how this is intended to work. I guess
we can always do the allocation here if it's not been done before.

Also, I see the drivers/mmc/host/alcor.c calls dma_set_max_seg_size(),
so I am guessing that calls fails as well. Hmm.


> +       dma_set_max_seg_size(dev, queue_max_segment_size(mq->queue));
>
>         INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
>         INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
> --
> 2.17.1
>

Kind regards
Uffe
