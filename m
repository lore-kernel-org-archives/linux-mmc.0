Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC10C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 26 May 2022 01:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbiEZBPC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 May 2022 21:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiEZBPA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2022 21:15:00 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A5D941A9
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 18:14:59 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-30026b1124bso1745117b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 18:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ykSFg+rutyYJCO+YMLtaxpz7VBcyFHX3grA/E8Rryw=;
        b=BQGEQTMz7hzSyQ6Mk2ZsgEnTb6jFpIJL2g0eWh7cF1ZfTGWE8gkR7ueG3rk+TqhgB7
         Je1PYt4wACgU0Sflal/FRQGuwlnP6CAMgyVefCQU0GQgKTL7hEp+jWBc1AOpbHnx+MLe
         hL5yrCUX/GgXneF3IsxLy4l7Ok3QY5kJnYC6V7jeHGQXgsdqHeILoTWzJIg3RRZ/6+F6
         zXRDmCnIl2A/5GjPkFF13jh1CftostZEohKn8KMBDJj+nNc/aEXsCpFsk/qhgDsaZgNG
         kHdP4ZOGfDM4VhQ49bu1CAL1vO38db15qtPN/0hZ/pRPhQIpTB1Ugwt5VoFLA52S6XE4
         KCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ykSFg+rutyYJCO+YMLtaxpz7VBcyFHX3grA/E8Rryw=;
        b=glh9U9xVRYW4EaWZGpEvRH+9R6zLVJ720R2k/nb9+o7rBCAMXK+V4qOGHohDP1ZupF
         E5m/JCVTZXjV9MtlWWTcg4k3LoCgaydg83CcT/vl22oUF+Ksi2u25Gc4OpOaBi+H1/Q3
         ai56TCgcygY9Inqhu76BqC37wBUIrXgH5KHRU/fUhYkTED1ZOYuqReaGDLEmnhkjTHwm
         DAwAH2xri/i8dGJFZ0gDqWYP7Koh77puzQVQh0mL9K9yC0SIrrovbLAxX/LUQu1M9cc1
         7fuQV+ZzlP98XRduDh5yX2LD58yl8cRzqR17R9A4SZb8hGWj7UkHd2d9EYyL9eTtoRBx
         r59w==
X-Gm-Message-State: AOAM531JVsjM/IoHfHS38iCV9djuDXlS5AOi3od6oe7jd14kYoFM0wDc
        JY+CDIRIiHiWRXTFWi9DiMpP8b0U6mX4ocUOBJV+NkdFdxg4zw==
X-Google-Smtp-Source: ABdhPJxI+Tl2Rr46rwK68QIzHeo+W3x3nzLH1QrdtXDR0SonDl0QGSoyoGRZArqVAYhti1aj7Pl6ZORyZwZf06vUfzA=
X-Received: by 2002:a05:690c:9e:b0:2e9:b625:1be2 with SMTP id
 be30-20020a05690c009e00b002e9b6251be2mr37177660ywb.48.1653527698439; Wed, 25
 May 2022 18:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220525122754.6837-1-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20220525122754.6837-1-jasonlai.genesyslogic@gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Thu, 26 May 2022 09:14:47 +0800
Message-ID: <CACT4zj9F7J3NgFMK7sG1aL19Y12zrPejPuD2ZEhwKYf0oosEVQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Improve Random 4K Read Performance of GL9763E
To:     Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, SeanHY.chen@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, victor.shih@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Jason,

Please check your codebase because the patch removed the gl97[50|55]
ssc patches.

Thanks,
Ben

On Wed, May 25, 2022 at 11:48 PM Jason Lai
<jasonlai.genesyslogic@gmail.com> wrote:
>
> This patch is based on patch [1] and remove data transfer length
> checking.
>
> Due to flaws in hardware design, GL9763E takes long time to exit from L1
> state. The I/O performance will suffer severe impact if it often enter
> and exit L1 state.
>
> Unfortunately, entering and exiting L1 state is signal handshake in
> physical layer, software knows nothiong about it. The only way to stop
> entering L1 state is to disable hardware LPM negotiation on GL9763E.
>
> To improve read performance and take battery life into account, we reject
> L1 negotiation while executing MMC_READ_MULTIPLE_BLOCK command and enable L1
> negotiation again when receiving non-MMC_READ_MULTIPLE_BLOCK command.
>
> [1]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=510801&archive
> =both
>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 193 ++++++++++---------------------
>  1 file changed, 63 insertions(+), 130 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index d09728c37d03..0c5aac8047f8 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -13,7 +13,6 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
> -#include <linux/iopoll.h>
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
>  #include "cqhci.h"
> @@ -64,7 +63,6 @@
>  #define   GLI_9750_MISC_RX_INV_OFF       0x0
>  #define   GLI_9750_MISC_RX_INV_VALUE     GLI_9750_MISC_RX_INV_OFF
>  #define   GLI_9750_MISC_TX1_DLY_VALUE    0x5
> -#define   SDHCI_GLI_9750_MISC_SSC_OFF    BIT(26)
>
>  #define SDHCI_GLI_9750_TUNING_CONTROL            0x540
>  #define   SDHCI_GLI_9750_TUNING_CONTROL_EN          BIT(4)
> @@ -95,9 +93,12 @@
>  #define PCIE_GLI_9763E_SCR      0x8E0
>  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
>
> +#define PCIE_GLI_9763E_CFG       0x8A0
> +#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
> +
>  #define PCIE_GLI_9763E_CFG2      0x8A4
>  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> -#define   GLI_9763E_CFG2_L1DLY_MID 0x54
> +#define   GLI_9763E_CFG2_L1DLY_MID 0x54                // Set L1 entry delay time to 21us
>
>  #define PCIE_GLI_9763E_MMC_CTRL  0x960
>  #define   GLI_9763E_HS400_SLOW     BIT(3)
> @@ -139,11 +140,12 @@
>  #define PCI_GLI_9755_SerDes  0x70
>  #define PCI_GLI_9755_SCP_DIS   BIT(19)
>
> -#define PCI_GLI_9755_MISC          0x78
> -#define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
> -
>  #define GLI_MAX_TUNING_LOOP 40
>
> +struct gli_host {
> +       bool lpm_negotiation_enabled;
> +};
> +
>  /* Genesys Logic chipset */
>  static inline void gl9750_wt_on(struct sdhci_host *host)
>  {
> @@ -376,19 +378,6 @@ static void gl9750_set_pll(struct sdhci_host *host, u8 dir, u16 ldiv, u8 pdiv)
>         mdelay(1);
>  }
>
> -static bool gl9750_ssc_enable(struct sdhci_host *host)
> -{
> -       u32 misc;
> -       u8 off;
> -
> -       gl9750_wt_on(host);
> -       misc = sdhci_readl(host, SDHCI_GLI_9750_MISC);
> -       off = FIELD_GET(SDHCI_GLI_9750_MISC_SSC_OFF, misc);
> -       gl9750_wt_off(host);
> -
> -       return !off;
> -}
> -
>  static void gl9750_set_ssc(struct sdhci_host *host, u8 enable, u8 step, u16 ppm)
>  {
>         u32 pll;
> @@ -410,31 +399,11 @@ static void gl9750_set_ssc(struct sdhci_host *host, u8 enable, u8 step, u16 ppm)
>
>  static void gl9750_set_ssc_pll_205mhz(struct sdhci_host *host)
>  {
> -       bool enable = gl9750_ssc_enable(host);
> -
> -       /* set pll to 205MHz and ssc */
> -       gl9750_set_ssc(host, enable, 0xF, 0x5A1D);
> +       /* set pll to 205MHz and enable ssc */
> +       gl9750_set_ssc(host, 0x1, 0x1F, 0xFFE7);
>         gl9750_set_pll(host, 0x1, 0x246, 0x0);
>  }
>
> -static void gl9750_set_ssc_pll_100mhz(struct sdhci_host *host)
> -{
> -       bool enable = gl9750_ssc_enable(host);
> -
> -       /* set pll to 100MHz and ssc */
> -       gl9750_set_ssc(host, enable, 0xE, 0x51EC);
> -       gl9750_set_pll(host, 0x1, 0x244, 0x1);
> -}
> -
> -static void gl9750_set_ssc_pll_50mhz(struct sdhci_host *host)
> -{
> -       bool enable = gl9750_ssc_enable(host);
> -
> -       /* set pll to 50MHz and ssc */
> -       gl9750_set_ssc(host, enable, 0xE, 0x51EC);
> -       gl9750_set_pll(host, 0x1, 0x244, 0x3);
> -}
> -
>  static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct mmc_ios *ios = &host->mmc->ios;
> @@ -452,10 +421,6 @@ static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
>                 host->mmc->actual_clock = 205000000;
>                 gl9750_set_ssc_pll_205mhz(host);
> -       } else if (clock == 100000000) {
> -               gl9750_set_ssc_pll_100mhz(host);
> -       } else if (clock == 50000000) {
> -               gl9750_set_ssc_pll_50mhz(host);
>         }
>
>         sdhci_enable_clk(host, clk);
> @@ -556,19 +521,6 @@ static void gl9755_set_pll(struct pci_dev *pdev, u8 dir, u16 ldiv, u8 pdiv)
>         mdelay(1);
>  }
>
> -static bool gl9755_ssc_enable(struct pci_dev *pdev)
> -{
> -       u32 misc;
> -       u8 off;
> -
> -       gl9755_wt_on(pdev);
> -       pci_read_config_dword(pdev, PCI_GLI_9755_MISC, &misc);
> -       off = FIELD_GET(PCI_GLI_9755_MISC_SSC_OFF, misc);
> -       gl9755_wt_off(pdev);
> -
> -       return !off;
> -}
> -
>  static void gl9755_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
>  {
>         u32 pll;
> @@ -590,31 +542,11 @@ static void gl9755_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
>
>  static void gl9755_set_ssc_pll_205mhz(struct pci_dev *pdev)
>  {
> -       bool enable = gl9755_ssc_enable(pdev);
> -
> -       /* set pll to 205MHz and ssc */
> -       gl9755_set_ssc(pdev, enable, 0xF, 0x5A1D);
> +       /* set pll to 205MHz and enable ssc */
> +       gl9755_set_ssc(pdev, 0x1, 0x1F, 0xFFE7);
>         gl9755_set_pll(pdev, 0x1, 0x246, 0x0);
>  }
>
> -static void gl9755_set_ssc_pll_100mhz(struct pci_dev *pdev)
> -{
> -       bool enable = gl9755_ssc_enable(pdev);
> -
> -       /* set pll to 100MHz and ssc */
> -       gl9755_set_ssc(pdev, enable, 0xE, 0x51EC);
> -       gl9755_set_pll(pdev, 0x1, 0x244, 0x1);
> -}
> -
> -static void gl9755_set_ssc_pll_50mhz(struct pci_dev *pdev)
> -{
> -       bool enable = gl9755_ssc_enable(pdev);
> -
> -       /* set pll to 50MHz and ssc */
> -       gl9755_set_ssc(pdev, enable, 0xE, 0x51EC);
> -       gl9755_set_pll(pdev, 0x1, 0x244, 0x3);
> -}
> -
>  static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct sdhci_pci_slot *slot = sdhci_priv(host);
> @@ -635,10 +567,6 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
>                 host->mmc->actual_clock = 205000000;
>                 gl9755_set_ssc_pll_205mhz(pdev);
> -       } else if (clock == 100000000) {
> -               gl9755_set_ssc_pll_100mhz(pdev);
> -       } else if (clock == 50000000) {
> -               gl9755_set_ssc_pll_50mhz(pdev);
>         }
>
>         sdhci_enable_clk(host, clk);
> @@ -818,6 +746,53 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
>         sdhci_dumpregs(mmc_priv(mmc));
>  }
>
> +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
> +{
> +       struct pci_dev *pdev = slot->chip->pdev;
> +       u32 value;
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +       value &= ~GLI_9763E_VHS_REV;
> +       value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> +
> +       if (enable)
> +               value &= ~GLI_9763E_CFG_LPSN_DIS;
> +       else
> +               value |= GLI_9763E_CFG_LPSN_DIS;
> +
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +       value &= ~GLI_9763E_VHS_REV;
> +       value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +}
> +
> +static void gl9763e_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct mmc_command *cmd;
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       struct gli_host *gli_host = sdhci_pci_priv(slot);
> +
> +       cmd = mrq->cmd;
> +
> +       if (cmd && (cmd->opcode == MMC_READ_MULTIPLE_BLOCK) && gli_host->lpm_negotiation_enabled) {
> +               gl9763e_set_low_power_negotiation(slot, false);
> +               gli_host->lpm_negotiation_enabled = false;
> +       } else {
> +               if (gli_host->lpm_negotiation_enabled == false) {
> +                       gl9763e_set_low_power_negotiation(slot, true);
> +                       gli_host->lpm_negotiation_enabled = true;
> +               }
> +       }
> +
> +       sdhci_request(mmc, mrq);
> +}
> +
>  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
>  {
>         struct cqhci_host *cq_host = mmc->cqe_private;
> @@ -952,47 +927,6 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>  }
>
> -#ifdef CONFIG_PM
> -static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
> -{
> -       struct sdhci_pci_slot *slot = chip->slots[0];
> -       struct sdhci_host *host = slot->host;
> -       u16 clock;
> -
> -       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -       clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
> -       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> -
> -       return 0;
> -}
> -
> -static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
> -{
> -       struct sdhci_pci_slot *slot = chip->slots[0];
> -       struct sdhci_host *host = slot->host;
> -       u16 clock;
> -
> -       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -
> -       clock |= SDHCI_CLOCK_PLL_EN;
> -       clock &= ~SDHCI_CLOCK_INT_STABLE;
> -       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> -
> -       /* Wait max 150 ms */
> -       if (read_poll_timeout(sdhci_readw, clock, (clock & SDHCI_CLOCK_INT_STABLE),
> -                             1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
> -               pr_err("%s: PLL clock never stabilised.\n",
> -                      mmc_hostname(host->mmc));
> -               sdhci_dumpregs(host);
> -       }
> -
> -       clock |= SDHCI_CLOCK_CARD_EN;
> -       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> -
> -       return 0;
> -}
> -#endif
> -
>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  {
>         struct pci_dev *pdev = slot->chip->pdev;
> @@ -1016,6 +950,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>         gli_pcie_enable_msi(slot);
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                                         gl9763e_hs400_enhanced_strobe;
> +
> +       host->mmc_host_ops.request = gl9763e_request;
> +
>         gli_set_gl9763e(slot);
>         sdhci_enable_v4_mode(host);
>
> @@ -1102,11 +1039,7 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>  #ifdef CONFIG_PM_SLEEP
>         .resume         = sdhci_cqhci_gli_resume,
>         .suspend        = sdhci_cqhci_gli_suspend,
> -#endif
> -#ifdef CONFIG_PM
> -       .runtime_suspend = gl9763e_runtime_suspend,
> -       .runtime_resume  = gl9763e_runtime_resume,
> -       .allow_runtime_pm = true,
>  #endif
>         .add_host       = gl9763e_add_host,
> +       .priv_size      = sizeof(struct gli_host),
>  };
> --
> 2.36.1
>
