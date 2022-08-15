Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93341C25B08
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 18:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiHOSwA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244603AbiHOSvd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 14:51:33 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C632146D90
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 11:29:23 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q184so9443217oif.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dekSjQzq586Ozy/0ROHpLvRNP0t8RRIkR/ZEE/ywaSc=;
        b=s8fAzi6HP5Z0e36dXT3DjeGWghOsYr8k83XWYXIVHVl1lusDhokwM7OzVjDZ565f6z
         TP6gninP4O0nBdsgCqk+LNeum2bdlJf4y3EJT6KXvFmgMJmeRIVrbt2e3YbAkELKyA2B
         c4hKa6g8FzJS4fGs28ZZFjkyu2yGgk4TELtT6WNkzHEG1fjEfFLzGKjFpMjdoYS/UUPo
         4topzVjPSTQdKJ1Hx1orOL8oM/bRJVkmMHnAzzMcfBw0vqgAkDYC+4XQAGJE7Hy2DUgq
         MLKQ6VMAvDisRrQ4vv/5T1WryFT0YLnohkOGDTLNzE6X5M/tVBOMSlykx1HlKcJH/ZT4
         NGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dekSjQzq586Ozy/0ROHpLvRNP0t8RRIkR/ZEE/ywaSc=;
        b=I9yfcp873AQXVoimU01AUQNEGW6ZIT124hrdRGh2ehCcrJaIZ4QBAf0r7uvf/2S6ZX
         htCaDTRJArbZRkm1uXww0adAXV7vkEc9eFaIBvOJGhVBFa8gO+OpuaQitJ8FwEIGQmPl
         Uvrm9U/MD7WEAivZxELLqfdp7m0v2P+z9rpU5WWDOuQiwyEThW1fD6zQf8gUE9iAOSGs
         y/fBkZbVgJ+NdxMFoXWFex/Eq1Bw7sU45VJuijXizKK0brEbfSGYau4/Ar7Pw0RnlkdI
         F+LvHOkR3FRVtJyx3ebo4PD2EASHzod02e2mJUcAKsTbGi2ni+wgAlXnekAA4kFkigLG
         y60w==
X-Gm-Message-State: ACgBeo0SFmPzcaoWmK4nRYU/Es58tRW8q+EBMwO3Zk/863bBiT2UOmC1
        pdVrQW7yr+Z5frrdSczcWsxRKJ34wnaXIJp5feG2wyGxJsM=
X-Google-Smtp-Source: AA6agR76yeDJ/hxv8Jv1gMy8sPeC7+BbsiHnYBI+8BF+6WBH5RJoxMWOzvdt4DSis0PS1ANKmJqIah+0fkjP70zEC2Q=
X-Received: by 2002:a05:6808:1c06:b0:33a:9b3b:b3ce with SMTP id
 ch6-20020a0568081c0600b0033a9b3bb3cemr7430008oib.53.1660588162506; Mon, 15
 Aug 2022 11:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <3a50873fdbf69f4a95b931a5d05cade04c1dacd0.1659099154.git.limings@nvidia.com>
 <20220809173742.178440-1-limings@nvidia.com>
In-Reply-To: <20220809173742.178440-1-limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 20:28:25 +0200
Message-ID: <CAPDyKFp5M43Rr2YvQuyoDVJJKWfmXOqc=5rzx2df7VK_0DdiLA@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-dwcmshc: add ACPI match data for
 BlueField-3 SoC
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Woods <davwoods@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Aug 2022 at 19:37, Liming Sun <limings@nvidia.com> wrote:
>
> Commit 08f3dff799d43 introduces the of_device_get_match_data()
> checking for some chip but breaks the BlueField-3 firmware which
> uses ACPI instead. This commit adds the ACPI match data and
> quirks/quirks2 to re-enable the support of BlueField-3 SoC.
>
> Reviewed-by: David Woods <davwoods@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Applied for fixes, by adding a stable+fixes tag, thanks!

Kind regards
Uffe


> ---
> v2->v3:
>     Rebase to mmc next
> v1->v2:
>     Fixes an acpi warning
>     Reported-by: kernel test robot <lkp@intel.com>
> v1: Initial version.
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 4e904850973c..a7343d4bc50e 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -349,6 +349,15 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>         .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>
> +#ifdef CONFIG_ACPI
> +static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
> +       .ops = &sdhci_dwcmshc_ops,
> +       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  SDHCI_QUIRK2_ACMD23_BROKEN,
> +};
> +#endif
> +
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>         .ops = &sdhci_dwcmshc_rk35xx_ops,
>         .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> @@ -431,7 +440,10 @@ MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
>
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
> -       { .id = "MLNXBF30" },
> +       {
> +               .id = "MLNXBF30",
> +               .driver_data = (kernel_ulong_t)&sdhci_dwcmshc_bf3_pdata,
> +       },
>         {}
>  };
>  #endif
> @@ -447,7 +459,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         int err;
>         u32 extra;
>
> -       pltfm_data = of_device_get_match_data(&pdev->dev);
> +       pltfm_data = device_get_match_data(&pdev->dev);
>         if (!pltfm_data) {
>                 dev_err(&pdev->dev, "Error: No device match data found\n");
>                 return -ENODEV;
> --
> 2.30.1
>
