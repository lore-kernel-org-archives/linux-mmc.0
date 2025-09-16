Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAC7260A
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020430; cv=none; b=oBi/ZVyLgBcg3YmFte1s6VzsbkHu2gmDUHG8eifs15Skx6R1mis2kVeUOKMXHHYMLYUeKKC38uepbt6gntfRhJXj+xvpF6Ti6U/ZLzlMkz2JC9v7ltMXQ/ZXEZCPRofI+nakM6SoUNoA74M0hcJrKXUOallK2VbTScOMBGBfTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020430; c=relaxed/simple;
	bh=M6Zqo8Ymcxu6eRx/7fcnIg/xojiXutzI75zXFiJxqNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sanxoo/aXgPq8PmRGQPus5xETOygGUfmV0odf8H13B85AgmoZ4GJW1w/3a0ogOI/qCvKfZQjtb49HPSl9MBUhZDphuUepWGZdxdxRn6OctW8gUsROjttXxzMD0QfLrUO2DJpbImlU6AcD+jXNoPoVmvzGUpVDuoHRPajz4DBQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cxxFqk+s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cxxFqk+s"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAYYeW012552
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vH/Rjq1TuanzbCVidX6mw4sX
	aElF2T/40jPPuQxAJJ8=; b=cxxFqk+s3TclutWcPBPpzYKxUvMqL8f+BX1NlLvw
	ABaC7fj13xTysRPsNiqHutQuPgUXUfajjvhnPcgnpF3yFjWIDJC8tU0AofVVaW8q
	b+A2/WlC8ytZpKXSJSWwCR9IUSv56vUbt5zYFwbxV8qRkdMEIqNaNVnek+qeUd3R
	aOyLlZ0T9sbcnTkZsSV126/F7ICaKJFIN8DwiTUrfEiT+ksKZDUAgIKXUmLOzCSG
	tpiEucz+MK2winOlvCc7US0oDuiJqYqr+hC81zk5kAIZkcezCUHAzvC4kZqAtD9j
	aW/LUY5E9540RHna9YvXk3SxcXqqWJMQtGOJL3t1alw8/w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072rkmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:00:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5fbf0388eso70800951cf.3
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 04:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020427; x=1758625227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vH/Rjq1TuanzbCVidX6mw4sXaElF2T/40jPPuQxAJJ8=;
        b=tM/XtBJvKGh9g5qslDVby7C6g8eSbY8bTsoaRjEe1MGc1OnDz6RUIwcpHddM0e5rly
         zolBMST7CyMpwWrhkuCCTvCdSznk6zhU36Pu4jdQDm7nzs0W9Fw/sIycxOrOgmqJyQ4f
         3GfKoXBlQJmkCYR1St0bdNMjo9ASzZja4uT9uUHg2K3OGiVk+8ovB3Gf0Rb4jnUPAX/c
         U7KxG9+EAzYhN505gUnuzozNohVDuDe/lScP69Guss7VBEDXIbkYBJugCnUW3wDHOVHg
         SR9XiiZsRIrKPHflUtvn0Rt0kPGAz7si+Fvpt8jKhrKfyZIe3HCHmo4Kk3bbDrFE2U7g
         nydg==
X-Forwarded-Encrypted: i=1; AJvYcCVJbJ7SfBxBwm5yx5nrjXuK9D5BYVNIVIKqhTAkNIlKrkLGnZmGYL1tVQ/AvuoKOyx/4PgM2Eiaxik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrANfguljuzHjPnkuulNyGztLKuMAUYziiOOpFb8lXfFDMheN0
	pDIbHJSJ7BgzvszsYOIbfacRWbSrFDCWMeNg6oTLRc6Z7CxQEUqwih+b0fenUt7w9FBpDeVLSgW
	/tW2sA+MvF8du2OuKywRBjKmQsJT8Vu53CUlHQ6JF9ElstPoyXX6KFUC1QPRWM5U=
X-Gm-Gg: ASbGncvLcNimRDZlwFVOU9PfWlUa+kb6LFFrqJTkEYx24uPcEYUAiIvuxunB7JNhv6e
	kRsitqBCID8NvWwpAPTi0oxKvyRZJiTwgusQ69KMyHoABzS6mSwVZAYaXqmPiwNAGCuVfxqb9CF
	RqwczIVU+D+22+IfYHMDTw2qpTBVJ591oWxbYxTAqOwRr1O39BL6ULUp3mrx0D5FU3MG0SlE22B
	lRxXXW9FQL+PGUxlTPwSl6Q2XCqBqkNeAMZJx/uPOOV4k+i9SLwiNG08HXAg8fAaJSkSKJGRf6l
	cz/5apbLxVxJBQ61hAnouyntiYq8mhNVpxEOwQwsIou3aKXKGNgKcECXQhsAiLD8rN2eZPqecTp
	P+cV6gobxcM+53GfN8r8TpzJ4Q7zsyf+4zIlTkF4uM8MasAUh0/iE
X-Received: by 2002:ac8:5d04:0:b0:4b5:e12b:9e1 with SMTP id d75a77b69052e-4b77d0aff86mr159715171cf.60.1758020426815;
        Tue, 16 Sep 2025 04:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEqyqBzvf06O0P8M/2FvHMvziCp9UQog00iNc315yVML3/M3tQIwWCuaULaNoan+pHArDzpA==
X-Received: by 2002:ac8:5d04:0:b0:4b5:e12b:9e1 with SMTP id d75a77b69052e-4b77d0aff86mr159712941cf.60.1758020424897;
        Tue, 16 Sep 2025 04:00:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63d9esm4235593e87.70.2025.09.16.04.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:00:24 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:00:22 +0300
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
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v5 06/10] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Message-ID: <kq7dqqjaw5rgdx7nubycj3wuwqor63e37vploqw3efo6qa4oir@faorattts2vs>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-6-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-6-53d7d206669d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX1Qn87jDEHNMm
 dNIkxA/SImnw52OsDCyIZKfkm/sz+OhYtNDMzjmVtfEpJn8L8FZSPMLAGyagAdadL/Rcmylp0dx
 pln+jYSw7gWjkgWp57FWpCXr99h3PmspFJw/sLlm2i3ngQbr3YHmMSzA2G76ZRe2WK6h7LuZo3u
 FlQVc7SCaNcpMqKpyT5RSF8WAkFdYZ12Nr6KCaRUPgS8PEvdoPrOxyK9F04dPKHZRCnY12Demyz
 x+hzVsYJUc0ZvurhQL2V/clLOy9LI4+3mqrec6C86GaJMY5Ioj4NRgz8QP1oOP+tSARmbKMopl7
 bV9dPtZkOQ0QSumga3e/toj03q592htKASP49RsVZU2xOXubiD/EDnTt/ltcADyITKn6zfMtSWl
 u7wosbc9
X-Proofpoint-GUID: HatVkut4B0VfmBoKk9XkyCVYmyng4AJO
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c9434b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=woMd_khH0HIeFH28_EQA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: HatVkut4B0VfmBoKk9XkyCVYmyng4AJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On Tue, Sep 16, 2025 at 04:16:54PM +0530, Wasim Nazir wrote:
> Enable remoteproc subsystems for supported DSPs such as Audio DSP,
> Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> firmware.
> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
