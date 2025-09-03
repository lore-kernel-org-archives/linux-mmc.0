Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472B320A01
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919819; cv=none; b=i6B7Tc6d4o8LthIczfd9C6q3u1ll9iQ4G+rrXoqQQERQUFryIs9U6K4RDGmH+h+02zB+drc/t6RDhdYwaPlj6e8XB2tDgLgtIMROkwGFPHdmrhaYozlFO0r/ikd/IIb3cOjjtUwlOU/N0cmA4yHAB58YFFygG3wH5bztXSzA2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919819; c=relaxed/simple;
	bh=nqlFhZhzUZ+Vy1SQPrseXFrBMF8Y98aiCpXePUraDik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6jFrN+oGv1UNONnBHcqiUd3jRA17QTanh/6nYqlyNOOgbLMx1xjvKG+e/BAVHmXQo86ddJEWAB2GZnEdJr2/28QZoTcOHuA2TkQcpZKM4Mu3Djk1Wkz2bQLsMAVqppcoDRvfc26WoTsFLDc7EYRsEC24h+INg6zCpkks3pp5Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FK8sRegv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FK8sRegv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx5c5021846
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 17:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z7peoZhXj/0Yo2bV05F9I7qJDdTJs3fB7ALaWzJ/+MY=; b=FK8sRegvj+nzad/G
	x4nwE2u1SOyjQfNpCwU4f8nF2eyv2gn65se1ATns8YjKgpa6WqQniAvLdySSC2So
	ytM0qWhSipr0DmresAQA1/+GZ6Jj0Lxw/MybC+Ey2Wd9KiSFSwf1oiRRYjVccMx6
	8RxIEwk8WF8/FoQqDiXOs0DFOgBd9VWM9BqO0c6p0CXx/fLS4n7QUwJQMWG+aowr
	IsjKFBIEnnN5xQAWcalfDQrhTt/ZFQwsy4/+fTiLX9RMsx/8l/h2SME67nh4DbSR
	BUU0UzIY3qQpvozGjYSZrLjYkr4fhrBj6Tb8Wc5z/iM6py7qRkFDXDSSkw44Lf6/
	ZReCeg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0emrf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 17:16:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b307e1bef2so323451cf.0
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 10:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919815; x=1757524615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7peoZhXj/0Yo2bV05F9I7qJDdTJs3fB7ALaWzJ/+MY=;
        b=GC8UrIblRahZzOHcr7chxAmzXNPVCoHa9iJFvJ+YFXiFCTw1kcr691w7WKPIBtRDl7
         C2+roEmTk8hg82qpv1vQSm7Ct6GUaCMFnrgx/WWvHBihPsUL318lJjtPpdwmy39/NAkO
         gmQ3mJxTDjFQScAFQ8EjxXG7Tu5lBYsL9ExwBSwng0iyMuy3bK8//acSbvLWrwqHAexp
         mdIrxXIBEsErwXAEoZU5JKNSaw8gMnduoGa18rXPlWywxFUgygInuagd0N4XRiqjyQBO
         msqxJfh8n887krN7QxpwgX+v89lLSxuooN97EjD9bus9eeFe3iIJ2rOLkp3aHxsX46NJ
         47sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJLWt5zXJiFR8LFcyzoF0fzM9NTguvgE2FiST9uo8AEUYsGydVKZFKeVwUNHhaWy0tlm63Tln92/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4X9AQ2sz9t5smziOJ8c3SwoeNcQfGoJ21FTFn/61bZ8j+yxQ
	eJBymyIfpjdxmuZdSEsPiT4xINPg7EdXVLM1AThMnHvAQ6bREN8vFCFIC/ePC5hBiq/UE2HADN5
	EFrO7hKxhGYuoZgv+saEFZgt20UJRekaEgmoKD/1O/QUB8OstF2dY4F912CFhak8=
X-Gm-Gg: ASbGncsnZJ8eESPCnEo6eK5v9qHdZSn8bYy3641GCrXerAFjpNUImWte1VfskJirfvv
	QpJGgfd9HLLz/p/1Jc+xvCLE21n0+ykFuxRgygKYidpgtIkGvi3S8pU7cE/d9Rr9s4ghVgrfNDd
	O4GDjlrwZ920/ywaOPubXkKUYghJH4jgWgfUgwhuDytSzB44b9XslGKsC5nynWeLb1YUcOQG3H9
	5btXRbFR5/OzAGX1AT/rVBrdfXQqdrG+bGQbb8080b2hCzLo/piqkGOXoij+5ILrslHtCFy2MFQ
	KyU7GyhTV8BhpNOaTgUGTekpZP5ZEXkL5qFuXFGEcQFmw+kaSLbrkqS4sn9xQlu8CCRlS9u5nio
	Kd85522uB8nyvJlIUqV1VBA==
X-Received: by 2002:ac8:7f53:0:b0:4b1:2122:4a51 with SMTP id d75a77b69052e-4b313e59df0mr165737231cf.4.1756919815386;
        Wed, 03 Sep 2025 10:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzufSNCOLJcAHJBeXbkcXSuchMY9E0g8OI9XBOLb45HVfhiGviTYDOVr814FhPcFk6atK3Vw==
X-Received: by 2002:ac8:7f53:0:b0:4b1:2122:4a51 with SMTP id d75a77b69052e-4b313e59df0mr165736731cf.4.1756919814748;
        Wed, 03 Sep 2025 10:16:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4e50fbsm12023875a12.38.2025.09.03.10.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 10:16:53 -0700 (PDT)
Message-ID: <7234085c-55b6-4131-acb8-a4ec097c6668@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 19:16:50 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and SDC
 pin configuration
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
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
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2qXS1QkDVLvEGuCS_vd0W15rEBZkFGT0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX1M/G+P9Yz9Hw
 JdeAJW4jKqvkvI4YTZfkdsgkLTKpSpH6vicq/10tnmKLfwawyjONJhcUAH7e8xUvxHwbtHFsM0K
 eDHlC06RsVoS1Jsu4hunxGuGcQAH5UWIm5w/FXZEQcs2kWUNQyRi7mjV+11dDWqhd6qZrZrETcE
 ce/jtfmMfJFXuOZsUjUFnw/mt3MlmpNcvqP85EfUvMQMqmHgEdTp2jOWhRqYiz4fWNhsxA1kaBG
 DbTOSNka9C+ZPCgKwUT7jWfF2e2aV5suIoz+azJqQNcjBlJbMPQHPfqS7TM8RHYZUJMgYs9800/
 BnuPfDLJMFZ53vhTUcAU4BQKNumQBM/vYoZ4HWLG9WhFAch3z9KLKurl07CCYe0lvHf163hvsUO
 4A2xAQ3F
X-Proofpoint-ORIG-GUID: 2qXS1QkDVLvEGuCS_vd0W15rEBZkFGT0
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b87808 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=_TSgDihk_Fvy7NELKkkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

On 9/3/25 6:28 PM, Wasim Nazir wrote:
> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
>>>>
>>>> Introduce the SDHC v5 controller node for the Lemans platform.
>>>> This controller supports either eMMC or SD-card, but only one
>>>> can be active at a time. SD-card is the preferred configuration
>>>> on Lemans targets, so describe this controller.
>>>>
>>>> Define the SDC interface pins including clk, cmd, and data lines
>>>> to enable proper communication with the SDHC controller.
>>>>
>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 70 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>> index 99a566b42ef2..a5a3cdba47f3 100644
>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>>>>  			};
>>>>  		};
>>>>  
>>>> +		sdhc: mmc@87c4000 {
>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
>>>> +
>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
>>>> +			interrupt-names = "hc_irq", "pwr_irq";
>>>> +
>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
>>>> +			clock-names = "iface", "core";
>>>> +
>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>>>> +
>>>> +			iommus = <&apps_smmu 0x0 0x0>;
>>>> +			dma-coherent;
>>>> +
>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
>>>> +
>>>> +			no-sdio;
>>>> +			no-mmc;
>>>> +			bus-width = <4>;
>>>
>>> This is the board configuration, it should be defined in the EVK DTS.
>>
>> Unless the controller is actually incapable of doing non-SDCards
>>
>> But from the limited information I can find, this one should be able
>> to do both
>>
> 
> It’s doable, but the bus width differs when this controller is used for
> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
> only what’s needed for each specific usecase on the board.

If SD Card is the predominately expected use case, I'm fine with keeping
4 default (in the SoC DTSI) with the odd user overriding that

Konrad
