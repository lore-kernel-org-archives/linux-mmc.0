Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121D8C433E1
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D965922B40
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="matpPN0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgHEGfO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgHEGfN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 02:35:13 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DC1C06174A
        for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2020 23:35:13 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id u15so2885952uau.10
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2020 23:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4ywlhldW4kDh3ZXxXvvyOrk6REe2o9rXP8i4tyEpJw=;
        b=matpPN0TvrSyWoHIgom7iF9rqu/oVnIrSLCgFiaUjeB4QnF3CuXrNVs1WaP9ZsbU7q
         kh1mpN/x8nla/KPuWLFlYe7sjlT7wS5h03142IlJ4Cz539vrWRTT9rEqiGaRfqMGXXsG
         HW7xmUrlFdn5z5ZLV8zQYJpeIbd3mh7Z6U9Nsi6EPHyhpyHnPw1Q6qSrtrZkPV5IuZiA
         faYkJGRUa0yHV+qvxuEU6demhT4BBfxbZF1Tv8jiDbr6SSHxyetXdBbGiMHVQlNcaWma
         +DOFoLmiiWgtzUfUWFZznjDRyelYyxEIh8H//LI443lVOd4ya9v8D+4N8luP1fl2YfWa
         gwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4ywlhldW4kDh3ZXxXvvyOrk6REe2o9rXP8i4tyEpJw=;
        b=rEQCd1ucjl0147tYAstk9gQPNs6/a4eZ/euj+kVmRIZe+FD5Ojlm34uqWllzEEeM8y
         chWOfdF0rlx7wd2Nvnfl1EawnH92lZLmybVBASniiuRp+bJO35BJXkmksXK2DMJMy7rT
         jZtzk/8ITpc+ROM0nga+0ibMhTMAbnjIm3CqDhjaAK+wPx46oMHM4uQJsyRoMX0jGS7h
         WQmjM64cw0/LZjbUpiLSPwsH74sPt+n0MWunBa4RK3RMhzY47ptpNXEMt/TgzuNNdEjs
         wGxKWZ8x/GPJkN3O8BwI0iK7KWLP9fntIqGdIxLADTX2jKHnNzZW4rXGzae0UPMqT22d
         5HIQ==
X-Gm-Message-State: AOAM532nb8O/U3T21AQXuFSaL/5eMX28yxl2Mo6frPPUf/xaFl3g0roc
        eHZ61V9LDWgO+byJIBKFKt0xjpKiNHEKXvr2RZN83g==
X-Google-Smtp-Source: ABdhPJyx6e35SmLJtM5ClLBDxQA/t39AsV37R+NXabvQCL/RW8H6CMd+zG7xtjMNPM7TGUpCowamWd8FxvX3bVwAjS0=
X-Received: by 2002:ab0:3114:: with SMTP id e20mr1041212ual.104.1596609312762;
 Tue, 04 Aug 2020 23:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200721012700.8564-1-shirley.her@bayhubtech.com>
In-Reply-To: <20200721012700.8564-1-shirley.her@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 08:34:35 +0200
Message-ID: <CAPDyKFobxS13-=xZeqrdm-7+CX3Cfd4SkL0H5fe2sKg1yMQFiA@mail.gmail.com>
Subject: Re: [PATCH V1 2/2] mmc: sdhci-pci-o2micro: Add HW tuning for SDR104 mode
To:     shirley her <shirley.her@bayhubtech.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Jul 2020 at 03:29, shirley her <shirley.her@bayhubtech.com> wrote:
>
> Add HW tuning support for SD host controller in SDR104 mode
>
> Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>


Applied for next (a while ago), thanks!
Kind regards
Uffe



> ---
> Change in V1:
> 1. Add HW tuning for SDR104 mode instead of SW tuning
> 2. Change clock base to 208Mhz in SDR104 mode
> 3. Add CMD and DATA line reset after HW tuning command
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 33 ++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index ed3c605fcf0c..fa76748d8929 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -196,7 +196,7 @@ static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
>  {
>         int i;
>
> -       sdhci_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
> +       sdhci_send_tuning(host, opcode);
>
>         for (i = 0; i < 150; i++) {
>                 u16 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> @@ -305,10 +305,12 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          * This handler only implements the eMMC tuning that is specific to
>          * this controller.  Fall back to the standard method for other TIMING.
>          */
> -       if (host->timing != MMC_TIMING_MMC_HS200)
> +       if ((host->timing != MMC_TIMING_MMC_HS200) &&
> +               (host->timing != MMC_TIMING_UHS_SDR104))
>                 return sdhci_execute_tuning(mmc, opcode);
>
> -       if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
> +       if (WARN_ON((opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
> +                       (opcode != MMC_SEND_TUNING_BLOCK)))
>                 return -EINVAL;
>         /*
>          * Judge the tuning reason, whether caused by dll shift
> @@ -342,6 +344,9 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 sdhci_set_bus_width(host, current_bus_width);
>         }
>
> +       sdhci_reset(host, SDHCI_RESET_CMD);
> +       sdhci_reset(host, SDHCI_RESET_DATA);
> +
>         host->flags &= ~SDHCI_HS400_TUNING;
>         return 0;
>  }
> @@ -369,7 +374,6 @@ static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
>         scratch_32 |= O2_SD_LED_ENABLE;
>         pci_write_config_dword(chip->pdev,
>                                O2_SD_TEST_REG, scratch_32);
> -
>  }
>
>  static void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
> @@ -497,6 +501,10 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>  static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         u16 clk;
> +       u8 scratch;
> +       u32 scratch_32;
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       struct sdhci_pci_chip *chip = slot->chip;
>
>         host->mmc->actual_clock = 0;
>
> @@ -505,6 +513,23 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (clock == 0)
>                 return;
>
> +       if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
> +               pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> +
> +               scratch &= 0x7f;
> +               pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> +
> +               pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
> +
> +               if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
> +                       o2_pci_set_baseclk(chip, 0x2c280000);
> +
> +               pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> +
> +               scratch |= 0x80;
> +               pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> +       }
> +
>         clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>         sdhci_o2_enable_clk(host, clk);
>  }
> --
> 2.25.1
>
