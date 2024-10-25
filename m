Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFB20EA21
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881228; cv=none; b=N0wEE/kmG1R+V83qZCJROYirHd40AYS/R1R1ynyM9l4PoBAzRUDIN3EFLOn/nahTJ4nR+PgmDkYR/WxVYH3hPaoudEO8CWmn4vlp7h1EfnsBjsiMcK7m4ObyjuIrZQWBRoiHV4OgYwlw2M9Cp1Y8HvzbinaQLi8p9rsJX3xnqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881228; c=relaxed/simple;
	bh=C1E8frnjMeEQSy8Pqyg4K5aFpsibcSd31aK+iCCZ3dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUnPlKyL4Yd3egZ4RQmPMjn/RpDPGLNDNx3Msr6l2eLYhWugYCsGey1sOd15IZAazkxl9O2l3NTdrWfSuF9GLk0ww02OzLEeaA8lNrGQzK9Mpo0tKwnXluZjCIzAiMoVxdT35yrVBx3dcQH9QCARJYrq1+WbBKNS6cKKWrCRZ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EQr6gSn5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQr6gSn5"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBEEmX026339
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 18:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YrhtYMGo6oB+Fh3IVUbINDP/3iPpzWJ+iflfs3uTsao=; b=EQr6gSn5M0viTC4A
	rE8Zb8dRdxwkvc5EmZjNoQnOTG0Re+SZStLVEkzwv42J6GIVpLHHIeTZ5r8g2kv4
	euEK6T+R1qPPavZNm9xDCfjOkdJYxw5LNN2b5lfmtOwLZqhS6winmC8pMoMOoWAm
	ws7l2luJOFOBQrG/pCHbkMILZQKY7nwPetsm/fGPz6U0YZmI9kEBI4kRZURm7BZN
	WBIQBMrCaUqneefBOiU1EIYKCC8woKq2iy+N+pTM2lcpVk313FA7yP18wFpdTmWh
	ARemsALE5PbYJTMlgPG8ob4TYm1Pvoxzmjyj0gaYqLyXBZq8QGma9RmA1CrY0PIm
	8azGGg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3wt4n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 18:33:44 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4a4929a5d59so106971137.2
        for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 11:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881224; x=1730486024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YrhtYMGo6oB+Fh3IVUbINDP/3iPpzWJ+iflfs3uTsao=;
        b=epOQCaBZlVwxNUsQUDepWsb7KbAuSdRO99UevVjrBtmtS3788rYNBbl8gY6CDEhmXp
         FV7d1vR4OfGnQrd8i4pEXC8OCiidSyeG3Rm+aY0JxWXBufs1OxauA7NW+gV1mFKVLQRF
         TVk/a8bLCMVk2DHRPwam5SPOaGqIQxEU6JKuJ0iJUQRlC7MDEI3OZNAwMt8eqcye0mzW
         uUsXR7t6YwqNnC7f1/AznnWGISBz364u8eIRbbIWlLK4NdaMYESRqQyY+E1UEzrL0uEi
         1QjrFwxu4jTC381jg+N8lX+vBwvPALUBAPSWfBt4eYixgb8maTTSgwqoISRs0fF725Fu
         O9GA==
X-Forwarded-Encrypted: i=1; AJvYcCXd1iu3U13DOEyCEJUxlYx82LkP/HiIA8ZLi6Q/eUilAOhx/jIoyRve/16O7a4dbwGvfc8vgVyidfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcahR12tz2HSOX4v5ZboCs79YQj5ctNNolXSopoSqQxiSZHC/q
	rM1iUCFkNgENA39m0E2TykkHjYXY0rSX05qmBAGN8k+JdiaTfWHCyBAl0CnJTWDiebmH3DRby4K
	mzPgzqnTI8diJzZOEWYmbHZn1LGSfVQlQPKV7NyWILLm0Uu1a+pGNB27DQ5o=
X-Received: by 2002:a05:6102:358d:b0:49d:4538:be24 with SMTP id ada2fe7eead31-4a8cfd69f9cmr248209137.6.1729881223994;
        Fri, 25 Oct 2024 11:33:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpgeCSyeMgeGBpUzgGyBg9YoUfZTE/wNtpSmO+wzQcSnouAf+xQwCdivKcj6OqaJrksIp1pA==
X-Received: by 2002:a05:6102:358d:b0:49d:4538:be24 with SMTP id ada2fe7eead31-4a8cfd69f9cmr248187137.6.1729881223686;
        Fri, 25 Oct 2024 11:33:43 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1e75ff3bsm96012066b.1.2024.10.25.11.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:33:42 -0700 (PDT)
Message-ID: <321296ae-7190-4c54-b36d-92105b49f61b@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:33:40 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: x1e80100: Describe the SDHC
 controllers
To: Abel Vesa <abel.vesa@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241022-x1e80100-qcp-sdhc-v3-0-46c401e32cbf@linaro.org>
 <20241022-x1e80100-qcp-sdhc-v3-1-46c401e32cbf@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241022-x1e80100-qcp-sdhc-v3-1-46c401e32cbf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -lj1rQhtMeDXELXzSGLkc5kq3TGfBUf9
X-Proofpoint-ORIG-GUID: -lj1rQhtMeDXELXzSGLkc5kq3TGfBUf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250141

On 22.10.2024 12:46 PM, Abel Vesa wrote:
> Describe the two SHDC v5 controllers found on x1e80100 platform.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 102 +++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 0e6802c1d2d8375987c614ec69c440e2f38d25c6..2d0befd6ba0ea11fdf2305d23c0cd8743de303dc 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3887,6 +3887,108 @@ lpass_lpicx_noc: interconnect@7430000 {
>  			#interconnect-cells = <2>;
>  		};
>  
> +		sdhc_2: mmc@8804000 {
> +			compatible = "qcom,x1e80100-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface", "core", "xo";
> +			iommus = <&apps_smmu 0x520 0>;
> +			qcom,dll-config = <0x0007642c>;
> +			qcom,ddr-config = <0x80040868>;
> +			power-domains = <&rpmhpd RPMHPD_CX>;
> +			operating-points-v2 = <&sdhc2_opp_table>;
> +
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,

QCOM_ICC_TAG_ALWAYS

> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;

QCOM_ICC_TAG_ACTIVE_ONLY (this is a CPU-x path)

for both nodes

Konrad
