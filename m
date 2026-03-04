Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEA34D396
	for <linux-mmc@vger.kernel.org>; Wed,  4 Mar 2026 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609348; cv=none; b=dzh8uq4v2JQXRfsOOpIcKyIGcVfpV62akx5X0oD8488qb09iA82r6ixUND90mvN6CyeMFSFT3kQqB+R8enzE2BGPTz3SdMhlFD8cPuJqYTW1mSH5LnNYOFutuMa8lqa4r5mm/ZZj51/of6uRgKtu5ZRcAya9Cj1xsotp31huuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609348; c=relaxed/simple;
	bh=owgmetOP017zUc2xmYxQF4xO4rRCUn1Zs9CHzd9jTb4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=N2S99q4xIkhPkKHnH++em8wgK3wB5lj8iHxdRB+VsAZZkmHEELATXA1joPX9gDikc8vy6pNWvy8mEAEyDH2k69NRFI8OhYyChntQ6oJkjSCIKwnMLe78kZ86rcpD/A9dS58nx3e7wI1+QWuukT1iXvIxuyPJyqyFcj3KeyUWOsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L9AoUr2w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F1HHykAn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9AoUr2w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F1HHykAn"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SiFN632656
	for <linux-mmc@vger.kernel.org>; Wed, 4 Mar 2026 07:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	acRVQGvlsUrqD0vKmGV4gn6wFUEPlbyFgT5Hb+l0yOY=; b=L9AoUr2wyg0u+woe
	h/mIenrzyjjUQj3+H0OqNNE1ifR/4+1jC/pGGOcRW2O3Fr6e/jND1+rANqW3eSe9
	nzxNdOI4nxP1rV/Dl5pz7LXEELqXyNgBqZtum/dI2gLk9T9N3m/kcWNC5hSEq6M0
	mryvZNhKVJiinOyaYOFYTiyCsmstDkd96kfj8ZC+Ux5t4+b7NCKgumlmHrrwVMc3
	PpxkdfhnhjTCZZGOp/H59g/pD+OMEq13wlb6QStqfb4+KyWP/qFgxJkqAgnPbE6q
	hldJIUhh5nj66a5w8a1xKXYZqdKevDvCaa6hBHWoz92s/GMAaNZZucoSHJbAZ96F
	PWsgrg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvtuc1dq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2026 07:29:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae415b68b1so39595835ad.2
        for <linux-mmc@vger.kernel.org>; Tue, 03 Mar 2026 23:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772609345; x=1773214145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acRVQGvlsUrqD0vKmGV4gn6wFUEPlbyFgT5Hb+l0yOY=;
        b=F1HHykAnOhndPh5bTIq4WpY0lS/d3stxXv82FBLWe5e+7oMAmR5Cl6WzqJYIMW4JWh
         jjx2BPa+igYnl4lFY3SsMke4u60eX9DG05+vsqNhGZi4UB/pNU9BonvyAiRjbUpaFdSN
         7DipPw4Cl6lMu2TCp7/iqI9k7Kefym8XOWPtyXhFFpJnA4R54riUQns4s3+3SFbkA4np
         ACjdPdS5y0bLv+PudxKcmgbmHCETqOHXu4KxWKlqrTwawGgT5ZP64pTC10EHDrknF4Sa
         TGlCqLiL+fJT/Y04o75IBXuwp+r5GulbJfNMeh8DJuOo4GxYf8qcJK8CL/z3qzQEeFGB
         VxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772609345; x=1773214145;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acRVQGvlsUrqD0vKmGV4gn6wFUEPlbyFgT5Hb+l0yOY=;
        b=jLYJBAE4iYhvnA8vj3xWpqH4QqZ6fc7mUkd4Xrh1H7caHLHVJ13HFdAqRHBAm4Qdca
         rtXmdI5VQhTyKLu96Ictqh3+omlWvqULYOkP0wSHrF+LzTDBiUi3t7C4z3lGrWNNx8Z/
         ErzCFOuEntPiU5s4QUo1qP0lJL33PJpbX0Zo7qIBYYq+uVrvjurbydnAHw4ucphcx4KM
         oDkRToRwwDdbyXtiykwNpjYQyt2JNvgkmveEc1Pd42qlaWNemNwSk55tOrMIYtWMsXSo
         W+KvDEuVT9/T1TPUjI7bOADFvQ6qLJsl5227B2ll9nspzFIjUha5clMwGY4QEj5vloXb
         pQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8MrcAN03LiaoXp2nEWC6HIKkogYs2wE2WnuAjbR1dvcDyEShn6xja/Fva37GVxkqLm/z3feAkhMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Tvy9KdSYTKLTsWswPCPCX5+x7AtmxSm6ccS9vPKV/c7lszCu
	TXa4o1osZM272pQSUZllUY+RLubD8MOG4x2+aEEQictcibaEyUBbOMwt2Spiy1AvVkq/mq1fVld
	TXDN9GyWup9e42UDBxQjl1IoH4Mw75pXpMUdPk2xy7RVG7coeyuXbMnFlLus8nMoksgcdnAs=
X-Gm-Gg: ATEYQzwdwmq9L8yiJHouSuOsYBt6Ql/89Bt3devLwjBNojhRxt+urito40rOJ9rkblu
	X/sf2S3EP1sFCWFBwDI1evOEXQlbr51WWoyOc/sc/IKPupg+t4V97rkED4RHQz7PuVLTXcGoJU7
	6x8KshAo+PXpfihRsEQmAcj+C2+1Z2k9v/mVk2m3MhjIizPE5qOaz9XqxTZ0Tec51qAVSk68KOO
	V/RFEpdcAqzbNEQAaJaEGgDzvsBtHQVPN214f2K0rTeOvGU+0j+6SCuk4vEdV1GNGRl8MYyoKmT
	OgEjcPsGDDAJsFevaaNP7tByiKr/vqxQ8dOzN/0K6D0MpJAMU4AfTrK3+rSIePMHOvVAB7xjkOH
	KHQmpDza97XBRsgKtpqBYx5NTVtXhZxphxHe/sW3vZns7hxCjxA==
X-Received: by 2002:a17:90b:2792:b0:349:19a8:e00e with SMTP id 98e67ed59e1d1-359a6a7ca47mr1074425a91.31.1772609345240;
        Tue, 03 Mar 2026 23:29:05 -0800 (PST)
X-Received: by 2002:a17:90b:2792:b0:349:19a8:e00e with SMTP id 98e67ed59e1d1-359a6a7ca47mr1074400a91.31.1772609344684;
        Tue, 03 Mar 2026 23:29:04 -0800 (PST)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359aa403c57sm96394a91.13.2026.03.03.23.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 23:29:04 -0800 (PST)
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
 <21a87714-cd11-4217-a2aa-82fddc3a8530@kernel.org>
 <544925d0-cf32-6b2a-548e-d6f7cc517581@oss.qualcomm.com>
 <01085021-c116-46de-a0ce-730455620cb2@kernel.org>
 <32b7763b-ba44-4341-8528-be97d6607354@kernel.org>
 <06967254-7fa6-218e-db8a-8e4a118a7d24@oss.qualcomm.com>
 <3339ddcb-d0f5-4117-99fd-f3f158b7903d@kernel.org>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <04f83e93-5866-9747-b5f8-109ae3c16368@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 12:58:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3339ddcb-d0f5-4117-99fd-f3f158b7903d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ubIEh3Z-QW25cv5VAZUxNzKq_uCeeC29
X-Proofpoint-ORIG-GUID: ubIEh3Z-QW25cv5VAZUxNzKq_uCeeC29
X-Authority-Analysis: v=2.4 cv=A75h/qWG c=1 sm=1 tr=0 ts=69a7df42 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RyUJWM3ohA95taQL8aIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OSBTYWx0ZWRfX/BAujVf6WddN
 blJSt5rDWpttKMqlCj66kImEIwy/liq61EG+vAzgWADWC1hcr/hkr1mpZBT7JCQ2ebeyutLGEbp
 9OFr61VWs/I37Rx+j5PIxLKZ/EpSo7ZQ3y0Dv6CwhzAfal5Y3TkbOgFDif72k4s+WVcutCmM+nU
 73/muB51VZSAmp+mIC0jGZkeNsp7w9geQwrBsl5C+FfT+lC/KaUbSfNrMurnWVRs0DXdXVrHofX
 jq7BY1cF1Q3r6NX+YNmsvwsNnxCrsIJFpKMmxwZQtsHGZ9Cgabz3egrzmgFloadaBRY3VHBCTJ3
 gh/n2JMFfmH2MjIGL7+87RsEqjIupSfVsirQG7BPDkKRUUpIjMwq2VA7ArurGx6J15bX+ejnGaE
 WuvuWJMDFSi1Iw2mX0PQyYWS5ZH9xrxqxRfIl10vb7n+yaHl9813ytvDAIsYVLwJQZuEf4qkp0C
 UF1NtCf0gQhkqXqAv2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040059



On 3/2/2026 10:08 PM, Krzysztof Kozlowski wrote:
> On 02/03/2026 12:25, Neeraj Soni wrote:
>>
>>
>> On 3/2/2026 2:27 PM, Krzysztof Kozlowski wrote:
>>> On 02/03/2026 08:48, Krzysztof Kozlowski wrote:
>>>> On 02/03/2026 08:45, Neeraj Soni wrote:
>>>>>
>>>>>
>>>>> On 2/19/2026 1:57 PM, Krzysztof Kozlowski wrote:
>>>>>> On 19/02/2026 06:38, Neeraj Soni wrote:
>>>>>>>>>  
>>>>>>>>> +  - if:
>>>>>>>>> +      required:
>>>>>>>>> +        - qcom,ice
>>>>>>>>> +    then:
>>>>>>>>> +      properties:
>>>>>>>>> +        reg-names:
>>>>>>>>> +          not:
>>>>>>>>> +            contains:
>>>>>>>>> +              const: ice
>>>>>>>>
>>>>>>>> And reg is still 4? This is not correct syntax. You need to define
>>>>>>>> proper and final constraints per each device. I would write example, but
>>>>>>>> why... more things you could just ignore.
>>>>>>>>
>>>>>>> I had included changes for reg in v3:
>>>>>>> https://lore.kernel.org/all/20260206112053.3287756-2-neeraj.soni@oss.qualcomm.com/
>>>>>>>
>>>>>>> but those were not reviewed so i assume them to be incorrect and dropped it.
>>>>>>> Will fix this in next patch and post.
>>>>>>>
>>>>>> Patch v3 was also not correct, because SDHCI v5 devices should have 1 or
>>>>>> 2 entries, not 1-3 as previous patch said.
>>>>>>
>>>>> This is not clear to me. Here:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml#n80
>>>>> it says the entries should be 1-4 and there are no v5 specific constraints.
>>>>
>>>> There are, just scroll.
>>>
>>> Here:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml#n212
>>>
>> Yes i had looked at this but, as i understand, this constraints the minItems: not the
>> maxItems: and in your comment here:
>>
>> https://lore.kernel.org/all/21a87714-cd11-4217-a2aa-82fddc3a8530@kernel.org/
>>
>> you expect v5 entries to be constrained to 1-2 and not 1-3. So, as i understand from here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml#n78
>>
>> the v5 can have 1-4 entries without "qcom,ice" and 1-3 with it which is what i had posted.
> 
> We have long discussion and you are just not replying to the problem. I
> am done here. I wrote already what is wrong and what I expect.
> 
> Repeating the same as before in the FIRST comment: Your patch allows
> incorrectly four reg entries for v4 and there reg entries for v5.
> 
Sure. I will test and post the new patch with constraints for v4 and v5.

> That's a NAK.
> 
> Best regards,
> Krzysztof
> 
Regards,
Neeraj
