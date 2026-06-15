Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C8317177
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509068; cv=none; b=V+jciSwrCPJo/Hr/Fm9dicdc+o/3rawkIHWz5YdHbEos4jYqXq8IdW5FPKfC+IIKoYXtSGjJKf4PFbeWZKCD83SwioCPENlV/skfQJJOHxGoje2wLOhgM1mzFex6TfywGo5nr1qEWb8TyLKJb1ll1LJlWwMzwv3LDhJDIwl0W7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509068; c=relaxed/simple;
	bh=JNkDNEnXyRueWYXiUuPsYeB1uw+H5DfKndAs0vsPneg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUGx2Sge7WGe5XNewf6zbas2m5h8xHmXY3S1mwns9CZB50T1k1vUj7qaiY4l7aUNxUZolDCBLxzAy+pkz1j1pY0OQj5Jnmz9VnkQZ/5e+kaZNmB4XRaWwfN07o9SrPIjVo4/OoT73kAgUopN/Bm1UrJ/ErEi4deNFFtFzjjsU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdLwKuBy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kZtwnw0j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdLwKuBy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kZtwnw0j"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6KbLv3709710
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 07:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KA/kjF8FvreUrlkAuGn/Suka
	SvADoi6dD6lgMWfNLEo=; b=cdLwKuBy/TwyFfmmzwAZb5TGI4uatcGyNKp0XxcZ
	Kk2OUqW/YUTGMGLX2w4T9gv2LI8FhvQUCKyYTaWLubMJlYPnwK746UDjPtGZil/Q
	nN1xao5iszS8q9BX98J4mRqOrGti6QJCuFucjAl4i5t3OWHgfZmTIytKFplAa1Hh
	k5cgr4RUVNoK6MV7nYqt8RmSVM7Z20VivKQfOy/Q4Y2h/sT6rRqXqP/XeHwuXYLx
	SglQgby5gW/GgymTBnT0SCN2wSM703tQSn0oC6rRrgMb68vTY8yPX2MgaaGsWqpx
	ILcc6SySpUcWNTmaWGflTdnYpGVpyD5bvBiDpP1zxXbOLw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery9567r8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 07:37:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c85a2cde332so1420119a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 00:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781509064; x=1782113864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KA/kjF8FvreUrlkAuGn/SukaSvADoi6dD6lgMWfNLEo=;
        b=kZtwnw0jXWLFmoHm/lWr8FYHcBo6WrkayfQAP+xkRI7hhEzERZ59VodMtUXuYm1huO
         eUABF5Ou437Djo9amxavpGMssHqdFDhNyagkXLRqjHa7XEfGvTNjofeeDe1wFlTOczkr
         jIyStBbGfW8UgMz9fYcPB9hW2a36Jv9ADhVHM3gA2vaLrWsUkOX0UhII+F1UzX/skGJz
         w8hclf8R3N6DqmhyQQvtoj7lTu2BTiM5KNxZpEu2x2rWckeT/Xyjy8uGYdr2AAsSM6Hu
         iLeanC32uFH3z7Vex/Gmo0pTtUQcmGY4n9lXp8s6f4fR9s85qGuqSMh3H/jnWhxEnUBa
         i+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781509064; x=1782113864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KA/kjF8FvreUrlkAuGn/SukaSvADoi6dD6lgMWfNLEo=;
        b=FQpMt1iVezBT6moMKtdXsNVbIkyDefb8L5S1ZujwBFYgKgF3g/aW0htAHQ+YEnSFRd
         xxvHl8+r0K3hQb8/R/H5TuhiGgvWFPJDdzlSGoc4erlSE4ZIa/CALOsmJQ+S1kqcoh5r
         6svPYIeHwiAzr/a5mL+5MLJP9si/k6aSSidbbHMw/WIhqZUGeU4rBVYaLfkgbq2UoBxJ
         Aplf3xTP4U4A7Oo7pVlOy58YXWUNZ/j48Jd6sJaxA7xCClcuue53yHv9BhoGVmWhthO8
         OWkSyOpHQ6YhIr1YHUC3O3ef/ARWZFBbwjmdHBMP1DLozRXW6k3myFl73erI/ZrvQPTq
         Xu9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+4pVtZa2Dov/BuGe1LMpp2qmPq8atF7KMrVKE5i3ukQY3x0GQdG4GImxa7/4AGO02PpZnPqUOSoP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlQRTUo8heD9e339ebMqGoWql6/cMP6Fu5hP6QJnGD9GG4xfRo
	CeOY1h7LBJ+M113gNYY9wEffiRDSd2Ff1SnumxHlWhqMxRPCKt7eeS1XZRBZgtBwIs2GLZPZJOK
	VabBJz7n/lU9SnsuFQ6PDQ8oP0cbHD0kQAAsVqzbw61xSPs5tAC5par9Wg6xiLWM=
X-Gm-Gg: Acq92OHHxMIC0zHs23n6E587iJKG7lsE6HVHIOFYnzGQpqPrSPnKPR2VXyo8WYdmNKV
	YTlhQhlgNPboGlif8kXgFb3q6TKM1haiyZAcO40D5ymOJ6ycmGABTCOCjqfAsNka+c1Iyu3K/G1
	52zA4O7OrwFjYbhbQ8W8Mh+ij/HbzJvf17iDpplSLH2lukZIeyB+CqBPftGyERh13Z8/fG/7aVB
	xrE0iAjq/5MZAqPJEMV55MIph74sCl/6g0qbfe7jUIhyLETJYUA7ZSFLbkjwSSkHVac6JLFE/P6
	C4iFRHZloiPYvx0WCWZwV6/TNZqrV61eP2TrWGigNNOcrWJq/QupKCpiXTqxpXJKG6tYINI3h0J
	xiMjGzzU6Ex/Xz3E0cGCG6kaDLUvHIry9//Tx3luDe8iqYUm28yVbYcGo
X-Received: by 2002:a05:6a21:7807:b0:3b7:9c69:99d8 with SMTP id adf61e73a8af0-3b79c69b373mr7696090637.2.1781509064024;
        Mon, 15 Jun 2026 00:37:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:7807:b0:3b7:9c69:99d8 with SMTP id adf61e73a8af0-3b79c69b373mr7696058637.2.1781509063593;
        Mon, 15 Jun 2026 00:37:43 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434accac96sm9860782b3a.14.2026.06.15.00.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:37:43 -0700 (PDT)
Date: Mon, 15 Jun 2026 13:07:34 +0530
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
Subject: Re: [PATCH V1 0/2] arm64: dts: qcom: Shikra SD Card support
Message-ID: <ai+rvsUsZts5o0oL@hu-mchunara-hyd.qualcomm.com>
References: <20260604122045.494712-1-monish.chunara@oss.qualcomm.com>
 <hpvnpq2rx2axmtxmk2y6tddeo42ohvd4ae3z37lynzm5nug4vf@sg5ndaqfdlvh>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hpvnpq2rx2axmtxmk2y6tddeo42ohvd4ae3z37lynzm5nug4vf@sg5ndaqfdlvh>
X-Proofpoint-ORIG-GUID: xmYpBuS3qbxVWf1xWoqSf-wiqpWiCmHr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3NiBTYWx0ZWRfX44SsxxQY23NP
 SG+XCCYqPRDWp40WepsHavJ957PdmSuBJeTRm9ji6NLUDbmR3E7CL7Wi7YhvgD/rD2gwl+9dT1X
 pacIIcvyvV9UtWBpZ6WZZebHf9SVAGo=
X-Proofpoint-GUID: xmYpBuS3qbxVWf1xWoqSf-wiqpWiCmHr
X-Authority-Analysis: v=2.4 cv=EbP4hvmC c=1 sm=1 tr=0 ts=6a2fabc9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2VYifEciZLNaiyXlYSoA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3NiBTYWx0ZWRfXwj9EDgw6uGA9
 4V2NU0SZqW7ztzuzdAVWnuKkGpjegOSodaQQ7BA/R+clfDsv7idUgot8lx+jBj9bYbBJHww21qT
 drszbIJ/ndFASUB4KREVbCVJmzLiOA4FzMw2IsQV5Jv0LnhmNY6pryfcosUjbEUut10udHkMmb/
 EnECxwR26LOPIDhf8Ml/vA0GEQGwbv7HKocJYhjoHAv4cttGSR0nPLvtG3IkpG0zENX3QtBp8wl
 z5wAF8ETR0QztYHLrect06lvww9/JNTH0sTny83Z9ALCh4wvqeyKmvVpnAwmt5735pDSzIlmPWE
 HysQV9REwE5x1m6Pfp6it3hOnvzXBY6/238yCcGc6XRq4K7rAW8S77oUhyyVWn+6Oq42Q3oWM2v
 3g/V4kbupvru09+5Vl0Mo9LY+em5Im34RRWzo9IMdv0MqMBNw2WxFg4wW4ZgEnQRUSNcAwYYsIh
 416InasAfiV2NJ4UFcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150076

On Thu, Jun 04, 2026 at 04:22:42PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 04, 2026 at 05:50:43PM +0530, Monish Chunara wrote:
> > This series adds SD card support for the Shikra platform.
> > 
> > The first patch adds the SDHC2 controller node and the necessary pinctrl
> > configurations to the base Shikra SoC dtsi. The second patch enables 
> > this support on the Shikra EVK (CQS, CQM, and IQS variants) by defining
> > the regulator supplies and the card detection GPIO.
> > 
> > Testing:
> > - Validated on Shikra EVK variants.
> > 
> > This series depends on:
> > - https://lore.kernel.org/all/20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com/
> > - https://lore.kernel.org/all/20260521-shikra-rproc-v3-0-2fca0bbe1ad7@oss.qualcomm.com/
> > - https://lore.kernel.org/linux-devicetree/20260513-tsens_binding-v1-1-1780c6a6caf2@oss.qualcomm.com/
> 
> And how does SDCC depend on TSENS or remote proc?
> 

Added the dependencies as per M0/M1 series. Will update exact dependencies for
SD card in the cover letter of next series.

> > - https://lore.kernel.org/all/20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com/
> > - https://lore.kernel.org/all/20260522-shikra-cpufreq-scaling-v4-0-f042a25896c5@oss.qualcomm.com/
> > - https://lore.kernel.org/all/20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com/
> > 
> > Monish Chunara (2):
> >   arm64: dts: qcom: Add SD Card support for Shikra SoC
> >   arm64: dts: qcom: Enable SD card for Shikra EVK
> > 
> >  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 ++++
> >  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 ++++
> >  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 18 ++++
> >  arch/arm64/boot/dts/qcom/shikra.dtsi        | 93 +++++++++++++++++++++
> >  4 files changed, 147 insertions(+)
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry
