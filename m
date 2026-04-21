Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F76298CAF
	for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 05:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750646; cv=none; b=AR06NBEjc1syoYNdXyn4IrUU0xNPi6qksQvfYZaxB0zt4rXudhkS6YdDsnVal3paPMNfoXtCYkrJo9WkjV8MgIb+5+PmAMCHxfKhavSLFoPGNxts/QNW6P3PqlvKx2aJAVT8Iq92OiYAJGCLmpk2EFXBd9uXrxH3CU9vH038Xyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750646; c=relaxed/simple;
	bh=Ma2F8m/bDMhSI7Ffwjbd7H0bWVVF1mYXZaXGnaO6JrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGVzw6XuNTQb0gO4Ym5VFH9IvjSaVbpBhvBfHBhVh7EPXV4ePdLn6DYrLXszgY7M95RdopRn8X/l2I3VJALlMSk4H6kmQGh8a+PWO2Nxexy6RigXkbqAuRbwFcpbPZ6TDi2dNDWvAjzEi/fbk2nssIE2FA7fLnnYCbmBcZ82pys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oz50KCKw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jgD5ds1F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oz50KCKw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jgD5ds1F"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L1ZKK02281708
	for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 05:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VDMTCJt9tkGymDiOnHfYrtpW
	tA3tQv0mZLbj4noOZd0=; b=oz50KCKwAA1y7tlWZhNpgOE57wXZJ61yZGcPi5ii
	URgmtf7oUJGVEht30bNAnNSid4Gx7mRv0LEpZCp1JG47YnOscmSXl5uXCEsAEzuC
	Vai85BnWbJTJXmMVVDbXDj0mu7T1Z2yIQDuT2xgSm/vvy6jFmtd7Cav5t4Tv0CgZ
	MvHFgaqcbbr6Zb4sWEADl3JK6D6UAHZfqWzKlWEGVsscw5XndB8DEyV7imUteOon
	Zni8nHgPkbVTbKBXCKAaFumeql/onrQgp7SP68CXKTjaLNrX9aYkOPrBMlcdDBI5
	jv/NCygmh03HAZ8cdHiVBAWPhO99glPlW3NvaDJh/1mw8w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh59c074-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 05:50:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f9f49e4beso1664943b3a.0
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2026 22:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776750643; x=1777355443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDMTCJt9tkGymDiOnHfYrtpWtA3tQv0mZLbj4noOZd0=;
        b=jgD5ds1FmtqTsyi08u4BOdMnKESim87rENJ/+rLtbtMrACWSXae5Zu8q9l8gLpTT7G
         oPJaMfyFU8CtMkBbfMVHC0d//BiG8n4kaZZl455pweSqQFWW7mbpPd1jrpXy3gqdZ+fp
         60HKboxApFoei1vwHv18/3NhcA6PP8t5W4CuwamaxV+ZF+o8Z3B7CvrORoCQ5eIUDCqw
         dz1Amwwf40OfHkfuAGhOESvgbWvNuwq05xdPXLgV5VGOfnvARlbKKp109IpsKJGM05oG
         fJW1j+baRzB3ywGeS59bVZrzVJXVTMYbb+Uonx/2DM/gsBrpl3o6WbrKLr/2xQb9uck5
         0UlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776750643; x=1777355443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDMTCJt9tkGymDiOnHfYrtpWtA3tQv0mZLbj4noOZd0=;
        b=KEAoNB5YIDER1ZsecaXjzN9l15BbEnUVKTEmxze5zUpf5hYPSthl5CG2h2mNiDEsqN
         HptLXiwj841bI+dRvgpvvuTw1p8sGIB4z6YcRprniElSo4ogNHdIbLTBYI1054PBn9vJ
         ImUl2lSoNmr+ctRMB38LZ1OuZT4ladkpBE2wOn7/Vwc2FW+G15hZ6hiLnDqX+s14W+Ua
         1oJ3nGJFLTk63E4crAnH6d2+EItD0vPmxoPNio4ssmZ4arVyU9rP2bSrpZEg1U5PoJ8C
         7em1Jcauwztc+kQPIIuDs/JIzDLNSdQw/1ckgltw2EeMrwVtRf5JKuI1cYWgkpMlDMst
         NLcA==
X-Forwarded-Encrypted: i=1; AFNElJ+sQGjGy9UONWSzRKocNu16iJ6eZAYq0yIzAVdbHket5hWmic4laeGoMaKDatPOxtKnwznHDqZmJns=@vger.kernel.org
X-Gm-Message-State: AOJu0YycbpuRIgFkK5fj6NUMrUvgmY23KhEc5v7oN7wIiDO4ai557ke4
	gzxsIzAPundTip+RtxdC5d9JLxiEJvmZW1+Z/ySu907p47cO0XrnsKqGO8mDzkFRIczO/n+u/yr
	c9RRcY8zY2Ya3jjsJVWSihL/iUQlqSFGPjmu1RkE72eeMf0JFAVkU5EcmYP/s4qU=
X-Gm-Gg: AeBDietjz7titSh4L2Op0UpSYEun6kJcSC9z1rgfjylOGr4RF7+V9yGE2QliIC8ePIP
	h3Xe1/FlwsLbEhXb8mVIeClpGT9/kF4CVBaSCqFLCaLlHi9vq21iByFl9i9CApg2hv3N6SBB6e4
	TPf0YM3ObER+mW+IIiVzDjGMKfSoJT60UF/O/lvv0SjX6M2bm/Wrrw0SiIb2Xrg6vs71HhR576u
	El0YkKKBmBjNJVlcNLBhAh0cz63xZBLe4//BxdfE4y0pwCkeftiNeajscRjXS2BwBxUKSvjuHYU
	b5MQN8drlCBjdp2YIeDNpgkoLctxP2U/2s1SKCaLmzUsymLZiFToMyg6SVTnko+/TFv36xfkWW1
	4MvYiKZ7xhbyZwBJ1EljaUuWJBIP+WNN5W+g3TkL0nVpJZxoe5W9kKoGlon+1zGOtDFWwfA==
X-Received: by 2002:a05:6a00:1993:b0:82f:6841:8733 with SMTP id d2e1a72fcca58-82f8c998ba9mr17278537b3a.48.1776750643205;
        Mon, 20 Apr 2026 22:50:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:1993:b0:82f:6841:8733 with SMTP id d2e1a72fcca58-82f8c998ba9mr17278498b3a.48.1776750642707;
        Mon, 20 Apr 2026 22:50:42 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb1dsm13700652b3a.14.2026.04.20.22.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 22:50:41 -0700 (PDT)
Date: Tue, 21 Apr 2026 11:20:34 +0530
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE eMMC nodes
Message-ID: <aecQKiWBMHBYMt83@hu-arakshit-hyd.qualcomm.com>
References: <20260409-enable-ice-clock-scaling-v8-0-ca1129798606@oss.qualcomm.com>
 <20260409-enable-ice-clock-scaling-v8-5-ca1129798606@oss.qualcomm.com>
 <71c6c453-4a6b-414e-a039-80f36e948489@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71c6c453-4a6b-414e-a039-80f36e948489@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: vqVEQQcjychSftmh9dHbRovT1bU2zueg
X-Proofpoint-GUID: vqVEQQcjychSftmh9dHbRovT1bU2zueg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA1NSBTYWx0ZWRfX3xEVMW2UiK3b
 0PsDLxlHubBr4BaXcJIpIm9YmiblsKt6QJqYe3RntVRIrG0rI5nM39EDMyZHz2m7LM7RUqIp8V2
 3YtpiN1tr7A0XawSNPtGuRyy8b4lqdclqFJyLZCMczU/LfVYdzDp7wkgxp8vf3qkLg1DQE4uv3q
 ZfSpuAj7yiPXd+ydLsESZsyr1OCnLUl5bUwf/AnnJL6N8EP2ULsYvdWTBXLTrnvDPrr2X/dEpr1
 fWVLlwMdQQ/OQn3mMCJD6f2ZoSMfQWvj4FalEx0/Iu2A4u+HjbRtRfW4roh60u631qI/Auw68B6
 e9RJgjpr6gkDUVXXGeOWUnsokMFIrL/m3kl622Ux2ghUnduEx9qcWZdxCJTClruWuARAVWGXRYa
 LkKCTjZplE0n/BxXOeN8qqGbcDq75mtV76Vx926MPidu4zgM5nT765Y8feeGEq3dEoENqKPwMfl
 WTcoZUbXJeZR/WgeB1g==
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=69e71034 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=FjpnKfaMezcxXxbuv6AA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210055

On Fri, Apr 10, 2026 at 04:27:35PM +0530, Kuldeep Singh wrote:
> 
> 
> On 4/9/2026 5:14 PM, Abhinaba Rakshit wrote:
> > Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
> > an optional OPP-table.
> > 
> > Add OPP-table for ICE UFS and ICE eMMC device nodes for Monaco
> > platform.
> > 
> > Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/monaco.dtsi | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
> > index 487bb682ae8620b819f022162edd11023ed07be8..cb0e554e94d237b0adccb55fa9ed967bae9eea05 100644
> > --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
> > @@ -2730,6 +2730,22 @@ ice: crypto@1d88000 {
> >  			clock-names = "core",
> >  				      "iface";
> >  			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
> > +
> > +			operating-points-v2 = <&ice_opp_table>;
> > +
> > +			ice_opp_table: opp-table {
> > +				compatible = "operating-points-v2";
> > +
> 
> 75MHz is supported too. Please add that entry.

Sure, will add the entry in the next patchset.

Abhinaba Rakshit 
