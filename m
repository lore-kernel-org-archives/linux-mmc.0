From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] Add HS400 enhanced strobe support
Date: Thu, 23 Feb 2017 21:49:41 +0900
Message-ID: <CAK7LNATTsDDGrct5kBHjPCVi8MXjqi6V4_QdiUV8zKDwGeLyoA@mail.gmail.com>
References: <1487166614-12808-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83]:43798 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdBWMuu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Feb 2017 07:50:50 -0500
In-Reply-To: <1487166614-12808-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi.


2017-02-15 22:50 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> Add support for HS400ES mode to Cadence SDHCI driver.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>


Next time, please add "mmc: sdhci-cadence" to the patch subject.
This will clarify which driver is being touched.



> +static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
> +                                            struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +
> +       priv->enhanced_strobe = ios->enhanced_strobe;
> +       if (ios->enhanced_strobe)
> +               sdhci_cdns_set_emmc_mode(priv,
> +                                        SDHCI_CDNS_HRS06_MODE_MMC_HS400ES);
> +}


This function, if ios->enhanced_strobe is true, enables it immediately,
but nothing happens if ios->enhanced_strobe is false.
(it will be disabled at the next call of sdhci_cdns_set_uhs_signaling().)

If you look at drivers/mmc/core/core.c,
mmc_set_ios() is called immediately after
host->ops->hs400_enhanced_strobe(host, &host->ios),
but I am not quite sure if we should rely on that fact.

I am just putting my untested code below.


static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
                                             struct mmc_ios *ios)
{
        struct sdhci_host *host = mmc_priv(mmc);
        struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
        u32 mode;

        mode = readl(priv->hrs_addr + SDHCI_CDNS_HRS06) &
               SDHCI_CDNS_HRS06_MODE_MASK;

        switch (mode) {
        case SDHCI_CDNS_HRS06_MODE_MMC_HS400:
                if (ios->enhanced_strobe)
                        mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400ES;
                break;
        case SDHCI_CDNS_HRS06_MODE_MMC_HS400ES:
                if (!ios->enhanced_strobe)
                        mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
                break;
        default:
                break;
        }

        sdhci_cdns_set_emmc_mode(priv, mode);

        priv->enhanced_strobe = ios->enhanced_strobe;
}


BTW, I prefer sdhci_cdns_hs400_enhanced_strobe()
is placed below sdhci_cdns_execute_tuning()
because these two callbacks belong to the same group.

These two are not members of sdhci_ops,
but replacements for host->mmc_host_ops.



The other parts look good to me.

-- 
Best Regards
Masahiro Yamada
