Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E268347532
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037296; cv=none; b=p2WOVg/cNvn2lhENz58/+9bl7lRFJ6DIHhv4CKoYwWOm8CS6lvw4vaDpa4vgtGE5m/X4X10mMunheGN1axAWn6LFpM5mHWk+qS/9n0uYmtNydD5y/UWO6I2D4Ck5CCBHchYxsGBEDaORWGAG2UFHWA+/YJGfrKl/zwNewPMIYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037296; c=relaxed/simple;
	bh=97g/NdktaIsfmzcUs7B3fZAs/ud1qLpVVqapGtwmntw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Te4idU1VYO62hfGepjjdbvmpxNeuUrlouhw9CmMEWtKXBEs6+KABRX/EPb27w9dmNTaBwAEO1hyEMvm40sC6AsAL10SUvj9ohuELt8W5F/Q/pIUv9SuOA8g/p4IOEPcPE26GoUjvaDFzjBQ/XaBLUX1PxAed8aaC3XHtMXUn+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DPSKucqd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QA8ZiHla; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DPSKucqd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QA8ZiHla"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H1lRFe849157
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 17:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+xRzeH96dtwyj2Z5WMwnZyLEFHICTIHnJvR10SSBCzg=; b=DPSKucqdOpkA8zhl
	f5TYHIXNv5YMsgwOibwUCJd6SE6lBZatsSAd4CQD8coNkgGneC0kxdkCCgIWxKFS
	j2zpDvOoIb8V+ha4eJfhW2bkTM6NxJ0W68Bd/Gc/6EmHA/jQBfgr1MGEQwyL99Qt
	SBWxRSlUNofr2ec1TNzbmW/1l+43Bbw+AuCoeyUuGYvKrzk+MyUs76NBP1gIJgT9
	iu+g1xp+vf3X72gQByT1rPzC3eh4S2EmpTLTZpZCqrZQIl4f8OKuVTOXE+oz/0Lz
	Jgv1HteWLh+AevDerqNcIP8HQkzjHcLr34Jhkhg1U2p2Yu3eLzksg0L99jSmGk8r
	ICyNhA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gwmb8e9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 17:01:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso38378305ad.3
        for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779037293; x=1779642093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xRzeH96dtwyj2Z5WMwnZyLEFHICTIHnJvR10SSBCzg=;
        b=QA8ZiHla08Yxykdk5baymhBkGyn+nSsBHccjZsmlriV2cGCBqkuRrSGxvbi9uUbqZu
         ctFkBCVrRdkhnC21VFmSmnbgyrBPZSyO53FTxLX6YEo5wrJSNaeNHot2Q6Xcg9Dfz3z7
         fjbGR2cR8kTVFMrtrbRAXwVt0q4cbfDVo1FsRaMoS6tZCiaoLw2YDlZ52SY8EHnxL7ur
         wmr7ldWe22bm+vFpAgtxONiY5356etYGYhccW8yqgQVeczuiqBcidgQ1h4OgP8BT2HDc
         aYTC2VzZJZs4IeBgWrKQzPzyrwaei+9YDsFHRth6Lqh5HmSjAx4L2386oRLZ9GZqqGj7
         gN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779037293; x=1779642093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xRzeH96dtwyj2Z5WMwnZyLEFHICTIHnJvR10SSBCzg=;
        b=HY0FstXObX66/bvwBzNLBvuv7w3mvMKV++qbRXpJPXTOwuwATiiLWmegkfTpVHUtIg
         bSgQWzkuESckHzdR5N3AB6U3islEetTqkF7Bh+BrWaqxbC0ko5YtA7VW4dlgDgRejgXq
         YoGNfU1wyDcDyQRrW3EXxOqqT1/CsTGyqpAtSvpFfxXYX8Nl5ODv4OdtlN2URSIbyy7X
         cIAVqgSCOSRT2KMFibYEr0fNVL5/KAbwOdpDO/f8KlLhljxfQAV8q5BqZBx3omqL/0Uu
         zllQ77KXYDJVI0jFrql2kExa1XjcQ1QDKDYCnblYro004/AGw2E5Ko4A5wy1KnfLs/pw
         3O2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9bfTVNEuXYgySS25sPaoKI4ZpbxwQSU4Cr9wqbzZviuhitnnLvj9zJR/bdBESy0rw/dHvwDJywdhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlad9deuEeanVKqCVTe613TnqC2o8Z7Rmsy+CdYBWBRejHnph5
	ET7S1ZzFSbaCWGMQYB8GdrGySdlVnIdAGROIWsINAyp5yY59spjtAXXaNp1jRuTvI66dw6ZeZjd
	J2Vhsz8hnM0uGXSvBxXPx68lzqjr5CPPEzkyE5fbyxlUXkoO/S7faiUAUV6+N1wg=
X-Gm-Gg: Acq92OE+m0A7olLAnCxQf6RsSqKwB9MdVyEdDVjgs0KxLNTJdD4NjMQqTIJ/mQCP1jd
	3fO12r6W4SBhG2byA+s2U7V/Pd/Hf6RVfm5o/7L3BYckyWP+vwjAjA2j4pStdnrkDSXO92smMTo
	axae/aXBHPLfQfkXbbUjY80ijBLNmiUknl8ouiB888H4CArA8XozoiJJMmabaFI5f8TlBK16HY6
	uHmp8j+briLtAOoS4pzOVPpOkSt2qRUtknsTk7vQoJ1Ievc9kL18AsqxhivCy7q8zTOSjM3fAxx
	mFnaY9r+3qD1n7FuvjEuQV0ffPeigVtlq8pBkyTKuEQHCh3juTXUBddeOOy0PjP+jYOJvOH1ZsT
	TsdL8F3zK7KPUsLjXtmerSOxsTcFQmMgHa+ILVwQm4/p4/hwVbLc=
X-Received: by 2002:a17:903:240e:b0:2bd:3bfd:74f2 with SMTP id d9443c01a7336-2bd7e831c89mr127658535ad.10.1779037293145;
        Sun, 17 May 2026 10:01:33 -0700 (PDT)
X-Received: by 2002:a17:903:240e:b0:2bd:3bfd:74f2 with SMTP id d9443c01a7336-2bd7e831c89mr127657885ad.10.1779037292600;
        Sun, 17 May 2026 10:01:32 -0700 (PDT)
Received: from [192.168.29.166] ([49.43.235.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600a4sm115580535ad.30.2026.05.17.10.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 10:01:32 -0700 (PDT)
Message-ID: <a31e27c4-b024-4377-a5c1-f02c2bf02a0d@oss.qualcomm.com>
Date: Sun, 17 May 2026 22:31:24 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom: Document Shikra and its EVK
 boards
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org
References: <20260512-shikra-dt-v1-0-716438330dd0@oss.qualcomm.com>
 <20260512-shikra-dt-v1-1-716438330dd0@oss.qualcomm.com>
 <20260515-pumpkin-cuscus-of-expression-cec1ea@quoll>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <20260515-pumpkin-cuscus-of-expression-cec1ea@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ul4jFeievoN_6h2CR75yoI0dKBAjMK0W
X-Proofpoint-GUID: ul4jFeievoN_6h2CR75yoI0dKBAjMK0W
X-Authority-Analysis: v=2.4 cv=W/AIkxWk c=1 sm=1 tr=0 ts=6a09f46e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=g4/7f0GlZvY0MGcqtTB0Sw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=QP8ThlpALwkLgMcBQ0MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE4NCBTYWx0ZWRfX/5r0nDrJf/kb
 8hwpSQTlmxMTgaWdo1q710vK+p2FD3YcwIzmtrSYrCS8rwjhqK5ICvxFQXOQXktZ5IXdPlX4Std
 QHHCSyngl47duY+drR17L0ScqRviWDbI7rmVm42JZWndgXwd9URoEazRcpPAmaTtMI3WeMgobfs
 oc8L/SQOsQt12EGXndh8M+5qegqTIP4DRWv2b7kCkT/LQzsEODmjuGOPP7PGbUxcdwnTiUegPI3
 gIUs1edJ39c3lshbLstt/OyIxnpNd1MyZn+IKQ9ISSMHFPKaezjA3MFktLO1DnhJxwkBTWvZeT/
 +/wF3X3daNfNUcLytsS+CE2WH1O60NiRaCZdVthLtJtu43qEf6nOirSuMYQoVukaAEZB9FsFjP/
 9jMtr2GUu+SRS/j3vXeIwT6I1BTHwo8lBJUFMfC0F4PncqkXmuc135evqMi3Ih99YoNCkQA2+gX
 epz6mYh8XRgmktciVQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170184

On 5/15/2026 2:21 PM, Krzysztof Kozlowski wrote:
> On Tue, May 12, 2026 at 09:38:04AM +0530, Komal Bajaj wrote:
>> Shikra is a Qualcomm IoT SoC available in a System-on-Module (SoM)
>> form factor. The SoM integrates the Shikra SoC, PMICs, and essential
>> passives, and is designed to be mounted on carrier boards.
>>
>> One SoM variant is introduced:
>>    - CQM: retail variant with integrated modem (PM4125 PMIC)
>>
>> Two EVK boards are supported:
>>    - shikra-cqm-evk: pairs with the CQM SoM
>>    - shikra-cqs-evk: pairs with the CQM SoM, with no modem support
> s/CQM/CQS/

Right, will fix this typo.

>
> but anyway I would prefer to use full product names from
> include/dt-bindings/arm/qcom,ids.h (so CQXXXXM).

Sure, I'll update both CQM and CQS to their corresponding full name.

>
>> Each EVK provides debug UART, USB, and other peripheral interfaces.
>>
>> Add compatible strings for the CQM SoM variant and its two
>> corresponding EVK boards.
>>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 2741c07e9f41..f041d71d7957 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -963,6 +963,13 @@ properties:
>>             - const: qcom,qcs9100
>>             - const: qcom,sa8775p
>>   
>> +      - items:
>> +          - enum:
>> +              - qcom,shikra-cqm-evk
>> +              - qcom,shikra-cqs-evk
>> +          - const: qcom,shikra-cqm-som
> This is not accurate. The SoM has physically different SoC - either CQM
> or CQS. You either need two lists, like Toradex is doing (e.g.
> toradex,verdin-imx95), or enum in the middle of the lists, like Renesas
> is doing (e.g. renesas,rzt2h-evk).
>
> I prefer the first option, so Toradex choice.
>
> But for sure you do not get the third solution... Really, you are not
> supposed to invent these things, but look at existing solutions (and I
> was mentioning Toradex during internal meetings whenever someone asked
> me how the SoM and carrier should be organized).

Sure, I’ll follow the Toradex approach and restructure this with 
separate compatible lists for each EVK/SoM combination, as below:

- items:
       - enum:
           - qcom,shikra-cqm-evk
       - const: qcom,shikra-cqm-som
       - const: qcom,shikra

   - items:
       - enum:
           - qcom,shikra-cqs-evk
       - const: qcom,shikra-cqs-som
       - const: qcom,shikra


Thanks
Komal
