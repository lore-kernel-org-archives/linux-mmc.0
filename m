Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01422F2E
	for <linux-mmc@vger.kernel.org>; Fri,  5 Sep 2025 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076489; cv=none; b=JOv+xi3bt05ASWSOUUIgWzCEQeuEpmx7vMb2uNdiUY3bDHSOU4DBheblpnirUDNtUm65I9gugFjZeyQmwGXQS3K0y+WUdtRrSPBGFzMQ260o8NGa7GvpsmRHfn9c/48h6FuNe47EeTGM0KVJShCpS9hxMIVDgdBc6fZ2yYe5d1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076489; c=relaxed/simple;
	bh=eP867im1PNQSlQH0RP105yUK43I1I7etGb230DP2KcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oct6XnHCQeCDZFlVbWVualIOUgGzHWHsMebf+9pwMJgT9CnAaSjhpMs+xXAdmjBvH+xUDi19p6XlG66xkHsfEALcXisjtU4AAY5wUwuIwVoOQ+G3971d6grnV4dXOiEThyyB0h1oQBo6qTfU/MtdJUup3m1JC5ilI5pr+kx0bFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hi6yo34A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hi6yo34A"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58557JC7017818
	for <linux-mmc@vger.kernel.org>; Fri, 5 Sep 2025 12:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ZVoQZK/NUQF8NTLJXml9/Jc9mpKZVnyeUkELKpWfaA=; b=Hi6yo34A4CSECkEy
	in3l+VwwNrdQ6GuihEaLSZ8pdMPQDi9lXGOksR3My2YGA1VKteV4zqqlwdEMzoJl
	B4lQpu6s1rmjeIWEqbH0YsMJANl8znAiyzkOH9Y2LO+pgTd5FsSw/xkI0Egp7tKu
	SC35tPxJBmHl2caBubK6NAHEwBUQzgKVbyGQoIXsZ/kEx65UwN6UqxGrGt3nMEFw
	PATPGNA4XaOZJ/VXljLilvqq075X2eXhmRYvbXfvaUqIka/dwLDHlY7oifDaUyNV
	ohIH/PlqNWtFc7RGCkMv6NYYYGfliyTPtPjOyhs2hInzVExp/zykB/clpvO1jzd8
	ufcaLg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebuu1ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 12:48:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-804b4b568e1so78978585a.2
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 05:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076486; x=1757681286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZVoQZK/NUQF8NTLJXml9/Jc9mpKZVnyeUkELKpWfaA=;
        b=NEqExzFX1tfqiWs8LusR/cLwNU4NVnrwV3u0pA35HlMjSk4QCtjyEuiHdd1/fkd3GP
         Cp7A9jDQMe4baBH78Z8YsN+zENp5up5O3iaNpfdX/Rn4xWLs7Z2pICHWoLnpMOOXp4Q9
         HD5UTfhI+wEb+F2LKpVOE45jTfeyGf/gQzCrktKTi88+DZSlICkyiA2iE+U6jVxqzzXo
         hPWz5DyYBmVVibSKNPUwz68l5Ssa8ERiRrScXoYyalFgEP3qAA6b8W/zrZLJ3+4WCSFt
         jpXRU+1kkOW31EeAzQGF70H1YIm/Ra8iSihPUGjixYNYFqTC6qmscxPG6AuppUDTbLIl
         OMjw==
X-Forwarded-Encrypted: i=1; AJvYcCU9SueFgrtq5kYm720Dj5kpDh+x80kEuZEX3FtH22FyRNp5vGE5XTCKxawtSpFm+Ag44PNlvRNsHOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWQb8g4qCb3UEZgbmVeyZEQ2kda9W8MLzoMfir9S3yK0fIsZdQ
	3qbOoy4XiazJKaWuZWJcSmuzyHgQKXa9pGEW+DcZf6N0+Fya9FJ0BXm6uga2WQ8/a+AhhXhOwxF
	B4RMj+//7Kwv53ZL4IC2iwYjQTGvzuFy2ne0rzAEWb5YJQ13mlZ4eQcHd741shLI=
X-Gm-Gg: ASbGncuEBTuFgcMWl7f2qyBV7tgjOxwIHVmt5YxYkXvHwHi0Eg9FOzKsAoBRRt+yKw3
	hOOYrntBS+hC5HQ0s3zSwZJ5m9Bgvv4TxLaN6/YeWBcjQSb/yU/vZ8llAi+LgOQ7XSQ03UFeJHq
	yxMfdwcAfC1srF3cuVB+WDFwfcp9QarRDZBbXgOqDI0Uc57xFAB7/QIqroLy2KK+jPyQTK2joXs
	njH0h/1ICT66q5F8Pt6Uzw4YnhM8xTBSQp+sRMx3Ko3IYYVcbQB29wFiIYbOegDgvyExylW2HsP
	MXw+0qQCZKTBlXiMEJdpz6zLo5nkSYJ3SGrn8raX4AQ+2bfAmOApBHhUrfmZdifzeDrb8DSju5Q
	kookbz9xRYSSWKocW0CU7PA==
X-Received: by 2002:a05:622a:349:b0:4b3:d2c:f2a0 with SMTP id d75a77b69052e-4b30e9a9735mr211937301cf.11.1757076486032;
        Fri, 05 Sep 2025 05:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2ElF7QOoyt6gf6FW/4zDA+dbADMgok/NNv8+HL6CTAMy+7viHFeskOkCiSzRQ+mmOfHHfSA==
X-Received: by 2002:a05:622a:349:b0:4b3:d2c:f2a0 with SMTP id d75a77b69052e-4b30e9a9735mr211936971cf.11.1757076485517;
        Fri, 05 Sep 2025 05:48:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0466a962c4sm694167966b.71.2025.09.05.05.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:48:05 -0700 (PDT)
Message-ID: <25489432-7cdc-4e99-b5a7-eb976df302f6@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:48:02 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] arm64: dts: qcom: lemans: Add SDHC controller
 and SDC pin configuration
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-2-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-2-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8tgPeAwz-XJymaKLl86NtNSWaTl0Xxhn
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68badc06 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=EaOeOJoe_TH6RZfqOFQA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX+O85/HKSrtSO
 paOlQ8v8oEHiYypTqD5gZX2OODlYkCJIByWo+qoojS+sSXseeBIA5Z+BV1YLmBlaFK33SPO6XVu
 WQxZTG2Zf+wbqbAxZXJinw9HeEVeoE9mI+POmy4JHZsygDIRF61YKM6NPlxPx6kZCoVt4TubnNp
 XsBv4OJ2PEemTP/X0ZCtFKXxztgVpLwWRdRvrJsCD49ex6+aC49g+9m+JY2GxwtPrC3X59rmrZq
 3qUXVvCEw9QUorA0gf4bXUmFIIx1kNoVNsCN0EhirG5UYpk8pKDFJVUeNdh32jOG4d8znu3MrYR
 CL1yqcMxPBT1ERjnJp/lEywnc3jOkJVgT6bo15/zKmXnnUMcMwYfGdzSejOf9Yi3lmFicFdMeGx
 /rFbFGZR
X-Proofpoint-ORIG-GUID: 8tgPeAwz-XJymaKLl86NtNSWaTl0Xxhn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

On 9/4/25 6:38 PM, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Introduce the SDHC v5 controller node for the Lemans platform.
> This controller supports either eMMC or SD-card, but only one
> can be active at a time. SD-card is the preferred configuration
> on Lemans targets, so describe this controller.
> 
> Define the SDC interface pins including clk, cmd, and data lines
> to enable proper communication with the SDHC controller.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
