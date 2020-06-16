Return-Path: <SRS0=InOK=75=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC73C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A7B82098B
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VibwAZSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgFPLdP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPLdO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2020 07:33:14 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6A7C08C5C3
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:33:13 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id i1so4712965vkp.8
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSg0muGbkwOyh6Ot3lTlpvo0Mmt4wgCAweHT5tRHxm0=;
        b=VibwAZSD84LU+4hHmx7H20bVV8ZpftSbkJ7qeyM+fPSnWy5b52HMmY8uC6oN/TOJ3N
         Ppd7MeLLzhu4lLdwL1u8+HFFzEJwEkIRbPl3l2liiO84a2tEXnOOLJLVeD2eQr2LEdo1
         GuqKU5ksA+/+QuCtf656nkvB+l8BnzLR+CwMeWI8NMKjSG87T6hTFLog6RcU8uJ5b42y
         lBqr6ENJXZQ31zwwwbbWm8fG8NZlpIVe4l6fg47KvRL/VkNsBi3g56UkQTQ64+dQKFpF
         89zZO5b6w/YjOAiLDeGYGxLcR5EKhAFvvlLFVKqumAr2y0DtwWTd9++bWUxaqHYG4fEh
         NmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSg0muGbkwOyh6Ot3lTlpvo0Mmt4wgCAweHT5tRHxm0=;
        b=TWJ+pybH92uaJISftFbtlUOTz5EL2BMrQ1//GxVpSjG6Vd6DRurtwiP9W6F02i0gfP
         2tQrGbKBgxDezs8uvHpSGbMykUXhVXPGpsSH74WSZhype2QFvpQyqkQJzDcBMOYZw9zW
         emw1GsaG+D7w0k4DSqUdZwX809nl7MbJN/qRAoWGrMpE761AByQMRuIcVOcvTMEIzZLm
         zswWoa3v2lCYxvib23HMl1NykEUjArSHrNPQ0bjLvg0B2u9mLGfzo4BC2+8YE5T4nHuZ
         op79Px4qJU4CRMt1hPgJNXYc8sbzWKGaL0LxGZf1WNcrhV/z2QYYbNd1mRQ64RLkDxfF
         lzbQ==
X-Gm-Message-State: AOAM533jSD2OBTA/ckimQ5VF5yPraub/25xt2zcz7HzbNW2Efe9UGT+O
        jfdsfJLZyu8ROvl1PZ0fJQTBe83RRbEEH9Xyt0bF9A==
X-Google-Smtp-Source: ABdhPJznqqxzYSq4IwrFjXL5kmjhHPScZNDOA7H32xZbM7qlqeiuriVkd5OOYnJKbb8oO4Q4Ov7r07YvZL4Xn1v7YjE=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr1118293vkh.53.1592307192362;
 Tue, 16 Jun 2020 04:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200608084458.32014-1-narmstrong@baylibre.com>
In-Reply-To: <20200608084458.32014-1-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:32:36 +0200
Message-ID: <CAPDyKFo7VA-wbOZUxExUpPoc+u446KecFARX0KNCakaubowpXg@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: limit segments to 1 when dram-access-quirk
 is needed
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Art Nikpal <art@khadas.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 8 Jun 2020 at 10:45, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The actual max_segs computation leads to failure while using the broadcom
> sdio brcmfmac/bcmsdh driver, since the driver tries to make usage of scatter
> gather.
>
> But with the dram-access-quirk we use a 1,5K SRAM bounce buffer, and the
> max_segs current value of 3 leads to max transfers to 4,5k, which doesn't work.
>
> This patch sets max_segs to 1 to better describe the hardware limitation,
> and fix the SDIO functionnality with the brcmfmac/bcmsdh driver on Amlogic
> G12A/G12B SoCs on boards like SEI510 or Khadas VIM3.
>
> Reported-by: Art Nikpal <art@khadas.com>
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Fixes: acdc8e71d9bb ("mmc: meson-gx: add dram-access-quirk")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 35400cf2a2e4..cfaf8e7e22ec 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1143,9 +1143,11 @@ static int meson_mmc_probe(struct platform_device *pdev)
>
>         mmc->caps |= MMC_CAP_CMD23;
>         if (host->dram_access_quirk) {
> +               /* Limit segments to 1 due to low available sram memory */
> +               mmc->max_segs = 1;
>                 /* Limit to the available sram memory */
> -               mmc->max_segs = SD_EMMC_SRAM_DATA_BUF_LEN / mmc->max_blk_size;
> -               mmc->max_blk_count = mmc->max_segs;
> +               mmc->max_blk_count = SD_EMMC_SRAM_DATA_BUF_LEN /
> +                                    mmc->max_blk_size;
>         } else {
>                 mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
>                 mmc->max_segs = SD_EMMC_DESC_BUF_LEN /
> --
> 2.22.0
>
