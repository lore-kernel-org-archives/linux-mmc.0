Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A787DC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 07:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8612075F
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 07:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Md/ReC+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgEOHJs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 03:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbgEOHJr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 03:09:47 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9DCC061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 00:09:47 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id b6so433257uak.6
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 00:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQJXdZars2FHytaa2yOBf/yqopDjJjCjC8o19wOgYMc=;
        b=Md/ReC+5LLYVOvswUxYBZdm50jIMagh7Aw/PpVajG7qRY1Xp1lpB4I7wwSwoMKfNoO
         5mH7K23IFnK1Eyty78QkeG2p4N6rOx7lM6/D/ypzo+CmxygUOJf/kE+kme4QXv7A3mEb
         EqRVIZSRcy85dyDjOktnjjQOC0BHzovAm/QdVkaimP6I+BNgb5B81rurto0Nc+5TZthy
         CbGU1/EgS/9uUOdXXiOygw69lBVP8UyTj7TLaLpI3TgHHXYElUIcsot+93+LeXQpjE78
         zwIlBbBuoxxXluq839Er0tHX/CCIYyhE3ezmiE+Bdfrj52iIQRarBgn7/HV5jvEaxf1+
         OTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQJXdZars2FHytaa2yOBf/yqopDjJjCjC8o19wOgYMc=;
        b=k2ykYg/dl5dV79XLabOokqGWsxtsVGMP7s6eVjWTLNVP5b4vDTopVZI+ZX6OPbTZYA
         IrmPx9Z0Lg+nRY9tobXM0l1Sno+PN6pDLEe5bnc2ocvnahDqblFFWJ9OW48F3F+ADzOH
         hPkDgim7Wh/PL0UfrcQ2LWYmJpkx9grOtk1dLLB+jSshF6kI1SF3D4BFyTYbBE/P6iP7
         VAV+O8rJPfHhHiafSesYh5ypJsGp7oCuX/dvITC55kA2y75shQjR1N/Ge/cxsnqoo1Oc
         g9yJ7lysjSQ6mFEsr5Dy/K5t4HuBV+IZ7xzj2GOgsne1n7WiQ6f/sut5TClMS3lAkV2F
         f6Cw==
X-Gm-Message-State: AOAM531LonpN9i2w6wnQxjRSewsjkGZ1y4189CzyoF/rs9VorboURIdZ
        M7lHo14jHd2HxWVm6q9xb3eo4SVx8xutJPEIAVYnAA==
X-Google-Smtp-Source: ABdhPJyj0xQXTIvEkTtYrCP0WxeJTTPFlN4BRz0PAtsY9nefInvQhLlPMslbWzeP+N7M3M4RpBJwHx7OTbGDE5gpr8w=
X-Received: by 2002:ab0:7293:: with SMTP id w19mr1704849uao.129.1589526586787;
 Fri, 15 May 2020 00:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200508064154.13473-1-benchuanggli@gmail.com>
In-Reply-To: <20200508064154.13473-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 May 2020 09:09:10 +0200
Message-ID: <CAPDyKFpKu_LnrZGBp=b11VRCPBLQXOJMtJRJvwuOqkyp=AHsjg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 8 May 2020 at 08:42, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> GL9763E supports High Speed SDR, High Speed DDR, HS200, HS400, Enhanced
> Strobe in HS400 mode, 1/4/8 bits data bus and 3.3/1.8V.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c |   1 +
>  drivers/mmc/host/sdhci-pci-gli.c  | 106 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h      |   2 +
>  3 files changed, 109 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index af736afb4b91..bb6802448b2f 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1745,6 +1745,7 @@ static const struct pci_device_id pci_ids[] = {
>         SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
>         SDHCI_PCI_DEVICE(GLI, 9750, gl9750),
>         SDHCI_PCI_DEVICE(GLI, 9755, gl9755),
> +       SDHCI_PCI_DEVICE(GLI, 9763E, gl9763e),
>         SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
>         /* Generic SD host controller */
>         {PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index fd76aa672e02..ca0166d9bf82 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -63,6 +63,19 @@
>  #define   SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY    GENMASK(2, 0)
>  #define   GLI_9750_TUNING_PARAMETERS_RX_DLY_VALUE    0x1
>
> +#define SDHCI_GLI_9763E_CTRL_HS400  0x7
> +
> +#define SDHCI_GLI_9763E_HS400_ES_REG      0x52C
> +#define   SDHCI_GLI_9763E_HS400_ES_BIT      BIT(8)
> +
> +#define PCIE_GLI_9763E_VHS      0x884
> +#define   GLI_9763E_VHS_REV       GENMASK(19, 16)
> +#define   GLI_9763E_VHS_REV_R      0x0
> +#define   GLI_9763E_VHS_REV_M      0x1
> +#define   GLI_9763E_VHS_REV_W      0x2
> +#define PCIE_GLI_9763E_SCR      0x8E0
> +#define   GLI_9763E_SCR_AXI_REQ           BIT(9)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>
>  /* Genesys Logic chipset */
> @@ -351,6 +364,81 @@ static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
>  }
>  #endif
>
> +static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
> +                                         struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       u32 val;
> +
> +       val = sdhci_readl(host, SDHCI_GLI_9763E_HS400_ES_REG);
> +       if (ios->enhanced_strobe)
> +               val |= SDHCI_GLI_9763E_HS400_ES_BIT;
> +       else
> +               val &= ~SDHCI_GLI_9763E_HS400_ES_BIT;
> +
> +       sdhci_writel(host, val, SDHCI_GLI_9763E_HS400_ES_REG);
> +}
> +
> +static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
> +                                       unsigned int timing)
> +{
> +       u16 ctrl_2;
> +
> +       ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +       ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> +       if (timing == MMC_TIMING_MMC_HS200)
> +               ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
> +       else if (timing == MMC_TIMING_MMC_HS)
> +               ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
> +       else if (timing == MMC_TIMING_MMC_DDR52)
> +               ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
> +       else if (timing == MMC_TIMING_MMC_HS400)
> +               ctrl_2 |= SDHCI_GLI_9763E_CTRL_HS400;
> +
> +       sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +}
> +
> +static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
> +{
> +       struct pci_dev *pdev = slot->chip->pdev;
> +       u32 value;
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +       value &= ~GLI_9763E_VHS_REV;
> +       value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_SCR, &value);
> +       value |= GLI_9763E_SCR_AXI_REQ;
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_SCR, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +       value &= ~GLI_9763E_VHS_REV;
> +       value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +}
> +
> +static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
> +{
> +       struct sdhci_host *host = slot->host;
> +
> +       host->mmc->caps |= MMC_CAP_8_BIT_DATA |
> +                          MMC_CAP_1_8V_DDR |
> +                          MMC_CAP_NONREMOVABLE;
> +       host->mmc->caps2 |= MMC_CAP2_HS200_1_8V_SDR |
> +                           MMC_CAP2_HS400_1_8V |
> +                           MMC_CAP2_HS400_ES |
> +                           MMC_CAP2_NO_SDIO |
> +                           MMC_CAP2_NO_SD;
> +       gli_pcie_enable_msi(slot);
> +       host->mmc_host_ops.hs400_enhanced_strobe =
> +                                       gl9763e_hs400_enhanced_strobe;
> +       gli_set_gl9763e(slot);
> +       sdhci_enable_v4_mode(host);
> +
> +       return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_gl9755_ops = {
>         .set_clock              = sdhci_set_clock,
>         .enable_dma             = sdhci_pci_enable_dma,
> @@ -390,3 +478,21 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
>         .resume         = sdhci_pci_gli_resume,
>  #endif
>  };
> +
> +static const struct sdhci_ops sdhci_gl9763e_ops = {
> +       .set_clock              = sdhci_set_clock,
> +       .enable_dma             = sdhci_pci_enable_dma,
> +       .set_bus_width          = sdhci_set_bus_width,
> +       .reset                  = sdhci_reset,
> +       .set_uhs_signaling      = sdhci_set_gl9763e_signaling,
> +       .voltage_switch         = sdhci_gli_voltage_switch,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_gl9763e = {
> +       .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +       .probe_slot     = gli_probe_slot_gl9763e,
> +       .ops            = &sdhci_gl9763e_ops,
> +#ifdef CONFIG_PM_SLEEP
> +       .resume         = sdhci_pci_gli_resume,
> +#endif
> +};
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 42ccd123b046..d0ed232af0eb 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -72,6 +72,7 @@
>
>  #define PCI_DEVICE_ID_GLI_9755         0x9755
>  #define PCI_DEVICE_ID_GLI_9750         0x9750
> +#define PCI_DEVICE_ID_GLI_9763E                0xe763
>
>  /*
>   * PCI device class and mask
> @@ -195,5 +196,6 @@ extern const struct sdhci_pci_fixes sdhci_snps;
>  extern const struct sdhci_pci_fixes sdhci_o2;
>  extern const struct sdhci_pci_fixes sdhci_gl9750;
>  extern const struct sdhci_pci_fixes sdhci_gl9755;
> +extern const struct sdhci_pci_fixes sdhci_gl9763e;
>
>  #endif /* __SDHCI_PCI_H */
> --
> 2.26.2
>
