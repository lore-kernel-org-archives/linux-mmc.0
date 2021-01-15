Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7979C43381
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 12:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52F623888
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 12:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbhAOMXC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jan 2021 07:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbhAOMXC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2021 07:23:02 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2E5C061794
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 04:22:22 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id 187so938143vsg.4
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 04:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnxXF1b1hlEIRmrDE+jdcwk2oJov3zYkF1GH3eLuWvQ=;
        b=csjJO5DFqfWzvPQVa8dHbqyqTosixO5stfLJRgnyCgauPA0Oje/EYF97CO51xF7YmZ
         r0l+De0om6SU6LlBrNfE0PloSrbVDHF3ku5pLoWAbq8EmcJky/PV++Ww25dTgvJW1ZWN
         GM0NtBJjfw/XbC8D7hcWgpn1wNihG75AAvCK0Llqrv++EP+OjK8/HgtUuIPu2/tjxhsf
         DFUJxSsI9Fn3oi5YygnDq3nXKmFbygO79VzbNPvvpNlmvrJDiK4WO/uoqUXRLFuCgyzE
         sf54W0G9mLQ4nnKT7QTn3FZJK7ShnJ/Pd6c939WpvzispMA9nM+6CqpNKszdsRzEvE/W
         oMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnxXF1b1hlEIRmrDE+jdcwk2oJov3zYkF1GH3eLuWvQ=;
        b=rkV+K+6FhqHZL6cSpOV6JrKHBdE0S5Ikj+SCAEKOiaXU3u259ESwRcDCyO19WviyU1
         +Mt2RuB2bGHb/OLDXX32W2f25ywSTTpjD4TjES3QUG4Ylbm9qFW4x+gBrWc14l2ktou7
         R5qCRelxRmKH689vQUp4UmnceyVD692ottIBdCKC9ciqz03nS6+KL2I32BdykBFab6Ti
         bDlH+wzK1RX6jknd0wseDvPhOnuUOzA3dPGEKZ4RS3o0YPvu3V8xddf32XnZZLUloSut
         d0h1wXN5jXrQ/solnc2jZPPqKplu0avMngKmjpLzuO9pomqX0tKU9l3QSbO0I8ynuvcZ
         L8+Q==
X-Gm-Message-State: AOAM531S4oUJ9L636osEhP8sPJAgk4dFDkFhOHP7TVj3PRTQ1kY3GMOm
        XJNYIXwrERWRLeeaiZ5cxHoJ1EIUv40OCsm3XCv7oQ==
X-Google-Smtp-Source: ABdhPJyS6NQUXL9UmjeWVGTE11NWkeW45TxoEyenaS+avlB2x5ihacWJ8RZMg3sgqie2ZWYwrvxkwSe7w/ghjRfNm0g=
X-Received: by 2002:a67:7f41:: with SMTP id a62mr9737982vsd.55.1610713341234;
 Fri, 15 Jan 2021 04:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20210114201405.2934886-1-pcc@google.com>
In-Reply-To: <20210114201405.2934886-1-pcc@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Jan 2021 13:21:45 +0100
Message-ID: <CAPDyKFr5rSa-FWaXwLtauBYKkj94SCdC-1eDD+guYXboFmLu5A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: don't initialize block size from ext_csd if
 not present
To:     Peter Collingbourne <pcc@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 Jan 2021 at 21:14, Peter Collingbourne <pcc@google.com> wrote:
>
> If extended CSD was not available, the eMMC driver would incorrectly
> set the block size to 0, as the data_sector_size field of ext_csd
> was never initialized. This issue was exposed by commit 817046ecddbc
> ("block: Align max_hw_sectors to logical blocksize") which caused
> max_sectors and max_hw_sectors to be set to 0 after setting the block
> size to 0, resulting in a kernel panic in bio_split when attempting
> to read from the device. Fix it by only reading the block size from
> ext_csd if it is available.
>
> Fixes: a5075eb94837 ("mmc: block: Allow disabling 512B sector size emulation")
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Link: https://linux-review.googlesource.com/id/If244d178da4d86b52034459438fec295b02d6e60

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index de7cb0369c30..002426e3cf76 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -384,8 +384,10 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>                      "merging was advertised but not possible");
>         blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
>
> -       if (mmc_card_mmc(card))
> +       if (mmc_card_mmc(card) && card->ext_csd.data_sector_size) {
>                 block_size = card->ext_csd.data_sector_size;
> +               WARN_ON(block_size != 512 && block_size != 4096);
> +       }
>
>         blk_queue_logical_block_size(mq->queue, block_size);
>         /*
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
