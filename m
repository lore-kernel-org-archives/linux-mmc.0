Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5830BF5D
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996453; cv=none; b=cVJRKMeW/guQ9OTpHZ+6sGqVSELeerK5LNyBNNVwhJ+kgn5TsA+ZhBSyvPzhu2DVTeofns9Ygrt296bZlVqKV1PwgDhbsFh8tR7bc9zM5JGD48N424eA88dRvv2EhNj6hr0B/eMNiMLvFqakEfW1pj2ukEgu+x1W39EN7HN6qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996453; c=relaxed/simple;
	bh=9kGLZsuAUdIFYWwz5hLauSws155ufe/wyvzDGbTeJKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSatk6kT/jwPukfWgukNUjuqfPLPBmNa3rn5fFfm2vuNhMUHXS8NJ4y602O9P916NNzqpQpb+o51vBJ/RD++4yz/p0AHHKCYyEHQm9+x6dN7tX7fqptqls2TAk8VD476NKcCN435s7vmtjj5TNDGfSLdVIcUys5a7NfCUf3QB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aXt1iG0a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aXt1iG0a"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X8j8008125
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 14:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UCrAy4VBSkToOvA1xqFBwYaPjkxY7aXwIQYFx4Hsorg=; b=aXt1iG0aMxe8G6oa
	9TMcp8SxOzjrLwZHlbrpP3ueeTw1RVsU7KX3aIPBqu1sE3S+G6kI+8Wp1JW/kGom
	WVOoPXF2346qLO0Zy4BzFyVsvo9BrrlLFrgcAj1gMHvDZl/ZAv8wZCcs3XpyC6xj
	eVABlJW79vRjLVHhRvm1vO1KTebmvcXBzzYaY/t8uHrZ7zWyAPPCDTxbCj6G3RCn
	dT6IYyFes2oetlcM+4sA8lmnZJlcW8qnb70LTM5haX9GVuBn63uKLqO9KHcRbnuE
	rBJIah4/IxGhB8OGZpB0LTPL1ASgwiJ79EYF9bGp+iSg6ggyKrCoqF4LJmfsnizf
	dB0QqQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjqr69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 14:34:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b331150323so2731251cf.0
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 07:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996449; x=1757601249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCrAy4VBSkToOvA1xqFBwYaPjkxY7aXwIQYFx4Hsorg=;
        b=BzNpdCHC3TYgaVQu7AGDqFjjfy5foeYNsZY2RrM5wR4xl1mNvjGq2LxkIja+kPnM/w
         NpPEquHN4u62+g+50JGYrW1ozataoEIr+C4WIXl885KZqu6dHfI59wVq3A+G1GOXCD90
         ublY4ry3M2BxWdHuJEXFRNkWq/qxAlGocWTnocZOXfQTm6EDL2oV00YQV39VDcMaDp6s
         /I0JJqn4wmYZlbpxyWNkJe5Ii89ZD16xXipYz6xiPZ+Wm78XVVJBXt4XspcvrzPbQe6a
         7vpAb3/e5yQDap+F8qLDeSv29NQXHytFk61Ufrh+tHLgFvXdCchzWBM/D3OKLWbh8Dqy
         abWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjsH/yeNFHMqVxjrj3bOnS5Dfz6lmBFAc/1EivdiAY8gzxWlm667apPV0jIixMSpiKpMimo/VEFQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhL4JZ41ciVk589zOxHtF4j0t8RdykRCszGBh0r4mWQSIltsnh
	p3Uu24PtENW2FxZa/YSK2+PdmCTuBvX1zwW/mHi+CDbJjcUVS2/Aui/8ioDzvomtvE0NnGlHL26
	FHX6g1ov/coSzgs75quVvyeVmTbJpeyRJNphTcGoMqHqijBu2nuEUaRryCwDyPcY=
X-Gm-Gg: ASbGncs/y8tI/Dj3F5coF9/m0Lqc0om9uWFfACkowzSHC+x3QKGjw2K/n4E8fEePrQO
	v2SNzFU/9Nb0CAk4moqW5GF3XkLFBQsNIJCRgL9ek5SPYsIFuGrwHmu1LTdC5MaK6c9PswfbtwJ
	P2a3El7DKdZME2UUzfvhJi5y85YZyG4t3NLRhUmhr0eaNV2DpDaQQpC4RzrsfogI9PfKklkEXGB
	2QPfbHvWaiRWeIo7vW5EQCNrd/0s9QXtjhhtgqfomRYXTYQVPh4hjD7ShNbYiW0JAsK27zseLpW
	UeuwtTpkf48rI/uWGuoevjf52jjAa4UH5EEg0LaLlt+/RcVfe98G9ypUWlYQ2MgSerPcrmdXlpN
	AKqfeHv8ZaI2dYXRqFBGxng==
X-Received: by 2002:ac8:7c55:0:b0:4b2:d981:9d4a with SMTP id d75a77b69052e-4b30e932ab7mr178894781cf.6.1756996449042;
        Thu, 04 Sep 2025 07:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrw5RFAVNLFohEcIYk+SdbuRFducNBzrRczOAhY4ohyswSH9BPbnDav5kTvXk4L0TpomNHGQ==
X-Received: by 2002:ac8:7c55:0:b0:4b2:d981:9d4a with SMTP id d75a77b69052e-4b30e932ab7mr178894231cf.6.1756996448330;
        Thu, 04 Sep 2025 07:34:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc579ba9sm14097959a12.52.2025.09.04.07.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 07:34:07 -0700 (PDT)
Message-ID: <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 16:34:05 +0200
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
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
 <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b9a362 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=kWtGODYmnNjJKUQazbMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sIounEGBPuRwzqQDjmc1UCL81Y6ifpVX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX9g2lbvmTuEn4
 1f58fIz6SUvMLzc7OWeFxwRrSxP7QbCLz9Isupj1EgdV85x74gyWkAK3iU9vQTswJR9jVkUeT/V
 QcUURCJ0zSztbI5RgSeVpfbVRsAel5GU6tTkP5n24/g0aZDDKduRpzXRO7yDAehmp13RKnxjqtI
 W2wn0jvnTvqZWbaPtwYoQ7gqos3gocBkNkDCYE9NoMsTayrTgXvajn1tP5bQrbQ8QnMnotMgOAm
 FC4CK4OqxhCs4QxQKQjwiNEfI28B43MXIDBDBQnkkzRBVkuJPrb5zvZ0667FDuwWoFYHL1BC0yS
 MGzDZB2CmZ0ivW627f/JWIYs6Db/+Pf3SIQzONTZPQhSTyW3CIOd1ThhTc3CYz2x30jCL8w4ZrF
 OsgNVubx
X-Proofpoint-ORIG-GUID: sIounEGBPuRwzqQDjmc1UCL81Y6ifpVX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
>> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
>>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
>>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
>>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>
>>>>> Introduce the SDHC v5 controller node for the Lemans platform.
>>>>> This controller supports either eMMC or SD-card, but only one
>>>>> can be active at a time. SD-card is the preferred configuration
>>>>> on Lemans targets, so describe this controller.
>>>>>
>>>>> Define the SDC interface pins including clk, cmd, and data lines
>>>>> to enable proper communication with the SDHC controller.
>>>>>
>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 70 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>> index 99a566b42ef2..a5a3cdba47f3 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>>>>>  			};
>>>>>  		};
>>>>>  
>>>>> +		sdhc: mmc@87c4000 {
>>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
>>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
>>>>> +
>>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +			interrupt-names = "hc_irq", "pwr_irq";
>>>>> +
>>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
>>>>> +			clock-names = "iface", "core";
>>>>> +
>>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
>>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
>>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>>>>> +
>>>>> +			iommus = <&apps_smmu 0x0 0x0>;
>>>>> +			dma-coherent;
>>>>> +
>>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
>>>>> +
>>>>> +			no-sdio;
>>>>> +			no-mmc;
>>>>> +			bus-width = <4>;
>>>>
>>>> This is the board configuration, it should be defined in the EVK DTS.
>>>
>>> Unless the controller is actually incapable of doing non-SDCards
>>>
>>> But from the limited information I can find, this one should be able
>>> to do both
>>>
>>
>> It’s doable, but the bus width differs when this controller is used for
>> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
>> only what’s needed for each specific usecase on the board.
> 
> `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
> properties inside the board DT. I don't see a reason to deviate.

Just to make sure we're clear

I want the author to keep bus-width in SoC dt and move the other
properties to the board dt

Konrad
