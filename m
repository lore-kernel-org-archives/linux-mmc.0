Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376942F3618
	for <linux-mmc@vger.kernel.org>; Fri, 16 Jan 2026 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546261; cv=none; b=IkxHw8337aIJ2CR5RsDFCLryiSpgMJeQe+sjk0Ub8R3Zv+3x+1NtKI87kfhKHNmiL43pX1l5uQB6SmrasgTqxUUI9TuZpxLA7irgqWhFITRlJC8vgxbgxqVgYTfRlrcHKanj4YJt6B2EDc8ZC1jz7O6zPwqdGvwMZ4q1/v7Xews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546261; c=relaxed/simple;
	bh=BA4ZPU/cXu93ZliGQHfyFCqbPhHm3qleH/fMJSr8a5E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eQAZVRD3UW9m1FfKaMVasNGhfHB0jMrBZqHLFWkE8oZxMsNEZ4VkSWLfYr7nlULJCvDvoGpAdAMaBDXBQENmo3l2NAMA1HWLEQMZWuVPtfzU/lZAhZ9ncSPOuCDKVU8IVak2H2ikZGWONroSrGNnGNVgQ/PTMDTNMW4c3IRj+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fdx4nKKl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aWf4pSRf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fdx4nKKl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aWf4pSRf"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMbYEG1240908
	for <linux-mmc@vger.kernel.org>; Fri, 16 Jan 2026 06:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F9hfFdMp+vdKY3MRWWiYYi+Gv2S3Eb4yZE1YVXqmDxU=; b=Fdx4nKKltnrwx9wU
	zIYNbwwXem7+25eyZwfPTpDy3p+kvo6v1vVJKlY518xsUGbCAv3EcCKFlTRbFGHV
	jt2pXj2E5/oTCASSGGF4s+PbibeA8qlLkLUXe5MC2zmVFm3QpZeUlHVeGI+jssr1
	vWGd2o/b17/VQEbpwX3h5mxtI9Rs8AI827beKTOJPOZB8FRDnerSXcqlu0eV944q
	HBzgZZ180uhHTCrD8aoSBa/WDdptfd0xFXbFiX4hRsdp9mvnd/Go0/OwyEdDEZIH
	FCx3aG1vyMDd49ZNwFqRnvFkDl/aw2n69WTJJg+xDnatnqF6dsTVIMA17pudxFPW
	Ff7SwQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96ss492-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 16 Jan 2026 06:50:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b471737e673so2485543a12.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jan 2026 22:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768546258; x=1769151058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9hfFdMp+vdKY3MRWWiYYi+Gv2S3Eb4yZE1YVXqmDxU=;
        b=aWf4pSRfP1YU4lW9VsRF8mQy3gZD02NqPpMogCe+/anrUNdR9z9ad+Z3Q7ynCtdh6b
         TbSEo+QdnocKvvRivohSNWteCQNIeVSbDzOunr4ee+GJgsG7U26SBvBXJmXC01yw4oAW
         EjGQuq7lWFxPwQE2HcpDvoxyS7HdFGGwB5ktHgjLRmgUmkbDUMeKq0R8qnPQ3xT5KZWY
         kU+j8fEhMjF1gXcSn/x2Ug7qQIsZ7/6Ssuifz7WEceJgXFZHrA4IQs1WX7Ts66yaJQ8k
         xXzUFNfFHE2w+MVwqSlttJsQS2vn5U5tZkcG/FqlayElRp6caexyy5LohKtxSU4CqbAo
         4oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768546258; x=1769151058;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9hfFdMp+vdKY3MRWWiYYi+Gv2S3Eb4yZE1YVXqmDxU=;
        b=RpYtgdYuXbndXwP51xdtj0xaIq+CNrGbmsqxB4j8USAxhhHkpS12eoJQ+TGiWihX7i
         bS19AxO1F4BWNUJdABGRPt9jBOzzHsjD0GCDlGEUvTXNukNM5HqLROERJXx3Gt0DWcqK
         dH8pmHL82UmXOIXjW58sai1Lo9oTj3TPgEOqoZOxeU/yIvpm58fVSm4lFKyBWfvUp3zg
         aAMKYIJfov4ZHzR56VbsjhukFSCFGNgLD5Xt13VXcDMVZRio+tYo6HUvEk95b4bQip6q
         Lm4dqGqdPfyIq7k3T81e4yjJ319wkjdYmFdto7DyooXL1unoeXM3YXbgMo636e+ZNjsb
         kMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbVUsWcBvra+3URP/MCKzpYGawcNzDTIVcqfcO0k3EMQbeFurgmju6uIwDt5iENW9amL3sZi+HaBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziDBB3G4h5DW4vYQKJdfqB7udJOPd21lw2YDCzuFyV+6EnFE/R
	nzMQTZZQd7d8BO4OR7C6mknu/yctKX9l1oosnpEjHwbmOjrzDok1ETSp11rLmc+uaxxsCZwuPD2
	Z9WmEDZ5RbSCx3pIrOdK7HXRYgHlFt3QWItXQbsbGh+Yvkwu1nei936gE+rcSAYk=
X-Gm-Gg: AY/fxX5TszdViVC74o00jTyZOMfds5nMQIbwBjjzc5Bm3xTSuxS3tPK+ORwK5gLcf8Z
	YSeZJevkjFoVob88jA5fnQse2NAbAEoK+pAgtG3qupUT8arT/Fub9ifUpGLJJw4RkCRn3y5z+tv
	HsEQzsni9QTCIHCe1Fgiusps077zS1QdmzeFduf2OJvMZql2lz6IqGd0JTMktKWCjLO5IBzQmH2
	KdgEcuYaU/DTVBhyvj8dkBCnco4dYkMlXJ/vVr8AcqdKQQV9TSEqUMtk7BxpRR+IzQA0o3fn4gr
	BUwJarcJfdz1YBoRTrtnkZ0QUEZhW+tbi1W7mzMWywwfw94Qt9NNy7jjTuihHeQlAVIYmXeCchn
	Ez/cs6ItE/Ubvi111xm1SRg+ebR6IoupKW713048=
X-Received: by 2002:a05:6a21:1505:b0:363:bb19:ed30 with SMTP id adf61e73a8af0-38e00bf65f8mr1652656637.5.1768546258533;
        Thu, 15 Jan 2026 22:50:58 -0800 (PST)
X-Received: by 2002:a05:6a21:1505:b0:363:bb19:ed30 with SMTP id adf61e73a8af0-38e00bf65f8mr1652633637.5.1768546258060;
        Thu, 15 Jan 2026 22:50:58 -0800 (PST)
Received: from [10.217.223.154] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527312381dsm1128659a91.14.2026.01.15.22.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 22:50:57 -0800 (PST)
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
 <20260114094848.3790487-2-neeraj.soni@oss.qualcomm.com>
 <20260115-intrepid-space-meerkat-d44ec9@quoll>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <ce49730e-75d3-87fd-3190-44e45cf83fe0@oss.qualcomm.com>
Date: Fri, 16 Jan 2026 12:20:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260115-intrepid-space-meerkat-d44ec9@quoll>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wECL2dkFITMroQ1xQ5dec72pdmTbeNsk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA1MyBTYWx0ZWRfX89UyLThLH3P5
 cXZWfcXKVj+YLV1ij1RueYFLezwuPZl1XJR2xS/K7IIoIIqZAwSGKd02x1wMFVw5JWXfcR1yPUh
 8PCBZkgSdAPLCif1+rWoxTUFTUHHxS9OHJkxzQ8tm0aTr4iL47gRBWBAokw8GEtUC4WWgEI5v1+
 27VbsekSBMHksxaukYgEQDu35IL/BK/l8G26gzPYn+WZgvgVk7VZzF2r4vTSfqHa1ajYoY/rzxD
 i2xaDuvSwwfl+qPmM4fIZPdEsqtiLwLy5YW6luNMTkloF1nQFEYfHFwOYY4k2log6XvsfAkKDSF
 OhajErulgx+HsM6UYl7U9ssEZ1aI5de/eoGJrFAOolFHHDTgOuCsLXnVwCKTJw1eXvFWD1B122h
 QpxwZKCLVDdNcksHcoZoHzWCsAOx+daC64cYzEbqOJmi+F/oiuhqjD7itdZpaUbut9Lq6+PwNhD
 //D/qsdB+E8fNyk0XBg==
X-Proofpoint-GUID: wECL2dkFITMroQ1xQ5dec72pdmTbeNsk
X-Authority-Analysis: v=2.4 cv=M9tA6iws c=1 sm=1 tr=0 ts=6969dfd3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=lCUKn3xyVXRm64x0VdAA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_02,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160053

Hi,

On 1/15/2026 2:33 PM, Krzysztof Kozlowski wrote:
> On Wed, Jan 14, 2026 at 03:18:47PM +0530, Neeraj Soni wrote:
>> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
>> So add the qcom,ice property to reference it.
>>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>> index 938be8228d66..8a6a25ceabe1 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>> @@ -140,6 +140,10 @@ properties:
>>      $ref: /schemas/types.yaml#/definitions/uint32
>>      description: platform specific settings for DLL_CONFIG reg.
>>  
>> +  qcom,ice:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: phandle to the Inline Crypto Engine node
> 
> Description should also say: for what purpose.
> 
> You either have this phandle or ICE address space on sc7280 and newer.
> You cannot have both, so your schema should encode it properly.
> 
Sure. I will update this in next patch.

> Otherwise you just sent something which already was on the list and it
> even was reviewed:
> 
> https://lore.kernel.org/all/ba3da82d-999b-b040-5230-36e60293e0fd@linaro.org/
> 
> You even copied the commit msg but did copy the authorship!
> 
Sure. Thanks for pointing out. I will fix the authorship in next patch.

> Anyway v3 and v4 were not correct and probably v2 should be used after
> adjusting it with my comments.
> 
Okay. As i see your comment in v2 here:
https://lore.kernel.org/all/c8eea30f-5ea2-cfc9-273a-3c6e99a316b9@linaro.org/

i guess what you want is not to drop the entries for clock but rather capture it
in the "description" of the ICE phandle entry. Is this understanding correct?
> 
> Best regards,
> Krzysztof
> 
Regards,
Neeraj
