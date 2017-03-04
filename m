From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v2] mmc: sdhci-cadence: add HS400 enhanced strobe support
Date: Sat, 4 Mar 2017 12:37:13 +0900
Message-ID: <CAK7LNASx5jO8FdJv2e085A5BJ5V-sZjJjSsiM4vM8o6ofF+0KA@mail.gmail.com>
References: <1488529893-6690-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:44509 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdCDDjA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Mar 2017 22:39:00 -0500
In-Reply-To: <1488529893-6690-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Piotr,


2017-03-03 17:31 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> Add support for HS400ES mode to Cadence SDHCI driver.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>


Thanks for your patch.  It looks almost good to me.
My comments are about some coding style issues only.
Please see below.




> +static void sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv, u32 *mode)
> +{
> +       *mode = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
> +       *mode = *mode & SDHCI_CDNS_HRS06_MODE_MASK;
> +}
> +

Why doesn't this function simply return u32 value?





>
> +static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
> +                                            struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +       u32 timingMode;

Could you avoid CamelCase, please?
(perhaps does checkpatch.pl complain about this?).

I guess "mode" could be enough.



> +       priv->enhanced_strobe = ios->enhanced_strobe;
> +
> +       sdhci_cdns_get_emmc_mode(priv, &timingMode);
> +
> +       if (timingMode == SDHCI_CDNS_HRS06_MODE_MMC_HS400 &&
> +           ios->enhanced_strobe)
> +               sdhci_cdns_set_emmc_mode(priv,
> +                                        SDHCI_CDNS_HRS06_MODE_MMC_HS400ES);
> +
> +       if (timingMode == SDHCI_CDNS_HRS06_MODE_MMC_HS400ES &&
> +           !ios->enhanced_strobe)

You could stretch this if-conditional within 80-col
by renaming "timingMode" into "mode".





> +       host->mmc_host_ops.hs400_enhanced_strobe =
> +               sdhci_cdns_hs400_enhanced_strobe;

I should not say this if this is the only matter,
but can you move the 2nd line to the right by inserting some more tabs?



FYI:
If you have not checked the coding-style guideline yet, and you are interested,
it is a good idea to read Documentation/process/coding-style.rst


Some of my comments are based on the following statements in that document:

  - "LOCAL variable names should be short, and to the point."
  - "Descendants are always substantially shorter than the parent and
     are placed substantially to the right."

We need not too be nervous about the style,
but generally speaking, it will be nice to keep the style consistent
unless there is a specific reason.

Thanks!

-- 
Best Regards
Masahiro Yamada
