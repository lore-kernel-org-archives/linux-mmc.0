Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40BF3644BE
	for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2026 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812934; cv=none; b=lIVzuXCOyNxxtrR4Mqo67GGJRgH1Wa4NMg6zY0eyNHfYGe3AbDPJckMX85AtBfWZV2O88q/BMjz5A0SsV4dCJdKcMC0FA/FDO0yj52c3ZtF5aoUT4vvR6sl8mNAEy4ZIONaSd0q3sHiQ7wzBnnujcUbyd4APn8m8txegmWCUj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812934; c=relaxed/simple;
	bh=VpRfMjkDIVgIG1IpVnvWLbUY77m9BHwbtWthaup4Qr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkwYOAgU/JXLHrtkG4/vhZi1Ts8gThwaqLkS4AEgBIzvCG89Vx2uhZ34yRG8vrGGKAr/xovMHZgNqH2fGwP7NpKYnMq6op5Y7XZINE00HXcawnUJ4eoeiC4BdFWIvP5zhdlkN7kZTVpJqHUaohlEnDjrcTVeJVUKVvFnFsbgp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LxBIQfcR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MLT9JVAM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LxBIQfcR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MLT9JVAM"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6R6Qw2074658
	for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2026 06:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7ShQA2gHtvOv/7C4MRutuVhaIXxmOVy4BCMu2y+jIWc=; b=LxBIQfcRVtlQdTrO
	UOJQyP34Uz5/HuqMwLc0TRaw9/nYqDj5/YaKBkc4CAryllu5s0jpz+LpkEgeU0b+
	M7ao4WkzbCSvIRL6VHELrNKYjXS8g9vEjalyqDHEk1TdJVmtUb9RRtZ2NEnEUpUx
	8b/4aQA4wrY4Pwq/9M0CpiZPofrYncG8HHAKHjqxCcHPxdGpyRdBWZ2D4orhxsy6
	IHxW5I7KPaWy4yoxlvAYKqmfHnJW3DCsNbkvsC/ZH98zeJiGj+IiDJLaTWc8OtG5
	JL6BzHqTB5ar3VGPYWw1xlcvATeYHdyxBlVEoiEm0LSnTRhORWghymSku2v/uTKl
	rRYkbw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaa3bh6yp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2026 06:42:11 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so2162530a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 26 Aug 2026 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787812931; x=1788417731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ShQA2gHtvOv/7C4MRutuVhaIXxmOVy4BCMu2y+jIWc=;
        b=MLT9JVAM+c7tmAbZa8q0+CvHdFGq/Ka6efIlpSbxJ7XfIqNvp77A646kjOW75vxhUj
         mW85svNTamDLRhRtFgnWsFNA/AS4zH0CSBEQdZutpy5b4jlpQJkXIhwBHM/H+t0H9SZ/
         SVSdYIqWauTXzTQWMgxP2xJRkSlBec5r/3HbubTGmJprkqOhtFUsJeK1Quq/rEb87BKt
         wW3DL1WaVz6wkHHIrjWqBOITVRUtaNnisOfa3bTjwVtqPuXWVcagKNVS7OXoG6hqVzzb
         DZhqaEWghbdWM8bnhM2q7YhNujTVPS7owUM+OE1276QCfsF2ZCyEbEUAMUDfVj+ioRmU
         h6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787812931; x=1788417731;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ShQA2gHtvOv/7C4MRutuVhaIXxmOVy4BCMu2y+jIWc=;
        b=GhQ3pm9txu1Nco+3s5zsi7PEJQG7yqoRXCOIXZiCGC/vDXHBOGJZjelMyDos/vTbsy
         rv9eQh33UMU6HFltGY1EYMlc1e1rw6oJmpb9MpvHiPzFn8qixcFp64VYRxdkiWjahGEY
         xzAKKVjB5vtjSCaYCkz8RDaXRhKWvKnq42f+8GgFs6OZj2UVqWxRO9n2z28jdk/QIqkk
         aum376WqjxoKTq6Z8dFkg9SxUHE9lVRQ44C3xJbwSCPXjUAsjxtOJAqbrprpzohMn9Hf
         dEPS31tBawqjl+M5D5npUVGm4DdbFQVy35qfeyo2wPJ1RsNrEI9BlMdhNiNKZf7ffpqL
         +2yw==
X-Forwarded-Encrypted: i=1; AHgh+Rp84XsNFbxFEDs9meOAytQEVk+/PlTFygjjAzxLmgUE5nkmZwnckQaEHtii0HkihX30gw2bEY+qjH4=@vger.kernel.org
X-Gm-Message-State: AFuF++kA5GmmsMX9+RuHYCUGMYx6Ifb699pDUgz1iCHUOrQqNaS234jC
	eucipMJYH1ds2Rf7hiivio/KrDkFpdmNAo/wEUJPVIEo9sH4Eq/VCSxTwCNlBfJ1eAz7VJ1dorg
	hfSf6BEHln2DrMpPU54aXMeFHwHPA0Tc0hKPaOvFXr2Y4sP8GDJoh+Mz6eRSoQq0=
X-Gm-Gg: AR+sD11QL7IsWe1Xex2ySEQhNqA9PySDCF/69uHwXgfIf87y/omIkQpNKwYZ7hlHfWN
	wDRqySdc3VXwf6optQVgfRUv/qulBuAr4e8u8zlw825Upq2WTkcQtud1eh/qhcz1lW+Y6xQAKxV
	N9I/ECu+P3InbhDJ9nFN9dchdT2zSea4L9tnsCPZVgn8xIr5vtQbn2BkuR/0xa1MaiU3KZPSMuD
	5p8OWEi8xuIJfUbQN3woIHKLW4ZQYRBZXBBDK72Pl3xHjbXFaXLT1Mj+osPRciNcD6bBWCIPkPC
	iQeefiDEBCQqXKS0H0SQlD6V51OmutXS5uaxwcghvjTFpNZTgOXuXSDlowJthuSM9fE3EnFZTdW
	vpnAbm0iOXKfh1lK36Jcw+rgfo7pYFUo=
X-Received: by 2002:a05:6a21:4593:b0:3bf:9b61:f7ae with SMTP id adf61e73a8af0-3cf8413dffdmr28629357637.14.1787812930910;
        Wed, 26 Aug 2026 23:42:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:4593:b0:3bf:9b61:f7ae with SMTP id adf61e73a8af0-3cf8413dffdmr28629279637.14.1787812930531;
        Wed, 26 Aug 2026 23:42:10 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1bec80fdesm1693669a12.24.2026.08.26.23.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 23:42:10 -0700 (PDT)
Message-ID: <167f6b2b-a838-4563-99b3-39ef8077ee9a@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 12:12:03 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
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
        Harshal Dev <harshal.dev@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
 <20260824-enable-ice-clock-scaling-v12-5-09271f583dc6@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-5-09271f583dc6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1NCBTYWx0ZWRfX6ydjAUw9IGsC
 VNmduR17sfmAcw7K1VBPIGyxHzBqvb84FxE4/VmwAA2wTBamhJehnT7XVoTMti6m0xSLNqw4yZH
 OxrGMcnu0fYnKOOlblTHz9tZGrIL1RuloD0qfya6ddB0WTb5FrAy0tIHF/tyCPvL3eCdyhqyUSp
 bma3rsRmmZGK5fU2RKuB1dzD/cPhW4pJ9lFBOukufimt1cPBnwDwC9EOfQ8zeAxSIPuRwd6Erxa
 R5k1iFNlbV/aMaYD8mo5CrycoNPuo1p1aQmYvMZVqfhdYrdoV2lPqNvt3EUov+Wzotl1j802Nha
 vR1lqkTfP+oUjYchozHir18suaAtYczhTTjRbshNm4m7jvtLHW3A4yk5fwiMlFlCJr/0FXwBZKX
 5GFmqnstirvnTbCTlEDAFVc/ftFbDQYK8IN7BIwuEa+uqSsACff0kgQcGvX6QoOJa/kbTl+/Mqz
 /8jRdLpQLZ7zAUBNFzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1NCBTYWx0ZWRfXzPafkBF6AxLr
 5xedjBaI89PogsB9Nd5zhYo+M4a0nkislDjX9Fozm7ZR2A6MRlhtgo8BsimYxftuyZVdoZElym9
 mh4DlxA2WW2iUlzfQdOXvBY7fRz6iAI=
X-Proofpoint-ORIG-GUID: W49S_A4-nRQUugwepo750d0JaKkt-eie
X-Proofpoint-GUID: W49S_A4-nRQUugwepo750d0JaKkt-eie
X-Authority-Analysis: v=2.4 cv=KbfidwYD c=1 sm=1 tr=0 ts=6a8fdc43 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=-W0wxAWcNmATYll7EfoA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270054

On 24-08-2026 01:17, Abhinaba Rakshit wrote:
> Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
> an optional OPP-table.
> 
> Add OPP-table for ICE UFS and ICE SDHC device nodes for Monaco
> platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

-- 
Regards
Kuldeep

