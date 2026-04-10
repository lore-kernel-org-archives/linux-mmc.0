Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F65391E52
	for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818665; cv=none; b=sbhAnphgCzpJR9/RBq1md5BwgMI4NAx6SdK5qXhz+sRjnUIhUL/sr4cm4jMzso6kPYJRuFCpstL2zIAQzp3NjDImldx2w72fzR5pPOP48uBSlnue01dQw7SLVtvNoAtFd2LSP2AlrBBiFcrBhbb8skVUSbq6Pp/McSadRmRRDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818665; c=relaxed/simple;
	bh=+q+1OhDdzvPZ+krF5hp5AKstKd3Qe2GUMwhgQ5xgalk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMJoXB3pAN3Avw4/mrdvh8qcqoyyLDMirHQoz2bD4M0fqPDXe+GsU/n3qe1RK8zI2Ft6aIgRZupouaeI/thxI2et7lqHmRwV1JB2UU5gOwD0Ax5qxRvXD6SP/71DnR0qv2LkJgrEcR4oJj4FXbB598YPJ25Q8qNohcDIxA2pmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CkdTtaf2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xxsn6grA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CkdTtaf2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xxsn6grA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AAZrrs1925369
	for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 10:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A8SRtNLpNrKw7SKWjiRL/dpR0Kq7TCMarVsjksXHNUo=; b=CkdTtaf2nqO2xGy8
	Bi410T3HIY9W7ZVvMQzBUGspYTiLWjE+ICQmE2j+qe8fXz6QfmQZq7xrJxg9Aeqg
	1bHek48yjW6VfugcMLvj/et5eBFb7eFe2wGQIuJIOwTu+hZBmyIPk0AfWLTyX/vF
	VR7SQ6b286brkyvfzsnCzb5VCVFnwm2luRlVBf1/XfJTz+Wl+IegnsHWtTotUQjk
	1LEqvY635IeSOn0pkb8E3Tx97EwT9YDMeO0fZWwWUAo7L1OnFHZmo6TdO82fCGjX
	aR5wLwGCm34fPAgZheTJFKeYYLdbOSnoDEFBUoio63nlLy7/E7gi3eGuLD42OTOD
	zd8cbA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudjs3bm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 10:57:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b24308165dso39471765ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775818662; x=1776423462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8SRtNLpNrKw7SKWjiRL/dpR0Kq7TCMarVsjksXHNUo=;
        b=Xxsn6grAo6ebetO+WFMc1Xf0DJQU0m8YRVLRhiJPb8w+8iAeGuON5nJW4SfQXAzCDT
         KBIvFU25YN+K1l2UlbBp3QTXwEAGyA/lekiHSPDOPPz2Jvu9bcftPT42KdP6S3W1MhTm
         bJC4uxhYiVZKQuVPJwTmEvxlfDyFQfAbcmeo8LWnQj7QgylsLhX96VDwtLeKYdCm+Uih
         sy8beDsbsWPRpH783VLkeiwEfmFvIAubjTI0KArO6Bka/ALD9tqSGDKYpccs+BHim5OE
         hvaD+BKMJc+ylVebSxzGgKRMJV6o+s4DKkTlaPoOxzzoJgzChlFvTkhOAtjdrkCgjJnd
         LC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775818662; x=1776423462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8SRtNLpNrKw7SKWjiRL/dpR0Kq7TCMarVsjksXHNUo=;
        b=Djx2h47iYQECgKA4Su45gNiI7Dw3iLl3Ajq7wsKzRIprIcLkE+XEftGMnQE/CY7Zy+
         LrvRikCx7NCglGXMOhHZtugy9KZG5d9GrWkIvtzEuWRolEmOP80VU3i7lsKCuYGaR/Tj
         Y15cXkVMIooNPdoBhi4qel9+GE4fD4RnH0235ySy5yo9oT9zROXfDi51t9D1g29vhTTe
         888a40WbF9o5A0cKxUHk3vG3z1Kl4k9dbwM6qbpaHSjOZ4bBw9NwGVxVzJ96pVKSpFGA
         T9svFozK8QB1oWXbMjCTBu6LJZgRAkWDm/T0DhgA2JTVpUNjiL0pgVP50yesNHdoyfzi
         m0NA==
X-Forwarded-Encrypted: i=1; AJvYcCWLodDawVkUPO0EdXVzvQ6x1oecTwNZEWopXmh2INT77nify5crEnsuk3yqkKOYBkm7HYYRlaCA+6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBT39mlG6f/XaidLRTL4eJz+ytGPz7spaRIikQ0RdF8pI78dYE
	yL1TGcgTBP5ayvbXpwzv8nmGZb40jXqPRjjcNKybP/CYvbHyzjiX03RjJjTf04AYMqlkwumM2iU
	QQxuNCgSHUDVrZKvou+78ESt5m8pnKl3UjARIf9TxSuyKCCjokK3dKwQyRDPIxZk=
X-Gm-Gg: AeBDietxfM0rQhhR+GZr0NROoZGFRHbXS+s59ikdsDli26coDLhsRKgTus4CQHf4yQe
	8t1TMFSULxVl6wxm/P4yuwVlt0tv/y6+9kRQBqJ29ENdpGZpclyvdQywsi+oWWQwdbCTI83apNv
	aDdfovHWKD5KRklIObuBVMyTa/kafoxO5VaaVjQS1nkM/hZY0dNQXquL6+6kkKx5jiYZaY8szcu
	4dKj8MQNzGoP17mPSKMOMa69k31VhYO2yzyX0sfrdMW2mO2tMpITx50n8HkrHd5lRMGTGuEF/4K
	DeHbVKitwkkDPoujqg+KOsBgCW8cI832mtT3tc+noaQfnPXMo4fFuUdwT/VOM1jEIb/DeeTPw6S
	I22hf+JoSdD11GBHQ+ws/0H+hvKim7smSxdqL+EFqAPWVokXDFfw5
X-Received: by 2002:a17:902:b101:b0:2b2:5491:e32b with SMTP id d9443c01a7336-2b2d5a2a296mr20063455ad.23.1775818662527;
        Fri, 10 Apr 2026 03:57:42 -0700 (PDT)
X-Received: by 2002:a17:902:b101:b0:2b2:5491:e32b with SMTP id d9443c01a7336-2b2d5a2a296mr20063225ad.23.1775818661968;
        Fri, 10 Apr 2026 03:57:41 -0700 (PDT)
Received: from [10.218.44.178] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4e15f71sm27075985ad.34.2026.04.10.03.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 03:57:41 -0700 (PDT)
Message-ID: <71c6c453-4a6b-414e-a039-80f36e948489@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 16:27:35 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE eMMC nodes
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260409-enable-ice-clock-scaling-v8-0-ca1129798606@oss.qualcomm.com>
 <20260409-enable-ice-clock-scaling-v8-5-ca1129798606@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260409-enable-ice-clock-scaling-v8-5-ca1129798606@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X+hi7mTe c=1 sm=1 tr=0 ts=69d8d7a7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=QRdWpJMrku1fmPn5X40A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: lCSEGGgVCZd9mGoltj_6uT-ryvimiD41
X-Proofpoint-ORIG-GUID: lCSEGGgVCZd9mGoltj_6uT-ryvimiD41
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEwMSBTYWx0ZWRfXzRBJKd2PTEbS
 wDSPpRqyxCueV/c9eQYP6R2B3fcdBT7+QCGcs0F89cB9c3IMoqnGPVqy36iUOeeUW1Cg+KRPS/M
 J5ZFTnvlTNBQZff/mFICzUTCbMLtsskP8E7Qxj/vL6/q43wE5+zlRv5bONvQRtx0BMZQevHxgZQ
 /OmB8gGcmoimfxK+nB5PvPJKRjH4gEUNtpzwlrnFnboZhTZilkumEhq0szXoIAb3HpP3uQ+q25i
 T84gFRx0t2VyYElJLvQmwlgkgkfLZCS0lkmUIYmyudiuWMBTyBWLl2B4BhxG0LQ0H41iAn66cUS
 ZpW3LkKkKSjIeAqK4rxo5yX7bemc1ssSjbT7jcW9DauXoX55+r5BimkHi2H+QOGxCmlOc59W9jG
 cAuIrkTWxHl5qEC097VbBtkuBSXO7ZaEnODVFXaQTNmVsFrncGMxQkDk6Qe53lGvSo1TsPfOmCt
 YBicfuMos9Q5QA23soQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100101



On 4/9/2026 5:14 PM, Abhinaba Rakshit wrote:
> Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
> an optional OPP-table.
> 
> Add OPP-table for ICE UFS and ICE eMMC device nodes for Monaco
> platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
> index 487bb682ae8620b819f022162edd11023ed07be8..cb0e554e94d237b0adccb55fa9ed967bae9eea05 100644
> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
> @@ -2730,6 +2730,22 @@ ice: crypto@1d88000 {
>  			clock-names = "core",
>  				      "iface";
>  			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
> +
> +			operating-points-v2 = <&ice_opp_table>;
> +
> +			ice_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +

75MHz is supported too. Please add that entry.

> +				opp-201600000 {
> +					opp-hz = /bits/ 64 <201600000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};
> +
> +				opp-403200000 {
> +					opp-hz = /bits/ 64 <403200000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +				};
> +			};
>  		};

-- 
Regards
Kuldeep

