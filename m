Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2ED26C3BC
	for <linux-mmc@vger.kernel.org>; Tue,  5 Aug 2025 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399294; cv=none; b=n5L7YTLPB2eovMBVKw0zW/P95CJ9481Moca+r+ER3jY2Eh3vLHBPMNRmd3DaGmI5snCmcSXkh3iBq1EeZ/y7IKScwZuckuIzAglfMt20VDvXAT/hVCBenSP794O5sdWLOqT5IPvuGBd9jOQeo7CKgI/2Iw163Ooiy8WmHyyK0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399294; c=relaxed/simple;
	bh=XMQ/CjpHTQ625oN346Fj4oJVA2n+W7fLJLcl8OfHgdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tenTmEAZOSM9GzGKmxERrogGHn9MO5OF6LpRvqexNuAFJT9K29RNpsw7aaw24hNvWDThnBAk9agBuv2pmqeCw29e2lH7Gn69xJX7lrO7JvhcrEdeJtwoEcuA7W7e9+FycZ6B/UTedYSrD1Ok79EEq/dlAU1LUEOpUB3ffDIJ8C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RNFfABln; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RNFfABln"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5756Kbnd006321
	for <linux-mmc@vger.kernel.org>; Tue, 5 Aug 2025 13:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V1RinYJ//EKx/XDr4zrnDSZd6gtIJfrzcdr6MQbb4o8=; b=RNFfABln/8ZBwmeo
	YpNeLxPvSeiJYW8CKNyoetOA57j/scU5Z6xZZn06OC7ht/+oH31RtOlYcJwK6ZfU
	TLROl26OBvFQ5IJQy9e6uBexblAfSZvfSsCMNVWSnF6AQnGOcWV9eT78PQdAuIou
	OLCmNVo3H26WhY0ehdIVh40ErOemT0tOpLK8DFDNFsiK6sqlqdxAmDvatsrtTcl2
	WgKy8QkPZgJqJC40eFC3J3lWIP6wVCBqitFJzfX8NYY4L9CuUWfLTix9vIzQAb24
	p31E3hFfemkLV4wbMCru+C6bICAercOjuJhb0eOsUOT9kG0LA5ZhMzsZGrQgyzi/
	XQn+Hw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489byc8gr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 05 Aug 2025 13:08:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e1d3bc3bd9so60890485a.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 Aug 2025 06:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399291; x=1755004091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1RinYJ//EKx/XDr4zrnDSZd6gtIJfrzcdr6MQbb4o8=;
        b=XWSc2zfjdgfgNjMpY8zQP4veZdkY8WEY9MMO7F2NPzkfGbnJHMJ+riuFjHVXuvdFOo
         Cp7ddwOXHnrnSeAD3PrZLjPZpMzYR77Afqjn6RSLwpBRrJvzQHt8/WS1jF/WTyf4vv35
         K8G0S51lQ9PSJhmi/Gz483HdsbABu4n6zm7GDi3gEHUcOUZmlEJFAYcJdL+6HcPZMuZM
         F+9/D5fba17gpsHaP3cmRzAWzj2j9vznLoOte6cN0m5zHn9+78J1QZyBIKH19uV5uAgF
         JsUo0Nkjb/+2/TrbWPJbaIsjFM79uCRB4MaxIqwpwVr+O8cUsfowiLJUdnZav+nHkFBo
         qQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCVNngKnIljrHuqRl0ZTvob79HSuZ99/YQAd12UVt98WGk/UVYVCqao2umb1f7U87sjp7V3+Lv3MmM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw514Y8Prmg4/HTfUO55va7HiQQTv7J3wixfNAe9ptJAhdSZRYC
	9w1yc0wWCWO5NbadoR3+1XWXIcf1hP5Di3zD73zEv3M4o6hJG8E7WxGEskPjj+E/hp7TSTG1v14
	xLBa2P14QAQndpIFOzpEnv6LRmlO0Kgnn0zCYPMWNRC47JEsVuq04835lag9mkq4=
X-Gm-Gg: ASbGncvawoKq+hvFPeeQeN/nsijUAKzlwqWmYRE+/W8dA6a3IDIsX1NJbW8N7xKxrCS
	4uEJX1/HL5fpjyBEudMZbWZ2M1IGro4EA86jXHSux4gjMsMXDHRVbudTTbdh8xfXdTfRxeEc2/Y
	VY8M0BvYxLLf0iTMFbZ4DCzGMnJg2KCwkV4MnKZ6qxMnmNnX3hgxPEwtYISnunhSDIL/cvkc00T
	ZEPeF6kkkIvIueQTAAU7GC8fkGndzaObqRz/JWJ68Kk5CLvbxH0Na3E1nxFnXZhe2UhlRs7q1Kh
	r9yDu4VkJ9SMf6bggSxb45AES8/EBmbuxVHmqALZ0STe3Bcm3w71BAFTJtMkKqhbb5JGHux+QgM
	5PtzxoR1mCsbHE0/eYQ==
X-Received: by 2002:a05:620a:3703:b0:7e6:39a2:3ebe with SMTP id af79cd13be357-7e69627a8ffmr993278185a.1.1754399290899;
        Tue, 05 Aug 2025 06:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzNz3BICSPsbshnHOdcR51KGwLa6oOSI7DAskcW2OrM/K4xCPKDoMD/yMxAl4j9/+41ZoXKw==
X-Received: by 2002:a05:620a:3703:b0:7e6:39a2:3ebe with SMTP id af79cd13be357-7e69627a8ffmr993273085a.1.1754399290302;
        Tue, 05 Aug 2025 06:08:10 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8306sm911353866b.83.2025.08.05.06.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:08:09 -0700 (PDT)
Message-ID: <5d5820c5-463a-4fa0-8ad9-21b75797aaf9@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 15:08:06 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/4] arm64: dts: qcom: sm8550: Remove SDR104/SDR50
 broken capabilities
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
References: <20250801084518.2259767-1-quic_sartgarg@quicinc.com>
 <20250801084518.2259767-5-quic_sartgarg@quicinc.com>
 <69f2807c-9a28-4b31-97cc-2756f0ab9fd4@kernel.org>
 <c7e36755-9255-4209-9d53-20077bd1d3ba@quicinc.com>
 <lkjp2353athoi76h3j3bgkcxdwfn6akcyyweipt4g774ztmmer@vcw7ru5red3n>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <lkjp2353athoi76h3j3bgkcxdwfn6akcyyweipt4g774ztmmer@vcw7ru5red3n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: abqMGXuRO0mAek5aohTsPUGrxlpI9uEd
X-Authority-Analysis: v=2.4 cv=Y6D4sgeN c=1 sm=1 tr=0 ts=6892023c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=36rLTHuftK6yE2Nq2w8A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: abqMGXuRO0mAek5aohTsPUGrxlpI9uEd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5NiBTYWx0ZWRfXzK/kduT782FJ
 SZUq3AtEVG2F2+NAbmrRP5ljGtI4+40RIYO3hrMbRqQTVePoB4CT0YpNTZqb/zHwi4+NzCa3pob
 J5vx7P5nmMEDrySvhoJ+yg7xUYyvXnDKVnMy25IKhyGCeBw2dL7/7Oad9Em5F68MJJCcm7fsvdP
 TnKDrTRvc+JVxQcs/aT4PuKjMPItHCsbfx1n2Iq1NxW5RkkdgA0Fcer5WVPVSxaLBtRh5phC/R4
 OUf50mevN73EqTJ393G9Q+ZeMinTlRT/fNoVhg86hWZZtBPQ0cBEr2VJTyTR944QVq1G1kQRQq0
 8yhIxrdWL5VdWwYCF/Abr2hUP/MczadU+bVrCpsGmvKa+nsGmtF9RetylpvcZOaptc4wFmO2n2q
 HU3jPtcsHLE4GfNwMNAx113BrxiHB1Q+s71Q7xe/hsJ7qymNA5/0i4YdQcQ9Hr7vjpxpsvXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=787 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050096

On 8/5/25 11:59 AM, Dmitry Baryshkov wrote:
> On Tue, Aug 05, 2025 at 02:49:29PM +0530, Sarthak Garg wrote:
>>
>>
>> On 8/1/2025 2:32 PM, Krzysztof Kozlowski wrote:
>>> On 01/08/2025 10:45, Sarthak Garg wrote:
>>>> The kernel now handles level shifter limitations affecting SD card
>>>> modes, making it unnecessary to explicitly disable SDR104 and SDR50
>>>> capabilities in the device tree.
>>>>
>>>> However, due to board-specific hardware constraints particularly related
>>>> to level shifter in this case the maximum frequency for SD High-Speed
>>>> (HS) mode must be limited to 37.5 MHz to ensure reliable operation of SD
>>>> card in HS mode. This is achieved using the max-sd-hs-frequency property
>>>> in the board DTS.
>>>>
>>>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 1 +
>>>>   arch/arm64/boot/dts/qcom/sm8550-mtp.dts                     | 1 +
>>>>   arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts | 1 +
>>>>   arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 3 ---
> 
> You missed several devices which use SM8550. Please fix that.

I would be in favor of making this addition in the SoC dtsi and removing/
altering it on a case by case basis, since as I explained in the threads
of previous revisions, the fix for the limitation is additional on-board
hardware

Konrad
