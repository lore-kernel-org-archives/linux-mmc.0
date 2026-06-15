Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C063BF680
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509176; cv=none; b=ivLFjMsI8m8sksu0Pt6w861gafky/47DmGo2UURCRStHlYxh63o+9TSfcLHSaePr4K/2NP18vqlWqzip2ome0FekAUXoB/H7rBTHq8QKOyqb0bmyiaVdAp13VbHqy1ME/Pm+08+ggsSQ0ASWTF33lCk2mltSCM9j+CLdh/R9zF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509176; c=relaxed/simple;
	bh=bUTD83Pf7C+H3yrldiYUl4te8DBkzpoeq4nNJbvHMsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnRw8YWLpFC6sbsMkbetsOzSKD4nb3bhO74GHQaC+g0x+uFzNsOEiM79AhSpKFAFGcyg0kZJ0LiIMmDQ6sOR3MgRdjTFm9/p6SJw/AlkDM4UbXhvChD3P1AnCjbNG4p5NlOi37q6QN/l4Y1EYn/5ocQ4Te4iqR29dIi67qjV0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZKvcTkAT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GyxMkTub; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZKvcTkAT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GyxMkTub"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6JMcV3333077
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 07:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UZp2CdAOzWMP9vNOOQFjfC/K
	5baWaymmSjQGLpC8WcY=; b=ZKvcTkAT4GvL5Yp5yQ68MYwSnHMLSIV4+ZgzzPw/
	kV6yJSNcbvOabzoUO2gowjOWsFamE/su+n08PAKzUBBSK8ev/KORO4upnF6IuO5V
	v7nfFBe+cYK6eGEwIh0nr6E2u1XPPFPy70l141hewHPUAhmh+SrY1nJM84FRJt9e
	qgDDJmqOfDCLBoJajA9LpMW7Cr3py5PDmAX2jqHotZ+OEfQXrGE0J/uuVCTEi54X
	kyYDRYQsxByTd2VF0NGkeL2/qmxex9Ey1mbkhm4/WkSR+kUZiAZSsR3evr1RJ8Am
	VaF0Pk+hwuGoykPBS/pi8AwGXlyPQz2s9LhXjvSzXUYn4w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4erye169af-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 07:39:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso2977181a91.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781509173; x=1782113973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZp2CdAOzWMP9vNOOQFjfC/K5baWaymmSjQGLpC8WcY=;
        b=GyxMkTubtGcwPtiinlMuCSgPDC9cCf7z/JjVtLgv6rwvldwa62VwYR0EHbBp5vTRmM
         Nn0tGj0d3Jo0XZT0c0Ptm1AwCc8xYXXAA1rh2W3G0p8C1C05FLd/8Kwzjt4SbQboO/3+
         grHtVflgRBEubeqwHI3sji/gZX4QXBVq+GT4pPnA6wiF/hBHgy0bd3VYe9rDUVrlrtVo
         L6prHE4FY0CCzB4QgUYayx/skB8Eqf/iFqFiAfeqgsnSdX5qxXDXhR42YpeSN16u1q8z
         ZepvFyi2Eg/O+SybmUGQBViUwwUtk4y8aX0qOOIY8VTxZ4kdLSTFL8sP5nftZnrkWS5B
         SgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781509173; x=1782113973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZp2CdAOzWMP9vNOOQFjfC/K5baWaymmSjQGLpC8WcY=;
        b=VIjbJX+xtYHP0zA8yOWqs8RUYzUZTJKOZPvcixBYDD1X319O2b15PEmTMvd0PkDmrh
         xkQN907VlAVtIPdeQLxyhB3kULilXDPJ7vqn75qk08hb62AP+er2bVU8J1quSAz1NV5B
         8TNluUmrcnUdikMZoxO9M5ULL5JiLhDXE2McwRUVO4u8hE1Y64e/EFPGj/ZMREB6ibn2
         AfFnraXJp+j54UKqW4o/lYrkWUUPyRxI5ALxnZ1s+M1zOBqQxAuD3wbQswQ7ZqMrz/w+
         jqTJjfZbbxoYaZ8Iuq3OcA9pwB4KZTiGW4EacaXsMW5qfl/sCcU/7kkfKMeaZX49TuVs
         UDNA==
X-Forwarded-Encrypted: i=1; AFNElJ+Fb8RivtxiBgFMjy3Fwp1XLN7mg78F5GQ+esgyJBi9XQlNO1/GRi9+4vjcYftbXH99wILq+Xqsw2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Wa5BxQxnFgOzRnCXC5QBxNq3DUm31ioiaSYwG2qEgbtUfvGY
	OFYOv4L5v0Gg6Bx/5j24cD3b/ujFep8mXWj34QIEQfvej3TJmASP4o8vCPQZ9eluy63UZgFs2II
	k5RWUeSNjxdtG8WW7AhK0seVvWhKt60bQbX6ZjQRkajJ4ExTKKJ6quAG34K2grVU=
X-Gm-Gg: Acq92OEguDTHMMPZpcSn//K+NJGN6qYVJAy8gr0qtZPSpGYhj83gzm6NgWSpEtbRx3A
	tmeWMEMeGBU9ZtxGjRbPuEby9Pg/D2w5I2YicSkF94dIPq0QOWrpTIvh7AgCIXL+psps7qUsaFM
	rjEp02Mpv0iM5M94GulJVIafxo1XW7G/w9JSLHF/gitYAyRnNJMKwvQOvPHnUBv3jq4nHyvvCKx
	dLxLVtbcv8lrcZ2++DI/CyL+gQqdv4QT140MYrUSz31taA1/pJ2Ullddmo0vFx6QA8Qzo0Y9kau
	mhhtk5q8uJTSjWH56oM1kPFkZ5diD2yFnBJNpMmR+cRIBdAZabMidqTEOSA43WLPSTy3+gzj7DU
	GjejoZ8xrawQWMe1vSI2HJNwGT510Dvt0PRmIu+eBMgLeSQouJCUWyPxF
X-Received: by 2002:a17:90b:3f43:b0:36d:79c6:1562 with SMTP id 98e67ed59e1d1-37c2bd7e8d6mr10389165a91.25.1781509172675;
        Mon, 15 Jun 2026 00:39:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3f43:b0:36d:79c6:1562 with SMTP id 98e67ed59e1d1-37c2bd7e8d6mr10389142a91.25.1781509172228;
        Mon, 15 Jun 2026 00:39:32 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a25ecd66fsm12016278a91.12.2026.06.15.00.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:39:31 -0700 (PDT)
Date: Mon, 15 Jun 2026 13:09:24 +0530
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH V1 1/2] arm64: dts: qcom: Add SD Card support for Shikra
 SoC
Message-ID: <ai+sLLCjdWQt3NOC@hu-mchunara-hyd.qualcomm.com>
References: <20260604122045.494712-1-monish.chunara@oss.qualcomm.com>
 <20260604122045.494712-2-monish.chunara@oss.qualcomm.com>
 <gq54nr2bzvvqkocphvkji7g7rhbsrngsno7gvsfl4nsfvakj2a@wsfsnohrnscm>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gq54nr2bzvvqkocphvkji7g7rhbsrngsno7gvsfl4nsfvakj2a@wsfsnohrnscm>
X-Proofpoint-GUID: aLQ81E8viIHyduQv3beD6FVrcrYQo48U
X-Authority-Analysis: v=2.4 cv=MNlQXsZl c=1 sm=1 tr=0 ts=6a2fac35 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=wlKiXeHTwYhgOVykP0sA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3OCBTYWx0ZWRfX6n2KBiKHKgBV
 /spktfskXW5/Ko2fKGS3Sx1sm4jdaK/lktZE78uN0wu13fbQvOl+megBu/0sJ3B3p2kqs/WKvv/
 wP2qCDNKEW3qFPXuV99nItxYusm3XcE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3OCBTYWx0ZWRfX42aJo/jtPWM5
 NKP76sPR8E94EyE9Z6H/EIFS+k0j6mmmYMNuPOAUxeFMI5GqKR/7VZZFbtHidRo9d9ScEoDBb7g
 /CHyas3SF71Ae8Viz5CQLGkWB0xy7pGk/zN7ZxAp7+AEPY7rg4mmM3sLD8Mhi9sJxsnihZAMvCC
 5STYU0GISTShWM7jhWHa+I+iS9SLflpJztCGDv6xZVVYX0uHXoTAptLqezEju1PFwcotFdhC6lV
 GoqzmCarPTao5bzQlZOuPMDQ+LjUTBsLhNNLj+0yUgyD0AxhZYosasTUnLkfMTYy9oSdwYYIS2D
 PrjuHLa8sfWTmb6l/gfBPri6M+VPn/15EES8hz9VbDIeyAc+DXp13ZaHhOI3TXyl4OpUv9938NS
 CAZcdvgsYgoP0zVkTBy3eXDrcvY2hxXGtpOLBEjNdoFW/p+fJncWpkJJxF0FhuMNq6AadOdnQGs
 l1odmK+ThPsX9teCBSg==
X-Proofpoint-ORIG-GUID: aLQ81E8viIHyduQv3beD6FVrcrYQo48U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150078

On Thu, Jun 04, 2026 at 04:49:59PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 04, 2026 at 05:50:44PM +0530, Monish Chunara wrote:
> > Add support for SD card on Shikra SoC and enable the required pinctrl
> > configurations.
> > 
> > Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/shikra.dtsi | 93 ++++++++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> > 
> > +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> > +					 <&gcc GCC_SDCC2_APPS_CLK>,
> > +					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> 
> Misaligned

ACK

> 
> > +			clock-names = "iface", "core", "xo";
> 
> One perline

ACK

> 
> > +
> > +			qcom,dll-config = <0x0007442c>;
> > +			qcom,ddr-config = <0x80040868>;
> > +
> > +			iommus = <&apps_smmu 0x0a0 0x0>;
> > +
> > +			interconnects = <&system_noc MASTER_SDCC_2 RPM_ALWAYS_TAG
> > +					&mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,
> 
> Misaligned, make sure that ampersands are at the same column.
> 

ACK, thanks for pointing out.

> > +					<&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG

Regards,
Monish

