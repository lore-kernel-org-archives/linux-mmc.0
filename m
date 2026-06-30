Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF653EC2EF
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815023; cv=none; b=CPorreqk+E/G4qaS8ETgguSTMi5m1xfSbh8oyEJ9wWMQ1OSsN7hCzkdUiWVLSAEvUTgNeEcBbJ46RPBpvf9erOzX4pL1Hc3nMlZomnxhst7o6YvL2kjcWiBBtsVCrrVN6BGIDGx9ACsqBQlZYtbFcQBPhgq/A4wYCz06iKalyg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815023; c=relaxed/simple;
	bh=LRkXfXdmo8CWYkWy2OtyR6Psk+d9GjTH5Ank4/i27FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZMK+Cz+lRDeWv2SMkyfYxZYB/UbzCvEYsvsXo2rUIcbjoUzA9FLLhkhwzzTvIFfEkVjyW7bKzWvHbwyRC/+M9386C19wUFkpTXmcc7Nma3Ts8yqtrgyngBW5tuBdjCFF6ZGbS12ybHMQaOtgJTlQEoTT0WdGbH6vQDop3r6z/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ln05Bt+j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ASID6Q1q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ln05Bt+j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ASID6Q1q"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mwXQ1604653
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 10:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fjf98r/hrw4t3YgSzoJNbJCdT3mRw4IABG8RvUCuBYI=; b=Ln05Bt+j1MfPwQca
	e2McPsyRUsHf+OEeM1Wjbcg4Xs/cgp8Fikn/1wFR51kxoBmBOktvbIbvsdOBjgFf
	2wwe4YGZ9u6rlgEiUgSlJmZTX2N9z7hbS3q1KetCJyQlhuRydVK7dBlThceaFakI
	XXWAW/uCJIuMNGfBkVWTUYjg4JvIozjse4EDj1R/kJg9sXTbVPLRD7d4qi1+dUyT
	q+soN7PDfpQDXeBc1kKqo7CBqO9wFXhD95eB4P4ByHbD5drPmpEwtXbHkzSexXcR
	/z7l2GNPw0j+No924uIPaJs+geM9u83mK22Rl9YeHkR8hO95hGnqDJRWva6cgyXk
	zJzB7w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f462fhp0h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 10:23:41 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139871a52c2so6071765c88.1
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782815021; x=1783419821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjf98r/hrw4t3YgSzoJNbJCdT3mRw4IABG8RvUCuBYI=;
        b=ASID6Q1qzgAREHlgLjgVt1n4FA8X3ddC8XzO/qBc3FfXRoP1KaorhHNeCA9jO4Q85m
         MMkNvh2QCDbGQ2c43tK4bTpH8GOoF30XENCvUncK2hPMiaq+sUY08veETuMJhEmL7kpO
         xSfuyEuFo6SNbFG6385I6OQUEA/X6Tsp/t4TA3u5Sf/hf8vJR4lB7Tb+Gx1tJgkl4puY
         rSZq+PHfd1nHQkSHP/yXJk7d33zaXQzAekS5CkbmoUYGwDWH6KCpFAPCPZozJB/ey86P
         blF4L/Bc/WSrHb1Pv0m9fv+V1HIwnaIg70QBiHj33tu1bReVDmGhaWfP/VJEpgoxPLau
         oimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782815021; x=1783419821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjf98r/hrw4t3YgSzoJNbJCdT3mRw4IABG8RvUCuBYI=;
        b=HxQNDHCGMxMH59kLBZU+knXaS26L1fAX4LyFvlW5dP6cygwdbmZvXgQa7KLglRZ0Oq
         fFtUuvDoiTZ3MYtb+qyxs5rq08UUxj0lCTICVq/lJnMvdaOJN3RZhQDCRzGJeMduUZx/
         9kIYL/faJyuEFhssVgrVmiarAdRRQGAEx13ynWhBGccknnG5znXGzr11RxdVtlyDd/0+
         jfwdsE6tH0QeMRV611kdcwdGJy9EvySzujslgJjooYkTuwJwYxSJJMBPIdQcTLyEZy1t
         UhuUQ487jpingNnKB5TcTTGjYgxP8hmcBfOKr0UtvudrEkvZ5AD1gjKPL9OEh52M4+xL
         iu0g==
X-Forwarded-Encrypted: i=1; AFNElJ8+TlsBfr7lsSRitAqe67Lnk4TumS9u8+0WhpzgHF29pbkFe98bC3CAIw6muwLwC/jidN4Bx/b5les=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYL44JFgM0E17fANH6xviDsfOI7drnpK/Y/4Q+DyZECpOD0z48
	kQ6csLAvXjuyb7xTzDn2zEo2Ge9WoSYDjuX4V3ysUdUb79eXVB1SNOKW4a5Pmlm754TuhawFXE+
	nE4e28oWfgE+4GsIxXq2rfhPLYk5apekYVft2LGMi00vNVQrX2mUtVHaUSvwZnkg=
X-Gm-Gg: AfdE7clB34qx1HNnKk2pjj9nfbPNIodoWUjknSL7sy1xBURa90DBx0VU+S2DMg6w03M
	50oXaWlemL8PrY1ED/Fd0WwfY9HoulvfQxAJB0Zd7X2nmYKqVMxO1MH8JKqnizjCUFxBzCAPHDo
	YFzbV9jNa59hwSCaZ4Q/MIV5BFB69mngQDevwc/M6a20oWp7iDcvC0lFwEx1SUMiR/k+VXlTXAc
	K5ydVe/rh0tIHwnxgLtNC5/mGGK0c0jAfHhyDa2GBYDy5i8kG+3d3eUrKXYSsFcuu0UhCxhH/4w
	3MWT4dkFBqXv2xiOY9w04uIPseWBQ/2JSXq4i17DNsTfpV9Mmypl4ppHGYc2ExfuKOLk1hcf4Fo
	ehwStfLX3YDh4DSZzl/TrsbVd1l5C10QUV9r2erOYZQ==
X-Received: by 2002:a05:7022:4381:b0:135:578a:cde2 with SMTP id a92af1059eb24-13b2a1c0abamr1761520c88.34.1782815020906;
        Tue, 30 Jun 2026 03:23:40 -0700 (PDT)
X-Received: by 2002:a05:7022:4381:b0:135:578a:cde2 with SMTP id a92af1059eb24-13b2a1c0abamr1761496c88.34.1782815020347;
        Tue, 30 Jun 2026 03:23:40 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2aba8008sm5339274c88.11.2026.06.30.03.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 03:23:39 -0700 (PDT)
Message-ID: <ffca92db-a3ac-4345-8477-1f53ec61ef16@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 15:53:33 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] arm64: dts: qcom: kodiak: enable inline crypto
 engine for SDHC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>
References: <20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com>
 <20260629-ice_emmc_support-v8-2-1a26e1717b85@oss.qualcomm.com>
 <ba96f5e3-6b6e-40b6-b6c1-300e862e8ee4@oss.qualcomm.com>
 <d3be45ab-0390-4d0e-8d5b-330a48c529a1@oss.qualcomm.com>
 <1a0b91c6-5e17-4330-a8ab-ac14d3339024@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <1a0b91c6-5e17-4330-a8ab-ac14d3339024@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5NCBTYWx0ZWRfX830I2/tWxvj2
 sHgFiD9lsm8AYh2in0y3X87BjkBvsh6sXInzosrZb21v2f8HgYSxQy5wPG9KCpVTqEENRvunYeq
 aplLVzlFuHORwE3PKk6FDzP1rBth5IYJ7rYK6f40FEj45l+bERJD5vc8OKucF8FmDbcssXbvOAw
 IVmbgiCWMumGvgpsYUgZR2Lx+pZ/XcjMxGUEaqsBSfMB+9I6Tb9U5wrh8YtqTUPOlBatJDcXUKI
 PtAHtvuqJYfHGPlXGgKeWPfJ3cnMdGM8PUvi70VtmrrQNuKB//F1FnJJReA11pBjxvRtOMkUB/Z
 ZI2Tdq3WOPTyoI5Dho+q3nFJ0DhJSgNysrahv0ZWhn1YVdv8k3tlh2/S+QpaboJNDnZjsmv9kZO
 RPuvJp0nnEdBQWAIDg9uLuYK/FVSUCoyLJY12rx7PSCtzqlQ3fExq6qTaY0hr0LX8jtKtysW/MN
 TLOXPP+d584PZ23wK1A==
X-Proofpoint-ORIG-GUID: INDLIWIAxZMWzpciJFMaeFO8IkncuIws
X-Authority-Analysis: v=2.4 cv=JqbBas4C c=1 sm=1 tr=0 ts=6a43992d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=kz5X_B4VHAOF4V-UfckA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: INDLIWIAxZMWzpciJFMaeFO8IkncuIws
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5NCBTYWx0ZWRfX0ABxMt/Th1ir
 h4YQuszaOLJtGh3ERo9kmBqorOfXeHrX92cWJlRyic+LahQk8RpW2wfkP1XrFLLg3yOmPn34OIb
 voIj58H/sA/oPnHN3gHvvaHBkC5e3k0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300094

> qcom_ice_probe()
>   -> qcom_ice_create()
>     -> devm_clk_get_optional_enabled()
> 
> If we remove the _enabled suffix and put a ice_resume() in ice_get(),
> I believe this is no longer an issue

I see your point.
devm_clk_get_optional_enabled turns clocks on, whereas using
devm_clk_get_optioanl will only get handle but don't enable clock.
Please note, clocks are needed at probe to read ice hw version and then
later ufs/sdhc fetch ice instance using of_qcom_ice_get() and control
suspend/resume path.

But my idea is, if storage itself isn't there(like sdhc on
qcs6490-rb3gen2) then why sdhc-ice should even probe and check hardware
version? as there's no significance in even probing ice.

-- 
Regards
Kuldeep

