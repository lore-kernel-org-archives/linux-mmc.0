Return-Path: <SRS0=N8Xy=7R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB963C433DF
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 17:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1303206DC
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 17:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pp9oePz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgFDRJN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbgFDRJL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2020 13:09:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A67C08C5C4
        for <linux-mmc@vger.kernel.org>; Thu,  4 Jun 2020 10:09:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b16so3523832pfi.13
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2020 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vTStGj95ld9u7qkUYgU+8qXianN1IvrWD90jNTWUG9A=;
        b=Pp9oePz0iDeW5lK/UVyrG268kmsnptbgxA6fex7JANQGQupPY4LTPKk8NlJSjKAEXg
         MBJxHq+MIzP8rMGcq4X0bD3g3XJT/wzB0Vdv0PA3h9Tqc9+sJi1JwWAtYO+IdoTzROrQ
         Zd4zBPqauS3iobpGI1XpZUmAAfWqDbG2vd8/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vTStGj95ld9u7qkUYgU+8qXianN1IvrWD90jNTWUG9A=;
        b=Z+HSjP8QxlK9nVBJ9NhEgOU6FDollE4SN0whpMD4yZntnBxxtnud+7iDLGt63Qgk90
         KuWLg+qMd93plBy23FincFefnBUjchDlfLn9Vxn8G7xoiB1cjyfOHu1zeIF33T1zdtj2
         /EN88Z5A0kKShGGH4NHIcxoZzQ66v1ts8ayqSmEJqNTTilzTuNJXDmjB8INt/lKu7Kzx
         Tx/Yr8cyJII4/E5fk20r2tvMAQah5em8y3PiwpN2qAR0+UgKTqhyOVraIZQCY1dPsHzb
         B2UcqOxIEyFWZU0SVmfBOedEmFT2vA7DX01gij45laZjF10/CtgeyHpY3OvRb3fN/xi9
         948w==
X-Gm-Message-State: AOAM533cThoBHiIq3gWIjWALLX62ATA+0DfobfKIq6TIONqsZU+wd+91
        eIuM0XOqH4yJy36w6phOIYLaWg==
X-Google-Smtp-Source: ABdhPJx2MzNkKVrT8WwTQAmXK4to6UBM/aaS1nLNNdsJTBm3DlU6iQH70iEPakIl6HD11i64VyfOrg==
X-Received: by 2002:a62:8cc7:: with SMTP id m190mr1386879pfd.174.1591290549416;
        Thu, 04 Jun 2020 10:09:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id q201sm4970443pfq.40.2020.06.04.10.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 10:09:08 -0700 (PDT)
Date:   Thu, 4 Jun 2020 10:09:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc-owner@vger.kernel.org,
        rnayak@codeaurora.org, sibis@codeaurora.org, matthias@chromium.org
Subject: Re: [PATCH V2 1/2] mmc: sdhci-msm: Add interconnect bandwidth
 scaling support
Message-ID: <20200604170906.GP4525@google.com>
References: <1591269283-24084-1-git-send-email-ppvk@codeaurora.org>
 <1591269283-24084-2-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1591269283-24084-2-git-send-email-ppvk@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jun 04, 2020 at 04:44:42PM +0530, Pradeep P V K wrote:
> Interconnect bandwidth scaling support is now added as a
> part of OPP [1]. So, make sure interconnect driver is ready
> before handling interconnect scaling.
> 
> This change is based on
> [1] [Patch v8] Introduce OPP bandwidth bindings
> (https://lkml.org/lkml/2020/5/12/493)
> 
> [2] [Patch v3] mmc: sdhci-msm: Fix error handling
> for dev_pm_opp_of_add_table()
> (https://lkml.org/lkml/2020/5/5/491)
> 
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index b277dd7..a13ff1b 100644
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
> @@ -2070,6 +2071,18 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	}
>  	msm_host->bulk_clks[0].clk = clk;
>  
> +	/* Make sure that ICC driver is ready for interconnect bandwdith
> +	 * scaling before registering the device for OPP.
> +	 */
> +	ret = dev_pm_opp_of_find_icc_paths(&pdev->dev, NULL);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			dev_info(&pdev->dev, "defer icc path: %d\n", ret);

I already commented on this on v1:

  This log seems to add little more than noise, or are there particular reasons
  why it is useful in this driver? Most drivers just return silently in case of
  deferred probing.

If you think the log is really needed please explain why.
