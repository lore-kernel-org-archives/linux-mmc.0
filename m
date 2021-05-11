Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C492C433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151ED61132
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhEKK6C (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 06:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhEKK6B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 06:58:01 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A306FC061574
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:56:55 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id 66so9958031vsk.9
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krrXoOQowFRAS4ha9BPKaEPs6gzq6K83uwGtNzWwAQg=;
        b=ACnL0dHkwLYgVRLIqXXl9waYOfpeGuw6bxFeIn0GshIdwkCzuuDbsUDkcHVa3iHWbD
         9dMFrYAOSH6caHfutfFKebSEauklzP02eMHhavj642e3BUN6RzyQTAZ06ZzHxH5bsX/p
         AO5X5sJBRZ75Y6HyMrXazCTDY3X8Nox9vnaFXMT0SZHfvuzMeEWhpEYw7g2kBWdv4XU/
         nbbCd5oy+j72M7FLpX1+PnQNZ7OqXnEicQbzxRRjqlV6NUFQB9dhBwOAfq+FiITsBFwL
         oyH4FpASr2Y92pOiXm8TsNiZY9xTSYUEJA7Xi575WTf8k0e/kRc+UgzvshXpjUIh+wTi
         FX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krrXoOQowFRAS4ha9BPKaEPs6gzq6K83uwGtNzWwAQg=;
        b=RigPYmhdhxN2PjwjD3trcZOOz5aG4xrKNLuK5p3jXijmByHxtiv6JexyFmuRj1SkuE
         aytRCRHW9WIIiwPVj48jrXrPy9oek+pUNiTz9fFPEOi2cyxPqh74SsRRfjM2PMRScd7P
         byTdu0k43UsTUBt+lH0AvSrR/RZiwmtiFuqWV1mZ56Ord+cdbgbf7Cre6I9KytMXzgPB
         NIpYGrS2suUe14nw//O7ci1Z5sbQtZ0fnHmglqvw3f6ixD3zvEmhM6NBRqhBaHVpGR1e
         Hv4ZQifPT7U9E3stdnrRY+J161kOoCxwqrku7Cqu/5aFL0WJCqOWR9pxUBpN9roQ1edh
         KzVw==
X-Gm-Message-State: AOAM533rlfYipJPiPUFmKHkXMuY1b5Qz3qmwUWF3R1ILXReFt46MhrA3
        bqDIolmj1jBTGGGYkd+IY/D5thmPqSvIof9V1L7eDw==
X-Google-Smtp-Source: ABdhPJxzT/keb4NOKXYCQGmWjolAOxpB1deXwetWTWdB7OlQ0knG8WgebyOQPjN1sx3avf7QixyvXZE1TGni0Xt+ppw=
X-Received: by 2002:a67:f60e:: with SMTP id k14mr25253513vso.48.1620730614934;
 Tue, 11 May 2021 03:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210426175559.3110575-1-narmstrong@baylibre.com> <20210426175559.3110575-2-narmstrong@baylibre.com>
In-Reply-To: <20210426175559.3110575-2-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:17 +0200
Message-ID: <CAPDyKFrZY0vdQrFfAGCRW2MM25WY1rivwiPv8u3aHsfwNPbe-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: meson-gx: also check SD_IO_RW_EXTENDED for
 scatterlist size alignment
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 26 Apr 2021 at 19:56, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The brcmfmac driver can generate a scatterlist from a skb with each packets
> not aligned to the block size. This is not supported by the Amlogic Descriptor
> dma engine where each descriptor must match a multiple of the block size.
>
> The sg list is valid, since the sum of the sg buffers is a multiple of the
> block size, but we must discard those when in SD_IO_RW_EXTENDED mode since
> SDIO block mode can be used under the hood even with data->blocks == 1.
>
> Those transfers are very rare, thus can be replaced by a bounce buffer
> without real performance loss.
>
> Fixes: 7412dee9f1fd ("mmc: meson-gx: replace WARN_ONCE with dev_warn_once about scatterlist size alignment in block mode")
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 1c61f0f24c09..016a6106151a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -236,7 +236,8 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>         if (host->dram_access_quirk)
>                 return;
>
> -       if (data->blocks > 1) {
> +       /* SD_IO_RW_EXTENDED (CMD53) can also use block mode under the hood */
> +       if (data->blocks > 1 || mrq->cmd->opcode == SD_IO_RW_EXTENDED) {
>                 /*
>                  * In block mode DMA descriptor format, "length" field indicates
>                  * number of blocks and there is no way to pass DMA size that
> --
> 2.25.1
>
