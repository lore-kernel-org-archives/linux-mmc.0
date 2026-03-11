Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67A3B6359
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239558; cv=none; b=VRjkgrAP3viGKnrXnPoPQ0E1y2rQUwAr7nkvXlT0rXIN8D5VZNkIkCk1ig9HoRnaPwdm6ynKS1Jie02IGzUf50Z1XZp3Qp2kbexZwySetfwR55h5c2KIaUJTcGpMsUtIZAC5QEqi4DTwcPfALJZVamGPHAf2bAuzt39syH4Ze6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239558; c=relaxed/simple;
	bh=N/qol3Rh+Mf5txiwvrJG7SjE9C785xyO9/8rlGExFxw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mkf1DYJ4ROxiUWFxUvAF/Ss0CZ+TnjzDBRxAtM9mYf3jO5uc4J/2wRTJjCUtILDvTuIMly5wHaIjEjdvoXN1aFcS5oj0q6BHw96spIcwZdYTNn8GJKsKKLaxXLJBbQJ5DHkSCqjUCy4tm+H7BEbTr3nwA/DKdHZMncaXyNmLve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T6ReN7Nw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XVcbYxyw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T6ReN7Nw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XVcbYxyw"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BA342D2038152
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 14:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D2I7e+eo+WIgicZriyeRrztNRyM4upZ+r1+QMOkzo9E=; b=T6ReN7Nwt3vwo40r
	uvlwbCZPYY+GfkKA16AK2/tigeM7AZ1ydxjhRd8CpCd+YbwhP5vIBUzPGNHpeO+5
	If45EDSFnJYb+/UArij1JmrRpoe12Rj+Uu5Ph+f+aRHDF7ijv65rnr4bhV+zlPhS
	uyie52CZ5NDOHfm/Z0nPfg8DOWVoNLjQKpr1kSy7XxzeG2LjkHiaUgBpjJmUBTFP
	saTM7bLo1njU+qvboSjBxx8CMrW2pX4zZCKRR7aOV82BVWYVIPWEscPoV4qBjxO8
	ax3yujViHW6CIgWyNCnGyYgjJwbb96p/IxF2YyCqGWlLq5iO/gQZwsRX0rTWSirH
	A855nQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu6a5gxj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 14:32:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3598c05c806so10416045a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773239555; x=1773844355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2I7e+eo+WIgicZriyeRrztNRyM4upZ+r1+QMOkzo9E=;
        b=XVcbYxywRsxsp13T2VIzDsowQfCvaPvlYinVoKIvQhhnCbu5BJwZPKvI54tJ0Dp9L4
         ntSJZxsrbi0hxz+vXebrzBdmDSceMWzCTrM0cFWVGmhfAAU7IAK2Tvml4L3B7hI7cPIS
         wevadrgyavXtN4iBIu7Jmguf+JHVY2HKNvOB5UXATu4VVGG8ck3b7qojwG8JUptyneGc
         l4zEp3HwWxYRjDU6xm1DKNUzg6LFlAxmUCFyAvDbjiLMqKlDo+bR+stNGmrdzPwPo2Ea
         g6/HeJvPTDPLSUx5G7PPAQVmq0d9i8QxLGxJnuqkhKYhrPesdDF8ITemv8DNBblvVeGu
         gzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773239555; x=1773844355;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2I7e+eo+WIgicZriyeRrztNRyM4upZ+r1+QMOkzo9E=;
        b=QwAyG49Tg+BFv4o/aYYQfzwEwq0Vmus6CEFP6NPKe7Qs1MVOckWFTufZsvUVFib0OU
         lPOGqavvHFXjTYYJNhJBKXV07rruue0Mf93hV/9VslcFuIjbkoEkCPeYnE8t//xC+fQB
         Kxqo01xSRxZJzDtaqv3i/DshvLLRHZBm/Y1yqmB/HsUs8jodrMHMgx1899uZc5T0tBi4
         f9/Pc5K+mvJSk1b2yOY1EQZcaNGIonBMoHs9LbZpWHBAa+kja0fNeEf6Rbw+Gm8+WCtj
         qiRVco0ub/IJmVyfwD2o+MBa66fmlBuhYKl7vtLoEDQhe4jfVvaE6pXEWtOhegBTzp5L
         WUhA==
X-Forwarded-Encrypted: i=1; AJvYcCVOdhP3HCGrI2maDGbZWA9uFWHut/Ks4v1tV7pHyffz9E7fTdBBxu7x8aNZzpjKNev7YTH8MWiwqkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwImXZHO1AvR7e451TDz7oC+aL22VL/zXTELYNlZQJgYLkJqDfZ
	sFcE9RA1j9geuvvjrg56bzfDMKyrBldPl20imh2LZXiM02vwQdkR9oPF8m8yVgkYDSho/0cL90X
	ZsrBPmsv8uwgq32C+PpXCNb9RZBJLHcCAA9eLFsvEgHaHX+BExmuUh7hGQqxaMFE=
X-Gm-Gg: ATEYQzxldiVNcEnRpspOYEPSFR5zVYK7YMpVdOHmG8xu/rsbFJDOghyANLlFwtsvuEN
	IuCXnLqVo+oPjl+Exzq+a3/FPZ+3gGiEj4gTX3RtOCwD7VRMt0t/wYg049jZ9r9eldWdjFga6Iv
	ZTpGHHr/ocTU9IVzM+cr8IOiyxtPS56yclBbqAHyd3Twxza+4xHBEjqI+Sdj3k3eaTutbn+W030
	93k0Wq2DcUIr7/7gCTJxgUbQ2BDeKOAi9wTGslem7sUqaYObSRQvXzkWrZCFj0UZAspEHQG9YLt
	uphKks9epBx73+cFcALySS6WWlWCFa88agmw8jVRcPxw0dfK+/EPBW9Zp8wF7Cv8H+qfHkSCnqs
	Hx0vEEQ+JRKY7o3CWqi49he3giHiJxqUbTLTacr6MFyxRDLnROg==
X-Received: by 2002:a17:90b:28c5:b0:359:ff8a:ee3c with SMTP id 98e67ed59e1d1-35a0131fb14mr2419053a91.23.1773239554654;
        Wed, 11 Mar 2026 07:32:34 -0700 (PDT)
X-Received: by 2002:a17:90b:28c5:b0:359:ff8a:ee3c with SMTP id 98e67ed59e1d1-35a0131fb14mr2419021a91.23.1773239554053;
        Wed, 11 Mar 2026 07:32:34 -0700 (PDT)
Received: from [192.168.29.77] ([49.37.152.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359fe40bed5sm3076449a91.5.2026.03.11.07.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:32:33 -0700 (PDT)
Subject: Re: [PATCH v6 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
References: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
 <20260310113557.348502-2-neeraj.soni@oss.qualcomm.com>
 <20260311-fascinating-qualified-whippet-d6d450@quoll>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <4c048284-7552-6130-0db4-1233293d6d72@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 20:02:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260311-fascinating-qualified-whippet-d6d450@quoll>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RaC4onQh4gqc9QnRlv0GBDxOpQjoX0eh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyMyBTYWx0ZWRfX9iVitoff0pDR
 ZVwFPdWyQeR6edWyETl6ghbVzlfOlW5bHBixawSKbcUW4Ux0RrD8K7LjwJmOnjMmUt+a5SV+wii
 5+Fz//J4k9N529DSWyL1y5wQcWBohyXdBvc9YOY9o6tzKkc7dmRpTZM/hi3NGNwl8nNah1MgiL1
 YkydwcHcxVseL75t3OPFqwzy24VVSDG9wLLc1C1/Bo0SeIBrjniEtp9bGORacGM1E/5HvBM6347
 WBPSHbjqiHjIcPlPnPTbJEsIO4DZC4CbC0n/LnZNPTfH8RhA4gnJ+g/MRG3gMVPU0f9Rb027Bb7
 UlZCuScuWgkV2Ell9GlwAY7xzLjZPE9eL2CDBCMdFCaZShhmABrBfZ8B511cbvjGTGxSoyAXbg2
 Xtq9Klar/vpadmDN6KJP+rcD4jjOAdYHYZBRYpfcpr9BU3AZX/lJe/VirMaXWGTn1NUkUl8AYKr
 6gP5lanDXTCYOYWxcVQ==
X-Proofpoint-ORIG-GUID: RaC4onQh4gqc9QnRlv0GBDxOpQjoX0eh
X-Authority-Analysis: v=2.4 cv=TtLrRTXh c=1 sm=1 tr=0 ts=69b17d03 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ldcrsYo+BdVLD9vkGBuAPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=P-IC7800AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=KxNIBlHTTW4pjOSnca8A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110123



On 3/11/2026 11:46 AM, Krzysztof Kozlowski wrote:
> On Tue, Mar 10, 2026 at 05:05:55PM +0530, Neeraj Soni wrote:
>> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
>> So add the qcom,ice property to reference it.
>>
>> To avoid double-modeling, when qcom,ice is present, disallow an embedded
>> ICE register region in the SDHCI node. Older SoCs without ICE remain
>> valid as no additional requirement is imposed.
>>
>> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>
> 
> Can you please finally start using b4? Except errors in your process I
> don't see links to previous discussions either.
>
Sure. I will be adding links for previouse discussions going forward
for all patches.
 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.
> 
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
>
This was not done on purpose but i missed to add Reviewed-by tag.

> Best regards,
> Krzysztof
> 
Regards,
Neeraj
