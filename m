Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA3EC33CAA
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 12:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D9E22314
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 12:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbBc/4dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgATMas (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:30:48 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38760 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATMas (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2020 07:30:48 -0500
Received: by mail-ua1-f65.google.com with SMTP id c7so11394613uaf.5
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2020 04:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lv1MPNHFWjo0ON39JmT/WKcoiXYrc2VnESryks917GQ=;
        b=KbBc/4dcRtTUTAqEZILlwUr8aY7RicPqFPhMqaSmSgzlwm0dy3IJzM7b4zyo+Zrzsw
         svnxqpHLqmfu/U39uaJkhyW6K4YfC4pTchVUYxbYpLtPgb7cxAdYtkEh7YoHdGewhpRs
         h3LU2bIXgQgYwpw16fgmeiibpjlKKOANnAEJDLHchHtRomnhB4Jq4HfvqX2+RRTjB5lQ
         A/e0AynR6pmlCcZS02DbmEQOQHzOr7HPiFkK+pzIahsa5bEstoVabJQ3/nML6fq8QpHd
         EMKShIQrb4iLXPTncGaba/ZAh00ITKCYC0nYUwpzcjxlv+J8FAVkTUwTGCAX6fUwgQZZ
         PO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lv1MPNHFWjo0ON39JmT/WKcoiXYrc2VnESryks917GQ=;
        b=cAGcn+Jb0dgi1gVxWn3zAs/vIIYYDa8DYD69QtfV04/6bQFiYpufNHJq+fbHCOwgIM
         A8z+7QmxHBNcPXrDkl8oSwM4HHN3EjoDPp20d8lv0P1I5I0fX2iSFDBfnHOMdiPtZSgi
         RbGp6RSpn7yKVwAp1IFDIwJ3ZrO6rIWThXHCcLLtZVkse/TucsHmfJjHsyByjaTK/qoo
         6aBacvpY7KleeItHdi2m7w+Ko57thlmqPInEw/jKXEV0/8RyXHwjfON8dQbgpSCFwOwm
         Mh8v4rZXeG+kmj1pSs8Ywbl8Pl4Qrdcr37n9Jl40mWb4gbeFvLhidyjK8pb+kuZV9qh7
         nUIw==
X-Gm-Message-State: APjAAAXrS3sBD3Kc+xcTxwyxqeh8QQntdxmhrUR9TtX/y6tP1moWD2ks
        aJtu+cXfjf4fhddz6W9brUoVrjWtQV2goSri30ORnw==
X-Google-Smtp-Source: APXvYqzNrQBcQkFDTb0eI4iFF9c5IVvIUVfCzKrf7Q91wzKsTXRso+/BH2LPw2j43fbOz+5HHbJhZ8ItCp5b05IWoZc=
X-Received: by 2002:ab0:740e:: with SMTP id r14mr28922933uap.104.1579523447188;
 Mon, 20 Jan 2020 04:30:47 -0800 (PST)
MIME-Version: 1.0
References: <1579194192-7942-2-git-send-email-vbadigan@codeaurora.org> <1579519045-26467-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1579519045-26467-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Jan 2020 13:30:09 +0100
Message-ID: <CAPDyKFq4yE6bcxjFrw0jzqL6i73jKSXUGshSDtFuNA+yaWLjpw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] mmc: sdhci: Let a vendor driver supply and update
 ADMA descriptor size
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>, cang@codeaurora.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Jan 2020 at 12:26, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Let a vendor driver supply the maximum descriptor size that it
> can operate on. ADMA descriptor table would be allocated using this
> supplied size.
> If any SD Host controller is of version prior to v4.10 spec
> but supports 16byte descriptor, this change allows them to supply
> correct descriptor size for ADMA table allocation.
>
> Also let a vendor driver update the descriptor size by overriding
> sdhc_host->desc_size if it has to operates on a different descriptor
> sizes in different conditions.
>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Applied for next, and by adding Adrian's ack, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 13 +++++++------
>  drivers/mmc/host/sdhci.h |  3 ++-
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3140fe2..44fb446 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3822,14 +3822,15 @@ int sdhci_setup_host(struct sdhci_host *host)
>                 void *buf;
>
>                 if (host->flags & SDHCI_USE_64_BIT_DMA) {
> -                       host->adma_table_sz = host->adma_table_cnt *
> -                                             SDHCI_ADMA2_64_DESC_SZ(host);
> -                       host->desc_sz = SDHCI_ADMA2_64_DESC_SZ(host);
> +                       if (!host->alloc_desc_sz)
> +                               host->alloc_desc_sz =
> +                                       SDHCI_ADMA2_64_DESC_SZ(host);
>                 } else {
> -                       host->adma_table_sz = host->adma_table_cnt *
> -                                             SDHCI_ADMA2_32_DESC_SZ;
> -                       host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
> +                       host->alloc_desc_sz = SDHCI_ADMA2_32_DESC_SZ;
>                 }
> +               host->desc_sz = host->alloc_desc_sz;
> +               host->adma_table_sz = host->adma_table_cnt *
> +                                             host->desc_sz;
>
>                 host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN;
>                 /*
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0ed3e0e..10bda3a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -554,7 +554,8 @@ struct sdhci_host {
>         dma_addr_t adma_addr;   /* Mapped ADMA descr. table */
>         dma_addr_t align_addr;  /* Mapped bounce buffer */
>
> -       unsigned int desc_sz;   /* ADMA descriptor size */
> +       unsigned int desc_sz;   /* ADMA current descriptor size */
> +       unsigned int alloc_desc_sz;     /* ADMA descr. max size host supports */
>
>         struct workqueue_struct *complete_wq;   /* Request completion wq */
>         struct work_struct      complete_work;  /* Request completion work */
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
