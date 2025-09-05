Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723234F478
	for <linux-mmc@vger.kernel.org>; Fri,  5 Sep 2025 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075189; cv=none; b=MrkzDkiLyDoTA993XF17JAPVW+WozOliUDDduX+Y6etIkfkE2zSyKDlYeU2C3MydlIoUbz7BsEyW98zU4Fj9TD7qPHt6eAUNai5jge6CO5HW2YiumLwsF4MnYW3/ytD8eyDLPPEj82zAyHWN9lRxR0iwfNmAoTlD4mha0hnRF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075189; c=relaxed/simple;
	bh=JkUf2vIGxOiyFPoVNdwA17YFnAIws6TxkLfW0TPXFlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4i4V9GLhNsNXnDVKH23FlWzECMNYz4yk8bYKjcb/r48MpezLCZuu/0BuLUmwarvfWDW8KZy+L/TSN+8A/Kp+QESud2Lq384jrfg6i0SZ8tcnQyqsfm6mR0Is9eFbrVQ+ifoik/aTXypeNvlXflvYj4d/YaP5jEXEicV4XNPBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThIs20tG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ThIs20tG"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5854RXTp018501
	for <linux-mmc@vger.kernel.org>; Fri, 5 Sep 2025 12:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kyI0487W0JqbBUoFU2qAu9jSBfGKKX4t5Zjxjpcd4FU=; b=ThIs20tGdSL4xOLh
	zGd7ULBE2BUErfKiBlNO5oeUXwhrBE5DtRFI2Jkq4mM86mMQcoAuB/N9FtJc4kjD
	5mfvZW3bdqw0RouzAjSFZkcxe2BNrVv16FrN9wXzRhj+DnWzGAH3xS/jPi5LUJ92
	oOg++dYIYcYZ1M7VsEv2krWlmLwpFZ4/a7kSpqFc+XIG3GUr10Y+y7AbD87x5MAD
	O7Ei1ghpuyNUCV3HRSOU+epkRljIFcBTI9qcB+tmk4io0y9wVxKl1GjPMmLAaYj2
	ONYPAV4BUGdA1EOMZfdQPN6jCvjHZNuWi0Q5nh9rHV1ZyIehNux6vnrz+NAn748c
	TtxMhQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebutytq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 12:26:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso8156891cf.1
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 05:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757075185; x=1757679985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyI0487W0JqbBUoFU2qAu9jSBfGKKX4t5Zjxjpcd4FU=;
        b=Vfnb5bD/BDsP3lXM1i3+mI7pM772COnMgPz+1cYvDPKRXBpv2xGknXBPDveMwaCTR6
         gnKV7ZDwVcWzDn1HGHVDwWwHVQBBJw0o3PGhd8AEsROhfjdyfH45ZUW0dd44iBkZZeuv
         X7SJRwjM7qzN9lLs7BumSV0bUMM5gzCnpFIQ1MSpAU1ZLukANIyNTe+K+ejTb8PpMZNa
         wtDitT7DaTa0U6IGFrM+ieadckuLMskESTPjJiEwn4oHkhLKJf1Yz+hUm0S2xSFKQIgV
         motKuaGPOq0x7dP/e0kVrXEAKDM977nZz14NkBzxMEo62tOakEai1lxe7SbHuLSBKX9F
         XKMw==
X-Forwarded-Encrypted: i=1; AJvYcCVnDKKidW8W1xsheMvsJr1YCiK1KL/laWZYw81n5OfrS18OSKGAsuQPuqLFFk4AfKLYSOMycikNaPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZng+sqOK6kfCOLmcoDNpur9hQ/FLlGgAfFMebGVbKJr9GSlJ
	Hu2aFV0boCnAZQ9vuO2X1+MVPx1ZYgjXJ59bFpgoDLw0jvo/PDvYo6YEUzngQo7EAMY2ejtb4h/
	h7LrYC+Bn/NJqxsDKc61sVuHMu7smR+ZK1Xe1rXKzirG0VgMGW4k0cmqHqJKVHnw=
X-Gm-Gg: ASbGncu9frTEPO8Z2W8U9UbnwSsaJV2mfGQRTCBMJ955NrCanqyIi5y4HzcAJwpnnOS
	nZ5RWNZred5mTQ1VcahwbeJHTZV85Cn6cwux/wuOy5G1JsNEUr1Ndr6b7L+/HxVITUzcspPpDsu
	IT4JnfVfvTZ/yUz27ik1vmAzHFkCsQBuD2Ouj4YQYsmGot21ZFxgcinU2rFdoAAf4gWrHwIlHQI
	9DEu3JEA33qpepe5F81HGWbBc3sg5nN5dYIvHE4QUmHFJI0ASR4i1vAc0I8bwaxPV/l2z5GNQXC
	yDVhcijkqZKnKjw0Ql6p8583yCORzAsWG+8LuXpjCzX/iKku1kdUqhP9cMpvJ/eQDilLHmxXsgN
	HcbnQWsbJUE2Kgc6/XgDP4Q==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr60505111cf.2.1757075184927;
        Fri, 05 Sep 2025 05:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHIZ1IK9XJ4FfWiCBoKZm9Dc77t4hxWRO8SKHBZ1qvz1azh9QEBjD3+6lYU1NQiV7h5+pluA==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr60504851cf.2.1757075184359;
        Fri, 05 Sep 2025 05:26:24 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm1546636466b.12.2025.09.05.05.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:26:23 -0700 (PDT)
Message-ID: <34d9ce02-5711-42ec-913a-772ee744b7e4@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:26:20 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] arm64: dts: qcom: lemans-evk: Enable first USB
 controller in device mode
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
        linux-i2c@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-10-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-10-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Azf5ItFj8j24U7gYwid7IUxfGaaeiqTL
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68bad6f1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=B3P4ua6ZyXwAq7e7NPAA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX5BK2K2EdrP1b
 aTPGDieRrngPVbCGArUWL4dGclelXf00apwctpcI3BdlbSxLaPDCkD/NPsnObbD5sRikjKmt0Qo
 8zhzwbxP3sKDtvqE396jwPTiLZhdxWqHdQs/foLE3B7NdeUMa0/Fg3I84axjrSmxQDZpSdAmH+o
 tFTGpE9RRNfh1ezXyPhyN/wmlTF8yW4Mf0H3ZrkaJ2JznTzdf76C2esVKcdbqQxnDKRkRj0tQRW
 TRZlt7byaUZQSBkA1lkDvOG6yjlJTFH06+7BlQ6ZDg+dSqzjoBKyjMulhvhlhpas/uQ1tD+2igh
 RlIfJZb1TPdn7La6p1ZKRA2uWmudIt2IP7OhttwJ9AvCskWL41toWlFi3aAK6N5dBpfd6Lz9i+e
 ZO/coh3F
X-Proofpoint-ORIG-GUID: Azf5ItFj8j24U7gYwid7IUxfGaaeiqTL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> 
> Enable the first USB controller in device mode on the Lemans EVK
> board and configure the associated LDO regulators to power
> the PHYs accordingly.
> 
> The USB port is a Type-C port controlled by HD3SS3320 port controller.
> The role switch notifications would need to be routed to glue driver by
> adding an appropriate usb-c-connector node in DT. However in the design,
> the vbus supply that is to be provided to connected peripherals when
> port is configured as an DFP, is controlled by a GPIO.
> 
> There is also one ID line going from Port controller chip to GPIO-50 of
> the SoC. As per the datasheet of HD3SS3320:
> 
> "Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
> not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID
> pin low. This is done to enforce Type-C requirement that VBUS must be
> at VSafe0V before re-enabling VBUS."
> 
> The current HD3SS3220 driver doesn't have this functionality present. So,
> putting the first USB controller in device mode for now. Once the vbus
> control based on ID pin is implemented in hd3ss3220.c, the
> usb-c-connector will be implemented and dr mode would be made OTG.

Hopefully that's somewhere on our todo list

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
