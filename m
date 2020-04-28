Return-Path: <SRS0=tofm=6M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A567BC8300A
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Apr 2020 18:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A8E20B80
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Apr 2020 18:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMOR3eMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgD1SaQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729459AbgD1SaP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Apr 2020 14:30:15 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28788C03C1AD
        for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2020 11:30:15 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id g35so10818346uad.0
        for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2020 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXMg95AozC5ju4vKrdTrkYzrsPUBTLw6GqQWj9wwSg8=;
        b=BMOR3eMSjaDO+gIF05mqIQqam13R+jGBmNymq3jZoK2dxuYu0k0lfMbTri71OPUeg+
         nOm7JCs5UGgb8RbAbZVh57RtL73K6pOtg4bfa6abk1zifMglkXSY4sHFy8Nj5nfsL3Ad
         dq4ixCiwxQPtrHIlKhKxJv/yYOmOLo+/3SvhMtbny8ghN3Yuz+VIlDubVGUfLXzRSnkm
         4f8qdAol1fBSCGJCWs0SrvVkjELl0tFaqPgwtaB6KB0y4p4G4e0dnfHEFfAGKDVQusYv
         z1y6QRs6X0ce0WGJHccaWZVslvJG1pAy/ou+ybIzy1ImNfYw7qsdTrmvqtgfLJTfPwEo
         srfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXMg95AozC5ju4vKrdTrkYzrsPUBTLw6GqQWj9wwSg8=;
        b=DQqwodrTNhjwOCAHgVrCZDmTPbwLOPQ0npQ696IitOwDYkplm0ej804UYYWj+FZt6l
         b5THStN54vaYMYXuV28TUZdmXiUpsC99iTMOgDq/kbI/noQolxGk2XLWMGynOpJlP7a9
         zUfTdkItqmzgkgijkZwJTcgfzscivEBF6rPj2y3PFimr1OTdTXATAKTLLZSMNuTFvvix
         WOsHyY0t+pT/Vf+Qagr31tgzaNEw33tRmnP4AuGARedF6ZZhrfGppd/YMV1QgfJV0W7/
         e3bW+GMRabga+/NEsOoK5PP5YPtKxx1mwbOiH1i8x7n4+IdgvC4lxBMAypynVE0NkPaq
         YmTg==
X-Gm-Message-State: AGi0PuZk0y6ZXU9KKwsYb3A41i8ex4Y8ES3GWkVb0fmUr76ub/TAUznM
        qdwKJps2ap8eKBuDQUcIUvMnJjYzK5f/F8epDcgMSg==
X-Google-Smtp-Source: APiQypLsMma60/04KmAJl8+He2niHeX0v3cUqZD1z9G1U33bvEUR66gRv6EtELS7Q+EmnzF1YJxBkDklwYv88PqRhtM=
X-Received: by 2002:ab0:6588:: with SMTP id v8mr23216205uam.100.1588098614071;
 Tue, 28 Apr 2020 11:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org> <1588080785-6812-10-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1588080785-6812-10-git-send-email-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Apr 2020 20:29:38 +0200
Message-ID: <CAPDyKFrGQvcCB1wfv=iqk66uja3faMRF1gGMSE2VhB8gJcO=sg@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] mmc: sdhci-msm: Fix error handling for dev_pm_opp_of_add_table()
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pradeep P V K <ppvk@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 28 Apr 2020 at 15:39, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Even though specifying OPP's in device tree is optional, ignoring all errors
> reported by dev_pm_opp_of_add_table() means we can't distinguish between a
> missing OPP table and a wrong/buggy OPP table. While missing OPP table
> (dev_pm_opp_of_add_table() returns a -ENODEV in such case) can be ignored,
> a wrong/buggy OPP table in device tree should make the driver error out.
>
> while we fix that, lets also fix the variable names for opp/opp_table to
> avoid confusion and name them opp_table/has_opp_table instead.
>
> Suggested-by: Matthias Kaehlcke <matthias@chromium.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pradeep P V K <ppvk@codeaurora.org>
> Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Cc: linux-mmc@vger.kernel.org

Is this a standalone patch that I queue up via my mmc tree?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 8a055dd..97758fa 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -244,8 +244,8 @@ struct sdhci_msm_host {
>         struct clk_bulk_data bulk_clks[4]; /* core, iface, cal, sleep clocks */
>         unsigned long clk_rate;
>         struct mmc_host *mmc;
> -       struct opp_table *opp;
> -       bool opp_table;
> +       struct opp_table *opp_table;
> +       bool has_opp_table;
>         bool use_14lpp_dll_reset;
>         bool tuning_done;
>         bool calibration_done;
> @@ -1967,15 +1967,20 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         }
>         msm_host->bulk_clks[0].clk = clk;
>
> -       msm_host->opp = dev_pm_opp_set_clkname(&pdev->dev, "core");
> -       if (IS_ERR(msm_host->opp)) {
> -               ret = PTR_ERR(msm_host->opp);
> +       msm_host->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
> +       if (IS_ERR(msm_host->opp_table)) {
> +               ret = PTR_ERR(msm_host->opp_table);
>                 goto bus_clk_disable;
>         }
>
>         /* OPP table is optional */
> -       if (!dev_pm_opp_of_add_table(&pdev->dev))
> -               msm_host->opp_table = true;
> +       ret = dev_pm_opp_of_add_table(&pdev->dev);
> +       if (!ret) {
> +               msm_host->has_opp_table = true;
> +       } else if (ret != -ENODEV) {
> +               dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
> +               goto opp_cleanup;
> +       }
>
>         /* Vote for maximum clock rate for maximum performance */
>         ret = dev_pm_opp_set_rate(&pdev->dev, INT_MAX);
> @@ -2133,9 +2138,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>                                    msm_host->bulk_clks);
>  opp_cleanup:
> -       if (msm_host->opp_table)
> +       if (msm_host->has_opp_table)
>                 dev_pm_opp_of_remove_table(&pdev->dev);
> -       dev_pm_opp_put_clkname(msm_host->opp);
> +       dev_pm_opp_put_clkname(msm_host->opp_table);
>  bus_clk_disable:
>         if (!IS_ERR(msm_host->bus_clk))
>                 clk_disable_unprepare(msm_host->bus_clk);
> @@ -2154,9 +2159,9 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>
>         sdhci_remove_host(host, dead);
>
> -       if (msm_host->opp_table)
> +       if (msm_host->has_opp_table)
>                 dev_pm_opp_of_remove_table(&pdev->dev);
> -       dev_pm_opp_put_clkname(msm_host->opp);
> +       dev_pm_opp_put_clkname(msm_host->opp_table);
>         pm_runtime_get_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
