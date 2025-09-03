Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14332874E4
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914609; cv=none; b=MTVEKMbI21XMu24TBDhxy7gE7sOb0AqP9s+3P526cbqC3p0ec7hy7R1ZgPqyFVNPLqlU0krd4qGXsdPpOKJVqApiREtfDHajwzydbI2gcoyKTM136lW0ycrnUskMoL/C8hFtyi3a57pVjRjn0id0HxDkwxzOAI3DNhTAcqyFuMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914609; c=relaxed/simple;
	bh=H5qfSjclHJYp6VlMCGtyMvRXByBYpsPV4yiw5eNY7so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxeFzL0K0I1+Txfz5rIK9ztVtxKfL5kOdlu8xT8BhjUmBdMZhDgbKfOUuhD3lwg0R73+A2bLcdAlI+eFsn5eIVSSIrihP8aeCAT/Dee24vVbTv2YeTEbclBRuhfZNZm3IionbYXDsA/WKAMkIoI4Xg0P3qNo5c/61sQ3R3DBmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p2+sutGY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p2+sutGY"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwqbw029700
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 15:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wix1g4uaPabNljAYVNfcf6lXHFclM2pJ4RBkrprNZ6o=; b=p2+sutGYPslM6Z2C
	j5bJtXi8oO7ulNmoKt2MenR5taVhx+NdfhbmAHyq2GpQfZ+/kNTELUfVaBaKqkAN
	C0fb1Z15DYrLLhlwpWMWBpIuYuaxi1hj773G9nIunQkRH/aOFK49y6E+6aN+AXqT
	NkgDVHvVjodweK3/0SiOUM9V3j/KzauwIuPixykixjLBVzR/ar/000pLuY3ca3Rd
	aNdTLLHG4br25j4f6s8eCHn+jONf2tPzTReOrRLPq1ipf2KO2YAFbJFQL0IcrcMe
	zl9x7R1TBj8k0l6Wji5EZkktqJdIyOVMbDUNcBNNr445xB9l/gYo6LQ3aS7lcq7o
	IgWBWA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpcdjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 15:50:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso134941cf.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 08:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914605; x=1757519405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wix1g4uaPabNljAYVNfcf6lXHFclM2pJ4RBkrprNZ6o=;
        b=COXqXE442nNYhhud7PMYMAadvGwv4pU711U7cbPZ4RIBR4r2HsCx2Zj0Ys+kWD1vXM
         h1B6L67v2DPgk7Gl2ESEgjYsDscQiMW7uuzUO+Om76avHEWComY9Q4rjQyex4k5QCxFI
         yRnMGOsdhIorWekGK2m+dGB6ZGp5+/Ccye0/H+tcu7100T01yCR6ij98+Qbnkr+tfJGi
         /dq/MmR3xmliJWeRr8eBvC5yRo+CvaexBXm9XdawGWxNGq/KsnftP8OLB6fmsVIJ2/Fy
         zTlcsx+VwtwRiWrSxyBD2wgGlf2mC+XChvGkeG0940tL4Vnbn+U4e0Ge1MXJhmz9C+pG
         PNCA==
X-Forwarded-Encrypted: i=1; AJvYcCVME4rmXw4rixsAodxwIeYoVWp3DD509HfklG9Ok9Z1l7z3J1enrQRXNTpu4CgIPlc3mZpt9pFhz5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNu2bTWMti+CuO3zbiVZjfe05L7LOCDP2YXIc5rFfFdmBlJawO
	KhPMZO/TIjGL0lF4VgQnTuNbZslDDf3GhhICaogiDqZBRA61XPvcsOy3Yp9FuE4BruVD6M0e+7w
	h7iRtUDSybQUeudBcQ2W9Y1Q9hyHBtXYwdRMnBRW2y+5CdxmUcjuDR5y+Ep0oczM=
X-Gm-Gg: ASbGncsoOQQr2M2vra8qsXMw9hHXVpKACChIBPqsTe5W3GYjRieHXqFb6uhsaU8uNW5
	fHu+eyhyw/HM/fgbzqxbi6Oi87yBXpE7K6l50ADhTO1dcnuEvPptuJdEBKl1mQbrDBJIvPbXAeH
	yqk9nZ8tphEL8sowLWQZ25N+y8/1qhNrLBIvyUkeVJWBDeLysNStPNQ+/k5+mqxQbTssWaxY18R
	/pWnN4O8m19Sl3QkHz9L3K8DZB0SyO+aySqCs1D/dstQ908sI7rMPN2+RCFDQJpZPn2L9Zp63j9
	jevsAxb20CB6jcvQ+hkS56ufCWJusT+xcnhHiw+GjfWqBxWcGOme4sqZPMAGzK5INUdyFgnBZSY
	3I4z6adCpVgYK5oV7yf/RBw==
X-Received: by 2002:ac8:7f53:0:b0:4b1:2122:4a51 with SMTP id d75a77b69052e-4b313e59df0mr162339041cf.4.1756914604658;
        Wed, 03 Sep 2025 08:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYKt+soWuAENoVdQ9j/e/O6Qu8NlsHabjBSI6xYSgRI5GQL7c5Sk7w14RsYRKa3ZHe4HcE9A==
X-Received: by 2002:ac8:7f53:0:b0:4b1:2122:4a51 with SMTP id d75a77b69052e-4b313e59df0mr162338661cf.4.1756914604015;
        Wed, 03 Sep 2025 08:50:04 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5306e6sm12116057a12.47.2025.09.03.08.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:50:03 -0700 (PDT)
Message-ID: <facc2270-e700-49e4-a7ab-3b473e343ccb@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 17:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-6-bfa381bf8ba2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-6-bfa381bf8ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PA9MkMC-N0m6VMCui9zc4qkHAMw6TL5F
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b863ad cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=g-wiT8vaiPKb6nfFgJ4A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: PA9MkMC-N0m6VMCui9zc4qkHAMw6TL5F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX8bTT/IbaGg/C
 JUePKoFUIYm/JUyRcQF7Z7sYf6HDHpZ8ExHTccEcqn8J/+LR9ORMAZvZsNfyTUONsnZ+gb4uDwo
 NC7woiDOFpBa7gBax5+svf4cv7tO48bk6cvoU7hsVjsqbVorFMiBFdcZ6/Sl04nGDddVXZGgDDX
 6i4j/UCVeWMzdRQ2Plkq5YX24hhxzx6UaWK8Usl/5u+s2AeJWxMu+jF3k/qktBQxrajzgwywosf
 lInuGxUvCre+iTmmVbPZKsArjWKtxf1TEwa3xUEiU91JdybDatRgmXsU20+UKIg23E5eub5zBFq
 GIpTn8TuRlOgJLKkN1qGxFBAWMd0UvPN7qIAGQyAtZa9lrKanxYAdVNUSLtFpalf/ciMRNnVbQZ
 acAAa9LO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On 9/3/25 1:47 PM, Wasim Nazir wrote:
> From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> 
> Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> 
> PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> 
> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 196c5ee0dd34..7528fa1c661a 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -379,6 +379,40 @@ &mdss0_dp1_phy {
>  	status = "okay";
>  };
>  
> +&pcie0 {
> +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_default_state>;

property-n
property-names

in this order, please

Konrad
