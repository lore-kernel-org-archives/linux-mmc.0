Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5653469E3
	for <linux-mmc@vger.kernel.org>; Fri,  5 Sep 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073896; cv=none; b=cfiFiZsMUaIya3W37RWOImvYaYT3gRHm2EGE3f5lFCY1Qwxqgd5aqB25AXlX+93qFLsGuXxEg4MbCN6XKKErHH49U4bg6pChBzQPwdgTxHDcAX93TBrHLuG4rcvwREWoo4msrb9rmu2YUL1vP1UDrixTGutyVDWO4Ji3pbDZayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073896; c=relaxed/simple;
	bh=CKJR1UXErJMqU7CHSnOAY8gQQIgTBqYaQgB/aD+Ka9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pu2FNLpyXZN6o0pwh0Q6c3zGwZD+Rd0BW1l5/dSdExqZiWcHFy8JTUUp3WRQqDKqkiDIZoGYLdGrQAAiS6NB4mZdSFOdIFc7vta2APeTTiNSbdb/Z4HJlG8zJPrD2iBU0mqxyolmT/rW1Zyq618iuhTX7KNypKHEEuBNWnG/wOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GBoN9RpM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GBoN9RpM"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58578erk005051
	for <linux-mmc@vger.kernel.org>; Fri, 5 Sep 2025 12:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7V6g3pF18kS88E7syRdBPWgAVN+Oj7kxFaYlpmHqpUA=; b=GBoN9RpMfO+hNpxR
	LrOMhXgWgLdwvnQKotq/Nyvhxz3rnN0KBBFO+k8901ZupA3s3dyHJhW8zbzkFGZ1
	l81PjdatDe2e2iYdjlvxN8cSG1xDEC2Dd4gUnZJczVudQ60g1syVh2VgYkeCqPLS
	83IJHdgRX5Hw6bZS5TxBgx3mYAt0RCl0IwFVDQ2HE4y+1EnlZkrZvALocQB2jGNS
	p0rpSfS8X+BZiFlVAWyl/ZG80+Da4hKJguX02ffnyuVL5IGWwQVIEp/7Z1JdMyIk
	qKqkJijN5/u13fK9up7kph88hxf9zmGRLJXfHa35NkiZUcyV9TEDq8iqEYmVIoNl
	Bb5sqQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8sb5up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 12:04:53 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-52f4691fbbbso119004137.1
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 05:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073892; x=1757678692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7V6g3pF18kS88E7syRdBPWgAVN+Oj7kxFaYlpmHqpUA=;
        b=rSYWJkMHNhyMSnNMZMqiwtWYMC55QkH+mE8e80gJXF/I4TvreSKtRX6mJi1LLob9sW
         yXMLsLxxQJV8SZjlJkiLIb72C24Tz47Bwin7nJ5jC5FenO1evg29y/IH3SBCNHH38QB3
         TIZcewpK+uFVaApuN6i2fdpyGaURIv5fs3u+ht54FBbE9VR+oQKdd1SSQdLbf3OIoJZn
         Rd2N9ZKcHzsDTiZ37WB1D6wgzuo9lW2i2UsLdcwUp20AlgaiIjAzi1q2L6K5vAvCyAHU
         Hjy8tncEN1T1DYVVR5YSILJ9JSo0+8LkSIfupehs1hz0xKt91CF+PRrQOgz4z2Uu05z2
         whgA==
X-Forwarded-Encrypted: i=1; AJvYcCWSIKc9BilrWROxCR+6mRfCGoxvH9H3Y80FXrZ+SAcnK1bmWWYAyhciykK3/48fH5/ipW1FVJsFir8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVCMw6zcTp33B3Sc/m62lK1w1Gxl7zMYnwPkdQRo1hwZO6YeQ3
	X8k/Yj3fV7XdzE2ioupF5F8t2w/ToWo9ETTV22s9XDpacDfLLu8Gz67zhOsMxpctLvv3QbxFlDR
	sLrKYe8oMLYpJnq4Qpip7gUuic08kTuUP2BJvYf5MuKu6WOKAwoEVGhksy6RdJUQ=
X-Gm-Gg: ASbGnctiUUwjfmQSslNdTpu3TplMItyLJY6zL6Q6L0J4TCL09GrmoviBbCkKhYMcwYu
	onGH99uLw7a1+TKUrQSbNDdAu8fY5eraheS63qaZfPgtiYNwBdSbu/o7bR98VxWPeoQiLXy231p
	8pH76MARZTdPIPmexfRRiwJKFSzUCQtTGNIWmd1RRp1bGV6y6ry2xh2Av4LYZnQ943p9XTbUCNe
	d+1Cee54ACz+Ku1oQRZ+wpbfcuC+WiKJd73kzrT4ek1enjw4C2oRH5FSbQnJBZoozFu8HTxsCSG
	ItqOKxFRHXIRcJJdj0PcQoB2hLGkUnFCdy52fJMt1kRRRmIGzZdk9MsePPk8PmWgn+Pr9tHbN8y
	uDbjZYDmUY0ezToBevMlJvA==
X-Received: by 2002:a05:6122:630b:20b0:53b:104c:8ef with SMTP id 71dfb90a1353d-544958f1256mr2482510e0c.2.1757073892291;
        Fri, 05 Sep 2025 05:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYH6Gpw2ODnZPU7Gl4si6T8PTWLun5b6ZfDzHmiq7n2fFtXqLoZORHaroZpIDTDGTs7mnc1Q==
X-Received: by 2002:a05:6122:630b:20b0:53b:104c:8ef with SMTP id 71dfb90a1353d-544958f1256mr2482490e0c.2.1757073891752;
        Fri, 05 Sep 2025 05:04:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ae40sm16176794a12.44.2025.09.05.05.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:04:50 -0700 (PDT)
Message-ID: <53aac104-76fb-42b8-9e0d-0e8a3f59b2da@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:04:47 +0200
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
 <57ae28ea-85fd-4f8b-8e74-1efba33f0cd2@oss.qualcomm.com>
 <xausmwmh6ze5374eukv6pcmwe3lv4qun73pcszd3aqgjwm75u6@h3exsqf4dsfv>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <xausmwmh6ze5374eukv6pcmwe3lv4qun73pcszd3aqgjwm75u6@h3exsqf4dsfv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX+5Gs4CPURY3E
 JMBucvS7WZeqxJsPnwX/A/OQphFlAgyR1JAE2MyYKvMHsvNiTe1ACPVkaZcRTvlAdqwK9mDjYxl
 7R7z5byJskO3t8FlJmM/Fz4mstTMMUBbpx8QN/ICoTUMcnfgva1G2sQC/xc/zkCSSPyazUOaY4y
 sG1ImoWXxtuX//dGr9Tf6RGUczJKEoR7hgNcl6gxuw5DS2r+RXDcCxpi1YERdwI1koQ2DNsbgu9
 OKZkvHVGsmKZVdia9z6/FiIt776afUKHsIFBxsi6MpESJ8vwNrO5kXXDYs608Jk/yt3qQUU7OFB
 jzObc800u6iVW0TDJI3KmW3s7P6LvoFieA6yW7Mjhzxh4tDMpA4B1mt6TVaOqNJR15K/2td0aQ0
 oEsSqE6s
X-Proofpoint-GUID: Ixu4AtIxLd4oJUVSKYHQu3bM5rK8FhUP
X-Proofpoint-ORIG-GUID: Ixu4AtIxLd4oJUVSKYHQu3bM5rK8FhUP
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68bad1e5 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=GsIQqm9gGXrf3KcGJ_IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 9/5/25 1:45 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 05, 2025 at 01:14:29PM +0200, Konrad Dybcio wrote:
>> On 9/4/25 7:32 PM, Dmitry Baryshkov wrote:
>>> On Thu, Sep 04, 2025 at 04:34:05PM +0200, Konrad Dybcio wrote:
>>>> On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
>>>>> On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
>>>>>> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
>>>>>>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
>>>>>>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
>>>>>>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>>>>>
>>>>>>>>> Introduce the SDHC v5 controller node for the Lemans platform.
>>>>>>>>> This controller supports either eMMC or SD-card, but only one
>>>>>>>>> can be active at a time. SD-card is the preferred configuration
>>>>>>>>> on Lemans targets, so describe this controller.
>>>>>>>>>
>>>>>>>>> Define the SDC interface pins including clk, cmd, and data lines
>>>>>>>>> to enable proper communication with the SDHC controller.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>>>>>> ---
>>>>>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>>>>>>>>>  1 file changed, 70 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>>>> index 99a566b42ef2..a5a3cdba47f3 100644
>>>>>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>>>>>>>>>  			};
>>>>>>>>>  		};
>>>>>>>>>  
>>>>>>>>> +		sdhc: mmc@87c4000 {
>>>>>>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
>>>>>>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
>>>>>>>>> +
>>>>>>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
>>>>>>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>> +			interrupt-names = "hc_irq", "pwr_irq";
>>>>>>>>> +
>>>>>>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>>>>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
>>>>>>>>> +			clock-names = "iface", "core";
>>>>>>>>> +
>>>>>>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
>>>>>>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
>>>>>>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>>>>>>>>> +
>>>>>>>>> +			iommus = <&apps_smmu 0x0 0x0>;
>>>>>>>>> +			dma-coherent;
>>>>>>>>> +
>>>>>>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
>>>>>>>>> +
>>>>>>>>> +			no-sdio;
>>>>>>>>> +			no-mmc;
>>>>>>>>> +			bus-width = <4>;
>>>>>>>>
>>>>>>>> This is the board configuration, it should be defined in the EVK DTS.
>>>>>>>
>>>>>>> Unless the controller is actually incapable of doing non-SDCards
>>>>>>>
>>>>>>> But from the limited information I can find, this one should be able
>>>>>>> to do both
>>>>>>>
>>>>>>
>>>>>> It’s doable, but the bus width differs when this controller is used for
>>>>>> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
>>>>>> only what’s needed for each specific usecase on the board.
>>>>>
>>>>> `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
>>>>> properties inside the board DT. I don't see a reason to deviate.
>>>>
>>>> Just to make sure we're clear
>>>>
>>>> I want the author to keep bus-width in SoC dt and move the other
>>>> properties to the board dt
>>>
>>> I think bus-width is also a property of the board. In the end, it's a
>>> question of schematics whether we route 1 wire or all 4 wires. git-log
>>> shows that bus-width is being sent in both files (and probalby we should
>>> sort that out).
>>
>> Actually this is the controller capability, so if it can do 8, it should
>> be 8 and the MMC core will do whatever it pleases (the not-super-sure
>> docs that I have say 8 for this platform)
> 
> Isn't it a physical width of the bus between the controller and the slot
> or eMMC chip?

No, that's matched against reported (sd/mmc) card capabilities IIUC

Konrad
