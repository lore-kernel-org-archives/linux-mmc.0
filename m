Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF81346A08
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558695; cv=none; b=Q5RLE4Imlv7yvMpew/MueBq6FHXdMNpmkgwaSoO/xG0d7q1Z7jpj94fmziICQqWbFhuKxjfD6Kw/q1zx+E4u8npGvR2vL9dFjEhLmtlbfPtYBC/r+dNvAqa9d2pG9W6pfnDEu5/184Og5b99oQ8v0pqQ3tZokye6wEF9MNJ9u9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558695; c=relaxed/simple;
	bh=Jqg1EoDVDYxk/8JdcNcaKA6W49dbTyuAi+5B1jH8WIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tA2HVCatrsiJXgYYoBnktWVOZ07Y9NCdd6PSJBa5VLrawatraTMU4OIlu/oO7sLKtvBBGeitGyPRCw+zTgcqM5Vn+tXAOlkGsg45UuYUtUbah6rbOOn0jia3we12BKpdlFmwG1Cs3HBq2pw9lmQvitW43gbGEZJ9gJsVKIj0S1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AkZ7vdf/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QWCWsGjk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkZ7vdf/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QWCWsGjk"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5RGe63067019
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 08:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xuwALojs1t7YE4eu6ENijvAe
	4SU/Ojcsp9SKogHiCUI=; b=AkZ7vdf/sA0kbLDojB7Og4C5PwxbjhGDGQYNDLi1
	7IhzwjBirzL58bwYPqgpGAkJ14ZV68/UUg1wgwGpZN2gPcssev8JqDFTmkGXUWDa
	SyKeDslmae2DrO05o/wa8NL3f3RI4609RWOWKdnMpbrd4YJj44OiP9/tnjVAO+xP
	v97vJTafi3cyi5lX/oxL/pHIyI82rmYHWoayiE3aZ1vemQTnCLrwWKyN643bfM3A
	H+h7MJlla8iJEZFbMC/RpSnpXM/JF8ZHBRvmh0pfHM64WG4O5Zj6Et02V7gzBi3F
	GpHX30OYciiFlFNJfaNcAeI13OVHyNvRVqxlfU85Wd7elQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88jphk3u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 08:04:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ea75996387so63086026d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787558693; x=1788163493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xuwALojs1t7YE4eu6ENijvAe4SU/Ojcsp9SKogHiCUI=;
        b=QWCWsGjkq+OG44r6+27kabHNUJo308AOLhYv8lUwop2hzvJQ6v1z5UWPaFTTYvEEav
         M1nI2XAD0NkBpjPY64qT5m45Qx/gCeRAJ98GfFwUlg2uQJlw3wkA9KdIqb4X9sxke2/f
         Z23RFm+PyZiu+6vaS4wWpCTatmlr8p0DfCqsBxwmF7bKgyASvAmVoxG0ICGtR23lExi9
         ezfbpjCBaAMoEwuw3wZ9VExejf1JMm9XChNoSUF63mp9pTgso/8Wk2gEfTJjkkrf2gGx
         cA6rVJDyZXkezDylJRP9+YmLvqBn456DdaYFVpra/LoXnCJ4IAHt6BVUQBJkFMYSFr+z
         LUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787558693; x=1788163493;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xuwALojs1t7YE4eu6ENijvAe4SU/Ojcsp9SKogHiCUI=;
        b=nXkw+9t1TX6Ug5WdOHs6QR//9t4s5TWucujiGOUoCNxBRnZZydaBZ59tNx6/IHE8QY
         1xG+fOfViH/yxVwvOwH34DUQ5J92LQzPfB2l9iWgexBzTtE9+8lpX1JCZrZHEGPAt3kM
         /79ECYJa/HqgcsirhF/iZ+02oIyywmSUBwxhw3nxf7CoqzMSYOsnBtI9itLUXka4umx/
         bxWNctZjt1eOQUIHtHu/u0+6DNXX6KwUCIAz7KpdifRHkRXMz5bGwoRFjJMBzlggFpeV
         eP7KAKhSCZfUiuiC8JeJ/SLrgc+s8kaGY0uMRLaFV81OgedjQ+FOQYF5b+MVv5DMvD70
         ut0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp8xKxZ2JAAweEY3ghZRz3GDNhkdUZXh+u5982pGduTGxW8OMHMk5rzeC5h6vpWBwibe/cnT0+MBNs=@vger.kernel.org
X-Gm-Message-State: AFuF++k3P1R2oGXQo/Sb94ycgD52HmMluSmA1DrxFUPUXVBFQlAMzkfT
	ARcnFIPZFTKF4t9+BIEfqXyIv7lRatm+Ah9rW3zOpE6aAnftuz6yXcp5k6uGju6aDvI/Nedd8gp
	MPZK8qivbzuz2W50dQovFa+vgbY0gdqvdFNozwUen6NM0Ei5SwgoFuIaBKe9WT8w=
X-Gm-Gg: AR+sD10OAgZjzL0LnoMC0WvJO9nL7FUUGx/6L4j3ABnVHUFjuCZ/Na66fZ6s7iBcVR0
	KtHV/mWOaKdxQT8bg3J6ThTzHt6IO1oPha4pRxqEusl3xlsv09J/oLqkVGZ90JZEgCyvAuT6hrw
	vIlLofOh4gy4EGgUjnHrk342jwh/ljkdTFquwljFT6mR5ogWPnfOvuSZzugep7E3IaFsyIA/8ew
	KzpGKx2AIzWE+TR5OMHm5MRHsg7Pw3X+92oDp8YpOalslpHV17B+pH62wFxaXQ/N/XTQPzRP1Fl
	4ZGVJDQhBc/yPNMiAPVNQ/G8XnorQ7GufCaU9KrFuMBW0n3wPim2AgfBJiigrZuVOXKWdX7O7ZG
	iEnEvCfIB5l4c5eo=
X-Received: by 2002:a05:622a:1353:b0:51a:6feb:dc8a with SMTP id d75a77b69052e-52e09bea1d2mr160318591cf.18.1787558692824;
        Mon, 24 Aug 2026 01:04:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1353:b0:51a:6feb:dc8a with SMTP id d75a77b69052e-52e09bea1d2mr160318391cf.18.1787558692374;
        Mon, 24 Aug 2026 01:04:52 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496296cafsm1155678266b.14.2026.08.24.01.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:04:51 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:04:49 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v12 6/6] arm64: dts: qcom: lemans: Add OPP-table for ICE
 UFS device node
Message-ID: <jvrg36wp23yzewcphyumsy5xdm3bfks56rnztdmloqj5nc744c@gvtowzq75fr5>
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
 <20260824-enable-ice-clock-scaling-v12-6-09271f583dc6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-6-09271f583dc6@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfXwER5Myuaawxm
 oMwB6Y0hVNrUdJgya5Fk8CRkX00so2L8YtrpQeRw3KM7MEqwIEtrHLzF4BfhhCQFWjLzPFG17XP
 0GhO9qSCPZqy4uJOpJvfKxCzgGGq14xkkPVkmE5dv/QA/SGI+G37nbbuFFX+SyiwO6otCFqme72
 5h2kjDnCuntNK9OT9L5cWCnB+zdBQcT3UfVWDcG0UIWK3KCTqxyVd4pd7w8bSmFRQS4vpp2Vm3x
 d5ap3h1sbMityVQR6plCG6nSXTRkNX1EXRtknPKaiDysF58nb1oag8SoPohlaO/0xd+DBR+2Roa
 dtrTKnxLbqqKTPh/TxKziHrkSkwS+DwaTvT6G07/VGRhR2qw0R3fsrda5zxRH5JDhVM6eL1+iO1
 Mn+AW2FMjiXVDd1f/ykbHwC0s2ej4suGISGsqGvc8760twsFcJAdKZTNJ/KogTxnIuDouaydID1
 VU8nVtRvMDxY5kk14jw==
X-Proofpoint-GUID: ijgNZzdAl1NvAEoGDSC3OHtpbjKIhgTg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfX20GPs3dQOHh+
 egN8Agp4FWiSpZcSUZrQY3elvcCczfvz8+7ZJVd1To8zVo0zn3AOQOi8WC09JbjfezflTZpQ/MV
 Ti1U16ebs8BCmz560FzPzv8XOd523go=
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6a8bfb25 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=xhZcOr--89cURCpmMK0A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: ijgNZzdAl1NvAEoGDSC3OHtpbjKIhgTg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240070

On 26-08-24 01:17:43, Abhinaba Rakshit wrote:
> Qualcomm Inline Crypto Engine (ICE) platform driver now supports
> an optional OPP-table.
> 
> Add OPP-table for ICE UFS device nodes for LeMans platform.
> 
> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
