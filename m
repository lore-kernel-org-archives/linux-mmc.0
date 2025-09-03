Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE31DE4FB
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908940; cv=none; b=l1wArP/aAFsz6IODdVuknZUqzVY7XIm3+Xg1ZKWFgU0r0E4LEBx/aDpjSsBoovwNSReD2p7BGG00CWnmXSPFJ4HhOoL9jUGUKqqnEzF29xd551fuVoyxlpCUP+YAs2lJ5YHWo8Sq57FU8zkvFWHAzwwU5VzpiBWCnNMlPtao9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908940; c=relaxed/simple;
	bh=HQXjdiIWY6GV0ST39+EojeXyRY7MXzjWNNCvjujQ6Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwF7dlOYLP/NQeirYzcXKfbpDpvkOJSCdT3Z4w/Z207agGg9cfoA5j0RC+nmYPQ2HZi/8jYr3Wh8jFY3G5/Q+eyc4Hwi6sXutdnrsu7I1/h7LZ85em1defEa9lgJQ69Wnq6E5nKqI9YyJOCgKsR1P3At6taUgPl8QupWNc3uEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l9Pe4LlO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9Pe4LlO"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DxMKR004224
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 14:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0VzNlel62yPa+SyyPLg/se3d
	IslRaGTpf2G+ejZAHH8=; b=l9Pe4LlOnoJ7lcxOaTdXD1cd047A5yETSUzBKRe1
	FVMxnYUuITdqVMGblNqGWiVr4Tgc7G5P0EmYS/AfBI+vGnosTAPDZ8m3Gfx3YnMi
	lK3cRRh0UaUtcBgz+r+UO2qmoe4CBC6htGghMVkfFe3lt6Y0kNINsSk7LKUbGAiT
	BFyc1nnSZz4JVJfFd61GndKLbYtJKFY9uoLZ20Yyz/XSDVfVzfF9/Kq/RfII3tvH
	6oJUHOTxo1lJhi8j3cBYC2q2N2zVhiw/6Uqn8lIP2/FWWcn0uA9acvBGfXF6wgoT
	Aps9MBcN+Xn9vHhEMTL6Z6vC/++J8x0UHT19QIHYC28tPQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8uvvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 14:15:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32b698861d8so607470a91.2
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 07:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908936; x=1757513736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VzNlel62yPa+SyyPLg/se3dIslRaGTpf2G+ejZAHH8=;
        b=Z7BeABzTqxuzoedovidALer90VcfP16SGsNS7aSwYMyMHIu3e/ZVXpkt1Iz1ZWyp33
         DA5fhrNJZxQNLjV3COh+D+g7fABpViwfObJo3xDk7MBBeKJWijURQaXatKmSlxW67Ryq
         GR8qXvDaMo3ospfp6sKkjOBICH/YJ/sLmy/R8DoRYRLHNBzZQlkKrPRP9r1qj/tJKh+G
         JJACLCeWuZUmoQ+3C87/wzwgfl9ei82zkkRy8e3mhJ8ZAd3ukMnYqyBQgvqwMa2gGWNZ
         dvw5M06DRq5i6fLl+cRBH8eN1lFXsJTrQPfsjw1GUfrKAJ7kE3OoUUzyqNzJN7keJI45
         eXBg==
X-Forwarded-Encrypted: i=1; AJvYcCWULQ3PhvByXHqhqD1hfwPqtqa0EX8U5HEd8CBIs85O4HnYsNffctsnuXhw7YN5cQ5KFD/19fA52ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+gspqymRguyoLKA2jYVpWe0qGdo77buioCEbg7A435rGEzxq
	mcG7637PP9xugL+QPROxXRNRF4yaQ0OTTpAn3a8h4XwluG57SKY2R2FcrYFJ9usb3V/lBFEwG1W
	hzyLbUN/yjBw/1eO5m7Dc+cFo82w1gDfpbqwZQvyvsTBQwJegqh+unLMRxsd1BuQ=
X-Gm-Gg: ASbGncsSZtxDMJxadkfUtPlzbphCeOx6mnFc3nrMVBvzkq2g2mtk9HlLzzE08FxXGtY
	eHfPwPP88X13tGsqj+0nNdOZcrK/mf/4lQ2hQAkXRdTQRiTKJqn/1JgRiQsL5BfQMshp7P9PKbs
	IgJBPTLJkFuJS45xkBVkeTL0xH0c9dC+k1aRx+u7bNMOi/6KKuOMJ8uF3Mhj/lERJi4nUcdJeQx
	RWI/ThZBjSMlyS0Zg3QhXig5ddyvdDdSt25Rb2tu1sKbnNGzzdY9yq2C1Zw03pX3ppetoPXyoyD
	+VnqRveJgQmCYJ9oOjzgk+N/TP7WYYplpsSBOc226notbOOQ7rlHbnPib9jHgIRxiPzr
X-Received: by 2002:a17:90b:570d:b0:329:f535:6e3c with SMTP id 98e67ed59e1d1-329f5356ef7mr6857476a91.35.1756908936215;
        Wed, 03 Sep 2025 07:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyr3tjnshT//538kzr5X5b0VHSeB28iN4p9ecCqREiYD9oSxtfYFdYbnWB2PiVBs2MwLu25w==
X-Received: by 2002:a17:90b:570d:b0:329:f535:6e3c with SMTP id 98e67ed59e1d1-329f5356ef7mr6857406a91.35.1756908935730;
        Wed, 03 Sep 2025 07:15:35 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329f633749bsm4435336a91.27.2025.09.03.07.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:15:35 -0700 (PDT)
Date: Wed, 3 Sep 2025 19:45:29 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v2 05/13] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <aLhNgQJtimNmiN31@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-5-bfa381bf8ba2@oss.qualcomm.com>
 <olv66qntttvpj7iinsug7accikhexxrjgtqvd5eijhxouokxgy@un3q7mkzs7yj>
 <aLhMGqYGzabIoyjS@hu-wasimn-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhMGqYGzabIoyjS@hu-wasimn-hyd.qualcomm.com>
X-Proofpoint-ORIG-GUID: 8mw5c8Jc2rDqj6S0ZpCV8N3WKqveqygJ
X-Proofpoint-GUID: 8mw5c8Jc2rDqj6S0ZpCV8N3WKqveqygJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX0h9WQ0r+21tB
 nTszkydbnjt454OEKmxOxd4U3Gq4BBym7QvJHRmN9+SI1owrV7u5tjRJMROS6DCpLzkpHSDkIZt
 j6UYY+7Y6XN/cTe7S9tC/hgl4MQKs1gHlzmE0GmY9bbfTfdkY+D+FeYQ3udjaqG9xcfbggBiYmX
 rwgpwQrUyJ0169fkMjWkALRTTM+7i0veaI20udhrCWMxCjRnANVudLQBBvoCW/4TFB/4ygVS/F9
 J9ahToxHhmmAi5rH3WWxFHqA8Ssq0gzuu7Lg2Icya8aPlogoPxHsljzx84gHWpC/gV6uvZFYL43
 NMV5jXRRlRbR/aw5WZrZrgIJBEngFdGgqx3hGxqutbEjCDIFnALGZrSH+Us2V5+RjYLbmRv//4x
 lm3/AXtk
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b84d89 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=M4mhlKS_8liedgrrcqYA:9
 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On Wed, Sep 03, 2025 at 07:39:30PM +0530, Wasim Nazir wrote:
> On Wed, Sep 03, 2025 at 03:16:55PM +0300, Dmitry Baryshkov wrote:
> > On Wed, Sep 03, 2025 at 05:17:06PM +0530, Wasim Nazir wrote:
> > > From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > 
> > > Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> > > interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> > > DMA and peripheral communication on the Lemans EVK platform.
> > > 
> > > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > > index c60629c3369e..196c5ee0dd34 100644
> > > --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > > +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > > @@ -277,6 +277,18 @@ vreg_l8e: ldo8 {
> > >  	};
> > >  };
> > >  
> > > +&gpi_dma0 {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&gpi_dma1 {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&gpi_dma2 {
> > > +	status = "okay";
> > > +};
> > > +
> > >  &i2c18 {
> > >  	status = "okay";
> > >  
> > > @@ -367,10 +379,18 @@ &mdss0_dp1_phy {
> > >  	status = "okay";
> > >  };
> > >  
> > > +&qupv3_id_0 {
> > > +	status = "okay";
> > > +};
> > > +
> > >  &qupv3_id_1 {
> > >  	status = "okay";
> > >  };
> > >  
> > > +&qupv3_id_2 {
> > > +	status = "okay";
> > > +};
> > 
> > You've added i2c18 device in patch 1, but it could not be enabled before
> > this one because it's a part of QUP2.
> 
> Thanks for pointing this, I will update it in next series.
> 

Also I will try to update the clients in commit message too.

> > 
> > > +
> > >  &sleep_clk {
> > >  	clock-frequency = <32768>;
> > >  };
> > > 
> > > -- 
> > > 2.51.0
> > > 
> > 
> > -- 
> > With best wishes
> > Dmitry
> 
> -- 
> Regards,
> Wasim

-- 
Regards,
Wasim
