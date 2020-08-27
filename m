Return-Path: <SRS0=bPLn=CF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21738C433E3
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 10:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01ABB207F7
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 10:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLi7Icac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgH0KMi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgH0KMe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2020 06:12:34 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7802BC061233
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 03:12:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x143so3129033pfc.4
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJv+kX0fx+tQS4yK9UoZ8qyQVF+m9p2XpweB7RFLEmo=;
        b=kLi7Icack7lOIO0wq/nfvgRAgBD76TneJHfLt62pddUwAvuIwFGXPrt1RPO8ERlHSo
         jKOKr6Lrr2qByhU+y6ZmL9L813/DyrKinJcgIS7+KnjcL77/HCvBxrD4ZhmPbVAsHVIn
         O5YKdLMrouJ3H29P/pzRpIb4owUvrYRpqQgJlBH3dcSERgXGWf/UyxE4RDoCA2o7w0ad
         Tlu+f6TfGreAJScwgA+LinJxOc2eB9u1t427zGHYB1yHLCdJhS/hDO6U1c7GY4KEl3Xj
         q6I7v/VS9qIH9hk9ODo0rX5fGAxRmbql8etWjJt15uj+qUnmMQ0DDhSxx2ciI6xaVGcp
         lSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJv+kX0fx+tQS4yK9UoZ8qyQVF+m9p2XpweB7RFLEmo=;
        b=Gccagj/9EJnoKtr7Kl7muJBSC/fn2JOd6txWkKk0XHM89Vw299BhGismSDVBrTmb04
         oE5YA725y5p2WYccy6mnvUd7i5euiDyJIyDsBwuguNQosaEdVNFenlTi6CCGHaxbYexy
         eUYrURoxs+AEue7u8RHdob7DM6uOIO/fayOermE4o+X6K8xCVl5gF99s9tKccyWi0Ruh
         7X/QBxOJqcAIkvGAguSX33NwBy0blQoVqkSzqaLO8A+BJog8AOt45seAQScL473t3Mlq
         XVCqx56mD0NPFLMY2VwZy80L9UrI+u+PMS2odukE7O4DTRGjmRJfYpiXZCRDotJpHb5n
         z5Sw==
X-Gm-Message-State: AOAM531oRu9EljTSEKtsDWqjS2L1t4OaoMzXtjMCdQ8SspRogO1yaJT+
        CgZO03Aev2l+yYfU4oI8LfngfA==
X-Google-Smtp-Source: ABdhPJxcA/y5X1Cy7gMI+Ti+jy6KE1Bhf1haAh9otEUPNYOnJ/WNKO1u9FcJcYInXzwj9ZyU8C4HHg==
X-Received: by 2002:a05:6a00:2285:: with SMTP id f5mr15977535pfe.173.1598523153812;
        Thu, 27 Aug 2020 03:12:33 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id fv21sm1717054pjb.16.2020.08.27.03.12.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:12:32 -0700 (PDT)
Date:   Thu, 27 Aug 2020 15:42:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com
Subject: Re: Kernel panic : Unable to handle kernel paging request at virtual
 address - dead address between user and kernel address ranges
Message-ID: <20200827101231.smqrhqu5da6jlz6i@vireshk-i7>
References: <CA+G9fYvUwH2FA9GOeA_7GYpLA31uOmEpg32VKnJ8-d5QSK4PdQ@mail.gmail.com>
 <20200827090813.fjugeqbb47fachy7@vireshk-i7>
 <CAK8P3a2zxybiMDzHXkTsT=VpHJOLkwd1=YTtCNU04vuMjZLkxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2zxybiMDzHXkTsT=VpHJOLkwd1=YTtCNU04vuMjZLkxA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27-08-20, 11:48, Arnd Bergmann wrote:
> > > [    3.680477]  dev_pm_opp_put_clkname+0x30/0x58
> > > [    3.683431]  sdhci_msm_probe+0x284/0x9a0
> 
> dev_pm_opp_put_clkname() is part of the error handling in the
> probe function, so I would deduct there are two problems:
> 
> - something failed during the probe and the driver is trying
>   to unwind
> - the error handling it self is buggy and tries to undo something
>   again that has already been undone.

Right.

> This points to Viresh's
> d05a7238fe1c mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()

I completely forgot that Ulf already pushed this patch and I was
wondering on which of the OPP core changes I wrote have done this :(

> Most likely this is not the entire problem but it uncovered a preexisting
> bug.

I think this is.

Naresh: Can you please test with this diff ?

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b7e47107a31a..401839a97b57 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2286,7 +2286,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
        ret = dev_pm_opp_of_add_table(&pdev->dev);
        if (ret != -ENODEV) {
                dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
-               goto opp_cleanup;
+               goto opp_put_clkname;
        }
 
        /* Vote for maximum clock rate for maximum performance */
@@ -2451,6 +2451,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
                                   msm_host->bulk_clks);
 opp_cleanup:
        dev_pm_opp_of_remove_table(&pdev->dev);
+opp_put_clkname:
        dev_pm_opp_put_clkname(msm_host->opp_table);
 bus_clk_disable:
        if (!IS_ERR(msm_host->bus_clk))

-- 
viresh
