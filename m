Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5420C636D4
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 23:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBMXss (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBMXsq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 18:48:46 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A32126C7
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:48:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o13so13491782pjg.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FkCNeSORsYc6WFEKacYRX0wbC50Zcx5IER4XSSJlizc=;
        b=zn9CuSmE+S0LORJdl4CiBNFT0k6mOJuY0zchBywp0mpgL8KUtyYteZVGNkTDPr95lg
         TYNa3zJXwPGJIANEUJNLFWdmNpKpEs/+K6N0yenRkD3p46VDJvt2FKAO5uZJi49XoBCV
         82w7VA6pqgX8EOFeGN9peWJw/7XuLDCpdZzY3vFMjWTLgnrf4GRWUSErw90hWa29VH7J
         +B3VFJvt6ZyYG3Wq8bClfuDqi1FiBPQwXSPuYO7nFCShhOkrejrxAk2/VIfro6yfAJUd
         TQhR4FTAe4A70U8TrNgnRQ/LwRycH4Fq0sAqzVjoy6HxqQ2hebPsA7DS0JTJapEUivrB
         RV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkCNeSORsYc6WFEKacYRX0wbC50Zcx5IER4XSSJlizc=;
        b=upcG7KBEHwbBtDWET2OA7VO8gyxqjpcnoo4g8UczZdFVmRWgAfYaB4rywyd21Uyj7Q
         RzE37p/KRPGoC1BjdRIqzatpyjxJbV6Q/4ROJHv81IhAp/cVaJI/w+agFaqr9DY8UId9
         bCie7x91hlnRwHTxFYdgJkG2c05Y0wC8fX0xc9i5B6C+UIj4G14F9uRC7IykigZh3M5d
         uTHzt4qB20eMKxwgmQqlrDvK4dgUrJ7D6jyRSBKNtUFPlES2n63x5nEKlFFAOxbc6qVI
         1OI0wtfhr8SKzCxK01J5oCtK10EPoRhvUoJu0DUYDUJ0oqVZ/rhRyzRx3FA+seCHYg4M
         KMRw==
X-Gm-Message-State: AO0yUKVTKQOB5FrdFIAD1DtL4OUBDHkzKDXpAj6ioxh2dE9S+d02YJ82
        07hqGVNqHn7DzynFUqcaD+zMs6ZcrORDKO7GCfyP2Q==
X-Google-Smtp-Source: AK7set+ggBheB870d5LQZGZTGJQLon97bf4lGwg6a4C2/lc+oOwoASXu6j4Em8IAhVkXjl0iO379e4cbxDOxdh7fuGw=
X-Received: by 2002:a17:903:2341:b0:19a:9ba6:6526 with SMTP id
 c1-20020a170903234100b0019a9ba66526mr203311plh.2.1676332125406; Mon, 13 Feb
 2023 15:48:45 -0800 (PST)
MIME-Version: 1.0
References: <816cba9f-ff92-31a2-60f0-aca542d1d13e@gmail.com>
In-Reply-To: <816cba9f-ff92-31a2-60f0-aca542d1d13e@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 00:48:08 +0100
Message-ID: <CAPDyKFp_wK6Wyw5=hPEBf-Pgv=G2sK6uuD7ikVt0OBZLDWvSXg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] mmc: meson-gx: fix SDIO mode if cap_sdio_irq
 isn't set
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Geraldo Nascimento <geraldogabriel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Feb 2023 at 21:55, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Some SDIO WiFi modules stopped working after SDIO interrupt mode
> was added if cap_sdio_irq isn't set in device tree. This patch was
> confirmed to fix the issue.
>
> Fixes: 066ecde6d826 ("mmc: meson-gx: add SDIO interrupt support")
> Reported-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> Tested-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v2:
> - fix printf type issue
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 6e5ea0213..5c94ad466 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -435,7 +435,8 @@ static int meson_mmc_clk_init(struct meson_host *host)
>         clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
>         clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
>         clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
> -       clk_reg |= CLK_IRQ_SDIO_SLEEP(host);
> +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> +               clk_reg |= CLK_IRQ_SDIO_SLEEP(host);
>         writel(clk_reg, host->regs + SD_EMMC_CLOCK);
>
>         /* get the mux parents */
> @@ -948,16 +949,18 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>  {
>         struct meson_host *host = dev_id;
>         struct mmc_command *cmd;
> -       u32 status, raw_status;
> +       u32 status, raw_status, irq_mask = IRQ_EN_MASK;
>         irqreturn_t ret = IRQ_NONE;
>
> +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> +               irq_mask |= IRQ_SDIO;
>         raw_status = readl(host->regs + SD_EMMC_STATUS);
> -       status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
> +       status = raw_status & irq_mask;
>
>         if (!status) {
>                 dev_dbg(host->dev,
> -                       "Unexpected IRQ! irq_en 0x%08lx - status 0x%08x\n",
> -                        IRQ_EN_MASK | IRQ_SDIO, raw_status);
> +                       "Unexpected IRQ! irq_en 0x%08x - status 0x%08x\n",
> +                        irq_mask, raw_status);
>                 return IRQ_NONE;
>         }
>
> @@ -1204,6 +1207,11 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                 goto free_host;
>         }
>
> +       mmc->caps |= MMC_CAP_CMD23;
> +
> +       if (mmc->caps & MMC_CAP_SDIO_IRQ)
> +               mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
> +
>         host->data = (struct meson_mmc_data *)
>                 of_device_get_match_data(&pdev->dev);
>         if (!host->data) {
> @@ -1277,11 +1285,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
>
>         spin_lock_init(&host->lock);
>
> -       mmc->caps |= MMC_CAP_CMD23;
> -
> -       if (mmc->caps & MMC_CAP_SDIO_IRQ)
> -               mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
> -
>         if (host->dram_access_quirk) {
>                 /* Limit segments to 1 due to low available sram memory */
>                 mmc->max_segs = 1;
> --
> 2.39.1
>
