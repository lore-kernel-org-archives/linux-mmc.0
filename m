Return-Path: <SRS0=BwSF=5X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE21C2BA1A
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Apr 2020 01:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9237C20692
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Apr 2020 01:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuDQD19F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDGBSp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:18:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45124 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDGBSo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Apr 2020 21:18:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id t17so1772720ljc.12
        for <linux-mmc@vger.kernel.org>; Mon, 06 Apr 2020 18:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnnaieBMYtH8tBz+uOZHqXqOnY597whaeQ5KH/tZ6PI=;
        b=IuDQD19FsKgVRQNx4NbGbcTDDLKrG7Knwemayb+efXkLUIGiR6fTmoVZ0qJQxNTnKN
         ozQLjLrvLYEVZkvXwJDm04HN1BwooS5lzoG6cx+VPNRVqGQnjbJYUICpqWX637HzrR44
         KsCeBZUZLEMjdCKUU2VDZs/UxOffVFopp+zuFHl5lI5c63tum24VwbdKHXPfHEbiZOVQ
         p/DDs/BllShS3rRTkyqV3/+Def1qMzU5uJK1II0j0CSeYbwP1spRU+Nv0tbEfr+qxnEP
         No5E3fl2DVfNREy5SrykdObGm8A964nNRtPJzp15OIv1b5J1GagSJejB8R0BHZ3s0bgX
         xysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnnaieBMYtH8tBz+uOZHqXqOnY597whaeQ5KH/tZ6PI=;
        b=STJTenM3Xn2jkljWGgf97aKqcdg27JLDgLgSX6DpqiOwxpikN8rLJ4qKlfBwMB3qxX
         K4BjojEWb5qHVUBq+4K0D9rhHrqJVI6xuKGv+IqgYwIVn2G1ZP/0yHPclhopZjhMpcs3
         j7+4EZTBeTXcXg5WryKHiS7rsoGoaSdyvT/PHoYiImLmEaEsPS3nHFsrOHtfo+V5/aq+
         GlXgzS2p3DZcVQ5NqFos1gEsMIzvfVcV2zTEmgBUH5kWV5W0QuUfr4bT0xrfn90YdmtZ
         hXezypGm+4BRWhgbLBgyZiyYB3hbEl1PQ2ZcXnHxaYShd5BNImTpdst71L1o8K6V0unU
         876Q==
X-Gm-Message-State: AGi0Pua3zTWtfNjf47KEK0gR/3Fisdpt8MOLJ+FZJT3tNPVl6jjxkcuP
        KD23yFi8eikOOslKrutC4eMCAhbDj7A9i5H2AV4=
X-Google-Smtp-Source: APiQypLdckJzrzEt6S+SXIU59sonTXc+Vfa6lNGynhr59/prNFtUnGh5f2zOkWXnh1aR7zLMgpVqBiomnzrGX1Sipyo=
X-Received: by 2002:a2e:3e1a:: with SMTP id l26mr41920lja.15.1586222322718;
 Mon, 06 Apr 2020 18:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200406113724.8504-1-ulf.hansson@linaro.org>
In-Reply-To: <20200406113724.8504-1-ulf.hansson@linaro.org>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 7 Apr 2020 09:18:30 +0800
Message-ID: <CADBw62oUTN5fPecRF9c4v=QNzFWWVXgtbBuP-uis-4Xc1VEEPw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: Drop redundant cap flags
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 6, 2020 at 7:37 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The MMC_CAP_ERASE and MMC_CAP_CMD23 flags are already being set in the
> common sdhci_setup_host(). This makes it redundant to set them for
> sdhci-sprd, so let's drop them.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks Ulf.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 2ab42c59e4f8..60c3a4c620f9 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -556,7 +556,8 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>                 sdhci_sprd_voltage_switch;
>
>         host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> -               MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
> +               MMC_CAP_WAIT_WHILE_BUSY;
> +
>         ret = mmc_of_parse(host->mmc);
>         if (ret)
>                 goto pltfm_free;
> --
> 2.20.1
>


-- 
Baolin Wang
