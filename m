Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04348C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 11:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2EB61994
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 11:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350426AbhI3L1M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Sep 2021 07:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350437AbhI3L1G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2021 07:27:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA16BC06176E
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2021 04:25:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i19so20860722lfu.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2021 04:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8PvzGV7RQh9r19dv7sQTAnPOmVRl05fj0IURPoGTjE=;
        b=RXfkA+78yN2AQYzVjgxXgCUGzZNUhbTFuc4ZS4gofT3I8tJ2l+/uKe+ri6q1WKsmtt
         JhkaOU7nWduEFt+meXYv3p6g3K2J6cecRxgrVhLl+L5SvKZR2o+stcNUAY0kyMJOyQ4k
         xbpku8hUtiZ2b5dvIXGlfgnvzCe1TpZLKQGU2mE9ZutxqPKDscNkDX8L+3N71xBVPElG
         5jrqMpTc7TwMmBOZgaeDHoik6ZSWNSMkMNf76y1ISu5XjYJcs4FuVvl0KmRg8azGnWwc
         nyiR8sJHyPaxwHLA+DVVIBzxduHcE8yxJbTNKA8Ga3pLHglJngTOJl6TL13LWTdnVMJE
         UnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8PvzGV7RQh9r19dv7sQTAnPOmVRl05fj0IURPoGTjE=;
        b=e4LU8QVSBYldb+WgZO/3MEsdafwtvU8PGtavl9wr3a9j5zvY/UZJlws/4S2hfrSZpF
         oSWREDUD889ezKWGSk+t0rvGhzljwm2cVbrx5UTV1H1R8jInoTM8m8E+a00oqrYKAAKe
         p3iRSWt7cTVq6YxI6+VPv0jT16mLduxX8toOan40uWy9sUkewF2AWirc6NpAv3BH+F5u
         3GwtJEre6uJA4eGnMFwwiE/f2HPxocknXzn8MMSvgUqW6i4JJlLaPQJgQMp7A53yMy9L
         lUXxNKOgICr+++12PumXqkR8PU6rDqnRc6a035CyIpR9wMqqbV53szc6Jpmp0g/WPKkP
         nr+Q==
X-Gm-Message-State: AOAM532Qv2HTbkOjYCt3avuT88qIJ2T/ezm+BrFt5G+swUoVTADBNy6b
        FDZtZE+Eg8N88W7bfIGoV4U3x6JiJsjiJyuS+k2r4A==
X-Google-Smtp-Source: ABdhPJzqAgHZsEsSUpxycEma4VWu16tr1ftIM/UiErO8t6pDuEHCXDKqX+uW4bQjUZYqCDKNXtdclOjuZZIpv/IsnBQ=
X-Received: by 2002:a05:6512:3095:: with SMTP id z21mr169648lfd.167.1633001121852;
 Thu, 30 Sep 2021 04:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210928073652.434690-1-narmstrong@baylibre.com>
In-Reply-To: <20210928073652.434690-1-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Sep 2021 13:24:45 +0200
Message-ID: <CAPDyKFqZX4BNZcZ3NgpPiMcabXj2-tetR8cEvy-LV3JSxRG-og@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: meson-gx: do not use memcpy_to/fromio for dram-access-quirk
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

On Tue, 28 Sept 2021 at 09:37, Neil Armstrong <narmstrong@baylibre.com> wrote:
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
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
> - added sg pre-validation at meson_mmc_request and dropped checks in meson_mmc_copy_buffer
>
>  drivers/mmc/host/meson-gx-mmc.c | 73 ++++++++++++++++++++++++++-------
>  1 file changed, 59 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 3f28eb4d17fe..8f36536cb1b6 100644
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
> @@ -764,21 +764,27 @@ static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data
>         sg_miter_start(&miter, sgl, nents, sg_flags);
>
>         while ((offset < buflen) && sg_miter_next(&miter)) {
> -               unsigned int len;
> +               unsigned int buf_offset = 0;
> +               unsigned int len, left;
> +               u32 *buf = miter.addr;
>
>                 len = min(miter.length, buflen - offset);
> +               left = len;
>
> -               /* When dram_access_quirk, the bounce buffer is a iomem mapping */
> -               if (host->dram_access_quirk) {
> -                       if (to_buffer)
> -                               memcpy_toio(host->bounce_iomem_buf + offset, miter.addr, len);
> -                       else
> -                               memcpy_fromio(miter.addr, host->bounce_iomem_buf + offset, len);
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
> @@ -830,7 +836,11 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
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
> @@ -849,12 +859,43 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>         writel(cmd->arg, host->regs + SD_EMMC_CMD_ARG);
>  }
>
> +static int meson_mmc_validate_dram_access(struct mmc_host *mmc, struct mmc_data *data)
> +{
> +       struct scatterlist *sg;
> +       int i;
> +
> +       /* Reject request if any element offset or size is not 32bit aligned */
> +       for_each_sg(data->sg, sg, data->sg_len, i) {
> +               if (!IS_ALIGNED(sg->offset, sizeof(u32)) ||
> +                   !IS_ALIGNED(sg->length, sizeof(u32))) {
> +                       dev_err(mmc_dev(mmc), "unaligned sg offset %u len %u\n",
> +                               data->sg->offset, data->sg->length);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>         struct meson_host *host = mmc_priv(mmc);
>         bool needs_pre_post_req = mrq->data &&
>                         !(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
>
> +       /*
> +        * The memory at the end of the controller used as bounce buffer for
> +        * the dram_access_quirk only accepts 32bit read/write access,
> +        * check the aligment and length of the data before starting the request.
> +        */
> +       if (host->dram_access_quirk && mrq->data) {
> +               mrq->cmd->error = meson_mmc_validate_dram_access(mmc, mrq->data);
> +               if (mrq->cmd->error) {
> +                       mmc_request_done(mmc, mrq);
> +                       return;
> +               }
> +       }
> +
>         if (needs_pre_post_req) {
>                 meson_mmc_get_transfer_mode(mmc, mrq);
>                 if (!meson_mmc_desc_chain_mode(mrq->data))
> @@ -999,7 +1040,11 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
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
