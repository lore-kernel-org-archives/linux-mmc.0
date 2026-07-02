Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6838E10C
	for <linux-mmc@vger.kernel.org>; Thu,  2 Jul 2026 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975219; cv=none; b=eNItfzq4oYLUnjQrlfK1mKVjTJkGh5BZ4+miMCop5CIf16e3XwaBwE72TiNQHs39Pxps6zpqhXQvcek86Pn3mE8pTyCtF6Sx+TIvmlFnPmnaU2dd3TOl/fCl1GLiX7qq+/D5F6OOK7zVhp1OZKV104rML/Xi8v9gV/cI3tSK3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975219; c=relaxed/simple;
	bh=+4b3w6JmV1B0LZJw52j1qed3WNOp/NfO4qp3OK/aatM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVvrJrhUEonRG5OfiFQVT2Buj8dnOmVE51qV8fyaoCqhTG/v2RsDbVVMPYKg/Uctg2sGtySvCDyj/tVxDAtSE878IQl4kViDH1NetRA9sawZUAAiVMfE+kz3qPWjdvnumRGuQpyZOxj16cYDpft4lgprIE21B19Z/xELAb/01xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1aSo5Fj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TNQ+Itdf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1aSo5Fj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TNQ+Itdf"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KM6I3050683
	for <linux-mmc@vger.kernel.org>; Thu, 2 Jul 2026 06:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BHip0Kz7buAzWxIlIF8kUD1bXgXidWDoAhK1k+rP8l0=; b=Q1aSo5FjWCvGe4xm
	t/kmK2wpQ4rvcpgGyWYAh6HtsmUmb+YgJ/CrV4dsNOyzFTM0UGngY/ztD3R6lBfO
	tQ6IMttWxrdEi9/qGIB34BDYQyFVVT+obQguohRSyVLpVy1L1NkZ+H+89nRzGUdE
	r2ZQuFlgrK0xHIUoapaL27LxMX4F8KRytIYl7O0HDnMqc/P8IYY90It7eA+ZFS/l
	T86FauypaGcnnJEgKqA7EmDuD1BxBS6OBpDT/SQla2oSRg/I6TQ52enDvzcUQ/P5
	Ixh9Tk2irHT3BIneZ20/gjAr/2Ra/CKx0BuPFND+cJmp0iLJhMers92901A99gR9
	vZ2wNQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f56gptre6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 02 Jul 2026 06:53:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-380b630c4e9so1090795a91.3
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782975216; x=1783580016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHip0Kz7buAzWxIlIF8kUD1bXgXidWDoAhK1k+rP8l0=;
        b=TNQ+Itdfn3OB51EKHyfuW0JaXYuB7tfapNsW2WD7X5Tc9MmlQ5WmnGtFAyHnEXXUWb
         nXkx1u3NwzatgYfYkPNwg+EpyW63LgPoQHs+acZX9Wyy0AzpXeLSni3zgNCxLr3IRBzR
         JM9Yohx76QCM9qW+3szIfSSoHq2edegqwHpXYmX4UMvAjj26wYq4GMJXNSVv7v+zsJfz
         8LlfjzeeT64MBTN/MtWzcr9Mya3kmkYZvwCEhaZb6okDPcLOusPWE/UKNGnCVoTdEonA
         lZNXXHH/DDgi0Xmg/BZKUwtQdmCICy0mfYNzJrshiqQfD96gXWunQzgtgAHCCerWI6Ba
         C79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782975216; x=1783580016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHip0Kz7buAzWxIlIF8kUD1bXgXidWDoAhK1k+rP8l0=;
        b=GrWBQEUOJBPdhCeE6Qh2hL4RayCVeTJNsdMAvzxWzVQgPIJQ4+KchJnln+1O1R+gsM
         gCfOTCh4XZruO524E8oiOpyBW35o2ESQ2owRyCxCG71Ql8odHnIV7hPOiuQD60PzyvbE
         0Qi6L/nbur+Lk0YhzBxrcfwIh08u47Vj5QNXEPYs5w/pwBEKszjDZXinOo7SPh0QeQV/
         /Km9UVMuB8ZKwiP9Xq6VM9oXLC5UhvATpIAWYsIjYJzVEm3H1XZRHEG7pwzDVIDef/58
         QRf0B9H5O0t1eNLNqS9JvmZW6g8i3GcQHrFL16UtF8Bypwk/deRe8XbKIWTabmRDA/51
         vpPw==
X-Forwarded-Encrypted: i=1; AHgh+RrjZQn4tL7Sbp3UHKXYIxogFmytn1HAJFgKs7NwNu9qsf9dsIrJOVcHDO7gDIZuR2w8Do3LOExB0cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhazeHIZd6ZA9zwAZVKETPxXUZhk+6pSiXEP0BhbYpSQy328lN
	qoAdx8r74AhNznCyow/XRYwxEP22CVu8wEvd/76Vv3wkK/i8tvMD7KFW+VA/BLzEHaolZ3Pg4nX
	4dDSVoDioqvLJi2gL+W69HU0pO+jgN7SHvUdWq6BJBPv2vuDJ1By7qwbZsG5d8NM=
X-Gm-Gg: AfdE7ckRKhXDPZ8xhJPyzeL+8g++Go4yfhqNqtrNkk+SpeeD4yRvkv7minrbg7p3Z9U
	LBol2JdC2TP5cVCSR+GvzI3OdZsyzXmKjWBTJS5Ir2DdC4qzd16KtO1+N2SUk5i4l0yn+Z1+1PX
	CU43FE7vKv0Dk0PNmm0KDEevyYBqIW7hxJA2hYtec2NPU5ZdFRo8Jm6c1FEy4CtMe2g+jU8iKp0
	/6vSoQiW9S21QzI9eZ2EZAhwDPK7YtAW11O2jl0AjyEjpJBtgQj78wfEj3PPDT6qm+wA9pjjkpc
	46VT0YplMJOYNq2Ojpy+6ZjtMyiRBe+SnOG7svJEtMXBP5TltKLItDSLhr+jloljTYSKXcdBCll
	tuRk4P/I6sLoHDiA1txiDJMfzoeGSq39WYKqESXu8
X-Received: by 2002:a17:90b:1844:b0:37f:c2a9:468 with SMTP id 98e67ed59e1d1-380baa6b497mr3981926a91.18.1782975216279;
        Wed, 01 Jul 2026 23:53:36 -0700 (PDT)
X-Received: by 2002:a17:90b:1844:b0:37f:c2a9:468 with SMTP id 98e67ed59e1d1-380baa6b497mr3981881a91.18.1782975215737;
        Wed, 01 Jul 2026 23:53:35 -0700 (PDT)
Received: from [192.168.1.6] ([182.77.29.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e1608b23sm551730a91.9.2026.07.01.23.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 23:53:35 -0700 (PDT)
Message-ID: <08ed6b4d-5549-4aae-9967-1365db0e3aa2@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 12:22:57 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] arm64: dts: qcom: Add SD Card support for Shikra
 SoC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
References: <20260630165700.1886608-1-monish.chunara@oss.qualcomm.com>
 <20260630165700.1886608-2-monish.chunara@oss.qualcomm.com>
 <b43691aa-6d1e-4df0-9d1a-cd5c4b3e3dff@oss.qualcomm.com>
Content-Language: en-US
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
In-Reply-To: <b43691aa-6d1e-4df0-9d1a-cd5c4b3e3dff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA2OSBTYWx0ZWRfX0YISVutR5B0G
 up76fGfUMWTfyvLTi3Hj7qWCshWBmesd0bJu4n7ZMC5DXPzCc2iJt7CkHcnJ/lr6r16xAQb2yTQ
 eUubNR1lWxdVB53UJyPEPqghlnybCCc=
X-Proofpoint-GUID: 5bn01aXlEFq-8peFB5Xr74rLYnNJKoR7
X-Proofpoint-ORIG-GUID: 5bn01aXlEFq-8peFB5Xr74rLYnNJKoR7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA2OSBTYWx0ZWRfXyO+caawA9ymV
 VHKXpc+QWB48i3e92gyWqUGaexhi9SIHQRAbgfZ2hdXl26tNBPGYHaPIr7yRr+FXOnX5N/I0VNc
 8M1H3SnDCL0oP0VP0FKAxmdeS47xO3MfaKA17uiO1ZqTK/vml0lCJyTzFTdqVfZEMxZTIMrj2bf
 qI5vpXBoyvGsFCZLoCKP3tXdpxH3+eK1DcVCIzuQbf0dP71r9alqKdAZsa00bLmw6jxaT9tDhwT
 7U3qH9Cxy1nw+KXE1t+gvDGjeRouLzzrPWikRvOoH5lHlu5eJXDwGBbEi9tKryz0pZxRgKBkshE
 VJS6fCxv/O1DasPmy2YRFI/nUR7ABUUMz8zm7QLKk4CyH7TmeTdKvKea5Vq6zORLrjQNk7zrxdG
 40JR0NljYoFLDBKrDw8ODby6WZwZzCfyTvvW258s0u3qY0QcFGAAynw1Sf56txDYaudbVvldiAP
 dv9Zvo+DdSqzNybIW8A==
X-Authority-Analysis: v=2.4 cv=K9oS2SWI c=1 sm=1 tr=0 ts=6a460af1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=1qKOYMtCOh3zOq8T1Y2cZw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=nutul9sAWFEbEiaF5vMA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020069



On 7/1/2026 5:07 PM, Konrad Dybcio wrote:
> On 6/30/26 6:56 PM, Monish Chunara wrote:
>> Add support for SD card on Shikra SoC and enable the required pinctrl
>> configurations.
>>
>> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +		sdhc_2: mmc@4784000 {
>> +			compatible = "qcom,shikra-sdhci", "qcom,sdhci-msm-v5";
>> +			reg = <0x0 0x4784000 0x0 0x1000>;
> 
> Please pad the address part of reg to 8 hex digits with leading
> zeroes, like all the other nodes
> 
> otherwise
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad
> 

ACK, Thanks. Will rectify in v3.

Regards,
Monish
