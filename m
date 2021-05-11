Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825CDC433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443C060FEB
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhEKK56 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 06:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEKK56 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 06:57:58 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F63C061574
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:56:52 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id h1so6217955uar.0
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1uNin7KdMToK7k5qzR9dcDANP4zzvkct1xdccaJQws=;
        b=Q+zrTlsHYPpOEFR/1lxEQ1xDjGMHj/jHorL6odYvL/qu3iFZfK2dpRHu0G5WcNX5RK
         j3s9a7RHPljllfITPX7T7CcnNcZ7Vms3knS3IpG7Cp4YSIgTuRTxbJ1x6ZlpDfsw1ixw
         AiQZLZa27GTuFKLsWnR6yxFRrozKJv9y7sRnbg+5ouXeE14DdccjtIvHWc4FZr4cAXU9
         +dP32wOJsNd+/1shyrN4pyKTw8gLynAhuHxufYdsua1MUBtbTY7bszfcd+OxtylWOao2
         2AxD69artZaYniDzneJG2qyuZQKknwqGMk1gHJLVjDDFsIc7g2+b2O9hAZhNbN/FLnj9
         KtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1uNin7KdMToK7k5qzR9dcDANP4zzvkct1xdccaJQws=;
        b=OuVZ5B3ElsbQIt1YYW+Ey6or4LffIotsgHustQadcIormR/crZj1LlWc0uPkTCPp+l
         LVuZQalN06frmteUbHO0nVsScL2dEPeYhdrnQFHPvIi2n6latgo7N/9rLlU848UCl4Ai
         sgQgjqH2op1wFhAmv41Uyv+RVHToTEy4bkHx+RTfIfos1IWbM3kIZfoTld8Gl9aAd8DP
         Ma55FjQ+RpgzZkOShdFX/jkGBsOgnHqaEER5KOzjKuRxgWGoi9pn/7Yaxi98qHqc3S9G
         W5YOcoWU0e3QK3BtcA6TfXVCvxQ3dQbIroBsKIXbriLI2arV1PvTATWC8MusqyXydjwp
         sCIw==
X-Gm-Message-State: AOAM531dlERlY2qIVVIMOcej4AFRJ54bUaB18Ob65tkkcScFdxuvJflr
        eE61RX8tKTUfQzZUHHpMBIEH2wOY3wvQD+ZQrhZghw==
X-Google-Smtp-Source: ABdhPJzwusLl8Z0aiFBl2Lqp8RrtcLMyHfRb5ku4ea5ClE3f0h3GFfNnJiYu75fDrZlUzfkMBv2nhhZe1xi57xQY20s=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr24423126uak.19.1620730611370;
 Tue, 11 May 2021 03:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210426175559.3110575-1-narmstrong@baylibre.com>
In-Reply-To: <20210426175559.3110575-1-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:13 +0200
Message-ID: <CAPDyKFrJMFX5ztz6wiWVmwvVF+pms23_+qw8Ey_1pzrHqQ9vRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: meson-gx: make replace WARN_ONCE with
 dev_warn_once about scatterlist offset alignment
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
> Some drivers like ath10k can sometimg give an sg buffer with an offset whose alignment
> is not compatible with the Amlogic DMA descriptor engine requirements.
>
> Simply replace with dev_warn_once() to inform user this should be fixed to avoid
> degraded performance.
>
> This should be ultimately fixed in ath10k, but since it's only a performance issue
> the warning should be removed.
>
> Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mode")
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index b8b771b643cc..1c61f0f24c09 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -258,7 +258,9 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>         for_each_sg(data->sg, sg, data->sg_len, i) {
>                 /* check for 8 byte alignment */
>                 if (sg->offset % 8) {
> -                       WARN_ONCE(1, "unaligned scatterlist buffer\n");
> +                       dev_warn_once(mmc_dev(mmc),
> +                                     "unaligned sg offset %u, disabling descriptor DMA for transfer\n",
> +                                     sg->offset);
>                         return;
>                 }
>         }
> --
> 2.25.1
>
