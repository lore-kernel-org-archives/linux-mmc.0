Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9B3DB300
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718796; cv=none; b=F8bHfHYsk5O5m3SueZRhPZwuJXdk6VoQY3tBIMuR99QokXRqJmg055YTicgb24AD52moJmyMGRteXY9JMUJAyi108z3yCXNOxIHr7IPdoG9TTREjogCXrMuZRoi9/OYJUrHd8PM89vDmomnrMBo+y0UY2TwasVX34MuOcxycmqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718796; c=relaxed/simple;
	bh=MkM9uVwsLGoyllB7BgF2sIXL2LM3Mcmuh38APOIYjp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQGJGwloAi90aFbnF8A89XWEOBFvUSeZ10V6vMm/V6rBlyaIQegIeEQyeRl0zwi5jDQV8xHo5Okj2Sb/MrxJxv4WKeaVjmwjcLCeaNV6HFggBdg7rsmXX+GNfhYXmm/cnDVOYp9/gQ4cmT3qbb7RK5U/AA+wBTxV5Y5CNZtEMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P7X307JV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KG6dzPEq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P7X307JV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KG6dzPEq"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rGsg2115250
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+yEe/FsX9bdBWzSFLe6+4+hwpucE4LB5KH6eBAurizg=; b=P7X307JV7EABQrTU
	A2rG3K+Gm2wUXh2wtRuDejiCPQlAIhopSsTZ1NzONuIxcfwONFADx35RpYRijGQ2
	VOnnzwjPsGw/KyUPCC7iWPUs8U+R5wuWbfTC1v7iCgFx/pwIU+IUFAr6EZqeY1OS
	zs0Mbi7Mrgv43jSc07zGt5iRFbE0zzzzBv2xSyyXjbgr9w0A8wc1E/Dt/+gqgHdw
	sTiZnINIpMY8xo+ti1WBWW1YwQqsmCSB3E9t3Th+iXjtUoDO3ZJf6XE55bs+T9bC
	d5eGZ+a4+7R6lL933eyklJQbMN5eXiC66+KQ36MPB7cKANYoYiKyvupwrtTFpYR8
	MTrZsw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f2734dbsr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:39:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c9b71388fbso23908325ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 00:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782718790; x=1783323590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yEe/FsX9bdBWzSFLe6+4+hwpucE4LB5KH6eBAurizg=;
        b=KG6dzPEq09CvjfpoZuVxQ6Ybj7Q2pyQKoqfrHtMToowuDCJR7Pt7lfL6sUBQIwuUnf
         jHOY1yavq57JadJM9P6thTSbU7VP7+PZF/EhVyV5UoWGHHOMEiwh85DcNosV7HdhVUyO
         hO66ceAYDiVNovXfcxUWq2LRIhK+axBDAdwyYzPNltCZTOLVSeRVeEK9qxcw1FEE8B4d
         +mgqQzgA3SJE0u6uUqquFox0AOGD9EJwQzNUfTo62fbMqlddbHKhGFu1hv/H7xhfZ3Ue
         czHmijMDyFJQcU4nTC2DhIyeMziVvGccWir6SWz3kle0AwWf02X81D4qYI7dZ4nl0nY6
         Ugow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782718790; x=1783323590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yEe/FsX9bdBWzSFLe6+4+hwpucE4LB5KH6eBAurizg=;
        b=k1UCNH8xO7UT72+8y+x0fMGsxVksRzXP/aK1cYJ+iagc3+PO0lz8Mvp7/0lQ92ohAu
         1TsTmdxRgvTDGV1AmhttvKZBwaN8JTt5/++nAH9oHYMaQKEpoqBSOApdMvvnuYfi8Nxk
         0T3qmRHf+ghCMXUpKspJ04YiBVbTmQWTR3MbhRAaDeu8Sdrk6zpgAZMIMsy70Ef91S7L
         N4q3ZUONqAR2kg2Iv2/FKlWqzdd1S7CmrxCxbB2mi0iQCDHSc+fQUthpnTkqxlQbLfv8
         CYYHxiy3WEIRwjhdgcTxttW5/fs++ZnWsv+xOM7+UZ0c6ZR9zZUV8vFx4j4NNbBEimU6
         6T2g==
X-Gm-Message-State: AOJu0YyvcTr8C/B1dmOcA5EDRP2CM7l9E1oL0KuTRTgDnaXjiwAmr2+n
	SbdnTbUQAWJNE8WoJrc8l2bk5JocXZ3FNMBk99dQDCLnpfxI3o6QPlVBTMc8Qmv0U/nIpDyNhca
	QkO/KzURredUedvbMXp1A8ug4BpmUDybPHWnvND42/uIWRpm6UOe/n4GOAGzgDHA=
X-Gm-Gg: AfdE7cmitV6UJzeRLpK/WNyhOZLYtJ+NRC3hD8rkwsigjgIm2CoAwqmtM1CVgQVFTjl
	KOCA6382caqoaFTP53m3zsn581jAV0yVi4/CxGtKgpT6sHI1HX8egLXTaqiPAuqNUGLaBdVWf50
	LJzlbWaf4XcMJVrU3dBnRwv504oAMB82lHAcxAqLBfMtzrhv6ibz9ibMzwetltvL4mo3O4kF6qB
	g9uSSox03ed5hkhoNu05AYiQrhU3hUHeg9Du2C7BUKWgpvjJaPaKitCwUAUI7rwyr3cq8SLkhXs
	JPxL2IaZdOPpoZr8YzOovSYcoPe3FWab3Jpj9Yl++hdwkB3hRWlUB5ljJprbQUQbCoUTqVQ+DLd
	Zbw3xosiC4I4ou4vRqNM90aWKppsXSxavdKuO4NYSJDI=
X-Received: by 2002:a17:903:384f:b0:2c1:e426:70f4 with SMTP id d9443c01a7336-2c7fc76f62emr152444755ad.23.1782718790052;
        Mon, 29 Jun 2026 00:39:50 -0700 (PDT)
X-Received: by 2002:a17:903:384f:b0:2c1:e426:70f4 with SMTP id d9443c01a7336-2c7fc76f62emr152444555ad.23.1782718789582;
        Mon, 29 Jun 2026 00:39:49 -0700 (PDT)
Received: from [10.217.222.146] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9ea00b342sm21726305ad.3.2026.06.29.00.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 00:39:48 -0700 (PDT)
Message-ID: <617408ee-baa5-45c7-88a3-9be78cc557e6@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 13:09:43 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, ulf.hansson@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260608041650.541502-1-neeraj.soni@oss.qualcomm.com>
 <20260608041650.541502-2-neeraj.soni@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260608041650.541502-2-neeraj.soni@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7_xFMEJUKY7CxKhpY7CxQUEAgCACHyVR
X-Proofpoint-ORIG-GUID: 7_xFMEJUKY7CxKhpY7CxQUEAgCACHyVR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MSBTYWx0ZWRfX8GsYncS4zyuG
 /0Jd9+a6U0u56pSLwOf6hxvAM2roFLm5+KYoPFxh2Ehyan0NII/3CFGrE9VAydOsHfhl9I2JypN
 HYyF/Su8LfUbnHV/bOVJs+NPjq7iJ1Y=
X-Authority-Analysis: v=2.4 cv=HYokiCE8 c=1 sm=1 tr=0 ts=6a422147 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Z0ZxW08zNbm2n-bVQSUA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MSBTYWx0ZWRfX/LouxOTmaJVx
 z4kxw19x7XsNe85lzt9yzhj9WcJRbiwJhZI5o0MdytkNcpMf1CYFDok0o2N41kKKxm1aZIJKlZO
 kNjKU5BSOWQVO680Mv2nrC0D5FRe0NL+sMnMa5nlNK6zbztJaO68+zd6M/FU0c1gFudVACkqNFI
 1FB7vZISb51S+P96wFo7lckdOonzHj34sZZyCiNJSyn8KG4HlbNw0/Wr5t9Zp6SOWEvZobXysDG
 LAyThVfdtYdCh+2Su6hqqdBrbmHU6TwNcTSS/I2VGJAvm6k1j8M/G37AXhZaJC6f9XfPyUdBoRC
 SYk2ga1KrDQsqA1lLWBol//jwbx7kmMEzEcFJJqltWifjd5hxHW2Z1qyZVxab9+TMk6b5HtP0P+
 vyl1uTAqrISK+om1Uykykr/+UveqVilFAW0beytktLSdBo2EH8aIk6RbT9iEzsYddq0J8weeShR
 nWdg4Xh/Ue7GzsMttRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290061

On 08-06-2026 09:46, Neeraj Soni wrote:
> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
> So add the qcom,ice property to reference it.
> 
> To avoid double-modeling, when qcom,ice is present, disallow an embedded
> ICE register region in the SDHCI node. Older SoCs without ICE remain
> valid as no additional requirement is imposed.
> 
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/20260310113557.348502-2-neeraj.soni@oss.qualcomm.com
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>

Below 2 series are clubbed and sent together as new series.
-
https://lore.kernel.org/lkml/20260608041650.541502-1-neeraj.soni@oss.qualcomm.com/
-
https://lore.kernel.org/linux-arm-msm/20260409-ice_emmc_clock_addition-v2-0-90bbcc057361@oss.qualcomm.com/

Kindly refer below series now,
https://lore.kernel.org/linux-arm-msm/20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com/

-- 
Regards
Kuldeep

