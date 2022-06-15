Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53C9C43334
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jun 2022 17:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352107AbiFOReE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357945AbiFORdm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2022 13:33:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C64C18
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 20so19978907lfz.8
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcHVsoWguVVLX6D1o9p6ROzYq6Vx8lJC3ceKckv3Ay4=;
        b=pL1t+th8AsvavKWoWyXCwlHfo4w+BpNrHX/+qZpCkcTcFTvkBhwcJhH6kLrcco5aIT
         dMzV/4EDZ8W90wOEFxWwC4NuUOkwQG4f/I10x8tN41xmww9Qga+ps7Pyjw6RtKbT1XPt
         kDclqWzNDQCZL9dVuKvQTuQgtzAjRmw0jHYTat5C1cGwTAgZ/dEbnu6PLJgyDFATORuX
         kk6OnLexf+I6OeWxz2D7zQR0Z7nL2i0ea9Uh1Mb35r1YssNbBJu/cAyH0QMvBTcdIg+T
         nVXA9qlfHiPNPtzBEwHt+bM/nl7ITcCXM42nGHqUvGNbgABm7P2bP7zzvLq3RAwCTmbS
         6uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcHVsoWguVVLX6D1o9p6ROzYq6Vx8lJC3ceKckv3Ay4=;
        b=Oy58OnKQj+reZt5dQ9IEPIzTjkyeHRBu66yiAOIVG4Ya09FbhMKlphtJOXZAuEXeMB
         1DOE0TMy1OaPkuW/3RumbYYElGm2/X/q1B8PiMPm/n05Ovo1HCOqky7FN7AEw8eeV7bJ
         DJq8SlZyXoem9/R0MFksfAswc+I1skuGUBX7sqsjRpTSeDnnoetR9tSCUkHsxpoRBgud
         wDKy0ThiMoq6ibhck67JCkPI0wElFr2U/z5MZiKGPF8OotYHU9cBLlYpvxWUi2y11Xu+
         JhXFk4nAOl1BIwqx+LUGDnUnng7qYdSQFdkHobrbVOcZQWlA1/VrYJl4vB4U6HeNuFkK
         /gvQ==
X-Gm-Message-State: AJIora8cUVtJDZm9BXTk1VfaFrDTp9wj+pwIqWwjUu79ypYUEgaOPKK7
        I2vUwZ3xcn9qiHP9jWoQ7pPOQSq8zs7Y3/RdpQsvJg==
X-Google-Smtp-Source: AGRyM1syp1olg9wmO7O9Qx4xXKGJ5Ujb7iIbPyJx9BtqoyO1ka7CEAlVv9TnzuhTfveTUdS/L89RxjTf47ju1VaOxuI=
X-Received: by 2002:ac2:4bcc:0:b0:479:16a9:897 with SMTP id
 o12-20020ac24bcc000000b0047916a90897mr327943lfq.71.1655314419080; Wed, 15 Jun
 2022 10:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220613092907.2502-1-jason.lai@genesyslogic.com.tw>
In-Reply-To: <20220613092907.2502-1-jason.lai@genesyslogic.com.tw>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 10:33:03 -0700
Message-ID: <CAPDyKFp7N61WQYYVT_fBgXYGPUbLWTbu6AL4Jyt=n45bEzuZXQ@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: host: Improve READ/WRITE Performance of GL9763E
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

On Mon, 13 Jun 2022 at 02:29, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
>
> From: Jason Lai <jasonlai.genesyslogic@gmail.com>
>
> To improve READ/WRITE performance and take battery life into account, we
> turn on GL9763E L1 negotiation before entering runtime suspend and turn
> off GL9763E L1 negotiation while executing runtime resume. That is to say,
> GL9763E will not enter L1 state when executing I/O requests and enter L1
> state when PCIe bus idle.
>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> This patch is the follow-up to the patch [1] and adopt Ulf's comment.
>
> Due to flaws in hardware design, GL9763E takes long time to exit from L1
> state. The I/O performance will suffer severe impact if it often enter
> and exit L1 state during I/O requests.
>
> [1] https://patchwork.kernel.org/project/linux-mmc/list/?series=646869
>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index d09728c37d03..69bc3d614e15 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -95,6 +95,9 @@
>  #define PCIE_GLI_9763E_SCR      0x8E0
>  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
>
> +#define PCIE_GLI_9763E_CFG       0x8A0
> +#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
> +
>  #define PCIE_GLI_9763E_CFG2      0x8A4
>  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
>  #define   GLI_9763E_CFG2_L1DLY_MID 0x54
> @@ -818,6 +821,31 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
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
>  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
>  {
>         struct cqhci_host *cq_host = mmc->cqe_private;
> @@ -959,6 +987,9 @@ static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
>         struct sdhci_host *host = slot->host;
>         u16 clock;
>
> +       /* Enable LPM negotiation to allow entering L1 state */
> +       gl9763e_set_low_power_negotiation(slot, true);
> +
>         clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>         clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
>         sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> @@ -989,6 +1020,9 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
>         clock |= SDHCI_CLOCK_CARD_EN;
>         sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
>
> +       /* Disable LPM negotiation to avoid entering L1 state. */
> +       gl9763e_set_low_power_negotiation(slot, false);
> +
>         return 0;
>  }
>  #endif
> --
> 2.36.1
>
