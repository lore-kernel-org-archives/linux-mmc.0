Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22469202F71
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761471244; cv=none; b=rrD+8Pi1wwJcbElZ5M9yxk1QzAF6It/90crL70XFDFPim7xYor34Kr8bEDbhPpIBU92/MIOfSXk2ZuP11z1WJbgyctnSmdLtZjWnjmecJOcGhbn7fJHs+7ZyXAkZVloysZrZU0m3Zu8dUcu44744ZtcoG/yHsr7iPD2/Hq8AiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761471244; c=relaxed/simple;
	bh=Mh6NpoOEODASCpA92pc1qeYToNd8lzNHa+S4ChO1X40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBDQD4I789VgafaQ/xoH5M2AOulI/2xSAkQPwtjumJJt3G1HjgUpAwsn8mxhzgVZXzUNlHWOCwiwOtrXj2h0XrE6apsuilM292ySaIWv5kC1swwAlC86Luuc4i3dHhLRJw0gUyvYcOIgXqTUluNIpPHYJnNGk4weVXZMrpLvUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WSmOR86j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WSmOR86j"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59Q5HWGn3103326
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 09:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	56dn96aHf3hXKKzsHWNkw3ffdRMIjdiQ0e3RFj+hds4=; b=WSmOR86j5uftPdxW
	3UzSKr0k4OppNZN2fibBusBMXBB4Oke+ZM3IQj9RVQCH08YrViqE3tnpC1QsQfU6
	E8pPYX6oe+CADvPwTN5jZFcUvELuMqL2cJD7mAL9nDUFbMH5u6+p3/cp0/5iD3EK
	NuNxCVaSWvk26osFNXGu2vqQRk7SQQ1gTpqBqHGZUef/C8CCTPOtMjdjoXbvZZ3F
	U4UvNWIMRHf0KzpqIXUy/JEPIcbYGbWwB296VpqQmPdGrIA0qj76dj3/Aqi70IlI
	uF6+HB8pissZAAllccPZX2t9GpOkCZKFux6wzq3br7ITbWsN90hzqbp99LmAeEov
	cD8LGA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4w9v06-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 09:34:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290950e7b1bso6538305ad.1
        for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 02:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761471239; x=1762076039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56dn96aHf3hXKKzsHWNkw3ffdRMIjdiQ0e3RFj+hds4=;
        b=vXRtpv7qsorav6A2Icd+zX8TmBSdkJvYMEExCQ3NV3TMpNQTiCHd1JEXTC1C2vb4wL
         X1//GxjaFXU6l8fJY8tZxvXbvkrBOJJhOL+TBrMV6p848tTVVNazIfOP8VH2bcYyTocM
         yQOYA/dxffr4Mx+ZjDAGEbWirC1mXEIU+aXZEhuIQWFyP7grk5nnGQkxV4POoE/uM7Rh
         004b1qFEUMJF3RbKCtWZhtczyoEP+fgzLJOIPbf2SMqkSeVRi09DQsNxzDeQKaOMSvQ8
         mtHATplMFlKJJTi6ZszUvTrT8JwZoARLx0kTdIHEZTkTp52AM0/Ul4jksb7Xf5o7glpM
         4G4A==
X-Forwarded-Encrypted: i=1; AJvYcCVekZqhDbqJVglo2vsgAMjAiC2P92KH+w5ntMZre01qmBpdO8nPWNX8FbI+8YJgBOiztf8t17R/Hjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiPPDOBdvnZ96J0qAYrcozPQJ1ZDmSsDhdpwPPn6CTrkr1B4nu
	PKiJCvIwbwHiDRuwaR6pvbYYZV2HsCfNIn5+RzrwWcd8Dsq3cuC4NntMkwS+oJ4xMzDSlVgArwl
	rtruX+TfmuOMzPdLs+EL5Lk+oMsBxR9UL4VeYUYdk/oQ2u4wFl34g1yJ+nHhUQQ==
X-Gm-Gg: ASbGncsFXMm2vKLHS1Vr9JFR8g5e+b/2JKHRFQs4GOyM7ckfvI9eyGgAJi8Rwgq7JNs
	N0aN8YbHDgcvaBF0KMvXQ7+ATJlP29YGS/yI+gp/jeCPbDA1fB7hlTD2Dvotlp2FhqMGOauzzWg
	NXzD/DTN1coqXsK5ln17disekGzuWVeyOdaV7oHu35MWBHkOE1M0h7GoZY01WQlUtr3DYunOU6o
	MacNbE23TkMKqFaJ8WEI1YRBrx2WBEwMsxnRtgf3IZweRJbSDAgoEoWcXkhaZWTtX9hz6E3y3kj
	12UVj+7q8rdkXjFLJfpVT+8EUaHw++H0x2zg+M6jG3nON3IekaUKignrnyJbVUdpuIRFuiI2VM+
	svwrekLUrmJ8x7fOETcXV5h+KIg==
X-Received: by 2002:a17:903:2a8d:b0:27e:eee6:6df2 with SMTP id d9443c01a7336-292d3fb7f47mr128134335ad.7.1761471239579;
        Sun, 26 Oct 2025 02:33:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQBERQ6dlt5UHcYOlT6Y1tPbrDH52NPHs0vo71kb86ovM01aE0uB9o33e/ODR94nDiuD9/HA==
X-Received: by 2002:a17:903:2a8d:b0:27e:eee6:6df2 with SMTP id d9443c01a7336-292d3fb7f47mr128134215ad.7.1761471239159;
        Sun, 26 Oct 2025 02:33:59 -0700 (PDT)
Received: from [192.168.0.3] ([49.205.244.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3f4asm45343295ad.11.2025.10.26.02.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 02:33:58 -0700 (PDT)
Message-ID: <6292dd07-0a74-4773-ad5f-b737b2f848dd@oss.qualcomm.com>
Date: Sun, 26 Oct 2025 15:03:51 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 soc
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
References: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
 <20251023112924.1073811-3-sarthak.garg@oss.qualcomm.com>
 <kbbebw2kr3hu6q3sb4z3i7yy7vv432rjx2ylp254cbifpcxe33@bhyldim36fff>
Content-Language: en-US
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
In-Reply-To: <kbbebw2kr3hu6q3sb4z3i7yy7vv432rjx2ylp254cbifpcxe33@bhyldim36fff>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PTFLEJTczXIiEPti7czwRBKeshHQlXRG
X-Proofpoint-GUID: PTFLEJTczXIiEPti7czwRBKeshHQlXRG
X-Authority-Analysis: v=2.4 cv=NobcssdJ c=1 sm=1 tr=0 ts=68fdeb08 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=bVPtsstaAh+Xhvtfxu+pEg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=sFmbwog37gvI7kGm1A4A:9 a=KKStjhyEKkBOW3-R:21
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDA4OCBTYWx0ZWRfX+ffIG2lMv+5k
 TidH5iS5geyUk5sqMCGp624HEOThmxdX38sEpoWBWDlCbxpJ1fTnP/ZgWz/RG+hYbVpnzq+yoeT
 YytVgBHEP3eJ/G8hJ/982N1kIoL+WkXu7VL03+HjIhiQJk8sEov3Kn1TOhKtet2YZqAQsbdfDoW
 +CuzrolxvD9T8NpjRwTxhSQHTg21ASRtHuR2vEQKQhbukDV4Dg0TPAErJIdwOBDrbmJpRYM6ClR
 NPVuD3v9SOQWTd2/jAKwHrGEW5iRx9WEmcAV2AMjeG/j3IHAudUizMiz+/MavWYACAMokv0S8ym
 zQ9T8A7s+9uhgg9Zu6SUUjMSS8kUnQk33u6ZO3b5DQBhrBzxluKGtjwmjS0v+r0HXc75KISOpFH
 dH2ZydGWloyc2TqGnw1bt4CW0+jIkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510260088


On 10/23/2025 5:44 PM, Abel Vesa wrote:
> On 25-10-23 16:59:22, Sarthak Garg wrote:
>> Add SD Card host controller for sm8750 soc.
>>
>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8750.dtsi | 68 ++++++++++++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> index a82d9867c7cb..1070dc5ea196 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> @@ -2060,6 +2060,60 @@ ice: crypto@1d88000 {
>>   			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>>   		};
>>   
>> +		sdhc_2: mmc@8804000 {
>> +			compatible = "qcom,sm8750-sdhci", "qcom,sdhci-msm-v5";
>> +			reg = <0 0x08804000 0 0x1000>;
>> +
>> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq",
>> +					  "pwr_irq";
>> +
>> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
>> +				 <&gcc GCC_SDCC2_APPS_CLK>,
>> +				 <&rpmhcc RPMH_CXO_CLK>;
>> +			clock-names = "iface",
>> +				      "core",
>> +				      "xo";
>> +
>> +			interconnects = <&aggre2_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
>> +					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
>> +					&config_noc SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
>> +			interconnect-names = "sdhc-ddr",
>> +					     "cpu-sdhc";
>> +
>> +			power-domains = <&rpmhpd RPMHPD_CX>;
>> +			operating-points-v2 = <&sdhc2_opp_table>;
>> +
>> +			qcom,dll-config = <0x0007442c>;
>> +			qcom,ddr-config = <0x80040868>;
>> +
>> +			iommus = <&apps_smmu 0x540 0x0>;
>> +			dma-coherent;
>> +
>> +			bus-width = <4>;
>> +			max-sd-hs-hz = <37500000>;
>> +
>> +			resets = <&gcc GCC_SDCC2_BCR>;
>> +
>> +			status = "disabled";
>> +
>> +			sdhc2_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-100000000 {
>> +					opp-hz = /bits/ 64 <100000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +				};
>> +
>> +				opp-202000000 {
>> +					opp-hz = /bits/ 64 <202000000>;
>> +					required-opps = <&rpmhpd_opp_svs_l1>;
>> +				};
>> +			};
>> +		};
>> +
>>   		cryptobam: dma-controller@1dc4000 {
>>   			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
>>   			reg = <0x0 0x01dc4000 0x0 0x28000>;
>> @@ -3121,6 +3175,13 @@ data-pins {
>>   					drive-strength = <2>;
>>   					bias-pull-up;
>>   				};
>> +
>> +				card-detect-pins {
>> +					pins = "gpio55";
>> +					function = "gpio";
>> +					drive-strength = <2>;
>> +					bias-pull-up;
>> +				};
> These are board specific, so move them to the board dts.


Sure will update in V3.


>>   			};
>>   
>>   			sdc2_default: sdc2-default-state {
>> @@ -3141,6 +3202,13 @@ data-pins {
>>   					drive-strength = <10>;
>>   					bias-pull-up;
>>   				};
>> +
>> +				card-detect-pins {
>> +					pins = "gpio55";
>> +					function = "gpio";
>> +					drive-strength = <2>;
>> +					bias-pull-up;
>> +				};
> Ditto.


Sure will update in V3.

Regards,
Sarthak


>>   			};
>>   		};
>>   
>> -- 
>> 2.34.1
>>
