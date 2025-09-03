Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006B2BE651
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915986; cv=none; b=U3mS9D5rvcPl2F//YXz9QfXdrDciQuQMSZfQOk43rpluXS3XahQoOwbaej6qZ535nMCictDWpUP0z/lU+OTQdCl7qNWnE8FYgLjkzeavZfXucOuIjHaHFZJqbTMGzC2MMc207Dqm7kJTvCMwqdJ3/vIZOL6AnYQwV7h/HELA+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915986; c=relaxed/simple;
	bh=npa6VTO3UD4EmfEg4HVC1uujU7lkywOp1bop//9kLe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0ms9yNbjeu9Nfzo0XR6D61c7DMnEikdMzY4w6eZSIun18jTsDrjmUoWnN64SSKxpqhOMrLlJhwtSLZKSzb5RcLjvcqJuajRZYE/4PM5dyXILJfwfOLGKwLrunfuUcL/iklLb0quiDs2p8bJL5Gh773189i7dQIqDBhztk1hBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RcwnqjG3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RcwnqjG3"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwqkp004991
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 16:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pKeGXm8jI+JpucgwsLhCt1MqYWl2JGrUgMOwCF0ZLRw=; b=RcwnqjG3gzZFzE5y
	qk0DpNv2Z9TZ/bvR+tO3S4pDWBBktCGCpsH1epbK0E1RpKxO2iLyG5xmhciO2pKt
	qCU+iB4l77rt009pAJYpZmWzNzzC6whn7GzU+IFxXVSxW7i2EG6Bmk/6gEBkPDT1
	DjE0WOfBwjNYbG+qwHdqww/EIEvnIk3fxh6yaPQE0JyHUAsOebQH28DzBNrKDLFO
	McOgq085DUVyLmPxGlqK09VDyxDvLJI2hZjlEn19Jbf5DaHLfVTtP0cxC/KWi3K4
	cfXSyFe7/lPyPeS5SZeC5FyxM/EE30UXGx+3w5XLDCQ8QoTjg8oU9f5gdl2InkCe
	zawcTw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s4em4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 16:13:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso189221cf.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 09:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915983; x=1757520783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKeGXm8jI+JpucgwsLhCt1MqYWl2JGrUgMOwCF0ZLRw=;
        b=RgT/9Vvo5pXIAQ5xxZuXGWN0FFPBgiL7YbDy2rPXNDNHiH5XXJbOL8FG3WBTvVTf1j
         o771NzRyhsYf1vp0Kq1O/R7dpo4s1GXTgAfzUumMUW7z7gKX9HYgahEuKQDXB/QAmO1h
         e/vWK1/s8U7ktNc1KrTjuxiYBD+Io99E4w8dNPE3XBjNDaduG5cLze46bphOdaTUhG50
         yneqVt5oDgzuC67sP2UbqjB9UVdNl1FIIA6VV1Kv+5V3LzofDDgeUUH1aDzOGZ0FoSTg
         TgS1309pjDwviSyKwai8lSJ1qhflhMc0cmm6oBoTODk0iuCVtNlg8WBhACdV45OAGBJ3
         yo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKe903k2nau7hypgfVK1s2fyRK6ZlejeXISu+KuOsU8F+w8HlWsFS8k/eBOTz8T+xo/CinqxFgySQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0zTASNsw+J6kneeyWNvYhynEGqbGuwwng/ektjlGj3koKb3w
	0nR157qAXBFsw1zxwV6fekWaWnOMw96sNHjuqezShj9lec8zzZaHu/sv3GI57Sux0vre1wVMmWS
	vOHb99N9KolTW+QVF1Swr0vqaNmiuceipAU0ta0E2GnOFvyYm8CuxQoAvcq7GelA=
X-Gm-Gg: ASbGncuKgy26dRookybv6MyM1UyJ2zvKH0J+mw2dEUeGLQb1XTZXgtkb6nQm8QX/2w0
	GJcEB72jHCN9prTjlepPjrxiVWBR4yE+fTYx/oUR3hvD6wVo98cWZK3Nc1Of9TziNc9fhAZHYbI
	UiNPloLT2NAPXXCn4OmXcZNW30Bl0cLMsHiEhLjD0icoIXDN3KKhrjrPmyJs7o79VMEIWz59+VT
	tAMKIEV+64/iwv36/LKCo4BNL9tYEnqsotv+CCkuD2YTBcRO0kr3nZh2TT/kvYVRyAWy3DICDIt
	TXdBOe37EtUw+uR37Ld4gJs+XP1TDvelUye8YumwTkBv7SZdAHtSkGz0+2aIvQHSrQbYYiqKpaI
	9PLZxwPPJQ88SgSOe0rnlYA==
X-Received: by 2002:a05:622a:4506:b0:4b3:4590:ab74 with SMTP id d75a77b69052e-4b34590ba5bmr60324201cf.13.1756915982756;
        Wed, 03 Sep 2025 09:13:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfWwWchCPw1ePeEGx4qP5S7OYtJkgaeMl5VvODCf95CzdX3BdtWxnPTsVZ03+bkL8BPje0cQ==
X-Received: by 2002:a05:622a:4506:b0:4b3:4590:ab74 with SMTP id d75a77b69052e-4b34590ba5bmr60323761cf.13.1756915982100;
        Wed, 03 Sep 2025 09:13:02 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04110b94cbsm1003115266b.93.2025.09.03.09.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 09:13:01 -0700 (PDT)
Message-ID: <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 18:12:59 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and SDC
 pin configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
 <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX2uqxVrDRsZXX
 XOELrAQABo7EbCU39FZtgzdIfAnsQ7059BsFvfB4jiBWg+pui+EiIEvAEyoEQuuQZKDglzHYam3
 ClDXdEkWqyDco8akTVBjpuMdCXVNt+Fd0RG00Z4Yotq9OGKmmpuTwuganspLePNUX+rboeUjcPk
 PK89RiQRV7bHNLLP3+AxQt6F6jYWq0aB2WGVTFOYYwOAdSPy32cznHcbL/+iZmtfNEYMpjNoLzn
 PCdXQLXr3wCnlv1scEvYPSyEyq+6QMVWk0wdbKrv18aqWficFeSb+NqMRsVJd45X2/awPDq0z6H
 VHE7vnqpkfUQv6d9Mb7uopu63C5J01tPgwUGTr6rVEi1t0CHAiOW3iHzzL+KCUt8yrrNE+yzjEC
 I5oAnXVq
X-Proofpoint-GUID: w1zkAyFeZladnROsfqMsdKZKlDOnag9-
X-Proofpoint-ORIG-GUID: w1zkAyFeZladnROsfqMsdKZKlDOnag9-
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b86910 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=onm5DRxEkm4ScgEcFVIA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
>> From: Monish Chunara <quic_mchunara@quicinc.com>
>>
>> Introduce the SDHC v5 controller node for the Lemans platform.
>> This controller supports either eMMC or SD-card, but only one
>> can be active at a time. SD-card is the preferred configuration
>> on Lemans targets, so describe this controller.
>>
>> Define the SDC interface pins including clk, cmd, and data lines
>> to enable proper communication with the SDHC controller.
>>
>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> index 99a566b42ef2..a5a3cdba47f3 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>>  			};
>>  		};
>>  
>> +		sdhc: mmc@87c4000 {
>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
>> +
>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +
>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
>> +			clock-names = "iface", "core";
>> +
>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>> +
>> +			iommus = <&apps_smmu 0x0 0x0>;
>> +			dma-coherent;
>> +
>> +			resets = <&gcc GCC_SDCC1_BCR>;
>> +
>> +			no-sdio;
>> +			no-mmc;
>> +			bus-width = <4>;
> 
> This is the board configuration, it should be defined in the EVK DTS.

Unless the controller is actually incapable of doing non-SDCards

But from the limited information I can find, this one should be able
to do both

Konrad
