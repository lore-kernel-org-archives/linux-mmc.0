Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5748C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D75D233A2
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbhAML0h (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbhAML0g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:26:36 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68A9C0617A2
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:38 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id x26so920100vsq.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvx4Rm0JVaEBLeH4g/sZ+OV4otU1DpUJjISnok3Lub4=;
        b=fZ/f8jvURhta2ZKt6eWO0sA195Ej1y1EgflYyXr+/2V3gTama/jP93zQ5uNq/kl3lr
         aijqqb8SxWJVl84URx3J4SPb6Ow7hCp4ZMJcLGkQuLM2DrCm9UG21uoFB+IICsZw4EPb
         dpo+zaFOq6l376bvvUEwbWF5/RwMbKnoaoSuDsmJbzrhQgR7s4LWuPlxeouDZn6A9xj7
         xxwr+rFWE2XMA21SNaz5nZIaW6yDIIjeT2AIBHtEksb/7XQbAmPajtdIBaRuwt+sswGy
         XxWrnuBb0KFIVCjxuXFdudaVjeSB2Iw0yYMX/PGftUpletczCPmEm8fZEioDIEuH9l3V
         Tvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvx4Rm0JVaEBLeH4g/sZ+OV4otU1DpUJjISnok3Lub4=;
        b=EyD1uBI8VvKeJ2JCFFc2q+mSoQD4jOHk1n9fvRxyYhtfukJzXqbaS1onVXuU4gjFxV
         Ytz44cyrAgbgtSsBRynAW4GSkfdCtS9uvtyOkN73oPl3yyNsQjsFxmeS8WF3695j9mUv
         DQOtZF7xNGu1BNjyuB6pr2BM+rYZuIttfdr0L+OkQHWaRijQqAVLtG8WPIW+oyZB1OzU
         FnvamYBMk5PGPTvJjAkbKMjNORS3DI0MVmnfRzaAc/NEEtZrCdC53fS2eZMeB/uQwKJR
         Rfjf6VfMsv1+9CjGfryiU3PybEjrYhbRT4Ge6srp5wvsbvq27SR8xIuy6r08dZllxGIN
         7ctw==
X-Gm-Message-State: AOAM532TpKbegepnjUdwCaw9WtkaZ8bPE4cF2cXg5ylbf9cQizI1Ba52
        GCjnAm8Nb/79ucc/0rr9k5/xon3W28u6MmTHKyQ7OA==
X-Google-Smtp-Source: ABdhPJxZ9n2zAVtmqUz0lOujvmZtP4s4E9RPWoQ1Bn9DvMLU+rD6Q8RJU5GcDSMrudFwKiblbn1f1xrIZGk45ZpvT+k=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr1188727vsr.19.1610537138051;
 Wed, 13 Jan 2021 03:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20201218075312.67338-1-lebed.dmitry@gmail.com>
In-Reply-To: <20201218075312.67338-1-lebed.dmitry@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:00 +0100
Message-ID: <CAPDyKFp+qvVUycmssdm0wjRfL7HxEAYkT3edCicXzJ5HUwzfSg@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: check for scatterlist size alignment in
 block mode
To:     Dmitry Lebed <lebed.dmitry@gmail.com>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Dec 2020 at 08:54, Dmitry Lebed <lebed.dmitry@gmail.com> wrote:
>
> Enable SGDMA support for SD_IO_RW_EXTENDED and add proper check
> for scatterlist size alignment in block mode.
>
> According to documentation, in SDIO block mode meson-gx DMA could
> only handle buffers with sizes that are multiples of SDIO block size.
>
> Some SDIO drivers like brcmfmac use scatterlist API, but do not enforce
> proper scatterlist buffer size alignemnt, this looks like a root cause
> of non-working CMD53.
>
> Some minor style fixes.
>
> Signed-off-by: Dmitry Lebed <lebed.dmitry@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 37 ++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 13f6a2c0ed04..eb6c02bc4a02 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -227,7 +227,6 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>         struct mmc_data *data = mrq->data;
>         struct scatterlist *sg;
>         int i;
> -       bool use_desc_chain_mode = true;
>
>         /*
>          * When Controller DMA cannot directly access DDR memory, disable
> @@ -237,25 +236,33 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>         if (host->dram_access_quirk)
>                 return;
>
> -       /*
> -        * Broken SDIO with AP6255-based WiFi on Khadas VIM Pro has been
> -        * reported. For some strange reason this occurs in descriptor
> -        * chain mode only. So let's fall back to bounce buffer mode
> -        * for command SD_IO_RW_EXTENDED.
> -        */
> -       if (mrq->cmd->opcode == SD_IO_RW_EXTENDED)
> -               return;
> +       if (data->blocks > 1) {
> +               /*
> +                * In block mode DMA descriptor format, "length" field indicates
> +                * number of blocks and there is no way to pass DMA size that
> +                * is not multiple of SDIO block size, making it impossible to
> +                * tie more than one memory buffer with single SDIO block.
> +                * Block mode sg buffer size should be aligned with SDIO block
> +                * size, otherwise chain mode could not be used.
> +                */
> +               for_each_sg(data->sg, sg, data->sg_len, i) {
> +                       if (sg->length % data->blksz) {
> +                               WARN_ONCE(1, "unaligned sg len %u blksize %u\n",
> +                                         sg->length, data->blksz);
> +                               return;
> +                       }
> +               }
> +       }
>
> -       for_each_sg(data->sg, sg, data->sg_len, i)
> +       for_each_sg(data->sg, sg, data->sg_len, i) {
>                 /* check for 8 byte alignment */
> -               if (sg->offset & 7) {
> +               if (sg->offset % 8) {
>                         WARN_ONCE(1, "unaligned scatterlist buffer\n");
> -                       use_desc_chain_mode = false;
> -                       break;
> +                       return;
>                 }
> +       }
>
> -       if (use_desc_chain_mode)
> -               data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
> +       data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
>  }
>
>  static inline bool meson_mmc_desc_chain_mode(const struct mmc_data *data)
> --
> 2.24.3 (Apple Git-128)
>
