Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DDD25F7BC
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852615; cv=none; b=mhENu6IC41UwVoMWN+bKvOZ6OdknX3xXHCU/KnkHjeYe7Ufb9iIVMlhv4VOdH6wwystUTWHCRKUamlB2TgM45aJSnvrozp/7XU/51q3NSLQRdIh7Dzq6JQFuYfwmuPLQuuCRZXLPEXZUpat+Oq0tMr22uGzrR/igV2aZ0QMGV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852615; c=relaxed/simple;
	bh=BVCdK3npxOuJY1EA2b0sv4BUq030Q9+u3iWzgAMxjkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KByIUHegNK9/o03PtJFk2w1XDSSvQ0pDRd13mHLnzmosmdve6EaI4keqNXsUdaBFHopu3pfq3BUmsteA0lFqLbYG0dDWpwWAIeWfkH5+Uyd11Cz8nabv6LxivbIgWHGTdIhUd6mHLdmrY7FjcFsIhizIVKawji+x+Dq/H0BmiMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gcAy36CW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gcAy36CW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P5ck3I014586
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 11:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qtf2LIek4hpLZ54vWooJjQr0lr5Bw40aXqP1yVThXvQ=; b=gcAy36CWTbjZXPo4
	LTSwKhbDedrFZlz2r+vLYTqGQbV/ntVaxiyCSbTWhGgbB4wiL4cFf4RcpxTeukyW
	Z0lUSg7KCMvc5YZyB20FRHLHELnUuDX76MW+Ff5cAnAtskiBNIMufa1fhKxduvjW
	gHpIWW9JY4YOBptfCCSpG9K90osox1ZM/Rb66n+jwJ+O8q2kAZwvwE0hdKiM8oL/
	VGI6Ao8ka2NnGxon+VNonHGnDYpVqFSwKr68tZ6/5EK1kwAgXj8RxJdBKOJdo+gt
	OfsE4gxhBaJrm38QaywRixi3s9AUIk36u4Y/mgV3Q8tLahgjHdQcgtNZuTHthVAz
	pnNLrQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rpyyqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 11:56:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d09a3b806aso149390485a.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 04:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750852611; x=1751457411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtf2LIek4hpLZ54vWooJjQr0lr5Bw40aXqP1yVThXvQ=;
        b=Rz1sal/WDqPGkdeFMFvmuSYF16tHcyAjUUW9+LEG0cZ6C2FMJ3IE+LxTuhBOlRc3La
         40i6RHHNJKIyr5pGexakxNhojC+vkUy+XBTWCne6xIGi5CTWM8LimLj3HnEOG0Xgp+/0
         bpFzfq1x20uPiu82yFShX1Bp2U+hu0gUfjpZAoPs9DxZI1u1lz20EOOUupHpsKijutMO
         qcNZurA4JUdtmK5wNAUOXFS4vWuq+pdhLOpD1h4bymG9OlfTYLL/oxxYZq9sR6/Q6/T4
         12mtu7FaYSB94ivcNBKSnFr/0rmfFOKa6Hu6VMXPc2AHPD5WlFzIdFn8jps7j8tZZo6R
         wpMA==
X-Forwarded-Encrypted: i=1; AJvYcCUu0f0Mo5O7WujuUm7PORJfGuZrBnQeEw2Kw6KYmpyf18PybdWMJJ44GFdmIEmr0t9HFe9ASYgVNQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxplHWuRTOcjRleS1PnFpt74yVuivFPAqpl7l2ohMjfPiQRZyNH
	bcXeUqaYsH58LW72xF2gRXNWhMZ9W/d1tgpEUdHYAh09akKoOxII+AYru8S8+b5H4rI7WmWomnK
	rQFL/o8BG0+t8r1zWDznZ9uUCWm9iKKnKCV07yjI8OVMHijigpptJtFQTl1AKrHU=
X-Gm-Gg: ASbGncshHLXGpsyjDvmezSbvP8BdoVibJFXpQkNIN61NGGRUd8cRg/Y6LgPWhJfFmus
	fDjsITYjg9qatIWxOd0sgd0AC4xMGooP0hQo/l0fxc4WAmfC4Shw/MSsMMAEoSb9Qbw7gRNkC3U
	xmfb2ebsM76PkMsr+dH93mJPSZ5WCCiDkoATySiPWSYsnPwDtXrF40OqwukNPi6PbcBoESaCoby
	HMGU5ZLFrOvwDqaWg9t0IYNQM9Bs+ord3ebNJgv/ji1j4FPOEqaO10QOLKUAIk0u76rQZtMoI4w
	hKS5BcMlcOTvzeD/ceO/G8oyMU8XZZBfzzRBedr2wgO7pa+P4X7l+3EdEDwvUi2DP9wFCEaQdGm
	WxAk=
X-Received: by 2002:a05:620a:2949:b0:7cd:4bd2:6d5a with SMTP id af79cd13be357-7d4296db1e0mr156158685a.5.1750852611673;
        Wed, 25 Jun 2025 04:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbNAdmHcL/ohxdpxrFhw+P+cQf12Kd+1+opwn8szOOQKrMRERAl3ZBXjt2J5pp3lvClg9lMA==
X-Received: by 2002:a05:620a:2949:b0:7cd:4bd2:6d5a with SMTP id af79cd13be357-7d4296db1e0mr156154785a.5.1750852611039;
        Wed, 25 Jun 2025 04:56:51 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f4842e9sm2431839a12.61.2025.06.25.04.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 04:56:50 -0700 (PDT)
Message-ID: <b98d305b-247f-415b-8675-50d073452feb@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 13:56:46 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Various dt-bindings for SM7635 and The Fairphone
 (Gen. 6) addition
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685be404 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=6H0WHjuAAAAA:8 a=PtzdWR5wS_Xl21Jse7IA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4OCBTYWx0ZWRfXwCTOGoFUaeg5
 vKmz4yhr6yOO8MOVKuAcXMGa9/zckqtt+hP/I+wJc0IyehRH1ajHkELpzXMQsf30CCf1hzqhXi2
 u22ChtebYac1g+jGDovvYKnvwmYoEeaI6KvkkvHjMAgM8jGIipXTkvhhjUKa4+UIQPoStp/P9v1
 GdOaHoeJ097X+7grGh8cxTnvlVswvJg2Vkn4zktak2EYKQE9YaqOaVFwHcZyc8zKp832BxXpj/v
 R3PCGyYBy5XwoA+kysAj9DKhL4B4opoYkzSoorRVlTw1L2A6dH9w5y1JoU/KHINFS7hvkY5q/f/
 eAYHT7RTw87FNuy2u0NiVQc034TkjJ163lplfCWWua7ilVa4+07BYS6xZ4CdF8wc+6NoZJ06bC2
 0oo7d2wTLLcv00HFebx1NnZesb9beazfH2mWgyCozqpqkOggdajCStzeIQkYrW9hJBSTy7cu
X-Proofpoint-ORIG-GUID: 1okGejALvVASmh65N3deUA3lOARn89qB
X-Proofpoint-GUID: 1okGejALvVASmh65N3deUA3lOARn89qB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250088

On 6/25/25 11:22 AM, Luca Weiss wrote:
> Document various bits of the SM7635 SoC in the dt-bindings, which don't
> really need any other changes.
> 
> Then we can add the dtsi for the SM7635 SoC and finally add a dts for
> the newly announced The Fairphone (Gen. 6) smartphone.
> 
> Dependencies:
> * The dt-bindings should not have any dependencies on any other patches.
> * The qcom dts bits depend on most other SM7635 patchsets I have sent in
>   conjuction with this one. The exact ones are specified in the b4 deps.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

DT/subsystem maintainers, please hold off a day or two with picking up
these dt-bindings oneliners, we're having some internal naming discussions
and want to avoid potential big revert-redo patch sprees, I'll try to
post a decision whether we're good to go with these ASAP

Konrad
