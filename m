Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7832BD031
	for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239931; cv=none; b=CoOE8iZ7ti8u1WijzKV4h6MK6ICVCinuyDTkYCMwU6VAzb5HprAS7oUSX6+IQHfbac29IlfMXOuCJrbGsA/fhLyNLLjEZmSX9NY6uB1iPwm7kFv9KMYyKmDDLeR3RP99kEAQJSBn9Dt9pLOmXBa/z0oW/nchl/fJ1OvTcE3+kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239931; c=relaxed/simple;
	bh=axEx3VHoc5uojuaL7EUNQLo4zjFgdBEAqt3gWqgER+Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ATN1AHH9VD8/bW3zi6CFXnVPIgPOHvWIoQ9ezCz4RWmmwu7AUIN5d+byzCS9xYeimVK7wtnLilbCpgulB0QM6RKjWuJy8ur4//HGzuxVkkaY0XPJ7UFa6hqHG4znhApj6qSPx64x0cC78lpY9NkzOxA3sv51fNeo8iLcUcKZ4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YECjFPrT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LwQqwa52; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YECjFPrT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LwQqwa52"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G2CiRY3474374
	for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 11:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YMni5B+nUretOJRqmOjn0HSOX+2VPm/OmABagc+5UNs=; b=YECjFPrTbJi/78dy
	VTN+dqQabkXQsCm5po2S4ioJtsaTNDcUgJApYOxY0afbfs6J54c98f/VNPJamoCi
	TBEBl6e5CN05uBnD76Di8cnakJ5T7498UkuVzHIXVUPkcgC4l6/w2YC2Mf+fndtX
	kn79mRhaSyx/KqSbe3GX9m8VeCFTZdOV5qSWC1EGfAFxQm0UysFQMjG+UM8fQ3+n
	HQxg6SCpqO7LLnvYsGKcSqnWZ0LtWkngVHk5zNDj9q0s4I9i1K6Cw0RlL2O1VD2q
	YZXwMBC5D26/aoUMDGf+bQSXfF5lc86ba3TbNECXzMXouQ9Q1ikGpIqT3tIEEq+I
	R4lTEg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cah4smauq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 11:05:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35842aa350fso8472377a91.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 03:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771239928; x=1771844728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMni5B+nUretOJRqmOjn0HSOX+2VPm/OmABagc+5UNs=;
        b=LwQqwa52ORg7bzE+BtwWEsSdLFcuCdxypbbgilAK8vflUYURFcOkGSVyFNntBw5JOC
         ulJz4pjFd4JTmQOIx27uFRyGPqJpKkR5SUx8nZ+XH9tSCtwUEQ2ZD1ZQigEkWJzAMkIm
         73jba1uqGWyfeXmnr4s1PVyF50OHpDoqy03o01pS2Yin6CBOACaOIVAFReWXV9mCmVig
         8ESynmc/nv6MTMh8bVaKGvxYyzXsuhyTMKvzVLv6VAgUWMGVOP2icbgDMSxT5JnwEObb
         gd3tbt+IgGjfabpla32dnBO+I0LNDnmg16nN66z3UeZGbbCqm+cSm+Z0a+MIVzvO8qjt
         QlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771239928; x=1771844728;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMni5B+nUretOJRqmOjn0HSOX+2VPm/OmABagc+5UNs=;
        b=glKsYyqprbij6jmJ6kcHPsEIh2PNSJAjEe/aOgEUygP5nYH+1tx3To/E2Xcj+b0c2o
         AXDn+zKvVjZ4DdUcFtSLfZZTbSBRJ4xEbtfScd/UsXLATzqgZBbaXJ/20GDcBki+deji
         6aaHX4VDolgSqNKPWcfuErrcMhqu5Ycsz4x0l3tvdQmw+TpQ2Fclbydzrg9sedyum88T
         6y3VujadvbVvsadjIf2T/DWHwcygiK1V6/prLdHyuC33eg3p2eRwYKgRsPnZC1CHrQxx
         gObBiVfcu9Qs0gNwdJEnLn+kRepNGMYzPzdjkqqHO5LqQihZn/ruFHsvGCl2C1gHcgjw
         2FVA==
X-Gm-Message-State: AOJu0YwsGjr02CrDpSoo+tX/i6nrv+0NP+oqrwOUbrkZpGtc/nCFfJ9M
	aSEStlWDrA2HL0+0MJweDUE1Vjas1Wv9BkABAM2gyieR8MEn+Ztqt53F6i0DO6yX36CHp9bpnh7
	kekN+Y6HejcR5Z11l4hxaiUr2rGatDOsIg6lcEFOdxAL+UDB2UB6QUJgpcZwzp10=
X-Gm-Gg: AZuq6aJXwEDvLg5Wiw7u2DsLboOpr11cc3jOUwsSyUSWDhy1KC7f/2vN4jR9rNfCMlk
	MzbiqTWOHBN8tKjeDonhC3Tvmku8F2r7aZ/FZ70GwQP3h72hjmapBzc2il/1wNqBFCMVaIkJktT
	FPa58GC9DvyAjcro5tTMZ6eB6HoJOdDldqqZfHjaGiD+Vg5U9McFU2BHaQr0hNOf1O+RgsIFauV
	QdF1B51rTIMqsnccB/pwDf+fR3d8Qj/OtlHtLT5fYHVJISNctzIRNftlCyufZeQTrUJiQc7uMC8
	pRxyf9wTw/wHwEa8syG+MuJJQEcd2Ro32TqgBXqdVVp0DlqxaqHItCWN7TbKn/W8AIwWDcsnjsn
	DFzTz7nuERkk/E0gjkgKXLzR2tNEE/vo+VgJ5uDo8Zzx0UB6Bgg==
X-Received: by 2002:a05:6a20:3d8e:b0:366:19a5:b492 with SMTP id adf61e73a8af0-394671146c2mr10383868637.5.1771239927861;
        Mon, 16 Feb 2026 03:05:27 -0800 (PST)
X-Received: by 2002:a05:6a20:3d8e:b0:366:19a5:b492 with SMTP id adf61e73a8af0-394671146c2mr10383837637.5.1771239927339;
        Mon, 16 Feb 2026 03:05:27 -0800 (PST)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532f2ba0sm6281191a12.25.2026.02.16.03.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 03:05:26 -0800 (PST)
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Krzysztof Kozlowski <krzk@kernel.org>, ulf.hansson@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
References: <20260206112053.3287756-1-neeraj.soni@oss.qualcomm.com>
 <20260206112053.3287756-2-neeraj.soni@oss.qualcomm.com>
 <b6e510da-b369-4c43-b9a1-455478af4948@kernel.org>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <640e2eca-1656-1723-38e8-d6cd97e6e2e3@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 16:35:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b6e510da-b369-4c43-b9a1-455478af4948@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA5MyBTYWx0ZWRfXxB9KAH7K88he
 uhAc59xG272bGlYUJQAwM9yjQVMD02ah5lpYdO8eJ3k2KMNTj5tdbu8m84mdRiXtu/yV5DtcCcR
 j/ZbjFRWeKxhlVfXq/UnuK+JbqqxY9WGb+KKRJ6/4qzEiNzRRhCv6CnokFMRn/vF/hIme+8JOgn
 /x6hZ9etIvBCn8dCGFTZ6K9FZTPrSIHVA3cCZ2WknT3fJE7g4ezU/T/qXzKubfPKgw8u7Hpcn0j
 OtZJrpZrsqj2YpwXvrT4gGXp79ovHRC2/hpT9PPIV8BJqi5iTSVe3jQbBav5mxSuv7WuYyH+RMI
 TQtP3mtZm0l2Afp1fFreNDCVVHVScMWY2FQetdKJwpIEnb0TM5d3L83Erob8Mfp5B4x9nrwpVVv
 BOqXlc87P7k06xeCuLazHUw8DGSycB7bMOrwZQ1xCNWzTNbNdYZ6sXKaoYiWTM/vNeqgpci9lbW
 1FDDte2yqhXaOoKiJDw==
X-Proofpoint-GUID: p3CDVRLfEDazghxzxxb8jmUUo5hyjoB_
X-Proofpoint-ORIG-GUID: p3CDVRLfEDazghxzxxb8jmUUo5hyjoB_
X-Authority-Analysis: v=2.4 cv=EbXFgfmC c=1 sm=1 tr=0 ts=6992f9f8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=GgeKcXs6izqwwY2gQxYA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160093



On 2/6/2026 4:56 PM, Krzysztof Kozlowski wrote:
> On 06/02/2026 12:20, Neeraj Soni wrote:
>> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
>> So add the qcom,ice property to reference it.
>>
>> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>
>> ---
>>
>> Some initial work is done by Abel here:
>> https://lore.kernel.org/all/ba3da82d-999b-b040-5230-36e60293e0fd@linaro.org/
>> and by Abhinaba here:
>> https://lore.kernel.org/all/20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-1-2a34d8d03c72@oss.qualcomm.com/
>>
>> This patch adds the purpose and usage for phandle in the description and encodes
>> it properly in the schema.
>> ---
>>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 26 +++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>> index 938be8228d66..f35b675c9f16 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>> @@ -140,6 +140,12 @@ properties:
>>      $ref: /schemas/types.yaml#/definitions/uint32
>>      description: platform specific settings for DLL_CONFIG reg.
>>  
>> +  qcom,ice:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: |
>> +      phandle to the Inline Crypto Engine node. ICE having its own platform driver will use this phandle to
> 
> Please wrap code according to the preferred limit expressed in Kernel
> coding style (checkpatch is not a coding style description, but only a
> tool).  However don't wrap blindly (see Kernel coding style).
>
Sure. While executing dt_binding_check the tool reported max limit as 110 characters so i wrapped
around it. I will consolidate the description to single line in next patch.
 
> Do not need '|' unless you need to preserve formatting.
> 
Ack. I will limit the description to single line.
> 
> I do not understand the platform driver reference here. You are supposed
> to explain how the hardware uses it, for what purpose. If I change Linux
> to use auxilary driver, then the binding is incorrect?
> 
> 
>> +      manage its resources independently. Either add this phandle or ICE address space for ICE to work.
> 
> Don't repeat constraints in free form text>
Ack. Will fix in next patch.
 
> Such trivialities should not happen, I am sometimes skipping deep dive
> review, so I skipped the rest.
> 
> :
> 
> 
> Best regards,
> Krzysztof
> 
Best Regards,
Neeraj
