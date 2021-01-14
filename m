Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32D1C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 20:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A244A23976
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 20:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbhANUPk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbhANUPk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2021 15:15:40 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEFAC061575
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2021 12:15:00 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id u26so13800921iof.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2021 12:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lYKk9gFEGFltLyHqftSvPX8sU+c8v7Qr6yY9DVb/Ok=;
        b=XIBg8nGz7KqNAd60aiIGIQBNJow4N1QbunlgLNKxLr1XdNg7VMl0gZr0iD7ZzM7dGj
         zLbbqcYY0QPKVjjAf7tqVEpldX6zsXECMXNDw95cUxTsbekmK6P/7YCpxdEFTq9nJlT+
         AsfJ4rladN1X2De5wnrIyXzCLuH89poBIsCzM7Y0NnNIitbwU6V81S8DsEMk77PHaCyG
         O8ZWagAxGPvYv9tlwG6Q50iyWrDbNaSP8M5ouWQBUfJees0C7fm+KhMMu5+QQAXD8wz8
         YnnG4dY8DTnNO6iYsv25HicHCYwEbqlU3+mpDuJ8wZvvpp0B2xUGsYVaTXlkMhUkDtKY
         mWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lYKk9gFEGFltLyHqftSvPX8sU+c8v7Qr6yY9DVb/Ok=;
        b=F6edqubh5TJd/RVkSAzyX9ryxgcy9Qiz5oOp8ivooLeN3eD+25hbg9CANBG/wCjqBn
         AhvWHMT+jNJZYJOoikQPtSbAy80u19RRt/CagS+d9NRov6tqTbUk+0vfcn44+LYMrBq/
         SBMwQ923GCpDqeL1byksvoPvZt9YmW8bFsxAV4JDcqwMhp/0Mflteewkf0dO+CTWlMvx
         AMIrpme6rLD6dRr4SX+NSsD+zupm0aGn8j4VLMEit1CWSV5FSY19MfRVQRrxc76sQYok
         dtUPJPyknxEDEl4dt4bo8Nk4iv4Q6GnlcsYsQmoNlo6G/Z+PZ14aiFWFCw6EbE5I6sgQ
         kBDA==
X-Gm-Message-State: AOAM530dwxqTKt8aH+whw3gGdcbbmsMOAnahx+1wTsmpZSNwGlikXbVa
        MiOCmMK+08H3pIjY/ibRNyfMEpkErNETToWs7Tz+bA==
X-Google-Smtp-Source: ABdhPJzpNe44a2hZyuDibW48Xgn8N18yHP4UyoHbxzgZHRmOP+FwuoNONcZ31f6JPCjTl/Za1NO7SSxUKcSTX0zDsw0=
X-Received: by 2002:a05:6602:2157:: with SMTP id y23mr6451380ioy.202.1610655299119;
 Thu, 14 Jan 2021 12:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20210112210944.605953-1-pcc@google.com> <34278e68-d69f-0440-858e-b2079b8ac7bb@intel.com>
 <CAMn1gO5Yuy3c48Rscny6mnQAycZeUy-aCwex_r=h_XTMF6Lh-g@mail.gmail.com> <2bba99d2-3c57-d96e-090b-c223372a12c9@intel.com>
In-Reply-To: <2bba99d2-3c57-d96e-090b-c223372a12c9@intel.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 14 Jan 2021 12:14:47 -0800
Message-ID: <CAMn1gO4+DuWcg4pPN55QsjZe8pN2USTRc+Ua8CcmfT7fUmu+fQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: don't initialize block size from ext_csd if
 not present
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jan 13, 2021 at 10:11 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 13/01/21 9:46 pm, Peter Collingbourne wrote:
> > On Wed, Jan 13, 2021 at 2:43 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 12/01/21 11:09 pm, Peter Collingbourne wrote:
> >>> If extended CSD was not available, the eMMC driver would incorrectly
> >>> set the block size to 0, as the data_sector_size field of ext_csd
> >>> was never initialized. This issue was exposed by commit 817046ecddbc
> >>> ("block: Align max_hw_sectors to logical blocksize") which caused
> >>> max_sectors and max_hw_sectors to be set to 0 after setting the block
> >>> size to 0, resulting in a kernel panic in bio_split when attempting
> >>> to read from the device. Fix it by only reading the block size from
> >>> ext_csd if it is available.
> >>>
> >>> Fixes: 817046ecddbc ("block: Align max_hw_sectors to logical blocksize")
> >>
> >> I would go with the original commit i.e.
> >>
> >> Fixes: a5075eb94837 ("mmc: block: Allow disabling 512B sector size emulation")
> >
> > Sure, makes sense.
> >
> >>> Signed-off-by: Peter Collingbourne <pcc@google.com>
> >>> Link: https://linux-review.googlesource.com/id/If244d178da4d86b52034459438fec295b02d6e60
> >>> ---
> >>>  drivers/mmc/core/queue.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> >>> index de7cb0369c30..735cdbf1145c 100644
> >>> --- a/drivers/mmc/core/queue.c
> >>> +++ b/drivers/mmc/core/queue.c
> >>> @@ -20,6 +20,7 @@
> >>>  #include "core.h"
> >>>  #include "card.h"
> >>>  #include "host.h"
> >>> +#include "mmc_ops.h"
> >>>
> >>>  #define MMC_DMA_MAP_MERGE_SEGMENTS   512
> >>>
> >>> @@ -384,7 +385,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
> >>>                    "merging was advertised but not possible");
> >>>       blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
> >>>
> >>> -     if (mmc_card_mmc(card))
> >>> +     if (mmc_card_mmc(card) && mmc_can_ext_csd(card))
> >>>               block_size = card->ext_csd.data_sector_size;
> >>
> >> Might as well be:
> >>
> >>         if (mmc_card_mmc(card) && card->ext_csd.data_sector_size)
> >>                 block_size = card->ext_csd.data_sector_size;
> >
> > Can we rely on this data structure to be zero initialized? I suppose
> > so, provided that it was allocated with mmc_alloc_card which uses
> > kzalloc. But it isn't entirely obvious and I figure it may be a little
> > better to be explicit in our intent here. But either way works for me.
>
> The only valid values are 512 and 4096, so you could add WARN_ON(block_size
> != 512 && block_size != 4096) if you want.

Okay, I did that in v2.

Peter
