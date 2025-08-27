Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEAD1D5CD9
	for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2025 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258566; cv=none; b=KdWByUDPh633qx8SotjSxn5nJ7+0oyuwA/WW8SuS8BmRxoKl/uZLYGLUoW/LySpPlacfhZlmaB75nfsdB4TI4aK5uAlEIHyy8zsmGFFa17waEL3K/lDirOHOFZypA8P4sIXrFy9tK30tzeYq2DP8VBjj/57WFeUknTorxs2CdVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258566; c=relaxed/simple;
	bh=dLtbAOy3Al7ntneY5m6QeaS3+rQWEwiiPaCM5hdVMLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECwjqDEHNEibaVK9CECE16DlEyNgdg1UoTNwEdx4fwXzr4QfJ/8Yk4KRjvn3FtWzntK5v2RLtfaYE62fMDJYn56x8oxY2NrgwMbIu4YlVKgl0B8QzJWFRF6g0Am39sY5VdGZp3fkrCsr+C5HjUfcWfVrP3W1DU4pK7PKDwnvPxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mv52OYtl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mv52OYtl"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QL1RKi021722
	for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2025 01:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1PV4FHH7FYcoWRrCgIX4mrtV
	qFom0HRFEZhw9/QxUVw=; b=mv52OYtlJPP3UQm75wK9b6C1nlhoQMOYAXG+6TCR
	paihzPxa52dYVf1THiYBACbpJ0enZFNNzv5LM/jq+vMFgFrYOtyssa1q/1GzztUZ
	LyRoWu4Bea0yeMM4lhP916GV04r7RryiohBOH/436vPLywAByFVgbL38U/kE/HZn
	m0AcODpFlQEAs8QhQpjPLcjn8qvLdHrJ2Kot6JafaBb4WGepAmYCSWkoom+zfaZX
	oles/FVBr7ezEIRgiM+fwest0BsdNR7W09WUMqESdrbA72u6P+2aoBO2bKYuS6FT
	bgaOAEcMcl6dceDj/wEs6ofNx+Lo0luaffd7+DUG26u7Rg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615jups-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2025 01:36:03 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70ddd80d02fso5713616d6.1
        for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756258563; x=1756863363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PV4FHH7FYcoWRrCgIX4mrtVqFom0HRFEZhw9/QxUVw=;
        b=oNuiVOqtJ5aBq68xsxcYkzvHGD/gVDp+HTnbmUhG7jXr8ANGz1Iiiwg7uhGTLQGOj6
         w4MCMUrFr+yb+kjGXeb9hA7HmEdqYJHJeip3v49jJ/xuiqmPNw7Hc4A9Vkz33Az1sKi4
         NBr3t79zTga8BfThTK3rMDK+gszCoOIb7wi5zrv81RiEJftjVG9pvMKUJsrG4V2MIsUu
         YyZVrfPzOGSCCKrq7E0aeaiwc+vpGwGAvNa20f/KjlbdBkgIjBfAOuT9tsBuxSHoUgX5
         WC13N4IPKzdHPC/YlK5TtN1PCjS5SjwEJdPFYms9pWSD9o6Wd1hyUzfd79J/v74dpvNA
         ugCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiVpbLtaWLnjxMUWB1aBs4iUvu0AD8vKGWcHW/lZ44Smh4ZjjNRefHW8PFHx+EafnJ2sZUxEqXJis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmEpk4cTH6EImCfR2uUuWmgUvI5mY0VNygFbixXMo1mMw7r1r
	+WRoZInFebR+pDa2zbHO6j0O4Zt06GbdcQH1oxfc2o6qfeqsaeg5micZdwJmKfgcsZ2ng3JPFvI
	bGRq08kfCVeWO8SgTuq9fJh0ASCCNNBQkLQ2dIv0lln4hykqTmwsN6sFBmc+Qa3E=
X-Gm-Gg: ASbGncvGeGoMOSbBDBr13jtOjtqbhzK/vX9mSAz0SARsrqQdCtLwqgOcWjeiATR1wvI
	//hA/o8abBEbHOn7XaI3ydRnyeKlLgZEjRoltvrpKi/el6oiDz4llEuRKMWcrlgiK/muHZKd1YV
	ZlrJguXW5vv2QQiNR9ldPGzmIgwmxxXbQ79j+z0UjtfiQvF07pc5EdB+PBVm8uOpZzUypKkWG01
	K5fjUpK2cQm7noIyC70LDuIHdn7z6nRREg6kw4VVr2VZ12rDeR5K/D2YTGj7rh7ytWL4wpbXlBS
	gqfR0XuAJDfmHhSVDYTCh6sZnOr7NkuMKGm+LwQIGDiMDNRVBlsS6UdjBhK/xDkRVlovL+2ZOxK
	AYfDRx7ioX9WQKVTIf4A90lcIw6cPAhnMuQ1oF7sy8sIP7C7qpOWI
X-Received: by 2002:ac8:5e14:0:b0:4b0:67c9:fd3f with SMTP id d75a77b69052e-4b2aab20a48mr236543441cf.51.1756258562659;
        Tue, 26 Aug 2025 18:36:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/dgryyUxS5WO/q5gj1Tl3Ipo6ZRLnJI6T4Ubswm19yZunDtrbO1VFLpdWSQydKXSKYMyCTA==
X-Received: by 2002:ac8:5e14:0:b0:4b0:67c9:fd3f with SMTP id d75a77b69052e-4b2aab20a48mr236542971cf.51.1756258562040;
        Tue, 26 Aug 2025 18:36:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c02dcdsm2540804e87.13.2025.08.26.18.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:36:01 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:35:59 +0300
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
        netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Message-ID: <kycmxk3qag7uigoiitzcxcak22cewdv253fazgaidjcnzgzlkz@htrh22msxteq>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX8fIyt+QCuCmr
 CKBYk1zq+pc0QIzn20J4NOdDhn0mamiBDe9lRJfzdMMqCY9TZ02RmY39g19uASgB+RrzxHkyt8g
 64FFDnZGoghC8Mk0WpgcwXADkOQYYiMbyXCq2xJj3kh0DX5sKNv7NXRAxiFoGL/MB1Xcwa8U/ms
 OaKmydaIZc8nbXub0qa5IeMwCqwYaHXu0M4Jwi8AVlgX1XBzbWWP5ni9Qe+1MgNL6RABCXwKaox
 rWne0Zzw6twlN9ZXSNj5BmwCjv7GRtPl+KIMFhKZHjwX/x4SEv3z3NR16oDPMyL5Drn07I9NOrl
 Mw6VDf0Vzu24GQ3pzqr+rTmCaw+MMh/tmEgxwIZviTAzc7pFQr3nYfktk9lfXCNB3g8NnOY/prP
 C3/CA05U
X-Proofpoint-GUID: D6cs9Mc2LYoI9ukesdFY1bYzx4EXCgus
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68ae6103 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=GE9niwbHW9fFSqPIJ0AA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: D6cs9Mc2LYoI9ukesdFY1bYzx4EXCgus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

On Tue, Aug 26, 2025 at 11:51:02PM +0530, Wasim Nazir wrote:
> Enhance the Qualcomm Lemans EVK board file to support essential
> peripherals and improve overall hardware capabilities, as
> outlined below:
>   - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
>     controllers to facilitate DMA and peripheral communication.
>   - Add support for PCIe-0/1, including required regulators and PHYs,
>     to enable high-speed external device connectivity.
>   - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
>     GPIO lines for extended I/O functionality.
>   - Enable the USB0 controller in device mode to support USB peripheral
>     operations.
>   - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
>     Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
>     firmware.
>   - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
>     and other consumers.
>   - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
>     Ethernet MAC address via nvmem for network configuration.
>     It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
>   - Add support for the Iris video decoder, including the required
>     firmware, to enable video decoding capabilities.
>   - Enable SD-card slot on SDHC.
> 
> Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
>  1 file changed, 387 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 9e415012140b..642b66c4ad1e 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -16,7 +16,10 @@ / {
>  	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
>  
>  	aliases {
> +		ethernet0 = &ethernet0;
> +		mmc1 = &sdhc;
>  		serial0 = &uart10;
> +		serial1 = &uart17;
>  	};
>  
>  	chosen {
> @@ -46,6 +49,30 @@ edp1_connector_in: endpoint {
>  			};
>  		};
>  	};
> +
> +	vmmc_sdc: regulator-vmmc-sdc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmmc_sdc";

Non-switchable, always enabled?

> +
> +		regulator-min-microvolt = <2950000>;
> +		regulator-max-microvolt = <2950000>;
> +	};
> +
> +	vreg_sdc: regulator-vreg-sdc {
> +		compatible = "regulator-gpio";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2950000>;
> +		regulator-name = "vreg_sdc";
> +		regulator-type = "voltage";

This one also can not be disabled?

> +
> +		startup-delay-us = <100>;
> +
> +		gpios = <&expander1 7 GPIO_ACTIVE_HIGH>;
> +
> +		states = <1800000 0x1
> +			  2950000 0x0>;
> +	};
>  };
>  
>  &apps_rsc {
> @@ -277,6 +304,161 @@ vreg_l8e: ldo8 {
>  	};
>  };
>  
> +&ethernet0 {
> +	phy-handle = <&hsgmii_phy0>;
> +	phy-mode = "2500base-x";
> +
> +	pinctrl-0 = <&ethernet0_default>;
> +	pinctrl-names = "default";
> +
> +	snps,mtl-rx-config = <&mtl_rx_setup>;
> +	snps,mtl-tx-config = <&mtl_tx_setup>;
> +	snps,ps-speed = <1000>;
> +
> +	nvmem-cells = <&mac_addr0>;
> +	nvmem-cell-names = "mac-address";
> +
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		hsgmii_phy0: ethernet-phy@1c {
> +			compatible = "ethernet-phy-id004d.d101";
> +			reg = <0x1c>;
> +			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <11000>;
> +			reset-deassert-us = <70000>;
> +		};
> +	};
> +
> +	mtl_rx_setup: rx-queues-config {
> +		snps,rx-queues-to-use = <4>;
> +		snps,rx-sched-sp;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <0x0>;
> +			snps,route-up;
> +			snps,priority = <0x1>;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <0x1>;
> +			snps,route-ptp;
> +		};
> +
> +		queue2 {
> +			snps,avb-algorithm;
> +			snps,map-to-dma-channel = <0x2>;
> +			snps,route-avcp;
> +		};
> +
> +		queue3 {
> +			snps,avb-algorithm;
> +			snps,map-to-dma-channel = <0x3>;
> +			snps,priority = <0xc>;
> +		};
> +	};
> +
> +	mtl_tx_setup: tx-queues-config {
> +		snps,tx-queues-to-use = <4>;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +		};
> +
> +		queue2 {
> +			snps,avb-algorithm;
> +			snps,send_slope = <0x1000>;
> +			snps,idle_slope = <0x1000>;
> +			snps,high_credit = <0x3e800>;
> +			snps,low_credit = <0xffc18000>;
> +		};
> +
> +		queue3 {
> +			snps,avb-algorithm;
> +			snps,send_slope = <0x1000>;
> +			snps,idle_slope = <0x1000>;
> +			snps,high_credit = <0x3e800>;
> +			snps,low_credit = <0xffc18000>;
> +		};
> +	};
> +};
> +
> +&gpi_dma0 {
> +	status = "okay";
> +};
> +
> +&gpi_dma1 {
> +	status = "okay";
> +};
> +
> +&gpi_dma2 {
> +	status = "okay";
> +};
> +
> +&i2c18 {
> +	status = "okay";
> +
> +	expander0: pca953x@38 {
> +		compatible = "ti,tca9538";
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		reg = <0x38>;
> +	};
> +
> +	expander1: pca953x@39 {
> +		compatible = "ti,tca9538";
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		reg = <0x39>;
> +	};
> +
> +	expander2: pca953x@3a {
> +		compatible = "ti,tca9538";
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		reg = <0x3a>;
> +	};
> +
> +	expander3: pca953x@3b {
> +		compatible = "ti,tca9538";
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		reg = <0x3b>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +		pagesize = <64>;
> +
> +		nvmem-layout {
> +			compatible = "fixed-layout";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			mac_addr0: mac-addr@0 {
> +				reg = <0x0 0x6>;
> +			};
> +		};
> +	};
> +};
> +
> +&iris {
> +	firmware-name = "qcom/vpu/vpu30_p4_s6.mbn";

Should it be just _s6.mbn or _s6_16mb.mbn?

> +
> +	status = "okay";
> +};
> +
>  &mdss0 {
>  	status = "okay";
>  };
> @@ -323,14 +505,196 @@ &mdss0_dp1_phy {
>  	status = "okay";
>  };
>  
> +&pcie0 {
> +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;

I think Mani has been asking lately to define these GPIOs inside the
port rather than in the host controller.

> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_default_state>;
> +
> +	status = "okay";
> +};
> +

[...]

> @@ -356,6 +720,29 @@ &ufs_mem_phy {
>  	status = "okay";
>  };
>  
> +&usb_0 {
> +	status = "okay";
> +};
> +
> +&usb_0_dwc3 {
> +	dr_mode = "peripheral";

Is it actually peripheral-only?

> +};
> +

-- 
With best wishes
Dmitry
