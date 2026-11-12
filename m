Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483066;
	b=vG7KEisZ31WFN9biDbdy5EIk9aM8y+22T63jkLMPH9oEVCCAlRFHoYNuGM3fec+m4njr
	 NpUTFkYYISbg/SLV9naHGl+BDbARYrgztiANRVUT5kqY15V6NOPK5PmbtJq6PCHP4a1S2
	 BGxod41Q52ApCio5cInHmSCc4RNmv2hA9cRSFzGPmcLciICt0JB30i9GLaJUfH3azOVDb
	 CtthpRGRQj50UEevKlQHKdQAWxKzzmfNZG/gu1WFe74kbnBOdo938J9iB3KqN1QmpTAyl
	 x2GZ8knXogXh1ZpyN/d7T9D7RiLcP/BXQxIWKf51chsGdr5pGjRifILaH2EsMWzMYIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483066;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QtaI6ngPGNeT1DD/YyV2Ag57CpUXifqmSKUI2JI3pK4=;
	b=hs8L0bc2Z9WNp/c+PwwBtcxnq+ymBLeaQBF0Mw5PEMn3pE9xZt50sq+uZSGRA/84UWAI
	 WAt8ziVZIXJtb8bD30GfeuCoCgNWh8L0Vygz9WCrJRjwcvlth3+bHQTSsyx/1zoE0e9bm
	 IpOSTbzexL6dHJDWK5mgcSV7g4M+3U7pxB5WgSh51hYppeSxk33QOS146tKatL9rQ93Aa
	 94pxCJJ6kajpFXN5Q6Zvhuh37AByPQOgE2RT70Wvc2jlGfplzvLFJjZ+XnWwVyxoZOTs/
	 CVQYE1H/eL6U5YnbjzxtgqZQo9vNr4LEy2Yvy2Z8gki3o/rWlVP85thzd0WIN8Dtbeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=noy8g8YV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IHaDqmdR;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4E606A8A2
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 11:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC4E606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=noy8g8YV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IHaDqmdR
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9E29Y480282
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 11:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QtaI6ngPGNeT1DD/YyV2Ag57CpUXifqmSKUI2JI3pK4=; b=noy8g8YVf9J5rPmJ
	UwPBDCfjMPKR0RmF3O1R4xqqK4215RtxouUI53FnNoC9ggbOyZ5yfKNhSw5DT2vj
	pJ93GKcm5Y9lx/YDIYENjiInMGcgL3vT42v2b06iyMnGxn7bJMzvHKpfRCXCmAZG
	vCvwppkw666OrlXoRusHBZhvx5z6UP9TxyMed4h1lO5cPZWrwWQ4D0iJfhYo9d1x
	Mr9Apx1eNK2WCkcr0PwgIcd9V2J57kweSJIiPXIyezzIyYW6tnFvB0rSgp1PBssm
	xD2VZGHTH/CIpA2JeqyCllSSay5jVvY8YyxeUoEpX5C2CgGb74roTmgdwvZJ8CtA
	+nBKxA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4revj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 11:31:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a079256596so3289615b3a.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 03:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794483064; x=1795087864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtaI6ngPGNeT1DD/YyV2Ag57CpUXifqmSKUI2JI3pK4=;
        b=IHaDqmdRB6t49l+r1ABPC0H/gRzWI0foqbJXdf3Oi3OOXaWCt2T/zlXktJC4NgHzpB
         WZH9o36gAAP67sG4sjCZKN5Iw9eaEgNuFocH6wKP0uEM3RCyM8W6j4bOhCjIu5kqQla8
         aPMMBnsP1KanCG2p8st8tYxnynQWmMu5vrUTmXf1rUBcHUqQk/dv1jLUB0WyC5Vu0cxq
         +6AycmpDTvbctcQNlp8nc4uYKSzOQuSBtjyiSdEXkm+NF5SkOFwGWbOUtdaLj37Bm1sR
         owPaLn/N8ZTBBLgFJeLPXPd7rY7tDvv8EleuhMyI0l8wqkO9GMg879ope2z8Y3IBg8yE
         nxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794483064; x=1795087864;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QtaI6ngPGNeT1DD/YyV2Ag57CpUXifqmSKUI2JI3pK4=;
        b=HYe9a9662Hb0VzeXXDrplkms0agRNzuuGO77OTpfiN8doeqr6s/+Ujk0V7i4RD3uTe
         mKNJkgLKnk0hW+gRjKFSmaDY33jXp7nr4FULGl8nbJ21shkaOl/f8IY8N9HHIoQXIQIt
         lWukoJMFGqs7+vC/4MgBkWKqVT5zuPaogZcNONjagBbCiwRmFb372atgojrt5v1hpzXT
         cPc8s9m9CavjD7IgbIEvGt+ZBhHN+CMvbyTuUGMwlhZJuEYKfoi3gkVsBWb5cMeM1+Mz
         UsiJWiX+cu7MGdbt8LhIOwzHlTU/NMsAq1pvS7YKGXeOnyIX+CgLWBiKtAMf3Aydk03A
         p8vQ==
X-Forwarded-Encrypted: i=1; AL+hErHcpVqm4rEANMl9qrumD6I9MUbYaSvFRxQx2bY72bA+4m68R4ncT0S7jiA5gBle3pA46FjklATRiQc=@vger.kernel.org
X-Gm-Message-State: APuU4Z83+yklGq9pKhXCAq4cyu1w/RoTXCVTbtQw48KDse2IyE2F+UuX
	jkKFiruEaH4N4U70bmig4QmTYMjNr3lhxZHENjTv4u2B4mb2RX9L3aEPT2TINezL+LVstSUB2Bw
	LaqrXu44dQLfetQ00wPUChUNCM9niXppcHSwUMmw+B2vtD55pP3qTPacrwbEZJwo=
X-Gm-Gg: AYBFou2/bllS+uZj4imjb6+Fm1bYK23vr4dZdczgRH3hGYX9LjMe2eDVjEm2yZsZbiE
	Nf1l7cW4742JWq5OIBmLplFbcjQBHRBmDXDS3kCm7eJiHMZwUjarMVM6IcnKs9E2N2tW9cCMe8B
	2ZB4jXZPwoychak6FFNMiuG5bYor1ShAmZ89WUZK/H2tcygALv4klTsjVUgIXaz1uebLQbwawuv
	lxiL5g9s8U1eHmFELOphf3ikO6domf6Kyc79PWh7JXNYNvh8PxnvQrXEAnz8QvhK0Tmpeeo7LHr
	iJT5yxxdmyApdrweUkM9bVJgsGGYHZqQ51DkcJbOdohu1PWzzYBOkIEVL9xuSY0pcv+TCMcmWk5
	0Mvyofh0C7WE8CqTm8IsYonzRGiuDmQR7KNfhZpszs5EeQyyLVVuQDYS2W9lLH6+KeHEeytfSpZ
	PFTq8=
X-Received: by 2002:aa7:930c:0:b0:88d:4b30:1c11 with SMTP id d2e1a72fcca58-8bc19dcf4eamr4997930b3a.6.1794483063953;
        Thu, 12 Nov 2026 03:31:03 -0800 (PST)
X-Received: by 2002:aa7:930c:0:b0:88d:4b30:1c11 with SMTP id d2e1a72fcca58-8bc19dcf4eamr4997900b3a.6.1794483063458;
        Thu, 12 Nov 2026 03:31:03 -0800 (PST)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3e110sm3264720b3a.36.2026.11.12.03.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 03:31:02 -0800 (PST)
Message-ID: <172229a8-a4c5-4103-a38b-e4cce3f18718@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 17:00:56 +0530
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mmc: sdhci-msm: Enable ICE before enabling crypto
 support
To: Eric Biggers <ebiggers@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org
References: <20261022-qcom_ice_pm_enable-v1-0-f7a84086c651@oss.qualcomm.com>
 <20261022-qcom_ice_pm_enable-v1-1-f7a84086c651@oss.qualcomm.com>
 <20261024182904.GD2553@quark>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20261024182904.GD2553@quark>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XjC_PuStaKL4Dh7mlMrEuQ2kzEwP1o8H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NSBTYWx0ZWRfX1vYrS8JzpCif
 uFFWfdxcshidD0lZrod1gVjO1UHzCVqR7ZEKKdUEzS56xSujKD/+OyJ0nqpegIAejdnNIdhx6V3
 T2c9ZvA/4tGmguN5omFc3EltAv4PkB8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NSBTYWx0ZWRfX/IyHn8VNVY8b
 Kfqu1/xjHqJjYt5uaK5eHIQkSUpnYqCCQ+FjjOIPhF6/qPO69tRTrj2hEJhlgo2dd44KqC1gUAK
 7FuN2QJrsuxeVv0PvvZ325CF6ZfBIx+9zfSb2HewP9RznWvB1O/kV6o20kShqAz9/dznnvda/A3
 gwo7NA2DogSlSkln70U8eOlVBW8OCjpff6o6RTAG+zfHXK3i5YJubHahM87lJeftBYnR0JL9Ua6
 /r6Kl+M/2LoCpz3k/rZERi3FasAg+HKtOXlngRIZ+C3lvnuIrqS2eg3LgIib1Ko6h0VXJYRM1ux
 NnStpYmm7quCoGnuJ1C5yErFfpsfkGdbWovjGk9S7SqpFREI1xFHUd+yFe6Ej9fx2LloRHnQRaw
 9BJ6HrzHLjf4LDodZw6gI12G2P1ChqVpeNjUtai0HunMffAHxhGkROJKyvsIDflDu3OB5TxdKoz
 WXzRcWGjFb+9swH7giw==
X-Proofpoint-ORIG-GUID: XjC_PuStaKL4Dh7mlMrEuQ2kzEwP1o8H
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af5a378 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=fvpZdPw5ZEdYVRYleWAA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120045

On 24-10-2026 23:59, Eric Biggers wrote:
> On Thu, Oct 22, 2026 at 03:21:50PM +0530, Kuldeep Singh wrote:
>> Remove ICE enable call from CQE path, since ICE is now enabled
>> during SDHCI crypto initialization only.

Sorry for delayed response as I was away on vacation for more than
2weeks and hence couldn't catchup on the thread!!

> 
> This change makes the low-power and "optimization" settings in
> QCOM_ICE_REG_ADVANCED_CONTROL be set only once, during probe.  Is that
> correct?  Those settings never get lost at runtime?

Yes, the low-power and optimization settings are set once and are
retained over suspend/resume cycle.

-- 
Regards
Kuldeep

