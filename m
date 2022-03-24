Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29411C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Mar 2022 11:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349905AbiCXL5q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Mar 2022 07:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344641AbiCXL5p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2022 07:57:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C7A27C5
        for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2022 04:56:13 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b5so5782975ljf.13
        for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2022 04:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20qzSFu8WfFwCVYdzmq5hRnnFKw8ZDXsTSDNJQxzips=;
        b=F29pMukvvs0UY7bTUtc1Tt9UgguPPK1AYFQx+T/yGyVZ+Y5Kzfd8qOBxFztYBt54Cn
         Ord0ThryohwhU38ZYzUtx2JM/TNVre58iFvSf6gz7nsFXurdeVbJsVGfn2Mzr5GfTACa
         trP9aVf/PauBXoHeuEzqVtqUaMxjGDOPzP9mJ0oOvgkjUN+kXI0BLq0XB/ONhoMIYEpy
         BopNgDvFptw0AiKJd4E1t3M0DWnXWV5g+5E1tZ/g/NLPLVv+yb//veNSaZCFdVKTVFtt
         2D/jQhdtUH18hJDdEFI5bdzei/dowxx0vsllHWmQ6uMte3hIezf7/lLnebGbox7gBFVd
         2ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20qzSFu8WfFwCVYdzmq5hRnnFKw8ZDXsTSDNJQxzips=;
        b=kB+sSVsPZKHBnhyPGAvozMcEU2gvlZRjCnkTxSy3ELnbkoxasafEXutjA0wbCWyz87
         CzXH7/tHneciziErD90UyhO7J7BYxfHX9qAEMh2iGAkk2kQp/x5mVZUIjalxV5sH2s5W
         1iMly8pvb86vaLZud7xJH/0EsTO4p5Tpsdza/fRA0MLqA+lni2EUi/Gt3X83Y99hdeh0
         G10bhb5lieah22j7pfiOONlh1EV40D7GQ346FZr0i6L0zq0SQOqIG5GMsubWtwkC3B6F
         CLo0l3zvBC4xZWfq7M6l18XCCAI9fPnXlYIRaQIEuiHwt7Pb48PyUQKrYaBsaFYFDRPj
         /OZQ==
X-Gm-Message-State: AOAM5322rebz5706GoJLyTXEFZtf7d7hr4Y4u4aOSWzgPoLOYXr60AZY
        uv29Z8XyuqKhmLyvbw4hSR2N+wQicSesw36psqEP5w==
X-Google-Smtp-Source: ABdhPJw0GZRItCAMGMn5UV2L1PQyIs1R+7qQj5XrMCVRXWMeIg8BqBj3QSlStxt7HTPELqkp6gmVtw+jQBG/FeW7xHw=
X-Received: by 2002:a2e:9cc5:0:b0:239:da6e:290d with SMTP id
 g5-20020a2e9cc5000000b00239da6e290dmr3744841ljj.4.1648122971468; Thu, 24 Mar
 2022 04:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220317111944.116148-1-yann.gautier@foss.st.com> <20220317111944.116148-3-yann.gautier@foss.st.com>
In-Reply-To: <20220317111944.116148-3-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Mar 2022 12:55:35 +0100
Message-ID: <CAPDyKFqzzKgLHWiy26QW0hvM9kZEATS_c2mXkTuGiFpPaW8YKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: mmci: stm32: use a buffer for unaligned DMA requests
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 17 Mar 2022 at 12:19, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> In SDIO mode, the sg list for requests can be unaligned with what the
> STM32 SDMMC internal DMA can support. In that case, instead of failing,
> use a temporary bounce buffer to copy from/to the sg list.
> This buffer is limited to 1MB. But for that we need to also limit
> max_req_size to 1MB. It has not shown any throughput penalties for
> SD-cards or eMMC.
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 80 +++++++++++++++++++++++------
>  1 file changed, 63 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 4566d7fc9055..a4414e32800f 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -43,6 +43,9 @@ struct sdmmc_lli_desc {
>  struct sdmmc_idma {
>         dma_addr_t sg_dma;
>         void *sg_cpu;
> +       dma_addr_t bounce_dma_addr;
> +       void *bounce_buf;
> +       bool use_bounce_buffer;
>  };
>
>  struct sdmmc_dlyb {
> @@ -54,6 +57,7 @@ struct sdmmc_dlyb {
>  static int sdmmc_idma_validate_data(struct mmci_host *host,
>                                     struct mmc_data *data)
>  {
> +       struct sdmmc_idma *idma = host->dma_priv;
>         struct scatterlist *sg;
>         int i;
>
> @@ -61,21 +65,23 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
>          * idma has constraints on idmabase & idmasize for each element
>          * excepted the last element which has no constraint on idmasize
>          */
> +       idma->use_bounce_buffer = false;
>         for_each_sg(data->sg, sg, data->sg_len - 1, i) {
>                 if (!IS_ALIGNED(sg->offset, sizeof(u32)) ||
>                     !IS_ALIGNED(sg->length, SDMMC_IDMA_BURST)) {
> -                       dev_err(mmc_dev(host->mmc),
> +                       dev_dbg(mmc_dev(host->mmc),
>                                 "unaligned scatterlist: ofst:%x length:%d\n",
>                                 data->sg->offset, data->sg->length);
> -                       return -EINVAL;
> +                       idma->use_bounce_buffer = true;
> +                       return 0;
>                 }
>         }
>
>         if (!IS_ALIGNED(sg->offset, sizeof(u32))) {
> -               dev_err(mmc_dev(host->mmc),
> +               dev_dbg(mmc_dev(host->mmc),
>                         "unaligned last scatterlist: ofst:%x length:%d\n",
>                         data->sg->offset, data->sg->length);
> -               return -EINVAL;
> +               idma->use_bounce_buffer = true;
>         }
>
>         return 0;
> @@ -84,18 +90,29 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
>  static int _sdmmc_idma_prep_data(struct mmci_host *host,
>                                  struct mmc_data *data)
>  {
> -       int n_elem;
> +       struct sdmmc_idma *idma = host->dma_priv;
>
> -       n_elem = dma_map_sg(mmc_dev(host->mmc),
> -                           data->sg,
> -                           data->sg_len,
> -                           mmc_get_dma_dir(data));
> +       if (idma->use_bounce_buffer) {
> +               if (data->flags & MMC_DATA_WRITE) {
> +                       unsigned int xfer_bytes = data->blksz * data->blocks;
>
> -       if (!n_elem) {
> -               dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
> -               return -EINVAL;
> -       }
> +                       sg_copy_to_buffer(data->sg, data->sg_len,
> +                                         idma->bounce_buf, xfer_bytes);
> +                       dma_wmb();
> +               }
> +       } else {
> +               int n_elem;
> +
> +               n_elem = dma_map_sg(mmc_dev(host->mmc),
> +                                   data->sg,
> +                                   data->sg_len,
> +                                   mmc_get_dma_dir(data));
>
> +               if (!n_elem) {
> +                       dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
> +                       return -EINVAL;
> +               }
> +       }
>         return 0;
>  }
>
> @@ -112,8 +129,19 @@ static int sdmmc_idma_prep_data(struct mmci_host *host,
>  static void sdmmc_idma_unprep_data(struct mmci_host *host,
>                                    struct mmc_data *data, int err)
>  {
> -       dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> -                    mmc_get_dma_dir(data));
> +       struct sdmmc_idma *idma = host->dma_priv;
> +
> +       if (idma->use_bounce_buffer) {
> +               if (data->flags & MMC_DATA_READ) {
> +                       unsigned int xfer_bytes = data->blksz * data->blocks;
> +
> +                       sg_copy_from_buffer(data->sg, data->sg_len,
> +                                           idma->bounce_buf, xfer_bytes);
> +               }
> +       } else {
> +               dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +                            mmc_get_dma_dir(data));
> +       }
>  }
>
>  static int sdmmc_idma_setup(struct mmci_host *host)
> @@ -137,6 +165,16 @@ static int sdmmc_idma_setup(struct mmci_host *host)
>                 host->mmc->max_segs = SDMMC_LLI_BUF_LEN /
>                         sizeof(struct sdmmc_lli_desc);
>                 host->mmc->max_seg_size = host->variant->stm32_idmabsize_mask;
> +
> +               host->mmc->max_req_size = SZ_1M;
> +               idma->bounce_buf = dmam_alloc_coherent(dev,
> +                                                      host->mmc->max_req_size,
> +                                                      &idma->bounce_dma_addr,
> +                                                      GFP_KERNEL);
> +               if (!idma->bounce_buf) {
> +                       dev_err(dev, "Unable to map allocate DMA bounce buffer.\n");
> +                       return -ENOMEM;

If we fail to allocate the 1M bounce buffer, then we end up always
using a PIO based mode, right?

Perhaps we can allow the above allocation to fail, but then limit us
to use DMA only when the buffers are properly aligned? Would that
work?

> +               }
>         } else {
>                 host->mmc->max_segs = 1;
>                 host->mmc->max_seg_size = host->mmc->max_req_size;
> @@ -154,8 +192,16 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
>         struct scatterlist *sg;
>         int i;
>
> -       if (!host->variant->dma_lli || data->sg_len == 1) {
> -               writel_relaxed(sg_dma_address(data->sg),
> +       if (!host->variant->dma_lli || data->sg_len == 1 ||
> +           idma->use_bounce_buffer) {
> +               u32 dma_addr;
> +
> +               if (idma->use_bounce_buffer)
> +                       dma_addr = idma->bounce_dma_addr;
> +               else
> +                       dma_addr = sg_dma_address(data->sg);
> +
> +               writel_relaxed(dma_addr,
>                                host->base + MMCI_STM32_IDMABASE0R);
>                 writel_relaxed(MMCI_STM32_IDMAEN,
>                                host->base + MMCI_STM32_IDMACTRLR);

Kind regards
Uffe
