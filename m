Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78561C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 10:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62DFB6023F
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 10:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbhIWKxW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbhIWKxW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 06:53:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B3DC061756
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 03:51:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i25so25134068lfg.6
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZAOZKDlswTrDBuirwUgec+0wirM62qGZzElgpQmHWc=;
        b=c+uc7dBvi0o8VbzJj/9l72hYiJGZlLposYxLzcXp04J15VNUZglANSoNSTDDY85VzH
         9vcFA6NuhDzSRoRriGM2MYxe/FAvpzq7X/o0hRTXU+qgvdYtk7qjkCTO+lmokQPVA7Ls
         icxidEkDd5X+hRAWmWFWd09TXCzDoI36pJp9V4gkqRGQQJVVkj/BuAyWzf4443bnTbVG
         /qHD9LXObzKDT2bZKHkljt6nCAU6th1mLXX3YeTygPVJ23jy142kItEgR6zrzlULEtcX
         3kfJEY/v4XlmrkiAj4BseE976o2W388hKlH7aVSTJsHmZAhpgrYnEdKzpxiPolFZvLF/
         gakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZAOZKDlswTrDBuirwUgec+0wirM62qGZzElgpQmHWc=;
        b=e99N0YB8YvYN5PPg5123ex0ZLDXztq6XhZAbP5f4ONnbpWn9W+0ecj7SZiFuzSAPFb
         EXmhr7NzWlx2bO4UgqI142yFpyebT2ZaKFfuRnCVynyfgpalLK/fu+yz5lXydx/9N9Je
         i4c2CKjifCL0qJdyiTjwIYjoz2Rbgbv93Hp4ldAG7IMhyEP4USfhsfHDjlgAoBk6Y3qk
         f4J/U+0Fx8olBYvB8FX6zPYNm9wjqdLV4UE16YcXguW5Qhowa79Ek7Rx3bcXpBFjmVDw
         7znD8OsX5e+zyCicSx5esQQLo7tuqvmXJD4Ny0x8qOxD/3Ds4YhW67IjWOtCn2oQCxie
         SBJg==
X-Gm-Message-State: AOAM530mnM4cKQx0tme76sPyVCcOlZ2ViSoQAW2fHC5fqy0rsXcU53Lj
        7GNybUkCcrrl0E/AjApr/IqBGBQIS8LgaDajOv6bUw==
X-Google-Smtp-Source: ABdhPJzDqiDdo7fH13X6725lmGDL0pLCjz5Voj6/qRJne0PS12YyRUk8hp3c10PW5rrZoHYv6HTq9mLQec1PhG0Xb6k=
X-Received: by 2002:a2e:85c2:: with SMTP id h2mr4412758ljj.367.1632394309094;
 Thu, 23 Sep 2021 03:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210913080504.832521-1-narmstrong@baylibre.com>
In-Reply-To: <20210913080504.832521-1-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Sep 2021 12:51:12 +0200
Message-ID: <CAPDyKFqLvnAOAmk3PeNiBzwXTgwvG+zEO1b_pJNzSuUZ3Zamxg@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: do not use memcpy_to/fromio for dram-access-quirk
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Sept 2021 at 10:05, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The memory at the end of the controller only accepts 32bit read/write
> accesses, but the arm64 memcpy_to/fromio implementation only uses 64bit
> (which will be split into two 32bit access) and 8bit leading to incomplete
> copies to/from this memory when the buffer is not multiple of 8bytes.
>
> Add a local copy using writel/readl accesses to make sure we use the right
> memory access width.
>
> The switch to memcpy_to/fromio was done because of 285133040e6c
> ("arm64: Import latest memcpy()/memmove() implementation"), but using memcpy
> worked before since it mainly used 32bit memory acceses.
>
> Fixes: 103a5348c22c ("mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk")
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 49 +++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 3f28eb4d17fe..08c0ff0bfa8b 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -746,7 +746,7 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
>         writel(start, host->regs + SD_EMMC_START);
>  }
>
> -/* local sg copy to buffer version with _to/fromio usage for dram_access_quirk */
> +/* local sg copy for dram_access_quirk */
>  static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data,
>                                   size_t buflen, bool to_buffer)
>  {
> @@ -764,21 +764,34 @@ static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data
>         sg_miter_start(&miter, sgl, nents, sg_flags);
>
>         while ((offset < buflen) && sg_miter_next(&miter)) {
> -               unsigned int len;
> +               unsigned int buf_offset = 0;
> +               unsigned int len, left;
> +               u32 *buf = miter.addr;
> +
> +               if (((unsigned long int)miter.addr % 4))
> +                       dev_err(host->dev, "non word aligned sg");

This looks weird. You print an error message, but continue to process
data? If this is a case you can't handle, perhaps you should propagate
an error code instead?

Additionally, you may want to use the IS_ALIGNED() macro.

>
>                 len = min(miter.length, buflen - offset);
>
> -               /* When dram_access_quirk, the bounce buffer is a iomem mapping */
> -               if (host->dram_access_quirk) {
> -                       if (to_buffer)
> -                               memcpy_toio(host->bounce_iomem_buf + offset, miter.addr, len);
> -                       else
> -                               memcpy_fromio(miter.addr, host->bounce_iomem_buf + offset, len);
> +               if ((len % 4))
> +                       dev_err(host->dev, "non word multiple sg");

Again, a dev_err() doesn't seem like the right thing to do. If you
can't handle this, please return an error code instead.

Perhaps returning an error code isn't convenient at this point. An
option could then be to pre-validate the sglist at the time of
starting the request. We have other host drivers doing this, have a
look at drivers/mmc/host/mmci*, for example.

> +
> +               left = len;
> +
> +               if (to_buffer) {
> +                       do {
> +                               writel(*buf++, host->bounce_iomem_buf + offset + buf_offset);
> +
> +                               buf_offset += 4;
> +                               left -= 4;
> +                       } while (left);
>                 } else {
> -                       if (to_buffer)
> -                               memcpy(host->bounce_buf + offset, miter.addr, len);
> -                       else
> -                               memcpy(miter.addr, host->bounce_buf + offset, len);
> +                       do {
> +                               *buf++ = readl(host->bounce_iomem_buf + offset + buf_offset);
> +
> +                               buf_offset += 4;
> +                               left -= 4;
> +                       } while (left);
>                 }
>
>                 offset += len;
> @@ -830,7 +843,11 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>                 if (data->flags & MMC_DATA_WRITE) {
>                         cmd_cfg |= CMD_CFG_DATA_WR;
>                         WARN_ON(xfer_bytes > host->bounce_buf_size);
> -                       meson_mmc_copy_buffer(host, data, xfer_bytes, true);
> +                       if (host->dram_access_quirk)
> +                               meson_mmc_copy_buffer(host, data, xfer_bytes, true);
> +                       else
> +                               sg_copy_to_buffer(data->sg, data->sg_len,
> +                                                 host->bounce_buf, xfer_bytes);
>                         dma_wmb();
>                 }
>
> @@ -999,7 +1016,11 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>         if (meson_mmc_bounce_buf_read(data)) {
>                 xfer_bytes = data->blksz * data->blocks;
>                 WARN_ON(xfer_bytes > host->bounce_buf_size);
> -               meson_mmc_copy_buffer(host, data, xfer_bytes, false);
> +               if (host->dram_access_quirk)
> +                       meson_mmc_copy_buffer(host, data, xfer_bytes, false);
> +               else
> +                       sg_copy_from_buffer(data->sg, data->sg_len,
> +                                           host->bounce_buf, xfer_bytes);
>         }
>
>         next_cmd = meson_mmc_get_next_command(cmd);
> --
> 2.25.1
>

Kind regards
Uffe
