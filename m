Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB77C4320A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED7361246
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbhHXO6I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbhHXO6H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:58:07 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7FBC061764
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y34so46117418lfa.8
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCU02vQPCVRgosx/P23fJfyqXhya+bGULRpnI6avmR0=;
        b=rdV9Y+oO+VdMGr5BqhX09UBghNWF/clEGIf27uALLkpJ5V4Zz28O9+CRNr/rI9fV3Q
         7G4wYcOxN67lJTrtmWxSlK37mKws2ZMSwvZnRhDUS3MBTF7UeBijAx2qkKIV+iCjbpXZ
         8PvY27yGjSKEsXZIMenQRqFlSiCdKWpfd/IgvO7EB0bLXMQIBtaOp4YTafzioQM/Nrk/
         slmHOcq28u70TjJbV43chsHgDR0YuI5McXGOvg0fWD5VXRGYEoazi33GXuC3JDRXx/TV
         tOzmowqFBtQ3SPFR8XfuvsPYJMcVE8kvgJn7ovCMcwmy/hEUJd7PL6aCkKkIp0Y6lvdv
         zuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCU02vQPCVRgosx/P23fJfyqXhya+bGULRpnI6avmR0=;
        b=mcDJKhsG50gfbycJ6c1MF1sJ+t3z9YjA6Soervpw7c/GAroSlGLJoV43dtkVC/Arbw
         Xa3H/dkPfmr3ziO35L38qCH/RoQ7k6qEOMTo//paQTKJsPdlgcFDPW2kaSYymdVgCMCL
         bSwYbvHuwXrVkY0MOoy2JcUNRo4Cr7FF91QH8A8D5Ec+4TMtRVWbSwsvwZNWpBQFuny2
         aIHOm9A/EvV0fEWqjyr+tU7IKz1me2MU0K9jKxwXATqadoHL8wmXQ70zH4dnSpelMG0s
         zPbRP9sPZuTAam3kgQM2j4PuyJsLeiL6K0TLl14ae9+BjO9FcIKOgjmyrQepUSUBMlpG
         OFxg==
X-Gm-Message-State: AOAM53336AWgsS3mtDZ6lxg7aPLJBOcJ7IoA0nmcsXtWKQVizA6tjRr4
        FmvXutZrPEqrZSUvwUULJ6t2/9564dGUKACooeX77w==
X-Google-Smtp-Source: ABdhPJxRJla/SFQy/LavlYVBASTtA3qqzyQgbbFnID1BGsRI/uqwA5R5lVA2m9qSnDfHubRMYHK2MKsxWrFiRS7IaaE=
X-Received: by 2002:a05:6512:318e:: with SMTP id i14mr29774273lfe.113.1629817041551;
 Tue, 24 Aug 2021 07:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <f6fe24f2372c8c627a08ace7187bfe60d35788b6.1629580314.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f6fe24f2372c8c627a08ace7187bfe60d35788b6.1629580314.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:45 +0200
Message-ID: <CAPDyKFr5_MqtbXsk9JWf+oYSFW+uU+W4otq-hu+ZYKq_p+Bokw@mail.gmail.com>
Subject: Re: [PATCH] memstick: switch from 'pci_' to 'dma_' API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 21 Aug 2021 at 23:13, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The wrappers in include/linux/pci-dma-compat.h should go away.
>
> The patch has been generated with the coccinelle script below.
> It has been compile tested.
>
> No memory allocation in involved in this patch, so no GFP_ tweak is needed.
>
> @@ @@
> -    PCI_DMA_BIDIRECTIONAL
> +    DMA_BIDIRECTIONAL
>
> @@ @@
> -    PCI_DMA_TODEVICE
> +    DMA_TO_DEVICE
>
> @@ @@
> -    PCI_DMA_FROMDEVICE
> +    DMA_FROM_DEVICE
>
> @@ @@
> -    PCI_DMA_NONE
> +    DMA_NONE
>
> @@
> expression e1, e2, e3;
> @@
> -    pci_alloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
>
> @@
> expression e1, e2, e3;
> @@
> -    pci_zalloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_free_consistent(e1, e2, e3, e4)
> +    dma_free_coherent(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_single(e1, e2, e3, e4)
> +    dma_map_single(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_single(e1, e2, e3, e4)
> +    dma_unmap_single(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4, e5;
> @@
> -    pci_map_page(e1, e2, e3, e4, e5)
> +    dma_map_page(&e1->dev, e2, e3, e4, e5)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_page(e1, e2, e3, e4)
> +    dma_unmap_page(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_sg(e1, e2, e3, e4)
> +    dma_map_sg(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_sg(e1, e2, e3, e4)
> +    dma_unmap_sg(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
> +    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_single_for_device(e1, e2, e3, e4)
> +    dma_sync_single_for_device(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
> +    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
> +    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2;
> @@
> -    pci_dma_mapping_error(e1, e2)
> +    dma_mapping_error(&e1->dev, e2)
>
> @@
> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
>
> @@
> expression e1, e2;
> @@
> -    pci_set_consistent_dma_mask(e1, e2)
> +    dma_set_coherent_mask(&e1->dev, e2)
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---
>  drivers/memstick/host/r592.c    |  5 ++---
>  drivers/memstick/host/tifm_ms.c | 12 ++++++------
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index 615a83782e55..7ed984360349 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -293,7 +293,7 @@ static int r592_transfer_fifo_dma(struct r592_device *dev)
>
>         /* TODO: hidden assumption about nenth beeing always 1 */
>         sg_count = dma_map_sg(&dev->pci_dev->dev, &dev->req->sg, 1, is_write ?
> -               PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
> +                             DMA_TO_DEVICE : DMA_FROM_DEVICE);
>
>         if (sg_count != 1 || sg_dma_len(&dev->req->sg) < R592_LFIFO_SIZE) {
>                 message("problem in dma_map_sg");
> @@ -310,8 +310,7 @@ static int r592_transfer_fifo_dma(struct r592_device *dev)
>         }
>
>         dma_unmap_sg(&dev->pci_dev->dev, &dev->req->sg, 1, is_write ?
> -               PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
> -
> +                    DMA_TO_DEVICE : DMA_FROM_DEVICE);
>
>         return dev->dma_error;
>  }
> diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
> index 57145374f6ac..c272453670be 100644
> --- a/drivers/memstick/host/tifm_ms.c
> +++ b/drivers/memstick/host/tifm_ms.c
> @@ -279,8 +279,8 @@ static int tifm_ms_issue_cmd(struct tifm_ms *host)
>         if (host->use_dma) {
>                 if (1 != tifm_map_sg(sock, &host->req->sg, 1,
>                                      host->req->data_dir == READ
> -                                    ? PCI_DMA_FROMDEVICE
> -                                    : PCI_DMA_TODEVICE)) {
> +                                    ? DMA_FROM_DEVICE
> +                                    : DMA_TO_DEVICE)) {
>                         host->req->error = -ENOMEM;
>                         return host->req->error;
>                 }
> @@ -350,8 +350,8 @@ static void tifm_ms_complete_cmd(struct tifm_ms *host)
>         if (host->use_dma) {
>                 tifm_unmap_sg(sock, &host->req->sg, 1,
>                               host->req->data_dir == READ
> -                             ? PCI_DMA_FROMDEVICE
> -                             : PCI_DMA_TODEVICE);
> +                             ? DMA_FROM_DEVICE
> +                             : DMA_TO_DEVICE);
>         }
>
>         writel((~TIFM_CTRL_LED) & readl(sock->addr + SOCK_CONTROL),
> @@ -607,8 +607,8 @@ static void tifm_ms_remove(struct tifm_dev *sock)
>                 if (host->use_dma)
>                         tifm_unmap_sg(sock, &host->req->sg, 1,
>                                       host->req->data_dir == READ
> -                                     ? PCI_DMA_TODEVICE
> -                                     : PCI_DMA_FROMDEVICE);
> +                                     ? DMA_TO_DEVICE
> +                                     : DMA_FROM_DEVICE);
>                 host->req->error = -ETIME;
>
>                 do {
> --
> 2.30.2
>
