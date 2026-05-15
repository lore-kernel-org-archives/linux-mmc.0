Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD5D407562
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841454; cv=none; b=eNnPoc2hA4+v4D27hoTc4TCjxjOXmuJTSR4AL1GAih0Zw/86oMrXYOI+/bRkyXcoEolsW3Ur35tav2JCWCZvsDSBYDqs7huWxVOacs4HuqC+lbo1DO/g/GnMRrNiUzXhjgiG5qVVxuURo30/jXFX6ohFt3ttYdStB5zkiLUAzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841454; c=relaxed/simple;
	bh=Olhz024//a3T39nWj7aqngNz5zRyYEO9Z31uP3Yw8LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gI71Cg4lirjy+2OwjBPMncTX75GbverH1yrs89g3NY5SlsDfXgpIAdUCHudDG8lShV+6yGiOC4dTPUr1Uq1loQh+9D9+992ePqSCuMY/4pFV/WyNCsv7KasL4bbtyqEtjUuMqtvOIUziACP3Oojkz3/U9vmV5Z2TGLxDGJ0E8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GWVEUiSA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EVzF532M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GWVEUiSA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EVzF532M"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F9AhVI1717390
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 10:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VvbGXS2kE9zWNc5GpgcccNRZaDS08RE8hpzanRVUMOE=; b=GWVEUiSA3y599VxP
	PumCYLmwl71QWmb8uCw1z7y5MHaXMEjidj0PZ8v6NjmdhJrCs35UooKfmwl7OjC7
	yT1d870mm/U980fmjS0xppCjXxTmjl3nt5vEDH3nzJPqnOvY2mtLHXwY91aRdpyJ
	DlBewtmCX2dkvh9m583EB95DcaJRIvv3U+0DqYzZM7X4pCrOj88dtSaFIauNqVM+
	A0Vo8QnGwp25YTCDSw/DQKDa1rYAGQgDpiPubOc5Oj7Sd4iVqGD6ynTfnwMPOBuf
	y9YQXQIp2l3zoCf09CUXMPLgCo9/SUscDJawRtxZQGVRdTX6Hg6lrraVu7hL/aEB
	u4OG5g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5tyxsnd5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 10:37:32 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6314bbea08dso392361137.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 03:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778841451; x=1779446251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvbGXS2kE9zWNc5GpgcccNRZaDS08RE8hpzanRVUMOE=;
        b=EVzF532MfX1gyXSXi2xGpO6eNPkvwVbe7N9xbJOJ+TGqngyYIU1UBvkZh1W6A0pUX8
         1ZzqlT0x91MWJzfK85E+AJQuLQOGLxGDOX/mVKEzMfGnfJlSBDnvenT+xkG3aEcTiFE2
         PJ8kGxQ12VSX4NlueEiXDKrg0Lw6Coxme7bLsyaviUk3lfFJl8jFqKk/QoAeiRKANuVe
         ozDxUeYwTpkvMy65s/rLDiPvboz3VsiL2C143KvdFTwV9skOT0BLSqaFjAUsVxRXCTTK
         7iISovupklVJHetKGr0j30Qj9ntIYxHbUhyu2mtYTdvVyaRjzsyb7x6IXMiCBnPNtj/p
         gupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778841451; x=1779446251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvbGXS2kE9zWNc5GpgcccNRZaDS08RE8hpzanRVUMOE=;
        b=jNAa5IFSzc4azB9mN22y0KJWIRinhWmfKghoif731JRRy09s0IDlytHq9RzQh6yQu9
         Z4Wsin2jujyrf1engeyiVs65HVc/+hlwusnkj6W0JESYzop+puc24WprkxPY23j8mcu8
         CxcbnacYxglEeXfWiWR3qFboXqy9etqm2x07iFypkKAS4YUIlxcncxIISQXtarm1bQ/h
         CraRzDXPqfzZg6cjgbyjqwg+8nYa1LoMMVP5CVjXVdlWPl/3VA1wqGkOGqc2hDDnXGgP
         voMEjjl8auXlSx85x58c5oYC33J1vK0p5DJ2+WfH58OgBncFneKyL4TUUvej2pXt/L+W
         0H7g==
X-Forwarded-Encrypted: i=1; AFNElJ9C8eI6DWwVf5b2IyM7SKZSUnPaIsvMJSM3dPM4CdTrnMS8kBaHxRd4ZtvTttxKERU3g3RPRh6TYZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7AGl6lGL9YiIRVab+C93WJTUstfG9TsRhbOKNbUMniUo5q8ty
	lnb3wNhS+iEy7qXIc97jIItSBxqwvpKZ8SRQk+TI0of1gy/8H8Qhnq26aEig7XAFHj1Zm6pcWti
	Idn1wNRwJF1Fq+jU8zQi7ICu05pEuJv0AhOjFDne8T3HYZpkaGk222n//e6hMMHM=
X-Gm-Gg: Acq92OFUvQ630Jp1DLbv/9EIjHBw/bUZjmPiUb89R3RvCB9fJ8YFXhLkxBhoYta+QyO
	PnSjaL+RocPDXqWsonp+T+CIHNoIgC88KpaD1x6ivSpC4raPvGdsFg3nDZCdktl/UGSeqNYA3H/
	vFOgpc1XTCLSLAtTMMw4EwNZPYk4mvH6V22Sy3wGvmelGTvgR21lbTgBaaT0OKQJPNrDrZLOpYK
	U/MIE+3dJiIRWOf2kxQh+zFPtyID/gRx4jclzLKDlFMeSrLDLJB9vrDkPBJJneKi/44wCf6tnCk
	buksex73wKL746rjWxGV5y9fhFkSXweKCOjWzWzWTJJ0xPtt22u3mISFP37yK9MKIfc5rZ4QuOJ
	o/5217rXZzGFAG/ylE7+XAlMFVP65Lhdza6R9y4RGE1kvDPmjVwjIHp1blBVY5Ou5nr3KjjgZSJ
	j131c=
X-Received: by 2002:a05:6102:2245:b0:631:3ccc:42df with SMTP id ada2fe7eead31-63a3fa98b68mr406168137.3.1778841451401;
        Fri, 15 May 2026 03:37:31 -0700 (PDT)
X-Received: by 2002:a05:6102:2245:b0:631:3ccc:42df with SMTP id ada2fe7eead31-63a3fa98b68mr406147137.3.1778841450885;
        Fri, 15 May 2026 03:37:30 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ec6548sm206391066b.62.2026.05.15.03.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 03:37:29 -0700 (PDT)
Message-ID: <ced00124-9ba2-49ca-9200-62abd6ac3340@oss.qualcomm.com>
Date: Fri, 15 May 2026 12:37:26 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: Introduce Shikra SoC base dtsi
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>
References: <20260512-shikra-dt-v1-0-716438330dd0@oss.qualcomm.com>
 <20260512-shikra-dt-v1-2-716438330dd0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-shikra-dt-v1-2-716438330dd0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dMWWXuZb c=1 sm=1 tr=0 ts=6a06f76c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ids9KMZMtRugHLbRT8AA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: IShJzGgq3a92if8Fpypr13_bIekt9zN1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwNyBTYWx0ZWRfX3k6XQBI+a6R0
 tqdSbKc769MbbOYotYXnWZEBmiaDW4KK3zKl9GE/IpcevJBOoFbiHnNGsU76+1XLu79CRpm7qwv
 lSiHaHZnu34y7FIbLyhKfU4Gbq6fXonwx90WCb7ypNQEQ6hlIDtpVj/72285HuXB19bv8Um905R
 pjIgNBI39VaRVCqXK6oVgIIm1Ylbf8SpoOukeKlK2GG+zUfRYswF4pwwywD/RGuv2lKX5pcVXhG
 xRHGpiDi6hUma4/ZLMKSF4TmZ/+dtNmhUoqeBwnPfqW7XcP3olfVgVJcLF0la0mw1CmKJiV/6fW
 QhfUUImebDNbN5saBuUGxL2ezUpaEXEQQmrZM069PozBBoaaNpGLkJDbm0k7kAz/kTasP8uJ3RJ
 hVrHhGQwmwhhg+6jKzc2NTxDsttDP2ovZjpEXDSAAVLzrCL04D8WkwX4/NzLhfMgJ6k17CcqKOo
 bzUy9sT7H1v8iRcViLA==
X-Proofpoint-GUID: IShJzGgq3a92if8Fpypr13_bIekt9zN1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150107

On 5/12/26 6:08 AM, Komal Bajaj wrote:
> Add initial device tree support for the Qualcomm Shikra SoC,
> an IoT-focused platform built around a heterogeneous CPU cluster
> (Cortex-A55 + Cortex-A78C) with RPM-based power and clock management.

[...]

> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;

Considering there's 2 core types, you may need something like:

9ce52e908bd5 ("arm64: dts: qcom: sm8650: switch to interrupt-cells 4 to add PPI partitions")
2c06e0797c32 ("arm64: dts: qcom: sm8650: add PPI interrupt partitions for the ARM PMUs")

> +	};
> +
> +	psci: psci {

Unused label, please drop

otherwise:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
