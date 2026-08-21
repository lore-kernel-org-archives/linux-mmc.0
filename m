Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F35423E8B
	for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308617; cv=none; b=n8dk6YzYZUNnjgGLkQvtRoBmV85MxGVzfMz6XQjwKjZ6RZ4CaaN8QPCk87kiftwLnhYZ0y6d12MytyYDZMYyZ9AekmyXCVR0XFnUOBGHU4Q1yJYkq5fJgFGi1Eu94keKrctvFIpywhG4xHejk5CfXelLnL87l/0yoOfH6QTrn8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308617; c=relaxed/simple;
	bh=b8OrTdm7l/bHAh1BFCbvKBBAJlt33YXBsSrQAG+/eqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6MsK/h/w8KAAl373lUKA/oXJz81VUU3IqjgzTHx4fXZnD0aRhRkOMwTvjVLCsb+PxLCKTiqDxitCqcQEdp1aZpGavnOjyWvtuvZknbuTW/9TFpzmvnm/l/2RspBBZqcYBvPVUPTUkzwm6rKcFUvWZGrXBXWgrgQ32SpIquReXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pzhr/cUG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iuFh0/aH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pzhr/cUG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iuFh0/aH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9MEQx1025958
	for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 10:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x+/TUZQqtWMcSQBmELloooyymV8cy7fWHjTFq4Y7vHE=; b=Pzhr/cUGL+CVVoi5
	TXT7wCB/F87yxsygEFZGnZ+L8TceExE8cotOWyNTADW9Hfx2MZwqBjnu39ZpX3bt
	A0L+aBkuaxLYyBpssKHDwyG6d2I1qK4ttWGlm71bcB6vdQWBJJsAj+GNgATVsPHw
	l27BGzDJAtq+/rR/oNyO/nTvFvjjARru6PKbKZgw6WqofUKQcr2x/Ud8ZRzIaaaX
	qhHcS+UziN8jfZMncmKEViL/li2ZUvD1U/lliPEAhUoUGIAF+9r0OCY4Nub28eaG
	fqDZzekn6WLUt8amT9bMV72I/xUF4yL8v+XL7HdkHWISQuCN0sgb7Hwjn/r1rOrb
	+wmJqw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gde93bh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 10:36:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so1162976a12.1
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 03:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787308609; x=1787913409; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x+/TUZQqtWMcSQBmELloooyymV8cy7fWHjTFq4Y7vHE=;
        b=iuFh0/aHCH/VZis1rWWq5lCBryXfKnHDlSNkBa7UXBtlqYjhicTB0ZCibCkCl0Sw00
         CV5HKwyXrbNNmGB63zOTkAuIwJI1haY+hOkQoyP9BWPfhaDbRHQXNWomX7LLTYJTawfi
         fkLp35+QrmIxkJhpj1SknpPFQ10w0ALy6bJwxA4BayNqgDOPQm1CAWxhuuH13u47hHBD
         ZyprxPYLDAlgkdlPe5rCGSt3AW5HrFuvbSsxAtmiDcWjaoh7vbI5PyyrHIiFdOgRhxjU
         jAyVdnNgbXNHoHev4Jig1Cel++b50dLypfGoO/v2jqr76YnGhmMvllRW0R90S2yx2wTN
         G/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787308609; x=1787913409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x+/TUZQqtWMcSQBmELloooyymV8cy7fWHjTFq4Y7vHE=;
        b=VvaSuHD/ABujMU4HmUxXeKPqwYLD0zpRVudLF9ROTZx/Z9Bwyt0EJnBM5NoVs98XnR
         xzUG8elTIzi7Am5NEUoNx2eWwDVmFI5baFbyCJ7uxj9OQXToV9OBAk4812BbRbMjHi00
         5wfI0PSELqPXnb6Nenom9osvOBmrrUVLoemUnjiJ9r8vY8vU5lZCfFOTIIV9eMsZeFJj
         4iEa3lIe0eyn/CeRNoJZkuUMD5bMXVHMZDe/Nn925crsyISxeWjQOH0ZsxckoZFZF8qc
         Ud1rdHlGP6TMjcGZQJbD9F5IqZzmsQuI+WGtAlsOy4W7kiFLRKuqEBQP0Tz7HcjBp+6d
         MkQg==
X-Forwarded-Encrypted: i=1; AHgh+Rp840LxSDcAgUuVND/OlMXMdKIwpSCCOYVParT59H4nKw1FPhLhQCoiUn5sJE8jzU6SuveQY4ffLv0=@vger.kernel.org
X-Gm-Message-State: AFuF++kKI3p2if/CLLTuovln+hQH+1SO/hhQN6OloR/Knir4Q4RcclNj
	pGo+BeKDAHwFyir4lGl9zPF7i1jSGjbzeH5h9fo8AOj6ekrOvGrEA1swv6E/K6SVVgaRy65RBBg
	DI2yp9YuuEa7jYBWrhOrsl2tWC1c8c/EA+Rw13K0efgk6qA7Kf2PvC/7edr3aPcU=
X-Gm-Gg: AR+sD11PQNfEyi99EZ4tSFokQTxYyyeUhdxd/jBjJDHsrWYVAxdMzlfBEp8ANlg3dWT
	QGB59g9wzBUlIYlsJOtJsVfCntTe6B6y3ogF0k+gkv1qy/tm7UU5Tn8iUSGbbXLqXr2E9y80FuI
	WmNyqZ55UVjg1jmwFihlmBC6ypy8tIZEKvLAe8oBVnC77H7lsw5L417JFqqgOQAcYFD7y+FNcPH
	wmS76hYkoiLMzJJPTYULuG65c033H10R8I5u/N00wZnEPIIiN4vAxzlP6iobPNt7ZAb5psoe56o
	mI7CDNpyammOaxW1mR05vSPmpBk5WfOzEH6U7TxnbAZyYEq3fMX6v5D7wWDJHj8dnkI/kfAtVAS
	tqqGNHF3RyPksX5XwKGke80GMMHXcjlBPdnxkRA==
X-Received: by 2002:a17:90b:394b:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-395c384d95bmr10132146a91.14.1787308608493;
        Fri, 21 Aug 2026 03:36:48 -0700 (PDT)
X-Received: by 2002:a17:90b:394b:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-395c384d95bmr10132085a91.14.1787308608069;
        Fri, 21 Aug 2026 03:36:48 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c467d907sm2662874a91.7.2026.08.21.03.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:36:47 -0700 (PDT)
Date: Fri, 21 Aug 2026 16:06:39 +0530
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
Subject: Re: [PATCH v11 5/6] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE eMMC nodes
Message-ID: <aogqN5IUBvHgmpoG@hu-arakshit-hyd.qualcomm.com>
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-5-1cebc8b3275b@oss.qualcomm.com>
 <d8fd7888-cf7d-47e2-8e77-3ba705c88502@oss.qualcomm.com>
 <ajjmXMKdWzae5qqk@hu-arakshit-hyd.qualcomm.com>
 <dcd6f0e3-46a6-4f57-b4a6-0b9362b1a8c4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcd6f0e3-46a6-4f57-b4a6-0b9362b1a8c4@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=BcroFLt2 c=1 sm=1 tr=0 ts=6a882a41 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=jk3V8XEzhubCWnqVx50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: km3i0zzAw2uQTRyndjOwxa7Nd2tCOj6a
X-Proofpoint-ORIG-GUID: km3i0zzAw2uQTRyndjOwxa7Nd2tCOj6a
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3OSBTYWx0ZWRfX1QcG9R68DbdN
 ySYKHMqOsfy2d/dASFCt6mncwJp7FwL+n9MhAOs8GPn6QW+Zq+pgvQ3/bezNzdkxyxLTjQEan6v
 ADLz3d7t3scYzglwOTOvI6XK8YcHG+M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3OSBTYWx0ZWRfX8JMp2vh6qtOU
 NVuZVxPUtrCeym0KIYA1kpWldHz7brYa0/XiDdQ3LQRCQj1O/PKLV/Yem+1+DLXXKoJYqamJ12m
 uJPnQhP5CVfviirMhe4bFfS0D1g3tLCz8KoiMyzq4Wn81w8HSVZcv/Pa7E5bcoNoNa9cxqYeIZs
 X5lQQeQ/NDx6n27BleMoJR+ZNVJF5U0OjcV3PZ+qCV3/r9HPy8pSuFMoB6c5auESQSUbXqpcglG
 EMpFqP5QGrIQxFvevQRPljpGqnjq/TkvSpZ0flaE8dDn1qAmSAVRdg9OLB0Ay/ATolcmls+iGgY
 GNbw3VDVswXqLw+qo/K/S4Fcrp4cQL4VuzUI0xJWZUJe1q/FsK+UX9HH95CLpJUoh+hWgLxgHZg
 H5JLIQzkSZu9pZjpRZv2qNLyfiodYvR8ucrnxdhPyvPHfu5MdjUI54ai0t6K+ylgyj/mVvF9zla
 WKgfEDuAi9dDCobDAmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210079

On Fri, Jun 26, 2026 at 04:28:54PM +0200, Konrad Dybcio wrote:
> On 6/22/26 9:38 AM, Abhinaba Rakshit wrote:
> > On Thu, Jun 18, 2026 at 03:04:57PM +0200, Konrad Dybcio wrote:
> >> On 6/8/26 11:47 PM, Abhinaba Rakshit wrote:
> >>> Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
> >>> an optional OPP-table.
> >>>
> >>> Add OPP-table for ICE UFS and ICE eMMC device nodes for Monaco
> >>> platform.
> >>>
> >>> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/monaco.dtsi | 37 ++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 37 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
> >>> index a1b6e6211b84d0d5008231c55613a0ccd61b9450..d9298d8b7874b8669b2cded2a28a99dce6eadbda 100644
> >>> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
> >>> @@ -2742,6 +2742,27 @@ ice: crypto@1d88000 {
> >>>  			clock-names = "core",
> >>>  				      "iface";
> >>>  			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
> >>> +
> >>> +			operating-points-v2 = <&ice_opp_table>;
> >>> +
> >>> +			ice_opp_table: opp-table {
> >>> +				compatible = "operating-points-v2";
> >>> +
> >>> +				opp-75000000 {
> >>> +					opp-hz = /bits/ 64 <75000000>;
> >>> +					required-opps = <&rpmhpd_opp_svs_l1>;
> >>> +				};
> >>> +
> >>> +				opp-201600000 {
> >>> +					opp-hz = /bits/ 64 <201600000>;
> >>> +					required-opps = <&rpmhpd_opp_svs_l1>;
> >>> +				};
> >>
> >> Since 75 MHz and 201.6 Mhz require the same power level, is the former
> >> OPP any useful?
> > 
> > Yes, both use the same power requirements. However recommended by the ICE team,
> > the DT should include all opp/freq supported by the hardware.
> 
> Is there any reason at all where the OS would prefer the lower OPP?
> 
> I think you at one point mentioned some dependency vs the storage
> controller's clock frequency
> 

Monaco UFS controller supports a 75 MHz clock rate at the same power level, as
specified in the hardware description.

Although both frequencies (75 and 201.6MHz) use the same power domain (OPP),
retaining the 75 MHz ICE OPP allows the ICE clock to align with the UFS
controller’s clock frequency. This synchronization is required for the
controller’s supported operating modes and can help avoid unnecessary
frequency mismatches.

Abhinaba Rakshit
