Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9F8C6379F
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 16:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15292076E
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 16:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vu16Ujmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389888AbgKWQHk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbgKWQHk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 11:07:40 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D898C061A4D
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:38 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id e127so1586410vkb.5
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/ItqqpCB3WwrW1C+GCf4NN2Kjg8Qry/xoQUCv8LM1Y=;
        b=Vu16UjmbO6sNa5108slHIduaE+yjbGtAc5ye7fxBJdvq7YygR0atRT57IkCM1X31+W
         UUgiwq2aSFoFNzraUyzdqbwX8hu/fONCC6hXIeUo2tKabgHbyllDl5GZCKAda3EDH79N
         Sxz/RslEJC7ZoEx5jpq1sTKXMJqn+pP2LeEKE4aZpdh5WE1o9n4Ju7m/Zpxuhjlqmpz6
         sjeKBWZaKjxfh6ogWeSrHa+0N/ex2uJMz4wwi6UIzBlwI46NpSZgzY4PwGa8Vh5cz7ue
         hnVoluFIbrAf2b0aY3dn74xoWNW4TFSK6ZHnThlMJuxyA1ynf97QfEm/rQ+ExtTj6/3n
         HYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/ItqqpCB3WwrW1C+GCf4NN2Kjg8Qry/xoQUCv8LM1Y=;
        b=CVLATCg6/n6ouFZ4FQtVjgzG18bEHVEUsZxvYttoFT+2wfwJ6QGlXFonUh3gfimSc+
         8ii9LSeX2hMQzrWbP5mgrFeojZ1s8JCQSGCuLhU6euYctEsW7mbVi6OfpksI/9biXVve
         6DgGVeMNKRcOGOsKMhz8mnwQQ5WLF8IciCRXjQz2Ylmxwx2jflhDIKDooVjGayWHAo7H
         QN6qpINdKzhN9kdnW+3mdNKAA+IxRa/GpVQ7q/O8mktHLW4j7LMWO/N6eevMzdIdNyM3
         acmqK1yd/+AyCmM86Dj2zaNe4zTVm1LV7MrFLvR2GEd5K017zFY9E/EcokDUOi8sW2S5
         Z6Tw==
X-Gm-Message-State: AOAM5308lWnyHrLJe3S2AClRYwNqkVOSG4Cwlr4AiFjwWvfEyt47eftg
        aIiE+S0snk+irQYR0nDYugSXL0OcI6+rjQ5AF0lEeA==
X-Google-Smtp-Source: ABdhPJyWnEErE/SiDA8LVPRNMejQR2+57MiKFEIdwOr/gU4OcMsQt0L5pBWLI+QK+wC55RYqTPUdmE3EersH0WdAUv4=
X-Received: by 2002:a1f:2cd4:: with SMTP id s203mr524230vks.6.1606147657783;
 Mon, 23 Nov 2020 08:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20201118120120.24908-1-muhammad.husaini.zulkifli@intel.com> <20201118120120.24908-2-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20201118120120.24908-2-muhammad.husaini.zulkifli@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 17:07:01 +0100
Message-ID: <CAPDyKFp6ws4SKwBXF36CQ2-PiaJtETXupqRsPMCLyUvc9Ho7Kg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: sdhci-of-arasan: Fix clock registration fail
 for Keem Bay SOC
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Nov 2020 at 05:01, <muhammad.husaini.zulkifli@intel.com> wrote:
>
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>
> Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations handling")
> introduces platform specific SDHCI clock operation. Each platform should
> specify clock operations handlers.
>
> Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations handling")
> and Commit 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem Bay")
> are merged about the same time. When doing rebasing during the upstream process,
> Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations handling")
> was not included. This will result in sd clock registration failure for
> Keem Bay SOC Devices as clock operations handlers are not defined.
>
> This patch declares the clock operation for Keem Bay SOC Devices.
> Add clk_ops for SD, EMMC and SDIO operations.
>
> Fixes: 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem Bay")
>
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 829ccef87426..012d52e1abee 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1199,16 +1199,19 @@ static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
>  static struct sdhci_arasan_of_data intel_keembay_emmc_data = {
>         .soc_ctl_map = &intel_keembay_soc_ctl_map,
>         .pdata = &sdhci_keembay_emmc_pdata,
> +       .clk_ops = &arasan_clk_ops,
>  };
>
>  static struct sdhci_arasan_of_data intel_keembay_sd_data = {
>         .soc_ctl_map = &intel_keembay_soc_ctl_map,
>         .pdata = &sdhci_keembay_sd_pdata,
> +       .clk_ops = &arasan_clk_ops,
>  };
>
>  static struct sdhci_arasan_of_data intel_keembay_sdio_data = {
>         .soc_ctl_map = &intel_keembay_soc_ctl_map,
>         .pdata = &sdhci_keembay_sdio_pdata,
> +       .clk_ops = &arasan_clk_ops,
>  };
>
>  static const struct of_device_id sdhci_arasan_of_match[] = {
> --
> 2.17.1
>
