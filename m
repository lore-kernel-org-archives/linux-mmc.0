Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27939CD8C8B
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Oct 2023 14:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjJJO16 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjJJO15 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Oct 2023 10:27:57 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3032CA
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 07:27:55 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9a516b015cso1002481276.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696948075; x=1697552875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dT77dimH38lNkEOjl8IbLPxRcBLVK2X43aS4AEihWpM=;
        b=vGj9VZPyTFZobfyj+fkrhPKhxwDZ3o8bIiDQ37YfnfJenNy3ZH7HA4SfdyeoUY2K1m
         9ZEwRgDTuYsnljEX6A+ABS2WM3OqBmpjrHjcvupIqdcU5TMi+cWkn3aGy5BKzzwZRe1k
         vfHyz3ibYX8AyNGZU5hTq9l3n+m5BeYKouiSxuDLqojGXpnxvPnQNRhhmqnyocYgUgzx
         Z+OyJ6fpUpFof85vWUhynelHYwu766IdZoEMML39tFkqayat1QhOHuH+JQHEw5xFmemc
         J71GuQp1nEpylNjqfdIWO7Yk/w7PQDWZWYMmE0tWuOWl804ZZx7jotLdD6K+hOcRBl1L
         k1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948075; x=1697552875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT77dimH38lNkEOjl8IbLPxRcBLVK2X43aS4AEihWpM=;
        b=SZizO1XEI18fHCwgMtePgAPoZA3skFQm8o5OWhv5scIs0z4dRf1V/jyECKBz3TOLym
         8BRu58AHUWkQzhKyAyEjS/lFwVP1FZpvT+mHFEUuJdCH5sbmDtJxWaVSk9/g4Jiym0uC
         hwyP+Fq8LmZT7hC2UWU0jjQqLWhZc9tVM5nFuACIplz4e1atCXBB4ug/8PAf9pR2yGU+
         V8hL3AY4b3SipT/VOmKE189UrcIOZzpn3N6L/fF5OfJ7Cff2GNOoVdvvbSsF5veWTquc
         s1wvVcXsDxDcGadPhGR2MTeE6vNq3Ic7FkqdcvAu3trd2q9wTYU4mimJPYgEou9j18zg
         NChg==
X-Gm-Message-State: AOJu0YyQQUVb7VEktmamxx12RySQJS8nvPCjdFn7uksPd5bZHG7rlyde
        pFbecPlejoAoqhdYufxdFXyQyaqA56X1JqdLazkL2A==
X-Google-Smtp-Source: AGHT+IGWrxLtQd056lvR1T3hdr2BKFoq4kFj36v28+Mx5Z06v6657RWnOLDen1pD9HpMm5ZtwX8ltnK12vixWnT1Ra0=
X-Received: by 2002:a25:24cd:0:b0:d81:cdda:729c with SMTP id
 k196-20020a2524cd000000b00d81cdda729cmr16448284ybk.23.1696948075130; Tue, 10
 Oct 2023 07:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230928135644.1489691-1-ben.wolsieffer@hefring.com>
In-Reply-To: <20230928135644.1489691-1-ben.wolsieffer@hefring.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:27:19 +0200
Message-ID: <CAPDyKFqha53z1wvB8FTXkivE0akoyCbcmU4DCh2qJhBtAbKwtQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmci: use peripheral flow control for STM32
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 28 Sept 2023 at 15:57, Ben Wolsieffer
<ben.wolsieffer@hefring.com> wrote:
>
> From: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
>
> The STM32 SDMMC peripheral (at least for the STM32F429, STM32F469 and
> STM32F746, which are all the currently supported devices using periphid
> 0x00880180) requires DMA to be performed in peripheral flow controller
> mode. From the STM32F74/5 reference manual, section 35.3.2:
>
> "SDMMC host allows only to use the DMA in peripheral flow controller
> mode. DMA stream used to serve SDMMC must be configured in peripheral
> flow controller mode"
>
> This patch adds a variant option to control peripheral flow control and
> enables it for the STM32 variant.
>
> Signed-off-by: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2: use bool instead of u8:1
>
>  drivers/mmc/host/mmci.c | 3 ++-
>  drivers/mmc/host/mmci.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 769b34afa835..90e32f18abbc 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -249,6 +249,7 @@ static struct variant_data variant_stm32 = {
>         .f_max                  = 48000000,
>         .pwrreg_clkgate         = true,
>         .pwrreg_nopower         = true,
> +       .dma_flow_controller    = true,
>         .init                   = mmci_variant_init,
>  };
>
> @@ -1012,7 +1013,7 @@ static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
>                 .dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
>                 .src_maxburst = variant->fifohalfsize >> 2, /* # of words */
>                 .dst_maxburst = variant->fifohalfsize >> 2, /* # of words */
> -               .device_fc = false,
> +               .device_fc = variant->dma_flow_controller,
>         };
>         struct dma_chan *chan;
>         struct dma_device *device;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 253197f132fc..34d9897c289b 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -332,6 +332,7 @@ enum mmci_busy_state {
>   * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
>   * @dma_lli: true if variant has dma link list feature.
>   * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
> + * @dma_flow_controller: use peripheral as flow controller for DMA.
>   */
>  struct variant_data {
>         unsigned int            clkreg;
> @@ -378,6 +379,7 @@ struct variant_data {
>         u8                      dma_lli:1;
>         u32                     stm32_idmabsize_mask;
>         u32                     stm32_idmabsize_align;
> +       bool                    dma_flow_controller;
>         void (*init)(struct mmci_host *host);
>  };
>
> --
> 2.42.0
>
