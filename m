Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB62DAFA1
	for <linux-mmc@vger.kernel.org>; Fri,  9 Jan 2026 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767940610; cv=none; b=UQbM7a6bX5h2CEqVisDtttyi+YhOJvrV8g47ZNTiViMip5K1WRaC7Jl9WqnTPmyEGaNKFA+6iYgWtU+oFukRcrIROplmW27j757pxXcy4+gVUuLEXwkO2bLAtOksWTUXbnCQONDRjm/JfwkwemFZMoleJhTTqEWRHEoZvAdlIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767940610; c=relaxed/simple;
	bh=Yjp1f2xBgBoP9g7qHeCglH36dHiwxKcSgZAm4VCj+WY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HkkD9EsEa88xk24tf0LdQ07cy5G74n2mabJfpFajJRZBD/GzUOURl0kBsmUPuQIuYALJM+DjbNwcfjmuyV1fOVzNUhNU0yQ2Pj2rMflD56tr+vwUHCBeF5NYNzK6zuKMoZbA52GPABZtdqwZopY/q9BZKkV6DmeZStJf8Xa2SSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fd0cdvUt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NYMiZ9mj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fd0cdvUt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NYMiZ9mj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60952gF33542097
	for <linux-mmc@vger.kernel.org>; Fri, 9 Jan 2026 06:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iEFLRadva6gNexYEwvb/IO34UQ3Sw4d6m5bd4ftOyJQ=; b=fd0cdvUtF1dKeFB8
	f2pIVWa4iOpwoEujM2Q5vuGos/seUIdCmjr6FeBF872A7FF2DJrFsPHLqCqXwvbP
	/7UbNCbrc4ilgfGnY3Av5BTdcyBKRONZ9ZTT3nti7x+GlDXxwHX5vmoQebVFKE8r
	fCFNy8guY9GKzN/K8GH3TDK2ETw6xfxQ16Kw9voY0n4qTl/Pxtl6ReYBO3N1DVme
	mIkyKYL3HdXoHGfxN2RvowYva1716SZ91D4gcO1vgqSfuQiWfqICOR+IoFxqTWpO
	VXBrn1IgHeHlQW33RSbTu5bXJwg639Eq0uQDr0KBNLfXMDsfqUpklHdx9ZWh/IMv
	pX4Gfw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bju6b07d4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 09 Jan 2026 06:36:47 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7d24bbb9278so6871453b3a.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jan 2026 22:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767940606; x=1768545406; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEFLRadva6gNexYEwvb/IO34UQ3Sw4d6m5bd4ftOyJQ=;
        b=NYMiZ9mj093iq8cIzJ32kIWWcK5kSvu9fq2LkRJOz37O0jwLmJPTBPAFTS8JS3IJ9G
         AbfZm+8VmcwCNWFAOKlqA4fFTSkTGYWCjS1mpJNpR3kM0OToFClGsO0OZyfmJuB8EqJb
         x5wEbYBIZ4HpywIO7xcocYZAkk44dzQWoAtt/lCmGoVrH4CaArOMYBRMRO0lECNwC3y9
         SxaQn4TPB7m1JEqWxCyObDqFZDwokidV0thZUYBj1rURNalt3mtVDNlBlJRjDe6LNsHb
         RacQVhQu1+hw1TsHxeSJWVVAXKxQTqx33w70Zwnyjybp02QswMo/oJKfV8vgGb4/bFaR
         cq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767940606; x=1768545406;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEFLRadva6gNexYEwvb/IO34UQ3Sw4d6m5bd4ftOyJQ=;
        b=dW8FlWArlwwJjjUhP+c7OApdgj8FUGBBXj7H7clhDzqvEMzl8VD76hGrVkUeFuvAGO
         itdFs60x/qITiCU3ii8TgNEkO02yFg/OqT1sZHlDgwrNrdAMiqYk+p2n8PaTAez5YH43
         bPshyRp8lOg06CLjulDCix8MiaBuoZ5bu947r1Yz4pqLQR11VNNnIKSkenYS68sz71z3
         g6Ft//7u16k/kU+zYV7tLb36nl0G7C4yeGx32d5V83E+VdKeEm+JQyANfEOLwkryDc3s
         HyTgBzjJZJDAOzVdGligoA5eIMfcwpoSKZdGJq2mjhCtBRY0gj5VXKZoBoARpVkUp+sN
         ngLw==
X-Gm-Message-State: AOJu0YzrEJoZsiqPIx1/2BDZIDPtfP07u+rT1CovusFdb4AA6SKlf68g
	mLMlg6sJsR/gombF4c8hbys5l6fih8ZaWt1vbUr9oBNWH1yE38oivnAmrwV4c1/rTfzkWP6E0zH
	TfkwEyaMzxNuR998QNnQbcq9gr7T+2PwA4lo/f4VtpY51c9mx3+1rdngD1fRhY0U=
X-Gm-Gg: AY/fxX6Y+eXq87CiLpbjNWWll3aZPcZ2IU0gkU2NzgvwwhsGNX6wCheCE7v5Y/tDkSy
	ca9rLe15MmxWloPo0hIc4qUPe2w7y3gCa5u6TDEHgHv464EDS1LKmGRNDLbD3lNe1zl/YqfOSHB
	L3EcctYcDnyhhFXYLc9OIYAL+zvRR2yz6qtlWoy5WMY1q8OxWaQNLhV0bGdENtkOsgVu5q9ug8J
	qwogDtnGU7uSM4WEGXltM0iXyCPIon5s7qiNM19uanYwZMG4JOZ5RD/f3QighHsTENXfCDI2uJc
	5/osW00GKCCfkSf/Ofy3ba0MSdF7ouQxHtW9ydoUd+CUFxSghXjmC03jkmqTERZjX248jyEsHx4
	aUtzAW6EzKU5uXytMRDhEduV2g0cwdkAC2u5hlRc=
X-Received: by 2002:a05:6a00:1d9b:b0:7fc:da5:f84e with SMTP id d2e1a72fcca58-81b7f4ed826mr8021676b3a.41.1767940606236;
        Thu, 08 Jan 2026 22:36:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXmqeKdNgTpsm0+9SyEU6DclsUOksJFj9tPdAfgRkUb5PrdJpec6P3Gn6Rk3hGo2QSnc2vbg==
X-Received: by 2002:a05:6a00:1d9b:b0:7fc:da5:f84e with SMTP id d2e1a72fcca58-81b7f4ed826mr8021644b3a.41.1767940605737;
        Thu, 08 Jan 2026 22:36:45 -0800 (PST)
Received: from [10.217.223.198] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52fc9bdsm9345543b3a.32.2026.01.08.22.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 22:36:45 -0800 (PST)
Subject: Re: [PATCH v3] mmc: Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
        Neeraj Soni <quic_neersoni@quicinc.com>,
        Ram Prakash Gupta <quic_rampraka@quicinc.com>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Sachin Gupta <quic_sachgupt@quicinc.com>,
        Bhaskar Valaboju <quic_bhaskarv@quicinc.com>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>,
        Sarthak Garg <quic_sartgarg@quicinc.com>
References: <20250718110217.1929526-1-quic_dmukhopa@quicinc.com>
 <a569a2c3-2fb2-4a40-8d54-898e7c36f4b3@oss.qualcomm.com>
 <42797330-868a-bfcd-e0bb-b5f0dd3eeb16@oss.qualcomm.com>
 <9a07d235-d1be-447b-ae89-75aa418cb69c@oss.qualcomm.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <cead2d86-bac8-2d4f-1a7d-c9b90dc05a7c@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 12:06:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9a07d235-d1be-447b-ae89-75aa418cb69c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA0NCBTYWx0ZWRfX+3/X43SijVix
 h/aWqulaFelUr2YlIb8IERGUDBF6TK5WlsKRHVm/rvEsNR718n8hkTryKYTywrIAl3qtJMmlB5x
 RiZlCqLmMTINpYMjCnMAwp8upgev63D66uzwdXXJNd1yVRhnDJyPc42p7AU0qZrMmTkEq7OxNcB
 Uvonc6jBC/iVrrwoTlWtpAerWw4XJcqAM1r0w9dMXMAWWtxnHdaaR7MMPKJ9eTo9ynf5riGdtGB
 DqpC3TBT/JOJXs4vZQTgaUF90tdct9ogtddNpOBKhfblPs3l4sBvnhDNqc7kvu8TyyjTKhmgH4u
 s03n7W98K4bVXeaC3jvFsdySI+1vb/xFZWhxz3eqc3L+QOW+zMDnI9nCyc84m7Tinb8+FlKMdPd
 OCXLJTURM7pZUmnuAEEJTyLFWwJn9tqEOSswV95eCRiBH4zIEDzyZR819fZLoHLclJYJeN8ptc1
 ftIVWOntRsA1DnRPNFQ==
X-Proofpoint-ORIG-GUID: Xi0-zGbIdgkOozbVd3kF2nVgQO4Xa8Vf
X-Authority-Analysis: v=2.4 cv=V+5wEOni c=1 sm=1 tr=0 ts=6960a1ff cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=QbZleMWpBfZgLPXxXDQA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Xi0-zGbIdgkOozbVd3kF2nVgQO4Xa8Vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090044

Hi,

On 1/8/2026 3:13 PM, Konrad Dybcio wrote:
> On 1/6/26 7:49 AM, Neeraj Soni wrote:
>> Hi,
>>
>> Aplogies for replying so late to the queries.
>>
>> On 7/18/2025 5:35 PM, Konrad Dybcio wrote:
>>> On 7/18/25 1:02 PM, Debraj Mukhopadhyay wrote:
>>>> Crypto reprogram all keys is called for each MMC runtime
>>>> suspend/resume in current upstream design. If this is implemented
>>>> as a non-interruptible call to TEE for security, the cpu core is
>>>> blocked for execution while this call executes although the crypto
>>>> engine already has the keys. For example, glitches in audio/video
>>>> streaming applications have been observed due to this. Add the flag
>>>> MMC_CAP2_CRYPTO_NO_REPROG as part of host->caps2 to control reprogramming
>>>> keys to crypto engine for socs which dont require this feature.
>>>>
>>>> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
>>>> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>>>> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>>>> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>>> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
>>>>
>>>> ---
> 
> [...]
> 
>>>> @@ -459,6 +459,11 @@ struct mmc_host {
>>>>  #define MMC_CAP2_CRYPTO		0
>>>>  #endif
>>>>  #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
>>>> +#ifdef CONFIG_MMC_CRYPTO
>>>> +#define MMC_CAP2_CRYPTO_NO_REPROG	(1 << 29)	/* Host handles inline crypto key reprogramming */
>>>> +#else
>>>> +#define MMC_CAP2_CRYPTO_NO_REPROG	0
>>>> +#endif
>>> This (and the crypto ifdef for MMC_CAP2_CRYPTO) looks like unnecessary
>>> churn - crypto functions should never be called if the config is disabled
>>> in the first place
>> Do you suggest to remove #ifdef? I am not sure why #ifdef is used with MMC_CAP2_CRYPTO
>> (may be to reuse the bits if config is not defined) but for MMC_CAP2_CRYPTO_NO_REPROG we
>> followed the approach used for MMC_CAP2_CRYPTO.
> 
> We got plenty of bits, let's not waste the time of a programmer trying
> to figure out whether his particular combination of configs is going to
> collide with the reuse, I'd argue the ifdef is unnecessary
>
Sure. I will remove the #ifdef from MMC_CAP2_CRYPTO and MMC_CAP2_CRYPTO_NO_REPROG in next patch.
 
> Konrad
> 
Regards
Neeraj
