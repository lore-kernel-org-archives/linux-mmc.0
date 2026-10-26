Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027519;
	b=Apz/yJHkJA+Iql4mPwgibwx0WMWdzxY9It7uCd7uqaijNBxuL+ryBsg7i4IftUelvE3n
	 pifO2zBIktZHWwffgqs4RG9f7EnshsX6PYVRoKGhx3w9NWKolNgWtOyBAPsboP08pzMO3
	 z/pgnTrXlpT2lBCaziOYjHNsR3BKbcqL4wXRW6/A0AoZ76gSMHVjziCZruB4S0sx/w9mo
	 jKrQD0XmsYfaq4ya4Hzxuv27hSkfeTcH/d/A1x8H7yvVqIBnpghTABLOsnnVniK4absbN
	 rLvBBzLZr7cTmzezGl3B8ZnUAkO8Qv1/+zJ75G+TyB/7jyVPRrEOZ8VREaLvDGmLLmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027519;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zI748uxWKPPDTZ/WsRErMlRZ+qLc7z2c01W+e2hpsZg=;
	b=csMdZSFYtWInozSa6O9jFLdqbX3dbVLpRLmjXaPG4t9au4xVlMyL0TkFL1NLqDg2OsXY
	 SDKTEOkFDXi0SX4gazXnDkHOYO1BvYsRmMWOCo3TENxYLhQAXGYLjRgH9xWgXB3auS2Zh
	 lhjgcHE9brTphvfCVopjKXbf9TbCRlV7HHyBzxY4BT19vpfDHWAW2XhCd/rLMJPcVHN0w
	 JszZLpLPC7XTUCxbp7RNRWQkOzGIKZiZUBNjkgP+VQ3kPhQ2f4eNoX2Idany5TKH8eHZl
	 U24BanYGAJMEyLR1IY1IwsWN2QPHQvCdLFLg2ocy7h7a+QsB4PeAypFpt0lqhRwriHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DyWaPPud;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SadAXZ5S;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31E606A31D
	for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 15:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C31E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DyWaPPud;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SadAXZ5S
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEwTs22082585
	for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 15:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zI748uxWKPPDTZ/WsRErMlRZ+qLc7z2c01W+e2hpsZg=; b=DyWaPPudMv5hXrWD
	yfOs0uowTvmp5SjVQGyCK1Xy7Cg0TbbU/L2fUVWIk6+PCjGCaCcbukFB8GkQONVJ
	Qa7Kqxbl0scWGiN5FKPbYLFr7HmQIMQxOIX4Xmd03gnCDF3YgVBJcRTX6kerdp6C
	kpMXU6j+wuXBIbiDOrB93tJqnj6ImBFNeLKRlRLq6wEJRIcANruTZRpySHyVkncA
	RNqmHEIm+6LPBQZPk7FBUSAD/H/qn6aDghRUg7D6/UG88DOoFycLG7WRaTfAPaE5
	aoWw8TlTd9PJWBSKvCaVRmN8GSQt4KHLePGSkJtQGtq9InN5mDwDpuQYCiKge8cX
	3oyqUg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgsu2cf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 15:11:57 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5eacd73e83bso165633e0c.3
        for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793027516; x=1793632316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zI748uxWKPPDTZ/WsRErMlRZ+qLc7z2c01W+e2hpsZg=;
        b=SadAXZ5SgIr5jwuMkiOeSkSHJmcb0rDb1bc+ovNCeIuziVQfQLPTM23kbDBHOSytXQ
         dWjFrDVr4rl2EPKtR5zV7QMOLW8e5+Og31YChxP2ODF9hX3oQ5up5/S90F7FsPSdTdFt
         /EssU+6lM4c+Ivg20C/AKBpl72z2E482kbEjzFFfPKgXDXIiaVCf40oiPx5TVfafTvIv
         rJojLq+98ksuEWMwCsBYG81SZ4hvQ37TBcSj763DjnKm+bAhbso4wj6i5db9G7AVjOQL
         esSKRwRNTjmAN4oaZL+umcIsLW1JpylvY2noSnIpF4u3OSTLk8EfszGd2axS96x3zOGg
         TqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027516; x=1793632316;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zI748uxWKPPDTZ/WsRErMlRZ+qLc7z2c01W+e2hpsZg=;
        b=b5+B934bZ49iPBM2vLYr6gkDDUNJ5l0//Lqv2X+sEUgyzWkVgM2qESbDfYkuJG5Aty
         eX1ZlIFHVaga0tL4FI12GhS770hAROrnM8Y0ooGc9JVFzOQ02UgK/hkzZ+90wA2n6u0h
         fUIeG5vlnm2w1nydBJgUZjAjHPjEuUV1WdJZSssGQLPNCLPVfx6ZiFtXeda3pJDYG69b
         QZff5lk8rdKq8iiPz9jKcwfGdDpwZ73WSf/bjQvcTZmX4jtKcEECNei7SbdmpROKqLgk
         0HTvofYxtmgvXX9kQndSZdjLfUY7PLU7ITq1anxHKbb1QvxTyEnyqMtJ2aX4Er+7wQmH
         HH6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwcd7hUYfTnVWJ/cnBVscxGEaSocao6uHmA04XpbHo3DnNIfopuT9AEzjcTWJxeVwXxcAUcO+dK0nA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIimF0tsttzNaxzzakqO94+p5Gm3n78Xs0yJSoPZpC5xOp0GWGe
	BzlNnVYVLczcxr+CzCd5iQ9EpNwBVGxPq89VCGvc2t5BWakExdupUIXsCW1TBSrc17BeZDUGrUr
	wqvEKvffra/qYubQMMbmm6LwDbLhaHCCfwBRwx13JABE1uzzdMl52kpLkzN+GqF0=
X-Gm-Gg: AYBFou01SDgyXeFWKP6Cel5VlIaKijXuegY5xVbS5TSSDCpA1B2hBzkPGkm5MeO5vJx
	UHBaDT7ladaelWFaGGnTcug5WdvVPRK6ORhOSSwMlnSR/TOEtrK2qJ9a8j9pzJo19PnYumBqf2l
	2RzQerhi0/RqBb4GOyuN8BNnJc66Bog77/Dq5LA2n2uhjgEbQL380Wd67o6tlkgYFxdv//523yA
	Ze1gqHUkheVNVPO9d9NEBQKFhDKrwztGVeQCO9cNuLLGdI38jQPkVBm7iAUIafjULb9Gw0lFjll
	ABN5seQeXOTI4p2LRc1RHHlJQC2/mRev9RGepw0g4fiosmnWkPg/mphU9Sc04up7phHSRg1dMTV
	Xt2untDkYa6HTuM6YrL0KrA==
X-Received: by 2002:a05:6122:8617:b0:5ea:af6f:16e7 with SMTP id 71dfb90a1353d-5ec2506ae8dmr2821905e0c.4.1793027516434;
        Mon, 26 Oct 2026 08:11:56 -0700 (PDT)
X-Received: by 2002:a05:6122:8617:b0:5ea:af6f:16e7 with SMTP id 71dfb90a1353d-5ec2506ae8dmr2821858e0c.4.1793027515922;
        Mon, 26 Oct 2026 08:11:55 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66c6dbsm327506866b.59.2026.10.26.08.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 08:11:54 -0700 (PDT)
Message-ID: <3650f273-d361-497b-8db8-7d5ca96283aa@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:11:51 +0100
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
Subject: Re: [PATCH v12 5/6] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE SDHC nodes
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
 <20260824-enable-ice-clock-scaling-v12-5-09271f583dc6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-5-09271f583dc6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2MCBTYWx0ZWRfX5vQHTQDDZA8J
 8YBswVGWSOdGMYHSBwYkRR2zX7NEpWRODNaLJVHGxPXcYUrMMnXKbicB/jrIEyzsGKa8gZb4UIy
 hx/sUwYvYfEW1uY5ToY2Deaok4lUxQ8=
X-Proofpoint-GUID: dGKsy8xi5tlUPuaJwAsbH8k6OaxEhB-T
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adf6dbd cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=-W0wxAWcNmATYll7EfoA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: dGKsy8xi5tlUPuaJwAsbH8k6OaxEhB-T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2MCBTYWx0ZWRfX6vtGaq9TjaiU
 NSvjLpMAcKiJxmCRRQljRMPThWP25Mtq9IK5MFCmc90bv2HCHG4aQ3vigjrB6U4RM+zYKe2Hczm
 mH+MLqf1zLJ1n087kNnUj5d0n5JcDjjTa6QZXDKEeUjqz08ceY2/UX4cCzQGqKmBgMHNE3Xi8/g
 sNEUN1s6ggI3qH2yOIm2qsjyBQ/bgIIvzAVpyDmtHG3Y7Jm/+rujIdHn0gZ9g8k9qTQMung0T1J
 yJGeEBObdiSuGFa4nhnt6GVJ/RsD5ivnNC+M9ppH3KWZGE0PNjemWZa8W1rH3oxw44fCJ+2Qx9s
 AMTmMjwLR4nGRP94BDqwb5wSQdukLt0J2m9CCTtghPiVF+DEkrHlMZZscMuvlwyy6mEjH9jlybm
 LwPS07zp82ct2IZx+ZaJNnLTveAu/gN170gEuzADls+icEB4/NQ6O2JQML82tzRv8X5/jd70H/F
 NmFiNJY79a+ACcADakg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260060

On 8/23/26 9:47 PM, Abhinaba Rakshit wrote:
> Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
> an optional OPP-table.
> 
> Add OPP-table for ICE UFS and ICE SDHC device nodes for Monaco
> platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
