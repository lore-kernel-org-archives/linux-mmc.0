Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144FA2C026E
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916127; cv=none; b=BZYuivaJqGy0JleVChe0G+9Lbq5c/TWKFQ1ebQp/Rh12YFXGMWJINoHPEW+Sf4it8Sn9ErEdXykdaB+qIwDkE5t3cwqMjhStTMJeZU2l2EwPT8sxra4OPcGApbiarjOq5OBAKXSXZhLUWONQSo93CnUQoxZAYs+2KudJNbZyFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916127; c=relaxed/simple;
	bh=Aj/h6m6u4l7cbXvG79uFeWtqptowi2jhB/O/8KjO2kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot+h78dzrO9bpp0WXruUmkSsKPcJyHBlvAgywLpnFQN0RaLo88/YAlJ6bypiFZgPIGS4KCTexwghblBwIQruYsak5l8od9LqPja4wJ6BrYm4GJO2slv1CDGZP6rDD2GOQfmcb8AXSlUtHRsqKJkZteQBfw9q5+QY6EKObbjwKiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fLUzOymx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fLUzOymx"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx1ru032621
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 16:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PV8I53amMsdpCAWkiS8+8Gie
	vBsDJmqsY8SnpNsX1Sc=; b=fLUzOymxa1pTD013yhxViU4+oqpHhqhdhbTpnE0W
	BKNmHbmS1OA1gChpfxz9CF+iGkqu9lE4eutE1xt61E6DU2Lu1p4dDhnCCEATU8hh
	W+YX9RxUoiZnoK8LS7iz2o1RMXLTGDpHBXoOcu1qoB7wjUgEaCi+LhFe7Fr0Mw9C
	YcU+/wylo33nymbEfC3ddPxMaEbPWjoXa1Xoa1v4TX6i7a18kYO+NvOHDGqLpDgc
	ijtftlnvqdkIwwiWtjIBOVu7VkWU7whPUB6yEidUljnLgxbaCwLFXdEyXaS/Llix
	KzFrW1pBgV7p6hkhw/ofXL3GHi6P8kRD0T6W3edg4Ujb5Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush348q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 16:15:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7724487d2a8so104050b3a.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 09:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916125; x=1757520925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PV8I53amMsdpCAWkiS8+8GievBsDJmqsY8SnpNsX1Sc=;
        b=VoIvULUYKRqnCQBF//rZ/Sc+dhy9Uha0O9Wv0O/JNaS58J3gQkjbt44tsE09werdSY
         PbZr4L0KR+PKaHWS/KkaBZgUDznKLdfHZfBDG+EGmGb4KP3bOolkaFt7kpaQBF3LTi+u
         9PKVoP3w4Aohpdbmejx4pbwei0uCnyGC/BDer74Bvq4SSVilIKsggIjZvfTkRO4XEITR
         Ri5wGyrgdJn+YEUAGtXe97+722kgIuZG26ItRIblqBbHe5M24USo7xioJD4CowjT8LD7
         QqteF6m3mFmPztgFGN52NO12pUrw8JTUoa3sYTHlHthlxvHZm8zLqPRRi8PERqDve7RS
         xXjA==
X-Forwarded-Encrypted: i=1; AJvYcCWWcD1Vva7UxG2JELufJt/LUqo/bwYpE2vUTMJA0lC2zEx/JVfJIrldodRgZ6c91FspY4MpOhPxlJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf54EsMhn6oiSMSYz6YRdWi3F1SjggRkKZdDfF2RzvnxanoAMu
	q0VLodJi+UOM97AYGLDsq25AJ1cmbtwUkmia0ePAmXXiorGZFbH8MujV92sOG+zem0SmlAVYsvi
	hmq4TbspzBZsNqHW3AIXYqpZfo8G6BmMlHidEJk0HkA6N9ZrI6t9Ivl0tZbOHaiQ=
X-Gm-Gg: ASbGncvO5/oY30bonWaRFH/bl41TQWY/oXrB5txVckI+mUypjT2U4mepv1ZaXKrdn+D
	HqyPjVlnBxi7ZTGsXaZJt/7/l2oxAr/nnxRbjPdBubFtIrLGyDM9kq+GKf6Pgm92fMhe+/AM0MY
	jpCj2ediabYK/DuwXoXTSvr5AKgB2DCq2EwQHIW7x1XZG+/iiBN7THeQVBmT02EJkzG0GtLWQuf
	wM/A0ZSYp1c4E0sZwku+Bjk1t+DkPIPGZSBcjQwHXmC+tA4/MnrNj8kWsV+AYx1LyWOHn7L14ai
	as6Yb1UwqFodnw1AnR6JjXZjzC2yZtUOzt4ZevsVyzr4IQIbSfepKI0JvNznmvzp8kW5
X-Received: by 2002:a05:6a20:4f8a:b0:243:fedf:b41d with SMTP id adf61e73a8af0-243fedfd266mr9715497637.43.1756916124647;
        Wed, 03 Sep 2025 09:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM5j7/sKnV77ewl35fCQ4KXYL+IlgEgwziqd/xP7B3RE++ZVU3ZpeVSYzTkVju3Z9dvwZsug==
X-Received: by 2002:a05:6a20:4f8a:b0:243:fedf:b41d with SMTP id adf61e73a8af0-243fedfd266mr9715456637.43.1756916124211;
        Wed, 03 Sep 2025 09:15:24 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd073f476sm14803635a12.20.2025.09.03.09.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:15:23 -0700 (PDT)
Date: Wed, 3 Sep 2025 21:45:17 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
Subject: Re: [PATCH v2 03/13] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
Message-ID: <aLhplc1XCWGNlnp4@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-3-bfa381bf8ba2@oss.qualcomm.com>
 <bbf6ffac-67ee-4f9d-8c59-3d9a4a85a7cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf6ffac-67ee-4f9d-8c59-3d9a4a85a7cc@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX6UiEvluY2qjP
 5EsiIUTYfCbXmXqk8B/j+B5b06p/fDEXjyO/vpZDhFE4DMN8MPFfw5MSFcEZxoyXttHntjy8bwH
 1THeM2CEIJfg5gUnwpolziogeljqvEQQaw1nTGw2fxcv9NfUqQgP45RywNzAlD+JGIK78NZuYBG
 RMUcPLe+ROtxc8+tqdYJbgMV89OPh1SpTzBqbFrQDneKYU9BKrEbFn29E76PzUcrVVYC24wqZ/9
 pq7jinDYD4ByJFgrGgjudwmYb6bf0uVxTHrei+YWpptWReMs7tvPbES9tyL4VfxLDgsHyOZCmtv
 MoG7iILeoeepfhZC966q6d7EKqdWNDCbvIvfWLSatOzBmAP+j+G706hXpSR4MrdvcuCoRTiviDd
 R3Y7Mkio
X-Proofpoint-ORIG-GUID: vZnVIJ0i_jA90Y0GDdxfFqlzbfQucRgR
X-Proofpoint-GUID: vZnVIJ0i_jA90Y0GDdxfFqlzbfQucRgR
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b8699d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=mdWu549IrBN_hmWUEDoA:9 a=CjuIK1q_8ugA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On Wed, Sep 03, 2025 at 05:48:56PM +0200, Konrad Dybcio wrote:
> On 9/3/25 1:47 PM, Wasim Nazir wrote:
> > From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > 
> > Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> > GPIO lines for extended I/O functionality.
> > 
> > Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/lemans-evk.dts | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > index 9e415012140b..753c5afc3342 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > @@ -277,6 +277,38 @@ vreg_l8e: ldo8 {
> >  	};
> >  };
> >  
> > +&i2c18 {
> > +	status = "okay";
> > +
> > +	expander0: gpio@38 {
> > +		compatible = "ti,tca9538";
> > +		#gpio-cells = <2>;
> > +		gpio-controller;
> > +		reg = <0x38>;
> 
> 'reg' usually comes right after compatible
> 

Ack.

> Konrad

-- 
Regards,
Wasim
