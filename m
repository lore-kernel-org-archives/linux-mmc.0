Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF92222B2
	for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488590; cv=none; b=k7seOctmJ3pV5G5oBio29WWbX6nzJnzmf77q+jkvlig5al6Jak5Z7Fj7hhJISsqELDPkk/soV/KheU383cKJyV0H5Rz9gODX9qGqogtpyN+8T7lTnWmuFBfT763iC+rk7oOrEmqUrEoV7OqtumV7PPQd2aU2JLrOg9obOLE4TKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488590; c=relaxed/simple;
	bh=4NehR4sTHOxsA4wUCf6MLaafUjVEdqAqvefjROThzz8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=doLohpxPa9pkPHRP9e3YKgqMnP+2ORgmAIyYIV7UUxEAkr7jaiALks4yGK28CX9Ek7K7Ddja/XqdU5gC4wNZldAM6Bp5EQeISG7AdCb82ZSdeRwf1Hw5inCPxUV94sKzAClboeh/lbIgLc85Xo5RQw9avXqw0aOyxyqQ2L3/4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i3fW7Y8s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U5PR1Now; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i3fW7Y8s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U5PR1Now"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J18QAi3078399
	for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 08:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	He9TCtmdJ/Jyli0G3m7/iAi1wToVq9O81jgA5Yqu3aM=; b=i3fW7Y8sEmFuTtK/
	t47W8Nbh2HwHQidDlVHrzm5GCoXQqeEIK7URzpYCkPUqxRkpIKduNmRxndGcqHSc
	+sMiEdnkH4e+dWKdvO3NVcNEihPssC0QuIl8mk2kgHU2o6a7hb5XDQUSSKpDEpq6
	nBR+3rhVpcSX3NCGOrk536nnN1ZYDqR5mY9rtH6ROgmOhhp/osHY9OOUU1UWyEsH
	OjP4kBWzr894+8yEO2FCmj5lk3l8ItefW+b9c9qvws7gvPwjhVW9oGBmcFIKx8/3
	NWdJIRujOQp1Jz49BQuZmmmecikfCj+Ctj3GhuYf80ZjPX1tWYYkmVqcGxsZFecM
	VLiDJA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdrk80rn7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 08:09:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aaf2ce5d81so9392045ad.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 00:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771488587; x=1772093387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=He9TCtmdJ/Jyli0G3m7/iAi1wToVq9O81jgA5Yqu3aM=;
        b=U5PR1NowaQHMBaQE6RCWYNcJzI4NXvkAjQcic5oGSK/shkVQ92WOT59YndUSpng9gJ
         Ug8bMFTDoHnhD/Rel2GSkS0FLfxwNwblNmxmMX/hurS5XNO8HVHrMo0qjixg6GdVuDL8
         SEE1Ehp1u4eUDsVNZFsgXSF4lxLIpiMJ8OetCcCis5QcNMxDsNqrismVS5TQ+e7jYJwo
         uc3XK58amaOL2Qf6wD9P1FUb43kzIkU954ecyzoAlMCsmcfDwh4eo5wMUOcdqafvdyh2
         0LGeLfH/BHCOoXAxXMoca7gBheVirqugA2+oQAo6Rh+2QK4tvFsgalVvuPxfuzgul+Lf
         ScrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771488587; x=1772093387;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=He9TCtmdJ/Jyli0G3m7/iAi1wToVq9O81jgA5Yqu3aM=;
        b=TE4koZmFzS1nLGwC8JMYqYSHdqwI4mjMLL0JijMoV/5CqfyAb0WDv25ndt8HpMquUD
         3uMAIqzT7AcHFSUolVVBKWtrT0l0a1o+GQcH1hpz5hU0fOBqi0L/oKAWuW36RwMWftby
         AolbPzPQQqgdFyd1gQMK/aWHzYXffMbDsOprlVO9TaOe7BnapUtOq69NUziFa3A08mpt
         Iwjamu45LRC7qMxNWcK10Od9LK2ti8Vw6iZtcNZKxysFlok0IyVurdW4URm+P4IKDAXc
         6dbVFwym/JBEWa+cx+QshKTZ5SPGusbQJEuYKwzLoVZ1y6v6ywkhD+bE0ZAYNjNChbO2
         9FyA==
X-Forwarded-Encrypted: i=1; AJvYcCXCGwY1yR+GI0/fKuouDaLwlVTbP83CbNxDRVuLsSKEkEhx8e2O/ICYPjVggFRKlvfdfUka1xZYNQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKDLgehTP0IlVmhpBtjUFBlycC1W9+HWo9iB/K/ibH1szi/Fng
	iUFy2CT+Ogy20jiQI4T1Mj35i8lNQJw6YsqfDmZuzalKRW7+jpM2qL4/6343DahVzB1N0ymydSg
	37smI3U2NlsHwyrDfp4QrB0Np+hy6DwhgpYGhNuaOoppr8O425UUj40Z3vk7dSRI=
X-Gm-Gg: AZuq6aLd6TJGn3ELNQJCQYGnHHTysaGKDObsvZd8JiyT/Klvfb06Zp7m80airFNg7lf
	d2ZFGqoNmxSYmvtL0tCm8XQsW82MHZQYF26+q7Qh78yifoQLlDdgz15kwMPIDZV0x3jf/TQ5i5m
	nUl6pZ7/XEHCLcbXLxrxJ9BkhZ81ZWjxl4qhyNgjqDRAByS5jgUIwl1EDpWibBYba/xZfSR427g
	XC3Yzglw8jDD/89EFc08hkGKSSH+fCljEv6wJFt85ezIvkjWBf2BozvESDcK13hBdM+aXOtyiG/
	JeQTpccF7wSQmPR6r5H/v56hogyBvL7Odz7QXQaZyk0SeyHtQHfeBGSHJ9S7UYJJBR4mTgYbf2E
	LA0Tuu5HWmbF5kpmbGWEAS1PLwJ/Shydbc9JvFWYeGosRIwFHQw==
X-Received: by 2002:a17:903:38cd:b0:2a0:c1e4:e25 with SMTP id d9443c01a7336-2ad1759ac22mr202678905ad.54.1771488586933;
        Thu, 19 Feb 2026 00:09:46 -0800 (PST)
X-Received: by 2002:a17:903:38cd:b0:2a0:c1e4:e25 with SMTP id d9443c01a7336-2ad1759ac22mr202678775ad.54.1771488586452;
        Thu, 19 Feb 2026 00:09:46 -0800 (PST)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aadd140sm161116145ad.72.2026.02.19.00.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 00:09:46 -0800 (PST)
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
References: <20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com>
 <20260217052526.2335759-2-neeraj.soni@oss.qualcomm.com>
 <20260217-berserk-puma-of-focus-bcbe82@quoll>
 <e3ac0681-605d-c1df-e4f0-78a2c142fa66@oss.qualcomm.com>
 <51d75568-5110-4993-b262-71af0a0d4600@kernel.org>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <28a9d23b-69ae-c624-4b2a-1ff719281cd3@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 13:39:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <51d75568-5110-4993-b262-71af0a0d4600@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aOmPLneFOtnC6ZZYSn4f0N7nng1gKmNU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA3MyBTYWx0ZWRfX2aLYM5Kz/rCR
 KJW+FsThUiaSVeQIQDXZXFvBHjIvJH6jLT62IuT3qNwI/DEXlgRdflT97N9HV5iJoCc76B9Ukb/
 SOIf2vb0OgQdGEENOR0WWWkRi1vrg1I4MRTqnln0rfuOzllJKac/ztMMJEHopBT38jmNmIKxJbz
 6s7YPfsPgHMvqg9Soz912kwRutSf4jLbwfc4sNXmZMzPAXoKIsqRtLwpRer0G+3XcYICjAYArGd
 Vl5nkl7u4D1qYvhWkkg1lMfaTGN3xPL4sotz9fyXnabzVXzEZ2OUxCQ+A9wTbxfiW0O33V7wv6Y
 1cKWpWJxs5roFwQ8/Fhu77Dgc1j2xAgAEnuQfn6wFpkH1yJbpFiHwUqwi6p3evGELX7LWGfx/aG
 OPw44Igirl6aRCgSfwoC7mTd+a7ApNbY4URwlgPj7TRWnJEGMayqDaLkfKCYCY5UCmS7q6WnZRF
 AB4+SyUBijyKqCSmeGQ==
X-Authority-Analysis: v=2.4 cv=MJBtWcZl c=1 sm=1 tr=0 ts=6996c54b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=lvwnJXwceCFjUmCDSakA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: aOmPLneFOtnC6ZZYSn4f0N7nng1gKmNU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190073



On 2/19/2026 12:50 PM, Krzysztof Kozlowski wrote:
> On 19/02/2026 06:38, Neeraj Soni wrote:
>>>> +  qcom,ice:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description:
>>>> +      phandle to the Inline Crypto Engine (ICE) hardware block for this controller.
>>>
>>>
>>> Srsly, I asked once and not much improved. What is explicitly written in
>>> coding style which I asked you twice to read?
>>>
>> I have attempted to modifiy it as per the comment you gave in v3 here:
>> https://lore.kernel.org/all/b6e510da-b369-4c43-b9a1-455478af4948@kernel.org/
>>
>> I will rephrase it to explain the usage better in next patch.
>>
>>> And how long is this line? Why such trivialities cannot be fixed and I
>>> need to remind this every time?
>>>
>> It is 83 character long but i understand now you expect it to be wrapped 
>> at 75 as per kernel coding style. I missed it and stuck to the limit
> 
> 75?
> 
Apologies for typo. Wanted to right 80:
https://www.kernel.org/doc/html/v4.10/process/coding-style.html

> 
> 
> Best regards,
> Krzysztof
> 
