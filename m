Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0962EC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Dec 2021 16:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhL1Q6Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbhL1Q6Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2021 11:58:24 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4382FC06173E
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:58:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bq20so42618237lfb.4
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ocARWT4oqNhZKpVx6f/xh0VoxCv24OuDvrijA8EBTA=;
        b=VBTV5LqaPYl1k5iDFyA6c0KpmmhuNQPJoL6PnlhBL7QrARoidpUjaifp72M+4KHObF
         2gifCx6hkSgmD8FG0+MKogQrD9bussrEZ8Mgttc7xEyhYf8gnOW48amUAkMQ4itc6Rsd
         BGvSX/hOieR8rGdUZ39i+rzYcmxxbViFczAGCiREKR5YMmyN1+crhLlq7iYPjmguQrtG
         BAr0O9qZVsjPb5ipGGr8CuHUVd8FtwqL8XuUGV/YRkLFcU0K+Dwc5X1ezphuMtkKBMaW
         6oiAautz/4ll68CN8L1+ctDmkqcP26Rixn4QC0ByPOZP9bKP7YDsf/TTgscIe9kTzg09
         QB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ocARWT4oqNhZKpVx6f/xh0VoxCv24OuDvrijA8EBTA=;
        b=aTBd/oEwdsPRPjJsWS1dZF8TtRrfK9sx3OaO2STh62SVnTj7GCc64DfbFiP1KumWUj
         HbO7QofrPQeGNrPiV8cqRellLEaorHAhJ7tJ5OhyMGc/EJQMa8U8/mgn+jDT/kKVLd/x
         ZEdeANEq2e15WI3yvgiMcLyARYvpMmU5ARUfr8a4seuHO58rR8+F84HCZbqxJBdYsAog
         stW4dSQ/KROnNXRKS41RfMGH5uI4pQSMgSn3STLfqe+9nSnM2zR+JOJusFOy8fASsOgl
         NBnUQbHsv5gxTQu4xMagHHswgMB6Eu0ATOysQ2TLw3u2DEWlhndz/ghCA5itigL5fQWf
         eEDg==
X-Gm-Message-State: AOAM530dhplAWZnYALp6+C8KB2gLWdgbInRtpMCYFOacbOaaUgdBw40i
        oB7+bIgTvaNSwI0BxI9B8NYIezRk8XT7PahIWTw0kWI+yh5lOw==
X-Google-Smtp-Source: ABdhPJwFeD1HDvawMro/TqLokgf5wiij8lj49YA+3lOQdVc9NDZFb+RY2Chr2xVJdt3kQId2jaZ5F7LlvouW67/k5Wo=
X-Received: by 2002:a05:6512:310e:: with SMTP id n14mr19690823lfb.167.1640710702461;
 Tue, 28 Dec 2021 08:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20211221040940.484-1-fred.ai@bayhubtech.com>
In-Reply-To: <20211221040940.484-1-fred.ai@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:57:46 +0100
Message-ID: <CAPDyKFrg150TLjtV0O8aO1Jjp_1U3M0wsB12eXmR_B+uRvFgbA@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] mmc:sdhci-pci-o2micro:Improve card input timing at
 SDR104/HS200 mode
To:     fred <fred.ai@bayhubtech.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Dec 2021 at 05:09, fred <fred.ai@bayhubtech.com> wrote:
>
> From: Fred Ai <fred.ai@bayhubtech.com>
>
> Card input timing is margin, need to adjust the hold timing of card input.
>
> Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Change in V4:
> 1.Select suit DLL phase's output clock as SD interface clock at SDR104/HS200 mode.
> 2.Deselect DLL output phase as SD interface clock before next card initialization.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 57 +++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index f045c1ee4667..56e9f93999c4 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -12,6 +12,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/delay.h>
>  #include <linux/iopoll.h>
> +#include <linux/bitfield.h>
>
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
> @@ -43,12 +44,16 @@
>  #define O2_SD_CAP_REG0         0x334
>  #define O2_SD_UHS1_CAP_SETTING 0x33C
>  #define O2_SD_DELAY_CTRL       0x350
> +#define O2_SD_OUTPUT_CLK_SOURCE_SWITCH 0x354
>  #define O2_SD_UHS2_L1_CTRL     0x35C
>  #define O2_SD_FUNC_REG3                0x3E0
>  #define O2_SD_FUNC_REG4                0x3E4
>  #define O2_SD_LED_ENABLE       BIT(6)
>  #define O2_SD_FREG0_LEDOFF     BIT(13)
> +#define O2_SD_SEL_DLL          BIT(16)
>  #define O2_SD_FREG4_ENABLE_CLK_SET     BIT(22)
> +#define O2_SD_PHASE_MASK       GENMASK(23, 20)
> +#define O2_SD_FIX_PHASE                FIELD_PREP(O2_SD_PHASE_MASK, 0x9)
>
>  #define O2_SD_VENDOR_SETTING   0x110
>  #define O2_SD_VENDOR_SETTING2  0x1C8
> @@ -301,9 +306,13 @@ static int sdhci_o2_dll_recovery(struct sdhci_host *host)
>  static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       struct sdhci_pci_chip *chip = slot->chip;
>         int current_bus_width = 0;
>         u32 scratch32 = 0;
>         u16 scratch = 0;
> +       u8  scratch_8 = 0;
> +       u32 reg_val;
>
>         /*
>          * This handler only implements the eMMC tuning that is specific to
> @@ -322,6 +331,32 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         scratch |= O2_SD_PWR_FORCE_L0;
>         sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
>
> +       /* Stop clk */
> +       reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       reg_val &= ~SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
> +
> +       /* UnLock WP */
> +       pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +       scratch_8 &= 0x7f;
> +       pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +
> +       /* Set pcr 0x354[16] to choose dll clock, and set the default phase */
> +       pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
> +       reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
> +       reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
> +       pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
> +
> +       /* Lock WP */
> +       pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +       scratch_8 |= 0x80;
> +       pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +
> +       /* Start clk */
> +       reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       reg_val |= SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
> +
>         /* wait DLL lock, timeout value 5ms */
>         if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
>                 scratch32, (scratch32 & O2_DLL_LOCK_STATUS), 1, 5000))
> @@ -533,22 +568,26 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (clock == 0)
>                 return;
>
> -       if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
> -               pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> -
> -               scratch &= 0x7f;
> -               pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> +       /* UnLock WP */
> +       pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> +       scratch &= 0x7f;
> +       pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>
> +       if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
>                 pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
>
>                 if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
>                         o2_pci_set_baseclk(chip, 0x2c280000);
> +       }
>
> -               pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> +       pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
> +       scratch_32 &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
> +       pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
>
> -               scratch |= 0x80;
> -               pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> -       }
> +       /* Lock WP */
> +       pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> +       scratch |= 0x80;
> +       pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>
>         clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>         sdhci_o2_enable_clk(host, clk);
> --
> 2.32.0
>
