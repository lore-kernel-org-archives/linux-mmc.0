Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB6DC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Nov 2022 11:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbiKQLHl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Nov 2022 06:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239501AbiKQLHj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2022 06:07:39 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25F2C776
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 03:07:38 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id k22so1447626pfd.3
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 03:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PBTy6d/RjS8lPD0yo/Wdj9yLVWoOYYSyLo6KPxke2Xo=;
        b=TmuqZePgyGhLmzr7tqu87fAhc+MjXhJoSsLPdmMNB3sjBoovGGcID2QVrZRfMc8RQN
         zLoAIg8tGTNqsQ8nEXR75pCjK6nRVXLO55gncwQNskY0Ae9lk1i1PmAUuIpq62czDRxA
         Akyw4s6ipajDiod4tY4q1LtjWkDj0cYZXW8lNdaga8xhKr63lD1F3VJSSz1LIeq2PQU9
         sX845Es8dcHggnJvKGF1fRTInyzCls+/BmqUV7Xyu++gMi+wpej8+iYCBuJrjuK2O32C
         7DDu9/N+KVwY9ksO/aPCKXVrDkImBD7JHW5jBauPkqj2kzCxnlUviCYLynPfOIlL4NWW
         mb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBTy6d/RjS8lPD0yo/Wdj9yLVWoOYYSyLo6KPxke2Xo=;
        b=PHM4Qwohxk+hNZYmspYcosvE+Hh/Rkdk4G1NDVFIZj2cy3uhjsLQYNepCjynjRuWO1
         jBX9Wu2DcAzEYOBEEqzFENiGgRX0kUR6fGFzrlSnT1b5g21STvfp4v5GixwyI5x7vnE9
         A7Ah8U2Rtu9LD0hWHqCYf0rnR/Atqhd/wPVANxvqBQAlY1iHyvZlU+xSbbD1conjbX66
         qaLv/VCjP700fvL7TfmSZTr1fSpqiAlp98Uco8VJ5JVg9DWtM5gwQRHG7/QtEMdDXRHB
         QIdLrbP9xWwbZadY+Y7yixCUkyo2glKhU3CM0p3iObfoDCGMj6jmHMLEgSLreaF0uMaF
         zBfw==
X-Gm-Message-State: ANoB5pmbcdhDWgcQuAM1caDmY9vMH/FSosa4eb6H5I8oyINiE3SMgPFM
        9HDLYYdPUKZQthK1I5At4C0sutXnWNRFScn5UFE1UA==
X-Google-Smtp-Source: AA0mqf6YmWnFKdAlow79QIEg6M0eJh6h88NATW0O0k0R7hagOy/J6l1FQJixnCR7Ecg5f/uxbyyg0VytaYrU6iY7HGI=
X-Received: by 2002:a05:6a00:798:b0:566:9f68:c0ad with SMTP id
 g24-20020a056a00079800b005669f68c0admr2432819pfu.57.1668683258266; Thu, 17
 Nov 2022 03:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20221117094859.20582-1-quic_sartgarg@quicinc.com>
In-Reply-To: <20221117094859.20582-1-quic_sartgarg@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Nov 2022 12:07:01 +0100
Message-ID: <CAPDyKFqLjKOUwbAY5KXWK7g2xcWBQLW09nYoeVCxarfJPGNrTg@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: core: Wait for 1ms after enabling the clocks post
 voltage switch
To:     Sarthak Garg <quic_sartgarg@quicinc.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 17 Nov 2022 at 10:49, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>
> As per spec we should wait for 1ms after providing the SD clock to the
> card again as part of voltage switch sequence but there seems to be a
> violation here. Clocks are getting gated before 1ms as part of
> sdhci_set_ios function where we try to reset SD Clock Enable by
> resetting SDHCI_CLOCK_CARD_EN bit in SDHCI_CLOCK_CONTROL register
> leading to voltage switch failures for specific SD cards.
> Below ftraces also confirms the above understanding :
>
> 9.511367: mmc_host_set_uhs_voltage: mmc1 called
> 9.511369: mmc_set_ios: mmc1: clock 0Hz busmode 2 powermode 2 cs 0
> Vdd 18 width 1 timing 0
> 9.511370: sdhci_set_ios: mmc1 called
> 9.511370: sdhci_set_ios: mmc1 setting clock ios->clock: 0 host->clock:
> 400000
> 9.511372: sdhci_msm_set_clock: mmc1 clock: 0
> 9.511394: sdhci_set_ios: mmc1 gating clocks by writing
> ~SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
> 9.511413: sdhci_msm_set_clock: mmc1 clock: 0
> 9.511423: mmc_set_signal_voltage: mmc1 called
> 9.533816: mmc_set_ios: mmc1: clock 400000Hz busmode 2 powermode 2 cs 0
> Vdd 18 width 1 timing 0
> 9.533820: sdhci_set_ios: mmc1 called
> 9.533822: sdhci_set_ios: mmc1 setting clock ios->clock: 400000
> host->clock: 0
> 9.533826: sdhci_msm_set_clock: mmc1 clock: 400000
> 9.533925: sdhci_enable_clk: mmc1 Enabling clocks by writing
> SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
> 9.533950: sdhci_set_ios: mmc1 gating clocks by writing
> ~SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
> 9.533973: sdhci_msm_set_clock: mmc1 clock: 400000
> 9.534043: sdhci_enable_clk: mmc1 Enabling clocks by writing
> SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
> 9.534045: mmc_host_set_uhs_voltage: mmc1 Done
>
> Wait for 1ms after enabling the clock post voltage switch to make sure
> clock is kept alive for alteast 1ms as per spec.
>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>

I don't know the exact behaviour of sdhci around this, so I will defer
to Adrian's input for that.

However, let me point out that in mmc_set_uhs_voltage() we are trying
to take the 1ms into account. More precisely, after
mmc_host_set_uhs_voltage() has been called to switch the voltage to
1.8V and to re-enable the clock, mmc_set_uhs_voltage() does a
"mmc_delay(1)" and then it calls the ->card_busy() ops to check that
card doesn't signal busy by holding DAT0 low.

I understand that the code in mmc_set_uhs_voltage(), expects the host
to be rather dumb from the HW perspective, which may not always be the
case. Although, I would rather avoid introducing new host flags, along
what you propose in the $subject patch. If this can't be managed in
sdhci, without some new help from the mmc core, I would rather suggest
that we introduce a new host callback that can be used to replace the
entire part in mmc_host_set_uhs_voltage() (or something along those
lines).

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c  | 4 ++++
>  drivers/mmc/host/sdhci.c | 3 +++
>  include/linux/mmc/host.h | 1 +
>  3 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a1efda85c6f2..d63e00aab6cb 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1181,6 +1181,8 @@ int mmc_host_set_uhs_voltage(struct mmc_host *host)
>         host->ios.clock = 0;
>         mmc_set_ios(host);
>
> +       host->doing_signal_voltage_switch = true;
> +
>         if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180))
>                 return -EAGAIN;
>
> @@ -1189,6 +1191,8 @@ int mmc_host_set_uhs_voltage(struct mmc_host *host)
>         host->ios.clock = clock;
>         mmc_set_ios(host);
>
> +       host->doing_signal_voltage_switch = false;
> +
>         return 0;
>  }
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fb6e9a81f198..ac7c254eef4b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2312,6 +2312,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 host->ops->set_clock(host, ios->clock);
>                 host->clock = ios->clock;
>
> +               if (mmc->doing_signal_voltage_switch)
> +                       usleep_range(1000, 1250);
> +
>                 if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
>                     host->clock) {
>                         host->timeout_clk = mmc->actual_clock ?
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 8fdd3cf971a3..06c88cd7a8bf 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -521,6 +521,7 @@ struct mmc_host {
>         bool                    hsq_enabled;
>
>         u32                     err_stats[MMC_ERR_MAX];
> +       bool                    doing_signal_voltage_switch;
>         unsigned long           private[] ____cacheline_aligned;
>  };
>
> --
> 2.17.1
>
