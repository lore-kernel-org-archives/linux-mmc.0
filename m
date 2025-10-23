Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F31302140
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221689; cv=none; b=e7XzrKVYaSl0DfiIwRqQVcZdv/RIs26oDDcYyBG8uJ/zjesztXKoXtvZz1xe+owIJoVcdOeNetRjwRS6f1pts7oBSXl8I1D3iNqniHKiHO0bILWCpW15XDGq/ilsfZMwQxReLxfP13j+VDAkLONaYk7ZtNnLeJqdZtHmAyhL8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221689; c=relaxed/simple;
	bh=ZhystKoo43Dti+bpSBJIod4fu4Bu+YnvXyc3sQZGb9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8V6vexR/khs183ZvCtvvsDPPJX0DxZDKN+EJ9ppWD9KiRa/rjel4jX+Kbcn8OmrnndisoTxxhYUUSXFDSX7B2WkbnFBYGQ1Y9IN1gvU0oOLtA80uaflavP5fEQeBDm6fjR/AXYvOr192nFR9RCRnh1gYScVLckL1txIfhaRjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UtItQApN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtItQApN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so4117405e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 05:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761221681; x=1761826481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzSn/ofpSQ3cyLuuE3gy3xtWs7k4M2brzlRD1/+xzHg=;
        b=UtItQApNiPpb0l5qHWINiHPshhfGZXyPSdjAKSDTSS9SYTz5HDXXsVZu0EJoSONd/3
         HB8ztJ1Q1bn/plet/jmyWQgxt82UgGgE4OQOTIgTeotL64fgTmx3s/jSezhWCmjb0d+O
         tm81s38wbNbrxGIwiALsPAX4Mka9SiJtX/qI7Hm5uvk/aFeF/04Vm7bH1MTbGCboDDpw
         29wxQbspixRaFpUqiIDnUtokhQm3CfAADksbXzbklqmCIkORsn5HUclfWXVVRgk27tMF
         qMKpJA+0mAlx13XzDXZTwgELI4ZxIE/gUow1GugBNdzoGcW1JXY+CrzYEuTmq7N6xUjx
         dwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221681; x=1761826481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzSn/ofpSQ3cyLuuE3gy3xtWs7k4M2brzlRD1/+xzHg=;
        b=RLsmIMAVRhUvA0kldMIkvU6ONCjKY/S1mMCwhn6W+qNTV9f1zfyt07XaQ/D1OGNqLu
         jyYhou56U1BduHlAodxBa7fwlhOP7eswk97nnWUz7HNOuBWxi8tJmao4wlvI3lBtBIn3
         7PsQhPDMlqvkNfcB/EWxBIvp61vyO7x8wl4ZAEY9M9oJz2Cra98liEwmW758xyB5qbpj
         /w24syaZjCcPfu9D8J3lpIdP9VI4yn6vLnjFgXnzjunQS7Cs3Uc9PZ35cxIxcOf6APBK
         NcIKAvvQSmf/cbec3Cfn6sN1pBV7RSUP2f6ivaPb5KovQ8ItzRT2H3nH7z9UT80kqtpn
         agSA==
X-Forwarded-Encrypted: i=1; AJvYcCXzrsejpo4J4fTVGuUdYfEflBi9xq6jge+fECebp5QiaExaehHhkjrk4qrJSLgmhnRHS3r5HMjagNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw17/8ZNrfytWAcnHpkWHqW0oekIRMWlJR3fnDOut4xoqZM3gL/
	ba8swUMMhrr9cyB2w4vnsT9fphmfZSv4LQMkbYTA9UG+TVSxtwFzApVCELucxbHZmEA=
X-Gm-Gg: ASbGnctc+2h7tlnaT4GYhQW6vv3sVn5EHMNvhKhgK2UIxyR1ZHyYfpXbgUoVezWo4eL
	wst6jd1HPZJzzRmX8K5hqVOJVJg3uwC1UoCZ5AY5kcojCRlaHsPEdezEWvL9TSGNdNmUPvKDh/O
	6XGrx7vwnd+Y7GiRR4LWKqrXPu5c2gc7DGG9XKQ93juT5Ygp4dTaUHFh+691Gw4jvTk3Cpkqu3p
	FAYwLSZytHXjV0MqMKP8lM79wCP6YES3hoLeTelIsyO5F9xNl+vWarbY4f5DM3ANoR8RSd/uCAU
	L6SIE2aa320hE73ZHDuPp7Rlbzu++oFoy8ZerSRxSxI9yeXdKRndqyJCWqSmY66OIQQkEfUAyLT
	WTbxgnzrZxlL/iCL0FmZcGQSXIfnnbCiD7xp1C2xt2fEIWSkK8f3mAJLfle3mqlA9F26Z0wBFm2
	xEGLfJMXFWC2T6LDxS4Q==
X-Google-Smtp-Source: AGHT+IGa6YZVedfz0mGpkJYgXn+quvhlbpzP0Y7djJyWwUQrWVTgUOvmVrts9NVOpQ28SystD6Xtkg==
X-Received: by 2002:a05:600c:34c7:b0:46f:b42e:e360 with SMTP id 5b1f17b1804b1-47117931edcmr178691255e9.40.1761221680862;
        Thu, 23 Oct 2025 05:14:40 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ccd88sm4402444f8f.36.2025.10.23.05.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:14:39 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:14:37 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Subject: Re: [PATCH V2 2/4] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 soc
Message-ID: <kbbebw2kr3hu6q3sb4z3i7yy7vv432rjx2ylp254cbifpcxe33@bhyldim36fff>
References: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
 <20251023112924.1073811-3-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023112924.1073811-3-sarthak.garg@oss.qualcomm.com>

On 25-10-23 16:59:22, Sarthak Garg wrote:
> Add SD Card host controller for sm8750 soc.
> 
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 68 ++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> index a82d9867c7cb..1070dc5ea196 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -2060,6 +2060,60 @@ ice: crypto@1d88000 {
>  			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>  		};
>  
> +		sdhc_2: mmc@8804000 {
> +			compatible = "qcom,sm8750-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq",
> +					  "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface",
> +				      "core",
> +				      "xo";
> +
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
> +					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					&config_noc SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "sdhc-ddr",
> +					     "cpu-sdhc";
> +
> +			power-domains = <&rpmhpd RPMHPD_CX>;
> +			operating-points-v2 = <&sdhc2_opp_table>;
> +
> +			qcom,dll-config = <0x0007442c>;
> +			qcom,ddr-config = <0x80040868>;
> +
> +			iommus = <&apps_smmu 0x540 0x0>;
> +			dma-coherent;
> +
> +			bus-width = <4>;
> +			max-sd-hs-hz = <37500000>;
> +
> +			resets = <&gcc GCC_SDCC2_BCR>;
> +
> +			status = "disabled";
> +
> +			sdhc2_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-202000000 {
> +					opp-hz = /bits/ 64 <202000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};
> +			};
> +		};
> +
>  		cryptobam: dma-controller@1dc4000 {
>  			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
>  			reg = <0x0 0x01dc4000 0x0 0x28000>;
> @@ -3121,6 +3175,13 @@ data-pins {
>  					drive-strength = <2>;
>  					bias-pull-up;
>  				};
> +
> +				card-detect-pins {
> +					pins = "gpio55";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};

These are board specific, so move them to the board dts.

>  			};
>  
>  			sdc2_default: sdc2-default-state {
> @@ -3141,6 +3202,13 @@ data-pins {
>  					drive-strength = <10>;
>  					bias-pull-up;
>  				};
> +
> +				card-detect-pins {
> +					pins = "gpio55";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};

Ditto.

>  			};
>  		};
>  
> -- 
> 2.34.1
> 
