Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13B3F7AAC
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787906; cv=none; b=n17/ztn3U8GfZGfpi08fN5rUWUy4S0govXCg+PTjb2DRHfiG8lV6N4AMqr3NhkcBmvXCL5sBW9UI+s9vDp55XSU5ssbUhW01fK1JXGW1FT/l1SVOqxkw731MH4EeXJ/iHsOdAiMXzfavQrxyy/ZitKv4s+ZZF6J89Wqy+luJ/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787906; c=relaxed/simple;
	bh=iJFpoj0Y+KkhOxJkO9jtgeUe8Nz64iXqGZjDvXZnyJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgdHHBZ1/hnxF2NJPzUoge1CiSUYPdoMlg2Gb4FIPEuW+HBDNMZgc8FuYP/XEiclW4YfKZbtCCz8u5TBsBoEL3QCowzOzehu0Wi68TpDuxz1qBkRCgaKtz9IxIBZwxsZQUPWadluiAboJuUHws4FSn+DQDELN3YeKZJcu6oYf8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L45ruMnf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Os5cPV6P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L45ruMnf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Os5cPV6P"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ICrnQV1319839
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AdpWPnfspT0O4IPRrN2sCrHLTuOAQdpa0+3S2ykbaYU=; b=L45ruMnfSUOYwG3/
	WLCojx3MdHdc9oEGKewXflXk0OQM/XLe+iQRLiQDvF80xn7b6eSUx6chpBMCuqar
	wlR2bPrVrEZT0EQFBgLiL21bN7Rx7Buuy8V2QKp74zc2U84PETEwY6CbFyCaVDJq
	x5T4HMk2HInVVSp+/9O4966VIup78INEziGHIQPpAMwrl3RlFB/VQWeptpzViFSi
	fN1m2bsript97o8HTU1hEaeej1ebxDwPZGMMpWGKMeg8iYSO5S24ytx8oTt8TJSZ
	lX/JxKF3+MxPHPgeIkFZGPI+MUb0XiEq9V4AMqumJliRieyWMzlsD2CBX7PfPR8T
	G8gcWQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2cckjt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:05:04 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8dd70b510a3so1361976d6.1
        for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781787904; x=1782392704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdpWPnfspT0O4IPRrN2sCrHLTuOAQdpa0+3S2ykbaYU=;
        b=Os5cPV6P9KKADMWgih/gwCU/2yspj4T11Ksxhrn87DDJzapp4CrdYSPo65DzAjaOg4
         7mOImf+qD9O6rmIhmzXm5zrlD39EN+s0DVkJT5392J3GuEy/1vsX2U0m5fpEU68pf8VB
         2lMHSvJLfECelZJRkmTGUg2Z9XEYDDsIDmQZa0hMqK8fYtDX16VdmqZyrbjBFE76hYX5
         VmLMKoeU/xvCKfOr5o3vQVWCLS3t4MltI09sHet7dAsJvn9v2n/JLCr5mduAQ9NTvs+w
         jVw+Pe6N+K86LhXIE++hPVI7iGh/V37mX0PpndU61+pKu7o60Q06dXEGwNgiD+6MELnc
         xuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781787904; x=1782392704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdpWPnfspT0O4IPRrN2sCrHLTuOAQdpa0+3S2ykbaYU=;
        b=JzO3OMIEX1F7lfqolLFY9wa9Ss0Uq8B9rzl9eD4gekruQecPJB+Sk7+E5lmovCHySP
         B374VoaKCoeCagZQa5pWy9o6rN26uHjrD+sDnoA5l/HVz+bhnB7CX1EaYKaxAx8JPeLy
         lV0jkp8B8Gtrd9jRbxe/+ie9rf4SFAJ/oRxJ7QynT2DCfaXc4H4mbFxlsngICyJosVRk
         k2M+n86Y2zRLh3QHsuzvtECMS38kqhhx+Thw/QiDtuf3f4ah+rIa8gPWnOZUOWdIm82k
         aIGg7J6jAfjNQ0GJMKK252U3A8sVS6ufDe91wnlfNSohyFCC1/sk/hE/f9PQraAMEbCq
         9kiA==
X-Forwarded-Encrypted: i=1; AFNElJ9Vwfws9asbJZUeYMtSxMJNktm/3JjD89ICRdx9yNhvYXQkK9enjQwOpFRtIa2HdrNbGBRoJZIfTy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Uh43cVv0BDNbekE//M0cOERvgW5qf8K9rLKeDqZmEc+i4nhj
	Vuodhr4xNobAKTDOAHuPKuvKA8fTlqhMWAhR6Ao2jMUljBFhzyP5ByN+NrOoGRyg5XOn2MQIWSV
	JQZ+xKzmBiEHrWt2q5VfO/BRuCIKkwnkI8S70nO/WAYEJY8Hbgy7G7JY8ELpziw0=
X-Gm-Gg: AfdE7clkogsSvwPLUHxVlx8FKaP4uvkPUvGjkudB3JuNsW36Z8JT4wJWOfPvvPjvP7o
	FcNeZcHa54cO2uUzLFkbVU/wE+yo6fz0Lx1tPxnLUMjIfI2a1iRPf3QVFTjLpEolkkA/KaZ44O7
	0KUXPo0WAoxB4PVcn66Zzcx275AYgtkdFjMBsRdC74BSRXGJWvUEcNM+eLzwv570TsTXPFpUoGz
	ICYTkaIeghWYcX6eddzyGkSgeO98KnduMPV/dFK2tpDAts2n+SSw0+QC1B1uDGMrWHJX61NpKcx
	CB94ZMGh8ANjPevEFwe97GAMUSmb7a6mtuyHyqRisDhxJaumgVBsXkR7Gv8xph/MVlerzZrG/sE
	F3a9vbnL7DfWc+BeCKiZjAAjL93rdZ5wJ9JU=
X-Received: by 2002:a05:620a:d95:b0:915:769d:56e with SMTP id af79cd13be357-91f27bdf21amr330332485a.1.1781787903775;
        Thu, 18 Jun 2026 06:05:03 -0700 (PDT)
X-Received: by 2002:a05:620a:d95:b0:915:769d:56e with SMTP id af79cd13be357-91f27bdf21amr330324285a.1.1781787902760;
        Thu, 18 Jun 2026 06:05:02 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6954c2a4450sm2231829a12.16.2026.06.18.06.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 06:05:01 -0700 (PDT)
Message-ID: <d8fd7888-cf7d-47e2-8e77-3ba705c88502@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:04:57 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/6] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE eMMC nodes
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-5-1cebc8b3275b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260609-enable-ice-clock-scaling-v11-5-1cebc8b3275b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEyMSBTYWx0ZWRfX57jwEfQlkXjS
 AzZElv0SaeJM6hQbXJ7rjDMdmzFCpUlBm2vJCkhC9LVReA3FI+XqAUbuvhqitmTGDV8llKR4o1s
 hoPiVPVB7q5vfD36les/N95ew6tNry+/7UzuORSPTFj+KQjjZnUiOWdeCULM+JodnW5Td32rQLm
 4P92oozw+QfVQqmhy2ttVa7pqMd1PJ3/FQTR8jmlysiA/UmR6D+WYIfH0V5iw8jY2CvamqYl9ZJ
 5c8meH0uLv2lhwaJ/7xl/HJhPDBNgQduGhBf0TfTLDKxY2cPeL/JZT0kHVxt+NxQW8C6uHu8QhQ
 fknvHepD4+L6wGzT6g5RpbN/4gEFKiVivErA8oXK8aTLyO4b2ZVXyeNtKJplhct/rscBEryfd1s
 jhpSEU1ADpHJTxCN+UtMglQ6FOKUQAOY7q7NuLp1KFeWZA7GC3hmNX0mEDxeg+5s7ngvYmKQNjl
 UpniOaxMIOIMDMtcmEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEyMSBTYWx0ZWRfX63/edUXsM7/n
 yHe6fHz4WDL/2u4Enn4bsHNrA0Uu5CI1vzCjZGnIZ3lcPbEuDq8xvXtjdXJdp11uePin1g/kKR4
 vt6qd/IQ/9NS54pjjnmRAvBpbnFjv98=
X-Proofpoint-GUID: n3-YZto_7Xrcss3vB8We8v0VskPHgwpP
X-Proofpoint-ORIG-GUID: n3-YZto_7Xrcss3vB8We8v0VskPHgwpP
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a33ed00 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=QRdWpJMrku1fmPn5X40A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180121

On 6/8/26 11:47 PM, Abhinaba Rakshit wrote:
> Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
> an optional OPP-table.
> 
> Add OPP-table for ICE UFS and ICE eMMC device nodes for Monaco
> platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco.dtsi | 37 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
> index a1b6e6211b84d0d5008231c55613a0ccd61b9450..d9298d8b7874b8669b2cded2a28a99dce6eadbda 100644
> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
> @@ -2742,6 +2742,27 @@ ice: crypto@1d88000 {
>  			clock-names = "core",
>  				      "iface";
>  			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
> +
> +			operating-points-v2 = <&ice_opp_table>;
> +
> +			ice_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-75000000 {
> +					opp-hz = /bits/ 64 <75000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};
> +
> +				opp-201600000 {
> +					opp-hz = /bits/ 64 <201600000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};

Since 75 MHz and 201.6 Mhz require the same power level, is the former
OPP any useful?

Konrad
