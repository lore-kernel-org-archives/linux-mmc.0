Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B02C04FF3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2125C6108E
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhEXONK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhEXOMy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:12:54 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F768C06138C
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:26 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id u188so14296484vsu.8
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9YMGxXWO3gw0lQ0MfPopfjRGds3L9RPAtVucI8oBh8=;
        b=QtGD1DYPGBFNv8H5o2auNhCqeNje2IV/YM/PBcelPMC5UV8XxqWGu7GXpfiJRCVnzq
         WxLxargTpqSF2/NatjiW5zKmHYbem4i4ioFqno6XfOIxIzm+OGM5+Zf0cJNzGxwvxTki
         BpJQq9zMpm4S2H7n2TS2i5waSARq92xas+rvm8tlQPoIEd60AFrMFb5wusacSxskhq4z
         D0dBJmMkpsyDkqSSyzqaXv+XyNBDgmosENFi/ahz+3syNlrg26pX7mFUfYnQUZ+LeG/e
         ZL0aS+Jb8aK5XJBbQh4/9sd9bPPWiuNmkweyF6GBz5+k6egoozwtSI/CQpTXHt4w6j/H
         bI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9YMGxXWO3gw0lQ0MfPopfjRGds3L9RPAtVucI8oBh8=;
        b=EszhQvs0UcJnVkGRBpT+q0eU8EyhXNtjErQkdgi/c+NBioo208XoaO0Gr9REbr668/
         6iZdMfZzFiTFWOoC/UBQ0EWQ00pmTgAoejeAp1qJhlaMkYlwd3HxKtagzroexIqIJTy9
         eNakps5sTCj+hWY+6DtpVvds3gprsWqIEvw97xp9vzXGRMAYNLRnt7EX9GAJcYKoohsr
         HySovbKIJVsZ2Vt8zkUVL0AZvrdm/bYYLtJkrZT+FND2F6+Y0CY4u+r0QJuocfQ+ncPw
         gG3UunJuHpv3njb6fSWeFTgJSCKozgn5H2QrL0NnY6SBO8wWbxiM5tuQ6CAxi8lEKjDS
         1dbA==
X-Gm-Message-State: AOAM532wrnGpUOzzglAcrJoDYk3vtJ2oXQBUve1/PxvaC618xqRAoooA
        SvitHdHXlvdMjDtTUpU/kiYjlR+KcloA7aVZLUIuWQ==
X-Google-Smtp-Source: ABdhPJxzzAJAoFVRENqAVs40gjeLmdQmf8w/SzQ1OZ0IRexZkd2N+MTwdqJ2gAjRYqb28BnHbaZTd8AXGltSe1mQUnU=
X-Received: by 2002:a67:1087:: with SMTP id 129mr20527619vsq.42.1621865485296;
 Mon, 24 May 2021 07:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210521034432.2321-1-zbestahu@gmail.com>
In-Reply-To: <20210521034432.2321-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:47 +0200
Message-ID: <CAPDyKFqPyyMizqFYfOcphXA3z3oJqod4x014T0D25Lm75uRHFg@mail.gmail.com>
Subject: Re: [PATCH] mmc: cqhci: introduce get_trans_desc_offset()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 21 May 2021 at 05:44, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> The same calculation to get transfer descriptor offset is already used
> at 3 different locations. Let's create a new helper to simplify code.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-core.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index c237b6e..1128dd5 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -45,17 +45,23 @@ static inline u8 *get_link_desc(struct cqhci_host *cq_host, u8 tag)
>         return desc + cq_host->task_desc_len;
>  }
>
> +static inline size_t get_trans_desc_offset(struct cqhci_host *cq_host, u8 tag)
> +{
> +       return cq_host->trans_desc_len * cq_host->mmc->max_segs * tag;
> +}
> +
>  static inline dma_addr_t get_trans_desc_dma(struct cqhci_host *cq_host, u8 tag)
>  {
> -       return cq_host->trans_desc_dma_base +
> -               (cq_host->mmc->max_segs * tag *
> -                cq_host->trans_desc_len);
> +       size_t offset = get_trans_desc_offset(cq_host, tag);
> +
> +       return cq_host->trans_desc_dma_base + offset;
>  }
>
>  static inline u8 *get_trans_desc(struct cqhci_host *cq_host, u8 tag)
>  {
> -       return cq_host->trans_desc_base +
> -               (cq_host->trans_desc_len * cq_host->mmc->max_segs * tag);
> +       size_t offset = get_trans_desc_offset(cq_host, tag);
> +
> +       return cq_host->trans_desc_base + offset;
>  }
>
>  static void setup_trans_desc(struct cqhci_host *cq_host, u8 tag)
> @@ -194,8 +200,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>
>         cq_host->desc_size = cq_host->slot_sz * cq_host->num_slots;
>
> -       cq_host->data_size = cq_host->trans_desc_len * cq_host->mmc->max_segs *
> -               cq_host->mmc->cqe_qdepth;
> +       cq_host->data_size = get_trans_desc_offset(cq_host, cq_host->mmc->cqe_qdepth);
>
>         pr_debug("%s: cqhci: desc_size: %zu data_sz: %zu slot-sz: %d\n",
>                  mmc_hostname(cq_host->mmc), cq_host->desc_size, cq_host->data_size,
> --
> 1.9.1
>
