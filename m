Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028A1C6FF4
	for <linux-mmc@vger.kernel.org>; Fri,  5 Sep 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077640; cv=none; b=FP1isSyjLqbCvEekvo3Hhn+LeusqgchJYLdmthRo+dEWdABeEJ5xsIeAysW9K64SOvnRzlpcQs+sOmiKovB1VlepNdrU/Ip5d76F4ACRS9f0th5I3QiwzwcJPxRvpyUQDDcM0883HbeZGdnWWJO+vi56CqGBfGjk1GQT9rW4qxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077640; c=relaxed/simple;
	bh=JsdLLPrUmGM8Tgv1FnyKp6BjjHIfVQSZbw506i21JtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKMcBi5QhQLnSWKhqiVhvmY1d1PmSsHCusLvihvOIUX9iUX4sNVNBG7WUc6eLOJgxG3J7q3G1qbWhVClDUeK5ZfnFYjrc5eR/kSDyaVDg2/pAubooBoCdAmOPOhD5JQGC5bpYQJL7mA4HZwtJws3YF5sm7/y6Uh3fWnijBP5X6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KGfTKInG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KGfTKInG"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857GZH5031853
	for <linux-mmc@vger.kernel.org>; Fri, 5 Sep 2025 13:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KrQKZP3w0ewlZNuZWmqjmyoq
	dp+JRPUq5JvWfsJm8Eg=; b=KGfTKInGLH016v/bWWLBLY4d0AWU5cpjdf1TzVMT
	LlSQIhkrXp03YU/0z+2IQ+1BmyRxGELsUmBwhj9nwXtkIKjmGxJc7CWgFsDdusgx
	JX3DvgR/W0KhH9iwOqQLJ3UxkwEdMj1Tz6MBKVDTTBB1iTAQ97stY5Y/szaA8zI5
	kiaTdt5l9ITkt1eF5gTuiWSqEv2TOC3twYKNBQt2WJMqJZovXcXBKw++nNqA6qBS
	56AHOEsNm/PaEbjHIGMUCLaFovQJLwABBEmwpkIVMAi2Ba8E4uh7mQHVJBIpmQ01
	6KdhKYZUmoV1C90nxvpKB8BnjPxmYv5gpFq4YFdqS7SJkg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw0b90g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 13:07:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329ee69e7deso2149463a91.3
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 06:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757077636; x=1757682436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrQKZP3w0ewlZNuZWmqjmyoqdp+JRPUq5JvWfsJm8Eg=;
        b=qX6b0f6PDvQxHoSSMh941i9yCebuSF0pEhRn+fP0gLQeL+LJZwRrv8Mi5HclhPnvzc
         pmvIagsVRI0l5SYxYsUveYuVYKRA4ipXsLnzIqh+0QQ06bQqc1J5EChbhXs5f1Ixq8IY
         3J+l83tpgFM7MhpLPBMspEWejsRI7qB+0Y8GaXmQvwa8WkMTIj8QR8g+VR3d4ThZaILu
         0zk3BJT/5TmB+O5tmExn9F8kqEqnGGsLfECQzTN1w2Tm2ffAHkOV38ohbSzcg+GB1ik7
         QuI3/MPzqNEw1+WjxwT4acPYGqFwI6tUJSbPHfGCD12vxjwZOy+ASU/Am2iJkxNfACLh
         BcTg==
X-Forwarded-Encrypted: i=1; AJvYcCVFblVsfUecOEiIkQuoV4jGuQXZGrYdkoVFSSUc/c4TeImwlStvzc7WXZxYPPtjn+6/NpaOfUQ3IgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYHinEjats9rLcAZaEk0gmtoLca/ZAorcUjRq+02WwTReJr/b
	vTuFQexD+4YcNhX/0sQPiKdImlMN2mNj7rHgpgML+piJObJ9c3fHDgwt0BMzksj0deNRHDLhr/9
	YlFSj2/7MVusfJseV3O4WZgdFhZ5K0Np41Hd9KN7/d45uGKjHQGAsat7plegMM74=
X-Gm-Gg: ASbGncsuTuz8HIlKRhus6iORcFUKV1qw7jgODkPJB7lwdXVoe9shbgBS8enaJWdgKNW
	B4gJeL9xwv1HPsSqLT/pL+whTvXc11LwRHYilKo7BJU7ZIuTA9+3m0FKqoPNKmREmGis9XYuKlo
	/jIe0V53lmgg9sOzpzRysSVVC4ZnEvn5hRdqwzTJuYFTrWBg3sG+EGHAXAMt7LkW0jwkTA45flN
	i46rGWt3gvhfgv+vaw3CPpCyKZnZRA4fccEQOCGKcwSSuuaVUUvQaLPF/TmyJ3vYoeV3tl+J27+
	oUf2cUV/wcKHDQPhbu/6DvpFhyeLYdFrAJpbEIzzNhD93Q/Xu4arGErfKys9g2eSQ9+y
X-Received: by 2002:a17:90b:384c:b0:329:e708:c88e with SMTP id 98e67ed59e1d1-329e708c9fdmr18453341a91.20.1757077636180;
        Fri, 05 Sep 2025 06:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOWdaNrn1TEaOULcrKSkZdESm8pCYoEw9CzGYfoVI1gFXNQjbHfv1K5YlHjOSkq90MCHN1Fg==
X-Received: by 2002:a17:90b:384c:b0:329:e708:c88e with SMTP id 98e67ed59e1d1-329e708c9fdmr18453243a91.20.1757077635494;
        Fri, 05 Sep 2025 06:07:15 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32bab2022afsm3689920a91.2.2025.09.05.06.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:07:14 -0700 (PDT)
Date: Fri, 5 Sep 2025 18:37:07 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 08/14] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Message-ID: <aLrge0QLmApr881B@hu-wasimn-hyd.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-8-8bbaac1f25e8@oss.qualcomm.com>
 <055bb10a-21a6-4486-ab0f-07be25712aa5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055bb10a-21a6-4486-ab0f-07be25712aa5@oss.qualcomm.com>
X-Proofpoint-GUID: J4d_h3ob2Vov4Yg5Tb3bgm3mv35Bt2UN
X-Proofpoint-ORIG-GUID: J4d_h3ob2Vov4Yg5Tb3bgm3mv35Bt2UN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX0eBeaFBt2hgv
 R+7/bUfT4Pns+U+kOUgz0c98i2T1kIgs47FSEdtL97mYnTHLQQV2Pvd4igFsZ9KHawjXjD/y7Xb
 icr0pMJZQPXBHca53Y3y5i/AxZBOmd6/HW2P8sAnV8egA25s5BM/Q/BbMUR5CA35IJQ/R3NLKmd
 CGi7d/AGD2OQvD8zT6mADlABViZKmAB+W8yTgAnHNLg7Y7AMu6Qf8O3nmo6UVh9cReQoQBOIg8B
 Lx6z9KExAFOoZz9CQ7mfQCkmF/hwqfyqDQF68J2Bz2gaOUke8K3wfJWJrqXgfu4yjZLukrVFIu1
 SJ3kmb+NoohThWLdNawOmGMkkHNuMwaoTBufB1qhZ3jGoGwgsGUTTksYNFhXn7lK+XvMXpMyHVW
 2vJyi5sU
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68bae085 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=CfLhDO45pqEqRx8ihX8A:9
 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Fri, Sep 05, 2025 at 02:46:46PM +0200, Konrad Dybcio wrote:
> On 9/4/25 6:39 PM, Wasim Nazir wrote:
> > Enable remoteproc subsystems for supported DSPs such as Audio DSP,
> > Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> > firmware.
> > 
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > index 17ba3ee99494..1ae3a2a0f6d9 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > @@ -425,6 +425,36 @@ &qupv3_id_2 {
> >  	status = "okay";
> >  };
> >  
> > +&remoteproc_adsp {
> > +	firmware-name = "qcom/sa8775p/adsp.mbn";
> 
> Are the firmwares compatible? The current upload seems to have
> been made with Ride boards in mind by +Dmitry
> 

Yes, these are compatible.

-- 
Regards,
Wasim
