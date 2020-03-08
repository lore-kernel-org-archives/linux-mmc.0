Return-Path: <SRS0=e+6W=4Z=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22372C10F29
	for <linux-mmc@archiver.kernel.org>; Sun,  8 Mar 2020 21:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD3420684
	for <linux-mmc@archiver.kernel.org>; Sun,  8 Mar 2020 21:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8i/L3Rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCHVvI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 8 Mar 2020 17:51:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37595 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgCHVvF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Mar 2020 17:51:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id f16so1022559plj.4
        for <linux-mmc@vger.kernel.org>; Sun, 08 Mar 2020 14:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/0umr1qG/qgpEFz5deDRXgTYtCKL5W9w5+Ev+GQb+Dg=;
        b=o8i/L3RzqvaBlnfdNPvNBkov0CbZ1ev3aXO9OELC4EF6fIuiIT+5wosdkaM2+PZ3Fh
         JT/oDPO4SPzaTCp5mhzvVtDl1d8XsQtAdmQP9d3030ErzHH/rZ9O8g6nE7H0X2eQpvQh
         DR5nt4NL35U1p5PBkQE4vOYjrHpltQ4+WUNrEhY0j0TXN/du5AD4OONWZjpUyiY7xuMF
         04wxOJct1+9W6EzedROi0pHgbTKzlMxWbxr/Xg+mXoVhxux29YGxEKS0x8t69kP1EVVx
         nVry261wR5FtZyy+ASdSoLqjgZMM/FJVLo0ACyyGE0q7BeneVF6nygiqUC7sVLZin2hp
         ZLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/0umr1qG/qgpEFz5deDRXgTYtCKL5W9w5+Ev+GQb+Dg=;
        b=CzqlNZH7uIXxvMEo62/Xr7ep3zG22OmZ8983+j3Z4+lkQK9n61YJSa2cAPs371xYCS
         FLJ/oTkdzUHDLZSWePMqYNC4B8uI7iDvq1YaBEQZ0kXgAhOO4yWDVyEKj6mTicM9L1Qr
         Zobz4s2jQVCDSvKek/N0Dao2XHuckgIe2FVk7BxTVNbLcR+BpYG9YAHCgMouV9QC6njZ
         NbCw6iPqt/ZENLHdy0h8mYCVxRf20S/PpLqBMEQAQsN3MnwXFf8mpzFTmRZfSs7S5Flf
         UHd2i96WO79+StXur+LdmA+nfrNtWURptWJTxHGwf+i1mZ2hN7bi1cCXW/YYfPzmbv4o
         9hSQ==
X-Gm-Message-State: ANhLgQ1K0Hma8zoozrCaRkriUrUC6FSuUtpv3FXaqRZc/vB4biHCjYVI
        4QUlMBbFkvas8x8TCzPBnmwgcQ==
X-Google-Smtp-Source: ADFU+vso95SaWak3tER3wqc75VRhPc5TbTb2THpk8dh/f8oHGiH8kxhVJ28evS719oogUmCiIiHFLg==
X-Received: by 2002:a17:90a:c78b:: with SMTP id gn11mr13899610pjb.97.1583704263403;
        Sun, 08 Mar 2020 14:51:03 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g18sm43038368pfi.80.2020.03.08.14.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 14:51:02 -0700 (PDT)
Date:   Sun, 8 Mar 2020 14:51:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     adrian.hunter@intel.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        rampraka@codeaurora.org, vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, mka@chromium.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-mmc-owner@vger.kernel.org
Subject: Re: [RFC v4 2/2] dt-bindings: mmc: sdhci-msm: Add interconnect BW
 scaling strings
Message-ID: <20200308215100.GM1094083@builder>
References: <1582030833-12964-1-git-send-email-ppvk@codeaurora.org>
 <1582030833-12964-3-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582030833-12964-3-git-send-email-ppvk@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue 18 Feb 05:00 PST 2020, Pradeep P V K wrote:

> Add interconnect bandwidth scaling supported strings for qcom-sdhci
> controller.
> 
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
> changes from RFC v3 -> v4:
> - No changes.
> 
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 7ee639b..cbe97b8 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -40,6 +40,21 @@ Required properties:
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>  
> +Optional Properties:
> +* Following bus parameters are required for interconnect bandwidth scaling:
> +- interconnects: Pairs of phandles and interconnect provider specifier
> +		 to denote the edge source and destination ports of
> +		 the interconnect path.
> +
> +- interconnect-names: For sdhc, we have two main paths.
> +		1. Data path : sdhc to ddr
> +		2. Config path : cpu to sdhc
> +		For Data interconnect path the name supposed to be
> +		is "sdhc-ddr" and for config interconnect path it is
> +		"cpu-sdhc".
> +		Please refer to Documentation/devicetree/bindings/
> +		interconnect/ for more details.
> +
>  Example:
>  
>  	sdhc_1: sdhci@f9824900 {
> @@ -57,6 +72,9 @@ Example:
>  
>  		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>  		clock-names = "core", "iface";
> +		interconnects = <&qnoc MASTER_SDCC_ID &qnoc SLAVE_DDR_ID>,
> +				<&qnoc MASTER_CPU_ID &qnoc SLAVE_SDCC_ID>;
> +		interconnect-names = "sdhc-ddr","cpu-sdhc";
>  	};
>  
>  	sdhc_2: sdhci@f98a4900 {
> -- 
> 1.9.1
> 
