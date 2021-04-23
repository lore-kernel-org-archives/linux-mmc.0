Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FD5C433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 08:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A25E613AD
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 08:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbhDWIPb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Apr 2021 04:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbhDWIPa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Apr 2021 04:15:30 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A7C06174A
        for <linux-mmc@vger.kernel.org>; Fri, 23 Apr 2021 01:14:51 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id b8so7790794vsu.8
        for <linux-mmc@vger.kernel.org>; Fri, 23 Apr 2021 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GMFn2cur8SrV9Ee+5W2clOCMlH7QL1pNxnb7A8dZKjw=;
        b=A5COx/a+h7x4MQF8S9NQjNMRt8dPwnpfYxqd95vH8GWQ6peJI62TrZsTjXBHNUG81v
         nYyXLTazc2OgijovXo2q2L35DuIYru3iLaYkWn2ZMbwp55GvzbEXCjHRg5fppYay3Uy3
         YdhqnD/nxVDjNMXDoe7chzVxYiqUVyfhYg04RfOxrI4QzVFfvIvqg+oTdPojVEF2mDya
         Mvkxh5lYIlYc4KP8pYSk8NGHqJhTrPhFVG3+eg7RtXvmVE5neAJ6L9OK0b0RCN+jXYSK
         UFI07OLDVxDVQfGLB6IdtXvegDKad+fSljNFy47oyQ8SwA0roWyR05w7At+QktKv1Nh5
         fMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GMFn2cur8SrV9Ee+5W2clOCMlH7QL1pNxnb7A8dZKjw=;
        b=Ylu9DnOimUDIonvUFxiTMfnhg9Tf3p3kwFPEebJV00DRBzQ9ymWVhM6KWNK7A9tnqu
         dxlV6Kmukwl9H1kfnGSRFw56CFumw+ucnV9nFmbtTuUbZhkOXlbxSFCWpEFlDCekls4n
         5RkW+3wl7HgovB5KfoQCrvn0Zqfce/ZEIdjQMjP0krfG5JsE028EaON5qmnOg7M7B4Fz
         we7XQH/zOZjiBiEwp+sLGgdkRzGXYzFNU2NiYlbzeDsRndgXfKXiiuT+cJ476w3zyxbY
         UmWeQCl3t7a59mjjW2J0usYlSZqRyLkdzwQfQ4wdj1upLHDMStIE9CYknF+sfatCOklk
         RRGw==
X-Gm-Message-State: AOAM531QVCZC+gs3SwAtwrJwGi/3FjIs8nClSfGVZfsvaf+G72Kxal3Q
        ye4YKFUO2DwBmjeNf71r3dIrDCKo8e1gubnoWBN3bA==
X-Google-Smtp-Source: ABdhPJxIvSz3yw05lnDAjMh107swAa9Dw9VrtEFVTDWNxK0fvLlh+evM9UjPlnNMToaujh4Lit6LGBJ4MnPe5Nbvo3Y=
X-Received: by 2002:a67:dd04:: with SMTP id y4mr2164981vsj.55.1619165691222;
 Fri, 23 Apr 2021 01:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210420134641.57343-1-avri.altman@wdc.com> <20210420134641.57343-2-avri.altman@wdc.com>
In-Reply-To: <20210420134641.57343-2-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 23 Apr 2021 10:14:15 +0200
Message-ID: <CAPDyKFoejcQz2jPgqzc+2W+mfaXOatGCdd8CdNYsk4FsUEb=7Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mmc: block: Issue flush only if allowed
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Peter <bpeter@lytx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Apr 2021 at 15:46, Avri Altman <avri.altman@wdc.com> wrote:
>
> The cache may be flushed to the nonvolatile storage by writing to
> FLUSH_CACHE byte (EXT_CSD byte [32]). When in command queueing mode, the
> cache may be flushed by issuing a CMDQ_TASK_ DEV_MGMT (CMD48) with a
> FLUSH_CACHE op-code.  Either way, verify that The cache function is
> turned ON before doing so.
>
> fixes: 1e8e55b67030 (mmc: block: Add CQE support)
>
> Reported-by: Brendan Peter <bpeter@lytx.com>
> Tested-by: Brendan Peter <bpeter@lytx.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c   | 9 +++++++++
>  drivers/mmc/core/mmc.c     | 2 +-
>  drivers/mmc/core/mmc_ops.h | 5 +++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8bfd4d95b386..24e1ecbdd510 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2186,6 +2186,11 @@ static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host)
>         return mmc_blk_rw_wait(mq, NULL);
>  }
>
> +static bool mmc_blk_cache_disabled(struct mmc_card *card)
> +{
> +       return mmc_card_mmc(card) && !mmc_flush_allowed(card);

It's these kinds of use with mmc_card_mmc() that I think we need to
strive towards avoiding when going forward.

For example, newer SD cards support both cache and command queueing
nowadays, which means that we need to make the code in the mmc block
layer more agnostic. To do that, I think we should use the bus_ops
callbacks. That's why I started out by adding the ->flush_cache()
callback in the other patch.

> +}
> +
>  enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_blk_data *md = mq->blkdata;
> @@ -2225,6 +2230,10 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>         case MMC_ISSUE_ASYNC:
>                 switch (req_op(req)) {
>                 case REQ_OP_FLUSH:
> +                       if (mmc_blk_cache_disabled(mq->card)) {

I suggest that you add a new bus ops callback ->cache_enabled() and
implement it for the mmc bus type.

From the mmc block layer point of view, it would then mean that if the
callback isn't implemented, the cache ctrl isn't supported (which
would be the case for SD then)

> +                               blk_mq_end_request(req, BLK_STS_OK);
> +                               return MMC_REQ_FINISHED;
> +                       }
>                         ret = mmc_blk_cqe_issue_flush(mq, req);

>                         break;
>                 case REQ_OP_READ:
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 9ad4aa537867..e3da62ffcb5e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2037,7 +2037,7 @@ static int _mmc_flush_cache(struct mmc_card *card)
>  {
>         int err = 0;
>
> -       if (card->ext_csd.cache_size > 0 && card->ext_csd.cache_ctrl & 1) {
> +       if (mmc_flush_allowed(card)) {
>                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                  EXT_CSD_FLUSH_CACHE, 1,
>                                  CACHE_FLUSH_TIMEOUT_MS);
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 5782fdf4e8e9..2682bf66708a 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -19,6 +19,11 @@ enum mmc_busy_cmd {
>  struct mmc_host;
>  struct mmc_card;
>
> +static inline bool mmc_flush_allowed(struct mmc_card *card)
> +{
> +       return card->ext_csd.cache_size > 0 && card->ext_csd.cache_ctrl & 1;
> +}
> +
>  int mmc_select_card(struct mmc_card *card);
>  int mmc_deselect_cards(struct mmc_host *host);
>  int mmc_set_dsr(struct mmc_host *host);
> --
> 2.25.1
>

Having said the above, we clearly want to tag $subject patch for
stable kernels as well, which means we need a simple patch as
possible.

Clearly $subject patch should have come first, prior to my patch where
I added the ->flush_cache() bus ops callback, as it messes things up.

Therefore, I decided to rebase my next branch to drop the patch adding
the ->flush_cache() bus ops (I will re-post the patch after we have
got your changes in).

Can you please re-base $subject patch and address my comments? My
apologies for the mess!

Kind regards
Uffe
