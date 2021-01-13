Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447B1C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 03:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26B423131
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 03:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbhAMDW4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jan 2021 22:22:56 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39250 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbhAMDWz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jan 2021 22:22:55 -0500
Received: by mail-ot1-f47.google.com with SMTP id d8so626149otq.6;
        Tue, 12 Jan 2021 19:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uwsL9FTbsc+Aps2F7O2luTmoMA47O3xHRLZuIayA+lE=;
        b=bM6P5yDQKu9jS12xZhoPivHsQxo4f5Lf86S26h6O+EtqfvolFemap0L6qSaQKbu+oS
         SINKx8ye+TfwlRv5b+C4iwGUZhu1JcaeviuAIXA1Ac3xMVliOjp6pCOJy+fFMlITvsLf
         5BGwmIXAdWJbh2iPK2c6dakPv2T2dBnc3yFK8FBmjfZdfFff6EYn1Nkb7EmgPAELcrw+
         uoMpIY5qtQK7L6sSPjhstBmzhlCHXo2lxe2vcPDebNfSLmPWxnJPeioIWCDecEiBmrSo
         8S6eBiFRuqT3lPYT9H6d8CjmO9iTrR/YGoCMI8L8JYtVHPYLfvY9IQyTv8XPsBbSqgdx
         5DHA==
X-Gm-Message-State: AOAM532kO8sgNaeJt2E5bZ6P3hhempqZRn/c3dVY6+1Isp7oogYP+O6S
        1NuMtpr+5Hcry8EofJv0kQ==
X-Google-Smtp-Source: ABdhPJyD6Bxo1ssdtzEhPiQb8BvrHMnTnthfAoe59bCXez8CHaIv/mz8h8nyWCO9TJ+rt8XKxasBow==
X-Received: by 2002:a9d:4b19:: with SMTP id q25mr11270otf.124.1610508134929;
        Tue, 12 Jan 2021 19:22:14 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e10sm162441otl.38.2021.01.12.19.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:22:14 -0800 (PST)
Received: (nullmailer pid 1467229 invoked by uid 1000);
        Wed, 13 Jan 2021 03:22:13 -0000
Date:   Tue, 12 Jan 2021 21:22:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Document the SDX55
 compatible
Message-ID: <20210113032213.GA1467169@robh.at.kernel.org>
References: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 07 Jan 2021 20:01:17 +0530, Manivannan Sadhasivam wrote:
> The SDHCI controller on SDX55 is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.
> While at it, let's also sort the compatibles in ascending order.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
