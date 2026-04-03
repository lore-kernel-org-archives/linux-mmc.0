Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D3296BCB
	for <linux-mmc@vger.kernel.org>; Fri,  3 Apr 2026 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775218185; cv=none; b=SITeWhHy+DSHpsvpJzN+mQIPJh21BF5UW5l11G7kfhnqvX8SBC8kz4ZpupfSA1cHjGa6Rej7KQXhe3c+PkCuB/zjXR/U9IM2ym0uyojyDbumk0YQDDM6JRhYt/we6Hex9RMeNXFquioUd69LD622AgQm9EBkM4g1JTFlxOA7FD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775218185; c=relaxed/simple;
	bh=wUvYtpcs9XNXiIywZhnee2IHx7izMalzhE0a0QgnWPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgVeFHurIgvn30Xr7XRTmKJILFqYZAGM19RPV5y9kBd7MTOjKRzwcn5aKmNfxDDRxwDEg/v0SNLVgF8nZhgIuavm9Rv4JiLCNMO15NHwDERDyCKsnye25E5EsIumKrGouyM2nvD1ASYNMljXqyBuLnxDq+PTguVVSpC1dAQWW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fCGsIgkD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lz7+NRwK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fCGsIgkD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lz7+NRwK"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633BRoO51562134
	for <linux-mmc@vger.kernel.org>; Fri, 3 Apr 2026 12:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gnl4sM8zA20ARfyeKrrxmcEGAhdUZgBxsvgJlrjFmX4=; b=fCGsIgkDcCodoe+b
	Yh36nTZM0Dq1mw1ztTRv4pZObZb3EzLfuoOkHDkC58M4oBZUfql0fliOJCFg1E0S
	tQpQq8PYEK/uVEqWKC5f7GgGa3K0RszzBffppzf6tfUAjDhY3lDR0f5VR9MCE/rG
	JJfqEl60aOfZ56QEOWfQ6OF6o3jNfowCCBAhz3KaM4TEFhNXeyNEuaW1F+ZKY/4b
	2xbmRQyEDNHHi40r3eACaAGdTp/DbWI1780Q5U4eeEejJovTf2EMMCQibnH/84+e
	Povq8LK+VK0HuJrC1ZNqfkKvABRaNdeUmwgydTtjPB501mJ+F5A8sO9rfP8RN2cb
	4idRuA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9um73b08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Apr 2026 12:09:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b0cf396c45so20275445ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Apr 2026 05:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775218183; x=1775822983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gnl4sM8zA20ARfyeKrrxmcEGAhdUZgBxsvgJlrjFmX4=;
        b=Lz7+NRwKrxXwENrDvGRpgqRiXEmgPKVuvv9WXZumkPbQDSxFnqLJb9C73/jhjBtRqF
         Zs1cJC20DmfBKFZxxGJN6rzKwHOpDd4VsFEUiQFicNp0zymbzd+YT3lNo+of9/tbjsy+
         Atyr8lEapvjetre2Hv3bKQgdB0q8Jd09Yf6ybluTtbW/g/6IwaVZ733PXP0sXDGL5H7h
         uKmvNBTbTdb4y3XAAbcEWzioNT7myAe2zmnnaVgPcjU0YqR3W2IuOyO1HYTK12xy4sog
         JLZlBvpEg1rtCGJhpBPo07iRLsFupFLjiO19u3fzg2RTgqcn38INMrClwxUALS9bc5sg
         diSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775218183; x=1775822983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gnl4sM8zA20ARfyeKrrxmcEGAhdUZgBxsvgJlrjFmX4=;
        b=bTD5/SWVBdaNjOHuYCC0T488YcW7HU3ZBQksDcF0lF4HlpuxonJ5Ie0RwoFsVvJA+1
         mG10xsvljiYy0AXewslwPGKZESR83Vjtg1Q2Uaqixi/7bCL3Yk5nxuXN6O4yhoG7Qt7U
         DAm8mmrxgPzhBpKBxmmu3byhgFt7OFLe+zaRBIe6Ubzhrnt4Udh0Ceoau0vRygvVeN2/
         1WRbHJU10JMPojQjryRxdN+Tj4iQvM83wBRwgiHwPM12conC53WLwBV0sMM+rEk+5ZQ9
         zF6j0d98BFWJzEuQk9ejRvVmSnWPnYxEbHum0cHplVm6fpjo7qbsW/YhJ1KRyWH64HHw
         nz5Q==
X-Gm-Message-State: AOJu0Yx196DX9YJJXLsKvUJPze1JGv6UphkRU7iNherOIZIfwjbl/IB+
	zw23+vCFyqeLov3+F9FEoRfFH/vQEuEUH/oDfaHsrgQnqrAYRCKY7MbdMcmD5anJ7Sahhmx4aDc
	/w1mh9oBim0ta2ntMEfSFECTogf8Pkv+ZPd0yf3f+PiTNrrHcBadrbNq0SsYsa8E=
X-Gm-Gg: AeBDievStWYNT/YHVbfaG2lBdayet2auRTEZzKt31ZrSOt4x7TCGk7qlzYUtcbdu1Yx
	MgOuK8v1sTGQdmfnCfx4pPbDKMr/ZczQa5mDJ5lwLZaJjKBnFvqRz6J5Ih1jD/FB/taFvDzVS+M
	HSboRGhPnQ5jNos0sM6dDF3PJOJMzwtrElWBwGvuDSRUnmtEHAo5JnIKojOzDM55FoKINSjMFDE
	10eiU8+h19V0WGexL5gPFWFC6g9HcH6SxIhXZxHxger/AnwWs63fxyUtUIZ6QT+FeiZLVjAIyFF
	SAuCjyEeP24MEslwdOwDrROhAy3ZnYq/EhVC/4r/P811Ho35IQDPA3o5g66eArGltu38FKCPd9M
	H9vfrEEaKvrCwuXB95bLTG3aJyiWMsSlP3XJcNxXrUClFvUlnVlYW
X-Received: by 2002:a17:902:cec6:b0:2b0:b290:f302 with SMTP id d9443c01a7336-2b2818de0femr34019245ad.35.1775218182660;
        Fri, 03 Apr 2026 05:09:42 -0700 (PDT)
X-Received: by 2002:a17:902:cec6:b0:2b0:b290:f302 with SMTP id d9443c01a7336-2b2818de0femr34018995ad.35.1775218182201;
        Fri, 03 Apr 2026 05:09:42 -0700 (PDT)
Received: from [10.92.199.249] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274979500sm76740915ad.44.2026.04.03.05.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 05:09:41 -0700 (PDT)
Message-ID: <0543815f-a7ee-420e-a4c4-9f4dc2848bbc@oss.qualcomm.com>
Date: Fri, 3 Apr 2026 17:39:38 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: host: sdhci-msm: Fix the wrapped key handling
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, adrian.hunter@intel.com,
        ebiggers@kernel.org, abel.vesa@linaro.org, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260403105949.1007447-1-neeraj.soni@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260403105949.1007447-1-neeraj.soni@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=U/WfzOru c=1 sm=1 tr=0 ts=69cfae07 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=agS0TBrbGMSRRrU0JjAA:9 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: wmpQ_Yub5HYbNAN-wckutfXpdPmXZY-M
X-Proofpoint-ORIG-GUID: wmpQ_Yub5HYbNAN-wckutfXpdPmXZY-M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEwOCBTYWx0ZWRfXzJc+YQPp+gu0
 rEJvNHRniPatdvxApqUXS6ObAWzABaU43cmmxgKY0ThfzhaH4ksvgQdPpSUcYrkGW1h3pzTXCbX
 txjpZPRiIqQstvu7xgnzufPkaePBVNAfe4D6FcPDNrZgVsYsyqUzM3e9CVbni4D8hcArPGzVKz+
 Avkiv4vt/rRY2fkEL5j5ceedT/g7lFYJiQnGtEv/dHDPiZknHP/ZPHEGyXa3DvOKY18QNUKTUII
 DNmQWZFq6dpKUzLbiuvcuEh8d0wTBB4Iym4C6FwLKrDWGlTCnfNXBana/zGAUyqMPE6wIWxa9Ek
 5eyMasos7CiuQJwgT0nm16hSfshyQNFiBIST5m6xMFWSvIviT+8UtwcmHs6sQIS8zmkcSGcsDL3
 g9TMLSc8nDk2ZlWkuSGEk9PdxW2b8jNhTeHHaQPszRPP0A56ASj2W2aPz7y2RGCKAfmUPUFzCLR
 1YEOlLilZBqqDi9rn3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030108

On 4/3/2026 4:29 PM, Neeraj Soni wrote:
> This change was originally intended to land with the patch series:
> "mmc: host: sdhci-msm: Add support for wrapped keys". The fix was present
> till v4 but was accidentally dropped in v5 while rebasing.
> 

Seems you need Fixes: tag to address the fix on the merged change.

-- 
Regards
Kuldeep

