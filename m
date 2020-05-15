Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F3AC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 02:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4F720748
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 02:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589511050;
	bh=RzJEhITZbWZpNq+mY9foajRd7R6ugOd0UfGm2M8BNsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hEuY7q+TUdfheS3HPmSTHoCYNBobBtVojSu8VsKseGvPm+aQXADJ+T0Apvd6LZ0hd
	 bWsYqm1WtEtqxDVtA2WXSno4EJSHjv3+KOc9AASis4qokfv7frx0L2Wekfw/sd2c1z
	 gmwErtIBC4ci5Yj3NnDvb7cjt9KhqMmwkL2Ea44U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgEOCuu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 May 2020 22:50:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39987 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgEOCut (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2020 22:50:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id d26so779867otc.7;
        Thu, 14 May 2020 19:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ozglBc+sLmCi94fyi9hM4nMjLfjck0uiAKDPMtJ/ktQ=;
        b=ECr0/UAyKyFFDJ2ku3XmPI+IYNoD1zjVfsHkXTU2ANlRVHZ7cWvSfbHLwLqLA5cUjY
         vKdcBSdLDbpY2qiojfBzO5Jvu6FcYhDmwPi6YOpUlgIo9wJ8RJcSr6F4p9T0QKAalWob
         yFpd0XwOpIHnTRoZqAS1QQR70nfhZ98klOnUFf4FILfn4QKiiXxStBtctn+rmTQ8lHcj
         H34xjdQA/aAV5Kp1CmtaO6INa3715cnwGMFGg6/pBpMKygs1vVSDQU1kJNyLNbx03cvD
         ZiomcyYOdIdjCexPmshbyprfnu1HfHe+RAqg6O+s9x8975NhwsrVGv40zE1v15kGeLNb
         MPlQ==
X-Gm-Message-State: AOAM531svvF5TG5dhnjmLUyBgVQRJZqOpJbqQbsDQcoj/lkOIRkppxiL
        qvWrbtwzjIaOW0YAyZrW1w==
X-Google-Smtp-Source: ABdhPJyf3I3BEvGznd2LmPlqdpXGJf9rz4M+SJAOYC+ZrQGj/mDBIoUotlVom7IQ3onC2yi+Xbff4w==
X-Received: by 2002:a9d:7414:: with SMTP id n20mr773057otk.61.1589511048634;
        Thu, 14 May 2020 19:50:48 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o17sm237457otp.79.2020.05.14.19.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 19:50:48 -0700 (PDT)
Received: (nullmailer pid 30844 invoked by uid 1000);
        Fri, 15 May 2020 02:50:47 -0000
Date:   Thu, 14 May 2020 21:50:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sarthak Garg <sartgarg@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        vbadigan@codeaurora.org, stummala@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH V1 1/7] dt-bindings: mmc: Add information for DLL
 register properties
Message-ID: <20200515025047.GA27895@bogus>
References: <1588838535-6050-1-git-send-email-sartgarg@codeaurora.org>
 <1588838535-6050-2-git-send-email-sartgarg@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588838535-6050-2-git-send-email-sartgarg@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, May 07, 2020 at 01:32:08PM +0530, Sarthak Garg wrote:
> Add information regarding DLL register properties for getting target
> specific configurations. These DLL register settings may vary from
> target to target.
> 
> Also new compatible string value for sm8250 target.
> 
> Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 5445931..b8e1d2b 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -17,6 +17,7 @@ Required properties:
>  		"qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
>  		"qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
>  		"qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
> +		"qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
>  		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
>  		"qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
>  		"qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
> @@ -46,6 +47,13 @@ Required properties:
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>  
> +- qcom,ddr-config: Certain chipsets and platforms require particular settings
> +	for the DDR_CONFIG register. Use this field to specify the register
> +	value as per the Hardware Programming Guide.
> +
> +- qcom,dll-config: Chipset and Platform specific value. Use this field to
> +	specify the DLL_CONFIG register value as per Hardware Programming Guide.

Board specific or SoC specific? If the latter, imply this from the 
compatible string.
