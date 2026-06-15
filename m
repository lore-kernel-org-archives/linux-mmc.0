Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337C339708
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520159; cv=none; b=lEjuxk3qmi+WAY+3UMm1PF45Y2H6nJ0lu6nBhyNyKqCp+/IYzqIb28JyjybRoYy6QAZ9vBNaqklDevisJ18RyKDHYavXGW6Yfc5SXh41WixAgosvG8CVMvovn5FWkDhpQHLk/yXrzZe1/fsVeFSqN4MvOqXF8y1fJd8AvjTXUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520159; c=relaxed/simple;
	bh=PFv8Bc1QwX3m0kl0RA/mhRJh7I4ymyWI54an8mkYJ5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChXtdlC4HwrJ3iWc4U/15E2UHTUwtHpX2EFhUx6H/D74rjQG/BMsUqPAj6Subx5PCsCZrQUcJa2efGqDhfp3whPZA2drqZOu9RAycKN/4mmVE/vpuGWcFlyKSB6jaBFIDP04lB/Ft1FOXq+JSlw7IDOq7keWbBjphJlVu/rv+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FE0O22jw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ijfl9d3E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FE0O22jw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ijfl9d3E"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAImHe2410425
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 10:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MoDrHo0nAAL3euwZduxOxWenFYYl8H0QyMF+HqYIOj4=; b=FE0O22jwl1QN8hIZ
	DmjPlCC3hQkvfTaA2H6gCjt+UATlBBsb3pfMkg2pQMM997S6JuGnbRikkHgVxIDa
	hwsMIRLi/gES5do6pDcVbjDW4S/1mKbEoN28be/dUT5uh3IQzYx6hl5TIKNm02fR
	Zc1dng4tQa7KCDZgxXiBSPvWviLFEmn/Wx/PUORtEkJkrN4o3MXVFGv8tjCpdBDY
	nG6LcHOrXe5V0W8R7/T48Y3WjNVA7r5BmLign8SaMDNiAogbDOPEdGtj4mKR4hGJ
	R/yWXfAVbtM4RC3T416GDY6x34c8DdfUp7SWbqDkelr4J5Am5WIZyTc4HIhhUmSo
	wuOgQw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete980f0g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 10:42:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0bfcd629eso38149255ad.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781520157; x=1782124957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MoDrHo0nAAL3euwZduxOxWenFYYl8H0QyMF+HqYIOj4=;
        b=ijfl9d3E+ISbC3tNnJmFbvsh6oaz6Vw9BqBqTlrXPGI0b2lTHGsAQJXcSzEEaNb1OT
         +PApx5lk4skIAVPqBSo9cUpD8FsIx8cULV6kiJcPZvvkp+6lAHYv/AMVOqT4DSDWRKfY
         QIFagz8RigiaeruQJCKA8usKhBPtSCM+xlsKGUzT6eLLusS6G7lmyQRMiHPMymebR5Vb
         p2r3teXMSTwOzrvK7M0lv5/AV2SBHfg1v6tG8/hegZ6VGjZNkZUcKlvjyV1faqbc4d/Z
         4YsdGUIZvIsYiXU8xIgP3ec1raQoDiGQSEhAh9o9y+g0MDfOImBGnKTVYEjQKhEkPVAm
         B7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781520157; x=1782124957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoDrHo0nAAL3euwZduxOxWenFYYl8H0QyMF+HqYIOj4=;
        b=HdvaQ+DOF1UpxgKeA3Sj9Yk2T5iVRCFWjs67VosPlwq9UAhA774df1Va1AOiao6P0g
         EXCifxUykkxY+/Gbgb3WufxIxn8ZA0IpsKlp+CnJ4mKV062XcuHSaXzRkOsNUaNV7uKN
         R2eNTrro4/G/hxYXHv3N0ue6pOkRqf4KIAqBWABmDpX7Hjm6MrOZ29LNyTS7z6WHEeX6
         C8JI++o2Bo7HRNkgpPiy8KRwdRpXQVjdin/Sfe1YaqyWHs9+sooY/k7cRnC3TIRawfeL
         uM5KG+96c8PorOgyERXA20G+4pqv7ftyW41je5rcFlM/o/zpHpQrFOzWNgg+RRvT4i1x
         Nk5g==
X-Forwarded-Encrypted: i=1; AFNElJ+JnGFlSMMvivXE1CzZsbUJCqT2D5/csKgbJMoMQrYiAYzZhXtaHJV1o+nOUb6d+gIpmz8h0bi+MIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVsLtVKcBH/uyXlGL7NL9XVhx+mBqbI4hZlryGKqVFGMJPfOvx
	WC5wVs3lkhjD3iBwOab0gf7PcJ3aJhqFPLZsyOVl3bdyWBUl/3o8PD3fPExLTcMjUYuscLH7/8X
	RKeuygl2e8SCf6TR9DZx/OR06oZDJjNctNyQc4LMmrBnddmY/jJC8UdYB/LG+GN0=
X-Gm-Gg: Acq92OGhfUMwfyYeW8mvbvqPgs6DqnponTWg6Y2eGnzZiD4OgYuYKErPXZlap3jXEsi
	rwAffflsQxS0zpZsa14lvdJAUk94ArgwhLj2Xc9S/evr+WTRbCheB8wUyetc5S8nUcu/SpJ47ki
	zc2Fx3UVIa5xCHtfVYZlxhJVMvVQgGzABOtHCno8jJft/2LSKhM1jEdEIlzw3GLY7dHHb9tIHT/
	8IzHb7SV/vmWX714mXHPAs40OhIHWvTX40iaJlpMU3LsQ+LgV1rA/QSnNEVKACT9y72oBCyJ+Ka
	vKfunn13I8amMCrRP4N2Galv6RLZPNtUmP5zA36AgTrtCH71/rqGDAvStK2D0B9lN2Y6HCS7JoS
	jf77MCCuD3GgZUj9gxrCWaDA5jCI++427n2Em1tr7yQ9UyzoOGBWBXg==
X-Received: by 2002:a17:903:2acc:b0:2c0:ab92:584c with SMTP id d9443c01a7336-2c66426264bmr116470985ad.25.1781520157222;
        Mon, 15 Jun 2026 03:42:37 -0700 (PDT)
X-Received: by 2002:a17:903:2acc:b0:2c0:ab92:584c with SMTP id d9443c01a7336-2c66426264bmr116470495ad.25.1781520156732;
        Mon, 15 Jun 2026 03:42:36 -0700 (PDT)
Received: from [10.217.223.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f1f0f19sm95512865ad.10.2026.06.15.03.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 03:42:36 -0700 (PDT)
Message-ID: <16746ff8-4b33-458d-9c41-3f43bdaca4e6@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 16:12:29 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/6] arm64: dts: qcom: kodiak: Add OPP-table for ICE
 UFS and ICE eMMC nodes
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
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
 <20260609-enable-ice-clock-scaling-v11-4-1cebc8b3275b@oss.qualcomm.com>
 <184dfbd2-4781-4dc2-9165-66b3617bde0e@oss.qualcomm.com>
 <ai+x7Ovc9/pPTu9f@hu-arakshit-hyd.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <ai+x7Ovc9/pPTu9f@hu-arakshit-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a2fd71d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=ENEOTGz1k9nZZJ794AwA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 0-shepbTyAvTKtri3EKEha7iOR-nmm6w
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDExMiBTYWx0ZWRfX1ODbmX8iuVZu
 PsIQuFBiR3vWePEn+hzH0gaCCqTRiJ66M+4ShUSxWdfliK3fa2bphBG9JgT+LKPXCn1EiO9fGEG
 iEtee30jiIBaDx0Hr4iGxmdc3MoF32A=
X-Proofpoint-ORIG-GUID: 0-shepbTyAvTKtri3EKEha7iOR-nmm6w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDExMiBTYWx0ZWRfXyORKRY92tji9
 0U1NdJNdzUNoTfrDAekO7L/EMS2aP6TZT6o4wnGUk8fzCAy8LBMZOMIu8//lClN1pqYMPF4ZVHD
 3Wbeg9wzw4Zf/4zsXIQN/6KEDoUCcEkKDVi7HJuhCwebml4bwR3CQXQ20aeRu27/qM8FKOH23M8
 K7OV+f8dc2ZUODCSNbtbsq8RkJED3O5cmrEWBEyA2W0gWB4X1AlF5f5bltcEX8s+TTr1rjQX5OI
 PQY3xnlQ/ZQSPIUKecfJ5nvVtjrt1D5+bBnb91a1kGVMcHZPS2NsAHIwqSPstwNAINBwnhhKCqj
 13Up7JAq77GoNQKanEzkXxO9goXocS/LGXNfy01o7BgaNvx6zJBnZ/Dmi+Y9KEN1b7zXS0J2XmI
 nIlebeEg2LqYGJWeOrtTO2u9PNHhX2OM7ZLk7Wp4vEym2Y++OvmNynWIlP1f9UnN22FiGGZ/Ub/
 QTISUb8FyhdEdNL804A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150112

>> To align with sdhc_ice(as label name), can we rename to ice_sdhc_opp_table?
> 
> Do you mean sdhc_ice_opp_table?
Yes.

-- 
Regards
Kuldeep

