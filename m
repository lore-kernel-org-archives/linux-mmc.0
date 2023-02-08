Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BB8C05027
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Feb 2023 11:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjBHLfn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Feb 2023 06:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjBHLfn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2023 06:35:43 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A698B458A4
        for <linux-mmc@vger.kernel.org>; Wed,  8 Feb 2023 03:35:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 7so12467769pga.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Feb 2023 03:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=su2Uv1RY21hobn+Be1LsOLLoAgAxd31SQuRK0ovyNhk=;
        b=DsTCOa59AEAtR9QctXXnEtqG2TzqIf47NMadFXN4/wdjBrRXgdZyHFyNOuzxN/pmml
         NLcaaqhJHE3tt7pH5ML9vZwqfA/k11uzw1c4hTTMFDPNyK5Cc5SVHVx/C83uqbqC2a+P
         WkktV3aTdKdtPy+rCsi0OERvdU7pd7AcNITaAlSAw2vdhD64HNVRfRXVx2bWblV2s8qB
         fwPTWD73kurVlluA6TcIxt2mNA4k21DdeddRbCoxT91icqj7+rrYC+Nm2X063VLdMJ3S
         u0ANpTeHLXZVMG4MthJkplv/8a7C8c1U6AFXWXk2sNqKYGFogvNXz95Q1O9ZCOl33B8O
         D+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=su2Uv1RY21hobn+Be1LsOLLoAgAxd31SQuRK0ovyNhk=;
        b=eJvU7TiKi26jpx/6XppKUj8Bk7d0gHAA3R7s4eaiERC38Pr9KlT/EuUKf6TSNFy+TF
         0TAxZxTTUzopiLonMMZtIdweHvBMpR6tu02E4LYWkBNHtYHx+m5lJWKMP6lYSodDsWjH
         0w8esOWAzX55dz8DVErMn0D1Eg5ebJkiXoqptYKtBNpxYNIQ89luUHNHg4Def1ZNUCFv
         DU9IOPf5YX1DZ0eMYt4Dr0CAthNBF12r88jr41anKlvilx9/DbN/YPNMV/sAlASotQFb
         BZBMVXZfg4iOzyt5+41iwKjzOKJL3TO8GX8HqMOsZtpX7m3POPfoD87nT9vRy+WGmo8v
         v3Ew==
X-Gm-Message-State: AO0yUKVKewcMBM+XW7isNK5m5QNm7ee125gBO3bMe5PlFy+EJtLMDsCN
        ImL6srIJeZuFZxWJXXxP+wJSYc/cgFJdSAc5cxtqc1kB/2Prdw==
X-Google-Smtp-Source: AK7set+m5KH7rmnS/iLBQPWUV3y7UALFqc0hm389QZJ78mtpe8IuVlbBUXAD6+ZsOfUeieDdS+PHQKmCJLCBQPa1NPk=
X-Received: by 2002:aa7:99d2:0:b0:593:b13c:e2c0 with SMTP id
 v18-20020aa799d2000000b00593b13ce2c0mr1552510pfi.32.1675856140112; Wed, 08
 Feb 2023 03:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw> <20221213090047.3805-25-victor.shih@genesyslogic.com.tw>
In-Reply-To: <20221213090047.3805-25-victor.shih@genesyslogic.com.tw>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Feb 2023 12:35:04 +0100
Message-ID: <CAPDyKFojDjsjAstdLFdM5E1ZJVBaLO1DT0FXBcVo0nWBm=B0aw@mail.gmail.com>
Subject: Re: [PATCH V6 24/24] mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 13 Dec 2022 at 10:02, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Changes are:
> * Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
> * Enable the internal clock when do reset on UHS-II mode.
> * Set ZC to 0x0 for Sandisk cards and set ZC to 0xB for others.
> * Increase timeout value before detecting UHS-II interface.
> * Add vendor settings fro UHS-II mode.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/Kconfig         |   1 +
>  drivers/mmc/host/sdhci-pci-gli.c | 309 ++++++++++++++++++++++++++++++-
>  2 files changed, 309 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 9c22370fb778..e68cdcb72cba 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -111,6 +111,7 @@ config MMC_SDHCI_PCI
>         tristate "SDHCI support on PCI bus"
>         depends on MMC_SDHCI && PCI
>         select MMC_CQHCI
> +       select MMC_SDHCI_UHS2
>         select IOSF_MBI if X86
>         select MMC_SDHCI_IO_ACCESSORS
>         help
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c

[...]

> +static void gl9755_post_attach_sd(struct sdhci_host *host)
> +{
> +       struct pci_dev *pdev;
> +       struct sdhci_pci_chip *chip;
> +       struct sdhci_pci_slot *slot;
> +       u32 serdes;
> +
> +       slot = sdhci_priv(host);
> +       chip = slot->chip;
> +       pdev = chip->pdev;
> +
> +       gl9755_wt_on(pdev);
> +
> +       pci_read_config_dword(pdev, PCI_GLI_9755_SerDes, &serdes);
> +       serdes &= ~PCI_GLI_9755_UHS2_SERDES_ZC1;
> +       serdes &= ~PCI_GLI_9755_UHS2_SERDES_ZC2;
> +       serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC1,
> +                            GLI_9755_UHS2_SERDES_ZC1_VALUE);
> +
> +       /* the manfid of sandisk card is 0x3 */
> +       if (host->mmc->card->cid.manfid == 0x3)
> +               serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC2,
> +                                    GLI_9755_UHS2_SERDES_ZC2_SANDISK);
> +       else
> +               serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC2,
> +                                    GLI_9755_UHS2_SERDES_ZC2_DEFAULT);
> +
> +       pci_write_config_dword(pdev, PCI_GLI_9755_SerDes, serdes);

Can you please clarify what kind of configuration you are doing here -
and in particular why it's based upon the card's manfid?

[...]

Kind regards
Uffe
