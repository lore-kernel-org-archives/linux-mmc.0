Return-Path: <SRS0=O5Lw=A5=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8D6C433E1
	for <linux-mmc@archiver.kernel.org>; Sat, 18 Jul 2020 07:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AECDC2076A
	for <linux-mmc@archiver.kernel.org>; Sat, 18 Jul 2020 07:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJkmroxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGRHQz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 18 Jul 2020 03:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgGRHQy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Jul 2020 03:16:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19CEC0619D4
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2020 00:16:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn17so7505185pjb.4
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2020 00:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hfxUueH3QbeglEO7GeTZdxJkg4B3ud/EaO3dQbu1Hog=;
        b=dJkmroxRnASHU49YmVLzvTRNRNDhNriN4AkQBH8Uh7RzLxxpddcTCglkk9C7OIlojz
         Bg2I+4BZod7hZhFJb4dTzGDjGMFEAzCoAGZUxrohX87vux5J82jnWcq6xYuZqqIZ3t79
         cudhKXbUTgB0WBVnong8BkqETzxZqazL+t9i2kcgBL6RMy0urpkLO/E8t6x13pCacSLr
         M225oOctgnwDwEOeDN4cZe4Wa272TY4DFz43fF5ULxJ05rC4iKP8fPJzPgr23NjUEmoo
         5n+E3W15gaB6ylvXHyqJcWF4Xpa405tbjktCA6vM+i1brDEedNMWDrOL8A6BPYA2lYLQ
         9tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hfxUueH3QbeglEO7GeTZdxJkg4B3ud/EaO3dQbu1Hog=;
        b=rks95qOLS7UVbly4E9nqnFmW7KYe9Uf3913/aQBl+kTny2fOVROlc1wArQELMwwNrj
         AhKPhw1IuHL3cv9o2UHtXDj0PxsMksnre/nbIC62cS+XtkgPbqSj3N4E5tAbZQYTw4q8
         1U8+MlWq4Ul9GQFKAqqrEfyoIdJ8qK/erFVapLnmg2WxEwMh+Z90yt53nbC1RCdObb/z
         hVhSAOpVTUQq0lgfjC/pnqU35iGD+jD/lgZ0SiuhbZdhHp0S1TKiYVjEsWnk580QvSza
         26r5YbKhPjBgBDzv5JCkV2nTHpByZvZU05A2IWrOUh0WDhtlOQ4W44esIDAqHSnTIiCn
         RSsQ==
X-Gm-Message-State: AOAM531UMPuf7epm20IogDofWh+taaFlGT98aPav43SXYB1cFRXR1SvD
        VDAejOlqhhSqInpdmu8xgxaTIQ==
X-Google-Smtp-Source: ABdhPJw+e+O6DfxUZ/zVD14RmqoHO4q64ucdaV4e2CBHpcvf3lklVV+zwiNz4hv2SJez9BqpzI8uPg==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr10822306ple.260.1595056613941;
        Sat, 18 Jul 2020 00:16:53 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x9sm7088652pfq.11.2020.07.18.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 00:16:53 -0700 (PDT)
Date:   Sat, 18 Jul 2020 00:16:50 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mka@chromium.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        Pradeep P V K <ppvk@codeaurora.org>
Subject: Re: [PATCH V1] arm64: dts: qcom: Add bandwidth votes for eMMC and
 SDcard
Message-ID: <20200718071650.GC61202@yoga>
References: <1595054006-6803-1-git-send-email-sbhanu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595054006-6803-1-git-send-email-sbhanu@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri 17 Jul 23:33 PDT 2020, Shaik Sajida Bhanu wrote:

Plase add "sc7180: " between "qcom:" and "Add"

> From: Pradeep P V K <ppvk@codeaurora.org>
> 
> Add the bandwidth domain supporting performance state and
> the corresponding OPP tables for the sdhc device on sc7180.
> 

You need Pradeep's signed-off-by here before yours.

> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> ---
> This change is depends on the patch series
> https://lkml.org/lkml/2020/6/30/1280
> Also depends on documentation commit 557ed5f (Present on linux-next)

Afaict both of these exists in linux-next, so no need to mention them.


Would be nice to have Rajendra's ack/reviewed-by on this patch, as
you're amending his. Please Cc him.

The change itself looks good to me though.

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 68f9894..d78a066 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -684,6 +684,9 @@
>  			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
>  					<&gcc GCC_SDCC1_AHB_CLK>;
>  			clock-names = "core", "iface";
> +			interconnects = <&aggre1_noc MASTER_EMMC &mc_virt SLAVE_EBI1>,
> +				<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_EMMC_CFG>;
> +			interconnect-names = "sdhc-ddr","cpu-sdhc";
>  			power-domains = <&rpmhpd SC7180_CX>;
>  			operating-points-v2 = <&sdhc1_opp_table>;
>  
> @@ -704,11 +707,15 @@
>  				opp-100000000 {
>  					opp-hz = /bits/ 64 <100000000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <100000 100000>;
> +					opp-avg-kBps = <100000 50000>;
>  				};
>  
>  				opp-384000000 {
>  					opp-hz = /bits/ 64 <384000000>;
>  					required-opps = <&rpmhpd_opp_svs_l1>;
> +					opp-peak-kBps = <600000 900000>;
> +					opp-avg-kBps = <261438 300000>;
>  				};
>  			};
>  		};
> @@ -2476,6 +2483,10 @@
>  			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
>  					<&gcc GCC_SDCC2_AHB_CLK>;
>  			clock-names = "core", "iface";
> +
> +			interconnects = <&aggre1_noc MASTER_SDCC_2 &mc_virt SLAVE_EBI1>,
> +				<&gem_noc MASTER_APPSS_PROC &config_noc	SLAVE_SDCC_2>;
> +			interconnect-names = "sdhc-ddr","cpu-sdhc";
>  			power-domains = <&rpmhpd SC7180_CX>;
>  			operating-points-v2 = <&sdhc2_opp_table>;
>  
> @@ -2489,11 +2500,15 @@
>  				opp-100000000 {
>  					opp-hz = /bits/ 64 <100000000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <160000 100000>;
> +					opp-avg-kBps = <80000 50000>;
>  				};
>  
>  				opp-202000000 {
>  					opp-hz = /bits/ 64 <202000000>;
>  					required-opps = <&rpmhpd_opp_svs_l1>;
> +					opp-peak-kBps = <200000	120000>;
> +					opp-avg-kBps = <100000 60000>;
>  				};
>  			};
>  		};
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
