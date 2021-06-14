Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6D6C2B9F4
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Jun 2021 12:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129D56120E
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Jun 2021 12:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhFNMJj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Jun 2021 08:09:39 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:34577 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbhFNMJi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Jun 2021 08:09:38 -0400
Received: by mail-vs1-f50.google.com with SMTP id q2so7649435vsr.1
        for <linux-mmc@vger.kernel.org>; Mon, 14 Jun 2021 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNFrwknP/IvmdiYbxnPdakNn1lYk7LNQWog91LXNo7Q=;
        b=bkOlRcuUaxZHRKE5Ob/q8HPJ/Uxgg6tBZ1/p/y9i3DSMI0lkRwBSsKQSahwQw0TCze
         srD62FvqpXbiECHAhVhf6F5PaaG3pv5EH3pgw+P6vKJJgcRLApb23H3Y8qeRx+TevmSI
         vggUQFQ1wkXLoe/QqZPP6QNjQaWnt9S9tGlND99XR4G/Jn8Zl656r5d7aaG1W9g3Sa/l
         DEuGooPcK5lfUq3J4QofTxeICnES3axLNmLRZ2QowxfOAZHfCJ3i+TDTD+14hxxwP/aC
         zvwvrdidrtPuigAwhl6oxt9zEDsgJeII8HtyAbYec7bU9pjrTt+Rqs+rhXQOeiPO9umf
         2jRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNFrwknP/IvmdiYbxnPdakNn1lYk7LNQWog91LXNo7Q=;
        b=bfRNyohLYmQwQIiL9/2YSZBHfGaV63OAmznSJHihb5j5+we53b+VAl7ns4wsFCBxHG
         3v54tNXeCcss0maNVmiTqxUDY6nMHipMb/i3Utv7Il23o22ItFdvcWSKWVOFiQpkM4l1
         VrPifQIxVAn21JPA7saE7a1uY2eaxR1czGzxGSHTtriWD7RigotlXdqe4Jbz0yDyUPdj
         325RINfVkLtMpQWJLazeefa9fZQpummyApQXdsfbO7GV9AB7fy/5ZNNzcm5Psowiwx72
         a+hZhDjid4MVT/inYtLDj0fuEDPA87/WcGkSGIUMo6FgRr+Z32EI2IBbwp4Aw5wNf1il
         UKqg==
X-Gm-Message-State: AOAM530Jj0z2hMgbqlR3hIWPKjU1jHolOeGnXP+2tF0c2F3kB0Ueaf4k
        9t3IZU5KW+muq9ZhQA+fBxidC8pvwstxit3190ayvQ==
X-Google-Smtp-Source: ABdhPJxLCHU0MQYVgc/uBXpq+K6HD33HgyiCFz2GIJd2VMmVokwPgYtlhEF5G0gY2l4CgowoEB3IVV4/5rAmM8IINuc=
X-Received: by 2002:a67:e359:: with SMTP id s25mr16473866vsm.55.1623672395365;
 Mon, 14 Jun 2021 05:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210609150230.9291-1-narmstrong@baylibre.com>
In-Reply-To: <20210609150230.9291-1-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Jun 2021 14:05:59 +0200
Message-ID: <CAPDyKFqRZJ=OvxKJu_0O+JLM0fYf2NQSsQvSXvVojWsaeMpDUA@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 9 Jun 2021 at 17:02, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> It has been reported that usage of memcpy() to/from an iomem mapping is invalid,
> and a recent arm64 memcpy update [1] triggers a memory abort when dram-access-quirk
> is used on the G12A/G12B platforms.
>
> This adds a local sg_copy_to_buffer which makes usage of io versions of memcpy
> when dram-access-quirk is enabled.
>
> Fixes: acdc8e71d9bb ("mmc: meson-gx: add dram-access-quirk")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> [1] 285133040e6c ("arm64: Import latest memcpy()/memmove() implementation")

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 50 +++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
>
>
> Changes since RFC:
> - moved iomem address to bounce_iomem_buf otherwise sparse screamed when feeding memcpy_to/fromio with non iomem pointer
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index b8b771b643cc..3e9b28f18c70 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -165,6 +165,7 @@ struct meson_host {
>
>         unsigned int bounce_buf_size;
>         void *bounce_buf;
> +       void __iomem *bounce_iomem_buf;
>         dma_addr_t bounce_dma_addr;
>         struct sd_emmc_desc *descs;
>         dma_addr_t descs_dma_addr;
> @@ -742,6 +743,47 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
>         writel(start, host->regs + SD_EMMC_START);
>  }
>
> +/* local sg copy to buffer version with _to/fromio usage for dram_access_quirk */
> +static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data,
> +                                 size_t buflen, bool to_buffer)
> +{
> +       unsigned int sg_flags = SG_MITER_ATOMIC;
> +       struct scatterlist *sgl = data->sg;
> +       unsigned int nents = data->sg_len;
> +       struct sg_mapping_iter miter;
> +       unsigned int offset = 0;
> +
> +       if (to_buffer)
> +               sg_flags |= SG_MITER_FROM_SG;
> +       else
> +               sg_flags |= SG_MITER_TO_SG;
> +
> +       sg_miter_start(&miter, sgl, nents, sg_flags);
> +
> +       while ((offset < buflen) && sg_miter_next(&miter)) {
> +               unsigned int len;
> +
> +               len = min(miter.length, buflen - offset);
> +
> +               /* When dram_access_quirk, the bounce buffer is a iomem mapping */
> +               if (host->dram_access_quirk) {
> +                       if (to_buffer)
> +                               memcpy_toio(host->bounce_iomem_buf + offset, miter.addr, len);
> +                       else
> +                               memcpy_fromio(miter.addr, host->bounce_iomem_buf + offset, len);
> +               } else {
> +                       if (to_buffer)
> +                               memcpy(host->bounce_buf + offset, miter.addr, len);
> +                       else
> +                               memcpy(miter.addr, host->bounce_buf + offset, len);
> +               }
> +
> +               offset += len;
> +       }
> +
> +       sg_miter_stop(&miter);
> +}
> +
>  static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  {
>         struct meson_host *host = mmc_priv(mmc);
> @@ -785,8 +827,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>                 if (data->flags & MMC_DATA_WRITE) {
>                         cmd_cfg |= CMD_CFG_DATA_WR;
>                         WARN_ON(xfer_bytes > host->bounce_buf_size);
> -                       sg_copy_to_buffer(data->sg, data->sg_len,
> -                                         host->bounce_buf, xfer_bytes);
> +                       meson_mmc_copy_buffer(host, data, xfer_bytes, true);
>                         dma_wmb();
>                 }
>
> @@ -955,8 +996,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>         if (meson_mmc_bounce_buf_read(data)) {
>                 xfer_bytes = data->blksz * data->blocks;
>                 WARN_ON(xfer_bytes > host->bounce_buf_size);
> -               sg_copy_from_buffer(data->sg, data->sg_len,
> -                                   host->bounce_buf, xfer_bytes);
> +               meson_mmc_copy_buffer(host, data, xfer_bytes, false);
>         }
>
>         next_cmd = meson_mmc_get_next_command(cmd);
> @@ -1176,7 +1216,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                  * instead of the DDR memory
>                  */
>                 host->bounce_buf_size = SD_EMMC_SRAM_DATA_BUF_LEN;
> -               host->bounce_buf = host->regs + SD_EMMC_SRAM_DATA_BUF_OFF;
> +               host->bounce_iomem_buf = host->regs + SD_EMMC_SRAM_DATA_BUF_OFF;
>                 host->bounce_dma_addr = res->start + SD_EMMC_SRAM_DATA_BUF_OFF;
>         } else {
>                 /* data bounce buffer */
> --
> 2.25.1
>
