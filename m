Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F62CCA479
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 11:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiGRLi1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiGRLi0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 07:38:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91BB2182B
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 04:38:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u13so18811679lfn.5
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKrTbfV1TIjezbnj9pZfW/yzd2q01rdirSDTyvPbTjU=;
        b=mh4onUHAiYaYnh02H+giZGGvog4JkyJdsiglHg/5RBO/SzoXleT/GwqABQJhhcta/e
         97sjZ4BzRpb94ffUJ4GcHRknEqEBywoFBTIBLPdtynJRWVAvjUACicUqzJ0UqED91FYm
         6+uFzlGlL9rB5y4yWoFiRi3JcLoDFpP7Nrn0BFouCWLtHqb3SNRMGhBAQ18kas0QfCTM
         Wf2EtiOqYibN079Th5gzKcXXU+gvCc5eoUhYQM2llJvamMPrtrr1dx6eDUkjzFFba2XE
         2YwOnc1YQPUx6EwdM1fpk+Ro02evibTXm4EzIIztm23MqgAausrckJSWMBpUTIWz8itS
         bqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKrTbfV1TIjezbnj9pZfW/yzd2q01rdirSDTyvPbTjU=;
        b=j+flCafu5iFw6M6e9cqIGfLOYR9xZ1DPsnA/CgurRvdMUZjlenzTy6UXvaxA8lugno
         h0fSVMzZucvtul8g72WWHKc6YmjnP43c6DQWvCWrQk4R5ptNsPzAckre0RpQKY1Nnl9d
         wOCUz0HylyK/Sr3j81GzCsD58copTK6kAd9X1MGOtEvaELbBBxnTvT2QIQJAPPbRZDDl
         SrEVaFz7kx5rw3hV7dpSsAlhS78CARlZBvNNhjyAe5r6f9pb88SOTm0ftmfoRAJnCJP7
         52dLEobJnV7eAukBRlUbIuf9CBGjVAOxMEBfi+5/exsDm1lk5dGWsVDmf5SyQlJUoW12
         Kgeg==
X-Gm-Message-State: AJIora/l9idx3lemfpRmHctwLaB0sN9HOHmcUzh9bLKDPV2Ag/pqI1FO
        q6egfkVtamMlGFE5fnCqy6Xotl1vLIeq4igALfuXNQ==
X-Google-Smtp-Source: AGRyM1ux2fo4OUI95oxoRd8QbK1bLzBMW/WZfSDYFRMjgd9hY4FaDe82H9U40sAKKcXBlfd8qgO4LYb4+n9NNWPVQCY=
X-Received: by 2002:a05:6512:2522:b0:489:daa9:467 with SMTP id
 be34-20020a056512252200b00489daa90467mr15084527lfb.71.1658144304143; Mon, 18
 Jul 2022 04:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220716140401.55494-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220716140401.55494-1-yuanjilin@cdjrlc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Jul 2022 13:37:48 +0200
Message-ID: <CAPDyKFp30G=x-LmiG+1NFsKaDTZvBU8bfgr9eUsMHiD4Jymotw@mail.gmail.com>
Subject: Re: [PATCH] mmc/core: fix repeated words in comments
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 16 Jul 2022 at 16:04, Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
>
>  Delete the redundant word 'it'.
>  Delete the redundant word 'in'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

I am fine with picking up patches that fixes spelling mistakes.
However, I would rather see that you go through all spelling mistakes
in the core and send one patch for all of them. It gets easier for me
to manage it in this way.

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 4b70cbfc6d5d..e4a555a2f202 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -56,7 +56,7 @@ static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
>  /*
>   * Enabling software CRCs on the data blocks can be a significant (30%)
>   * performance cost, and for other reasons may not always be desired.
> - * So we allow it it to be disabled.
> + * So we allow it to be disabled.
>   */
>  bool use_spi_crc = 1;
>  module_param(use_spi_crc, bool, 0);
> @@ -528,7 +528,7 @@ EXPORT_SYMBOL(mmc_cqe_post_req);
>   * @host: MMC host to recover
>   *
>   * Recovery consists of stopping CQE, stopping eMMC, discarding the queue in
> - * in eMMC, and discarding the queue in CQE. CQE must call
> + * eMMC, and discarding the queue in CQE. CQE must call
>   * mmc_cqe_request_done() on all requests. An error is returned if the eMMC
>   * fails to discard its queue.
>   */
> --
> 2.36.1
>
