Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846A212FB9
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757281; cv=none; b=bb0IQY7SlRqBaUKD2VMXQCtCIxkwy/dcxUqh737poQ7CWYupdMCkDnfLXoy1t2Xq11anM7sKa38zHna25bk6ukro3PYHwmaEuESeJzkIdmw9zMjp2YA3tz1iLGaFHdl3obk2hXRMpMcbZEjy4knu6iLFj+tOOjnIre0mmqlKxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757281; c=relaxed/simple;
	bh=Colp3J1CtUUxtYunOSxTe/q94oFmsL/+dkEwvdrbzqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXHu46i9srBzmHyL+eiOWy1qMdgWOmi3mi8vyVIwALGuK3EAcxypZAJvtxnG+GA4UoK6yhGRleB+P1wyRTPRl+1x3Q0b3Iz7Il7Roq+TXCoYdGkDZ3oqjPFNreu5fm+kY5z/zUDOxWmoLWYg4Ng3PAeZD91eKWLf5EV6h9jsCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jJcAHol5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ig82u5ez; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jJcAHol5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ig82u5ez"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9KZwI11278568
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 06:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hKUnVQ3iHT+UcmDjXNspHD8cD61G/kra1wg6N9IeAe8=; b=jJcAHol5IkPm5dZo
	JTbrrcz+LRU7LqYdjjjCg2MRokDcsDmnvVJrRQ2XtMBYPMXrN4AycxPYpUsRMaCY
	J2l8qwywE1sRRm+6+vt8x9RxLSFCQI4mbQZ4ucJ/XvlTL727tkl8xSN/+BYhDftX
	xqkz+oSM4kVjYFbkjq5LqXz6zWdlNjeSlP1Tvj2XqoVAsup31d1tkSO/ZGGlCxeK
	wLS6/q8dma/ls15p5q/KrnSlzgh4DVxR/2rs+Jrfbpn3aNQuhKxyqo5g2MPyEaQa
	yZFBou+EaKf+x7NNC9xD+N7d4LkHCqSg4BWzBsvQmcNYXLzKQ4K+UBnd0g5X070v
	SiUNvQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xs7bp9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 06:47:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a26a08b97eso326920b3a.0
        for <linux-mmc@vger.kernel.org>; Sun, 09 Nov 2025 22:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762757279; x=1763362079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKUnVQ3iHT+UcmDjXNspHD8cD61G/kra1wg6N9IeAe8=;
        b=Ig82u5ez/pYfn83Vrp+oQDZgeimyr0V/U6aGsXh6LFWKILDFTjZR79BRdF7oN8ot3g
         seua50LZthO9qRSR/A9rlGIX+EIv9vyYXt7Sk2ofCApOQ77+jyxEORw3Xs+8QDLcncjX
         IjuW4mrmRs3Cp+ciHtJuA3WoAJF/LoS3hjT93fLc6NeoSiLeZB97YQucWddAz60TLvPD
         CGN0FoM6BrTKOpLM7hv9xfvM3rd1rOMwiNtD1VmQH6QVb7l1jl/nNQ+nKEIn0+3cSvfn
         qWIOXNrqHD8X8S7g/9euqVTwOoUx30rdC6R+h58VqAXR14hVrlCC/oGum6SXBf/RayD9
         Q6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757279; x=1763362079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKUnVQ3iHT+UcmDjXNspHD8cD61G/kra1wg6N9IeAe8=;
        b=ns8MtS3WHbALLbmiMcar1OpWeyGhMqKLcO1tTH2Pafc99hytu7qZPhCIY8DLCzDOB5
         jcIL1IbxhWKno85GgvBSV9kXxgxM3oQtMj437/K/e2hRpdoLFwUJTiUUmTg60nXjtzK7
         wms1mHfIWVUHE4uNHqyItqmALuzNl7yJoOZ9z66MtCzINpsVpnZiP5ndJROWJDewdhAb
         +MY/PLSr3k4R3/Xcc1lfNKYpCzKiaVV53GV46HEgMbBYUMeh2DEsAY8uWnxUQl1Z60MU
         f3hvRzzD4h64C9U5i5kRElTugWzUX780oLpsFYT7/alstJmUBNeS8+jIQtMbB0N3SwoH
         P7hg==
X-Gm-Message-State: AOJu0YwfFYEmkhDlF7T6d4eSE/H40pNkgo8gBxtdOIZTIPKsizL4dwJE
	aOW6rSwQqMPxPIPk+tKcxu9GRfGlx1+6ojFaLUP8ZnYtBLqR4GbT7oqiRoJw2eNh/9pTKbEmhEK
	FnoCKHwl5CJAaUYh7hH+w37j/ApAjiZPQGOFuLla0K2Z4rxFxNqvDSD3BQFqKoQ==
X-Gm-Gg: ASbGncv/eZ+cGwusfc/D8DB8H3478WRxC569juRf4LuKPNb9BylbDXnOyUQyH8C9aH8
	oXJEa60Ph9O24RUWIlMaKGqHnxv/Hc8092rkYR0CMFCCSX2eyk888AQIAqzFiNp5/xeC18OT5jp
	TR5KRo3KSep/BcgQRGqHwccWo2El7qYKqQ3+eVBDLj4uOm9HhyN3e4+uA+KQwwlqtBCKGCFw1Wd
	UTy4PKkpsSi2kvRpmBbq1jP6afXB9Cg4xio7B1ZUYj5pjxSW8xJp6QlfhMt07kMpD8cLZv/yOWu
	X7oJ81EzbypX970S4NJNReYulAY9NCmgyQEKhnS+fyU+pGZQ4N/5WAYmJWDEMR/bplwicCIX4O2
	uFV4l7e6fgMsGtxU8mnmXPgHKsxMo
X-Received: by 2002:a05:6a00:2190:b0:7ab:4c7e:a9d1 with SMTP id d2e1a72fcca58-7b226999ea6mr4593589b3a.5.1762757278694;
        Sun, 09 Nov 2025 22:47:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgWc5pnkGSNwJDR7b/mhuRmkoqM2U37Z8tRqk/xuImnRxiqjCHoT5jkDMdFqNIO5Yv44sPdw==
X-Received: by 2002:a05:6a00:2190:b0:7ab:4c7e:a9d1 with SMTP id d2e1a72fcca58-7b226999ea6mr4593576b3a.5.1762757278278;
        Sun, 09 Nov 2025 22:47:58 -0800 (PST)
Received: from [10.217.216.168] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm10372943b3a.34.2025.11.09.22.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 22:47:57 -0800 (PST)
Message-ID: <522f353b-7965-467c-9951-9829e58dc681@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 12:17:51 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/4] dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
References: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
 <20251026111746.3195861-2-sarthak.garg@oss.qualcomm.com>
 <0c791304-928e-4075-87c0-bd37ebd8e351@kernel.org>
Content-Language: en-US
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
In-Reply-To: <0c791304-928e-4075-87c0-bd37ebd8e351@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wjP_oNfjT8tHgpIbbMtd5umQgZgeMifu
X-Proofpoint-ORIG-GUID: wjP_oNfjT8tHgpIbbMtd5umQgZgeMifu
X-Authority-Analysis: v=2.4 cv=LtifC3dc c=1 sm=1 tr=0 ts=69118a9f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=EGUEwqo9yqTfsl6hxHQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1NiBTYWx0ZWRfX2JFlHvnF9ON/
 nrT/4SdCQaF7nu5/IxoHNcVbE1hLkbAEhhL9Tsf1p4iH2clxfEtbSejd0vUvIK1o3vA2U5wQK1n
 Bhhg8mNINzrqXzvmxnGOZK+BK7IhjMBSRZN9pJKretDMtmejsaDTUfE1jmApjZjmlpvtJii0Bhj
 LBhvF2wqR6gm4pVxEwd1rGS3JRZQq2jmwB9fk+/P02w74FIwS7w2m73rqCUGh4v0/lXeJzaa9EO
 j4XvNilpPAnX9VOvTn7kXmiI5pIxq/xbNwLnvetKQw9p+SuMYufEsNU5K3Chtf+aIOMj31KHZnk
 qe0CWXMRp36PoL9xtgNBIFvMD/i2DJ4t1oSNmvj4FHHXaVbe3fjn0zDW4ajvWaI5s0coz27Bn2v
 cNThIiDBV7VkBhyS44zTFfQg49yhXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100056


On 10/27/2025 8:00 PM, Krzysztof Kozlowski wrote:
> On 26/10/2025 12:17, Sarthak Garg wrote:
>> Document the compatible string for the SDHCI controller on the
>> sm8750 platform.
>>
>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>
>
> Why are you sending third time the same, even though this was applied
> long time ago at v1? Please do not send unnecessary patches, this just
> clutters people's mailboxes.
>
> Best regards,
> Krzysztof


I had assumed that we need to repost the entire patch series regardless 
of whether some patches were already ACKed or applied. I’ll make sure to 
avoid resending already accepted patches in future submissions to keep 
the mailbox clean.


Regards,

Sarthak


