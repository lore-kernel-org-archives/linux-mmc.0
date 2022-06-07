Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490D1C43334
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jun 2022 11:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbiFGL0b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jun 2022 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbiFGL0a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 07:26:30 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE8CB0438
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jun 2022 04:26:29 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m25so15523012lji.11
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2022 04:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+GsRNHM+gUC3ILkZfy0P7gbySArTMhMkLLLOFe/YiE=;
        b=V/BPpAQ6jPfG/Vm00laKlt3Hf5YyQb2zWxqf/kbJNh2uKllC1S9k5Oz2iZZpe6s5PP
         pr3TFF/xLoN162ia+ifBo+G7qkY+GS8e5CWBVSHBzDjpcubIQFXZU1eMajzhOdeN+odu
         XBzyN83RcEH0rx4n/iHPUEzZ4maFz5LWSWqHV6jEoiw6jSqRS7YfcHYSfXRd8BnS5Q+A
         HLKXysn+Kgl+cwVBjPKQQK/yghZPh/Qgh6vwgs6N4SudlUPcCz7zIAZau2zL4eBcV7b7
         xqDfU5Kg9Oq4EyYJlce9X62jj3nKQitZNKJRzdBXH3y91rKB92HgOtcceWEZxU//533I
         QJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+GsRNHM+gUC3ILkZfy0P7gbySArTMhMkLLLOFe/YiE=;
        b=Ze/Ud8pGfAZ1qsNo1bxhsMz9Tzw6Um5LX9q0JhaDOTXcZ5woOKvDZk+74yYWQHBZTO
         F6x9EhcoIe8DJrHGJg/hhuIJjzZhQXCiiCM+pBsSfnEUyp41X0u6+HePW2GryatMwpFr
         FgdFHkvtYDM+pk25bNFfZMl23WhLwGg3ORnt+SbZRFtOQLLDby+xDQGtj/z1qTPRaqLh
         g9uNFOnBgVMOhjJjc9HByjWAjlP69U3iyR1bePU88Hq444dTxP9argdfC6g7eoo8jHMu
         pYGie6dMNz54P5VXPJ1Bi5IDqFfb5VTQ3Ypc5ShH/kIO1sYym0y6g3tuFKQ0dTRscYx0
         bI+A==
X-Gm-Message-State: AOAM533L65cGFyvwSYKr4R2KSTjSyt4a/zxXowGOiyOkMVXzCySs/PYK
        HMjyitno5X0Oz5/YoUen53TLgy3SHik119q2sWb6Fw==
X-Google-Smtp-Source: ABdhPJwQJndIGMpRqM3HTAmHmPqbIhjMJ5/UfRi/Hf4LUiqkae4Plisplb+PU972/BNYkXJeoTouJI3+PzfYXXb+CX4=
X-Received: by 2002:a05:651c:a04:b0:253:f0b4:a406 with SMTP id
 k4-20020a05651c0a0400b00253f0b4a406mr41637842ljq.4.1654601187661; Tue, 07 Jun
 2022 04:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220602114815.1801-1-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20220602114815.1801-1-jasonlai.genesyslogic@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jun 2022 13:25:51 +0200
Message-ID: <CAPDyKFqPBLNdLmNPHeQ4eMXbgUSPQfqxnAtD3h9exjoze-yDSQ@mail.gmail.com>
Subject: Re: [RESEND] mmc: host: Improve READ/WRITE Performance of GL9763E
To:     Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        SeanHY.chen@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        victor.shih@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2 Jun 2022 at 13:48, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
>
> From: Jason Lai <jason.lai@genesyslogic.com.tw>
>
> Resend this path to fix typo in the following message.
>
> This patch is the follow-up to the patch [1] and adopt Ulf's comment.

Please start to care about versioning your patches correctly. It's
difficult to follow what goes on in between each submission, thus it
makes it harder for me to review.

Moreover, the above information is nice to have, but it should not be
a part of the commit message, but rather in the separate section. See
more below.

>
> Due to flaws in hardware design, GL9763E takes long time to exit from L1
> state. The I/O performance will suffer severe impact if it often enter
> and exit L1 state during I/O requests.
>
> To improve READ/WRITE performance and take battery life into account, we
> turn on GL9763E L1 negotiation before entering runtime suspend and turn
> off GL9763E L1 negotiation while executing runtime resume. That is to say,
> GL9763E will not enter L1 state when executing I/O requests and enter L1
> state when PCIe bus idle.
>
> [1] https://patchwork.kernel.org/project/linux-mmc/list/?series=645922
>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> ---

This is where patch versioning and other information belongs. To keep
the correct patch format, add a newline here and end the section with
three "dashes" on a separate line.

---
>  drivers/mmc/host/sdhci-pci-gli.c | 57 +++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index d09728c37d03..891bcd38fd6d 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -95,9 +95,12 @@
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
> @@ -144,6 +147,10 @@
>
>  #define GLI_MAX_TUNING_LOOP 40
>
> +struct gli_host {
> +       bool lpm_negotiation_enabled;
> +};
> +
>  /* Genesys Logic chipset */
>  static inline void gl9750_wt_on(struct sdhci_host *host)
>  {
> @@ -818,6 +825,43 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
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
> +static void gl9763e_set_lpm_negotiation(struct sdhci_pci_slot *slot, bool enable)
> +{
> +       struct gli_host *gli_host = sdhci_pci_priv(slot);
> +
> +       if (gli_host->lpm_negotiation_enabled == enable)
> +               return;

I don't think you need to keep track of the previous state.

When the host becomes runtime suspended we enable the lpm mode. When
the host is runtime resumed we disable the lpm mode. That looks
sufficient to me, no?

> +
> +       gli_host->lpm_negotiation_enabled = enable;
> +
> +       gl9763e_set_low_power_negotiation(slot, enable);
> +}
> +
>  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
>  {
>         struct cqhci_host *cq_host = mmc->cqe_private;
> @@ -921,6 +965,7 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>  {
>         struct pci_dev *pdev = slot->chip->pdev;
>         u32 value;
> +       struct gli_host *gli_host = sdhci_pci_priv(slot);
>
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>         value &= ~GLI_9763E_VHS_REV;
> @@ -941,6 +986,9 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
>
> +       /* Default setting of LPM negotiation is enabled. */
> +       gli_host->lpm_negotiation_enabled = true;
> +
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, &value);
>         value &= ~GLI_9763E_HS400_RXDLY;
>         value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
> @@ -959,6 +1007,9 @@ static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
>         struct sdhci_host *host = slot->host;
>         u16 clock;
>
> +       /* Enable LPM negotiatiom to allow entering L1 state */
> +       gl9763e_set_lpm_negotiation(slot, true);
> +
>         clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>         clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
>         sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> @@ -989,6 +1040,9 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
>         clock |= SDHCI_CLOCK_CARD_EN;
>         sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
>
> +       /* Disable LPM negotiatiom to avoid entering L1 state. */
> +       gl9763e_set_lpm_negotiation(slot, false);
> +
>         return 0;
>  }
>  #endif
> @@ -1109,4 +1163,5 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>         .allow_runtime_pm = true,
>  #endif
>         .add_host       = gl9763e_add_host,
> +       .priv_size      = sizeof(struct gli_host),
>  };
> --
> 2.36.1
>

Kind regards
Uffe
