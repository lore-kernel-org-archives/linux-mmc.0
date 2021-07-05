Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E2FC07E99
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 10:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA815613C1
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 10:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhGEKF6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Jul 2021 06:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhGEKF6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jul 2021 06:05:58 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E72BC061574
        for <linux-mmc@vger.kernel.org>; Mon,  5 Jul 2021 03:03:20 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id j8so9861406vsd.0
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jul 2021 03:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCwAY9fp9m4N9qN3XklVdcm5LogiF/7qBOK8O4Xezts=;
        b=HaWOVjsbrkK3DRHwifuSfjEUUvZY66ImXxEk/FjmZg0zSz51Eg09ZfQPEUh5nZkeEB
         oSMYhQKlkkmBfAYj5HVCRIF2Gn/9WejtabmpVSNsritb2UuKso/qitq0prFgCiE/mE92
         oN6GJVMCG5LVjWcCoDUwbVWqjNbz5pfnwTSYGpgVRRr4XlzWQOnmD7G29MM8LQhxS3Ql
         Jr3A4A5APfj6A7GStgHZy9+gXTUPeFqQTODFs7ZwffhGu0/vxYT+/9IEVZ951ImpLYRl
         K1j4O9LkyZsrXgob2p15LNJhTv4hpaxLWvduP/EjDHkmsPGIT8ZEBDDgU0VWyKv1XSjt
         TRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCwAY9fp9m4N9qN3XklVdcm5LogiF/7qBOK8O4Xezts=;
        b=tgjQ6PZKVJ4UOIeEvj3gzynGJm2SDNXFeKyfSTDPbDs/o/i3RdMGr9CC00vBsBvSEc
         cusjUDrYBBlTnraTmF3VTAdr2Ps0kQogFm4bD7X7ZlF1wEASgT6R0ufGx4MAb0BpJV/v
         sL+weYhT2v+u/qWYQ5NLRDdqOylOId8+qIqmRSWb0muz9Tb0qzLsStK0iJAD7ZKgAvoL
         wfFGZ5QnsT33vc13ISdI/7Nw1NRxG4flRBGIPAMXBqTFPC2vmbSMM9KZpy1rTZRTijqu
         fiuj6ugSOiPXdNnZ+gHXcqXoNK7wbSNxF74er7EUYgjbZKDtluzQ4CfYRjFNWiSpXyyt
         kD1w==
X-Gm-Message-State: AOAM533Y1sDw5SaGe1rJdRrD3wvaGddKhcK2dWiNFgDiRWA5+7DAj6mx
        ObSoSMsNjSEUxSnFSpmInfjQb0ha3+KI9DcRJ1H32Q==
X-Google-Smtp-Source: ABdhPJzA2zaPYtbcfHP7MCekBgbK5yW7QqHZNrHPcI+yU71gwdOp6Z9C1MX4M2+nmsaZ7ybuc8zjmRETb6m9MbW3aIE=
X-Received: by 2002:a67:ee54:: with SMTP id g20mr8398583vsp.55.1625479399604;
 Mon, 05 Jul 2021 03:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com>
In-Reply-To: <20210705090050.15077-1-reniuschengl@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 5 Jul 2021 12:02:43 +0200
Message-ID: <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     Renius Chen <reniuschengl@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 5 Jul 2021 at 11:00, Renius Chen <reniuschengl@gmail.com> wrote:
>
> During a sequence of random 4K read operations, the performance will be
> reduced due to spending much time on entering/exiting the low power state
> between requests. We disable the low power state negotiation of GL9763E
> during a sequence of random 4K read operations to improve the performance
> and enable it again after the operations have finished.
>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 68 ++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 302a7579a9b3..5f1f332b4241 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -88,6 +88,9 @@
>  #define PCIE_GLI_9763E_SCR      0x8E0
>  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
>
> +#define PCIE_GLI_9763E_CFG       0x8A0
> +#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
> +
>  #define PCIE_GLI_9763E_CFG2      0x8A4
>  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
>  #define   GLI_9763E_CFG2_L1DLY_MID 0x54
> @@ -128,6 +131,11 @@
>
>  #define GLI_MAX_TUNING_LOOP 40
>
> +struct gli_host {
> +       bool start_4k_r;
> +       int continuous_4k_r;
> +};
> +
>  /* Genesys Logic chipset */
>  static inline void gl9750_wt_on(struct sdhci_host *host)
>  {
> @@ -691,6 +699,62 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
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
> +       if (cmd && (cmd->opcode == MMC_READ_MULTIPLE_BLOCK) && (cmd->data->blocks == 8)) {
> +               gli_host->continuous_4k_r++;
> +
> +               if ((!gli_host->start_4k_r) && (gli_host->continuous_4k_r >= 3)) {
> +                       gl9763e_set_low_power_negotiation(slot, false);
> +
> +                       gli_host->start_4k_r = true;
> +               }
> +       } else {
> +               gli_host->continuous_4k_r = 0;
> +
> +               if (gli_host->start_4k_r)       {
> +                       gl9763e_set_low_power_negotiation(slot, true);
> +
> +                       gli_host->start_4k_r = false;
> +               }
> +       }

The above code is trying to figure out what kind of storage use case
that is running, based on information about the buffers. This does not
work, simply because the buffers don't give you all the information
you need to make the right decisions.

Moreover, I am sure you would try to follow up with additional changes
on top, trying to tweak the behaviour to fit another use case - and so
on. My point is, this code doesn't belong in the lowest layer drivers.

To move forward, I suggest you explore using runtime PM in combination
with dev PM qos. In this way, the driver could implement a default
behaviour, which can be tweaked from upper layer governors for
example, but also from user space (via sysfs) allowing more
flexibility and potentially support for various more use cases.

> +
> +       sdhci_request(mmc, mrq);
> +}
> +
> +
>  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
>  {
>         struct cqhci_host *cq_host = mmc->cqe_private;
> @@ -848,6 +912,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>         gli_pcie_enable_msi(slot);
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                                         gl9763e_hs400_enhanced_strobe;
> +
> +       host->mmc_host_ops.request = gl9763e_request;
> +
>         gli_set_gl9763e(slot);
>         sdhci_enable_v4_mode(host);
>
> @@ -913,4 +980,5 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>         .suspend        = sdhci_cqhci_gli_suspend,
>  #endif
>         .add_host       = gl9763e_add_host,
> +       .priv_size      = sizeof(struct gli_host),
>  };
> --

Kind regards
Uffe
