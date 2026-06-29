Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ECC3E1206
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728695; cv=none; b=ojiXbsclV9TbSXKaCZZwmRsmfg4cXRv0xhFdt2LCKmBoQUgUtiFYBnzF50fx8vbp8oZfZeAYPPTT5givdFw6lQ02xGuZYSUL9baBQq8FdhpB92dC4HTlvaMzOt8xGX4EaATc5GW4+aC/4auGz6AXZPeP7rYfde1NsT4xu45vPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728695; c=relaxed/simple;
	bh=gx6Hc+xwDO6+Tr9b3IiC7MpXO14GpZ80jXnsZw3dv9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mP+4RVEyGnD5UGOrTUS7uAujTcjJPjUvYKybK7biWZEFijpsAHkK3u3lHKM7TcF3j17VIVT27TjeyI7gdJHtJpTab1FNf2A7w7+ljcJEvkm+2bArwMRZzF4SJuBR5CAhWP5cvKbAa2YJH5Lx1Yr1X5V1ShREGqqenP8zAr+qzvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mpZs+7PK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kW2GzBCR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mpZs+7PK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kW2GzBCR"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8xFxm2447442
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 10:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l1Fbhotj1M3nPhbbjSPmKC0CX6nRcaFEC/MDtEsul2o=; b=mpZs+7PKc3Ubkqzc
	7uY8WYPtje7SgmtgutoA1jnVTJvqqiEy2UG8IgA+JsjQbA1QFHoxpk4FNWtEfcR1
	jDF+u4lU6t2FhqvT9sKEi1ZxEpWIyRaGV334w1C8AXzL8rC4wDS6ngj/sNuyxEME
	X6huopiWCmvHhw9LVWeE/vttniqQ4szGKWFBm9FPQVNqEM6cl9bB/UNCIFQo0AOJ
	GUWJVaRo/AlJFvK/qu8/uFk6lFypZvcvgsaphu2jD8B8I0IGN58VWN6rSoKwbzlR
	OMJx/HhucffyV2ebF2txoJnh+nVftvc/klPtwVSkcGPrewXFuOmBoUFDDhuC159A
	Xgx75A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7gbb6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 10:24:53 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-845a29d8c1eso2301823b3a.2
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782728692; x=1783333492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1Fbhotj1M3nPhbbjSPmKC0CX6nRcaFEC/MDtEsul2o=;
        b=kW2GzBCRpy/7ACSQjmSIpoEITbuqhK+uKidzxGkwHshyCe2WjuCO1uGPMYWzXHXNGX
         kwH7uYiLe5lJKU1DEIlUHjTci/ph4jO/RvlE5NJ6iLj8nxeJx1OXE16KvjTPEqxXhAax
         /u5mJwgyoTJAR0CrD7L2gnEqY19Dd5waaqGuK7b9BgNw8fYkcw2AIGf52jj0szRv7Ofl
         Q1gvbQS1coKAC2UjoI4d8wx/d6T9bz+X7n5pguXyQkejDWb7RTQLoH+Wf4CD7pQXjnZq
         gqXF+3BNiRsOvtfGBLLkFoYUFGbVV0epPAVcXARkbVkvrXUEc0HKs9QcXnEQmI2mkwsl
         fgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728692; x=1783333492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1Fbhotj1M3nPhbbjSPmKC0CX6nRcaFEC/MDtEsul2o=;
        b=C6ha1figkMpVzjF3qgRpHLmInX4XQW3/lTCa76ssBO4dODQ20+J5BCNIjuukEU7cIM
         77jS/59PPcLOt4QhG7c97OS/3Sqdek6gRaH1MtQJ23OJ9wChY/YQ52SNLRLYE/E+KtN+
         Kw71dxsuN0i1B56w2uSHpCDTzW5VeoNsx0IP1yJZvpFph6jbGPRhj9a6EskZIYxS/Y9B
         k9/9iBVIBMmrlH/kfwFJ6OTlHrmizWB94VYg5+mEuFDrvr3yOehc+5ddv4z73VAUtbuF
         /v/6hINjf4Y6vGMshi937bu3faOtg2fkhSU+sctzCqrfCeaF4K+yoVkGROJOHqAbvRh6
         QurQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrn+2dyPsoYDvhrt4cpZTRIpxjv4+rfenUxwr8KDsAhb5eQ5POIkWU/9eBuGenYuE084Pr330Ux5II=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2Bapg8Jyw4sovhE9d6ztlEEyHMGAjf/WxAhIK8NEliu49zB5
	BsBzxEG/qan4rjZtj6sxUvZWF930ILSFSVlID7vbr3v6L2AV2hxHFnG8TnpwNucCIopka1BWVGQ
	9JLqIQo3QWr29BY0RIn6bT9m+XGrVm1i3FRowxbMf8bHKVGSsmUMttHR2S7nXAaE=
X-Gm-Gg: AfdE7clQASy4dRJLR++oQFBHEwrEaZ+WaSMkKlHlIG7KgdT2QQD88XOUbj3iSYWXUgV
	aHVIwj01d3tnNbTnNoaLDt98mLuHVcY52ROatin2V4V5iTap8UjYvpXDufiBryL6jbfh4rU4G7W
	UVs//gjhpiLaL8atZzWfVgWqhxX2flBD8PUAJSGX9KGMMfEKxpYR/Z4EskGC+/Qpk6RAj6t4Zik
	n5BKBC850eszrBp/a/Y0WXqHyXsQYE5kLifr7lBr/bIr1erdmmc8noNQob3a7bIkg++/o/m2p5V
	RTubSdVsNUIZXpiZ7kM6DVmCwWRVsRR7n8k0T+gyTjdk2qPUwex+YRgdhWvUGDEg0CgLtt4XnHy
	qV+dkXe8WlQntJepQGinTWf9bbS5q1Ir2iBvQeaOKAwc=
X-Received: by 2002:a05:6a00:8c11:b0:842:672e:7b5d with SMTP id d2e1a72fcca58-845b39f9acdmr15279478b3a.17.1782728692435;
        Mon, 29 Jun 2026 03:24:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:8c11:b0:842:672e:7b5d with SMTP id d2e1a72fcca58-845b39f9acdmr15279454b3a.17.1782728691963;
        Mon, 29 Jun 2026 03:24:51 -0700 (PDT)
Received: from [10.217.222.146] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8477594750esm2435981b3a.21.2026.06.29.03.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 03:24:51 -0700 (PDT)
Message-ID: <86321e30-2bee-41bb-9d63-d0e6ab4154db@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 15:54:44 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/6] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE eMMC nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-5-1cebc8b3275b@oss.qualcomm.com>
 <d8fd7888-cf7d-47e2-8e77-3ba705c88502@oss.qualcomm.com>
 <ajjmXMKdWzae5qqk@hu-arakshit-hyd.qualcomm.com>
 <dcd6f0e3-46a6-4f57-b4a6-0b9362b1a8c4@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <dcd6f0e3-46a6-4f57-b4a6-0b9362b1a8c4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4NCBTYWx0ZWRfX8oWVAg8wvsvS
 JcDcja2zqmM4cTR/ezvNOqgtD6SiQ7ZPViIWkvyv1WdLcKjJ3iPcRTeMrCwFgf9thT1ZctKWTyz
 XzzhMVscVsIpUZ+QvGTM6GU+PCQQP25LgrhCNQ7gb0BPXBYwUvaMs+IjQOmtxvv+XvyoVC/Kyyk
 hgkCjgfCZVmTMHRRZLwOZNxIjdc5pfJRf+mrTmu7ecxMOpuEujrq2M6zef21QPFl3XKvuL+bJrQ
 MP2nfeCGmgM31iNm/gc+0GUaRCJbCxP2ddCX9LDdZPl7WXjIt7dt1RAaUElNfDwmSoLkzTnLgJs
 19k0iB9xdaD31KQBUioKurHHG+nB9eoYYukC23bzWDVpB7oV2K/vxg/r9001pRDkWSp+Qp0Jfjn
 dszaGrdpLll4hEcljqEXmwkZWQxQjvMY2Zz7NfUSGOtH2pTQ4EUZSXbpUph56BQ5EjCxLjFMb9R
 MXgmw2r0s6a+cGF3QQA==
X-Proofpoint-GUID: CGzXdIWrK6xXFyTrZcd9BhG4Xwg-X8i1
X-Proofpoint-ORIG-GUID: CGzXdIWrK6xXFyTrZcd9BhG4Xwg-X8i1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4NCBTYWx0ZWRfX/YYyUYB7iWWo
 q30f5TieJTfz+W27O7PW++YjaOP27TSna7vkjTrn+IKzi5Uzfzx2lxOR3LDzd9hND2nF095xUr4
 6Caaz4U5vjKv837jMvc0d2A0j0djACI=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a4247f5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=nI5agbhGWDarof4E6psA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1011 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290084

>>> Since 75 MHz and 201.6 Mhz require the same power level, is the former
>>> OPP any useful?
>>
>> Yes, both use the same power requirements. However recommended by the ICE team,
>> the DT should include all opp/freq supported by the hardware.
> 
> Is there any reason at all where the OS would prefer the lower OPP?
> 
> I think you at one point mentioned some dependency vs the storage
> controller's clock frequency

I think Abhinaba captured all possible frequencies(even lowest ones) as
what the hardware currently describes. It's upto storage controller
running frequency and let it scale ice clocks to higher/lower to it's
max capabilities.

Describing hardware based information also avoid revisiting DTs at later
moment.

-- 
Regards
Kuldeep

