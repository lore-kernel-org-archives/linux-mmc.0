Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF673C432BE
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91CD861037
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbhHDLf4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237722AbhHDLfu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2021 07:35:50 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28FAC0613D5
        for <linux-mmc@vger.kernel.org>; Wed,  4 Aug 2021 04:35:36 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id a8so824210vsl.4
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2021 04:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=089KtpyaglCJJAPJEDJa5d2oc8GCusHeX3YJHgV4Yns=;
        b=dUFQ9aZwQs3sD02koMOt7sfnUYDoFBmQnwfrsLDQbRTz59Kvq6O45Q3OI12nKbR6Rh
         7YR6ZTZDVCcpenn8tY3V9uu+Xia4jzBYn38tRRbp6cXIzPoQs8jjtbYgOmxpx4x18t+T
         JYk/Ma0PeCz8esSlKwpdk5564NFl3t9jSt640cZSwqdujy86B1qeVnKeMxtVFRu4zR3W
         iZRLArx550TSoly3X9m3rYRCKCNr+zTc/N5Q7k0gCKYqbSEtKhl/rwGUSiX2Y84+3UcI
         agYRVYxCFoyH5Zg40MpfJPt5s9CJTJsCDUblMbxeGvqU6YP+4kPYabXESWeg4Cg0fuE7
         TCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=089KtpyaglCJJAPJEDJa5d2oc8GCusHeX3YJHgV4Yns=;
        b=C5T7Y6/6cxII6FzOtG+d4Qqvo7+wQI13aBxv+i7kNYEVIo3vvzmhzOJ6hE6GmKi0q5
         /FMDQepQu0oQ2JyjnWXB9i0YoWo1mM7F0pEPOotoIeYNxemGJ4L22DV9Vxm/9hU9xwPf
         na5ba2xmfB2jcovBEuGVHlrRAeABsFfLDGNkWHZ2mFAMWNSMPVRXAnCwXLSDdRvw/Jls
         DY9Bozk0ajjLh8hqJ84yW7ASD6i21+AD8NAsgf4UCghMWw2SRN2JtM7t/tbdQFUA6mLQ
         O3GWuUCTjyIi3csmGOewpB8jtuzl5+tL5av6zHIG/kwkrtuh5BWU2VJ0cQ/xRc2KyObY
         wVlw==
X-Gm-Message-State: AOAM530tRDMgEWTq5oNfVP1Bm89XTlPa55DQY2EXHJMS+pG6yeCgc032
        UFP+Gk3cE5dpHUPX69v8EjMPGmJ1/k74LdATj7ne7Q==
X-Google-Smtp-Source: ABdhPJy0KZ/I5TaiWAMKZSGIe7DEKIQBoa5SdW/1VoB9R1L3L74y9lVA1K4Xjq82FZCNoFOSM3cp8tOTKU3nR8Y2jV8=
X-Received: by 2002:a67:3214:: with SMTP id y20mr11280747vsy.19.1628076936091;
 Wed, 04 Aug 2021 04:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210721154738.3966463-1-ebiggers@kernel.org>
In-Reply-To: <20210721154738.3966463-1-ebiggers@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Aug 2021 13:34:59 +0200
Message-ID: <CAPDyKFpFr6CHd5+XkWRPddonCp3VQZ9aSxvCOgsWDb678KrnDg@mail.gmail.com>
Subject: Re: [PATCH] mmc: store pointer to bio_crypt_ctx in mmc_request
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Satya Tangirala <satyaprateek2357@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 21 Jul 2021 at 17:48, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Make 'struct mmc_request' contain a pointer to the request's
> 'struct bio_crypt_ctx' directly, instead of extracting a 32-bit DUN from
> it which is a cqhci-crypto specific detail.
>
> This keeps the cqhci crypto specific details in the cqhci module, and it
> makes mmc_core and mmc_block ready for MMC crypto hardware that accepts
> the DUN and/or key in a way that is more flexible than that which will
> be specified by the eMMC v5.2 standard.  Exynos SoCs are an example of
> such hardware, as their inline encryption hardware takes keys directly
> (it has no concept of keyslots) and supports 128-bit DUNs.
>
> Note that the 32-bit DUN length specified by the standard is very
> restrictive, so it is likely that more hardware will support longer DUNs
> despite it not following the standard.  Thus, limiting the scope of the
> 32-bit DUN assumption to the place that actually needs it is warranted.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> This patch is already being carried in the Android Common Kernels, due
> to it being needed by Exynos SoCs.  Unfortunately I have no way to
> upstream Exynos eMMC inline encryption support at the moment, so this
> patch isn't strictly required upstream at the moment.  But it may be
> worthwhile as a cleanup regardless; it arguably fixes a layering
> violation (mmc_core knowing about the details of cqhci crypto).
>
>  drivers/mmc/core/crypto.c       | 15 ++++-----------
>  drivers/mmc/host/cqhci-crypto.h |  7 +++++--
>  include/linux/mmc/core.h        |  3 +--
>  3 files changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> index 419a368f8402..67557808cada 100644
> --- a/drivers/mmc/core/crypto.c
> +++ b/drivers/mmc/core/crypto.c
> @@ -31,18 +31,11 @@ void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq)
>         struct request *req = mmc_queue_req_to_req(mqrq);
>         struct mmc_request *mrq = &mqrq->brq.mrq;
>
> -       if (!req->crypt_keyslot)
> +       if (!req->crypt_ctx)
>                 return;
>
> -       mrq->crypto_enabled = true;
> -       mrq->crypto_key_slot = blk_ksm_get_slot_idx(req->crypt_keyslot);
> -
> -       /*
> -        * For now we assume that all MMC drivers set max_dun_bytes_supported=4,
> -        * which is the limit for CQHCI crypto.  So all DUNs should be 32-bit.
> -        */
> -       WARN_ON_ONCE(req->crypt_ctx->bc_dun[0] > U32_MAX);
> -
> -       mrq->data_unit_num = req->crypt_ctx->bc_dun[0];
> +       mrq->crypto_ctx = req->crypt_ctx;
> +       if (req->crypt_keyslot)
> +               mrq->crypto_key_slot = blk_ksm_get_slot_idx(req->crypt_keyslot);
>  }
>  EXPORT_SYMBOL_GPL(mmc_crypto_prepare_req);
> diff --git a/drivers/mmc/host/cqhci-crypto.h b/drivers/mmc/host/cqhci-crypto.h
> index 60b58ee0e625..d7fb084f563b 100644
> --- a/drivers/mmc/host/cqhci-crypto.h
> +++ b/drivers/mmc/host/cqhci-crypto.h
> @@ -22,12 +22,15 @@ int cqhci_crypto_init(struct cqhci_host *host);
>   */
>  static inline u64 cqhci_crypto_prep_task_desc(struct mmc_request *mrq)
>  {
> -       if (!mrq->crypto_enabled)
> +       if (!mrq->crypto_ctx)
>                 return 0;
>
> +       /* We set max_dun_bytes_supported=4, so all DUNs should be 32-bit. */
> +       WARN_ON_ONCE(mrq->crypto_ctx->bc_dun[0] > U32_MAX);
> +
>         return CQHCI_CRYPTO_ENABLE_BIT |
>                CQHCI_CRYPTO_KEYSLOT(mrq->crypto_key_slot) |
> -              mrq->data_unit_num;
> +              mrq->crypto_ctx->bc_dun[0];
>  }
>
>  #else /* CONFIG_MMC_CRYPTO */
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index ab19245e9945..71101d1ec825 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -164,9 +164,8 @@ struct mmc_request {
>         int                     tag;
>
>  #ifdef CONFIG_MMC_CRYPTO
> -       bool                    crypto_enabled;
> +       const struct bio_crypt_ctx *crypto_ctx;
>         int                     crypto_key_slot;
> -       u32                     data_unit_num;
>  #endif
>  };
>
> --
> 2.32.0.402.g57bb445576-goog
>
