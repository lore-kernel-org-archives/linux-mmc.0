Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC22246BD3
	for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680548; cv=none; b=GUsLmH44tkglC9wl2PoOcqJTQOrMW4RK0XnPjs7TQmJTu0ptr6FTchz2fGmyKIT3LC3WADiTDmUQWe6K2ptk+tv+tYavK0AYlvjXv11W3rZVCUw0stXtoQNSYVgERA3Lj9S0SXYY6NRmCAjKDZqWM2OX6SdyTu55zKMYdUu3rpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680548; c=relaxed/simple;
	bh=qKSIqsV+KvAGtkioviVhsHDdAWmTF+w9b1unNcPVVFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nX2VJ+0OmhQeJyLbXeRI+e3fMuAsfASQ7nOXuOn9YcEjdBt3c+HVD29EjBwTPNlm/x0/0f5CC6NrO5kA6FcvHiTctxD9utqvZeYsU9xtyBgFsR/1kxCU3+Wn6946vcPrKwtLBhbt2HyiKZ2qSn814xrmSKjwIFOVOftMoXMO/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KE4S5EZA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KE4S5EZA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N7fYS6021714
	for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 12:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iUA4Ux34VVf9K7rAvlG3QrP3wRtZ4mYRuLZS2Rcg8zw=; b=KE4S5EZA8lx6Tzg4
	Jhpkb/rkGWCT4L4d9fBzMn9RWg0iaweCu/RZMMqP2CKaquT6bK/8RCcaHg84x69G
	W716sPfUlGUDlbEsX+ChVznKYR1rLvFKInkJ8g+ioPWoMRC68lCg0jQIsMuAT4iG
	/iZKas6ImwNmnfyt8e6+eHFvNtpbF3Gb2pRlaHvWhtXlPKEywfEoZFb0SDbvxUEU
	bbo1klTTz7dmhNI47MMOeRK0yQzaSyIjCdt3BdrpjBzxQaTKAYKwp+LLHsZ85s4T
	vFCSXsGXl3la4xjis/FbnlWxIdRhl/V4mryoYQbqdIpC8ZpgkHcf6GwCofn8UQoW
	mA9Lnw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rprqmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 12:09:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5af539464so117026985a.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 05:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750680545; x=1751285345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUA4Ux34VVf9K7rAvlG3QrP3wRtZ4mYRuLZS2Rcg8zw=;
        b=Pm+DZ7tWyPdwnk/9ORtZ/a2V1p80cIxlb2uPopDh7PmH4CwAMvFFr/pdRysE6h4oO+
         samL5JhieLeFkmiishmel8D1+SfmT5B8xkynYdQW3q+MswbjwRDDsmTHqhiPXDLXMBq+
         PvQAa/RmwuGkrQ32f4pqiOIU11UFfyCjG9rGB/mSqC0O5YfqEugASK+aaTKEsVYY++lr
         ivKiF2dM8XVA4g5TxOtwVI/wsStRsmLUzPSavs7YMIq40jbSbxjH3HL6teCGpaaF2zDS
         0acIKh8tQA4pml9zwBUh3UBI4wmLLmcoYYtH6b3twXEbWkzII6V44ChqZsmfWy0wvQhN
         brzw==
X-Gm-Message-State: AOJu0YygZdxSS8dqF6cyR8bgEuoncGUIXnhsWk1JKJr8v2/yoz4x/qjI
	aKEO018Z9CKpiygVxMeLCjGMMGywoL6UMI5ecEAhIdt+R5CiFiQ2PuJ9VZEELeq6vKqm9vZDHUV
	kFT88XEtmOs4SI0RzMiRROxq92GvfbmoxSQ1FQr9IeLDn5ziMX/VjPsl6UxXNrrs=
X-Gm-Gg: ASbGncvf3m8m1Dnq8iMVNekhnB0znJrrJZAn9GFmH26Y2YFKfVa6CT7fV7y3ooQowAh
	XY5o0oXnUh7LAea2IrczkZoItkUHl5QlZSRvfoXoyfiVlP3A2QHfoKUOg26GYDPeMoNwUBTWkSv
	Q00thudeP6ylT3BlShL0NxuqMW8fNHz5debS77yuu+51j+uy4+f7dqHFtW3Bw27QbmpUw7SsIya
	MBYGc7kH7KFVpqQulk+TvgagKZ3mtcCZclaXWOQ12xwk38iqVWb/nl898uBvTwaexiEsHEG0JIh
	s6Eoqtjk1nPHUztjguoLhJ95dR5YTyHIN5l4Ibs8apepp/mt3vintOZmLRR8QvdTexJJtVhbyCq
	RQAU=
X-Received: by 2002:a05:622a:9:b0:4a6:fb4d:b4e with SMTP id d75a77b69052e-4a77a27a4bcmr72341161cf.13.1750680544723;
        Mon, 23 Jun 2025 05:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoNMINZTAhhl7CMp5Boaokx/8RjnVYVBHAJiF7SNTYL5MUao5HTMPsguWO70eQQTBb5Hr2qg==
X-Received: by 2002:a05:622a:9:b0:4a6:fb4d:b4e with SMTP id d75a77b69052e-4a77a27a4bcmr72340941cf.13.1750680544191;
        Mon, 23 Jun 2025 05:09:04 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a1857c124sm5866353a12.36.2025.06.23.05.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 05:09:03 -0700 (PDT)
Message-ID: <5bdae07b-a7b1-49be-b843-1704981bc63b@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 14:08:59 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/4] dt-bindings: mmc: controller: Add
 max-sd-hs-frequency property
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
References: <20250618072818.1667097-1-quic_sartgarg@quicinc.com>
 <20250618072818.1667097-3-quic_sartgarg@quicinc.com>
 <6040afd9-a2a8-49f0-85e9-95257b938156@kernel.org>
 <9627ed6f-2bb8-40b0-b647-5f659d87f2f9@oss.qualcomm.com>
 <bba062a3-f96c-456b-8e9e-fdeb0dc2d28d@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <bba062a3-f96c-456b-8e9e-fdeb0dc2d28d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685943e1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=yCTWpnfuZRHAWxVBKy4A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3MyBTYWx0ZWRfXxFpd4Qj8G5Ml
 VkVGIWucQvrmzCcWm9mbqNiKRzzVmxtOUThgU76F05wZhPilCxgrcQTDfohePzA/2CWbObmR1jL
 JnxhPSp9T1ozPs8TiMQAhHaI2iuabs80zEzFhTDpMC9E5ETSMlqb3DOPTyoBCmn1nNAqgt6Xr7Y
 BRAMrLR5VNI/l+7biIJhbS+iq/fbBccQfNkKONUZjnYgmvg9G853nDEA0R4wIZyuIJwv+HzA8ay
 xC4q49Srd336ZVDhd0IGpvoVsTU8hcQ1Zrfgfi5LU6LJcwaIz89mlVeI9ECKg1ygTFRs13l9PUQ
 df4JXBGdrqClEbu593nLIZq8qKGSi8vlvGqTybFsCn5vbfXMTTU46eE9V3+GrckrNDkTqnx7bBg
 KjhjS2gj271Y+Eu/3L45FEmhBQuc4/X7y/MloEzvw/qJL4YeLRk+Oehmvw34qjokj1Ju/Uyo
X-Proofpoint-ORIG-GUID: WghP4iuELQhyP8EsoQgu3G4t6uEYgf38
X-Proofpoint-GUID: WghP4iuELQhyP8EsoQgu3G4t6uEYgf38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230073

On 6/22/25 11:48 AM, Krzysztof Kozlowski wrote:
> On 21/06/2025 12:20, Konrad Dybcio wrote:
>> On 6/18/25 9:43 AM, Krzysztof Kozlowski wrote:
>>> On 18/06/2025 09:28, Sarthak Garg wrote:
>>>> Introduce a new optional device tree property `max-sd-hs-frequency` to
>>>> limit the maximum frequency (in Hz) used for SD cards operating in
>>>> High-Speed (HS) mode.
>>>>
>>>> This property is useful for platforms with vendor-specific hardware
>>>> constraints, such as the presence of a level shifter that cannot
>>>> reliably support the default 50 MHz HS frequency. It allows the host
>>>> driver to cap the HS mode frequency accordingly.
>>>>
>>>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>>> ---
>>>>  .../devicetree/bindings/mmc/mmc-controller-common.yaml | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>>> index 9a7235439759..1976f5f8c401 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>>> @@ -93,6 +93,16 @@ properties:
>>>>      minimum: 400000
>>>>      maximum: 384000000
>>>>  
>>>> +  max-sd-hs-frequency:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description: |
>>>> +      Maximum frequency (in Hz) to be used for SD cards operating in
>>>> +      High-Speed (HS) mode. This is useful for platforms with vendor-specific
>>>> +      limitations, such as the presence of a level shifter that cannot support
>>>> +      the default 50 MHz HS frequency or other.
>>>> +    minimum: 400000
>>>> +    maximum: 50000000
>>>
>>> This might be fine, but your DTS suggests clearly this is SoC compatible
>>> deducible, which I already said at v1.
>>
>> I don't understand why you're rejecting a common solution to a problem
>> that surely exists outside this one specific chip from one specific
>> vendor, which may be caused by a multitude of design choices, including
>> erratic board (not SoC) electrical design
> 
> No one brought any arguments so far that common solution is needed. The
> only argument provided - sm8550 - is showing this is soc design.
> 
> I don't reject common solution. I provided review at v1 to which no one
> responded, no one argued, no one provided other arguments.

Okay, so the specific problem that causes this observable limitation
exists on SM8550 and at least one more platform which is not upstream
today. It can be caused by various electrical issues, in our specific
case by something internal to the SoC (but external factors may apply
too)

Looking at the docs, a number of platforms have various limitations
with regards to frequency at specific speed-modes, some of which seem
to be handled implicitly by rounding in the clock framework's
round/set_rate().

I can very easily imagine there are either boards or platforms in the
wild, where the speed must be limited for various reasons, maybe some
of them currently don't advertise it (like sm8550 on next/master) to
hide that

Konrad
