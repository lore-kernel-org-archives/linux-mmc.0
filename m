Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ADA21FF23
	for <linux-mmc@vger.kernel.org>; Thu,  4 Jun 2026 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579369; cv=none; b=Li8iD6VjQHWqt/hVInocMo+PKHbha2ZMEns4+3FXHQBus2IZg/9FSclAHSfjr6QakgqFh5ldJpnWwrWPJkAAzwLY0cO1iCxZZ0T8RllfSqIuxtlkLGpLYSt4TcetCn6Um0Jn5gNlIHB1InIoVTCqKjTAR+NJFw29QBr8Ie3Divk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579369; c=relaxed/simple;
	bh=mp4oqZktG8oHiXvxH1MbdJWP3s3UM3SrKCUR2gW7c5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb19jxE+LayLTteNVd6SPUPJGHVYLB+SpBB3eZZfMI6TiXPCaz5GDCo5P0nx0fSI5HNLPVPDbSALCidEOYxdjcFHcLaFONjQto0jB7Xh9F0vmQuNH6ckmd+XPMclyDtqwgINeN3oljlKX70Qn1GDpoqnacMqhZ+KnfzwQgYgmmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bee+46aT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OWteJB5o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bee+46aT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OWteJB5o"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654BhJMg994556
	for <linux-mmc@vger.kernel.org>; Thu, 4 Jun 2026 13:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0cPUcR58dasqpgjZO0SJrb2/
	PQ3ohFO4F+BZI7umGqk=; b=bee+46aT0YVD4x+qzKCAYR1nBxRsxzLy3WQh67pn
	3jYsalLdWPhzPD3AN4z81PN19CZwrSvl+ya96FIj1GW1LhZTwO5Dize8/DVmRc+f
	iqtPraj5sk8aPV3TpKnzER4fG2QEZqktWIt2k08yV91OPOiReZqZ0Shc5wEiqE3e
	nFnPlmlyNLUWRKM2519nv1zWNBX4dGClSRfxcb/7J/9GhDdWxXiLxcYZPzO8RIYp
	1NhKElqXBCm8PQ3kIZtcIvZheww66CgYLdq+QflrZ0a2PMxHX/kUP6Cso771IjnK
	fkzYEDzUj+WTFOP5r1LydlYPUic0EBLk1vmKhfFzlh4Wqg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek374sqk4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2026 13:22:47 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-59f18de8482so1080332e0c.0
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2026 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780579366; x=1781184166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cPUcR58dasqpgjZO0SJrb2/PQ3ohFO4F+BZI7umGqk=;
        b=OWteJB5o1p4gV85lkZZXFbKojB5CgjNL2D1MpElyy6Ro2VwY0rBlDMYBqcl8NXZJgK
         SFlZxbMkTWGSXu1FYamHlBlcLr0ImFQ+nCvxV0pCXl7s8UL+MwLhbgI3u14IS1P1gn1F
         Gs6WGA3rfZ1OJGRhoVsoCuu7nxg8yBiZbuzCmrNHOFB6sMdL/U+p1p9eYF3IP3nDyOcV
         FG1wk4k5u7HPRToiuaDxvtiBn/zmi1RdqNzg2M5p5HTp9aA+ot5QX/U71d9HLgFuPj1N
         RD3fvYMSlzp5ZXG2wbdohOxf1thv62Gz4pXPdyrVgEmS+dKiXAww1H4tlDOjZgRDZVQy
         TN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579366; x=1781184166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cPUcR58dasqpgjZO0SJrb2/PQ3ohFO4F+BZI7umGqk=;
        b=kf4l605h4a8BFEfDlHiEPGZZ+H3BmISFPFOIEs7hFY63vryYfG+l2L9DKNoYiYPGbI
         x8OCs2Oo7kiHSqAybkG63e/DY90/aX/L59tuguo1wjCot0v4RfpgOLIFtMggQtjwtHrT
         0fOGa61JwkgSOA1YDA+L1aX/TWm4JF1268hMAlfzSi2Gk0gk2twuTZV6M0oDuP06HArn
         ryq1nw1OSpu7ipNac0iqpUceyVrsX63afcuTrJ90YNkwX5GB9do6IFHDbUIEouk5DQaq
         xEZNtzzSgTrZunhL/0qBfLBvvEQigOn/30kVWPSeA8vCVEE4gacwqaslOdO/QEuiAu/F
         E8JQ==
X-Forwarded-Encrypted: i=1; AFNElJ9M4Mpe4wY/CNDpOJ8076FfF080Sui+kdlPJT8IU+sNNtBlsWbF2LQCY5XQzN4v//PhlypW/j176kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykR+MGxoJGgwv5sEEl00w4657KmWG1yzlaHgCnEdBuhgWKWYar
	bgb0N/pbmgosp+x7hYhSeOkMK1egLgLI1Q8aJsKXdOJn/40WFHvfP77uwqp8vbUJ7yIErk4qefU
	0N90jnGOz0BUG1SI4NBG5nA0QritTXt+J1nGA0iuIl7TVhtSBFiBa6vCpnJVLpDc=
X-Gm-Gg: Acq92OHL3chH4SXrxUB3WRb/cRrGS8JfkYbw29CNHgUoO9NAdG+h8HIkHGbTsVKI7DW
	FUYEkdenA2v7yjG+NbyufvljQI/A0/fH+a/wKbaCV8CD8AeKxnpD5TCV7Gd1xQMI7ggGLxUSKD1
	5clVmidTaeWo4MDcxxpta4tF+O0ykwQJotu4LbUW2Lap4BU9V7H8OLZLKP1J/mS1frlRx+Q5zW4
	z9DhbPHaSsbAqOA7nGDYohh7fkeGLuLBO6bsyUr3JJAtPQXbZBNDPynswHxV6tyousBTgDYmDGo
	XhTHsL3rzP2Ar6XlGpVq4Ucj5dvUZvoDo26uRftsDQauKptmp9UQbHlPy69VwCj8VtR54Kelcbz
	CBuTzKMz+di1Djao2kx0wY17pLwfvbsYg4JGs6V3iFznprQrMJqt4sk292dfWXF+W/1C+7Xiw7F
	Q3sxz42oDlAtZjXaEuVg3TkVpHwbKAP53n+HAube9fU0nIug==
X-Received: by 2002:a05:6122:1d87:b0:56f:a329:6859 with SMTP id 71dfb90a1353d-5a6e61be6fcmr4683049e0c.7.1780579366449;
        Thu, 04 Jun 2026 06:22:46 -0700 (PDT)
X-Received: by 2002:a05:6122:1d87:b0:56f:a329:6859 with SMTP id 71dfb90a1353d-5a6e61be6fcmr4682973e0c.7.1780579365955;
        Thu, 04 Jun 2026 06:22:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97ac1esm1200902e87.54.2026.06.04.06.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:22:44 -0700 (PDT)
Date: Thu, 4 Jun 2026 16:22:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Monish Chunara <monish.chunara@oss.qualcomm.com>
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
Message-ID: <hpvnpq2rx2axmtxmk2y6tddeo42ohvd4ae3z37lynzm5nug4vf@sg5ndaqfdlvh>
References: <20260604122045.494712-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604122045.494712-1-monish.chunara@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEzMCBTYWx0ZWRfX7fvpBKSsqZtS
 A4R5MiVck2484uxyM9yOw66GzfMvG5BHhLEV8RZwsqEjl/y8QqoryDMnBbV0t7YVOgJ50FsQHfJ
 74c+LCvpXaLxj5ITpCkcpBknzSOyA/IpQFMH5Ik4kWfjKZx5qogRFqHKRuYuQ229TNlzZ5MP4VW
 ZjqxsGhi3Y8JsLS99S6kck84T1CfacTqiL1sT9thRzLwecpIbkEnza65eQD0QLanZAlZz8sA8IP
 xF9CucMhSGYlgjDCnDaLY2EtFeF7cRPCodQA/MiQrhTZboLB3Is9Y7oMGGsshGzq71Us5uR+wtG
 XNFTmGo9VHziK4hp3SMbB9NuADxKVCqZ4VkIQu8G45QTQa5eZE3RrhV+aFE35ZWyxSnf9IZL/lH
 ki03mhY2HvUboRAyHKSXW+L11g+aNrvGfmzwLVCr0DxQIwZp+k3cyaJhzRhNjqwJ6L2fOt1/JI6
 A5g437++V4ZknDe71kA==
X-Proofpoint-GUID: _0J9Rt2q_hWAm8aVj9rMNRYfPPrEmk2z
X-Proofpoint-ORIG-GUID: _0J9Rt2q_hWAm8aVj9rMNRYfPPrEmk2z
X-Authority-Analysis: v=2.4 cv=eJsjSnp1 c=1 sm=1 tr=0 ts=6a217c27 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ymJGE50u7P9sh_QXW2EA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040130

On Thu, Jun 04, 2026 at 05:50:43PM +0530, Monish Chunara wrote:
> This series adds SD card support for the Shikra platform.
> 
> The first patch adds the SDHC2 controller node and the necessary pinctrl
> configurations to the base Shikra SoC dtsi. The second patch enables 
> this support on the Shikra EVK (CQS, CQM, and IQS variants) by defining
> the regulator supplies and the card detection GPIO.
> 
> Testing:
> - Validated on Shikra EVK variants.
> 
> This series depends on:
> - https://lore.kernel.org/all/20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com/
> - https://lore.kernel.org/all/20260521-shikra-rproc-v3-0-2fca0bbe1ad7@oss.qualcomm.com/
> - https://lore.kernel.org/linux-devicetree/20260513-tsens_binding-v1-1-1780c6a6caf2@oss.qualcomm.com/

And how does SDCC depend on TSENS or remote proc?

> - https://lore.kernel.org/all/20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com/
> - https://lore.kernel.org/all/20260522-shikra-cpufreq-scaling-v4-0-f042a25896c5@oss.qualcomm.com/
> - https://lore.kernel.org/all/20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com/
> 
> Monish Chunara (2):
>   arm64: dts: qcom: Add SD Card support for Shikra SoC
>   arm64: dts: qcom: Enable SD card for Shikra EVK
> 
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 ++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 ++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 18 ++++
>  arch/arm64/boot/dts/qcom/shikra.dtsi        | 93 +++++++++++++++++++++
>  4 files changed, 147 insertions(+)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
