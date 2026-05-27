Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1D40DFDC
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888784; cv=none; b=Vh95wwk+p0FhTrz+I9zA/5gmutiqfZEA8H4rjzLC05UNtobR1W4D7/oHuKCIU0dBtGmaU5rz53sl2FygrzYRlhBBnrYbY6TM6sDRpA+2WHp9na5vdsUe97tjE87rIYvDd66xp58WUOj22nnAU2csU9czd9BY7QzBscPvDtNXGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888784; c=relaxed/simple;
	bh=GeKLc7/+dJvLDIky390YOmE9RaNQtsnp6BD0MQMUEeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+1mEiSleItSoXyNTveqMVcrhNv8vqOqL6PgpKp55Z7gsyztRFGvvJolJrOJY+TSnN64bdOIFAtrt5/uUHGakPfUnXQi9xw+KX7uSrEGdhhIiAXGW0Fq0CU7baUcpvL+kJDfgfQSlXf5sSIMwiFyF0vQ2NacdGebH0p3WI+woeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WHfLAHLX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BMaBncSq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WHfLAHLX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BMaBncSq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RA6dP21149508
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 13:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CL59JHQMdaZ9xSO2ZRHaR8OddiR/bapur84ZCcORKo0=; b=WHfLAHLXddp08c3h
	sDZgxxFDiMINQqglTS+vQtgTGGoCi4s6zyQWM9ft+o1zGgHOPqfAL9ufQmBcn0CX
	Z+C/ul4DgBa5BR7KVgqtzDmlvYDqik6jWm8gvRj1Vtt8t+G97DUNJQFM819RWyvr
	5CyIJiYWGpjsfHHXfZlmGyNbhe/bwFRLXwT4wqhfzuaxLGkCT03J+fNlIlpcTTGC
	rQlFVzv+oy+FbWzkzKuTt+4/QOvz7ImiBwkW4JSs88Evbn4X2ZcspqUhoeG/70Kj
	XbeNXO3m4GMXQyGsV/ggtSud/dN3/BHMbfGA9S2t1ZlFls4kcHTRPln9axtEI3c0
	CHJOZg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edxjsgnvc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 13:33:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso7506221b3a.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779888781; x=1780493581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CL59JHQMdaZ9xSO2ZRHaR8OddiR/bapur84ZCcORKo0=;
        b=BMaBncSqr6ifLU39d2icZY0JyVpxzVJD/8EtWg+K2iLMyhpo29/Z+GqGbVcyiRQsgk
         S94JEbnh9sb8/PiYo3ZsiXPSZVXjE2r+tP/ZBdlj/LGjIKxXvCXl86TmE1Ya3jvSGXSf
         uoLwuXF7LnKrr51Kvrn0KvoEb9xaWnxJQBW3pvSfT3oYdGDk39MQnEGy0YE+oA3gcZsb
         f81VdlYTpObAZYgmmLy/zMP/s1pbxGLJ5WWB8ZH05Uiy8z6Yunc0DcR3zH8vVmGBz3+/
         aNGh5OECPF47rTkbBRFRp++jXz5w8F6/ISLPtQKmCXT+YEJZJoHs+OJo2ri6ZSaC5jad
         RJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779888781; x=1780493581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CL59JHQMdaZ9xSO2ZRHaR8OddiR/bapur84ZCcORKo0=;
        b=jIN99gh+oj+JYItrCvoUO3tBUzwSNeKwN8UIg2iE9wAcsg0g/svC+70REypxqZjCeE
         hZ976+4cH5pZ+xQYWn2V+6vXIxQGHUrjtGcuw4JdXcQesRaRMBn+wQRrS+4qU/aQ1AAY
         bIaYlSIKDU7CQ4TZCadjtgX1D5VhLPzi7kL9hKGhQZHWLD+TD3UnQQXWXSrACJZlCa86
         yxOX/NKzOpxFksB5eFjBXLb/SJTu+t7X+Ka0bPeibiWp4DnCDvUwf9x8U3OnqJAYFnv9
         Qhqr53HM4OSYfX6fgqdYLFG8TISvX0bja+m5PlBtZglfb/4/qVmGyHuXe9aeV6cKQidE
         9IYw==
X-Forwarded-Encrypted: i=1; AFNElJ/7/UfX0JfJ9+3axQKEdia0R0G0HdZ8lRpPGTSTeYiJHeEMIZWECu3JQXN8ihJ5CBpwIQfWxWWzf0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHDs89hgspyBn9f0nu/ESaRBIsAAX0fN9QoZvGnHIwDLHoXAh
	EUnvhezeybop0PBGDw2MgrfXDSOjyR7jq//uikFZteyGuw2LHPu6C6XLCA77WZUYfSVE5X0GXPs
	DWo6d2L4HcFBMtKJ0bIzPZt+LD7zIrNol9N8YGmXCsdmQoMLbc6omIOAq2uRXX7s=
X-Gm-Gg: Acq92OFHICIzFQb3h03Zm9QeDMKTuBDnOW//XXhiVPFUQAVFFPql+JaR6syJafxMqak
	IUvEjyk/H2YISxWkjlqbzgBDfYvrsUMfRNwDn95YCMPy5fJoW6/uEPVQWnaPKTsqZv+zsNjrNgg
	sohmdoGLn9byEH0xPiQ8ZOQDUL4LsVcTWtWkF+ygJ+ExZofqj0xu/kb0xCAOcv8hpUMjVaUQFAG
	kAZfcSFhhW4yDMNyrADRrKdkS8da6sHW86I/QzC0+RZG1PO7ZPn/ECHCCgO3byCoqpXSo4w+6ht
	/ddSTioEesCn0b0WAl8cRDuDmeGHSVZO55CcIFVSo4Qox9hM0yrzoNmw+YKSZFQcb6yUvcdOTIb
	rhpc0nUNKBLKk6C04xImigckSxZZO5MxPaUVrhNkXiGFfrB6N
X-Received: by 2002:a05:6a00:124d:b0:835:cc47:6ff8 with SMTP id d2e1a72fcca58-8415f3a54bemr21955232b3a.45.1779888780740;
        Wed, 27 May 2026 06:33:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:124d:b0:835:cc47:6ff8 with SMTP id d2e1a72fcca58-8415f3a54bemr21955194b3a.45.1779888780182;
        Wed, 27 May 2026 06:33:00 -0700 (PDT)
Received: from [10.219.57.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6e80288sm2663478b3a.10.2026.05.27.06.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 06:32:59 -0700 (PDT)
Message-ID: <3758be2d-4553-40b3-8ae6-bc3e502d0531@oss.qualcomm.com>
Date: Wed, 27 May 2026 19:02:53 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] arm64: dts: qcom: Add Shikra CQ2390M SoM platform
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
References: <20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com>
 <20260522-shikra-dt-v3-3-80ffde8a3dc4@oss.qualcomm.com>
 <63752557-6468-4aef-a847-06aa39ce108d@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <63752557-6468-4aef-a847-06aa39ce108d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=C4PZDwP+ c=1 sm=1 tr=0 ts=6a16f28d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ze1idgdxkBYruiX_gtsA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEzMiBTYWx0ZWRfX/9llgkvc+XiK
 cwbwK9FRfEGFph7v3udxW4+kXN0faG/iZmb4agfXn159hkwbjfBVfRzeolU7UbNV4gmthZZ1gjB
 T1Fk67/hxtFzidX2TUu1jVEa98NpEAXk6kItgxHPRWqrG+9Nr9bzY9UDSoRBF5KHDDgp9kdyj70
 ZZAupkSSH5AMr3P+nI3XaH1AGQXXqyqFIfr+kuGboQVzH+bHNjPq++cKABecXbI2kb0PI/8jFw/
 pTNUB5GgAgfvk6laVjBMrGacq52huvg4CK01yzaMYU+vH3Tfy199QxB02jn3HKEevPDu/6JoRKy
 S41xFN6FGjV+PmE5FSzhnCcF5aGv6RqOyqLkw1mQ5k19s5DKEVuBHupAXJ2U7cRsuNRCMDdTP7d
 fsVFVs9DyI6bS+CBugpVdb1/jHvmo3slBpMSJQwIp4LcwrNPzOCNGRu40xCRFWpKyJwhLsIflGE
 bi9b4oM8hp1td1dEzqg==
X-Proofpoint-ORIG-GUID: 44AWEkAm8NASdUYr9gXk_dyqtkQbiAWL
X-Proofpoint-GUID: 44AWEkAm8NASdUYr9gXk_dyqtkQbiAWL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270132

On 5/25/2026 6:46 PM, Konrad Dybcio wrote:
> On 5/22/26 8:02 PM, Komal Bajaj wrote:
>> Add device tree include for the CQ2390M variant of the Shikra
>> System-on-Module, a compact compute module integrating the Shikra SoC
>> and PMIC for IoT applications, designed to mount on carrier boards.
>>
>>    - shikra-cqm-som.dtsi: Retail SoM with modem (PM4125 and PM8005 PMIC)
>>
>> The DTSI includes the common shikra.dtsi, adds PM4125 and PM8005 PMIC
>> regulator definitions specific to this variant.
>>
>> Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
>> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
> [...]
>
>> +/ {
>> +	gpio-key {
> This is usually 'gpio-keys', reglardless of the amount

ACK

>
>> +		compatible = "gpio-keys";
>> +		label = "gpio-keys";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vol_up_n>;
> property-n
> property-names
>
> in this order, please

Yes, i will correct this.

>
> [...]
>
>> +&pm4125_resin {
>> +	linux,code = <KEY_VOLUMEDOWN>;
>> +	status = "okay";
> A \n before 'status' is customary

ACK

>
>> +};
>> +
>> +&pm8005_regulators {
>> +	status = "disabled";
>> +};
> ?

Already there's an ongoing discussion over the thread [1].
PM8005 regulators are controlled by rpmpd so it's not expected to be 
enabled here.

[1]: 
https://lore.kernel.org/all/20260525093453.edmqryggp5kcqxxy@hu-kotarake-hyd.qualcomm.com/

>
> (also double \n below)

Will remove it.

Thanks
Komal

>
> Konrad

