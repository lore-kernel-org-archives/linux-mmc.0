Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A10C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 11:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiK1LNn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Nov 2022 06:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiK1LNl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2022 06:13:41 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA3CE8B
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 03:13:39 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id l7so7634762pfl.7
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 03:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DkTWJOPMKJTcB+//bxFTghoIW5IcnXsOzZ4Es55yj4k=;
        b=I8sap03Y5jnqxS/AfTrHwFMsBnhWgReEqDiF1EXtJiIbpc5kZOIMtOLMfK3ruRNATp
         ZlhgyYXseT7TuKs41T3DhaTnyzGxIopEInhL4JgDQvZ029JGeQ3YCIb2nAIcgS06vtpK
         dFCmtWKZGMjJMKx7S43iecuC1E6g10q/UiFbkkzuRqQJSfUcp9O57WMb8/7Rb1TzTJCQ
         vlmXk51+cbL2SChwCrJJ/Y3zs1E96/XNFPzt3SDA3eix01Y1i1QUXE4utm9USEiB/U0u
         O+X/3WRT9Ht7mOEdp6A1Rarp5f1vnni5sdo+hyMf1PjkHrN0e+Q68rVl59gC1C2sHbZn
         GihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkTWJOPMKJTcB+//bxFTghoIW5IcnXsOzZ4Es55yj4k=;
        b=HVKI6HJBgxMKEenrDU+FMjzKLH7SITTKg2tuu6UxnW14jJhyoy8/+1NhFReKE5wW5D
         ItbYHP9dI2JY+dixVirBtWicyCWWu1LVJSkDmJHuCmZ9IssWoaMiN18VX+/vR8MNTuce
         tKDgh/d9Dfh9aF5QwFAWmpJlGf8sU96J8YZ+ZCU3aosb/Cf0t5jq9jqdWOROW1Ie+toV
         w77jiswwRSidqsi6vuQ/7JON3X09l/3nRmRI4NV4VSFgA56N3oXEG81z0dztEGRCXfxY
         w+D5JT6wejjbmlGBUlss1nNjg0f0fsUWVP18xHyqGplGbVcfswYygX6O018wJ3HWOeLZ
         D2KA==
X-Gm-Message-State: ANoB5pnd5J2VhTqzNlY7Xsh/iVpG0HF6aZVrh37K6Am/vkbUIBVS9sbJ
        B9w9PO5Epi7W17o+ElJH31ryu8Hrgw/BDnLenng=
X-Google-Smtp-Source: AA0mqf7F19D5w/rvIeaaV2OzGsJ+R4Gk44iwYuNsvqaA9SnNC/bJrf0+fGpdzPUaNjLaxUQa7D5NCLjqjlCmoH+YGT8=
X-Received: by 2002:a62:ed03:0:b0:558:99cc:8b40 with SMTP id
 u3-20020a62ed03000000b0055899cc8b40mr31069191pfh.25.1669634019348; Mon, 28
 Nov 2022 03:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20221124170649.63851-1-adrian.hunter@intel.com> <20221124170649.63851-2-adrian.hunter@intel.com>
In-Reply-To: <20221124170649.63851-2-adrian.hunter@intel.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Mon, 28 Nov 2022 19:13:28 +0800
Message-ID: <CA+Da2qxaKM4z7dtAyfzEGU74UJdPRdRnbJ2Q42-9wGzAi4p-sw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdhci: Fix voltage switch delay
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Nov 25, 2022 at 1:12 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Commit 20b92a30b561 ("mmc: sdhci: update signal voltage switch code")
> removed voltage switch delays from sdhci because mmc core had been
> enhanced to support them. However that assumed that sdhci_set_ios()
> did a single clock change, which it did not, and so the delays in mmc
> core, which should have come after the first clock change, were not
> effective.
>
> Fix by avoiding re-configuring UHS and preset settings when the clock
> is turning on and the settings have not changed. That then also avoids
> the associated clock changes, so that then sdhci_set_ios() does a single
> clock change when voltage switching, and the mmc core delays become
> effective.
>
> To do that has meant keeping track of driver strength (host->drv_type),
> and cases of reinitialization (host->reinit_uhs).
>
> Note also, the 'turning_on_clk' restriction should not be necessary
> but is done to minimize the impact of the change on stable kernels.
>
> Fixes: 20b92a30b561 ("mmc: sdhci: update signal voltage switch code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci.c | 51 ++++++++++++++++++++++++++++++++++------
>  drivers/mmc/host/sdhci.h |  2 ++
>  2 files changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2108e8075609..351b09b90d76 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -373,6 +373,7 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>         if (soft) {
>                 /* force clock reconfiguration */
>                 host->clock = 0;
> +               host->reinit_uhs = true;
>                 mmc->ops->set_ios(mmc, &mmc->ios);
>         }
>  }
> @@ -2279,11 +2280,35 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
>
> +static bool sdhci_timing_has_preset(unsigned char timing)
> +{
> +       switch (timing) {
> +       case MMC_TIMING_UHS_SDR12:
> +       case MMC_TIMING_UHS_SDR25:
> +       case MMC_TIMING_UHS_SDR50:
> +       case MMC_TIMING_UHS_SDR104:
> +       case MMC_TIMING_UHS_DDR50:
> +       case MMC_TIMING_MMC_DDR52:
> +               return true;
> +       };
> +       return false;
> +}
> +
> +static bool sdhci_preset_needed(struct sdhci_host *host, unsigned char timing)
> +{
> +       return !(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
> +              sdhci_timing_has_preset(timing);
> +}
> +
>  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
> +       bool reinit_uhs = host->reinit_uhs;
> +       bool turning_on_clk = false;
>         u8 ctrl;
>
> +       host->reinit_uhs = false;
> +
>         if (ios->power_mode == MMC_POWER_UNDEFINED)
>                 return;
>
> @@ -2309,6 +2334,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 sdhci_enable_preset_value(host, false);
>
>         if (!ios->clock || ios->clock != host->clock) {
> +               turning_on_clk = ios->clock && !host->clock;
> +
>                 host->ops->set_clock(host, ios->clock);
>                 host->clock = ios->clock;
>
> @@ -2335,6 +2362,18 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         host->ops->set_bus_width(host, ios->bus_width);
>
> +       /*
> +        * Special case to avoid multiple clock changes during voltage
> +        * switching.
> +        */
> +       if (!reinit_uhs &&
> +           turning_on_clk &&
> +           host->timing == ios->timing &&
> +           host->version >= SDHCI_SPEC_300 &&
> +           (host->preset_enabled || host->drv_type == ios->drv_type) &&
> +           (host->preset_enabled || !sdhci_preset_needed(host, ios->timing)))
> +               return;
> +
>         ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>
>         if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
> @@ -2378,6 +2417,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                         }
>
>                         sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +                       host->drv_type = ios->drv_type;
>                 } else {
>                         /*
>                          * According to SDHC Spec v3.00, if the Preset Value
> @@ -2405,19 +2445,14 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 host->ops->set_uhs_signaling(host, ios->timing);
>                 host->timing = ios->timing;
>
> -               if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
> -                               ((ios->timing == MMC_TIMING_UHS_SDR12) ||
> -                                (ios->timing == MMC_TIMING_UHS_SDR25) ||
> -                                (ios->timing == MMC_TIMING_UHS_SDR50) ||
> -                                (ios->timing == MMC_TIMING_UHS_SDR104) ||
> -                                (ios->timing == MMC_TIMING_UHS_DDR50) ||
> -                                (ios->timing == MMC_TIMING_MMC_DDR52))) {
> +               if (sdhci_preset_needed(host, ios->timing)) {
>                         u16 preset;
>
>                         sdhci_enable_preset_value(host, true);
>                         preset = sdhci_get_preset_value(host);
>                         ios->drv_type = FIELD_GET(SDHCI_PRESET_DRV_MASK,
>                                                   preset);
> +                       host->drv_type = ios->drv_type;
>                 }
>
>                 /* Re-enable SD Clock */
> @@ -3754,6 +3789,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>                 sdhci_init(host, 0);
>                 host->pwr = 0;
>                 host->clock = 0;
> +               host->reinit_uhs = true;
>                 mmc->ops->set_ios(mmc, &mmc->ios);
>         } else {
>                 sdhci_init(host, (mmc->pm_flags & MMC_PM_KEEP_POWER));
> @@ -3816,6 +3852,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
>                 /* Force clock and power re-program */
>                 host->pwr = 0;
>                 host->clock = 0;
> +               host->reinit_uhs = true;
>                 mmc->ops->start_signal_voltage_switch(mmc, &mmc->ios);
>                 mmc->ops->set_ios(mmc, &mmc->ios);
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 908da47ac5ba..b6f31a7d6152 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -524,6 +524,8 @@ struct sdhci_host {
>
>         unsigned int clock;     /* Current clock (MHz) */
>         u8 pwr;                 /* Current voltage */
> +       u8 drv_type;            /* Current UHS-I driver type */
> +       bool reinit_uhs;        /* Force UHS-related re-initialization */
>
>         bool runtime_suspended; /* Host is runtime suspended */
>         bool bus_on;            /* Bus power prevents runtime suspend */
> --
> 2.34.1
>
Hi Adrian
If the return value is -EAGAIN, host->reinit_uhs has been set to
false, will it affect trying to initialize?
int mmc_host_set_uhs_voltage(struct mmc_host *host)
{
u32 clock;

/*
* During a signal voltage level switch, the clock must be gated
* for 5 ms according to the SD spec
*/
clock = host->ios.clock;
host->ios.clock = 0;
mmc_set_ios(host);

if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180))
return -EAGAIN;    //<======= If returned here.

/* Keep clock gated for at least 10 ms, though spec only says 5 ms */
mmc_delay(10);
host->ios.clock = clock;
mmc_set_ios(host);

return 0;
}

static int mmc_sd_init_card(struct mmc_host *host, u32 ocr, struct
mmc_card *oldcard) {
...
retry:
...
    host->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
if (mmc_host_set_uhs_voltage(host) ||
    mmc_sd_init_uhs_card(card)) {
...
}
