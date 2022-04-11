Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A69AC4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Apr 2022 07:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245421AbiDKHdc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Apr 2022 03:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245433AbiDKHc1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 03:32:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32C73D48C
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 00:30:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so17616204pjb.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uoh+5w2FgxHInN7CbCfRJ6Q2aacclOIxcqG3PNif+Zw=;
        b=gtKjjh2ETnixhTITydnZTFhqZignJ2uRgWkCFRy3W5TFg+Px0zK+Q0lyDIWstXUBok
         d/H2oITXryoLemFXT9D9rnKh5FpHIAlunMf/hXFsJdEqcKD2IjJre7AUEj1T5aNRg8uj
         MvePwFuTKCFm0jCEW4egwcicD8uL8DT4QMFCuwvnW5qQmMWO+darhKYGEWLIFkL19FAJ
         eItP5SDxXLNf1Z/uQbzmpQOdm77HLinRnmZeErinPaMhljD/u1ux4/Q71RSgJ3mPX+/8
         A/1BdMHxqjb56H/UMUblA5k79uh0tL/ce4ttNFK6kUsKMmYQv2oSE9VPSJlPnofKRaml
         29MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uoh+5w2FgxHInN7CbCfRJ6Q2aacclOIxcqG3PNif+Zw=;
        b=vftfyf4l8OrQVQ9mVXSon1elCYFeBdjMkEs2bHyzM7c6ZL6tLRUaGXkvQwobUYufZ7
         srnythMV+9ESgvf6SaNAhSphzTQ7ETHI7ApqQXovasJ0mY8UQirT0g8DYmPJRKn5ACJU
         Tkqja4rc0Ua3px4xHPNL9qG2ZxTjHH2TuC2tzxPqkOKs+NeAmEHBr82UlEYIcNCEXL1S
         qdrY/aqmkWutqOy3hbVqMP7iNt8V5cnJFYx/DDNwlTTlsEDLb+cHGjbMH2tZsNFmekVT
         0fxYerpN620J/0Eii/mdT/tKDnc0Z1QfAL80tKpSAMM2iW5YjvgB5DY+bSPdLY4y874G
         oLFw==
X-Gm-Message-State: AOAM530eRUrtHOqWhE2tcLOUJZAsBdvGw+Z/vITRZLGDyPARb385AzLs
        NGgbrxE2a4HpQ2/KvmxS7RMd
X-Google-Smtp-Source: ABdhPJygvM3jQ3jaVw0+r0xd6u8Q896A5b6KJejsyKga7jtU0Kt77d6eULc8Qw+p4MptIaTHDQrBTg==
X-Received: by 2002:a17:90a:b10c:b0:1cb:9e27:5005 with SMTP id z12-20020a17090ab10c00b001cb9e275005mr4222480pjq.241.1649662214084;
        Mon, 11 Apr 2022 00:30:14 -0700 (PDT)
Received: from thinkpad ([117.217.182.106])
        by smtp.gmail.com with ESMTPSA id rj13-20020a17090b3e8d00b001c77bc09541sm19665923pjb.51.2022.04.11.00.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 00:30:13 -0700 (PDT)
Date:   Mon, 11 Apr 2022 13:00:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/7] ARM: dts: qcom: sdx65: Add reserved memory nodes
Message-ID: <20220411073004.GB24975@thinkpad>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649660143-22400-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649660143-22400-2-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 11, 2022 at 12:25:37PM +0530, Rohit Agarwal wrote:
> Add reserved memory nodes to the SDX65 dtsi as defined by
> the memory map.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts | 21 +++++++++++++++++
>  arch/arm/boot/dts/qcom-sdx65.dtsi    | 45 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> index ad99f56..5d51cc4 100644
> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> @@ -23,6 +23,27 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		mpss_dsm: mpss_dsm_region@8c400000 {

Node name should be generic. So please use "memory@" here and below.

Thanks,
Mani

> +			no-map;
> +			reg = <0x8c400000 0x3200000>;
> +		};
> +
> +		ipa_fw_mem: ipa_fw_region@8fced000 {
> +			no-map;
> +			reg = <0x8fced000 0x10000>;
> +		};
> +
> +		mpss_adsp_mem: mpss_adsp_region@90800000 {
> +			no-map;
> +			reg = <0x90800000 0x10000000>;
> +		};
> +	};
> +
>  	vph_pwr: vph-pwr-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vph_pwr";
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 7e2697f..365df74 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -66,6 +66,51 @@
>  			reg = <0x8fee0000 0x20000>;
>  			no-map;
>  		};
> +
> +		secdata_mem: secdata_region@8fcfd000 {
> +			no-map;
> +			reg = <0x8fcfd000 0x1000>;
> +		};
> +
> +		hyp_mem: hyp_region@8fd00000 {
> +			no-map;
> +			reg = <0x8fd00000 0x80000>;
> +		};
> +
> +		aop_mem: aop_regions@8fe00000 {
> +			no-map;
> +			reg = <0x8fe00000 0x20000>;
> +		};
> +
> +		access_control_mem: access_control_region@8fd80000 {
> +			no-map;
> +			reg = <0x8fd80000 0x80000>;
> +		};
> +
> +		smem_mem: smem_region@8fe20000 {
> +			no-map;
> +			reg = <0x8fe20000 0xc0000>;
> +		};
> +
> +		tz_mem: tz_mem_region@8ff00000 {
> +			no-map;
> +			reg = <0x8ff00000 0x100000>;
> +		};
> +
> +		tz_apps_mem: tz_apps_mem_region@90000000 {
> +			no-map;
> +			reg = <0x90000000 0x500000>;
> +		};
> +
> +		tz_heap_mem: tz_heap_region@8fcad000 {
> +			no-map;
> +			reg = <0x8fcad000 0x40000>;
> +		};
> +
> +		llcc_tcm_mem: llcc_tcm_region@15800000 {
> +			no-map;
> +			reg = <0x15800000 0x800000>;
> +		};
>  	};
>  
>  	soc: soc {
> -- 
> 2.7.4
> 
