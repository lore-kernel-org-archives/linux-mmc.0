Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA3026B75B
	for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153581; cv=none; b=XHToprccMd6ceMciG/oBdX7sxsqnfiiTuItO76mjQEjjzhXPyari7qkrmGTkvq+UxqMvBE5QmSM8CMGJn29jm6+1EXg/YkvWcdNLKjE1EY2XVJ7QWF/CpgD9IMAv039xaNEkuysc6F/2i7902c6jOIt9Hkl4aooXQl/rgJV+HIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153581; c=relaxed/simple;
	bh=gOQwJElKrLlL+KczaQjBEU0WOC+y5P4gVQMiGU5ncQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVT14/MnaOkyT8H1dS70npvoQPNUdzkw5fmZvYdVQj740WaY3Ldwyd5yjVEToHc9b2cUZCUugonqOm+1VkpF5tpOzXiNBUPpywoUxQZ0YynsBIAZpUMDK8ZUgurG7iYv+S7gr3oPMz+Y8ZhtDn8lv78eK2z0ZjjH5vD2FC5OvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EVWQCw0r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EVWQCw0r"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MGLDVx006339
	for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 17:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ObhDx2qKilPXrpU/ecszP1sikcNLUfUe5WUKxrKas0=; b=EVWQCw0r6O7WujXl
	Q7FsvceaN/p+YMzjCUZ4WD3SMhwUnWNjLavMDJ3l1HEdHNImw46Lpo7YhZKWXwiK
	Lu82CGQH94Jqkjr7o/2FhaU6kNo2EoZHdxgW/bBNdHUaTlTX2U5Vpiodr5iYZs2q
	EXPAXYvoOek5eCLpZRicIbRByJEvSGhdCyUSfBT406E1TG/oQOGRH6wwiRiR874j
	5njdBEGx2LmXDej1Tw/mpNx8s9fA2px2uPk4uh5RiAe+B94TU8W2RxsxMJwdokkx
	JtAiH1W7GYHoi2W/g3qz4lPTdvoUHyTkb7o0ATLTSKQ0pIpKO1oIHBTizVYyiMGL
	0SjH8A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsb3j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 17:19:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8934ae68aso5841811cf.2
        for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 10:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153578; x=1761758378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ObhDx2qKilPXrpU/ecszP1sikcNLUfUe5WUKxrKas0=;
        b=WSK30o5/UvyzcFl5o7fLaoXnYv5jzYJWilVjk8YzBfArvFK5BTxavN1dDfATluvRA4
         X8Tbr4WYcbGOKrWv1w90jocKKKQFJHFXZuxvSjFAQesji/YlvjGtJBDeQdSsvqSMi0S3
         nVzaf0UO+fsea9t8TeZc78TYIt4A9406PppbP+EgIMCW3HRFIXh3qjpgfxRrMRASWx+X
         Rw4v3UbPRbL+yQMa9baK/ipvk0Q73xPDOPPUDIc6ze0/iYfgroxwG7F8mhv7jTIddcq4
         /euji98Fp7mnVa6TRn1/vQqZ6S9tXAaTQHIAC9XjaAcvVsQSZ2dK/KNL4OJdh0go9Rpy
         YzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Yot0g/ZcYA2SParqmI/Hr24Jsu24Z4ZF38PL3eo8A+kcGZjWOFqmWHPXWtutPD+1eiibCspT6cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFIqa7ZoA4Eola/PYNcbaEAsinOheNVbq03ZjVsjvNjeE9TJah
	sGDBwClIobFvTXdEQ3Tc92vaFncaUS3Z0fMKql6Fz2B2sbQqThqZ/wlwMbKbS4OrMMxCzFX9EWH
	p4tTxXQfxEeezsd4ceIHm5IRmVfl2O74XCYMnmMp7AJ6Y5mn6BGnm7lKVDBSU2vY=
X-Gm-Gg: ASbGnctyXP32yeLlkhueDi701xDZIdDij9YHIXHUyH68k4OCVbNQt1gJ7A585i1oC+P
	wMlsX2cifu5HshT9WfqHKOtpu4FlFeZzUQbMMWMUAlwV3niR/E1GRR4IIxEEXvlrpRoLk/GIJKb
	38JfmnJVsmlIUgtU3wEQTlgwEqpyehEc/TxR893DA3kOj7wKY7YTmc1CnQODctRvyQE/vOjmaOl
	mNgY45Bl9QNt2y8G6OuopIEuUfRv43LrR5Qvg3Ei8a8w9e9GyJefw55Up4wchYlXwQ4DCudtIRg
	PhJfTy3j/2iitPzSNiAme+0dMdFy5RylfLdHKGIfgBwYeoyQcDNoML9DqisgH+HgvKAVcxOuNq7
	aEBGd6nDg1pxvXcUBVjuzmOnjPZ3S6ZdlYw2lB2Y/PD0St6yuBW3Y0Jgc
X-Received: by 2002:ac8:6210:0:b0:4e8:959e:440e with SMTP id d75a77b69052e-4e89d35aecfmr132575281cf.10.1761153577553;
        Wed, 22 Oct 2025 10:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1reHXf9fw3+r5fcINDoVpcwTbqNCUu/7wsWRAFjR33coa1mmho1pVdqG0TLpKriqCc6KFvQ==
X-Received: by 2002:ac8:6210:0:b0:4e8:959e:440e with SMTP id d75a77b69052e-4e89d35aecfmr132575051cf.10.1761153577093;
        Wed, 22 Oct 2025 10:19:37 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebe4a5ecsm1389504466b.81.2025.10.22.10.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:19:36 -0700 (PDT)
Message-ID: <32702920-19d6-45dc-bf1e-8a90b1b8c9d3@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 19:19:34 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: qcs615: add ufs and emmc inline
 crypto engine nodes
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
 <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-4-2a34d8d03c72@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-4-2a34d8d03c72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX3Z9uXsjfHkK3
 623FgkZcWbC3ilqp0msmeI90dyfx3YiHHCkqHrT3qmkJy7+gDkheXp1mvmJWWhkGHCYPvg2cjlY
 i5uso8m5gVgQw3wFljoi62Ews06wd3D6BJgxjbxXYTIHD066TpgNHZKZKVAq4mNhQJIuhPsZ74Q
 wpPsIaAB13tLKIxwaWbRAZt447eHXqbe6n2zQDGg4VvGFTI+vhbvuNATi20MgiHkhf84LUi+7Cs
 1AaqoNxWzbRsXUgIYWbGW/lVBAQC5/mQBEQgYqGUsvXPIzJGhp4BqzFZytjfE5BSch9g8LOB9Bt
 cJI//uThMDhpBRCBW05F5scqtUlbsQo4+VVH+pCNflly6Tc5OkYt+p5qwF7wfVz9E+RoEkRN/+9
 SAZ1xFKNVVAiOew55fXmh3c58dK7jw==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68f9122a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=FCLlhkshBCn6XtExdV0A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: kYc2bPfs36haLcUM_YaOA5wV8uamboPv
X-Proofpoint-ORIG-GUID: kYc2bPfs36haLcUM_YaOA5wV8uamboPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

On 10/9/25 8:18 AM, Abhinaba Rakshit wrote:
> Add separate ICE nodes for eMMC and UFS for QCS615 platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---

The commit message lacks a problem statement

Konrad
