Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A262EC433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7649722D03
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3V8rPYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHEGeR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEGeQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 02:34:16 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20260C061756
        for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2020 23:34:16 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id u15so2885454uau.10
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2020 23:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48RB7EHgoiQleD/pQuLV1J7hsacJfpBptGUuAWwcbs8=;
        b=B3V8rPYqR1X5GmMPhKullnNQMeoNv4O2aWsCc4hy0qDTE+AFPd0d/takEIfe9mUB8N
         Xuy0SLylmV5K51ZJqsQVACfYmjHhoipS5TKh5Tpm3tbXH2rPOtdCL8kVKlhCyfhldMhi
         01mpQyRUIv1iDt7zGxppNnVv1TxLO7V9nIvV39E9ejNl06lj2NYfKyzHIJy303QTie38
         L2e558f94ZZS/RclCoXhaKX0iINW9U8kScaSpNXAw5h6QICCsbbwPDx4VV5TjfwacYDS
         FVECR1yGlzaq0IkAyVFoVUbsd89JlQYUCChtIbZhPTr8oqx+c/eseOGnrN6/0PkG/zRo
         kZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48RB7EHgoiQleD/pQuLV1J7hsacJfpBptGUuAWwcbs8=;
        b=TDTN7GvEYSpr1v3bBQhLPXIE4XSLjAh59JbTtuptzJMSG/2oO88zNdfX9GuuXkIigo
         PTbYqPlR0fDeLplE2gJAeFTcvyVPtxfjpiV3Fzgs2IURzKaIKI60XZS39W8hEtBqGvFQ
         q3M/mYmzkAVTQilOFjsBduBp1ZB3d36d7d0CpZ6VQ/eEmngxjuMLxqF7AdhkGvc3yiw2
         BsM7QuCP8DJb8WVBabqX+aR1PsBtEyMmGVYjyrV0PxWQdW0LQNBibkAqD11zOLPjP3Rp
         ozcH6w9F1/n8u3vls3kS8bxHZfGMOsXZ0haeQL0iR/0FvHlqWhMX6XuntVUtlOpBit0U
         zVbQ==
X-Gm-Message-State: AOAM532gz9BR4vr37YN7OkUE4XgmdG2wP2scqVS1usPCo2OWVDa8dx4k
        pDS0Tmaqc4c7oNLVNQAl+Arwv9Spxmul223noXXOaQ==
X-Google-Smtp-Source: ABdhPJxTkDLFM38hfs5s92dQJSWgH7DPegQVNI+vhRfHvfv5xab0rdFpRdaqBGmVP4Cc6LayaOhJ0C00OAiOyA9vHg0=
X-Received: by 2002:ab0:2ea2:: with SMTP id y2mr996686uay.15.1596609255163;
 Tue, 04 Aug 2020 23:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200717033350.13006-1-benchuanggli@gmail.com>
In-Reply-To: <20200717033350.13006-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 08:33:38 +0200
Message-ID: <CAPDyKFpp54tNRiQ+or-3o9dUJ=CB+PpsRc=fkxc10dAUY-x_SQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and
 enable SSC for GL975x
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Jul 2020 at 05:33, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Set SDR104's clock to 205MHz and enable SSC for GL9750 and GL9755
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next (a while ago), thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 220 ++++++++++++++++++++++++++++++-
>  1 file changed, 218 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index ca0166d9bf82..5da2b06d84ae 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -31,10 +31,18 @@
>  #define   SDHCI_GLI_9750_ALL_RST      (BIT(24)|BIT(25)|BIT(28)|BIT(30))
>
>  #define SDHCI_GLI_9750_PLL           0x864
> +#define   SDHCI_GLI_9750_PLL_LDIV       GENMASK(9, 0)
> +#define   SDHCI_GLI_9750_PLL_PDIV       GENMASK(14, 12)
> +#define   SDHCI_GLI_9750_PLL_DIR        BIT(15)
>  #define   SDHCI_GLI_9750_PLL_TX2_INV    BIT(23)
>  #define   SDHCI_GLI_9750_PLL_TX2_DLY    GENMASK(22, 20)
>  #define   GLI_9750_PLL_TX2_INV_VALUE    0x1
>  #define   GLI_9750_PLL_TX2_DLY_VALUE    0x0
> +#define   SDHCI_GLI_9750_PLLSSC_STEP    GENMASK(28, 24)
> +#define   SDHCI_GLI_9750_PLLSSC_EN      BIT(31)
> +
> +#define SDHCI_GLI_9750_PLLSSC        0x86C
> +#define   SDHCI_GLI_9750_PLLSSC_PPM    GENMASK(31, 16)
>
>  #define SDHCI_GLI_9750_SW_CTRL      0x874
>  #define   SDHCI_GLI_9750_SW_CTRL_4    GENMASK(7, 6)
> @@ -76,6 +84,21 @@
>  #define PCIE_GLI_9763E_SCR      0x8E0
>  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
>
> +#define PCI_GLI_9755_WT       0x800
> +#define   PCI_GLI_9755_WT_EN    BIT(0)
> +#define   GLI_9755_WT_EN_ON     0x1
> +#define   GLI_9755_WT_EN_OFF    0x0
> +
> +#define PCI_GLI_9755_PLL            0x64
> +#define   PCI_GLI_9755_PLL_LDIV       GENMASK(9, 0)
> +#define   PCI_GLI_9755_PLL_PDIV       GENMASK(14, 12)
> +#define   PCI_GLI_9755_PLL_DIR        BIT(15)
> +#define   PCI_GLI_9755_PLLSSC_STEP    GENMASK(28, 24)
> +#define   PCI_GLI_9755_PLLSSC_EN      BIT(31)
> +
> +#define PCI_GLI_9755_PLLSSC        0x68
> +#define   PCI_GLI_9755_PLLSSC_PPM    GENMASK(15, 0)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>
>  /* Genesys Logic chipset */
> @@ -280,6 +303,84 @@ static int gl9750_execute_tuning(struct sdhci_host *host, u32 opcode)
>         return 0;
>  }
>
> +static void gl9750_disable_ssc_pll(struct sdhci_host *host)
> +{
> +       u32 pll;
> +
> +       gl9750_wt_on(host);
> +       pll = sdhci_readl(host, SDHCI_GLI_9750_PLL);
> +       pll &= ~(SDHCI_GLI_9750_PLL_DIR | SDHCI_GLI_9750_PLLSSC_EN);
> +       sdhci_writel(host, pll, SDHCI_GLI_9750_PLL);
> +       gl9750_wt_off(host);
> +}
> +
> +static void gl9750_set_pll(struct sdhci_host *host, u8 dir, u16 ldiv, u8 pdiv)
> +{
> +       u32 pll;
> +
> +       gl9750_wt_on(host);
> +       pll = sdhci_readl(host, SDHCI_GLI_9750_PLL);
> +       pll &= ~(SDHCI_GLI_9750_PLL_LDIV |
> +                SDHCI_GLI_9750_PLL_PDIV |
> +                SDHCI_GLI_9750_PLL_DIR);
> +       pll |= FIELD_PREP(SDHCI_GLI_9750_PLL_LDIV, ldiv) |
> +              FIELD_PREP(SDHCI_GLI_9750_PLL_PDIV, pdiv) |
> +              FIELD_PREP(SDHCI_GLI_9750_PLL_DIR, dir);
> +       sdhci_writel(host, pll, SDHCI_GLI_9750_PLL);
> +       gl9750_wt_off(host);
> +
> +       /* wait for pll stable */
> +       mdelay(1);
> +}
> +
> +static void gl9750_set_ssc(struct sdhci_host *host, u8 enable, u8 step, u16 ppm)
> +{
> +       u32 pll;
> +       u32 ssc;
> +
> +       gl9750_wt_on(host);
> +       pll = sdhci_readl(host, SDHCI_GLI_9750_PLL);
> +       ssc = sdhci_readl(host, SDHCI_GLI_9750_PLLSSC);
> +       pll &= ~(SDHCI_GLI_9750_PLLSSC_STEP |
> +                SDHCI_GLI_9750_PLLSSC_EN);
> +       ssc &= ~SDHCI_GLI_9750_PLLSSC_PPM;
> +       pll |= FIELD_PREP(SDHCI_GLI_9750_PLLSSC_STEP, step) |
> +              FIELD_PREP(SDHCI_GLI_9750_PLLSSC_EN, enable);
> +       ssc |= FIELD_PREP(SDHCI_GLI_9750_PLLSSC_PPM, ppm);
> +       sdhci_writel(host, ssc, SDHCI_GLI_9750_PLLSSC);
> +       sdhci_writel(host, pll, SDHCI_GLI_9750_PLL);
> +       gl9750_wt_off(host);
> +}
> +
> +static void gl9750_set_ssc_pll_205mhz(struct sdhci_host *host)
> +{
> +       /* set pll to 205MHz and enable ssc */
> +       gl9750_set_ssc(host, 0x1, 0x1F, 0xFFE7);
> +       gl9750_set_pll(host, 0x1, 0x246, 0x0);
> +}
> +
> +static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +       struct mmc_ios *ios = &host->mmc->ios;
> +       u16 clk;
> +
> +       host->mmc->actual_clock = 0;
> +
> +       gl9750_disable_ssc_pll(host);
> +       sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +       if (clock == 0)
> +               return;
> +
> +       clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> +       if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
> +               host->mmc->actual_clock = 205000000;
> +               gl9750_set_ssc_pll_205mhz(host);
> +       }
> +
> +       sdhci_enable_clk(host, clk);
> +}
> +
>  static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
>  {
>         int ret;
> @@ -295,6 +396,121 @@ static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
>         slot->host->irq = pci_irq_vector(slot->chip->pdev, 0);
>  }
>
> +static inline void gl9755_wt_on(struct pci_dev *pdev)
> +{
> +       u32 wt_value;
> +       u32 wt_enable;
> +
> +       pci_read_config_dword(pdev, PCI_GLI_9755_WT, &wt_value);
> +       wt_enable = FIELD_GET(PCI_GLI_9755_WT_EN, wt_value);
> +
> +       if (wt_enable == GLI_9755_WT_EN_ON)
> +               return;
> +
> +       wt_value &= ~PCI_GLI_9755_WT_EN;
> +       wt_value |= FIELD_PREP(PCI_GLI_9755_WT_EN, GLI_9755_WT_EN_ON);
> +
> +       pci_write_config_dword(pdev, PCI_GLI_9755_WT, wt_value);
> +}
> +
> +static inline void gl9755_wt_off(struct pci_dev *pdev)
> +{
> +       u32 wt_value;
> +       u32 wt_enable;
> +
> +       pci_read_config_dword(pdev, PCI_GLI_9755_WT, &wt_value);
> +       wt_enable = FIELD_GET(PCI_GLI_9755_WT_EN, wt_value);
> +
> +       if (wt_enable == GLI_9755_WT_EN_OFF)
> +               return;
> +
> +       wt_value &= ~PCI_GLI_9755_WT_EN;
> +       wt_value |= FIELD_PREP(PCI_GLI_9755_WT_EN, GLI_9755_WT_EN_OFF);
> +
> +       pci_write_config_dword(pdev, PCI_GLI_9755_WT, wt_value);
> +}
> +
> +static void gl9755_disable_ssc_pll(struct pci_dev *pdev)
> +{
> +       u32 pll;
> +
> +       gl9755_wt_on(pdev);
> +       pci_read_config_dword(pdev, PCI_GLI_9755_PLL, &pll);
> +       pll &= ~(PCI_GLI_9755_PLL_DIR | PCI_GLI_9755_PLLSSC_EN);
> +       pci_write_config_dword(pdev, PCI_GLI_9755_PLL, pll);
> +       gl9755_wt_off(pdev);
> +}
> +
> +static void gl9755_set_pll(struct pci_dev *pdev, u8 dir, u16 ldiv, u8 pdiv)
> +{
> +       u32 pll;
> +
> +       gl9755_wt_on(pdev);
> +       pci_read_config_dword(pdev, PCI_GLI_9755_PLL, &pll);
> +       pll &= ~(PCI_GLI_9755_PLL_LDIV |
> +                PCI_GLI_9755_PLL_PDIV |
> +                PCI_GLI_9755_PLL_DIR);
> +       pll |= FIELD_PREP(PCI_GLI_9755_PLL_LDIV, ldiv) |
> +              FIELD_PREP(PCI_GLI_9755_PLL_PDIV, pdiv) |
> +              FIELD_PREP(PCI_GLI_9755_PLL_DIR, dir);
> +       pci_write_config_dword(pdev, PCI_GLI_9755_PLL, pll);
> +       gl9755_wt_off(pdev);
> +
> +       /* wait for pll stable */
> +       mdelay(1);
> +}
> +
> +static void gl9755_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
> +{
> +       u32 pll;
> +       u32 ssc;
> +
> +       gl9755_wt_on(pdev);
> +       pci_read_config_dword(pdev, PCI_GLI_9755_PLL, &pll);
> +       pci_read_config_dword(pdev, PCI_GLI_9755_PLLSSC, &ssc);
> +       pll &= ~(PCI_GLI_9755_PLLSSC_STEP |
> +                PCI_GLI_9755_PLLSSC_EN);
> +       ssc &= ~PCI_GLI_9755_PLLSSC_PPM;
> +       pll |= FIELD_PREP(PCI_GLI_9755_PLLSSC_STEP, step) |
> +              FIELD_PREP(PCI_GLI_9755_PLLSSC_EN, enable);
> +       ssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_PPM, ppm);
> +       pci_write_config_dword(pdev, PCI_GLI_9755_PLLSSC, ssc);
> +       pci_write_config_dword(pdev, PCI_GLI_9755_PLL, pll);
> +       gl9755_wt_off(pdev);
> +}
> +
> +static void gl9755_set_ssc_pll_205mhz(struct pci_dev *pdev)
> +{
> +       /* set pll to 205MHz and enable ssc */
> +       gl9755_set_ssc(pdev, 0x1, 0x1F, 0xFFE7);
> +       gl9755_set_pll(pdev, 0x1, 0x246, 0x0);
> +}
> +
> +static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       struct mmc_ios *ios = &host->mmc->ios;
> +       struct pci_dev *pdev;
> +       u16 clk;
> +
> +       pdev = slot->chip->pdev;
> +       host->mmc->actual_clock = 0;
> +
> +       gl9755_disable_ssc_pll(pdev);
> +       sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +       if (clock == 0)
> +               return;
> +
> +       clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> +       if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
> +               host->mmc->actual_clock = 205000000;
> +               gl9755_set_ssc_pll_205mhz(pdev);
> +       }
> +
> +       sdhci_enable_clk(host, clk);
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_host *host = slot->host;
> @@ -440,7 +656,7 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  }
>
>  static const struct sdhci_ops sdhci_gl9755_ops = {
> -       .set_clock              = sdhci_set_clock,
> +       .set_clock              = sdhci_gl9755_set_clock,
>         .enable_dma             = sdhci_pci_enable_dma,
>         .set_bus_width          = sdhci_set_bus_width,
>         .reset                  = sdhci_reset,
> @@ -460,7 +676,7 @@ const struct sdhci_pci_fixes sdhci_gl9755 = {
>
>  static const struct sdhci_ops sdhci_gl9750_ops = {
>         .read_l                 = sdhci_gl9750_readl,
> -       .set_clock              = sdhci_set_clock,
> +       .set_clock              = sdhci_gl9750_set_clock,
>         .enable_dma             = sdhci_pci_enable_dma,
>         .set_bus_width          = sdhci_set_bus_width,
>         .reset                  = sdhci_gl9750_reset,
> --
> 2.27.0
>
