Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49DF60B8A
	for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2025 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756257627; cv=none; b=ahQjFb9dUkYXCnPl6owJDSYiREvHN5xHwvd6UDaQj7U//eW+lb39E3UzdR8iX75s0H5ytfzr1WoBQhrxk/P8O43Nh9C5GIYlVN4lsK6EvPAQlo1cDLqgm+MjKF36xUuxUEKDQDevFk7xm95LLqiib7AT9nUEkhkbUm2n5J7o8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756257627; c=relaxed/simple;
	bh=poieTlsyY1cLQWGzxhRq7UJJusIqma5TDI0g2OmhCPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTN70XDT3f2LBRGCVT1R6ENmL/BZvhxLPC6IjCDgM0UDwGIwp2U+rNqgryBtR70ZeuADHlONw7FaZsbASvEIku1qZ+JTfXQmko+OmLkItzD5IGzyTwkkXGThOwbM6iVOAIV4U3t5WM/RC6Pj1t7rwsyBIx059jzlxbdbIq1LkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lu9R20El; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lu9R20El"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QHZeCa024726
	for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2025 01:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=w/Xn+WN5sZN7Gioa60k8DdWJ
	ObxIkjRSuxFZ7uva++I=; b=lu9R20ElEb4wMvM0fGhG2Sc/xNgy2iMWZqhMH4F/
	hDHUsf9UZIqF7DmKCCLFmHYzTS4K6M8JJ01mG8YJ2BsetXgiN7VuCy2dMWBScBOW
	zSmaJQscYtA9Ggxwu+k817ax+pVwKYmnrc7b0TZ0DLp7U0HEYlgLtwaXQrITcShR
	2pj9XIzTYsrZoilKT0T8zdGz0jMBuVCaI3sTNH9jmvFaPYCi4JU2LI05UPXRxQkG
	GBqHT1YC6dQeCQ+5B4nG6ZmoiWyoEyV0B1P0enflkwgRyEqk3xauxOGGYoJZd0oh
	pu+ljD2VpkY0X5cye4DtSG+AMrRwBlp3PLlVKk/zJ9U7/Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5jqqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2025 01:20:24 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d9eb2ec70so46121036d6.0
        for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756257624; x=1756862424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/Xn+WN5sZN7Gioa60k8DdWJObxIkjRSuxFZ7uva++I=;
        b=amiJgSVtps3ZmNSLYC/ZhXVytoKLy2w2bQEO8NI4+wB6Or7oxgSgI2mk6nOlmVeH4X
         KymHX2HVZ4/2aV7pFeWv/aPS/tpsCeyQwO0bU4SoNg2wj52MxMHYM+IaZRbquGiDZE9f
         S/nYgONckbaoEPjd7yr3YmpTd4RnXTmh8M65DWtD088RlJnbs4VwQnnGkWNzqnGsczG5
         EQ+oRCnafoJ5/Jvm1p/0XVaTxwqsNu7tJkEN1gAr2gEHeUENuCqdBHrszJQbm5m5rt1e
         k2RXxjQb4Ivrekegl/RMOpkisEsjRsSma/385if1ZW6f2rqmzSpX9CenvDRW70gHZWci
         fKCA==
X-Forwarded-Encrypted: i=1; AJvYcCXliQq+S+RSk7E65iptDelsOQV0DBI/MdCwEuhRZrOUfi45U1HynkfJCQu9S1gG6gcSWHmND28tvDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcmt+rbSU176Q/rcf+2wtbK4QUx+vrIDhBrvzKF2cXFmDITeF4
	uKDhUnehd8BpEoyxZcI55XlvRoay2J8dsAr4E0ycfKi+rtf9LGUfadfznSVOyBajdsfBBF/B/27
	x4xO6zSRhmnqeG+ZrSDYHQ3nLtJLfy5OvKM7yU03iy3JbdZgGV1JoPluQi494o0Q=
X-Gm-Gg: ASbGncvdwZ14M6psQQRoW17nmJ2YyJ7RgWiL7xzADpG6UxURWJZtB4rtnB5RAYukctF
	sJNvC6ghteSgbbv7Uk8H4tsqIQLHBxkd9jcRTbD7vCTb2pRIMSBTj+reCLar9dBAIIcpTLsug2t
	XnTFZOvUp4f6TM1Uv0ODgeuDW3w4Br2/CpAZdQQa+fVq4gHS/Yza8cbrBSXSLoPI0ciTZiKOfUG
	r7CKQB2lE/3KQA6cC24TS01TEidcJraM1OQaJwlakJW9liZHNwgD4egYXGwJIpc2m6Fp9v8mMNn
	mfwooemKlOlI5hQsW2O4ZuBbOUiM+EEUnBBlFNEcIA/TT+QSKcdArwj+32UPSqoWekJuwXrfFel
	Ud4NZB7ucGj/wlcShPAl0GJ0W6k5nRhNIuyroFgSNZKJH5VDXwsiw
X-Received: by 2002:a05:6214:5013:b0:70d:a9aa:cf4d with SMTP id 6a1803df08f44-70da9aad0edmr158898276d6.18.1756257623934;
        Tue, 26 Aug 2025 18:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj7mqvlBJ1auHCNj37evOwAu64GQSmzOL1BDuqIdwslMygY6vB1q7fRLG4+OgUF4zumDU1lw==
X-Received: by 2002:a05:6214:5013:b0:70d:a9aa:cf4d with SMTP id 6a1803df08f44-70da9aad0edmr158898066d6.18.1756257623302;
        Tue, 26 Aug 2025 18:20:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e60a67bsm24910871fa.73.2025.08.26.18.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:20:22 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:20:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Message-ID: <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXwWWK6Jogm1SE
 QXeGxkYMwCOBbxw6JCkB8/jvmxtT4J8O3w5RMFoufTUVdnYOevx1HFwCApSUxrofo5ZcZKYxVId
 S4dI6zPVjo4GRK9RQI1Sj9yWj5WkJwf+xecFvU4Hxd5aU+6GXCtRiN3DxmCmMjQR/28B8IxKN5J
 uojkxOaN9ZRXq3IFpXo/GglrjgWH6eLVeJeba8pwO1dfa4v/esJCZcoSh/I2LcQZ7MF05OeOulc
 i8EQKih9jVV5ZGUcbCX7Ts/h6mUZllPQCY/gCa7Qy80Xd2APkoPGuAaadXtvwSWvy1u7Iar7KDs
 tlXYIwQR485Xozu/QANcHcAnNocsZw19G2NGxpsr7JWOs1i1DkKvShzGlWvxhUCHWgy4BGDdIky
 6NOLvMSd
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68ae5d58 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xnlQaYUteIq3HUSXtOEA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kQrKGV1_KwsTzUpw6pn4JKchSanFwYIo
X-Proofpoint-ORIG-GUID: kQrKGV1_KwsTzUpw6pn4JKchSanFwYIo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Introduce the SDHC v5 controller node for the Lemans platform.
> This controller supports either eMMC or SD-card, but only one
> can be active at a time. SD-card is the preferred configuration
> on Lemans targets, so describe this controller.
> 
> Define the SDC interface pins including clk, cmd, and data lines
> to enable proper communication with the SDHC controller.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 99a566b42ef2..a5a3cdba47f3 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>  			};
>  		};
>  
> +		sdhc: mmc@87c4000 {
> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> +
> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> +			clock-names = "iface", "core";
> +
> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> +
> +			iommus = <&apps_smmu 0x0 0x0>;
> +			dma-coherent;
> +
> +			resets = <&gcc GCC_SDCC1_BCR>;
> +
> +			no-sdio;
> +			no-mmc;
> +			bus-width = <4>;

This is the board configuration, it should be defined in the EVK DTS.

> +			qcom,dll-config = <0x0007642c>;
> +			qcom,ddr-config = <0x80040868>;
> +
> +			status = "disabled";
> +		};
> +
>  		usb_0_hsphy: phy@88e4000 {
>  			compatible = "qcom,sa8775p-usb-hs-phy",
>  				     "qcom,usb-snps-hs-5nm-phy";
> @@ -5643,6 +5673,46 @@ qup_uart21_rx: qup-uart21-rx-pins {
>  					function = "qup3_se0";
>  				};
>  			};
> +
> +			sdc_default: sdc-default-state {
> +				clk-pins {
> +					pins = "sdc1_clk";
> +					bias-disable;
> +					drive-strength = <16>;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc1_cmd";
> +					bias-pull-up;
> +					drive-strength = <10>;
> +				};
> +
> +				data-pins {
> +					pins = "sdc1_data";
> +					bias-pull-up;
> +					drive-strength = <10>;
> +				};
> +			};
> +
> +			sdc_sleep: sdc-sleep-state {
> +				clk-pins {
> +					pins = "sdc1_clk";
> +					drive-strength = <2>;
> +					bias-bus-hold;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc1_cmd";
> +					drive-strength = <2>;
> +					bias-bus-hold;
> +				};
> +
> +				data-pins {
> +					pins = "sdc1_data";
> +					drive-strength = <2>;
> +					bias-bus-hold;
> +				};
> +			};
>  		};
>  
>  		sram: sram@146d8000 {
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry
