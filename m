Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1153F88BB
	for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2026 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484150; cv=none; b=Oy1QHAA0uXjZ8SBH+26lkaVqRuB1ns/HBzFLSWE/2lnDDZE/SfRt8/MVHuf1fAG5UcVyYD9oY8YVy6BUC3n34rd8Hx336tPF/wf5SzwmJOJhzR90NoK8uIFiTJyuVprbQObeb4NmReaQ3UxXT5n6mcrd0qqP8kK9klLgDcrQ+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484150; c=relaxed/simple;
	bh=AB+GTcl1o/ZMDBuERbDpLhIle+9RFK/hgUm39nWcIxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndCJtymDwDGyKpstuz6icyKsyE65BVI1Wm5109KrEaPGh1cyuTFEbfcQuR7uali5nz2nRisgfyuhHHv/C185Jwvfve8spTL5cdTeCnP3//sPu5ab9kfLXIJEiReCoaLct0qu4XapHFnu8OeH0ASNSnVJlV6Ajtje+3dPT1Px4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KWlLs0Aq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O8fMmnv+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KWlLs0Aq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O8fMmnv+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAcoar3384292
	for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2026 14:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6KoXdf7c8yIFK3RBoE1eVqiW81sTwkSyj8rODkD/LDI=; b=KWlLs0AqBc46ktpa
	eifBVrPHksPB6eCH0ohP2IWaIwtquL2DZvv3sPBJudHNtO/RxalGVdCz/N6oI3wr
	kOqwzo6iLCa1Zu9p2t/4o+pYc2nxOCblSZcYlmLMm1Hbw7NhD2ODwsI1wpwPBlU5
	2K7Zg6ChGxpcbDAifgq0qagkev8Wn5aUcPzGKAaNsHOehHZ+0AE8/zQ3zZJiU0Lw
	1f0GCbcJlptG9MDEIvUhbBXAhe/nlX378yph+Nvt5Li7pebt4aWmf6vfFhxOCZU6
	NxgkLXMwYNOSDb0lkNYITkIU0K/fs81lNqeaTuQco/BMxTFODvPCOpM33N8ZjBJN
	t/9MrA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f19m3v5g9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2026 14:28:59 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-734f236d7c2so39322137.0
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2026 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782484139; x=1783088939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6KoXdf7c8yIFK3RBoE1eVqiW81sTwkSyj8rODkD/LDI=;
        b=O8fMmnv+cZ95tJO5vd9kGbjxNf9fE1Kv2nvdU4kOvJZzxBzdQ9CWfESSFIOY4CkNg/
         HlEi5xJyDsBsLekF+zC/3Krsh7p5/fMXlCPvfpVtLQIIPp5KbBfb/tGLnxOaIQoXcK5F
         5twX76zqgZgGPt4joLiPe0jl2ObkE+OoqHz//4A31gJm6TY8vjhgc4zK6W2o83qGKzQZ
         zYDcrRViv/4pU/Of5Nc8RNlcEG4z/zTez0aHQVadaaIx77C+QGfSkq7wF9C/hl0b8zD1
         TTd4VwHZOWgUmQXMowl6CZqT11y50HnWkzeSO6ZTHFpzLUiQw1qbuTSIc99WAjvZLevF
         sQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782484139; x=1783088939;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6KoXdf7c8yIFK3RBoE1eVqiW81sTwkSyj8rODkD/LDI=;
        b=n3+hPqQjF5woqqzhl6n0z3ZT8edePwEmqlG+0vxw/1l3/X5D3YXOEYWDyiAQw1n1my
         I4hD7Mte8MrfEwLf0oyo3CiVUzl2kPg/11BfARKCKIIKCsnZvfmbsR3IQ4K3EO5WU0Bi
         PtWLNq2AtcesSwc5DCg6GMsNxqjNJJQ9w6lkYKgdjZHSrhEgKACHv0TIUDMGaPNKbot1
         EdraWsgL0nfnFPvaQkyiVjTE2rZJJOFb9dz8Y3tm4YwX5aug5EYmtjCHE/iV93Fomgcu
         JTKSWh72p5ECYANeNFeyXPdE1vLIUApnricSkKl7tHsRmCnnob4GQsuabDvWvN6SbjGj
         7E7A==
X-Forwarded-Encrypted: i=1; AHgh+RqY+ny2zgmrco8O9EG/qFQAqtkfVo5W1OvFrlZDPStoK1O/z/w1emz3X6g6ygR09zmma5aJBIDi9FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFWp7TqShqQOmOZnADIJcOvFBIl+iepQWMQp3miVp/qSL1YeF5
	1Hbhk+zui0VSgvKVpQGXwSJQVPeLz43kOFcqb0Jfcw0YXtZlJlpAz/kPtHYEDS5KcLUU8B2qMMy
	XJr6spG1E2SRDpjkXQC91Qu7LQeX1225te+qOu46nRdpmJvzb2hsWXDncXDr45IQ=
X-Gm-Gg: AfdE7clYp3O1Hwm5m2v2ya7YK/iKDC5dczKqNXnfP5bgFkaqc0Uj5XcpBxTYVkd0dw0
	+VgJ64K8E0/mKSX3WHqOuZboYmJtYf1OYc62UzwzJ/QIOvJGLOUtD5YgrSMZRWlP4wx25wK7xIK
	v0yH8047KKOcHvDs+7ys025z9PGKAj7Nm+DkanwhymAOXB1lsQToZ0q49GXG9g7eEA04TiCJ4oB
	MzGJduS0Pb5wkSGl2x+jpTBDDZ9hBk4oqLzaK4CTUoMtWnAb6xNPz1vhjVgQ+UCGaNIM84y6ri8
	t+DvIc8mfM/W4k3LXyPHveaGaHf7hwXd255Q7dIussFj0N0pmYuuCpBoKCNGmqMud8xe664eX98
	jjmIM9TAJoMaMmlZreqZtR86bNlr2BQ0XyHI=
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1248995137.1.1782484138846;
        Fri, 26 Jun 2026 07:28:58 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1248986137.1.1782484138384;
        Fri, 26 Jun 2026 07:28:58 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bd36adsm2993408a12.27.2026.06.26.07.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 07:28:57 -0700 (PDT)
Message-ID: <dcd6f0e3-46a6-4f57-b4a6-0b9362b1a8c4@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 16:28:54 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/6] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE eMMC nodes
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-5-1cebc8b3275b@oss.qualcomm.com>
 <d8fd7888-cf7d-47e2-8e77-3ba705c88502@oss.qualcomm.com>
 <ajjmXMKdWzae5qqk@hu-arakshit-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ajjmXMKdWzae5qqk@hu-arakshit-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDExOSBTYWx0ZWRfXzraFALrS1dFH
 dYIvP5T0B4RnIj/ibIySRW1i3WIbYAr2gdUlPC4XNgmxnf4rMc5wbcXTYKLoG6llzefCOp//AuS
 UQPMTW8zJd7+PXeDja0zCBHVDUzJqHk=
X-Proofpoint-GUID: 3n31qYzyd2N8FVTbrsz9tKVsw_9BVIhf
X-Proofpoint-ORIG-GUID: 3n31qYzyd2N8FVTbrsz9tKVsw_9BVIhf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDExOSBTYWx0ZWRfX/UG358eLvhhY
 08BkRgkpa+ASvnTseKuH/wKDln2y+UB7Gaw6kt4we5z2oD2I3pldXhx6ETX4l777ZPLxv+Z7dPd
 ALmUWgQst05eXsRSehZQLsY7wSxYeQLOWEhrW4saM3y26ZSR/BzYrv7IKeAuLsV+wpcAYxyff96
 TbBSkChbty9nqTSlBDBRJSPdNYjMnB/tJFXoHI6GhPluxH+3BUAhzZzK7XjPEurwa+/763+5ydb
 eFcTjyZlcq8CQBg/ZiWvD0dfolKhffoSCMRFXkxK02IzIiTc5d9d1ai7pCFM83WYiPgI6rYjeSB
 Vw0xaGZ8d5YWNL5SqKxvZQABz6KBuz9fo4fldSgGhT8w1V7s3ATF+9lvoNRjCwbbB4rAyUholFH
 owPCNwdQRupozrjc8EuVt1OfpHbQ5SWd3JLtcNOSqDH8LmumJa8oTFJa8tSLpFl7fhLvQUiAlEz
 EcKUzG/frbxRW/TmO5A==
X-Authority-Analysis: v=2.4 cv=Vv0Txe2n c=1 sm=1 tr=0 ts=6a3e8cab cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=wUXJofhvmvxpLSIlt_IA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260119

On 6/22/26 9:38 AM, Abhinaba Rakshit wrote:
> On Thu, Jun 18, 2026 at 03:04:57PM +0200, Konrad Dybcio wrote:
>> On 6/8/26 11:47 PM, Abhinaba Rakshit wrote:
>>> Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
>>> an optional OPP-table.
>>>
>>> Add OPP-table for ICE UFS and ICE eMMC device nodes for Monaco
>>> platform.
>>>
>>> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/monaco.dtsi | 37 ++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 37 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
>>> index a1b6e6211b84d0d5008231c55613a0ccd61b9450..d9298d8b7874b8669b2cded2a28a99dce6eadbda 100644
>>> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
>>> @@ -2742,6 +2742,27 @@ ice: crypto@1d88000 {
>>>  			clock-names = "core",
>>>  				      "iface";
>>>  			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
>>> +
>>> +			operating-points-v2 = <&ice_opp_table>;
>>> +
>>> +			ice_opp_table: opp-table {
>>> +				compatible = "operating-points-v2";
>>> +
>>> +				opp-75000000 {
>>> +					opp-hz = /bits/ 64 <75000000>;
>>> +					required-opps = <&rpmhpd_opp_svs_l1>;
>>> +				};
>>> +
>>> +				opp-201600000 {
>>> +					opp-hz = /bits/ 64 <201600000>;
>>> +					required-opps = <&rpmhpd_opp_svs_l1>;
>>> +				};
>>
>> Since 75 MHz and 201.6 Mhz require the same power level, is the former
>> OPP any useful?
> 
> Yes, both use the same power requirements. However recommended by the ICE team,
> the DT should include all opp/freq supported by the hardware.

Is there any reason at all where the OS would prefer the lower OPP?

I think you at one point mentioned some dependency vs the storage
controller's clock frequency

Konrad
