Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA0C433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 09:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0097461132
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 09:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhDOJID (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhDOJID (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 05:08:03 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52867C061756
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 02:07:40 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id u23so907882vkl.12
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjVJwjzWYr1/sR0XamTsvtpkvMNA+5snLIJZWYxDhFI=;
        b=UyrLPEOZuT1ziKU+PyL1rJHq7rNyJg+UeOgK0vbNVbHgo9TdDnHuc+z5wtHB5da8cA
         G+eyDGuYo4jyss1OzbjpexQ1IRvennZUdBbRenPx4Yah7ic1Za0jpMLgARxClGCfccbQ
         la+cauI00P0pXwi8nnpjnuobj6IVxaU5KLorR9GLgmrM87RNMG2TxXIjwxkorvE0BAmE
         zH8TnvhSXF640s8pNdpUhEMJsqERIBzh+keXwLTULu70N1bYEdBNjeHg/tDr7EJnIIzm
         a8VZIsXsEW+0idHwtn7r+QltlRl5lNlAGJB11tkdsNyIqC5UkivcIK1+5f3qWV9Lxje1
         nUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjVJwjzWYr1/sR0XamTsvtpkvMNA+5snLIJZWYxDhFI=;
        b=ZyHSLt8+cNLEjeqlEooz85aoZeNR+82ToaSPThyj/IT3rMbOS8cyysq4UI6Lx7qX+s
         ZiMyg/Z7AOBHIrjNuz1J2I7gbI6dtUglLYie1iyvPhV1SNMNdJ8D+CRqzUVgLXsu1JuJ
         krcMYBfDrD4amUILIM6p86RExZ13t05RKznIEL4BVmUJrz3zCVGO0ESWL5la+JGcy1W2
         gQm9gwzU5Et+THG+qb7IwrTUowgdv41/38CjR/ZOhqe+No4bvQ36CR5A8ZYa0XkEym+5
         9LfS6Hfm+p0SthkpQbTeuw8Cftp/zYq5w5cFcMDgVWlwrQQSL9pnquR5+Z8oYIUJn/G/
         /V9Q==
X-Gm-Message-State: AOAM530maLIqPwThLXfXvGCuVlI4b45AqFzblVLN0HNwWrBU+Q0pEAQi
        XxOIEJlquRfUfvbDBoJM8DrCTq75oamCGtUxb+RDMA==
X-Google-Smtp-Source: ABdhPJy/tFAI7hIwRCSFL3zc12707ikZU7bG/40bLAl8ttRArxQYWSFbL/u1pKeyKIZ0A2iQgJwfGHELnGwKLccsYO8=
X-Received: by 2002:a1f:2c58:: with SMTP id s85mr999684vks.15.1618477659418;
 Thu, 15 Apr 2021 02:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210414100010.3877669-1-narmstrong@baylibre.com>
In-Reply-To: <20210414100010.3877669-1-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 11:07:03 +0200
Message-ID: <CAPDyKFpNLu3R+7ODZaC7yWMYbSOujswgLTkN97FQNg5zhwSxgw@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: remove useless warning about scatterlist
 size alignment in block mode
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

On Wed, 14 Apr 2021 at 12:00, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Since commit e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode"),
> support for SDIO SD_IO_RW_EXTENDED transferts are properly filtered but some driver
> like brcmfmac still gives a block sg buffer size not aligned with SDIO block,
> triggerring a warning even if the transfer works in degraded mode.
>
> This should be ultimately fixed in brcmfmac, but since it's only a performance issue
> the warning should be removed.
>
> Fixes: e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index eb6c02bc4a02..6bc151045843 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -246,11 +246,8 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>                  * size, otherwise chain mode could not be used.
>                  */
>                 for_each_sg(data->sg, sg, data->sg_len, i) {
> -                       if (sg->length % data->blksz) {
> -                               WARN_ONCE(1, "unaligned sg len %u blksize %u\n",
> -                                         sg->length, data->blksz);

Rather than removing this warning, perhaps an option could be to use
dev_warn_once() instead?

> +                       if (sg->length % data->blksz)
>                                 return;
> -                       }
>                 }
>         }
>

Kind regards
Uffe
