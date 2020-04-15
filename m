Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EAEC38A29
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 13:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7D02074F
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 13:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIExNdQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636294AbgDONxJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636288AbgDONxD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 09:53:03 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B03AC061A0F
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 06:53:02 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id v24so1343384uak.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHCUmJWsRphTQMxaENNbdAQ8mZO1bmk/JQwg7pzXYLk=;
        b=uIExNdQ4eDHgkQSNrY2fvgEh4hIXIPfyBx05C2VaK7xb/YrRcn1YgAHbfBdK7HEzgL
         LWazJ52HdKrYzPt6XMonzGT+zun68O0e2LUVAfsm79XhBwJTMAkoQL0qfJ6iOd7h8Ifi
         3BkedvS0sV05KnqsEf+BE0BVqQhdeH9tE9rPahco8WIbllYDImHQBZ34rZ8Fx/yW7kfw
         J9/Z/JhsZt0Ax+KV4sap3broTxi0VKtGNNqGwjG0YCDMCkKTU88nsyKHICBnFTXfnB+K
         zV5iiQ67lTBUE1mlAxirZ9dYk+8PN8p03J/lEf5mMSNtjx5gIdPMWtATHxFR63dsazei
         ESUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHCUmJWsRphTQMxaENNbdAQ8mZO1bmk/JQwg7pzXYLk=;
        b=JLMg1MibGEpBGamfN09MmjNOi/h7RDhuXXYEFjDNLMBq45vbU6PtL1E3ZA0xGzYlDZ
         FKC2NjeCAer91RlLeJelPI9JfEFPr8OoUL1TYf84GplsPXZslpfpU9ZgQ6fLFh0fLavr
         c4604yv8hVEmnVS+cEXsg6tcCu1DMiZPMSkyoT2p5oa2J6t4uJwj6+HHX5Pe4p6rpy3S
         VPVpJM1/7RvdkLtHkdpQCvtE3rQ4rZlhR1/KhYNK3i7/baxOXyKOZpKbuOBYwrdOdQiZ
         Bc0S0HGylbpGPfEzNPVjpVuxd9iIcMzzBBXcEIPHMXpByavy1D1BYTkDxZo3/gOvWcI/
         0YKg==
X-Gm-Message-State: AGi0PuYcns6mZuw5CuyVy3nVkqtXoj5x6/wcqEPfjCTW61H4b/M5BTsO
        ymuPCwRqUfH04c9FJvGuROOVaBecc8NkFC+FjqqiYg==
X-Google-Smtp-Source: APiQypJlPUxAUVcS2Scuc0G1A/D2knhA4TkV69Lh4+yTab+NixEnEzyNFUa1TwukmoylyxfV8hDoGYzeZywcp7jKtqU=
X-Received: by 2002:ab0:6204:: with SMTP id m4mr4601656uao.15.1586958781042;
 Wed, 15 Apr 2020 06:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org> <1586353607-32222-14-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1586353607-32222-14-git-send-email-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 15:52:25 +0200
Message-ID: <CAPDyKFrOFOLCWHu8nE4i5t=d+Ei-kcJ15_42Ft3ROSUDe5jkpw@mail.gmail.com>
Subject: Re: [PATCH 13/21] mmc: sdhci-msm: Use OPP API to set clk/perf state
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pradeep P V K <ppvk@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Apr 2020 at 15:48, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> On some qualcomm SoCs we need to vote on a performance state of a power
> domain depending on the clock rates. Hence move to using OPP api to set
> the clock rate and performance state specified in the OPP table.
> On platforms without an OPP table, dev_pm_opp_set_rate() is eqvivalent to
> clk_set_rate()
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pradeep P V K <ppvk@codeaurora.org>
> Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Cc: Subhash Jadavani <subhashj@codeaurora.org>
> Cc: linux-mmc@vger.kernel.org

This looks good to me!

However, are there any of the other patches in the series that
$subject patch depends on - or can I apply this as a standalone mmc
patch?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 09ff731..d82075a 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -10,6 +10,7 @@
>  #include <linux/delay.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_opp.h>
>  #include <linux/slab.h>
>  #include <linux/iopoll.h>
>  #include <linux/regulator/consumer.h>
> @@ -242,6 +243,7 @@ struct sdhci_msm_host {
>         struct clk *xo_clk;     /* TCXO clk needed for FLL feature of cm_dll*/
>         struct clk_bulk_data bulk_clks[4]; /* core, iface, cal, sleep clocks */
>         unsigned long clk_rate;
> +       struct opp_table *opp;
>         struct mmc_host *mmc;
>         bool use_14lpp_dll_reset;
>         bool tuning_done;
> @@ -332,7 +334,7 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
>         int rc;
>
>         clock = msm_get_clock_rate_for_bus_mode(host, clock);
> -       rc = clk_set_rate(core_clk, clock);
> +       rc = dev_pm_opp_set_rate(mmc_dev(host->mmc), clock);
>         if (rc) {
>                 pr_err("%s: Failed to set clock at rate %u at timing %d\n",
>                        mmc_hostname(host->mmc), clock,
> @@ -1963,7 +1965,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         msm_host->bulk_clks[0].clk = clk;
>
>         /* Vote for maximum clock rate for maximum performance */
> -       ret = clk_set_rate(clk, INT_MAX);
> +       ret = dev_pm_opp_set_rate(&pdev->dev, INT_MAX);
>         if (ret)
>                 dev_warn(&pdev->dev, "core clock boost failed\n");
>
> @@ -2087,6 +2089,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>                 goto clk_disable;
>         }
>
> +       msm_host->opp = dev_pm_opp_set_clkname(&pdev->dev, "core");
> +       dev_pm_opp_of_add_table(&pdev->dev);
> +
>         pm_runtime_get_noresume(&pdev->dev);
>         pm_runtime_set_active(&pdev->dev);
>         pm_runtime_enable(&pdev->dev);
> @@ -2109,10 +2114,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         return 0;
>
>  pm_runtime_disable:
> +       dev_pm_opp_of_remove_table(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
>  clk_disable:
> +       dev_pm_opp_set_rate(&pdev->dev, 0);
>         clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>                                    msm_host->bulk_clks);
>  bus_clk_disable:
> @@ -2133,10 +2140,12 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>
>         sdhci_remove_host(host, dead);
>
> +       dev_pm_opp_of_remove_table(&pdev->dev);
>         pm_runtime_get_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
>
> +       dev_pm_opp_set_rate(&pdev->dev, 0);
>         clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>                                    msm_host->bulk_clks);
>         if (!IS_ERR(msm_host->bus_clk))
> @@ -2151,6 +2160,7 @@ static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>
> +       dev_pm_opp_set_rate(dev, 0);
>         clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>                                    msm_host->bulk_clks);
>
> @@ -2173,9 +2183,11 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>          * restore the SDR DLL settings when the clock is ungated.
>          */
>         if (msm_host->restore_dll_config && msm_host->clk_rate)
> -               return sdhci_msm_restore_sdr_dll_config(host);
> +               ret = sdhci_msm_restore_sdr_dll_config(host);
>
> -       return 0;
> +       dev_pm_opp_set_rate(dev, msm_host->clk_rate);
> +
> +       return ret;
>  }
>
>  static const struct dev_pm_ops sdhci_msm_pm_ops = {
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
