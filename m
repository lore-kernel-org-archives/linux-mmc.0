Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544E9C4320E
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4176961029
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhHDLf2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbhHDLf2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2021 07:35:28 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F78C0613D5
        for <linux-mmc@vger.kernel.org>; Wed,  4 Aug 2021 04:35:15 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id a8so823771vsl.4
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2021 04:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=298qMJyMPJ/kj+mz3echEC0htUSwovH6vq6yOoyB4tM=;
        b=Fh5HYKtQFp+k8REP6E7NNwIapjtVT1gyFwJsRRBtz+n7dtq9uN9MdM2rE6C+2Phdzz
         wPapICaqVi2j9JDcX4w4RllZ4KE/OWXAEuvYlWrWwCoPqEKgvxrAmMXE8XQEauedmtUb
         WOHnU4sbl8AZWgNXbXjp01RRQOqYPawETspToUPeO5dEO6CgBeVUIfCgMBu8I9Gf/rGX
         9RNz0Wcl8FHIQipno4Ne+eTB1vnhm0nCClPihCj7qtj5e8Neg3TwcM+zwF6Do44XpibM
         fll85jtuS1L0BePgWTh2HQaoCrh4FJ/R7DFIsDLIxbaqj0XXi6bgaw6nA1idn21AxzRl
         zHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=298qMJyMPJ/kj+mz3echEC0htUSwovH6vq6yOoyB4tM=;
        b=OCSW2uVb3VGdW1yoV2h+0bUdq78PTP7k/EMYLYMIPM8Iu6/oxrHp9RnoEdMzsGTfiV
         6BmuW9X2uSRHU0nletmECHUV3LzAE10J2wfnL/IArOV+oOl9v34gddmUvSoR1ecM4AOV
         D3bEdizsvXK59Pq4haZci/7fFSW8unM+DRMGmhbwHsJN7uDDw5YRBP+prO3DcVgJ+fTS
         wl3TFfdea1pojP8bAUxwM4wbt/Kic7kVsoxUcT7wg1bYksfxqCeTMRVDMriwyZG2eOYx
         nOgL1582DMQ9qQLATsQJ5Tz/e3PVxP7syC+UvdC9xGtRVZEH1l0GPXzy8uRqGEA2zcBl
         tI+A==
X-Gm-Message-State: AOAM530Gy6g9KkfFdWs9xw+2ULsaMem1ecCUUJr016Tn2JDrt1ugr7cf
        /nFCrkkQgewVQJmc0z7DQL7jkVcV3BsC7AJ0qfUeFA==
X-Google-Smtp-Source: ABdhPJwTT1f5g/pJ3zCLWgbRxy/o2phdPtvkLnLQeMqGDPeswh6LzK8B7/BdwOQAQ5hY6iOy5ymqJhLXNhy1TUAYXLw=
X-Received: by 2002:a67:328f:: with SMTP id y137mr17234228vsy.34.1628076915025;
 Wed, 04 Aug 2021 04:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210630102232.16011-1-vincent.whitchurch@axis.com>
In-Reply-To: <20210630102232.16011-1-vincent.whitchurch@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Aug 2021 13:34:38 +0200
Message-ID: <CAPDyKFpuzdaBgcJuMmCZKN_zb8KEW1ES87m8K0R_Pi6Xgr34aA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix hang on data CRC error
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>, kernel <kernel@axis.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Jun 2021 at 12:22, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> When a Data CRC interrupt is received, the driver disables the DMA, then
> sends the stop/abort command and then waits for Data Transfer Over.
>
> However, sometimes, when a data CRC error is received in the middle of a
> multi-block write transfer, the Data Transfer Over interrupt is never
> received, and the driver hangs and never completes the request.
>
> The driver sets the BMOD.SWR bit (SDMMC_IDMAC_SWRESET) when stopping the
> DMA, but according to the manual CMD.STOP_ABORT_CMD should be programmed
> "before assertion of SWR".  Do these operations in the recommended
> order.  With this change the Data Transfer Over is always received
> correctly in my tests.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index f85271f5c4fa..845b0745ea37 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2083,8 +2083,8 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>                                         continue;
>                                 }
>
> -                               dw_mci_stop_dma(host);
>                                 send_stop_abort(host, data);
> +                               dw_mci_stop_dma(host);
>                                 state = STATE_SENDING_STOP;
>                                 break;
>                         }
> @@ -2108,10 +2108,10 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>                          */
>                         if (test_and_clear_bit(EVENT_DATA_ERROR,
>                                                &host->pending_events)) {
> -                               dw_mci_stop_dma(host);
>                                 if (!(host->data_status & (SDMMC_INT_DRTO |
>                                                            SDMMC_INT_EBE)))
>                                         send_stop_abort(host, data);
> +                               dw_mci_stop_dma(host);
>                                 state = STATE_DATA_ERROR;
>                                 break;
>                         }
> @@ -2144,10 +2144,10 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>                          */
>                         if (test_and_clear_bit(EVENT_DATA_ERROR,
>                                                &host->pending_events)) {
> -                               dw_mci_stop_dma(host);
>                                 if (!(host->data_status & (SDMMC_INT_DRTO |
>                                                            SDMMC_INT_EBE)))
>                                         send_stop_abort(host, data);
> +                               dw_mci_stop_dma(host);
>                                 state = STATE_DATA_ERROR;
>                                 break;
>                         }
> --
> 2.28.0
>
