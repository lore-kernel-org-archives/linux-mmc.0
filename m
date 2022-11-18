Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4AAC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 09:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbiKRJqs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241514AbiKRJqK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 04:46:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1828A8FF8F
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 01:45:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w3-20020a17090a460300b00218524e8877so6667465pjg.1
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 01:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lQZ3h1vhKzY9duIxC3wRAPL/ulwOO0zpQTJ21sthotM=;
        b=GIw5xKRJRRxfpolQXAD2hFya+qMmkMFCDRoWA3TmangkjYxNzcvF3sl+CpGv6tHS/P
         rZxgWrSBFVUYUewvrtx22iwKTI0kuv0eDrSv1cV8wmj6UcHD/0FaeVBtHielco/xkDB5
         4+szmH1wfAPb+6WMH8QK5bNgngZUP9IRg5APMo1Jce+qaMSaV9eQlL8hbAfljgxcMjqu
         Kv5at+LHJE2q87qu4msFxj73UVwxf0wr3qt9l3cCJ9BgNtZ0hjPbNP/Dh8XgEAGZZmk2
         O29l3qr2EeTdiH9JpuEsqIoAn8N8epWkX9u3BY+MEE32UNBxMkHiAUkoxsoSiFw/IDz5
         JgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQZ3h1vhKzY9duIxC3wRAPL/ulwOO0zpQTJ21sthotM=;
        b=5OaivVoYb/v4X11GpC9cZjCPtKpZF0UBpj6qTF0VL4qCbc/W+1jPIuZgMzIU6390Ld
         qjaLfZ8IJ9pNxOU2ZaKLSqPO1ZxaoZoR076U2q45rZvNcL6mUY8XSmzZ8iZq5Y+Ik/h1
         WY5H4lnH6846ShvitcOR2jXkmjlK5HUOuuGqTFfFuJ+XJjVp1Sl4ZeYsaMOb94cd2oPW
         WA+1PhT0CM4LfwgC7tAvTqREBpZQZIy4VblFp76Z6RslB2OUI/+v4t/U+s86jMC9RuK6
         pCyZGh2brY9KVxOB24PWjX/AbCvCEcHn6/1AnAThaxRwgaCbtkGDUmYZbnE0XsGbjg1p
         4PZA==
X-Gm-Message-State: ANoB5pmEB92oo+920H1ZS2G9J4WooxDUUWt3/FWNPbEP6WvmIakRaUv5
        qaeIeWMDoYERULGwe5nR8RG1uSKoJfvfoHGUN7Vz9/sxnOA=
X-Google-Smtp-Source: AA0mqf6SOgRQn9zt/ohGn559eboZTZb2YbBUtJTiGTtIQij6eUyAk6yXIpoJ3FjZMHgxz27+mSeq5OIcqhsCYueFoqQ=
X-Received: by 2002:a17:90a:ae0f:b0:20d:b124:33b1 with SMTP id
 t15-20020a17090aae0f00b0020db12433b1mr6826250pjq.202.1668764754600; Fri, 18
 Nov 2022 01:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20221114230217.202634-1-dinguyen@kernel.org> <20221114230217.202634-4-dinguyen@kernel.org>
In-Reply-To: <20221114230217.202634-4-dinguyen@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Nov 2022 10:45:17 +0100
Message-ID: <CAPDyKFq2jS0NutW9insj1QYW8Ku5YX1H4ncTBv=DfwEraQZF0Q@mail.gmail.com>
Subject: Re: [PATCHv9 4/6] mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Nov 2022 at 00:02, Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> The clock-phase settings for the SDMMC controller in the SoCFPGA
> platforms reside in a register in the System Manager. Add a method
> to access that register through the syscon interface.
>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v9: no changes
> v8: no changes
> v7: use dev_warn if clk-phase-sd-hs is specified, but "altr,sysmgr-syscon"
>     is not found
> v6: not getting the clk-phase-sd-hs is not a hard failure
> v5: change error handling from of_property_read_variable_u32_array()
>     support arm32 by reading the reg_shift
> v4: no change
> v3: add space before &socfpga_drv_data
> v2: simplify clk-phase calculations
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 41 ++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 9901208be797..13e55cff8237 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -17,10 +17,16 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
> +#include <linux/mfd/altera-sysmgr.h>
> +#include <linux/regmap.h>
>
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
>
> +#define SOCFPGA_DW_MMC_CLK_PHASE_STEP  45
> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel, reg_shift) \
> +       ((((smplsel) & 0x7) << reg_shift) | (((drvsel) & 0x7) << 0))
> +
>  int dw_mci_pltfm_register(struct platform_device *pdev,
>                           const struct dw_mci_drv_data *drv_data)
>  {
> @@ -62,9 +68,42 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
>  };
>  EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
>
> +static int dw_mci_socfpga_priv_init(struct dw_mci *host)
> +{
> +       struct device_node *np = host->dev->of_node;
> +       struct regmap *sys_mgr_base_addr;
> +       u32 clk_phase[2] = {0}, reg_offset, reg_shift;
> +       int i, rc, hs_timing;
> +
> +       rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
> +       if (rc < 0)
> +               return 0;
> +
> +       sys_mgr_base_addr = altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
> +       if (IS_ERR(sys_mgr_base_addr)) {
> +               dev_warn(host->dev, "clk-phase-sd-hs was specified, but failed to find altr,sys-mgr regmap!\n");
> +               return 0;
> +       }
> +
> +       of_property_read_u32_index(np, "altr,sysmgr-syscon", 1, &reg_offset);
> +       of_property_read_u32_index(np, "altr,sysmgr-syscon", 2, &reg_shift);
> +
> +       for (i = 0; i < ARRAY_SIZE(clk_phase); i++)
> +               clk_phase[i] /= SOCFPGA_DW_MMC_CLK_PHASE_STEP;
> +
> +       hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1], reg_shift);
> +       regmap_write(sys_mgr_base_addr, reg_offset, hs_timing);
> +
> +       return 0;
> +}
> +
> +static const struct dw_mci_drv_data socfpga_drv_data = {
> +       .init           = dw_mci_socfpga_priv_init,
> +};
> +
>  static const struct of_device_id dw_mci_pltfm_match[] = {
>         { .compatible = "snps,dw-mshc", },
> -       { .compatible = "altr,socfpga-dw-mshc", },
> +       { .compatible = "altr,socfpga-dw-mshc", .data = &socfpga_drv_data, },
>         { .compatible = "img,pistachio-dw-mshc", },
>         {},
>  };
> --
> 2.25.1
>
