Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F40C33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4F62075B
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lOtJ0XYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgAPOkS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:40:18 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34450 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPOkS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 09:40:18 -0500
Received: by mail-ua1-f66.google.com with SMTP id 1so7715906uao.1
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2020 06:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55hdoqwC1l3Y5tT8RJ4vFGhQpV1GTMrOlYccTMcxpio=;
        b=lOtJ0XYMpEYdQgCUgjzXy0tQJArjYwpAzQouV2q7YE+tkVM8wWHhlRwLNPjTDAwyTT
         h0gaB0k9B0xact4enGbULhKUcSHkl74Am901Q3SLO3pY6c6SjlnTwWlVwRvjog3CTGEN
         JyQF4JSdw9RO8qAEHtpFk3GlQtHoyGrAC2FE79SwUE47FscOc8MChyOPwGhXpffmQ5Oy
         nd4ZDNT+Ofkqrg8d7M7lIUN6LcKb2bVJgMIImcpJowJWVUY3RGGSjOJ5F1RRMriZu71N
         3UQRNsKNHgzTiBqGMFkNbDmUCz4dnttsv/Kh7v8R9cuvXTbBDHHKUZz6awboC7XQ/Zgg
         Ml7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55hdoqwC1l3Y5tT8RJ4vFGhQpV1GTMrOlYccTMcxpio=;
        b=j3GZv4QVWftPpFVw+A2heFQvaVk7avN7hQuBmX8g6+xiDam3Us7HsMTUbrPtcNiYSg
         0edJYMD6kaWBe3d2YDi5/6qfrxY0/vYB/dggzwS4btvoykYS3UFVQETj/1wK/zV40c8K
         Hmrk853sP4tXN0X57UiGKiItrjSd7TUkK4XVzJYiYEIWNble/aI0JAeNBNQGJ5jFhwD2
         punFDPpYBbbOzIe8k5pgC/mPWkfG/GffBl6uW/aKivkJOd3goKU33KrHP8JGShNhmImf
         W4dAJQQIsU/56Wk+ECBae4c8lf15h9NVoiJZvANug/60YZu3ZTJ+sG3DRtn2guzqnV+T
         0rdw==
X-Gm-Message-State: APjAAAXxwX3Qmt4x7BOZkoyo58R8LAh0HQWI7l4NpcfLru7kduv9PCK6
        vET4gn3ZmD70OVp74923Znfs4kcHhOzy8z/e+xJZOq4V
X-Google-Smtp-Source: APXvYqwaW79phQ4YWM6Gwjk04O8PkPewIPEJSXau3nx+p5O1x0KpgzK2Gh8/fBkTl73tiuiI0HaL2grJ8UoYJZL4kQ8=
X-Received: by 2002:ab0:20a:: with SMTP id 10mr17657344uas.19.1579185617305;
 Thu, 16 Jan 2020 06:40:17 -0800 (PST)
MIME-Version: 1.0
References: <20200108040713.38888-1-yangbo.lu@nxp.com> <20200108040713.38888-2-yangbo.lu@nxp.com>
In-Reply-To: <20200108040713.38888-2-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 15:39:38 +0100
Message-ID: <CAPDyKFqDGv2LJ7eDJYtoP5vgc_EuM_cqawEU5GUW_pJzAOyi=A@mail.gmail.com>
Subject: Re: [v2, 2/2] mmc: sdhci-of-esdhc: fix clock setting for different
 controller versions
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Jan 2020 at 05:08, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> This patch is to fix clock setting code for different controller
> versions. Two of HW changes after vendor version 2.2 are removing
> PEREN/HCKEN/IPGEN bits in system control register, and adding SD
> clock stable bit in present state register. This patch cleans up
> related code too.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes for v2:
>         - Used preferred style for comments.
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 128 +++++++++++++++++++++-----------------
>  1 file changed, 72 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 1110f90..6a58cf9 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -562,32 +562,46 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
>
>  static void esdhc_clock_enable(struct sdhci_host *host, bool enable)
>  {
> -       u32 val;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>         ktime_t timeout;
> +       u32 val, clk_en;
> +
> +       clk_en = ESDHC_CLOCK_SDCLKEN;
> +
> +       /*
> +        * IPGEN/HCKEN/PEREN bits exist on eSDHC whose vendor version
> +        * is 2.2 or lower.
> +        */
> +       if (esdhc->vendor_ver <= VENDOR_V_22)
> +               clk_en |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN |
> +                          ESDHC_CLOCK_PEREN);
>
>         val = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
>
>         if (enable)
> -               val |= ESDHC_CLOCK_SDCLKEN;
> +               val |= clk_en;
>         else
> -               val &= ~ESDHC_CLOCK_SDCLKEN;
> +               val &= ~clk_en;
>
>         sdhci_writel(host, val, ESDHC_SYSTEM_CONTROL);
>
> -       /* Wait max 20 ms */
> +       /*
> +        * Wait max 20 ms. If vendor version is 2.2 or lower, do not
> +        * wait clock stable bit which does not exist.
> +        */
>         timeout = ktime_add_ms(ktime_get(), 20);
> -       val = ESDHC_CLOCK_STABLE;
> -       while  (1) {
> +       while (esdhc->vendor_ver > VENDOR_V_22) {
>                 bool timedout = ktime_after(ktime_get(), timeout);
>
> -               if (sdhci_readl(host, ESDHC_PRSSTAT) & val)
> +               if (sdhci_readl(host, ESDHC_PRSSTAT) & ESDHC_CLOCK_STABLE)
>                         break;
>                 if (timedout) {
>                         pr_err("%s: Internal clock never stabilised.\n",
>                                 mmc_hostname(host->mmc));
>                         break;
>                 }
> -               udelay(10);
> +               usleep_range(10, 20);
>         }
>  }
>
> @@ -621,77 +635,97 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
> -       int pre_div = 1;
> -       int div = 1;
> -       int division;
> +       unsigned int pre_div = 1, div = 1;
> +       unsigned int clock_fixup = 0;
>         ktime_t timeout;
> -       long fixup = 0;
>         u32 temp;
>
> -       host->mmc->actual_clock = 0;
> -
>         if (clock == 0) {
> +               host->mmc->actual_clock = 0;
>                 esdhc_clock_enable(host, false);
>                 return;
>         }
>
> -       /* Workaround to start pre_div at 2 for VNN < VENDOR_V_23 */
> +       /* Start pre_div at 2 for vendor version < 2.3. */
>         if (esdhc->vendor_ver < VENDOR_V_23)
>                 pre_div = 2;
>
> +       /* Fix clock value. */
>         if (host->mmc->card && mmc_card_sd(host->mmc->card) &&
> -               esdhc->clk_fixup && host->mmc->ios.timing == MMC_TIMING_LEGACY)
> -               fixup = esdhc->clk_fixup->sd_dflt_max_clk;
> +           esdhc->clk_fixup && host->mmc->ios.timing == MMC_TIMING_LEGACY)
> +               clock_fixup = esdhc->clk_fixup->sd_dflt_max_clk;
>         else if (esdhc->clk_fixup)
> -               fixup = esdhc->clk_fixup->max_clk[host->mmc->ios.timing];
> -
> -       if (fixup && clock > fixup)
> -               clock = fixup;
> +               clock_fixup = esdhc->clk_fixup->max_clk[host->mmc->ios.timing];
>
> -       temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> -       temp &= ~(ESDHC_CLOCK_SDCLKEN | ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN |
> -                 ESDHC_CLOCK_PEREN | ESDHC_CLOCK_MASK);
> -       sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> +       if (clock_fixup == 0 || clock < clock_fixup)
> +               clock_fixup = clock;
>
> -       while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
> +       /* Calculate pre_div and div. */
> +       while (host->max_clk / pre_div / 16 > clock_fixup && pre_div < 256)
>                 pre_div *= 2;
>
> -       while (host->max_clk / pre_div / div > clock && div < 16)
> +       while (host->max_clk / pre_div / div > clock_fixup && div < 16)
>                 div++;
>
> +       esdhc->div_ratio = pre_div * div;
> +
> +       /* Limit clock division for HS400 200MHz clock for quirk. */
>         if (esdhc->quirk_limited_clk_division &&
>             clock == MMC_HS200_MAX_DTR &&
>             (host->mmc->ios.timing == MMC_TIMING_MMC_HS400 ||
>              host->flags & SDHCI_HS400_TUNING)) {
> -               division = pre_div * div;
> -               if (division <= 4) {
> +               if (esdhc->div_ratio <= 4) {
>                         pre_div = 4;
>                         div = 1;
> -               } else if (division <= 8) {
> +               } else if (esdhc->div_ratio <= 8) {
>                         pre_div = 4;
>                         div = 2;
> -               } else if (division <= 12) {
> +               } else if (esdhc->div_ratio <= 12) {
>                         pre_div = 4;
>                         div = 3;
>                 } else {
>                         pr_warn("%s: using unsupported clock division.\n",
>                                 mmc_hostname(host->mmc));
>                 }
> +               esdhc->div_ratio = pre_div * div;
>         }
>
> +       host->mmc->actual_clock = host->max_clk / esdhc->div_ratio;
> +
>         dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
> -               clock, host->max_clk / pre_div / div);
> -       host->mmc->actual_clock = host->max_clk / pre_div / div;
> -       esdhc->div_ratio = pre_div * div;
> +               clock, host->mmc->actual_clock);
> +
> +       /* Set clock division into register. */
>         pre_div >>= 1;
>         div--;
>
> +       esdhc_clock_enable(host, false);
> +
>         temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> -       temp |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
> -               | (div << ESDHC_DIVIDER_SHIFT)
> -               | (pre_div << ESDHC_PREDIV_SHIFT));
> +       temp &= ~ESDHC_CLOCK_MASK;
> +       temp |= ((div << ESDHC_DIVIDER_SHIFT) |
> +               (pre_div << ESDHC_PREDIV_SHIFT));
>         sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>
> +       /*
> +        * Wait max 20 ms. If vendor version is 2.2 or lower, do not
> +        * wait clock stable bit which does not exist.
> +        */
> +       timeout = ktime_add_ms(ktime_get(), 20);
> +       while (esdhc->vendor_ver > VENDOR_V_22) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               if (sdhci_readl(host, ESDHC_PRSSTAT) & ESDHC_CLOCK_STABLE)
> +                       break;
> +               if (timedout) {
> +                       pr_err("%s: Internal clock never stabilised.\n",
> +                               mmc_hostname(host->mmc));
> +                       break;
> +               }
> +               usleep_range(10, 20);
> +       }
> +
> +       /* Additional setting for HS400. */
>         if (host->mmc->ios.timing == MMC_TIMING_MMC_HS400 &&
>             clock == MMC_HS200_MAX_DTR) {
>                 temp = sdhci_readl(host, ESDHC_TBCTL);
> @@ -711,25 +745,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>                 esdhc_clock_enable(host, false);
>                 esdhc_flush_async_fifo(host);
>         }
> -
> -       /* Wait max 20 ms */
> -       timeout = ktime_add_ms(ktime_get(), 20);
> -       while (1) {
> -               bool timedout = ktime_after(ktime_get(), timeout);
> -
> -               if (sdhci_readl(host, ESDHC_PRSSTAT) & ESDHC_CLOCK_STABLE)
> -                       break;
> -               if (timedout) {
> -                       pr_err("%s: Internal clock never stabilised.\n",
> -                               mmc_hostname(host->mmc));
> -                       return;
> -               }
> -               udelay(10);
> -       }
> -
> -       temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> -       temp |= ESDHC_CLOCK_SDCLKEN;
> -       sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> +       esdhc_clock_enable(host, false);
>  }
>
>  static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
> --
> 2.7.4
>
