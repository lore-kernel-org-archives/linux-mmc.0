Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8EEC43217
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Nov 2022 15:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKBPmf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiKBPme (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2022 11:42:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5953428700
        for <linux-mmc@vger.kernel.org>; Wed,  2 Nov 2022 08:42:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v3so1619675pgh.4
        for <linux-mmc@vger.kernel.org>; Wed, 02 Nov 2022 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d3T+apdPM9d/LVHvl4ssAZf/YXXS8AT6BrLPp56q6P4=;
        b=bRoabxpWUjHKwQUA6JkZZIwcLtRde9H8Szf/vDnUvurleAFiQWwrgedTkyfECR07EJ
         mNanCNLUePcOioA5/z/Bd0mCa+5+wDqMb/e9sEZ+R8d5HdEpoZACHT+IL5IxcrgXOoWK
         63A4KtRgpD3JAY53QPxFEmVw+xDNCq8/IDxPjY3sCsQZLJNHoPN7WN2XcYJw0ddSCnWN
         fSpJTl28VbRjRmg+gyk69ngOl6UuZmsaST0LfN0VGB9jGH/2ocnGfX8MTSxMCLu4wFWE
         kAhpn8McWI0chHoTqw9HNUY+CnKLHkFvT+hH3lx50zat5pE6CgrNK33JbMTzJECZmyFb
         Sf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3T+apdPM9d/LVHvl4ssAZf/YXXS8AT6BrLPp56q6P4=;
        b=LZnfYylIe5llytptLCqtszFIYY5XepIoxhG7N9jO5Ea99cIQaeps9B3UtwXNP2ohTT
         SGjaH06p8VFS4GAKbUEz3AuL0/5+vUeXpLEQv1gqkISc1fcwwkWyhQWzvacXZkpj/4W7
         9BOlkndU3wflB+9CzjwOEmu+JSv8OXFU+ySrfOQnZDMprvln8jHry6SobyTDlQbT8LZx
         hPW+LUggNHGLKYkyh1IIeWQbgBviRsv4CjoE3EVyZwVADNAhliSlVSGGKMOpYlkHuWSa
         d1UWWOBqDWJnLSxvl//lIgBE5MvE1jx7HEDLpCbUfsrYz6vZafGS6qpSrP/cuuL9AnbM
         q8MA==
X-Gm-Message-State: ACrzQf1s5ZW5MD1kKIdWoIRnY0ahwB8x1uL7YNWgY0ZWg/hPOFd0i6cc
        XDY9ch7j5pisrzZTZTMCM3kn5+2+tnB8E0x1QOeGRw==
X-Google-Smtp-Source: AMsMyM5VlkFzEUiLRxmTPergQNEyNQ9URlJgnCoi+4jtnGNY54X56u4XM8yxlyw/sQGfd4bQDtFzgTMLMYWYGFCjToA=
X-Received: by 2002:a05:6a00:170a:b0:563:a40a:b5e1 with SMTP id
 h10-20020a056a00170a00b00563a40ab5e1mr25480891pfc.40.1667403751851; Wed, 02
 Nov 2022 08:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221026141631.696863-1-dinguyen@kernel.org> <20221026141631.696863-4-dinguyen@kernel.org>
In-Reply-To: <20221026141631.696863-4-dinguyen@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Nov 2022 16:41:55 +0100
Message-ID: <CAPDyKFpe30P7HzF4yfo=oPt5EwytMtkcCdBakUXkeUYtbmHt7g@mail.gmail.com>
Subject: Re: [PATCHv6 4/6] mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
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

On Wed, 26 Oct 2022 at 16:16, Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> The clock-phase settings for the SDMMC controller in the SoCFPGA
> platforms reside in a register in the System Manager. Add a method
> to access that register through the syscon interface.
>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v6: not getting the clk-phase-sd-hs is not a hard failure
> v5: change error handling from of_property_read_variable_u32_array()
>     support arm32 by reading the reg_shift
> v4: no change
> v3: add space before &socfpga_drv_data
> v2: simplify clk-phase calculations
>
> make property optional in driver
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 43 ++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 9901208be797..fff6222d58e4 100644
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
> @@ -62,9 +68,44 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
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
> +       if (rc < 0) {
> +               dev_info(host->dev, "Optional: clk-phase-sd-hs not found!\n");

Printing things about missing optional features doesn't really make
sense. Please drop this.

> +               return 0;
> +       }
> +
> +       sys_mgr_base_addr = altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
> +       if (IS_ERR(sys_mgr_base_addr)) {
> +               dev_info(host->dev, "Optional: failed to find altr,sys-mgr regmap!\n");

If the clk-phase-sd-hs property is found above, the altr,sysmgr-syscon
property is required, isn't it?

In that case, perhaps this deserves a dev_warn instead?

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

Kind regards
Uffe
