Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE0342CAF
	for <linux-mmc@vger.kernel.org>; Fri,  5 Sep 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070877; cv=none; b=lPC7WEC5PRfBJVLCWqZ5HO3DP7egEs2hG1wd4mCOnfx4ieuAMEyRVqLNfC50DM82faKWzBsA6S+h8Nswe8sAF76ixf08LPR5droH/YHKLuOFFfyhc8ldYI503MVEHobwfT2y8NgJzEVXoUxPP85oz9aTEWtdB9zWL1oXIfC16oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070877; c=relaxed/simple;
	bh=eMmQ9OoGm+P5E4eaGh3F1MRJISstesFzwHdqyCpi4pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAAPVI9NdLjXVJZcZi+upSM+1WeRdcqpinVy/zIm2iazLMiwiKY+yxlj1WzW7DZ1jrinTa7iB1NQC7s7xwpki6bi7C5FlBsp64RJhkb/CwkNQpgm+0Kb67GWdaax+h1Z3CipJv0t+IsfxOJg8F88Halct2mICV9JhEdYE7ZLMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QEja0c3G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QEja0c3G"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856lanJ024267
	for <linux-mmc@vger.kernel.org>; Fri, 5 Sep 2025 11:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/FpbTHZW4xFomqVXWX7ayTQvBYf6qoBXa0d+diUXkvY=; b=QEja0c3GC5hhIQb2
	fD9baFhbJ7Ms/iRoXZlJedqpURgY3oSaACrPnfba2EdQFzNkeTWIVxerLFDbesup
	WBz8YRPJ8ZC/4Kkx1DhO8p2gh+gjH3O9hD/EwkO+Sgt+0YCjrrkcqbaUXP+WMkoJ
	R3ApghoHAd/mSNCKhRSu2mV8b6Xj3sFh1e8K8ReVMswfAhNaYV2zOcdIKdpR+737
	9/DVisxAymcd6g3NsiHZ3eNFeqpdX8ig8AnXQNN/qA3P2nd3uiGuNOZzY3t9lIU7
	Xtu+KypdF7mkzV6hITjeNtfSe+zNmCaiv0YMNjPQO61bA3N1CprYrJSaFdeq8r7w
	imAKAA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fts4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 11:14:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-80d884c99e2so43886485a.0
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 04:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757070874; x=1757675674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FpbTHZW4xFomqVXWX7ayTQvBYf6qoBXa0d+diUXkvY=;
        b=eXo7zofuhykRfC3Kl9g6zsgFu8lkZxusn33talADAwjC1/+5h1TrxpzOgbmAV3C5Ss
         hEXH0psxIcErYDkW1vt9gRtFBHUFOdC9UJiVoB/dZq6+2DhAytdODhfPh2VrA0IGv3xb
         TO7Rm23UUrPoluwdbrTfc28VkajjtnDCvIdKXhpIpLvTxkU7yJ2BB34TCS64hIVbNeba
         rEdLPYDCsh4nMa8UaSYlJG8NjWfDRHALhHDBUx0jYm5psx+zt7rt5OuhxykhYr/3NyCf
         bLlsaSFavSaVkX1xoSHbREU42e7+zXjEmguRhLacLe8udFWTlkHfWzx9e8lvf+MhRd8q
         NjYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs72k0bqscdpLmUCWbh1GbvVTXSoS4lBV3Ia4NGyqfoNd1YEiezRoGvdGftiwSEhv1CL7pCwa0c8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7GNb62K4sR1q2fYhymXGFCAh4OkiHaguhz73kk3cUBe301IT
	PG29/siY0ZtjvGEFTngon/hoCRseZaWSj+k1HGJafh4QtjqLbiKwDHvxSCGHjOuVGl8zgGBh+ci
	00p1YHArD+rWwHASl5xjaPznbErR3HeHQe+hbd3HL5MO25az0RJAzgUpJ74/OuW4=
X-Gm-Gg: ASbGnctibV/PccMsDmH5oN+J2ppuzPD+BUGXIiR4ynA9vf43/9pND9U5JzvDtDNHMRx
	v9+YlGWwYEy4OH6evFLRN6EHPoMjcKvIjj6l9W1qnxnPED4Rc6PsAqtZYHEa3wwzvq1h7E/wMj4
	rD8SafvatoPIxCmSAFgOz51ZrMQkPT8SqkVjgYfRDPliXi04EfdrSDPzQuKD+jdq2F9b+6PCgy3
	nWrySvgnoLBgzMbzFjhW2Z7ekpIi0hqe9KNN068rJjvCCUL9Bryyp4HmIlSVeTGYPYXhHfeIWYl
	ClebY9x0mWIhoDIvJ6bYoOv9YJ49Hu5266oVSrJpS/LglErdM2M7CGwwB5vqH9qIbshZgmD0UOK
	OliY4oaAGv36cK3UKGeN39A==
X-Received: by 2002:a05:6214:2a88:b0:72b:880d:3bfc with SMTP id 6a1803df08f44-72b880d3c5amr24659186d6.2.1757070873611;
        Fri, 05 Sep 2025 04:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhxBIevK2sCdJCUPTxNgK1ElXc44o+jt15YDs8l2kK2RYkNbTjat2e9c4WHF0UaaGbTJuaiQ==
X-Received: by 2002:a05:6214:2a88:b0:72b:880d:3bfc with SMTP id 6a1803df08f44-72b880d3c5amr24658896d6.2.1757070872870;
        Fri, 05 Sep 2025 04:14:32 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b03ab857474sm1508366066b.89.2025.09.05.04.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 04:14:32 -0700 (PDT)
Message-ID: <57ae28ea-85fd-4f8b-8e74-1efba33f0cd2@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 13:14:29 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and SDC
 pin configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
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
 <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
 <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
 <zofmya5h3yrz7wfcl4gozsmfjdeaixoir3zrk5kqpymbz5mkha@qxhj26jow5eh>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <zofmya5h3yrz7wfcl4gozsmfjdeaixoir3zrk5kqpymbz5mkha@qxhj26jow5eh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfXyicbjMEhkdwV
 TTfNfJRWnHcTp5q9VeNcplUG1q9QQj9/FrJkF5Ug4DSqon4iR1vGEwvCoHKfC9Nf1x8t5spnjfu
 V8MjgdVs3T6uz3SWEVxpaxdGpli9egjptFAKRVYa/Lh3nxnhTFjJv8iL+G1gtIgJSKi1HHKBsgz
 0KZurDGSpjBonx3a0tOPWKubk45ASLmpO+eTzCbOv5ySC4bydxKGeoAUSyO5W1mMQRzETJVRplG
 JnLGl8DhjqjAsuYUFBKTZCPiKVQDF924qKC1TF+teQJjHMJW7w2I3HNiIntU4hKP4oDizwEl+QF
 QO6jb69sheNfTUBsRwh28i4akue7Zf/be1Tozz84ZIN8ZxmahrnqLFKl4fSAkvq3/kZHEvmi8Ol
 qxiDhVw+
X-Proofpoint-ORIG-GUID: orZSg0PF3w2yeOhKee9a3xgoKYdQ4a18
X-Proofpoint-GUID: orZSg0PF3w2yeOhKee9a3xgoKYdQ4a18
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68bac61b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=HgT1ff4I_b0h3GnEaV4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On 9/4/25 7:32 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 04, 2025 at 04:34:05PM +0200, Konrad Dybcio wrote:
>> On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
>>> On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
>>>> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
>>>>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
>>>>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
>>>>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>>>
>>>>>>> Introduce the SDHC v5 controller node for the Lemans platform.
>>>>>>> This controller supports either eMMC or SD-card, but only one
>>>>>>> can be active at a time. SD-card is the preferred configuration
>>>>>>> on Lemans targets, so describe this controller.
>>>>>>>
>>>>>>> Define the SDC interface pins including clk, cmd, and data lines
>>>>>>> to enable proper communication with the SDHC controller.
>>>>>>>
>>>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>>>>>>>  1 file changed, 70 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>> index 99a566b42ef2..a5a3cdba47f3 100644
>>>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>>>>>>>  			};
>>>>>>>  		};
>>>>>>>  
>>>>>>> +		sdhc: mmc@87c4000 {
>>>>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
>>>>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
>>>>>>> +
>>>>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
>>>>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>> +			interrupt-names = "hc_irq", "pwr_irq";
>>>>>>> +
>>>>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
>>>>>>> +			clock-names = "iface", "core";
>>>>>>> +
>>>>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
>>>>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
>>>>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>>>>>>> +
>>>>>>> +			iommus = <&apps_smmu 0x0 0x0>;
>>>>>>> +			dma-coherent;
>>>>>>> +
>>>>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
>>>>>>> +
>>>>>>> +			no-sdio;
>>>>>>> +			no-mmc;
>>>>>>> +			bus-width = <4>;
>>>>>>
>>>>>> This is the board configuration, it should be defined in the EVK DTS.
>>>>>
>>>>> Unless the controller is actually incapable of doing non-SDCards
>>>>>
>>>>> But from the limited information I can find, this one should be able
>>>>> to do both
>>>>>
>>>>
>>>> It’s doable, but the bus width differs when this controller is used for
>>>> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
>>>> only what’s needed for each specific usecase on the board.
>>>
>>> `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
>>> properties inside the board DT. I don't see a reason to deviate.
>>
>> Just to make sure we're clear
>>
>> I want the author to keep bus-width in SoC dt and move the other
>> properties to the board dt
> 
> I think bus-width is also a property of the board. In the end, it's a
> question of schematics whether we route 1 wire or all 4 wires. git-log
> shows that bus-width is being sent in both files (and probalby we should
> sort that out).

Actually this is the controller capability, so if it can do 8, it should
be 8 and the MMC core will do whatever it pleases (the not-super-sure
docs that I have say 8 for this platform)

Konrad
