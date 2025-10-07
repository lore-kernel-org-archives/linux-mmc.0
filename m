Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585CF2D9EC2
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837343; cv=none; b=G1EawMuXmEcWygqTrWRbYbN1doASoduk8hvnT2daYvWL4hxBn3sDrOBCbJOCTPqN+2yClO3q7MZpp6iSRt7hV2j0G+ZsmjB621xhhDkhGKCMfvhR0szX6iC9OPKHno+Brk9fgdKr+wo9/YrznK6NW4yzhpZ7W8Ns5NH54fYKHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837343; c=relaxed/simple;
	bh=v0istXODWIHL1ltiHYtAZ8N5d97LsN0HcUB5gpH3dT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHXZtRc7tPxikapoHXOMP0r9d2axQ7z8gyUTdwvidfZvroj2zuke+dAs83nYYot9CcnpPA00xyFEDIaIt7ZBPqznSHkXu9BzNMAh/Ha8X4UOEmTS+7EUFlGfINn+u1tQbJ3Tt2wgSvHtG3lZ2xAhQX4QzIdjo2kP7tt3+wKBYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HEJZ7KTG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HEJZ7KTG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5972v6Nd000970
	for <linux-mmc@vger.kernel.org>; Tue, 7 Oct 2025 11:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XQGXZvj+fHOBfHt2M7ZMsptXc4V1NWsTLPFuu0fCYV4=; b=HEJZ7KTGYM02TND8
	zMyYndX8ElSYmYg2eI1B6ARKpshVPejHauwn59rDm825JkFKqVrjy4rQC6S6pbER
	nPtBDdVhUhVUOomfFaQsaU+VVvSIMLXWFUFPxMKw+TiigzTqeina2fgfCzAfixoq
	qF/RRHGVofaf1SK51BnkRi22q4NARM1EgvuLgcK+YkjlD6drPgIxAZr1IRXfDVLs
	n3nw8cOgnv0BVHm6j0aOFub3cN5rFoRKfXPCU+DSYK3t0QklcYGnyAhwuYSaXiFY
	b1DzFXnZu4RKDcCnEPMNuzcJPPkP3MDb9AfNvnFIbHtLnSLTsDRlu7C7qfO32fOL
	OLr+ug==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9dy7vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 11:42:21 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-879826c55c8so12820566d6.2
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 04:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759837340; x=1760442140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQGXZvj+fHOBfHt2M7ZMsptXc4V1NWsTLPFuu0fCYV4=;
        b=k78G2LPka+xDm2kpYpEQj5+h+IwbUryj8CYy1ZLO+S3w58Dkl+WyRZmRasUxATIANb
         pvRtAsV0iu4a/ktqoYoas6me7KYArU2YCJkMrORyM2nqTkpRsNvpzfjLgp43ZA2/xzLD
         WFSrcLD6tERVfzdtboT6Opk/otmZDqWrVUUK4b534T/QJIijGM7kNrXrpwsGytUznuJj
         bsR3TUvfhAnZ8vAeevqSe8RRKX6X6gT2Xa5/OnC+s9phHvYqYUyxVQlUizOwBlRF6AzS
         1tZTY0CStKxfLdbzGEbj5APml3hTuYrEBEUIbhsK5PckiLc2kdWHvk8v+VGJ/tkr73ES
         dwKg==
X-Forwarded-Encrypted: i=1; AJvYcCVn8IOvH+xnhWTHx3PHjx1hU6XkEuD9pyyUd3z6CiFr54kl8hAna3i3G6ujHkf7a0e+MuS/d8JryB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kHq/+RdoNdCAv4mmlAfoD+HQnMm141HCLilvgd1fM7rJeUla
	OoREowpp7LFrqRivEJwGxsbakw96i7iPxsBMR8ioDKEdtqJVO9MsuZYqGamg81xStODwgeXL1QO
	aqJdbVZyWW9AX+EYTIWUz82p9g7JRAW+6FdIZzFjlUlxS6E20IRJY3oAeUuScY0g=
X-Gm-Gg: ASbGncvHsugO+SneQWxc1oWUyAz9Hm7+nefRyH+siW7WaggwEF2EaetpvevoM4DY3yp
	HLvrvcw1JZN1pFWXU6GpGFZjZ5i/tN5GTtm0T/0kURHmRUsYbHyl6kzvsdNzCWlwFxSbGtszWr2
	dde3DpK29cYBX8I/hv2UkwliWpNalbNy0bbFvpPj9w9Mm8a6h4+ShWrFnoTTLq1OyO+a9ceubym
	gy83WWr+3RLCDxpqMtctjjGRyr6nYpdDQ3k6q4TK+oIRQn47wllH9RPu5SLMjmTBEovUO9J31oU
	oEZkoYXmqi3T52kANpDAAohZSUPukeh6+0pyS9Sb6rl+YFXqY2BjyieUSgkltpY+i0GAyfMwLyu
	DQ8c3vqZqp4gJM1Ea/l3g+jBuoB8=
X-Received: by 2002:ad4:5d4d:0:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-879dc8e8b5amr134636916d6.8.1759837340101;
        Tue, 07 Oct 2025 04:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPO0pc61D7PrUDHek89IoEYYlLKOAWdzRK3cyRnVKS0r8C4VHw9zr6UpiSxFXAKmAVKcrTbg==
X-Received: by 2002:ad4:5d4d:0:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-879dc8e8b5amr134636436d6.8.1759837339372;
        Tue, 07 Oct 2025 04:42:19 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6397c9355c3sm5880830a12.0.2025.10.07.04.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 04:42:17 -0700 (PDT)
Message-ID: <1d052b98-4dfd-4ee3-b46f-ac043b406d58@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 13:42:15 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add dll-hsr-list for HS400 and
 HS200 modes
To: Ram Prakash Gupta <quic_rampraka@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sachin Gupta <quic_sachgupt@quicinc.com>
References: <20250929113515.26752-1-quic_rampraka@quicinc.com>
 <20250929113515.26752-2-quic_rampraka@quicinc.com>
 <20251006214830.GB625548-robh@kernel.org>
 <817f02aa-dfb8-a134-2fd4-fbdf8e8a714e@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <817f02aa-dfb8-a134-2fd4-fbdf8e8a714e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e4fc9d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=Nkk5IEO714fOIWWTyTAA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: D2rEZ0PRfW8H_KnDSHFxMgbsNrz1XfOy
X-Proofpoint-ORIG-GUID: D2rEZ0PRfW8H_KnDSHFxMgbsNrz1XfOy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX17FFs6CSRWJI
 QdgAeG140ZkfvC4Oc4zCZnhMG7ALlJ7HEWJ/jgirLa2atPKu96b/WoVurNirF4ZSP61UJ/m4eE9
 4LEIVE7Aaeezy2e7ZCwYXcXqfzMBOrqvZQUh4pqtJWmfszNMQqmhuSecigJZs7WrfopCbde3ZEq
 gf9MgVxppIBSMgcnw5f83gHi99b0nUe7LjR58MYPx5/D1vkUBBxQQ1HsVFA95XZ4XuDiw8wdLbY
 JEuu8fajizgy/UFGPjLSCMHWQnzE9rQRKBgTsrsLTmXkVqrT6R0GZHiATxAvaXNekR232Z08t2I
 SVgJwhLHg7DL3+st9NqsYmh0xvzFShHYh1SqDpwreWz/y/23tWWRSFUMJS1eLYjJDmPX1dOg3cX
 6tvDkO7VKEPjZCMrrss6ePCC5aPJog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 10/7/25 1:16 PM, Ram Prakash Gupta wrote:
> 
> On 10/7/2025 3:18 AM, Rob Herring wrote:
>> On Mon, Sep 29, 2025 at 05:05:12PM +0530, Ram Prakash Gupta wrote:
>>> From: Sachin Gupta <quic_sachgupt@quicinc.com>
>>>
>>> Document the 'dll-hsr-list' property for MMC device tree bindings.
>>> The 'dll-hsr-list' property defines the DLL configurations for HS400
>>> and HS200 modes.
>>>
>>> QC SoCs can have 0 to 4 SDHCI instances, and each one may need
>>> different tuning.
>>>
>>> Signed-off-by: Sachin Gupta <quic_sachgupt@quicinc.com>
>>> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>> index 22d1f50c3fd1..a60222473990 100644
>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>> @@ -137,6 +137,11 @@ properties:
>>>      $ref: /schemas/types.yaml#/definitions/uint32
>>>      description: platform specific settings for DLL_CONFIG reg.
>>>  
>>> +  qcom,dll-hsr-list:
>> '-list' doesn't add anything.
> 
> list was used as there are 5 dll register, but '-list' can be
> dropped, and it can be renamed to qcom,dll-hsr, I will update in
> next patchset.
> 
>>
>> What is 'hsr'?
> 
> Hardware Settings Reference

Maybe "qcom,dll-presets" would be more clear?

Konrad
