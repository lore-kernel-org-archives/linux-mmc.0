Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA4345743
	for <linux-mmc@vger.kernel.org>; Fri,  5 Sep 2025 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074078; cv=none; b=l1dX2sdgiC2zVWLrYrkRLYNFSAn8plK+yoYKoBDUQANBEo2SUX5PFjcON+XjLR7OMu8QPG5wnRcZ/Lup6jHko8FRurmsfR/iTg1V2S0Cnl/L2aJPZ72u+HZEsMs+TLjlTPVZWHvB/bGIxt3ZBQ8e2KG7I88Iqpbm/HE7puy4ThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074078; c=relaxed/simple;
	bh=qlohNMfmjA6RpvE7A5Xc8gTHqy7dxZ1ZxD7ony9bB2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuM82ZqgWMF9DtB8nqBR3oH4j3qcQ2Wf2EPEjg9O4ThZJcFo0fq7jb/ZuQeSkGCGm4TJLTSFj/a0pFoA+7js5oK+5bZXLlSwXmHhwUNoTG9gZsgUbCQFASMfy+H44ve6R2D2JKbG+k0aJADe30eSMPGBLBBRv408+SP7/bg6pD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OcFxGNNr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OcFxGNNr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857DLnd002543
	for <linux-mmc@vger.kernel.org>; Fri, 5 Sep 2025 12:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2ywG7DrxAJyha9p1n1s1uGe2eRAGhfx1UZDypRxMjFI=; b=OcFxGNNrlOznCtwh
	oW0F1GgSoQZXLTjJ5VCCRB5O/5z+rVjokRTjne2CkLvlf2U3+z/3ePAoFDGAXjcf
	FXHbC0uDw24SW9cWIUpeCK+Is3y75Z41ae6kb5//rXQdnn+ELvRtc4sKa5OEs5cH
	d6/3R2AweOCRkOiyfjXbWGh9Vn2bE0MlA/mJCS3eOA1cmXZlE4gCZ2fAnGCjpQ7O
	y4G4yuqVfdmXW/pNOwv2kffoJIZhz3k8QxDqGakw6P3yZSsOSqrEK5d28cWWNNYM
	gyJQw0rulMJlu3n3gblmXPtO9nrmb+XYByklAk6k3YkIwz6lnSGk0arBydqDeE9z
	DA5KiA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush3axuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 12:07:56 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-726ac3f253dso6643086d6.0
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 05:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074074; x=1757678874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ywG7DrxAJyha9p1n1s1uGe2eRAGhfx1UZDypRxMjFI=;
        b=EXNaoXU3t6R1mTwrBSOCE7nECwd45b8i5FVLuD0GnbrtjohF1PDPb/z+g7J0lUqTta
         f0qS87IryqewKnjrElKQsIDgaxUNtO634+4dth7UigtiCvU76+wTB54R9qgV8aAsRN6j
         hYPJO7hb4dT9hMHFtx3zgZZ7pyRO9er726/7KmSICBdOb20NUdLbgOJMk6WLBARYVvht
         7rGSXjRVg7p4ZoB4unWr7ky4k+xSMJ0sivm/+S3T1CW8aGm0E5lKn7kblbhU0uQTxpv9
         5/Wp6gitoldQQ8bf/xqlgYgZIofsnbB5QK3oa9M/J4qTjChCIQbmVsc+4vNTYgo9jzNh
         IH4A==
X-Forwarded-Encrypted: i=1; AJvYcCVb7mlPAReu+zsvhFIVqoTjbYs67qLsOLOsk+b/zwTddUiX+fa3QphzauI+PfXFcpRp8bIrn1F9IRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5utHcH5PT/F1i/qG/xz66nkzuSCyqekLANXSvJJ5tzDDM7/4q
	E0kt3leZnsuSkIIwl1TINgpzywxHxr5NiORILwMk/tQbfSFrdwIqDo8b7Xk2ZTCwKmTKg6XFzWP
	RqAWzlt8O+HMnwOCJ8JvupNBnQJ/ZK2D4iQGzPMRLcnNLTt1Mp27mPi7S1spX0rA=
X-Gm-Gg: ASbGncuEnr3COHwau8rsFMFNMnZok1X1XT0Ia73Cz05nA/p0kQEHbzEw+8we3c5PPqG
	yc4qCNCjQhiDjCQIV3H5+oZF9hhjGSTkq+ZkK/g/nEnZxf+U07F3z9uVEzHeIiRXo2iK3WYUmbg
	MJgrZXarly76S6ZKQ+sA1N+Xt1QmfhcMiEbdQCA1EuMPtC35by0NFDCGRgR3lk8aduAgQVj6Pex
	YMpxHf1rGiGohDHwZLGtrjv2mqii4wYkCjEiwx7ZuwBrqdYUN5SUSDzMRcqVO2xBTKFM54Y+B09
	DIkFSY4JdsG+WLkl5/DXsaLqW1LD0oqHZok09qkXqhp9arPUQ+nWtTQ4YZfvjnbtsjpSc98X8KJ
	itKSug/GWvzqr/X0qmtFQIA==
X-Received: by 2002:a05:622a:450:b0:4b4:9d39:3432 with SMTP id d75a77b69052e-4b49d3935cbmr67851461cf.10.1757074074552;
        Fri, 05 Sep 2025 05:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsdeBb4+ojSZLfqlx5FwAf1B8QozAeBTYPMWIY5jTEhRL6G68cKRSVMxgkPGjlTzVIJxN9Sw==
X-Received: by 2002:a05:622a:450:b0:4b4:9d39:3432 with SMTP id d75a77b69052e-4b49d3935cbmr67850851cf.10.1757074073738;
        Fri, 05 Sep 2025 05:07:53 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0413ee67a3sm1405722666b.24.2025.09.05.05.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:07:53 -0700 (PDT)
Message-ID: <e1c593d2-603c-4c3f-850a-07c14467b8e9@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:07:50 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] arm64: dts: qcom: lemans-evk: Add EEPROM and
 nvmem layout
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-6-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-6-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX+9e+v9hm/x/5
 ABJDsN6yNjI7L7HsFk9gsX8dgfHnIXN6ey+LcFiqcYRpiLqN5TWC9vgg9jllDRVMD9p/Qc9sVAL
 A2VEGk4EpmZVjq++46c7HeuGFKeuDm2zPpsBiOwR/51DDlU2t7hVyZW9e9Mq7VeMZxyABjQ14Ut
 vWiWQzyp4QjH3D0SdPbvlZMPyVrhwcVHRPn+dme/YuX7C8s0N40AyXuWtBvgZzugiguz1cj2ejJ
 vRTOyCm2rQbCbz+hoAdDwlghSE1gvHOWcCfkC6PRrSlnzO3umZhWRdixUG/De/Bt7uEjz9X+Ng7
 0o2Q/Hdc+zvRMmS2pLlvfYDrFBGq6xBGSbEhzXWvOUJFQdNO8OSC0u5f4HOn10jBCb6aY/oXk6S
 a+V3qge/
X-Proofpoint-ORIG-GUID: VunhqxDuJ9COh0v5orqMiMY0q2wSFyCR
X-Proofpoint-GUID: VunhqxDuJ9COh0v5orqMiMY0q2wSFyCR
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68bad29c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=E-EgujyPmZ3s1dcs9ZUA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Integrate the GT24C256C EEPROM via I2C to enable access to
> board-specific non-volatile data.
> 
> Also, define an nvmem-layout to expose structured regions within the
> EEPROM, allowing consumers to retrieve configuration data such as
> Ethernet MAC addresses via the nvmem subsystem.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index c48cb4267b72..30c3e5bead07 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -319,6 +319,18 @@ expander3: gpio@3b {
>  		#gpio-cells = <2>;
>  		gpio-controller;
>  	};
> +
> +	eeprom@50 {
> +		compatible = "giantec,gt24c256c", "atmel,24c256";
> +		reg = <0x50>;
> +		pagesize = <64>;
> +
I'm not super happy that this would be the only line of defense, but
you probably want to add 'read-only' to the eeprom node (or not)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

