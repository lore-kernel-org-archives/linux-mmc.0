Return-Path: <SRS0=InOK=75=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD1AC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B93208FE
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CoYSUcHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgFPLc4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPLcv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2020 07:32:51 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB5C08C5C3
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:32:50 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id g129so11226878vsc.4
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sot87bVdSsP/TMan7IAvrnTcCMriHtu18eIiUhQ78Qg=;
        b=CoYSUcHNt/515MdFb+hId5Mr7muoIms7ZGnrlq6d/WiCBnGeBKMHVbCXKQBxNNH2T9
         h5JWbF7sLq1SY5iw96WYIUr/8O2Io1HhxohjNCuQ3rEx087b57aVYkyQIAIFNtUiA+cy
         PDTXiHN9LJMQ4ZyIkgE4e/EEnnpN/lXdu8IIGckumZ8oTWoP0ahVuCt8qCWZB8eVugu3
         DKqttflCFH4XqIQDc25lsXZ6m1Y/dsET6LzYgLU4TVFACpqpABVRhmyqRadstioYflHL
         NDL64bWs87bbgAysJz/g0iMDgPjiZxfosMUvC+5ZlqhmaaQHlTIijUOPaqlCifq7LASJ
         KZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sot87bVdSsP/TMan7IAvrnTcCMriHtu18eIiUhQ78Qg=;
        b=ONM5IsCE5Enjcc7TLKywFgKOKgVhHPhYlkq2cxeSzU/7ET7tUULFr/1mvpHRdjiIrG
         E8ROzRl9Y2eRZ4aFJQnRmnWH0AGx0QOVlDZokVQxU2XADNkd20I8tSyzpLvfMWD6J8nk
         H48H34/SD45v+AWJNgH5QajhJ5HvBd8JRj4RNWHbHg89stECoAhKQEzXrmDUOBuKJDRw
         grH2AfGX/bNdIJNTI2IJ1zwIr+2DGj4GvZXe9kyFtzOOxiAp/GfSjKBlLcIfOKgSnZnp
         ywCZtWlz/iT6PB9Z5hSwwfjFU49gc8CQn2byHxsoBXTDIwYBxKLh7ExOgFfk7Fo7zPHe
         0v1A==
X-Gm-Message-State: AOAM532jyI6KigUywa8Ah5JFz4oeWwFuNh43sWPKeoWMo4XfCSUkUEb+
        t+qdpjMxpkCyhRB4xwaj9YgkBbhTrE3U6BotTfXMmw==
X-Google-Smtp-Source: ABdhPJx59T2Wps/nTk8kgN0o8VuzLM1bJSBOfHHK/JljmBTGCoe5QO6mrlabaGH6LSEdZ72YSS9AROzrMGNoviWY6+k=
X-Received: by 2002:a67:903:: with SMTP id 3mr1154481vsj.191.1592307168732;
 Tue, 16 Jun 2020 04:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <1591691846-7578-1-git-send-email-ppvk@codeaurora.org> <1591691846-7578-2-git-send-email-ppvk@codeaurora.org>
In-Reply-To: <1591691846-7578-2-git-send-email-ppvk@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:32:11 +0200
Message-ID: <CAPDyKFpqk7bvv9pWR63maqfxvquQ5QHUq7ACswLj78qmsBkyqQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] mmc: sdhci-msm: Add interconnect bandwidth scaling support
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-mmc-owner@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        matthias@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Jun 2020 at 10:38, Pradeep P V K <ppvk@codeaurora.org> wrote:
>
> Interconnect bandwidth scaling support is now added as a
> part of OPP. So, make sure interconnect driver is ready
> before handling interconnect scaling.
>
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> This change is based on
> [1] [Patch v8] Introduce OPP bandwidth bindings
> (https://lkml.org/lkml/2020/5/12/493)
>
> [2] [Patch v3] mmc: sdhci-msm: Fix error handling
> for dev_pm_opp_of_add_table()
> (https://lkml.org/lkml/2020/5/5/491)
>
>  drivers/mmc/host/sdhci-msm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index b277dd7..15c42b0 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/iopoll.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/interconnect.h>
>
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -2070,6 +2071,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         }
>         msm_host->bulk_clks[0].clk = clk;
>
> +        /* Check for optional interconnect paths */
> +       ret = dev_pm_opp_of_find_icc_paths(&pdev->dev, NULL);
> +       if (ret)
> +               goto bus_clk_disable;
> +
>         msm_host->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
>         if (IS_ERR(msm_host->opp_table)) {
>                 ret = PTR_ERR(msm_host->opp_table);
> --
> 1.9.1
>
