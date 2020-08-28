Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA35C433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 08:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E0B2208C9
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 08:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMHU9Aik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgH1IpQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgH1Ior (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 04:44:47 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CCBC061232
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 01:44:46 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a21so196351vsd.3
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 01:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSwGttpO58UNwtKWNF+HN930HSSYOnpc/+bKIQZS/m8=;
        b=iMHU9AikMMYxn9wjsl5wJsIqBY9vBfVrFeLa6kGhKLJwY1KMy7nAhGcTPOfxcsnAQM
         HOQLo8fuQIioyP4A/ZOKHzrbm/9Zc+NIXrrxNfF4my9wymu0SU/OdWqRChcsJYNQChBT
         wi5V636btYgP1WD1SJ9+Rbi1UswjFK4NEiyz2heNMMOqece9ty2xGUlAP94uEEwapP9d
         +ht/ZbC2N599ujNQ1IaY4zq7I9pwedKRVti/nT/qw2dB17psBky+3lhYpBwkFy2FQ88l
         5bEqWtPgVw6g8gaWILC+NfdrpIP+56zBxXzzjZAqqapEkc1cClBgcX7KJCnm93qbjpeC
         tWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSwGttpO58UNwtKWNF+HN930HSSYOnpc/+bKIQZS/m8=;
        b=Yut+m2WjgWb0RFhy+r/yUn4TNwDsyaKecexhSiaaqyMsAlAd6xx8REwqzAho/vSCOJ
         gbWf82ZmUiJxtD75NnNxOyeMAF//UZG3gAupub5ZDqXQmo6zQ5BU8WvfmqsfxLn3rDWT
         6O/N3sIJ4ILn/gHHwVtYdXdpFUsV3VczDpwSaGcVs1ZH2YQTzVqvfaSjpOmMcYDHWJMQ
         VMOLu7Kz3z2uArWa9fu0MIz/TnKrMt41XDlbySVJVmcESLc/YXkahZhXeklMbCQn4zRy
         woKcTDbc+beRpo7vLLfg+DysGNsvYLljlAOX3QxQBPPZ0+cgxQjQWZJGmiMU8vBm+0je
         uBKw==
X-Gm-Message-State: AOAM532EpDykWT8UNYdqTl0ZT+b51fwgUzyiPhLsRTG04hdHVW5/Vu5x
        4COqHGd9Z9grQSiPyiPrrqpfMq0r8f/FF1m5GDgtjA==
X-Google-Smtp-Source: ABdhPJyMTa+YCR54kZRT2NcbU5tNIxtghSNNIBzuFrngPMB9n10lMo1q3cbFPdXVIPo59zok8Er6V4HJCsgKwouWK0A=
X-Received: by 2002:a05:6102:1043:: with SMTP id h3mr66844vsq.60.1598604285942;
 Fri, 28 Aug 2020 01:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200825170015.32285-1-faiz_abbas@ti.com>
In-Reply-To: <20200825170015.32285-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 10:44:09 +0200
Message-ID: <CAPDyKFrvO1fQP0cVkL+UMjxsg5n02Q-ynph9T3yXn4nqY3GG+g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Add workaround for card detect
 debounce timer
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 25 Aug 2020 at 19:00, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> There is a one time delay because of a card detect debounce timer in the
> controller IP. This timer runs as soon as power is applied to the module
> regardless of whether a card is present or not and any writes to
> SDHCI_POWER_ON will return 0 before it expires. This timeout has been
> measured to be about 1 second in am654x and j721e.
>
> Write-and-read-back in a loop on SDHCI_POWER_ON for a maximum of
> 1.5 seconds to make sure that the controller actually powers on.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v2: Use read_poll_timeout() standard macro
>
>  drivers/mmc/host/sdhci_am654.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index f9d24af12396..9a048c80dad4 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -6,6 +6,7 @@
>   *
>   */
>  #include <linux/clk.h>
> +#include <linux/iopoll.h>
>  #include <linux/of.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> @@ -272,9 +273,19 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>         sdhci_set_clock(host, clock);
>  }
>
> +static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
> +{
> +       writeb(val, host->ioaddr + reg);
> +       usleep_range(1000, 10000);
> +       return readb(host->ioaddr + reg);
> +}
> +
> +#define MAX_POWER_ON_TIMEOUT   1500000 /* us */
>  static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>  {
>         unsigned char timing = host->mmc->ios.timing;
> +       u8 pwr;
> +       int ret;
>
>         if (reg == SDHCI_HOST_CONTROL) {
>                 switch (timing) {
> @@ -291,6 +302,19 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>         }
>
>         writeb(val, host->ioaddr + reg);
> +       if (reg == SDHCI_POWER_CONTROL && (val & SDHCI_POWER_ON)) {
> +               /*
> +                * Power on will not happen until the card detect debounce
> +                * timer expires. Wait at least 1.5 seconds for the power on
> +                * bit to be set
> +                */
> +               ret = read_poll_timeout(sdhci_am654_write_power_on, pwr,
> +                                       pwr & SDHCI_POWER_ON, 0,
> +                                       MAX_POWER_ON_TIMEOUT, false, host, val,
> +                                       reg);
> +               if (ret)
> +                       dev_warn(mmc_dev(host->mmc), "Power on failed\n");
> +       }
>  }
>
>  static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
> --
> 2.17.1
>
