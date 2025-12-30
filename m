Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1E257448
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767074570; cv=none; b=akmdt1fNdERhO5Ikp1kHIg3vQ40/xdz7EQE4vPkbNHrjZjPIw91LeX2VHY7gals9DS1bolFhDbQcZv0YrNL5HQCyZQBcmkRgfj/dm28plGveJi7nOeMnWxw/LkbTwYAFOk8HijKNt30N4pu4vt7IcDYTvhTuqqq4PJKkD51kPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767074570; c=relaxed/simple;
	bh=Kwas6i+yO6AYTCY2Bi0oOc14wGQ+uPdyWPo2DNR48tU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=vFjUt8HVJuWVDsqEF8SCkwuESFOrmf7jS6Mf1gwMEJ/My32mFDqGckS/IoAHSnS5aVHHkv6AJwn/g/Vht/Op5QSM1Z8sbj7d0VbBkv+KfEWRbQUTD8l6RfxQXYnyTAyGtE7Nh0/uOkWrJ6E9APWOEEauRPf0IAGMvZJ4spk1GWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DWwr6CD2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NYGS5n2v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DWwr6CD2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NYGS5n2v"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU3jb8D3555789
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 06:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MElqb+vB8K63hON6iSmHcwD/Y1fFl71V1NoNoV+IIa8=; b=DWwr6CD26zJj9Mel
	hBupvAC98jMDa9PzB3IcvY7TpUsnZBkglg7k1VAIyhMqiAEiF4vFfhax+1eK/FEb
	CXTV95mGjbUjmUKp2GOAFvSl46OlDKrPtrkMDrUNPeDkHYI6/OyZ3tAbC/PtqG7X
	ouk0G6GK38FjH4Keed6ailPDI6P94RZq8RNW3j1ezm6qm6TE/ds8bY7GY17Fltuf
	P9k3cC9OXfI54wW7+WPXLhnZTbd5+9QXiNxqMtTzkA9mFG+UsF4F28c6xx9lMPji
	J7sOKu63HyBYWn6V5txYKhHaTPPIxwtgXBU/bxrgyBFdw6JSlNhjzc/O1vVDzcJ1
	kUI7nQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc74608f1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 06:02:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c5d203988so20743040a91.3
        for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 22:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767074567; x=1767679367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MElqb+vB8K63hON6iSmHcwD/Y1fFl71V1NoNoV+IIa8=;
        b=NYGS5n2vjxF4kNuYqChFFYL1mw6kIChC8S/wec2c0DNp36+zx1fepfxOZgaaQJEiQm
         agLopHvcaMDA0lD31sfPhZzhvRxUd1lCH+ScnKsC05tFQFSLQBi8gWRwOTg5nzoAXYla
         5r9tkVzrXfM9bYDxj0EQBOjaHGEcU6F95EaB/nrCE9tAMHPWmzNeKx9pGCqiKwT4DLlU
         tlKWYquZ9RYGp/c7FLUI1e9soe7uATE+FhrxVXd+Ge1klzOnAUmou6k8aW9cbc9803mX
         uW8h+yChYFSu29yPPCL/eGhNNRb+DE54aMkzrH9Qs29b+cUTxQV0v9ATUeOc2EML0I0V
         pL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767074567; x=1767679367;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MElqb+vB8K63hON6iSmHcwD/Y1fFl71V1NoNoV+IIa8=;
        b=CJqro+fW50cv/YQLBZApw3z9GfhxFDnweHmwEuqqkpCfE6bDi4RoYZv15+YbA/3+Xl
         VwgC5ZK+dBEGXrbMa7u/X80wYqFLtHZcbJfkQP/b0aiN7duF1NV/a3/8do+8VDctNcgw
         CIPC+nqSxAwejB3cOVddxlmlCQz+asfl/CUAbs8wV0a/rFIXZOgqKBiKNqbYh1taguW7
         id6F+jAh7rhsddsxFkfVO/aUwvLwFUTLUf+4NTSGCZfPuvKw27Vquvbbe1dGoo10YIJ8
         bip2A82Pjus2jYpBpkSLPFIAXkM+A6ltb8NOSLw+5G/nPRUjzptf4rz5t8uVk2t4O3XG
         HKSw==
X-Gm-Message-State: AOJu0YxqMpVvdNbLJLSgfgMd+m8Gs5b20M1WeuOCFV9df6M5eRbb4Zl3
	LC9KotMk1WXhV92hNRQlt34a7MAgGGg6exRznhkt5k1lJ8skc9doTNkDocxh9qaBNLHopguc2fj
	exmMp5PLgHPiUjUR/cEnyXNyKN+Xot3VewbpCvzKJb9shbi6wWU3Cg/kJ8UKnWXc=
X-Gm-Gg: AY/fxX68KQ+LCQYm7NG3VRBOPe1tuTK31dskbpv0aEp8FH2nXDz49Re6kI4T1KPl7Z7
	D0hBKZpdQ5aTLhT79GNO2OMyqOLqzp4V42ZYf6GbVkRVB2ntX4+ehmWtxQGN2tJzBX5oeR80kAV
	/uBaGA4DJI1UrNFDjsew7RnInqJEnH4dT19EmnSd2OkjbQb6r403Vvc7f3XbNnJAOcxSb9DipgN
	IthHk/0YFjestd889ZVsqIkvUiLdZpn9OTo9z5A8WOCE6264KM+IjpkOTDoVd4OHdPhu7rF6XcE
	U3DDc8GdsWMI2V23wnl+R5gVBr7stCErNDhd2ydWf0p3kWl3dHsu4I3ycH4wpOqzhEwqpJ6qe+t
	elZUoi7XYvJWyt6DdRmulGpWDGsSGW5IxNUGmp/g=
X-Received: by 2002:a17:90b:35d2:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-34e921e057cmr30065538a91.26.1767074566739;
        Mon, 29 Dec 2025 22:02:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcdegpDZU4uHFbOONZR0iUuxpEWmvOTtglW+/1Y/PXUFGcUNtlm4gnCiJfdjxq6efdjBrYmw==
X-Received: by 2002:a17:90b:35d2:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-34e921e057cmr30065522a91.26.1767074566240;
        Mon, 29 Dec 2025 22:02:46 -0800 (PST)
Received: from [10.217.223.198] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c530f72sm26471509a12.29.2025.12.29.22.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 22:02:45 -0800 (PST)
Subject: Re: [PATCH v3] mmc: host: sdhci-msm: Add support for wrapped keys
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, ebiggers@kernel.org, abel.vesa@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
References: <20251229070507.3322149-1-neeraj.soni@oss.qualcomm.com>
 <cbf3fb8d-1dc9-4c16-9bd6-df45530a025a@oss.qualcomm.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <b116f43b-e3ad-4e28-7593-17d2c3d9d52e@oss.qualcomm.com>
Date: Tue, 30 Dec 2025 11:32:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cbf3fb8d-1dc9-4c16-9bd6-df45530a025a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Do9bOW/+ c=1 sm=1 tr=0 ts=69536b07 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=90dgnz13A4KOmbfFnlkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: e94X-hvOyLc2MD_Rtc3AdSSHQsfMUPzL
X-Proofpoint-ORIG-GUID: e94X-hvOyLc2MD_Rtc3AdSSHQsfMUPzL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA1MyBTYWx0ZWRfX2xlTp2ys1eb/
 fKAbegTXHy/TXtvETpBp3R55d6mqhQ1+TKpMxwDtfxHiui82z3NY3EuCMdhGF+9VKLMWgkf4SBt
 UisdebQ60/i76m/wvzsmG3GV4dyYt++zmFJueTSijvfGH9nf5NhKeknAgHeLUO7+s4cMLyfAB4q
 JYsDn4HGHC7KqOxuo5TkoYNgVMdUB8BLqHxerlQk2wEdzqEmpCDwkGMk9Yii99px1CaGF5c9IVd
 LiPaeD6oZP3RJNgDeNZ51Z/+cknh7u7G02pi1ce/4aMnq0DBbV/aTtjPqTMfGyacTsgP+/q0ZEF
 IMCfHaoHzr/mbSgLyQrkLVAp2rGBJC0SzqDVri8aM99FXSsDWuJ9Xxw/svjNAUC+MktxqchBjBh
 VUE4wi7MAddtIYf3Y/ViKuB6sFRcznLJrwcpPyXK2v+sTwoqGLKYpwgsCC72aMmXmoNzLR6jmfx
 3Gx5GLvtIYAamYbWKDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300053

Hi,

On 12/29/2025 6:48 PM, Konrad Dybcio wrote:
> On 12/29/25 8:05 AM, Neeraj Soni wrote:
>> Add the wrapped key support for sdhci-msm by implementing the needed
>> methods in struct blk_crypto_ll_ops and setting the appropriate flag in
>> blk_crypto_profile::key_types_supported.
>>
>> Tested on SC7280 eMMC variant.
> 
> [...]
> 
>> +static int sdhci_msm_ice_derive_sw_secret(struct blk_crypto_profile *profile,
>> +					  const u8 *eph_key, size_t eph_key_size,
>> +					  u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
> 
> These should be aligned, please touch that up
Thanks for pointing out. Will fix it in next patch.
> 
>> +{
>> +	struct sdhci_msm_host *msm_host =
>> +		sdhci_msm_host_from_crypto_profile(profile);
> 
> Please feel free to unwrap this line (and its copies)
Sure.
>> +
>> +	return qcom_ice_derive_sw_secret(msm_host->ice, eph_key, eph_key_size,
>> +					sw_secret);
> 
> And this one too
Okay will fix this too in next patch.
> 
> Logic-wise, I don't see anything obviously wrong> 
> Konrad
> 
Regards
Neeraj
