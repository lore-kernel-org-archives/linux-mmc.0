Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADE4C43334
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jun 2022 09:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiFGJpc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jun 2022 05:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbiFGJpa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 05:45:30 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61092E64DB
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jun 2022 02:45:29 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r1so1627569ybd.4
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2022 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2X9iRPRKaOl53iH3EPxaeVLGwUDKIuTwgGZgaLJPp0=;
        b=k4EkXacktROQTgJmhz6FvROgKQTbPFABk90BHV5DjB+j0chjxINDGmmf1c5fCG2F2h
         7kF6ZZHO7QcyNAMy7Ix3L2ypQYHIPVgDCGrBODjPft804cJ3Kj7ZUog3tvQe8tmza8nk
         gdvoTNMWkadMnFR9dkQtLIy5qUneBNpt0ri0cQoaLOIcjnXolg4gOutrvXtGq5LCBIPn
         kIr1N80VbDKkHwtK6n2dP6FuMY5l/s8Dk2HQy786o6LxfH4tSl2OeQ8UbOBLRxhzYkJI
         MeWaIUkRWDGpKSc39EoAsWukrFxoIdQC8YCxMTqQ03Ds1Q0aWUddiMUT1iI8FEla1LRe
         qEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2X9iRPRKaOl53iH3EPxaeVLGwUDKIuTwgGZgaLJPp0=;
        b=Xf6V1/mkZ8Hi3sQmBivyt0GPs5V36sFFe8pxCfPw88Rxu9t37joZ+WdyBfIlnbW4TR
         x8EFpTNpCXID5MZXuediko9n/UWkuEI+TBj+4t8IEpP3tGPwUl9ogdgjqiYmuLpFSH3+
         nHvm1NGg7Ic8Cjcv/3DfQ0euCWWakVaNlmUhUwuvkYsoDPx/tGvOOiIwOCLDXTdgk60z
         qhtjU+x0adtSGUn0ehROw2lUCOE6pr0Kj+ozpJtS7r/CiH+2/mrEjaEahWlRjNfKfRBZ
         UPb560Xc9oe9271Zr73wkDzvuBj439IwWhPPwbQ0XcyIVj0QcXDff3n9cIFxKoNalyFd
         yaHg==
X-Gm-Message-State: AOAM530PIpcwafIpbSXVWzyUyVd0DvkHtSPzFV1zWCXiyvjv9ycGPten
        jrn/9qcDHHFJxLiriUFqTeeK9WhXecto2zuia8XvAYFi
X-Google-Smtp-Source: ABdhPJwe+7VB+QtHJoNxKAqmAwjLYRrous8o1mvauKtPLqmZXnTd7qpYeVASEEzPFMrQs6xKq5YBzamXVxxmhhIh7AY=
X-Received: by 2002:a5b:a4f:0:b0:65c:a9c2:dc96 with SMTP id
 z15-20020a5b0a4f000000b0065ca9c2dc96mr29681511ybq.18.1654595128671; Tue, 07
 Jun 2022 02:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220602114815.1801-1-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20220602114815.1801-1-jasonlai.genesyslogic@gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Tue, 7 Jun 2022 17:45:18 +0800
Message-ID: <CAG0XXUF0JrQQXfgy4dynby0pNDoDxjFYq_rQB__ODV8YqTCTUg@mail.gmail.com>
Subject: Re: [RESEND] mmc: host: Improve READ/WRITE Performance of GL9763E
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        SeanHY.chen@genesyslogic.com.tw,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        victor.shih@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,
    Do you have any comments about this patch?

kind regards,
Jason Lai



On Thu, Jun 2, 2022 at 7:48 PM Jason Lai
<jasonlai.genesyslogic@gmail.com> wrote:
>
> From: Jason Lai <jason.lai@genesyslogic.com.tw>
>
> Resend this path to fix typo in the following message.
>
> This patch is the follow-up to the patch [1] and adopt Ulf's comment.
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
