Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AD223C6C
	for <linux-mmc@vger.kernel.org>; Thu, 12 Dec 2024 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024884; cv=none; b=esMcHpINguiKsi1lPHNMuYMswuMLo3RJiNxN3KFzCxa7D7Pg8+tZgNyg1rTrUQGqKEj29P4WDFo0ZhpdXVe0msrP307uhEzBnz5Jlz5bF4r25o5m2TgGFPfcGO0PQPf0hc5Cy66ghKqQu/AUAv2l80fFGwThfgEX6ap3fXtaFGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024884; c=relaxed/simple;
	bh=1ApeRTFz6odk1XghaSyjjzbGUVxHPQM6AiMitJnG81A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReIjRBIC86hAO8wx3o5ntb3eglOu1mi+cuWS74WPwnS1pvwRtDr58hj50HyPyN8kjjQO9xIBnECktsflk/U1fsWG0NEJUzbXq0JJAkXLl8ZgHYlMSxR7ZAScu2/P+YVZ88zmUuvY7gAH+bBhi835SyR+f7ZxBWFXTLyVsO/aBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IPyxdVlU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IPyxdVlU"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCBLw2V027969
	for <linux-mmc@vger.kernel.org>; Thu, 12 Dec 2024 17:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ix2yViUlfOnI3Jp/l53HkxumLGnFyx45XHeGOYs+gnQ=; b=IPyxdVlUvNmHefHg
	axdYOSCzpKgyMhouH/3h37eg41lkiQzZvQ5iRHIeKEJuS622s10rueZLzMicai40
	Nbl19dXid2zJvKhCdgz+RC2my79fZr/zRnxr1VIIucoPAWYJFEUyyLqxQqmyudca
	6YE0VyGJiaLIm8FghYyrrBR6fy2t2D31PA2aVUHgIjZ2+kudqTPR86+U6QUGArAD
	aHdUDR7coTOIwzUZ/eYyLkylAP1tuVxCW6zk1kZ7mepaFG42UbL4FO8MU/3GTizg
	wUR9lEnI8igp21U3wSw0ilgTt4lviQIzttnuhhw/2y3C4VQoNb8MmWKEEFjVrul/
	isGFsA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fxw4s2h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Dec 2024 17:34:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4679af4d6b7so1860741cf.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Dec 2024 09:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734024880; x=1734629680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ix2yViUlfOnI3Jp/l53HkxumLGnFyx45XHeGOYs+gnQ=;
        b=b7ZTUredRT7AWOLlfLuOldm3gzCvgKCfTvkfmjHu10ZhAU3y4tWmZf0RWcNonGZiPu
         OULMxkCcYn+ivIZLHFukdcFBgQOnl8M5/0DDP1t0lLS3e4A2XA4Bdi4DoyvUI1DLLNHN
         jJfUp+oeQDQ2CPx8U9JNLUTm7hqw0s9VBk/fdyy44B/q+yQ1Zxfn8rKeF6zSsDBjYiRh
         /gg3ku7LFErR6V7kkMDGTiKaacPvYyGIEJxx2ZZyc9D1SL3Do35FLIMKxwB8urWuuzyf
         yiBcWiXuBu3XZw8oIZ6w5Fj7OaLamWltCLJMz7FbqvQ8uYam8a13bdRD+LqknVUggNAI
         0jeg==
X-Forwarded-Encrypted: i=1; AJvYcCX+SWEPKh4GJoKg0A6+zpNPaE6+pvEIYvC99ZtFljhqA3RJdzuXqb6xnhoJF/EY+M3lykafTCI0WMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSx47YYCSWlqfh4YGgtYIT6+9TNNuqKZIFM0SP8Pnk70VP+dm
	PrzIuzBjn+rteajUs2E0em7ziWvTHx4I2nSoI094hjoRV6ugdqoCBJVdM9VEozLOEHDnDS8pDUY
	Irl1OPqPAH54hxnt9SAv9hEQsDtxYEJRGR7pSn0qiR3L/zA61mzu19+OG6R8=
X-Gm-Gg: ASbGnctzxnFMKAUIk3F2JveyDKza9gCHJ0cll+SCbM2JvMJwBckUXhzyaISBMZgkeNS
	UasTECk9uPdsBp6oyXklFgqeTjSjAQ/ueG6apZnb4NR33XM8XQaE82YL3deAj2fFT7Asb7Ei2fM
	oBDIxOvmT/342EXX1rLDVDi0JW35Pi4xOfwc895PxGPTU0hCL3Aa3QpNV5jO1tRwzXRQ6TXvO+L
	QRojm4I6rSuoyT0Ga2QC1jKFuXhiW58XrEzI7pu0xS4FxB5pEFsV+C5DQ6251IxTuUkwX36zB4o
	EqE+SVb9nRs5V3ZOshMQyQCfAUI2WJBVB4wAPQ==
X-Received: by 2002:a05:622a:60d:b0:460:3a41:a9e5 with SMTP id d75a77b69052e-467a16dd1cdmr7790921cf.13.1734024880039;
        Thu, 12 Dec 2024 09:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFljHM2Bl24f+BNJ4dG+QO5z/PRp3ZrX7hNKu4Z2XRUq2UO2aq8AUxd+Qp7DJXsYZxCRcCYIw==
X-Received: by 2002:a05:622a:60d:b0:460:3a41:a9e5 with SMTP id d75a77b69052e-467a16dd1cdmr7790611cf.13.1734024879612;
        Thu, 12 Dec 2024 09:34:39 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67d63f867sm679690666b.133.2024.12.12.09.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 09:34:39 -0800 (PST)
Message-ID: <f2964623-63e9-44cd-b328-d502b5fddcd2@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 18:34:37 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: x1e80100: Describe the SDHC
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
References: <20241212-x1e80100-qcp-sdhc-v4-0-a74c48ee68a3@linaro.org>
 <20241212-x1e80100-qcp-sdhc-v4-1-a74c48ee68a3@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241212-x1e80100-qcp-sdhc-v4-1-a74c48ee68a3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: b8pPXs-jBtsSUBz-jrn25cl1P6GQVsHJ
X-Proofpoint-GUID: b8pPXs-jBtsSUBz-jrn25cl1P6GQVsHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120126

On 12.12.2024 5:50 PM, Abel Vesa wrote:
> The X Elite platform features two SDHC v5 controllers.
> 
> Describe the controllers along with the pin configuration in TLMM
> for the SDC2, since they are hardwired and cannot be muxed to any
> other function. The SDC4 pin configuration can be muxed to different
> functions, so leave those to board specific dts.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 142 +++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index c18b99765c25c901b3d0a3fbaddc320c0a8c1716..1584df66ea915230995f0cf662cde813f4ae02a1 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -4094,6 +4094,108 @@ lpass_lpicx_noc: interconnect@7430000 {
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
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;

The comment regarding ICC defines from v3 still stands

the rest of the patch looks good

Konrad
