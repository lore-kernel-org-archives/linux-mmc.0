Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543B0C433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jun 2022 13:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351729AbiFANBY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jun 2022 09:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiFANBY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2022 09:01:24 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D5811A27
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jun 2022 06:01:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id t13so1912088ljd.6
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2022 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MnvqxACh+uZ2Kj2f4iFs6Q+9J5vjuYCtDh3mHYXw08=;
        b=bdeMP6ryAZKyMpDzSHaYvRDBep8FwNLjxVniHcllSALFjBtfkYlbFxEvd4K+qMV6AH
         NNSwwD5xd0mYTNt2att/Gw3xGRmO/7/nKciV/oNdvq95f0Oan0v6cAmLz1lNTO4lVpZW
         m7qWHPhPmEn38vEoKx8XEzEaEVsdGtg9vacAciXoQ8zk5U+qy8Wjj3nojH7vPG4HPVzC
         wqbDqZc/jr4hcc9GWKOMZDucLUaOLgWvEiJwr+Qv6PAgvIHRnqm0GGgfYKHiI3Qbo0ZK
         hkwmciujrTa2nRN+XH8L1lb+4prL4FDEY2Ai+ZkgpK4YjXFVNt6HG3MBHG3MxhPJ/QJY
         bzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MnvqxACh+uZ2Kj2f4iFs6Q+9J5vjuYCtDh3mHYXw08=;
        b=5FV/T7b3H7MTHVnS4DePSulM3QyLKp4bSM8WR4sM2rEx58vFcC9GyEDl1Y8kUG2oET
         vzKYK6tqVdKcnz+7byQMxacCO6XcIzNthwEUJD8C7k4WAtwnzN+ISFfUFAuALkZE5D5D
         s3CI2MOQiJPUyREfTOZYIHARoDiUNcHtOR9wlRcwF0na98hdBQPCL0PgQ5qe0tAl3Hfk
         TXWpQVIlK5K/63vyLlp2T4gf3OQOTseBApAUB6yRUitrH7IAFqk9tYM/f0vjkKw5fPDN
         i1g4aSVmymv1aRYtCcgPtiTL3jDFCfmnjU45Sz3KNdddNLKeMwBYm1zpVKOxK7C0YVJT
         yHNQ==
X-Gm-Message-State: AOAM533EeLSRimsUsm5TlDabkPdwauSx3rvEJ0QoAnYa/Drp9+tEyd6N
        svAnBKY/db7GyAZAmzSrNeN56NxdJEncBMKzdonbiQ==
X-Google-Smtp-Source: ABdhPJwPTvKmzMRmYKBbsHfY6s3ek7XVyozQ93IDPGDfcNlYzRUjMC+ml5u/zRei/ZCdpl+uDY5O8E8BJTLAA3EvYqM=
X-Received: by 2002:a2e:3908:0:b0:253:c4c5:e82b with SMTP id
 g8-20020a2e3908000000b00253c4c5e82bmr37277048lja.367.1654088480897; Wed, 01
 Jun 2022 06:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220530084702.64943-1-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20220530084702.64943-1-jasonlai.genesyslogic@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Jun 2022 15:00:44 +0200
Message-ID: <CAPDyKFpynSNVMd1iRZyk3KY6sVudcXC1rbbzHSXTqa2YQQjinw@mail.gmail.com>
Subject: Re: [V2] mmc: sdhci-pci-gli: Improve Random 4K Read Performance of GL9763E
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

On Mon, 30 May 2022 at 10:47, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
>
> This patch is based on patch [1] and adopt Adrian's comment.

Please squash $subject patch into [1], rather than making a new patch on top.

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
> L1 negotiation while executing MMC_READ_MULTIPLE_BLOCK command and enable
> L1 negotiation again when receiving non-MMC_READ_MULTIPLE_BLOCK command.

I am not sure how the HW decides to enter L1. That said, I wonder if
it would be a better option to turn on/off the LPM from the
->runtime_suspend|resume() callbacks instead?

Kind regards
Uffe

>
> [1] https://patchwork.kernel.org/project/linux-mmc/list/?series=645165
>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 86200b73c0b0..13c09202da9c 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -850,24 +850,29 @@ static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>  }
>
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
>  static void gl9763e_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
>         struct mmc_command *cmd;
>         struct sdhci_pci_slot *slot = sdhci_priv(host);
> -       struct gli_host *gli_host = sdhci_pci_priv(slot);
>
>         cmd = mrq->cmd;
> -
> -       if (cmd && (cmd->opcode == MMC_READ_MULTIPLE_BLOCK) && gli_host->lpm_negotiation_enabled) {
> -               gl9763e_set_low_power_negotiation(slot, false);
> -               gli_host->lpm_negotiation_enabled = false;
> -       } else {
> -               if (gli_host->lpm_negotiation_enabled == false) {
> -                       gl9763e_set_low_power_negotiation(slot, true);
> -                       gli_host->lpm_negotiation_enabled = true;
> -               }
> -       }
> +       if (cmd && (cmd->opcode == MMC_READ_MULTIPLE_BLOCK))
> +               gl9763e_set_lpm_negotiation(slot, false);
> +       else
> +               gl9763e_set_lpm_negotiation(slot, true);
>
>         sdhci_request(mmc, mrq);
>  }
> @@ -975,6 +980,7 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>  {
>         struct pci_dev *pdev = slot->chip->pdev;
>         u32 value;
> +       struct gli_host *gli_host = sdhci_pci_priv(slot);
>
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>         value &= ~GLI_9763E_VHS_REV;
> @@ -995,6 +1001,9 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
>
> +       /* Default setting of LPM negotiation is enabled. */
> +       gli_host->lpm_negotiation_enabled = true;
> +
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, &value);
>         value &= ~GLI_9763E_HS400_RXDLY;
>         value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
> --
> 2.36.1
>
