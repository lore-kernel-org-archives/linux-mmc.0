Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FD6C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Sep 2022 11:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiI2LVJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Sep 2022 07:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiI2LVI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2022 07:21:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13D6115BC9
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2022 04:21:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y20so997105plb.2
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2022 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sCaynwcp4f26Qsuas0gm084M63BBFBWC/hIFRDkk3Uw=;
        b=tegmkaiPhW3cNmFDnub5MjTxArl0I20BRME+tLmlGxvQMKqNELC4Lu0bz+FdmpapSG
         +6LU34q2RN17fs/xdyQaxIobLucq+S4NEAoF3PPkmOcwY+7o/4d+mnFK7Merc18/aND3
         J2dHhtSk5ULfx1fCST65ll60SPlMrxErT/AKm6jcOC5Ye7TZdSqbpDBZjWel0BjD5xnI
         4GsuK+xI+zyKEAARB3ktNSqOOCYfzHXV20YDfI6W3+/Xr47YJLOCS2bg5G05aTdNJk/v
         C/qfztBwtKKt3oI566phuyGXKMY6wzYdNsZq3vaUEzgVbjnh9HAM1PMdoq31Z+S/UJb3
         M5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sCaynwcp4f26Qsuas0gm084M63BBFBWC/hIFRDkk3Uw=;
        b=y3z5Itw09JpUrLtjNYV/kLFDgx6AwxcV0g/SoarVtmgu1pzlg5EmyUvMN2EZOusw5N
         NXeAQJSlfN+NurDnFYlcCn6n3Bpxpz5cW3Q+G5UvcChn4DWzTLZsGNDtkIz8QmCCVEYc
         nWn2bnpboihuZAA5izGl8KolOHiKdpD6OmoJNVRKqq4/GK4qsTjHeUBzsjqb2MlhE9ze
         2GBZ9xjTYilFarRZ5Wk2wNzlfRYwGacGwkX4/N8sLJFR/7kb23eooho1rKPz8Crit+Wl
         oaC+7NHRmbvzEW0MEYbDC9C6dviSQccsjZN8b/FocMa44xg8gC8klyTbqkfkBfr0JKb8
         WG6g==
X-Gm-Message-State: ACrzQf1v57bWurHlVUGIOIj2qIhrY0y67d87gdLdjSfVcfDZR1XuYaJP
        DJZxx1zUvWU7yFnXj4fb4Kic6+pHhpSgZ3RM8N/Y8Q==
X-Google-Smtp-Source: AMsMyM7PjjksYIL3HcmPj9LulM/zObjITKi55mnpApJWRDOIQBM+olQxhw0R6qsZVsb6XY5E4dAqRQBy4y7gVobhsvg=
X-Received: by 2002:a17:90a:aa96:b0:205:bb67:a85f with SMTP id
 l22-20020a17090aaa9600b00205bb67a85fmr3169404pjq.202.1664450465517; Thu, 29
 Sep 2022 04:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220928165420.1212284-1-dinguyen@kernel.org> <20220928165420.1212284-3-dinguyen@kernel.org>
In-Reply-To: <20220928165420.1212284-3-dinguyen@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Sep 2022 13:20:28 +0200
Message-ID: <CAPDyKFpF3rxYiHVeDyUCirciQKzrOJjPayZFQkFCoX6JXf8P1Q@mail.gmail.com>
Subject: Re: [PATCHv4 3/3] mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Sept 2022 at 18:54, Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> The clock-phase settings for the SDMMC controller in the SoCFPGA
> Strarix10/Agilex/N5X platforms reside in a register in the System
> Manager. Add a method to access that register through the syscon
> interface.
>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v4: no change
> v3: add space before &socfpga_drv_data
> v2: simplify clk-phase calculations
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 41 ++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 9901208be797..0f07fa6d0150 100644
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
> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
> +       ((((smplsel) & 0x7) << 4) | (((drvsel) & 0x7) << 0))
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
> +       u32 clk_phase[2] = {0}, reg_offset;
> +       int i, rc, hs_timing;
> +
> +       rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
> +       if (rc) {

This looks wrong, as rc may contain a negative error code,when there
is no clk-phase-sd-hs property found.

Instead, we probably want to check "if (rc < 0)" here instead, then
bail out, but without breaking backwards compatibility.

> +               sys_mgr_base_addr =
> +                       altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
> +               if (IS_ERR(sys_mgr_base_addr)) {
> +                       pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
> +                       return 1;
> +               }
> +       } else
> +               return 1;
> +
> +       of_property_read_u32_index(np, "altr,sysmgr-syscon", 1, &reg_offset);
> +
> +       for (i = 0; i < ARRAY_SIZE(clk_phase); i++)
> +               clk_phase[i] /= SOCFPGA_DW_MMC_CLK_PHASE_STEP;
> +
> +       hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
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

Kind regards
Uffe
