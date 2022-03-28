Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35DAC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Mar 2022 14:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243631AbiC1OHD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243629AbiC1OHC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2022 10:07:02 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7AE1AF13
        for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2022 07:05:20 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2e68c95e0f9so150372967b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2022 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3+Dl/fXqkR61IfHf3wdo0RZbRkOVxgqnRH8r2jeutA=;
        b=F0qAKt4+iXjNX+pakdSa7x85Hn986B7jQP5dnq1voAdEAgo2Xw9JCdT3BC/J7IZYye
         jqT+PdfRl6t5wmBJVeUf6zzZnw7H++P5plLUtrByacGW/np2yQfcuqGBSPKGxDqPMiT2
         oGBjW/sxYst5dVTVwxWHp4ZTAoxezVYAxaTyqB39ZYxuhr94EcXZFw/wy39mcKEzyPZ6
         f3HwDJ7h/HPKPjwQ3dOqmFgOSNLcnUTwNDi/SNKww6Kfzqe/t/3YXvsc1d9dtZ53fF9S
         PoAPCXB/xcPGoOMCR2OHNUVVjCJylwtuHBUb0siyOZHadnBSDPhSRuXBB49iaFvhperQ
         KEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3+Dl/fXqkR61IfHf3wdo0RZbRkOVxgqnRH8r2jeutA=;
        b=VTrimbQOppOVUmbLKJT/dY7lJoFulZOE4M618Qmh9Kzv0d5eD4GMNItXWF8XazGOPp
         W0fjcxbmsfdOTTfA6u4pqegU5T+FAd3CK4H9rdZxDhZ7q3veA6gpyIV5MimihOGTpHCE
         DYpcv8RYiyivMe+izQUX6ZlqKEhhgYb4Zk43GsANXwX1HrhNDobxL+wDYLG8sFbhPF8S
         M/Jbkk+Xaq2u6LLnF4LFyi7RHajPWIN6Is059OXi8eMWAndKIEJ2cycTQbRD5XzNd1Os
         TEzQuP/Gv7HUe+yQsNNVyXZDrQA4ebO2K9lBa6bQzis8ZvfOljHqt1ptQhvS4PE4YS1S
         Er8g==
X-Gm-Message-State: AOAM530LQxRYaKpZcBPuZEyaHjROs0MHuH/0i1mIqVp2+1e2CUAeHmEE
        n1R1Yos50EzjiD7uJ9uUEyVz9BICmLajLOfIqo7mnA==
X-Google-Smtp-Source: ABdhPJyPbUKLtl6wP3iIRYwX01Vwz6zZ+XswSo4Xh6MSyr6T1sjKL8p6Iq/hHnIfAb4w33b8erjRMxXqVXitrUvEZFo=
X-Received: by 2002:a81:1185:0:b0:2ea:9fcf:5ca1 with SMTP id
 127-20020a811185000000b002ea9fcf5ca1mr1977196ywr.37.1648476319626; Mon, 28
 Mar 2022 07:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220320124538.62028-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220320124538.62028-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Mar 2022 16:04:42 +0200
Message-ID: <CAPDyKFrqnt5aWniYHUJo9hTfBRoaqH9eHHmfFL5bUj+C65bQ9g@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: style fix for proper function bodies
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 20 Mar 2022 at 13:45, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Put the braces to the proper position to make reading the code easier.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Queued up on the "devel" branch for v5.19, thanks!

Kind regards
Uffe


> ---
>
> Ideally, should have been in the series I sent out some minutes ago, but
> I just found this now (hey, Murphy!). But not so bad, there is no
> dependency and it can be applied independently.
>
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 1497a46260d4..0bf35fb8b293 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -296,7 +296,8 @@ renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc_host *host, bool enable)
>  }
>
>  static void
> -renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_host *host) {
> +renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_host *host)
> +{
>         u64 val = RST_DTRANRST1 | RST_DTRANRST0;
>
>         renesas_sdhi_internal_dmac_enable_dma(host, false);
> @@ -312,7 +313,8 @@ renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_host *host) {
>  }
>
>  static void
> -renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host) {
> +renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host)
> +{
>         struct renesas_sdhi *priv = host_to_priv(host);
>
>         tasklet_schedule(&priv->dma_priv.dma_complete);
> --
> 2.30.2
>
