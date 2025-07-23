Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A282BD59F
	for <linux-mmc@vger.kernel.org>; Wed, 23 Jul 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267029; cv=none; b=aB+6+5WOmeBTLSWP395YY1gwpZTNASieXnxzLjelXbMQG5vPoe7C30ddX+R0qEffXWOZ1WnMMQGEuYcjqr6uoRc6ocG6NL7XCQ3JrfULeITLMDZwdsoExFu1pREs74lpbswVUco3Tv6MIJBNjyTYKLjgCydwCvaQFM9r3SXk+j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267029; c=relaxed/simple;
	bh=VZ6H2QqhGifjHQ2Cq+ZjqLjogniGh02DxOQCdfNC8IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vp7Pq+XeTkkULPJgwpSwiYW7gFC9IcZAIw03X3ZAcEChz4nN1/H7U5P1NF+e9JabkGlOyCveEEZ7Wqyraa+cWWtn8+Mwl+oRxS2fyGpO9ql2/HJsfokNVMRXO11XjgZXsi4HfBy6yhxkNDLVVvNrDkVU6vOO9XJiuOQ/fhTdIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zv1I/PdE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zv1I/PdE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9ekZP007879
	for <linux-mmc@vger.kernel.org>; Wed, 23 Jul 2025 10:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c3WPPm6RUB+edcD+yYLNUyD+huQyOSescoQcJtylh1s=; b=Zv1I/PdEDk7aA0q1
	FINhBwRDh/LayvL4SnyhTB1So+vWOL9HgMkPjtiXjvs/t2RB381UOUPA8GnQhXgr
	e/lmqLi/vYAJ/QEPYJxC+dgTdZkgumz9Bq9ngpqx1juCssJU7Ytf1lULXSppiEZm
	tQan85pPIEBaSjYz5YKB/OHnINwMaYDpE3QdhlCAEj5Sgu3K71Gq+ZMs7vAF3ECs
	TvhsNaKcnyTcS/Tcv9f6WQwuXb92QhTj79ippoeK5A97ev1SYuYo/yMyAHdXnTQH
	YTPQkwsugld8ascrp3XdK8WUMt+p3Iy7dw4L9+ehX8IN72yoxlEkwwOg0lI0grGP
	T9wC2g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qcths-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 23 Jul 2025 10:37:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7de3c682919so95411485a.2
        for <linux-mmc@vger.kernel.org>; Wed, 23 Jul 2025 03:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753267026; x=1753871826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3WPPm6RUB+edcD+yYLNUyD+huQyOSescoQcJtylh1s=;
        b=ZxRWIn0u71HFVZH1ym+zn1GI7UkOI8uRQeUJTlmm+brczfvdhTWz2LLVIGoOlrqrij
         tZ32dJlZUrzqsl3IUPTy1c15kuERy1u3H/y4L0nY34gFwX2AL/UUtTSgrr/aq3sBlxWD
         RfPXXrCdn+KLJDNxJ6mEvPhSz+CgaZn3lpH+WMMFqJm33EfS8R2FAUBv+Ruo1ZcaL+3e
         VqwrP1D77adEAkkvqeXpa+xO4Z7TlmWt64CqNvKfx4sqX6ikw/kd72kPOD/ARwCQhLbM
         pon0qfzaKrRbWtmYRfPkzO0BJhbpHineSB+LzJewj+RAD2t2wfoLUlhbnuN4/18uZdKE
         0TyA==
X-Forwarded-Encrypted: i=1; AJvYcCXi2+w5z9GGiCBB7/UUqj383vbPLqMqLmj9vmOsh6m+HvG0RiYboLcGw5/lgSG5mHuarudSGIEpIuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0nCiqkDBrsA8GSPcHXRQUsmMGnMQ4tF1CnlzDHeV1JHeHbOkv
	DZeSqjl0OM4zcWzUImawnXKWsbjgxMr8OOoZJ+5kbugWM6JdMIow0uGW+730m+oChSBsWo4mD8j
	bS9Jx8T7iS1yzaNM5/cEnPoT0bFa80Y4wil4h5a9sZgm7aKLesTeNr24wbaZI4GI=
X-Gm-Gg: ASbGnctjI7SL5QoWgSOmItoqwVC8YOSUA/B/XCWdJ3VpL4fydG1vReWS8OjgmyMOMD0
	wyTG3p/G8jIoDXiANtesLUzSI/dKzZJu2VhF08OdVKWtdspELTq1gIeG8Bc4QTIbTfN2lXYqI7I
	EvRi6FJ69tvHyz9zqUYWz36y2YzmEA+99/Cjrjv8lc28EdlA0eQtqaUHzUrWJEv8U5kAKGi6MXs
	kcthnZrmFjoSnCMQ4o2oywn5Ok/2aoA8Txu8T8bEoespVCNLZsX10lxIInGxXpuRA3O+9xOT33h
	YG9QwkbpTBDioYuoiF3HpewRkoPD1/e3rdb4hsj8lRb9vHV4Pb90mhHDTfTaok4x9n3I840lDF8
	WMmY4NpHKEubtGAYVPQ==
X-Received: by 2002:a05:620a:2609:b0:7e3:3996:f491 with SMTP id af79cd13be357-7e62a0a57c4mr134094085a.1.1753267026385;
        Wed, 23 Jul 2025 03:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf4hV1cEmi4SrXNUuipDGElpSF5X/2irJs3VnwL9DVxlwxrsZDYzctE6f2Vdwwz4dC9NujMg==
X-Received: by 2002:a05:620a:2609:b0:7e3:3996:f491 with SMTP id af79cd13be357-7e62a0a57c4mr134093185a.1.1753267025970;
        Wed, 23 Jul 2025 03:37:05 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d89cdsm1029598966b.62.2025.07.23.03.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:37:05 -0700 (PDT)
Message-ID: <2182b484-9ccc-4ebf-89f4-519646958413@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:37:02 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/4] mmc: sdhci-msm: Add Device tree parsing logic for
 DLL settings
To: Ram Prakash Gupta <quic_rampraka@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sachin Gupta <quic_sachgupt@quicinc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_mapa@quicinc.com, quic_narepall@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sartgarg@quicinc.com
References: <20250122094707.24859-1-quic_sachgupt@quicinc.com>
 <20250122094707.24859-4-quic_sachgupt@quicinc.com>
 <6xvsnmbnnvpmlgvmi42pt4d3ugkrxhrgrkp56szqhgh2foxe72@z4ildfxufq7j>
 <c6ca33b2-f8c5-66e7-bb3b-dd595ed040c5@quicinc.com>
 <d0af754d-8deb-041f-8e34-1c1214fccb09@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d0af754d-8deb-041f-8e34-1c1214fccb09@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4OCBTYWx0ZWRfX1zr06iLKy25n
 nE/RPm6XLEYzPQkio60vbXcYQ4R5AdjBc3BzrZA0+XyYs1NlpPCcqfhkBQvi5SRmUyaaY2CaG+c
 TG83uT4B9DBHeOgDoGKEsgiwC2VRMGcadIQRZHJ6jkQYZ1OceJwTELLfmhqVVU9ZiJaZzW2EZix
 qeQSJafJ88zG9AzeCQYuqSD1OQuptJ5uqULjenVIb+Z4eSFI/Y/RQZO42f141l/qvn4BBYHUYwx
 5Ch0caDqKb4+zimM3B3pxG2qzvIg4MsZhVG1jtHu1BQnhbkT31TrbSHD/OGrKi09QnpFM1xMkdw
 Tqn1yNPWBeNChM+Xbcb4KjSH2cCMmsFKCoGJEXvaHqDiAzjQ8n1v8C7VK6Ir5ca4b0YZQ1c6AlI
 x7L5BUYGbcu4cLEZ0LraGU37jKlPCXKyGkqJkS+QAFAUe780gj5FkTvEOIFC1NvnCcG94kdw
X-Proofpoint-ORIG-GUID: bowFdknWQZsuYXotEZAayolyJmD40zgZ
X-Proofpoint-GUID: bowFdknWQZsuYXotEZAayolyJmD40zgZ
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=6880bb53 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=OTpidQhUJuL9SOIRPhwA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230088

On 7/23/25 12:14 PM, Ram Prakash Gupta wrote:
> 
> On 6/10/2025 5:47 PM, Ram Prakash Gupta wrote:
>> Hi Dmitry,
>>
>> As updated in [PATCH V3 2/2] of this series, I have started now to continue
>> this work. Will address your comment next.
>>
>> Thanks,
>> Ram

[...]

>>> And the pointer to dll_table is lost, lingering for the driver lifetime.
>>> Please drop the devm_ part and kfree() it once it is not used anymore.
> 
> ok, I ll allocate memory using kzalloc in function  sdhci_msm_dt_get_array
>  and kfree() after copying data in this function.

You can use __free() nowadays (see e.g. drivers/soc/qcom/mdt_loader.c :
mdt_load_split_segment), which will dispose of the memory when it goes
out of scope, limiting the need to clean it up every error path
separately

Konrad
