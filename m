Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0136A375
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209047; cv=none; b=N/18yd4MfM4yQ0o7qAo5K8+I5HfdpiVOGKbE3kaIf4G4yGtqX7mKxbi0z2sR7fpdzqcpTxtPsrMj9f5V42h5wRKLOSZpWHnMgmrx2w4uw0i3IbXHoTUcgGzaMJc6nOfDOmyyxMz/LA8rAZ4gIx/6pgni34zlTvB2w09GzX6maWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209047; c=relaxed/simple;
	bh=Fq0Q/DDsjNcDFSjfHAH1n5aCPkGZos0PsXXjLEEFLMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPMqRkox5+IpRe5LCP6Qj3tUz1xGWp85eHf1iTDnqu/0cNoDg2MW5TpQdGIamkhP8jQ26QFiutmGe31Gjj4DRbzaIdq4bbRneeYFeWmXWmBqsODdVco2rXrXZPLUQKLX2fz4cbyWZg9Mln6rb8QkLhxs+WMbpJpsK9zuFMn9VBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dNoJbT6c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d6cP32vl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dNoJbT6c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d6cP32vl"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJ3IK21478956
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=W9wdom+aRQF7jsN+TuBvQ4aM
	HYM7LB4K4EuWK4s72GQ=; b=dNoJbT6c4YJCUHvSUJcSwLyni0Ks1N4MiOmotQ54
	5XoF514zeCD+ViI9mrpvqaAioJdXmzMu4i1AbbA6S3qxIeVvlImB0TUG32s/jDcV
	COtmZ4Vo48TWNlE3OtzShOP4IFdkunRl4Uyrct7HTuuVke0agG0eA9XSf/mrPMb0
	gPFMgPTNjwFJBUtN6E8mHV6+hRZEp01cttRIA2gy6nZNzdjxMG+O0LEEA0vLwYam
	rp11DYNZe++mcIo6HJz33SGSju/lgZOsJPxfgZdJSiJPxCLiPEtIbZ2Z0+Rm9DAy
	RuESzTgEPeYjHPIH0qulI+0nmk1a9fpta/cmYVIWbQtwHg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1cbgs21-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:17:25 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6751db2792dso98813137.3
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781209045; x=1781813845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9wdom+aRQF7jsN+TuBvQ4aMHYM7LB4K4EuWK4s72GQ=;
        b=d6cP32vljT/HA/JEfqCNCw1mz4ohivoDxh9UOKI29K3+pFk9hV2B732AlbegqlTTfy
         APwA64LDT2iDBi2H6CmtlcS1vocb85VWrmmYYF3H6AP4aoHXQBbXzE8AaYB7WfPhiFyV
         RyjPpV+MZ2uFPWIrHYFue1QDgGh5HGB24p2DzYLuig7C5pXyyTVfR4yt0rt3zdqjkxaS
         6Xcrlz4oLuUOkz0FvCfyFA2kDlYLrR5Nm92vAKYNI02ii5QxzRlBYHrtX86puoUDvVZt
         LEjViunmVa+zVP9Lj917lGRYzFzBjvzGIMaG5APd+2JcNQEpezPhfANepu3uzjOXCiDp
         6bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209045; x=1781813845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9wdom+aRQF7jsN+TuBvQ4aMHYM7LB4K4EuWK4s72GQ=;
        b=FBeWogkwPs7L3aTRP2MmAlo6HRqDOzdfeBE0pRTITEKVevJyoXU3d6189thJobwFbK
         vCp2toFpRkrDMsaqeU6ywQjTZhK9wvgDFBsLQ1pqGMw7sDSdbYyLcCZbvenpeKr//oKL
         v87XjFxaS0EC0Fr26ZKfb1cV4LrqmcYbWRViwnMpVrRguuzJVWz0oOvLqK+Sxq17mBNr
         Wk1t/yme4EQ3NV0rKk4kT6UL+rutupvON8cJ1h4zI2HS2k2ib0C+3tit0VXcNLcZzE6c
         oJdazPmR5hgEje251qUEMlDiIxkJ9JiGM23TWSgSVsyQfsL1ZF00OQ7BDfLWbDVly5J4
         li5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/rVJNAtowzPdfm3XPfuGlxxti+8h26F4mIHBCOMIvCkeUDxCCHP9wLx4Eu+GBinr4pKAtOqSthwLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUh77c7t2VScmVe9DVGcurX1dWf9ihAZimLK/fJbq6TUdd2kna
	x4+m+gNfYXGP/ovS8I85IV1YQj9UTia01Ds3boCWkT8oCEKGsS5+qWmMJECI51dT96M/K6HZZ2I
	soI62tXBqdp3yuj7H6u4uf8A+v8DBAkWdmHxB5RXdkux/v2Tr5qMve8Pj9XMxKNw=
X-Gm-Gg: Acq92OE82AJhgmGPP64uaeGMse5T2POqti/QSbvJeToFMB6uCD4J72Ty0S1cElv9qcQ
	EeaQavdXdOgu65C+tj8oWUwObihyWpl9sENN/YtmKYqy6BVgbpvLNKSOnCo3Lf+OUlRuActnGyr
	SEVGMo2Ki2oueXP6gMPm77pZ/UiKpJ32E9HsLNF4CJaOJUp9ZtVGvAKlOD7N3TCbuK1ayVduS9G
	/dLZGS35KJ3XfF8ywyQldp+seA+vJ59bkkD6MAlr/0VaI8AFU3DSDj8FSbyPvTSS7t56EF7I8ZX
	Jlyz3kdAQgRjSoUSAMDzVjEMt+G2dIwohGezndBx8uiium94Zd2J5exnEm7JLNdKn3mOYADHDV+
	MRDOn2X/Ahy4Nrcny43uLrOItUt8WhYVz1PSl2u/nXEQP7bdCyoDyuYvMvi7aBV3PwoPQ4slxGI
	ssrjBEAELBFlaP/ZiTqX+XQDibF0ghE9bfiMs=
X-Received: by 2002:a05:6102:3e8d:b0:659:3ae:e6d1 with SMTP id ada2fe7eead31-71d5d99fa42mr3015703137.9.1781209044805;
        Thu, 11 Jun 2026 13:17:24 -0700 (PDT)
X-Received: by 2002:a05:6102:3e8d:b0:659:3ae:e6d1 with SMTP id ada2fe7eead31-71d5d99fa42mr3015674137.9.1781209044310;
        Thu, 11 Jun 2026 13:17:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2cd966f0sm114597e87.71.2026.06.11.13.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:17:22 -0700 (PDT)
Date: Thu, 11 Jun 2026 23:17:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: Re: [PATCH v5 3/5] arm64: dts: qcom: Add Shikra CQ2390M SoM platform
Message-ID: <u5uvhewvzkbqto7wk3g3iaxnjijcgelifhlan4shbkopjul4qf@7fzwcygqq47f>
References: <20260611-shikra-dt-v5-0-103ed26a8529@oss.qualcomm.com>
 <20260611-shikra-dt-v5-3-103ed26a8529@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-shikra-dt-v5-3-103ed26a8529@oss.qualcomm.com>
X-Proofpoint-GUID: 8j3w1RAMdpyXrKzjmg8W5wrs1A8TVnpM
X-Proofpoint-ORIG-GUID: 8j3w1RAMdpyXrKzjmg8W5wrs1A8TVnpM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIwMyBTYWx0ZWRfXyQzaFRcEhU4N
 3hZLRwRWV4l/XPP1A/vF7sOrU5f0mT3TFz/03uSOb4c2BMPwsYX/vcTHBIY32BFO2nBmfG4wb3B
 cKuwJvonhOte7zQi17HdfqRHwf3F80I=
X-Authority-Analysis: v=2.4 cv=S57pBosP c=1 sm=1 tr=0 ts=6a2b17d5 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=djcwQD5uGQ3GNs8by1sA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIwMyBTYWx0ZWRfX3BSvuh/GAKxc
 qjWKrEd4AtUSrDLaReO6ogHYxo2ICXHQ6yxX2MUQQP1ayYgzfVo4Qg7dRx9TnqtDp5LuA2a+DkW
 7i6DCatWIpiScAqK0WoCMG3n7bi6lUtiF7O+QqzlQ52pIaEjFUJ1GCUJ9XSqQyBzGHOkzdeILK0
 PduVG9mxQrureh/LyirzkvHE8fNQb40kXYpkANwRduzLTtpytUbsBZ5vZld06RFvAJ4sJ6Gt0+a
 SSw2wWCRqvnEspBroyRrMN9ZhD8i/UXywNy990CBARVIcYzuSpfduS4skBXu8TZ+LW8WGGSGCZG
 AHVViiUpMn9zu0sywX265HXMrp8s7A7kkSBx8f1OfW0NIzBuyOLqpSPWarMi8tgWk7aPzyer5BJ
 DxV3jUl1iw2YZ1pcRzNtH8sTc9+DvvxgbTilyOgepOiHA4uJy+uew/R0kBV0uPhko05ocJ/emQ4
 vXf1rYnQl5+jdnHAPvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110203

On Thu, Jun 11, 2026 at 03:40:10PM +0530, Komal Bajaj wrote:
> Add device tree include for the CQ2390M variant of the Shikra
> System-on-Module, a compact compute module integrating the Shikra SoC
> and PMIC for IoT applications, designed to mount on carrier boards.
> 
>   - shikra-cqm-som.dtsi: Retail SoM with modem (PM4125 and PM8005 PMIC)
> 
> The DTSI includes the common shikra.dtsi, adds PM4125 and PM8005 PMIC
> peripheral definitions specific to this variant. Since PM8005 regulators
> are controlled by rpmpd, so disabling the pm8005 regulators.
> 
> Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 156 +++++++++++++++++++++++++++
>  1 file changed, 156 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
