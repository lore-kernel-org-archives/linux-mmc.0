Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CFE221DAC
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020481; cv=none; b=th3JSe6M07/drrldP87W2wimvLRMHdYHwnjOX5/w3EudKjgipkhMxZ+ex/Q2liKZLbbfqfFNACcEQA2JEa4Pt+SZInMl0wXqRExJinjTUw9/IA+UdEvdyX0OumHyI5B4qxILj6baoC1xfA2vmZRvOeK3htSGSvtlFjY3rQlZLsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020481; c=relaxed/simple;
	bh=NCB9zn+1OoC3HfwDpn00j2J+X9Iiwehic5Jfs6gBc6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRr0DbkNKK2KHZ5lF4VhkCT/18UBczC1hZCYNSGiYajvYh3ms/RJ/9EY3aN/RjQvUlO/hKX1eqQtjuneWJ9l3S036Q6rbVBqxF6q3yyGa5hxwyi4AM1aOfjrjIxqlzFs4Jb7hyK63o9EgcyShJufEFNXqbLRqPMoEQbkIxrn+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hWrnFyFJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hWrnFyFJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9vlNt020041
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kVUremSztL9SXw9vrpclbs+f
	CQ2ClcMRdwOTbzI7vMQ=; b=hWrnFyFJvxm6g+Lift+rgcEvVLmDxPebCs81lC9V
	M1SQ2Du/4aHvWlV+iYY6FitiLKOefbQSXdy3nQ4KgUkZX1zgfKNn/5CymZVnHPQf
	/ZDFCruMcP1nakG0b3973jNJKnLj6vH0culupLgKoSXM37wK3mhSwRXU6tnzDrpe
	j08KJUyTXA0vp9yPWyA9+RSsuEWQAFIcdaAsJJCSWhdwUV9+5lSa8DWKelV4kcfU
	bymx4QqGW8+HCmDYZKDZx6nbM7GxcrX56+JMfUqSgjria5FX/lMhCo9b5rgAo/Cb
	Xz82PeTIxro8i9Ac+C90NeyZ26Ep+Fti4W4/GGeu/Dzz5g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496h1sm412-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:01:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5fb1f057fso76475981cf.0
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 04:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020478; x=1758625278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVUremSztL9SXw9vrpclbs+fCQ2ClcMRdwOTbzI7vMQ=;
        b=wJZ1feLwvAs2lbzlBu1GcMQ/7yi0YuGo/ip3kAsE4qtwkSbkAZoQa25x2Mzpoj6G+q
         03cHThcTsiNny2alDymA+pKaCToajIg5htCH0Yn3Otor4VK8qZR9NNYBSqwWohwMViEA
         Nma/5C568OCtyIlrl2Asu0TiteZg2VRVYCG1x5NWsCSxCGRmrgRGTfr6OhDdIF+lIUUO
         26l5V5+hM4iFfElgXuEhleO1uUltyDr3XM8FFNrLFMpjWm+wbrwUd6dxBmz5rqBria7q
         t/dy28btlxmrSxyMiwKzxc1ssEqTevdMcr94BYuUNhlb8g0SmrkgVgKzIp93gzA070XJ
         EUfA==
X-Forwarded-Encrypted: i=1; AJvYcCVv9cgdps3JFIa3DS10p/DXTTk5MOIcBZQ7L3KCMbgFyQc6CQQsi27HW6s4yrHpQxWCmTksJj59t4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YytTSh0JG3fY42m04P0jIuO3dW7rUTU0Svjy/nXlJqT4+ewjOls
	SKmlkoAsNe/mZYHDSrj8JU0TYWb0rGRWyecLNjhhYV7iXgORwPjWCogQZd5m8YV45i4ng3pkG0A
	iMiZXf8do9B4EnMeQaY6OCY/Pg+jl/wefTSe/MyZke8MRZ/4bKlwk6TywFGSQV3E=
X-Gm-Gg: ASbGnctyTfYcNZp4MVcaiFmHuYtbaXkG/3SinW878DXwGkNpW9T5CjcUbkGvuNkYsBy
	VjuKnYGZ0IJPK/6Jka47NITwC9/wM268Sp/XjtBwGT+o88pJTmMiy9YjAOlQRyDJv8XieIsJv/9
	D3DfGyZdpudA589jhJa7WVhdAQEtCS58hAaYVuNoRY5Pyp5826yUmsXg5a+n4fehwFM3NW0Z/qY
	93DjzlfqYsCckVQsdaUPR3HlvxKkg4z2sWv0F96tKImzMrkj7PF0dJMCG6Fy9joQwE1Fv+PdXLQ
	YGPFsqjRxBJF8UmZ2jULn8YgM4Kk5EDA1x7G880L9CsR4dIRirtBT25u8tgBKXWDZvK2eQ1X4eg
	Bndg8H16qe84Datjwu7pqhSiJbNfQcDrm0ryjK8jEyz0UdYs/M92h
X-Received: by 2002:ac8:58d6:0:b0:4b7:9313:a35f with SMTP id d75a77b69052e-4b79313a964mr132544341cf.2.1758020478183;
        Tue, 16 Sep 2025 04:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLAF3UeE0KRBiIqMl1GqNbWZHZDnQRL51kIuIAuObbsA7nu8iKYJBvUfO43iyEhrcGCg745Q==
X-Received: by 2002:ac8:58d6:0:b0:4b7:9313:a35f with SMTP id d75a77b69052e-4b79313a964mr132543501cf.2.1758020477568;
        Tue, 16 Sep 2025 04:01:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63cc6sm4391757e87.66.2025.09.16.04.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:01:16 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:01:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: Re: [PATCH v5 07/10] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
Message-ID: <uega7zdkprvk3ediiu4lykiukf7iz2wgk56c3pdloqrpzddt2c@yc37f6payhca>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-7-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-7-53d7d206669d@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: bFsxpmh_vElDgy0-dhvqUrIzkWOxh2MB
X-Authority-Analysis: v=2.4 cv=A/1sP7WG c=1 sm=1 tr=0 ts=68c9437f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=yPPeNZB_paKBOZgJB6kA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bFsxpmh_vElDgy0-dhvqUrIzkWOxh2MB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5OCBTYWx0ZWRfX9ghUW0A0rQpa
 VLZp67iDq/uIaBJbVgfGQ6c38vU/yMp7PcNXh8ji9votuY7ugjAE1L0cxCBpYDJr4RCJKyAcJZL
 liF2LbDGIMo+PFsur08FwUJ9Luv6RuZo5bdHxahxBeH3iVSHZ2quHX1yM/PIv5i34pEikj1oXS5
 m/A+9W0UFLj2sDEc2GYl5uizhBOY2P2sHrkjnUH7u1lqWKNcgsuAY3omK/vrzFpMMjkwYXciBI9
 nwBEx7lfHHeAXtkM/FKoLCMT0W6HXdgwal3Bb+dmw6wMb+lZAFqRhUFqN+HC618S9L1JXmiJw5P
 zVAEPee0kU0GJxTQwvNgaSJFgTmo+xWL1sMlVIEUynSOYFjm8OQV5diJxqhgDbN2H7g0AhZyLwb
 08NFECOt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150098

On Tue, Sep 16, 2025 at 04:16:55PM +0530, Wasim Nazir wrote:
> From: Vikash Garodia <quic_vgarodia@quicinc.com>
> 
> Enable the Iris video codec accelerator on the Lemans EVK board
> and reference the appropriate firmware required for its operation.
> This allows hardware-accelerated video encoding and decoding using
> the Iris codec engine.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
