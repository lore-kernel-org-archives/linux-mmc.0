Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8B2346A13
	for <linux-mmc@vger.kernel.org>; Fri, 16 Jan 2026 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768543156; cv=none; b=TSRzwojmpQD57cz9xl/UZn2/fi9ymHCdnKG/kvJboWnrqvnQRTQa8k0Dp+YRAKc6BgdaQmz6iE1XhKFfaV7xnqra8HS89pfjAxS5IIlZLb7C05wBy4haJQS9MbtjeFqhdKlTjz+jtCb7IAgudvDQ3gU/Gfy0qoMOfqOvlSYjT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768543156; c=relaxed/simple;
	bh=iasMJ3+z9y0C5JSvUPL8dpwrTYQTImmk19TxYiQUITc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sI95HzA48PlJvYnJkjClq3pDCG/F4lvnNNW1nLWNMq6CS9drozVdkaLthCZgRDNJVPNnPP6Ba9dnDw3+yJ36/tsXLWNi8MPoUCGrasRGWuyMCKULaQ+s+hnxwsWe9FSWHcJIyorQUp6yJmF9vrQYSjqAQEm3dqFWAoJQvWJ0HaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0FR+YFc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZEdH648+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0FR+YFc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZEdH648+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMhlvq2819530
	for <linux-mmc@vger.kernel.org>; Fri, 16 Jan 2026 05:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R0clKylXHNFdxX6QHJyndTClU4t9+CvQcFZTqi/fbos=; b=D0FR+YFcB5YuxabK
	Do61k+L22Ka9KpLbQxLWAju2urmB0DWYNQDh6CEx0ZKi5fajwOQJTfAEeQVwoSp4
	2SccKcB0EjQVEdhpRZJ0mQLolNcX80TwDOMFUeG0xjF8WTUo5F4A47IvkpW9qRvW
	hVFTjVXvW9ZQGNuj9ohh3FCGB+nj4D4vapbzfEW3ZoQWbNw2NSd4yoq1ETi5Cvm4
	WJUpAPitpAWnuYb6Cjqdk6TE2VSyiVB+ValjWB3t12l9+Rj4FxL1TaMtmdHzDtM5
	oZf6diZXU/kv060mDDwM1EqL+mGz1VKyad2oGWeVvwZ0DIovIn9D3xcPHjBUvUvm
	45W4pA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq99agyrf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 16 Jan 2026 05:59:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34a9bb41009so2132367a91.3
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jan 2026 21:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768543153; x=1769147953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0clKylXHNFdxX6QHJyndTClU4t9+CvQcFZTqi/fbos=;
        b=ZEdH648+54v/zNNxS+NIIVVcWQwGtsSQ3/cC8bvCVvhQJH0PVtc3rIZX0WU2CLbLvg
         zV9qfoxc8GA+4tXK5O58wqxZkV7Ll94snsFirk7uREg+/xrcSS6PjI6UjC3E9TRO+NgR
         /1IWDjLsiAwF93PnQBsXLckQANBoby6obcQFMrPrCKkCFJlzixxxAdDg1WBWvTe2Sp6/
         HPbI0zSQY26tRK2aCwvvgKczn4N9qMqOaF7Mdsst4lMiUOLXqS4e/xEbJwrSq3UyXwmU
         /hXtjQLONrAFeuL2Mx6E+OS1+z4dmV8fZxHqnzVZbku8nCPaLUfisxu5N1yKZpa2lnJJ
         Xjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768543153; x=1769147953;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0clKylXHNFdxX6QHJyndTClU4t9+CvQcFZTqi/fbos=;
        b=W/YXsVhZFZEG5W9wHILfazB7SJW4iRhS75muJeNVRE/3mOVnrHiXRg9xSp7wB1RTex
         q03GAFWNvlcM/oQQm3TD1eLu/OyyuY0i7A5CgxD+C2yBmzsqCn5BpexI0EughXNi2nrl
         7X7HVDtj+W8VpQbdrLpxhWbzq3cYgN1komJoowsZVM7zYQeHuJ9ZC7Dgb1ZPU8Q8mYB6
         Ir8TWHkmyr9O1yyzQTApjNI6ytcYhk1SCzHszkJlVw1i2aEU6RKWHFVpFs4IPP1r+NDI
         tLK/K1LqS2npszVKKP6Xj154Enn07ASwdE6qwxY5x2p1tdH1VQyOfBYcDNIWLSkjkHM/
         LbHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyldjIbF6mvWU+czfrT1McNxr3aK3CkkfWaorLuFUi61X3LeoN8Qd65aVDyW3rb7V9+cPEw1NiNEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Sb4Oq27MuqFOcTY1JWY/U2Lm7kvHvr6ypxHyjJO3jkwXGoRF
	RHzWMJ0wQ98lc6uCMWCrMkKYxzUF4SjuBYB5WXTysuzP3s9cGz4w9YQDNGnqPyEgm/xnxpvOMmr
	Ym59bWsn1saxZjJr3aH2FwS4Ai06GqVmWmbW9r6ATD7+SQVWTcNc4pxO9DyIygs8=
X-Gm-Gg: AY/fxX4SFTtxv21LO53Th3jLDLoT1gZRa/3U/9mS3Bcx5ZnSB53Dvo6IxUdHofmPq9e
	ztgs1+Gaj5zG6nXTgKQ401iEWiZaAQoZ4PXzNodJiHRl0lLEUjrTWPA4/uKPuOkq7d5VjaYeQXa
	4tX4RvZRkz98MpUBCT0X7/wJTMgilzj2lNMaTKtRAchtRK5OOLJ/ulGPOXqDXuVgdt0UhtBUwB1
	F5U7IyVgZhl80tj5bBhR/7HHoZ7UUwAoIarmWNmYwK4Q/99Ay4lkiL+MLVDJQc1uVrfcx3ztkFb
	sew4GHmRDyZfH6oirUZUoe+Bz6Qg/OJ/VbGUfarqNNKhEWVn6TwOrq8+Gbe3wk8ZexlBVyna3GW
	Uo98A3L/EFttrXQRETqfQMQUDqHh+VeK5CIUmKdU=
X-Received: by 2002:a17:90b:1ccd:b0:340:f009:ca89 with SMTP id 98e67ed59e1d1-352732551aamr1379335a91.22.1768543152826;
        Thu, 15 Jan 2026 21:59:12 -0800 (PST)
X-Received: by 2002:a17:90b:1ccd:b0:340:f009:ca89 with SMTP id 98e67ed59e1d1-352732551aamr1379322a91.22.1768543152365;
        Thu, 15 Jan 2026 21:59:12 -0800 (PST)
Received: from [10.217.223.154] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf249fcbsm1037082a12.12.2026.01.15.21.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 21:59:12 -0800 (PST)
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
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <e10f846c-e81b-1d5b-1be2-8c41ca61b8b0@oss.qualcomm.com>
Date: Fri, 16 Jan 2026 11:29:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260115-versatile-bustard-of-bliss-059e5a@quoll>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: l2tKBibEpOnXvJxqKOUnCcCTRzhdpWke
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA0NiBTYWx0ZWRfX9IeWGjSJGDNC
 O+5Ngr0Z+AdavBCgIh5giyTlZ0wI7alkFi1MG4oOe78fJx64SHpu4iPrHnNVJY201lfrTh6GXJv
 p2WzuRyp+pbFbBY36jKr61WH9p81FbkjrP2JCidDgCK/kEx3bLuA5Bp0EQvgmjQwXNVMHl8Mtg/
 JrSSPUiC1wzmDSiAiFnPh/OmTUTdeg+rlIdAw2YJg2+FIAB6LA0r6xXUjGnTgJF/gdx+UWTMhGT
 R9aJ+OIvbM7k/F6hIRpZqcGxFkTMrdOiuw5l8Z+wMtdAyUVgyyyGnEySI94LJu56vOm+CmG/Nkh
 3z+PptJS4Z4siFLYqOWx7OFHSoN8vrocxhJlHRJUlA/zyxQGDDLk0oBG8uQi+avTZ1tuGSdKQ+g
 Tzm1KrnKedhk3dLWUa+Ry80MLPhGsMCHW500mMRN40phMgDHCBxhVl+IVOEwnsjjhwphx6mmAki
 JQhMOTJng7vkHEhxD9g==
X-Proofpoint-GUID: l2tKBibEpOnXvJxqKOUnCcCTRzhdpWke
X-Authority-Analysis: v=2.4 cv=f5ZFxeyM c=1 sm=1 tr=0 ts=6969d3b1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=SWxB8Vgrg67oVZcRXj0A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160046

Hi,

On 1/15/2026 2:35 PM, Krzysztof Kozlowski wrote:
> On Wed, Jan 14, 2026 at 03:18:48PM +0530, Neeraj Soni wrote:
>> Add an ICE node to kodiak SoC description and enable it by adding a
>> phandle to the SDHC node.
>>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> index c2ccbb67f800..fb2a9c0ea0f5 100644
>> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> @@ -1045,6 +1045,8 @@ sdhc_1: mmc@7c4000 {
>>  			qcom,dll-config = <0x0007642c>;
>>  			qcom,ddr-config = <0x80040868>;
>>  
>> +			qcom,ice = <&sdhc_ice>;
>> +
>>  			mmc-ddr-1_8v;
>>  			mmc-hs200-1_8v;
>>  			mmc-hs400-1_8v;
>> @@ -1071,6 +1073,13 @@ opp-384000000 {
>>  			};
>>  		};
>>  
>> +		sdhc_ice: crypto@7C8000 {
> 
> Why this became uppercase?
Thnaks for pointing out. I will fix this next patch.
> 
>> +			compatible = "qcom,sc7280-inline-crypto-engine",
>> +				     "qcom,inline-crypto-engine";
>> +			reg = <0x0 0x007C8000 0x0 0x18000>;
> 
> And this? there is no uppercase at all, so maybye you copied it from
> downstream, but that's not right approach - do not use downstream code.
> 
Yes it was copied but i missed to align with upstream. Thanks for pointing out. This will be fixed in next patch.
> Best regards,
> Krzysztof
> 
Regards
Neeraj
