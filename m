Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3DA12FB0A
	for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029282; cv=none; b=m4O6+JV7JdWljF871EmtP/Xb3NmTqFFyh+BMLMs2Jga4yL+UkTVgNI43x1Dp0jGbiZs6yjrhVCGbbEdU8LKyYok78rNsDTMcKMbEUCTzCW8c1EvhY6Q/mgB4eob959V3BVvrD3OCBRLDtnWe31h4idl/xh4s6JjKwZAKK6p4Ifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029282; c=relaxed/simple;
	bh=rDKXRHVbOfTJ8RkBS9OunsjPzlQzSp2S5/1GvtFg3DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WImbin1+B8FSuYMjXdqxxkFwGBzETh0C/2z0KH6+wS7lVgxrfKJ0/Ls24ceXXK+M0BTSZZkBHWbcaMtimqB4k9eU+o/4mG6u0Kn9fHMpriaBcErKTyxmWY5Y5zu/hWm5Kn/3eR/89Xn48P2ZLAtCIy0cqVJkKHdMlexLJ7LwcoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xb0F5Uuz; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xb0F5Uuz"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df481bf6680so4479821276.3
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2024 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718029280; x=1718634080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HUTNnXRPJHWKeXDCRm55pKx6poqyOs8jFpMjj/b2j0=;
        b=Xb0F5UuzMQv6nePHMUZJMSs1GbN7HdM6MBi+13QcIjl+Yh4H/FlO9KgozQsVBSq74B
         HLEPqvJOQfhDS2EGmbQwRbAJUISJkxytVajP0tFc3llb+YtYV53qyfX28RdE3UVf55rE
         WaEIBgMXrmJ40I/qv5eoHYVoNTvRSveTzHup9P+w5o5a3FtP0iqYi1WDNsMPxEQdOA+u
         rGkxq0x8nVrlBOIKmOuTdrMKs680KRUItKyE9gE25/afJOBF5FioHoJ+gcPxg4/BACVd
         ujKsjigddzBDv8lKIs5U2SAn8I2OK2nLcqRzhwh4jMLaJ3fQmYXTT7DIlF8/eYla5kaL
         IcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029280; x=1718634080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HUTNnXRPJHWKeXDCRm55pKx6poqyOs8jFpMjj/b2j0=;
        b=wIe4CRKOpnWvQVyZPad2SCcwgRYc5J6tqVvNJkyjr0ESOsFNZpMFUIzG1bjWr7A937
         18Tm4pjZ5ZT9c1MOQ6mTVmNjZkIQF4eoiVszlgx8TY3VedVXihLQZGl0r6/7Uz8PL0gh
         XZH+++4U+xeEqgSqobsQSQq0s1eHZlKOPZinhk1Vmof1qEMjk2i6Bcfn7BJsv6PD/wbn
         tZJzFlcb8TBYBi8uj0SO0WpJs9KwGH2vmQJeBFPYcfs4CiMwjKQ5+4z+uz1lifJM91X3
         a6MGhbXOWg367MrxzAf5Q1jNVSwS1sNOiVDs+BPxFwFmPyyVUozceQ5aNWYW8k1QpoCQ
         a8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXgSR5CgrQAt8PJqaTwzuv8hO5DGdH8FRRpXP7OvTzujFAehOiJVRNzgkmtQb8MxZ1I4WWRGo8wQw5zXaCIQhLDY0i5CpjFfVIo
X-Gm-Message-State: AOJu0YyNhbyyDtbEvOVbkWV3ICbgxVRteFPLT0lmll1n3snWcQ9WjjEE
	usV0Q/OGjf3bY5P/wskh1Rq2HT+4vhIVKfoIfBalHxqg2FTgEGjh/wYkLp8os40MJprCzBPrb45
	A3cn3tOSsfGzRNLKazihlw8rvgUU80lW6aXu7ow==
X-Google-Smtp-Source: AGHT+IE9R8++j06G+kusqDs8Y7OBEFKbWddjseLBZGjZpJuevBtlxBQ0Fn3jiZJfzbrNgO/wX7a6NmlrwTMFoGRBFx4=
X-Received: by 2002:a25:d617:0:b0:dfb:39bc:3e4c with SMTP id
 3f1490d57ef6-dfb39bc3fc9mr1779889276.42.1718029280177; Mon, 10 Jun 2024
 07:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-mmc-moxart-revert-v1-1-a01c2f40de9c@linaro.org>
In-Reply-To: <20240606-mmc-moxart-revert-v1-1-a01c2f40de9c@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 10 Jun 2024 16:20:44 +0200
Message-ID: <CAPDyKFpzbdB3tR3+t11KRPU1pD_XiG2h10CDF=W1csV9YrM6Wg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: moxart-mmc: Use sg_miter for PIO"
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sergei Antonov <saproj@gmail.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 20:17, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This reverts commit 3ee0e7c3e67cab83ffbbe7707b43df8d41c9fe47.
>
> The patch is not working for unknown reasons and I would
> need access to the hardware to fix the bug.
>
> This shouldn't matter anyway: the Moxa Art is not expected
> to use highmem, and sg_miter() is only necessary to have
> to properly deal with highmem.
>
> Reported-by: Sergei Antonov <saproj@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 78 ++++++++++++++++++++++++-------------------
>  1 file changed, 43 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 9a5f75163aca..8ede4ce93271 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -131,10 +131,12 @@ struct moxart_host {
>         struct dma_async_tx_descriptor  *tx_desc;
>         struct mmc_host                 *mmc;
>         struct mmc_request              *mrq;
> +       struct scatterlist              *cur_sg;
>         struct completion               dma_complete;
>         struct completion               pio_complete;
>
> -       struct sg_mapping_iter          sg_miter;
> +       u32                             num_sg;
> +       u32                             data_remain;
>         u32                             data_len;
>         u32                             fifo_width;
>         u32                             timeout;
> @@ -146,6 +148,35 @@ struct moxart_host {
>         bool                            is_removed;
>  };
>
> +static inline void moxart_init_sg(struct moxart_host *host,
> +                                 struct mmc_data *data)
> +{
> +       host->cur_sg = data->sg;
> +       host->num_sg = data->sg_len;
> +       host->data_remain = host->cur_sg->length;
> +
> +       if (host->data_remain > host->data_len)
> +               host->data_remain = host->data_len;
> +}
> +
> +static inline int moxart_next_sg(struct moxart_host *host)
> +{
> +       int remain;
> +       struct mmc_data *data = host->mrq->cmd->data;
> +
> +       host->cur_sg++;
> +       host->num_sg--;
> +
> +       if (host->num_sg > 0) {
> +               host->data_remain = host->cur_sg->length;
> +               remain = host->data_len - data->bytes_xfered;
> +               if (remain > 0 && remain < host->data_remain)
> +                       host->data_remain = remain;
> +       }
> +
> +       return host->num_sg;
> +}
> +
>  static int moxart_wait_for_status(struct moxart_host *host,
>                                   u32 mask, u32 *status)
>  {
> @@ -278,29 +309,14 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
>
>  static void moxart_transfer_pio(struct moxart_host *host)
>  {
> -       struct sg_mapping_iter *sgm = &host->sg_miter;
>         struct mmc_data *data = host->mrq->cmd->data;
>         u32 *sgp, len = 0, remain, status;
>
>         if (host->data_len == data->bytes_xfered)
>                 return;
>
> -       /*
> -        * By updating sgm->consumes this will get a proper pointer into the
> -        * buffer at any time.
> -        */
> -       if (!sg_miter_next(sgm)) {
> -               /* This shold not happen */
> -               dev_err(mmc_dev(host->mmc), "ran out of scatterlist prematurely\n");
> -               data->error = -EINVAL;
> -               complete(&host->pio_complete);
> -               return;
> -       }
> -       sgp = sgm->addr;
> -       remain = sgm->length;
> -       if (remain > host->data_len)
> -               remain = host->data_len;
> -       sgm->consumed = 0;
> +       sgp = sg_virt(host->cur_sg);
> +       remain = host->data_remain;
>
>         if (data->flags & MMC_DATA_WRITE) {
>                 while (remain > 0) {
> @@ -315,7 +331,6 @@ static void moxart_transfer_pio(struct moxart_host *host)
>                                 sgp++;
>                                 len += 4;
>                         }
> -                       sgm->consumed += len;
>                         remain -= len;
>                 }
>
> @@ -332,22 +347,22 @@ static void moxart_transfer_pio(struct moxart_host *host)
>                                 sgp++;
>                                 len += 4;
>                         }
> -                       sgm->consumed += len;
>                         remain -= len;
>                 }
>         }
>
> -       data->bytes_xfered += sgm->consumed;
> -       if (host->data_len == data->bytes_xfered) {
> +       data->bytes_xfered += host->data_remain - remain;
> +       host->data_remain = remain;
> +
> +       if (host->data_len != data->bytes_xfered)
> +               moxart_next_sg(host);
> +       else
>                 complete(&host->pio_complete);
> -               return;
> -       }
>  }
>
>  static void moxart_prepare_data(struct moxart_host *host)
>  {
>         struct mmc_data *data = host->mrq->cmd->data;
> -       unsigned int flags = SG_MITER_ATOMIC; /* Used from IRQ */
>         u32 datactrl;
>         int blksz_bits;
>
> @@ -358,19 +373,15 @@ static void moxart_prepare_data(struct moxart_host *host)
>         blksz_bits = ffs(data->blksz) - 1;
>         BUG_ON(1 << blksz_bits != data->blksz);
>
> +       moxart_init_sg(host, data);
> +
>         datactrl = DCR_DATA_EN | (blksz_bits & DCR_BLK_SIZE);
>
> -       if (data->flags & MMC_DATA_WRITE) {
> -               flags |= SG_MITER_FROM_SG;
> +       if (data->flags & MMC_DATA_WRITE)
>                 datactrl |= DCR_DATA_WRITE;
> -       } else {
> -               flags |= SG_MITER_TO_SG;
> -       }
>
>         if (moxart_use_dma(host))
>                 datactrl |= DCR_DMA_EN;
> -       else
> -               sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
>
>         writel(DCR_DATA_FIFO_RESET, host->base + REG_DATA_CONTROL);
>         writel(MASK_DATA | FIFO_URUN | FIFO_ORUN, host->base + REG_CLEAR);
> @@ -443,9 +454,6 @@ static void moxart_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         }
>
>  request_done:
> -       if (!moxart_use_dma(host))
> -               sg_miter_stop(&host->sg_miter);
> -
>         spin_unlock_irqrestore(&host->lock, flags);
>         mmc_request_done(host->mmc, mrq);
>  }
>
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240606-mmc-moxart-revert-beb833b07dcb
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>
