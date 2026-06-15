Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F63C0A03
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510648; cv=none; b=Su6KMx0jiG+BWjv+pQL0uROkp9xbbLrNfk8382fbFs5uqtcI4lj3JMZPiITREZhzyZU3YWj3BOY5Tzz62BhynhHntduNdcWtJWYUVsTCxLneqPUaM+V7Ns7jxfpjCEv/qLiClhJJWSNcVTuIYL65uylmq07BTX1YPOdI8Fu2Ig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510648; c=relaxed/simple;
	bh=306+Dnl51wBPqV9cZtf8UkZPlQZgUUwTx4NzKjshApY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhT3+gwkOTS00Zel3tCi5NUeoF6rgh8k8rGKE8htaiRq9UGVts6Kox4BOwgbZLyRMLjp2rCIzR54MJUTAJnL8qjvWdbSYE2pDmAgfeji8FqNE8v+jQQ4P2wG4kk/py9/N1WwXD71wNLvkziLxMrGyexQDGRxEPdy2oyWquIqJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DXRHMoLH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ahSGmyEs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DXRHMoLH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ahSGmyEs"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6Kvw33828153
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 08:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=69HrKwFmXz8riMg7FP9KtF3p
	naP2sJ3u7cfriQzChOQ=; b=DXRHMoLHX+vrQ7nXmhsOc5Loakb5Kvri1bCKc4hQ
	Uv+aHRsWgnIxDpa7w7s/w7QcuF9aD2POvYKMjqe+BNh4z78z58BtLgi/fhPiG4bn
	AWhpwYIF2YmMaz8dHfb4judSrC4hWhYdPsJ3Ytl0FGfiyuJjwsBrmHbyzEgd63eH
	kgOwB7OEWknBID/VNDCOIOiUNZ4DgXIlZMBZCOOR8uynqf1u+oalnetw7u7TWgMW
	c5i9CCViBnGozoQGCEcx5OHgZSHDeQ0g526RPYZqCxvHPrc+3iKPIXeyCB8dYgLT
	dzl7mSRNKawoWdvpLrjG5Y7Nv24ToyZB8npMx6qMsZyHvQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u6aa2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 08:04:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d97955899so3010996a91.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781510645; x=1782115445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69HrKwFmXz8riMg7FP9KtF3pnaP2sJ3u7cfriQzChOQ=;
        b=ahSGmyEstd7Dcu3Is5mpsp+u3u987f0L9z7rUWWf6rH171B2SwJVJ3WaLx2a0Tb66/
         8MGeENUHWxuUc8N3G2zcDcsf8YI4wcNP4cy3fQEfQFWg6vdXzMGKC1ROKmMKsgKUh8HU
         d6eYQAUVHousVacHuf2/vXzsM4pxI3VMuiO975DrxfH5QhD2GrX6wHRiON52ZYvB15Lk
         OrCXhm1x7MXbX5zDNwvD3tgjGD8SnXGUiYwa931EahRwBmRzSUChwtc3dTHBVJ+1vA+f
         QJslb0niz9Kt1jR1+r8SFTuOX/RrsGvnWelgM3JkdDmF9Mqj2lwjGcWBEYKW6yO2Ai5y
         z4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781510645; x=1782115445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69HrKwFmXz8riMg7FP9KtF3pnaP2sJ3u7cfriQzChOQ=;
        b=irnMdnEj0mOJDDOT7ollQeISmi8Hnn/6y0Zrtvl9IS+wGCtLM8LGCojT/UpPsZld70
         HVe8E7uUB+N6FWQ0BzRrc9lIs9CFBgpYwEcpsUKtaFvog8aGHi9WraELh0CEnheg+e/i
         WRvxpJVvb69cDPShhwOkRiAaMnIh3R2Yq+KBdkpLzBxlKPYKTzryldAglG8kCfket/Qr
         +qJMmP8CgoGddbIUKpLUNbZLF2bz3q9/MUxFAS+dtv+36zBgNsKa7WI3TGtEBtQe0dnH
         pqfY4lM8N7RYqifXb4hm+Xe2TJl584WLbOHhWtW0E4O2mkMT1C/uRbKIZHWIINNQaGT7
         OKZw==
X-Forwarded-Encrypted: i=1; AFNElJ+CaF2IgJTfZxx+KefqyPLtkxsHh68xJFWmUAPLYZ/0nKkm/7iHxZ7Kzee2CYBIHsHxG1oQsZxTQi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybRrU6UuvIiPnUansmsb6PQ0gB4OCsDnsa15Y6XHIPyjeER21m
	FC0deNrUEv3Vdrc61iD77Xas/zx/c3xu1nUR2QIbghkcCGFyQsCmc02OJtf9pp0Blo7Vt9E97bo
	gIHmf5YJYTfOM599m/RT/7+5RGt1Fjsc8+m8OAwUkVyoduR8dRsdCL3hdCV32tl4=
X-Gm-Gg: Acq92OFH7X6MdXamQ/Ewm3vp/QEBHuRunOabji64OoUAuOVRMOJvORX0ENyx36iIA2y
	EzMUbuy5Vt8Veluzqwt35HERb5fNdKJe+1OS/zxq9jKgCs1umMObpW5yUwcN2rZ9hKpvm91wMMp
	XLlHaVs3K/9MXIOdCmyQzOMvs+srq6PwMrR3JGz8ibRaJ3RVrSSr8a2j5J0kLb6ieoH955oEaPn
	YaPy7cIge93zVfvSnQvzUD29zKlc4QhNzy8hVLo0Xpf6ZVjWajCuPpFDxUQqc1SoeUeOzFGEdF9
	VBTErTXnXRzyrnmdr7zGmE0cKA53Nafebu7YLSAw+tHHHRwHxPO3LQJ2tA0+Egqn5BLYbaJ4Wiv
	ZXtUC7IBsarnUiDW2//pibFmeIktGuyfw/kOL6qbXvgwNQZI350a8Yzo8sEg=
X-Received: by 2002:a17:90a:c890:b0:36d:a510:f8eb with SMTP id 98e67ed59e1d1-37a01846de6mr14273908a91.3.1781510645446;
        Mon, 15 Jun 2026 01:04:05 -0700 (PDT)
X-Received: by 2002:a17:90a:c890:b0:36d:a510:f8eb with SMTP id 98e67ed59e1d1-37a01846de6mr14273878a91.3.1781510644980;
        Mon, 15 Jun 2026 01:04:04 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a2668cce5sm15354774a91.16.2026.06.15.01.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:04:04 -0700 (PDT)
Date: Mon, 15 Jun 2026 13:33:56 +0530
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
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
Subject: Re: [PATCH v11 4/6] arm64: dts: qcom: kodiak: Add OPP-table for ICE
 UFS and ICE eMMC nodes
Message-ID: <ai+x7Ovc9/pPTu9f@hu-arakshit-hyd.qualcomm.com>
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-4-1cebc8b3275b@oss.qualcomm.com>
 <184dfbd2-4781-4dc2-9165-66b3617bde0e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184dfbd2-4781-4dc2-9165-66b3617bde0e@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2fb1f6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=FjpnKfaMezcxXxbuv6AA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: zgudibq3CQGgPb--FToqywRZs-Kil2QR
X-Proofpoint-ORIG-GUID: zgudibq3CQGgPb--FToqywRZs-Kil2QR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA4MyBTYWx0ZWRfX5nHHD1+tB7Op
 YQb6WP9LFR1XF16gAfDWLSAvBfptR2+/aX2/mky+L84uXbXrL7/6kzMrNybdBd2/V1BFCSOP7gP
 PdqEG7KQ5EB9A/W2KD0BKBPuDpMIiQfmAICDn8WrZ8Ll8vHSLnbJjX9rJL7cTdamXXW7oqg3ofZ
 cdO+dqH4GZ6DOgSLJpQKI0FRow7qXFNHZC5iZQLb1FnyuwaRDud36OqmAHI7gFGcLL4m3i9c/UJ
 wficLGbhWH+XDPlg0e5lnZVgmYtpLjov9uWAuNuMwKaTxbrdm7DYFD74G5uSxVRdYgoJVAN6ZRI
 iEYNW8XbG+rFdIhnlMtDItYsJUpEMwgsKS80hSvJVsFman8ipECWyKKOQ8rq+HjnBq5hBlK7ifw
 07uPBP+3Aug3A0BxTLppil2aIn6Dxjk0tTejUsyzB6KwULESTbFGkOVm6l+i3IeA/lo0AZPjFTX
 RVfX98QJtPWIMyzSe4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA4MyBTYWx0ZWRfX7r5iasvt/UZP
 Pq6VEpy0yLMze2eHddrzshdnLwy4jvKTf5v42P/sTOrGxEHW8D7BTWCBdZ3CKnbYJaYNSoGY+n6
 GLszUpLbPMuLftfPVa18ayl3WrJLaYI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150083

On Thu, Jun 11, 2026 at 05:42:10PM +0530, Kuldeep Singh wrote:
> On 09-06-2026 03:17, Abhinaba Rakshit wrote:
> > Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
> > an optional OPP-table.
> > 
> > Add OPP-table for ICE UFS and ICE eMMC device nodes for Kodiak
> > platform.
> 
> s/eMMC/sdhc
> 
> > 
> > Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/kodiak.dtsi | 42 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > index ecf4790f3415c46781c8e790d7892a41300ee7a0..cd76da7e49d8c664df6a60b5c18418c4e97a3ba4 100644
> > --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > @@ -1087,6 +1087,27 @@ sdhc_ice: crypto@7c8000 {
> >  			clock-names = "core",
> >  				      "iface";
> >  			power-domains = <&rpmhpd SC7280_CX>;
> > +
> > +			operating-points-v2 = <&ice_mmc_opp_table>;
> 
> To align with sdhc_ice(as label name), can we rename to ice_sdhc_opp_table?

Do you mean sdhc_ice_opp_table?

Abhinaba Rakshit
