Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AAFC433E9
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE0364E5B
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCSON3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhCSONB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2021 10:13:01 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1B4C06175F
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:13:01 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id c2so3083076uaj.3
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81d6GJrELSSCW5LCwqTVpfRPWOljAmWO/kZTe23h7B8=;
        b=wCn+QVvs88WpK76XaHVCjFhwcJhitd+9EKnzCu4+1ftgPwZOu+LiHzdy5TPk6jUm4B
         iKkADz+PwQU0N/0Fiq50VrUu/GY3anDvBoHZFVf57Rwo9AwgFS0btoe2p0lQ4x517SHM
         Ki9aGNFTGvCcPQPfPPJxx4BAysWQOrWda4q9UbloQuqJ1Z7J+qYxExLbm8ntIlcwn8bk
         P4yY8uB0Oz3QOt+anyCwoEM7DEPQreMyAlO0njGePHxijzxxvSrYnIlqheEhhM8BhSEy
         cwmyF1hAxaj2BltUAbkYOhH2crFGZKETjPMssWeVx0PgmYyBUoiPHN+DXp1ywlJKQH1R
         JMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81d6GJrELSSCW5LCwqTVpfRPWOljAmWO/kZTe23h7B8=;
        b=Z8vwEBfjQJmv0eCiuwaEDVO0+neDYq9YMoCoEqmFxtaALIW3qC+49kZkOYPRco5o8d
         K6bjHXTKvKxivU9l4uizsh+uaGsdjqXFnnzP/pvfSXem1ea0usvi2JlIf9X+AInzQI18
         t7s2vucghnJliP3SroAgaLAKvG7N+NmhFgIX+lm+7RJ5DPjKyXP5V8pjahmKCId+z1Fg
         6o/dgXEpjJTPsQFZ79nSQZunwEoq6ungI133J+Z4ZS9sKqigH/7CuznbqusKWXAxQESE
         ErKoMy6uUUm3KuzC0y8HrkCEz3+s+hGQxbmmWzf9c9otgos2mk+mCzpont/sVex/OKnA
         o0+A==
X-Gm-Message-State: AOAM530BQBNyU2fMI4KVE5RQyNokxDGCGtfMGLxMbuoQBDxCafXEffsH
        sqzDRBjSoIoH2rqmi0G81pMAYnugCUOd9yF27wyWkw==
X-Google-Smtp-Source: ABdhPJz0NP/HIhZGzGr1PxFUVl/mUsvWgNgSY5kPIr19GJ66RgVfgXdMVEi2rkXoJCQAnGYFxtpvSwhwfYefkzrXtqc=
X-Received: by 2002:ab0:7a68:: with SMTP id c8mr5520428uat.104.1616163180444;
 Fri, 19 Mar 2021 07:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <1615879102-45919-1-git-send-email-shawn.lin@rock-chips.com> <1615879102-45919-3-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1615879102-45919-3-git-send-email-shawn.lin@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 15:12:23 +0100
Message-ID: <CAPDyKFqGhqT-dD5djp3vnWoXeg+01=294+nS69AxyY3G69P1eg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mmc: sdhci-of-dwcmshc: add rockchip platform support
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Mar 2021 at 08:18, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> sdhci based synopsys MMC IP is also used on some rockchip platforms,
> so add a basic support here.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes in v6:
> - fix build warnning from kernel test robot
>
> Changes in v5:
> - read vendor area1 from standard IP reg and move hs400es
>   out of rockchip specified, as suggested.
> - improve as Johan suggested
> - remove Adrian's tag for new review
>
> Changes in v4:
> - add comments for disabling rx invert
> - add tag from Adrian
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 261 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 253 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 59d8d96..0687368 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -9,9 +9,11 @@
>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/sizes.h>
>
>  #include "sdhci-pltfm.h"
> @@ -21,11 +23,52 @@
>  /* DWCMSHC specific Mode Select value */
>  #define DWCMSHC_CTRL_HS400             0x7
>
> +/* DWC IP vendor area 1 pointer */
> +#define DWCMSHC_P_VENDOR_AREA1         0xe8
> +#define DWCMSHC_AREA1_MASK             GENMASK(11, 0)
> +/* Offset inside the  vendor area 1 */
> +#define DWCMSHC_HOST_CTRL3             0x8
> +#define DWCMSHC_EMMC_CONTROL           0x2c
> +#define DWCMSHC_ENHANCED_STROBE                BIT(8)
> +#define DWCMSHC_EMMC_ATCTRL            0x40
> +
> +/* Rockchip specific Registers */
> +#define DWCMSHC_EMMC_DLL_CTRL          0x800
> +#define DWCMSHC_EMMC_DLL_RXCLK         0x804
> +#define DWCMSHC_EMMC_DLL_TXCLK         0x808
> +#define DWCMSHC_EMMC_DLL_STRBIN                0x80c
> +#define DLL_STRBIN_TAPNUM_FROM_SW      BIT(24)
> +#define DWCMSHC_EMMC_DLL_STATUS0       0x840
> +#define DWCMSHC_EMMC_DLL_START         BIT(0)
> +#define DWCMSHC_EMMC_DLL_LOCKED                BIT(8)
> +#define DWCMSHC_EMMC_DLL_TIMEOUT       BIT(9)
> +#define DWCMSHC_EMMC_DLL_RXCLK_SRCSEL  29
> +#define DWCMSHC_EMMC_DLL_START_POINT   16
> +#define DWCMSHC_EMMC_DLL_INC           8
> +#define DWCMSHC_EMMC_DLL_DLYENA                BIT(27)
> +#define DLL_TXCLK_TAPNUM_DEFAULT       0x8
> +#define DLL_STRBIN_TAPNUM_DEFAULT      0x8
> +#define DLL_TXCLK_TAPNUM_FROM_SW       BIT(24)
> +#define DLL_RXCLK_NO_INVERTER          1
> +#define DLL_RXCLK_INVERTER             0
> +#define DLL_LOCK_WO_TMOUT(x) \
> +       ((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
> +       (((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
> +#define RK3568_MAX_CLKS 3
> +
>  #define BOUNDARY_OK(addr, len) \
>         ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>
> +struct rk3568_priv {
> +       /* Rockchip specified optional clocks */
> +       struct clk_bulk_data rockchip_clks[RK3568_MAX_CLKS];
> +       u8 txclk_tapnum;
> +};
> +
>  struct dwcmshc_priv {
>         struct clk      *bus_clk;
> +       int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA reg */
> +       void *priv; /* pointer to SoC private stuff */
>  };
>
>  /*
> @@ -100,6 +143,107 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
>         sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>  }
>
> +static void dwcmshc_hs400_enhanced_strobe(struct mmc_host *mmc,
> +                                         struct mmc_ios *ios)
> +{
> +       u32 vendor;
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       int reg = priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL;
> +
> +       vendor = sdhci_readl(host, reg);
> +       if (ios->enhanced_strobe)
> +               vendor |= DWCMSHC_ENHANCED_STROBE;
> +       else
> +               vendor &= ~DWCMSHC_ENHANCED_STROBE;
> +
> +       sdhci_writel(host, vendor, reg);
> +}
> +
> +static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +       struct rk3568_priv *priv = dwc_priv->priv;
> +       u8 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
> +       u32 extra, reg;
> +       int err;
> +
> +       host->mmc->actual_clock = 0;
> +
> +       /*
> +        * DO NOT TOUCH THIS SETTING. RX clk inverter unit is enabled
> +        * by default, but it shouldn't be enabled. We should anyway
> +        * disable it before issuing any cmds.
> +        */
> +       extra = DWCMSHC_EMMC_DLL_DLYENA |
> +               DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
> +
> +       if (clock == 0)
> +               return;
> +
> +       /* Rockchip platform only support 375KHz for identify mode */
> +       if (clock <= 400000)
> +               clock = 375000;
> +
> +       err = clk_set_rate(pltfm_host->clk, clock);
> +       if (err)
> +               dev_err(mmc_dev(host->mmc), "fail to set clock %d", clock);
> +
> +       sdhci_set_clock(host, clock);
> +
> +       /* Disable cmd conflict check */
> +       reg = dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3;
> +       extra = sdhci_readl(host, reg);
> +       extra &= ~BIT(0);
> +       sdhci_writel(host, extra, reg);
> +
> +       if (clock <= 400000) {
> +               /* Disable DLL to reset sample clock */
> +               sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
> +               return;
> +       }
> +
> +       /* Reset DLL */
> +       sdhci_writel(host, BIT(1), DWCMSHC_EMMC_DLL_CTRL);
> +       udelay(1);
> +       sdhci_writel(host, 0x0, DWCMSHC_EMMC_DLL_CTRL);
> +
> +       /* Init DLL settings */
> +       extra = 0x5 << DWCMSHC_EMMC_DLL_START_POINT |
> +               0x2 << DWCMSHC_EMMC_DLL_INC |
> +               DWCMSHC_EMMC_DLL_START;
> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_CTRL);
> +       err = readl_poll_timeout(host->ioaddr + DWCMSHC_EMMC_DLL_STATUS0,
> +                                extra, DLL_LOCK_WO_TMOUT(extra), 1,
> +                                500 * USEC_PER_MSEC);
> +       if (err) {
> +               dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
> +               return;
> +       }
> +
> +       extra = 0x1 << 16 | /* tune clock stop en */
> +               0x2 << 17 | /* pre-change delay */
> +               0x3 << 19;  /* post-change delay */
> +       sdhci_writel(host, extra, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +
> +       if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
> +           host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
> +               txclk_tapnum = priv->txclk_tapnum;
> +
> +       extra = DWCMSHC_EMMC_DLL_DLYENA |
> +               DLL_TXCLK_TAPNUM_FROM_SW |
> +               txclk_tapnum;
> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_TXCLK);
> +
> +       extra = DWCMSHC_EMMC_DLL_DLYENA |
> +               DLL_STRBIN_TAPNUM_DEFAULT |
> +               DLL_STRBIN_TAPNUM_FROM_SW;
> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>         .set_clock              = sdhci_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
> @@ -109,21 +253,93 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>         .adma_write_desc        = dwcmshc_adma_write_desc,
>  };
>
> +static const struct sdhci_ops sdhci_dwcmshc_rk3568_ops = {
> +       .set_clock              = dwcmshc_rk3568_set_clock,
> +       .set_bus_width          = sdhci_set_bus_width,
> +       .set_uhs_signaling      = dwcmshc_set_uhs_signaling,
> +       .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
> +       .reset                  = sdhci_reset,
> +       .adma_write_desc        = dwcmshc_adma_write_desc,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>         .ops = &sdhci_dwcmshc_ops,
>         .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>         .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
> +       .ops = &sdhci_dwcmshc_rk3568_ops,
> +       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +                 SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +};
> +
> +static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +{
> +       int err;
> +       struct rk3568_priv *priv = dwc_priv->priv;
> +
> +       priv->rockchip_clks[0].id = "axi";
> +       priv->rockchip_clks[1].id = "block";
> +       priv->rockchip_clks[2].id = "timer";
> +       err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), RK3568_MAX_CLKS,
> +                                        priv->rockchip_clks);
> +       if (err) {
> +               dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
> +               return err;
> +       }
> +
> +       err = clk_bulk_prepare_enable(RK3568_MAX_CLKS, priv->rockchip_clks);
> +       if (err) {
> +               dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
> +               return err;
> +       }
> +
> +       if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
> +                               &priv->txclk_tapnum))
> +               priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
> +
> +       /* Disable cmd conflict check */
> +       sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
> +       /* Reset previous settings */
> +       sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
> +       sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> +       {
> +               .compatible = "rockchip,rk3568-dwcmshc",
> +               .data = &sdhci_dwcmshc_rk3568_pdata,
> +       },
> +       {
> +               .compatible = "snps,dwcmshc-sdhci",
> +               .data = &sdhci_dwcmshc_pdata,
> +       },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> +
>  static int dwcmshc_probe(struct platform_device *pdev)
>  {
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_host *host;
>         struct dwcmshc_priv *priv;
> +       struct rk3568_priv *rk_priv = NULL;
> +       const struct sdhci_pltfm_data *pltfm_data;
>         int err;
>         u32 extra;
>
> -       host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> +       pltfm_data = of_device_get_match_data(&pdev->dev);
> +       if (!pltfm_data) {
> +               dev_err(&pdev->dev, "Error: No device match data found\n");
> +               return -ENODEV;
> +       }
> +
> +       host = sdhci_pltfm_init(pdev, pltfm_data,
>                                 sizeof(struct dwcmshc_priv));
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
> @@ -159,7 +375,23 @@ static int dwcmshc_probe(struct platform_device *pdev)
>
>         sdhci_get_of_property(pdev);
>
> +       priv->vendor_specific_area1 =
> +               sdhci_readl(host, DWCMSHC_P_VENDOR_AREA1) & DWCMSHC_AREA1_MASK;
> +
>         host->mmc_host_ops.request = dwcmshc_request;
> +       host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
> +
> +       if (pltfm_data == &sdhci_dwcmshc_rk3568_pdata) {
> +               rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk3568_priv), GFP_KERNEL);
> +               if (!rk_priv)
> +                       goto err_clk;
> +
> +               priv->priv = rk_priv;
> +
> +               err = dwcmshc_rk3568_init(host, priv);
> +               if (err)
> +                       goto err_clk;
> +       }
>
>         err = sdhci_add_host(host);
>         if (err)
> @@ -170,6 +402,9 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_clk:
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_disable_unprepare(priv->bus_clk);
> +       if (rk_priv)
> +               clk_bulk_disable_unprepare(RK3568_MAX_CLKS,
> +                                          rk_priv->rockchip_clks);
>  free_pltfm:
>         sdhci_pltfm_free(pdev);
>         return err;
> @@ -180,12 +415,15 @@ static int dwcmshc_remove(struct platform_device *pdev)
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       struct rk3568_priv *rk_priv = priv->priv;
>
>         sdhci_remove_host(host, 0);
>
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_disable_unprepare(priv->bus_clk);
> -
> +       if (rk_priv)
> +               clk_bulk_disable_unprepare(RK3568_MAX_CLKS,
> +                                          rk_priv->rockchip_clks);
>         sdhci_pltfm_free(pdev);
>
>         return 0;
> @@ -197,6 +435,7 @@ static int dwcmshc_suspend(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       struct rk3568_priv *rk_priv = priv->priv;
>         int ret;
>
>         ret = sdhci_suspend_host(host);
> @@ -207,6 +446,10 @@ static int dwcmshc_suspend(struct device *dev)
>         if (!IS_ERR(priv->bus_clk))
>                 clk_disable_unprepare(priv->bus_clk);
>
> +       if (rk_priv)
> +               clk_bulk_disable_unprepare(RK3568_MAX_CLKS,
> +                                          rk_priv->rockchip_clks);
> +
>         return ret;
>  }
>
> @@ -215,6 +458,7 @@ static int dwcmshc_resume(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       struct rk3568_priv *rk_priv = priv->priv;
>         int ret;
>
>         ret = clk_prepare_enable(pltfm_host->clk);
> @@ -227,18 +471,19 @@ static int dwcmshc_resume(struct device *dev)
>                         return ret;
>         }
>
> +       if (rk_priv) {
> +               ret = clk_bulk_prepare_enable(RK3568_MAX_CLKS,
> +                                             rk_priv->rockchip_clks);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         return sdhci_resume_host(host);
>  }
>  #endif
>
>  static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
>
> -static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> -       { .compatible = "snps,dwcmshc-sdhci" },
> -       {}
> -};
> -MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> -
>  static struct platform_driver sdhci_dwcmshc_driver = {
>         .driver = {
>                 .name   = "sdhci-dwcmshc",
> --
> 2.7.4
>
>
>
