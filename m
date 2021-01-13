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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A5CC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 19:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226A8206F1
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbhAMTrT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 14:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbhAMTrT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 14:47:19 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0805EC061575
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 11:46:39 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id u26so6581181iof.3
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 11:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5S3fbVh75sTrcXZaOEMGuqYwwTThAkZV2dyVGj7pY0=;
        b=b3Rcn4maSoEfnDlFNSf4teaXnDsu8Hk8pPpLRG65UOdodc7SMWyz5mkCmMUzKxH1Zp
         EXqbNvWhwzqZX9mx/Fdy+D4kCKa1nzxhB8RZyR8l+fhkS2Qf9KCBsKpid2iYboE0Bu8A
         d4zP57faMpOrcVULkpHV68983L3DgO4J7TzP40v5ZuJiZx41dK1qvUk0qsi0HcsJmQMu
         S7a729CMo1r48YiTxaaZnm5rbO0MRYppU6kXNckZpFArajCsocQsE3g2FhnMv5fbd2+6
         QvdvewLdkGF0Cm3uv4T4M3U1e0+RvuWryUjPfB6CwcQUQPaqnTJ8j98q2PsM0+D+RtpQ
         ns7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5S3fbVh75sTrcXZaOEMGuqYwwTThAkZV2dyVGj7pY0=;
        b=XemZbYvHIPkdd9X5eaJkYfPjJr2ZHoypLpIXLHrfLhvKIzTPVq7JEcqicVGa0JZTF3
         e568tJ2wP/Y7VuumCiXoRCCXTTv8GjF7KPVoE97BAe3qU+fT5ipr+utn2h5kGQWZQUrG
         vFw7fxksN5hqHZz2b/s4faPTHedIu/8zB/auqOqywYPU+PvjKex6vOuF9ph9VBIpYsgp
         13wsahiOBK80cA6KIFhKh0I3z7i03vKKV9UrShUp/aVLpofvI5grLZX76mbStz/cHGE1
         uPJo6WhL3DGS3JRYejiO2vxu6zhicK07LLYgMmUdi1qvKIhUqmEAm1pktNtjQct486mV
         Joig==
X-Gm-Message-State: AOAM530DmekKwc/KbUuyMkCYKko7i2hAODOc6ML10+xteeVUBqgU9wtn
        8kyujHwF4iYSVqpTpSYnvqwa7uupK66AKN1eyGXjfw==
X-Google-Smtp-Source: ABdhPJy05DICZCPL1zdxNmpJef+jP3oPkoG5Kuk3c6L0Zs41kOpW4nxvaOEyGScDCxTufBM3+nG9pgMRyDCFIXm2jQA=
X-Received: by 2002:a5e:dd0d:: with SMTP id t13mr2961246iop.132.1610567198273;
 Wed, 13 Jan 2021 11:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20210112210944.605953-1-pcc@google.com> <34278e68-d69f-0440-858e-b2079b8ac7bb@intel.com>
In-Reply-To: <34278e68-d69f-0440-858e-b2079b8ac7bb@intel.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 13 Jan 2021 11:46:24 -0800
Message-ID: <CAMn1gO5Yuy3c48Rscny6mnQAycZeUy-aCwex_r=h_XTMF6Lh-g@mail.gmail.com>
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

On Wed, Jan 13, 2021 at 2:43 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 12/01/21 11:09 pm, Peter Collingbourne wrote:
> > If extended CSD was not available, the eMMC driver would incorrectly
> > set the block size to 0, as the data_sector_size field of ext_csd
> > was never initialized. This issue was exposed by commit 817046ecddbc
> > ("block: Align max_hw_sectors to logical blocksize") which caused
> > max_sectors and max_hw_sectors to be set to 0 after setting the block
> > size to 0, resulting in a kernel panic in bio_split when attempting
> > to read from the device. Fix it by only reading the block size from
> > ext_csd if it is available.
> >
> > Fixes: 817046ecddbc ("block: Align max_hw_sectors to logical blocksize")
>
> I would go with the original commit i.e.
>
> Fixes: a5075eb94837 ("mmc: block: Allow disabling 512B sector size emulation")

Sure, makes sense.

> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/If244d178da4d86b52034459438fec295b02d6e60
> > ---
> >  drivers/mmc/core/queue.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > index de7cb0369c30..735cdbf1145c 100644
> > --- a/drivers/mmc/core/queue.c
> > +++ b/drivers/mmc/core/queue.c
> > @@ -20,6 +20,7 @@
> >  #include "core.h"
> >  #include "card.h"
> >  #include "host.h"
> > +#include "mmc_ops.h"
> >
> >  #define MMC_DMA_MAP_MERGE_SEGMENTS   512
> >
> > @@ -384,7 +385,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
> >                    "merging was advertised but not possible");
> >       blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
> >
> > -     if (mmc_card_mmc(card))
> > +     if (mmc_card_mmc(card) && mmc_can_ext_csd(card))
> >               block_size = card->ext_csd.data_sector_size;
>
> Might as well be:
>
>         if (mmc_card_mmc(card) && card->ext_csd.data_sector_size)
>                 block_size = card->ext_csd.data_sector_size;

Can we rely on this data structure to be zero initialized? I suppose
so, provided that it was allocated with mmc_alloc_card which uses
kzalloc. But it isn't entirely obvious and I figure it may be a little
better to be explicit in our intent here. But either way works for me.

Peter
