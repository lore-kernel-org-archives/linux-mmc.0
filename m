Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABDDC7619A
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjCWMOo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjCWMOQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:14:16 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A5F25B9C
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:56 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-544f7c176easo246845867b3.9
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N7lgk6f+q2nEXeqkUqxHnazbXtEwKCKae3zY+1NYR88=;
        b=dCCUMvk8tORlt404OScY7h/k1sjCR9SqoK+Pd9k+QQsZSPAFkp4p01ZaANHdc7xBxm
         F7QNJxfsQgaqTz5Wj49ad+c3sBbKYw6RFYX2oz1eI8cIbFoeHDj4GhThLY2nxNzojico
         sLoXWN/iHtiFFLgPtEhtqS8TcRLB9fguGM8/B5dQ1YWoMKRwECmPPR7aRzbJ7ScymT8B
         lwMe/vybOwZHsNhKlsrRQlxlJBoX+RxTrFo3jIjo1vq3PgN/J/tb1QpCxnzszCgyrfbE
         Hcg6mnnhFD/vZhOPFIC3rL9eq3hFJaDnroswNxlxLo7cdEdnNlHES2goA3V9wlQvLo2R
         QBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7lgk6f+q2nEXeqkUqxHnazbXtEwKCKae3zY+1NYR88=;
        b=v+cFdDtYe7z0Kp6ocn0G1yRl4oOWE+kBgC1QCshQGxj7cSccmxy1ucAOM7tEt/Bwg1
         N+dwRTBa7q6TTB0svgniDSCdU4+gmRaa62UN5NQOkd05BNEjo0TseyNrjMQqMXS7hvvu
         2bZSo4bNht7N69vLVv/ZbIUjTg+D+T2yaG0Cg3siI4fP1U4LchvGrDnjBFrwqgUFn6tY
         FkqAwWuofaXE8dxNhGKe9Q/iEGmbT4qQrsXPB89Bc/Wd6ZHNax9g+7UabtzrXlyCMY1n
         V6potYdUND3V256B1a9B1xFpOuUmHijepNP0BcKxCErjiIR0eGUVipYocrq75ze3Sawb
         qLJw==
X-Gm-Message-State: AAQBX9eHk2f7bU5DFkRbMS4Nfxzjy52SHEzM/3JBH1mmJg2+MtAPfE4/
        vQMYlLOCOaaoOl6/rHI4xli7Tbbiom+qYfvQ7Jy7yQ==
X-Google-Smtp-Source: AKy350ab9pO/mcEnaUl/HDWXZ+Fnty7B9nPqyTX1tQTW/yxspuOWNB+4UF7majPChSEe/kPlAwb+LVwCezJ7W94X0hs=
X-Received: by 2002:a81:b3c3:0:b0:545:343b:ecba with SMTP id
 r186-20020a81b3c3000000b00545343becbamr1735106ywh.0.1679573635527; Thu, 23
 Mar 2023 05:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230316120549.21486-1-rashmi.a@intel.com> <20230316120549.21486-2-rashmi.a@intel.com>
In-Reply-To: <20230316120549.21486-2-rashmi.a@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:13:19 +0100
Message-ID: <CAPDyKFrte0nQYhZCD3FeMo7=z4PczhTi7C7Sp3=7fQ_QvcPbQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mmc: sdhci-of-arasan: Remove Intel Thunder Bay SOC support
To:     rashmi.a@intel.com
Cc:     michal.simek@xilinx.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, kishon@kernel.org, yuancan@huawei.com,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org,
        mgross@linux.intel.com, kris.pan@linux.intel.com,
        adrian.hunter@intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com, vasavi.v.itha@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Mar 2023 at 13:06, <rashmi.a@intel.com> wrote:
>
> From: "A, Rashmi" <rashmi.a@intel.com>
>
> Remove Thunder Bay specific code as the product got cancelled
> and there are no end customers or users.
>
> Signed-off-by: A, Rashmi <rashmi.a@intel.com>
> Reviewed-by: Hunter, Adrian <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 29 +----------------------------
>  1 file changed, 1 insertion(+), 28 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 89c431a34c43..fbafc87266aa 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -193,13 +193,6 @@ static const struct sdhci_arasan_soc_ctl_map intel_lgm_sdxc_soc_ctl_map = {
>         .hiword_update = false,
>  };
>
> -static const struct sdhci_arasan_soc_ctl_map thunderbay_soc_ctl_map = {
> -       .baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
> -       .clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
> -       .support64b = { .reg = 0x4, .width = 1, .shift = 24 },
> -       .hiword_update = false,
> -};
> -
>  static const struct sdhci_arasan_soc_ctl_map intel_keembay_soc_ctl_map = {
>         .baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
>         .clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
> @@ -465,15 +458,6 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>                         SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>
> -static const struct sdhci_pltfm_data sdhci_arasan_thunderbay_pdata = {
> -       .ops = &sdhci_arasan_cqe_ops,
> -       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -               SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> -               SDHCI_QUIRK2_STOP_WITH_TC |
> -               SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
> -};
> -
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver
> @@ -1150,12 +1134,6 @@ static struct sdhci_arasan_of_data sdhci_arasan_generic_data = {
>         .clk_ops = &arasan_clk_ops,
>  };
>
> -static const struct sdhci_arasan_of_data sdhci_arasan_thunderbay_data = {
> -       .soc_ctl_map = &thunderbay_soc_ctl_map,
> -       .pdata = &sdhci_arasan_thunderbay_pdata,
> -       .clk_ops = &arasan_clk_ops,
> -};
> -
>  static const struct sdhci_pltfm_data sdhci_keembay_emmc_pdata = {
>         .ops = &sdhci_arasan_cqe_ops,
>         .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> @@ -1289,10 +1267,6 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>                 .compatible = "intel,keembay-sdhci-5.1-sdio",
>                 .data = &intel_keembay_sdio_data,
>         },
> -       {
> -               .compatible = "intel,thunderbay-sdhci-5.1",
> -               .data = &sdhci_arasan_thunderbay_data,
> -       },
>         /* Generic compatible below here */
>         {
>                 .compatible = "arasan,sdhci-8.9a",
> @@ -1716,8 +1690,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>
>         if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-emmc") ||
>             of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd") ||
> -           of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio") ||
> -           of_device_is_compatible(np, "intel,thunderbay-sdhci-5.1")) {
> +           of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio")) {
>                 sdhci_arasan_update_clockmultiplier(host, 0x0);
>                 sdhci_arasan_update_support64b(host, 0x0);
>
> --
> 2.17.1
>
