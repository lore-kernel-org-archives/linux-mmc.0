Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3ACC433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 13:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EC3611BF
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 13:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbhDPNOa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Apr 2021 09:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240600AbhDPNO3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Apr 2021 09:14:29 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCE1C061574
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 06:14:04 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id g20so13922677vst.2
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 06:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4h1/qVgfVmVO29jQ+MIl1szKMUmrXhtSX+2OCoy/0xE=;
        b=vEIN9wTuGnvLfMHL0nZCUqEMjfTBglVX6XaJsr7R2LIMb0BMoV+UvdQUtcp9VsxR6S
         HkoBngcSDmDqCXmREfBA2N6pUdy/R7iLsTBf1XNOqkDEX5QYLQ2i4wn5DuYab7nw/6cv
         b7amVZfDEVWnvL1RNFg6X1r/a9mpalMMIUQy1qhEptGpX1dJNAfsWExtelO8ugFBY1Bx
         YW2RRnbnQ1pz6wTHum+Zbtw1DDkpUM2bD0s0PmG5wfsQxrLB5995b8FCLAlZx6O89nQT
         J2zpcdNxT44hVgr0csS3QduUiJfHZiyNEtksF1uPz9drJh9uSSlF9mNQQ5H7HlT/+zBu
         F1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4h1/qVgfVmVO29jQ+MIl1szKMUmrXhtSX+2OCoy/0xE=;
        b=pLKgefmkD5hZiX/PnZVzsMpuVgNtEEN/6R+l/raYvVwTfPkzbvWMAsEyqgxV9iovBh
         uOQvUN/xzmujp+i8s0vcGPk/6PCaT/YJUR6xtJ1Yb1paqbAh8o3po6uhk/kSCkV4fBwQ
         X8zHAzSVDYAJ8t60rCWO/tAElnBzKtT+GBgCxL98mqzECBe6xHOc6V5vjsHf+Pwx5P/n
         pG8Z3T+hRL4kp/n7Cb2NKkVqhLAUYum8G2rut7ggNkLvKWSmPhREisvQ22+1RIEx/Fgz
         B3eiUypJ2PuO7cND1d9zPBt5rOmktAaNzTa9n/W26kxqC4Qz/DSN9lif64KjTqtRMG1U
         xhZg==
X-Gm-Message-State: AOAM530OT8UTYBPDMemxrnvBKW+cQt7qPjIqBXseJsSt3jlqlqb+wgw0
        YFVso1VxvZ7eY67nOa7B0ZZ4b4QFNJP70v8n7j5blGigQSDCUA==
X-Google-Smtp-Source: ABdhPJxcTAtmnm2jjHs5eDbwL/1quQG2UxTl/uhFb+0TrnDtXKBt5dcXt+k0jk/x4t+cKSRQ87jNmeHJHuUQPtkrzMI=
X-Received: by 2002:a67:ec51:: with SMTP id z17mr6648147vso.34.1618578843818;
 Fri, 16 Apr 2021 06:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210416094347.2015896-1-narmstrong@baylibre.com>
In-Reply-To: <20210416094347.2015896-1-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Apr 2021 15:13:27 +0200
Message-ID: <CAPDyKFpu3bz64R-t9KxEkobKKoOY6Dy6H9j2W2LEzeoz4-D4Yw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: meson-gx: replace WARN_ONCE with dev_warn_once
 about scatterlist size alignment in block mode
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Lebed <lebed.dmitry@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 16 Apr 2021 at 11:43, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Since commit e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode"),
> support for SDIO SD_IO_RW_EXTENDED transferts are properly filtered but some driver
> like brcmfmac still gives a block sg buffer size not aligned with SDIO block,
> triggerring a WARN_ONCE() with scary stacktrace even if the transfer works fine
> but with possible degraded performances.
>
> Simply replace with dev_warn_once() to inform user this should be fixed to avoid
> degraded performance.
>
> This should be ultimately fixed in brcmfmac, but since it's only a performance issue
> the warning should be removed.
>
> Fixes: e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied for next, thanks! (I move to fixes if there is another rc on Monday).

Kind regards
Uffe


> ---
> Changes since v1:
> - replace WARN_ONCE with dev_warn_once and explicit the warning message
>
>  drivers/mmc/host/meson-gx-mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index eb6c02bc4a02..b8b771b643cc 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -247,8 +247,9 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>                  */
>                 for_each_sg(data->sg, sg, data->sg_len, i) {
>                         if (sg->length % data->blksz) {
> -                               WARN_ONCE(1, "unaligned sg len %u blksize %u\n",
> -                                         sg->length, data->blksz);
> +                               dev_warn_once(mmc_dev(mmc),
> +                                             "unaligned sg len %u blksize %u, disabling descriptor DMA for transfer\n",
> +                                             sg->length, data->blksz);
>                                 return;
>                         }
>                 }
> --
> 2.25.1
>
