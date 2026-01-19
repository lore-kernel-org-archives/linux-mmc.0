Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55552309EE7
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816577; cv=none; b=dVJI5PSkFTRbZ2ALkYkbeH6V79OmbJXxzT94C180S9FtGBNLRHDLcCOmliG+Ynk3+/APuJnGDYtu6JhbSfpzgDIJVvVWjYBQNwEehs4NOfBRUR/2u+vObU8NCdzY51wRW4lJFvsAaVV1vYRHTOwDlcdm5bOWT8Ha68FTsZKqp34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816577; c=relaxed/simple;
	bh=3oNxDmMzMtOu1B5PHeK1M4AxBFzLjHZRNYL1JD6/tjs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XBIRST2JZW95YMQnPPYQGZbTw/m3EBVM2JjC9/vh1FWPUuEQwjNndyUkOtpQCdUvJuZEOD/uylxU8BGa81yuZjm1Hn5Jk8v0UL2JU7pZiARv64i52Z1ar8ayGvaXB9g7hiM3ft7nFlKMk9YLUpylevMvA+U6lCvD2FBRLbbk/Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gqiEDyHv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fSK+uz2w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gqiEDyHv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fSK+uz2w"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J91G7j748360
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 09:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HtQOqvpNcjHT9N67t/m4FkhaK3GIb4GUQJ7GAEuX8pw=; b=gqiEDyHvNSfgB89C
	up1oSaIi5roHeAGh4yEBX8m4bGDO1dOxRXxOk6gio0ChWWPBGgkm5C93Lrso9HBa
	KXb7Em0IY8r7fEJb0Dr48vwmyJ1EmpPCN9kOrz41SjV5qNNOZjBunPc/dGIklcBE
	fz5UJSfCsja4mrXooOyboTUAIGpnww9LrcdlOTcopitcKTDP6zzDPgGPIW/LCkSv
	fFgPR8srEUgFuKSMIzA4bhQwzxWjJODfmH/mOeNvfjHtjeQRVlZN+U/VYk9rL7E+
	0vIDBoNK23BRYxO0LVMFN8sdDEigNcatgfCbPEONrKXWxn3UMIOkFwlarH0WFBfO
	+HaOVg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br2t74jfg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 09:56:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c66cb671fso4305453a91.3
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 01:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768816574; x=1769421374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtQOqvpNcjHT9N67t/m4FkhaK3GIb4GUQJ7GAEuX8pw=;
        b=fSK+uz2wqr+3Ey30rVsnuBMymNkWY5fcUc7/WjMdLzl7WLz26aKDRaFv7t7pygoN+3
         RiMPsg+XMlTuz7AbVULiLTlc1d36Qd9HTJjhiJnsBgkE0aLX4Bhl6EilNsfKRevkPXe3
         nqAMD3m4eLTvHvAZQUpHORN3iTX7QjQqfkCiGSi5cYORF32/lxfo+uqHWpJy5bVR0OIp
         E4xuhGKo4HSbqRS4N8W6ZrJOB1/mSfTEUBl+Z/6H/7hHXFmjXOKKPmC6MEzKWufGQ6CN
         YJ8KQZX/co1XGwPSolMPcVrEegIUA1dKDI8EO1WYlaH9X2wA7FRT0gyjkRVn+U+YIx+j
         eY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768816574; x=1769421374;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtQOqvpNcjHT9N67t/m4FkhaK3GIb4GUQJ7GAEuX8pw=;
        b=ZY5larYhqPIleF2KmGoTYaNh1LfvR7XpDbEvUhK7ICvAVqodwa5GpBaptGVyo3WkHE
         c/9GQIvSe48NqL6iHn6SAomKUibC45vBxvKd39sdaByc3O7A9HILKS5GsQ1iFiNcbhid
         TB0isSogNE0Y6masao7rJgxwUiFUQydZacusOfwEfLG/tREyIXydgWL+hSYKDGRn7H34
         KDkT7tMDNOgqDBpuBlalTaJAXzRxw1LIjuo/f4ABqTFyBjnzCThQHrKaxvQ7zNezf6Oa
         NjNCdlcohTj7te8PtjdN9ojDos36aOQvkwxS4o7AW1+b8paK1tPaK/LtKW7bFZfZnKMF
         yk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIaMBu8bvQNTzVxc1V3KZeydA43zx/wVKoXTzDdEm+2PXdBZyVkGOp+xtVzisdqJ5iDwlmVD0niwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGlo9qzUVze8JKs9BrAKOL49ep/lopmh/Cb4WQV5CL+NbwSLw
	bIJu3I9gpc1nU4drXZYIk/LOFjjPVIpeKud4H8GCw3j7on8S8yvoAIQftgBzYkqvDrS1W2o5oMa
	k31bJNg/9T87crw0EriNILoTKuUXFbOyPhlMmsUwb0beAmSfcVyKw4lt4xE6tuw0=
X-Gm-Gg: AZuq6aIzZk/0T7wM9omCjmDr7768JC8dqbTycLLzt2rIysySVS5VbuIOCnhfMgA4r6k
	HUmRV1w2hIzJcDTJyduJma2wNf+prJub291TIt71AYX4RaSCfS8VwVutZfwQqeoOOKQhbDoBJNc
	EUwR3Kbvr/RVK0YxVfFy6DSoxhosBoF7YeOVak7M3W0pRIlPi3VKhr6gzMPLUpEc2erAcOPJzqp
	VsB1aEgqXnOuHNwBI0FxAXjqUHFck4dlhwIscM6GkvwhEDl/aLqgwZDoCwyQpKegigzcja8mE7x
	z/S/RBfU83kI8D513zlvwOnp++JlY4IrYn0RupL0S1KUUZS94U4i55G/eKZLM/7xHptMPyzyoGq
	ckWZ4ySneOIYi/GfzxLs3/JXRJW0tXf08l60BWSk=
X-Received: by 2002:a17:90b:1c0f:b0:340:c060:4d44 with SMTP id 98e67ed59e1d1-35272edb230mr9211764a91.14.1768816574277;
        Mon, 19 Jan 2026 01:56:14 -0800 (PST)
X-Received: by 2002:a17:90b:1c0f:b0:340:c060:4d44 with SMTP id 98e67ed59e1d1-35272edb230mr9211749a91.14.1768816573805;
        Mon, 19 Jan 2026 01:56:13 -0800 (PST)
Received: from [10.217.223.153] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527437f00fsm4131291a91.6.2026.01.19.01.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:56:13 -0800 (PST)
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: kodiak: enable the inline crypto
 engine for SDHC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
 <20260114094848.3790487-3-neeraj.soni@oss.qualcomm.com>
 <20260115-versatile-bustard-of-bliss-059e5a@quoll>
 <e10f846c-e81b-1d5b-1be2-8c41ca61b8b0@oss.qualcomm.com>
 <0f1afc5e-d5f4-444e-819c-594f0b1e125b@kernel.org>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <f38e390e-dba9-d02a-e5dd-8eed3d0ebdc4@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 15:26:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0f1afc5e-d5f4-444e-819c-594f0b1e125b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Fdc6BZ+6 c=1 sm=1 tr=0 ts=696dffbf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Wknet9ZBI_JJvYukRKwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: GJEf8ZghvDVpgEnTAp8NCb5JNi_H0q8C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA3OSBTYWx0ZWRfX0i7aNoUO2kkN
 ABrQ6BDAujjbBSmVfyq5j287J7l+kPaZ04bwBg71oZQsR0WpFwoIKC3Z2+WvIII8fTCh4O1kioJ
 lQUI+ohE7jAkpNFrCXCA2gEXfbLXNoz+Pa7UslSainC9GG2tWXrStkfGk427573jwLFlGahIcSg
 0OmRF/LYJHT9gDFeCARrctddZ7JtrcTCJOfI5d//n85GMJEo4VBlhiEV668vDkfnFEpkJl9C5Nz
 zKgMP7CIjis1eg4vfC4slxmX0E25nCXJKukXa4F2UP/4L9dZSXBxotN8X+biyo9q8bPW425hlLP
 M78xBJDJUCrjLWv9NC7mKBxaNEBlOUA4zNY2xMr3WMwwPuSItIOyQjDdwqkWXpTfVEUUbM/yk52
 sFAPQ8R17msa67z0hkgqVzPmYTH5uzQu23OhtW3VjUW9NTq0w0LA3XZkoPctL/Mre2gVaTVLpjB
 9KWVX3jyWq/A4iQj3jg==
X-Proofpoint-GUID: GJEf8ZghvDVpgEnTAp8NCb5JNi_H0q8C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190079

Hi,

On 1/16/2026 12:49 PM, Krzysztof Kozlowski wrote:
> On 16/01/2026 06:59, Neeraj Soni wrote:
>>> Why this became uppercase?
>> Thnaks for pointing out. I will fix this next patch.
>>>
>>>> +			compatible = "qcom,sc7280-inline-crypto-engine",
>>>> +				     "qcom,inline-crypto-engine";
>>>> +			reg = <0x0 0x007C8000 0x0 0x18000>;
>>>
>>> And this? there is no uppercase at all, so maybye you copied it from
>>> downstream, but that's not right approach - do not use downstream code.
>>>
>> Yes it was copied but i missed to align with upstream. Thanks for pointing out. This will be fixed in next patch.
> 
> And that's the problem. You must NEVER COPY downstream DTS. We repeat it
> and repeat it...
> 
Sure and i apologize for missing this. I will be fixing this in next patch and will ensure this is not repeated
in any future posts.

> Best regards,
> Krzysztof
> 
