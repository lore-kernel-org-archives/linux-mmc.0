Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29211390982
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654416; cv=none; b=CTpyHekwomcgOf8ZMZhzghyIzDBSrL+jkq5N8vGj86JdiDbACz70FADKO2Ksk5iXx0Rykt4YH6wNI4l4Y71PEiFsqnUNhJ5p7chTMeaFocrnkYQzLoXPX7jukaX3qYIDTrKQZwofpbNN1IzjEdGhsw4SMUTngBH+yLeUUqhuDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654416; c=relaxed/simple;
	bh=5GAIeFCS0uUPv2PKBNS/6Rzen3mfcjnDIRp5SqOEd4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksI4Ga+GC53yy8vpoWg3hFl9XmQEnDOFAHxqxDCkbSrgQ56SmpfGDDML6Jg0msVVlEe64SD2IXotqPcXwNTAY9aUkzNed+Fb4lPF9Xnv0vZ1zOCMFwv4lZugQuckmnf7SkQFyrfkzYAtQWkqSKVTD+jX07iaep7Dd2HiwUwhUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AMNRTUwm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VlL2B0Ol; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AMNRTUwm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VlL2B0Ol"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64xfs1725178
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 09:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xGZEmgt8LPoPXTKdramnEFd7yZk6ZE7MCzHzNUdrRCE=; b=AMNRTUwma2/9IaeH
	bhQbeiAOg6wVPg+ZoBY3OsJG18ZcZBfk7PTWVMNihK04XX8qfQ9e/1UGleaTNLVu
	PFVSxBTBwPXD1vu8TzOSue0qk3xB/egG3rvTqE6C9+0sTixg6dgloz9+aU5fga7r
	zIO2TCs7GJohbO/gFOWsiges1KCkuVy7etOnDAPMcrulHg63jpSl8Bs+SaSA9eCQ
	ZK0O63a9WuSEhBBSEMR3Oz2hl7g/kT0epWeU50EPS59X5uO7/vcmR0zmOX75NWEc
	cP7V3bc8DcQcEKLkA2g3A5RoET2BmGQC0MrvHu40CwekY2tR4pd7br6chi9O3xUB
	TZxJVQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0udn088-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 09:46:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89a01982dc5so42379696d6.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773654413; x=1774259213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGZEmgt8LPoPXTKdramnEFd7yZk6ZE7MCzHzNUdrRCE=;
        b=VlL2B0Ol3dngjeW5xO3YCotO9cWt3Z7eVQ1jFabFA9ihS+ihCcS+lwrYJO7dzKtt5w
         b3qaqVf6X/v13B7M8y8/zpyC0PJQ2mW/MtuHjYOA8cS3Lt0VzT7eXMtTB7V0TZvFJDoD
         qg0ajbAGype4P5LJY7pASOvE8n6ll0YS7u8tG6MzS2o4dhWaPGznAVSctTTNpfuW9bwv
         DGV/pmkdwPhOCgCiqt6p/abEtI9RElMgnyewRjifJoMjuPABtbRl4RtLp+8d9Jby3Sfq
         NrBP0Nbcw0Ovt2UwVnGMmpI7jLHBi/MIJwOuyUizd0D2ihZRMwjKddCcdS8N4YqtQ1we
         MlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654413; x=1774259213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGZEmgt8LPoPXTKdramnEFd7yZk6ZE7MCzHzNUdrRCE=;
        b=gmGYbhBtJ+MccCJopBo/RbUQTrk1/8eBRqb+M3TCnr4Ajn85IeJHK/1o/8HWLfC/GW
         luK7U0NaX6HmJEVztge5HymjXYI2nJmaVLmDkuZyhpvskxUcxexbyLvpR4LbiZvSzJ8V
         uhlMH7Z4cTps91bGlM9cTE8eTDyFPVh1aeTwlXyHb1A5IMlfUHcmAr1+Ds3b8Vr66xc5
         Ziju4dIsVYiILOscsGwt7ef9xNU4q26ufvQZJVIBIiLEgUAEgl+hk1NHE8FlVxWGcNGz
         nW/sVHQW0Fle0u2bAqwl6lWY4stpuOc9D3ccwnrHTdwhBRxPlz/msj1SCiLKcHNma3Cb
         VNwA==
X-Forwarded-Encrypted: i=1; AJvYcCUpRH1FMn5yt5H8tHuNjSxx562PbhiHrs5IOOJUdNhRKk4IzHkkXM+hv5pNIi8O5MDkvxgRAxp6cug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUOSjhCz3929Vk5e6TBL2xqJlTnnSGN22eLufmUb+JNkLNKrV
	L/HjXeLWzkuW1ovcplfLAxy/NLDopKSmFEbCk+TM4gyvQDohV0QnMtyb4fYwL5jwzE2Xc1g0Deu
	p8YbTdmHiIL16+aS7jxP6DVYLW/KPjAor4Uzf7nvdpe1VTBYE0SSrryfJQO4rrWo=
X-Gm-Gg: ATEYQzxLrJ3tsDaEVmMjsYy0PMNk05srqNvWBmtHyRwT36jVL7Ml6JBvxgudCrr33Ot
	Wuyv3R3PeJBMwcPI0TGuyyKa5BHJ7JaaxmPOKb34scggaGT1QBLePISaz+9tEWtRtCTcUUxY/kt
	D1gG30Poh4TLYLi/Hbzvqc8+VcqfQpz8lAPNhW/xM6AD63Qr9AiroJc+FJyEDBX6pD7OkFDi6OJ
	kX6wL82qba97V6sbfiLLjya8wmwXgKvavgfz2+XiVUH4lSrt04iUOh3MmrFq28vhHYKE9c3tKxy
	wuDg7CvcnmME0q8loEendpePGKK2w0oUYy4f13ydNsJDWmH0W+cw8l/xy64ygIE2CsVbE1XbnEw
	ONXeaoP60TE0bdBaLLUVXhR1KoggXRO3DZAfTCCxjsBIXtMx8xKvRjgXW8TDoUoeb3y1JtO6eZ9
	0CR2s=
X-Received: by 2002:a05:6214:601c:b0:89a:6263:feae with SMTP id 6a1803df08f44-89a81cce148mr121904546d6.2.1773654413459;
        Mon, 16 Mar 2026 02:46:53 -0700 (PDT)
X-Received: by 2002:a05:6214:601c:b0:89a:6263:feae with SMTP id 6a1803df08f44-89a81cce148mr121904266d6.2.1773654413056;
        Mon, 16 Mar 2026 02:46:53 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97ae89ebc4sm237981866b.34.2026.03.16.02.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 02:46:52 -0700 (PDT)
Message-ID: <c89449b8-f28c-4364-a1be-5267f0d99c01@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:46:48 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] pinctrl: qcom: Introduce IPQ5210 TLMM driver
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-4-fe857d68d698@oss.qualcomm.com>
 <05a1dcfc-7df1-4b20-a504-468814a87b3d@oss.qualcomm.com>
 <1eef0fc0-d33a-452a-9da5-3d0903b1712f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1eef0fc0-d33a-452a-9da5-3d0903b1712f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BJ2+bVQG c=1 sm=1 tr=0 ts=69b7d18e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=-I31x9S0JgnQQLvGL8gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: M6GTysDNmHdFbnBuGLEYZfuqLvdWD6gI
X-Proofpoint-ORIG-GUID: M6GTysDNmHdFbnBuGLEYZfuqLvdWD6gI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NSBTYWx0ZWRfX4jo93msFrgAY
 lV0nq/it4UQpHf+rVp2vBWaWJmAp9MdM91IpXft/dQuRMjzvqB+54vzITbLzKY+C5mKytIMcdsQ
 0QuWF+yO/k9UI1FmlvnuJvAAnG0Y2GdiQy/sG7TguKV3pLbOVTMdADO9hq5hR5ec5Fa9Va4d9Aj
 ij+8/d41ilPtN1JrcyUloj1PQYe/c1C9X9glxnFrUogAtgshtLHttrzYKOntJf1r5moG2MkPeO6
 2LkHcZ3ONrK1Ab+R3YwG7TUatgRrgLcG/pvkyUvyFJVXQWRtQG8bRqzKsjvSh7Lm2PrtKfORrCs
 zT4rFIKqB+JGbZDTvOvpbgI9o+82qHfMlYZaz8b+sRc1d4cUL71GilL9RoBbG6ld7kKlzbP6KqF
 0PIRlCLcZLlTYo4aZCAUq4bn9Wf8SiV6Qbi2JwU/NrPzXoqcLmB2DnmXW0mktRIeBuLTEwRavQp
 JYX7YpYVrSvUYQ/+icw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160075

On 3/16/26 9:58 AM, Kathiravan Thirumoorthy wrote:
> 
> On 3/13/2026 6:24 PM, Konrad Dybcio wrote:
>> On 3/11/26 10:45 AM, Kathiravan Thirumoorthy wrote:
>>> Qualcomm's IPQ5210 SoC comes with a TLMM block, like all other platforms,
>>> so add a driver for it.
>>>
>>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>> ---
>> [...]
>>
>>> +static const char *const Led00_groups[] = {
>> odd uppercase
> 
> 
> Yeah,  in HW document also only this name has the uppercase. So I just left it to align with the HW document. Do you prefer to change it to lower case to maintain consistency?

Yes, please - I would assume the original author had made a typo and
didn't really intend to have a single random occurrence of an uppercase
letter

> 
> 
>>
>>> +    "gpio23",
>>> +};
>>> +
>>> +static const char *const led01_groups[] = {
>>> +    "gpio39",
>>> +};
>>> +
>>> +static const char *const led02_groups[] = {
>>> +    "gpio6",
>>> +};
>> What do these 'ledN[012]' functions represent? Are they muxes for
>> getting activity/status signals for eth/wlan ports?
> 
> 
> Yes, that's right. These LED functions used for the eth/wlan status.

Can we better group them, e.g. into threes in 'led[012]' functions?
(or whichever way they're coupled?)

Konrad
