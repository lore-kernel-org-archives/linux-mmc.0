Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3E5296BA6
	for <linux-mmc@vger.kernel.org>; Fri,  5 Sep 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074233; cv=none; b=EVEE5qWGKBgDrg+K1gVCqs8rjvuBNBTtAKDPzSKCXR22C8pP3dqeJ0zGlgmaRgsghehkY+nnGQ+xlv3iwLDLxnN4ThnMYuvm8Bt5b+4DF0PUh6Suphb9SYzSCnIJ+KZ6ze/hkAOV7gJFkwPOeTR+IuFeI2N0HCeQNrEn9MD3qvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074233; c=relaxed/simple;
	bh=ErCJ6Ql1rDMt2vKVLJW9jn9Ni3tpQtFY2dmm34Q5uBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7+JNWFlCGbODU+tEYpJv4CrIWQWlSOyW8ZIbDrJGD/0CpcA3wGKOETnUsWnUMyGSki7CLgo+MH0orgm877BBfdPUkoIyYXtecfd/I4pL1pgFoUqegDLZjulkUt0abI4DE75g34XeqhUsB7bBsjC5VY/DcmHBWxMVE1gjwGRD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m0r9UQ4C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m0r9UQ4C"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857GFJS002355
	for <linux-mmc@vger.kernel.org>; Fri, 5 Sep 2025 12:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B3CXvHZCGtK3JzFKnruevi9kzIT/zr8k7RvjkNKrle0=; b=m0r9UQ4CLWMjutZQ
	qETbEc2XdgjwRETjCNkkIMt0KynIg4Qxw3/QNyNYNWIoF5s6EQK+MmTf8jkzQ1KK
	SlRMk0Y2Cn+TAsMW10hykObKOX/tZ/7PRIJ7tLOoNGnN2dZOPm7XzgnJKyGOVZmn
	FC85p/oGlW/yqEQvbmqO7FTO01Wu5ktI+iuC31bDI8/ydyfM6taqlZaAw9dwc+P/
	oxO2b/8jg+eaF4roRMEgRimjFezbnlVumB4ywh+Sckr2BOFj5tMpQKwOK1v1VuKy
	T5Rysd6oAMP0z2HdnqLBFPgfl+tgqE8TIyZmPkO5h7HZHYWi8LupJLaQ6Q+ORNds
	oCOtlA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush3ay5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 12:10:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b307e1bef2so5829441cf.0
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 05:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074230; x=1757679030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3CXvHZCGtK3JzFKnruevi9kzIT/zr8k7RvjkNKrle0=;
        b=i2mFn9KRF/GGGKD5gt6IUx6luAurGorGYxzKt90VuIO2nE6RyMa7SV1m0BVB6aqMUW
         qR9LM9Ht7K44Rjw+QXS6Td5wtBq1xoIl7ai75NjtahVkCIQNtpQH/EYu5a50HLlb0i0z
         xnv0eYapUfrjUqPzouhvd9TFO6RbxCvkhl+AL5/HsOaxitxe3G0bEALI6KDtPUsMx+X8
         TCVy4Z6u5GWNTLkkk3LEuF24J1loMw6nuKgMQS9hAjKhroKLQ53KqKy/Sq/dFHyHKRUR
         4D8d34SKKkwO25HEg4EMki5LdknCoSOMAu65qFxh473O+Fjsf/LCvZyn0ilEsRKfC3ox
         CZkg==
X-Forwarded-Encrypted: i=1; AJvYcCX3FWzbh1X6mPYtTO4eHdxPZ31CRD2OVV78lqhQbJsE6sbYWOZVHiXklZHPDxQMV2Y91Ri1ur9ybXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPBywrwP2OBfLRp2SvCQJWc10VD2YX45ZWeQOd4SKVxvKPaNox
	K/QHMhvlEzXDl5S9E+mM/IhznbEIUvuzMuFvag2MDeo4kN7lP11GHtJ6QQazpfubHMQbR7YB9c5
	P9CXRJrKrk+SFEzs2hlFGD+Nh4PqGCqIvuRGYSaNvzBewVUi9Zsuh394KMNw+LJM=
X-Gm-Gg: ASbGncuyxiHLvY0ijyY0Qn3ZmGa+2quPsP1u9gcE1bNYLlWoi9/KmgrSlIEd5vgQFu3
	4Mf0L1icMKSlbAARECncD2Ld6SqHZ4T+Cj/if0PAX+8mgT5vJTobYZzFkOajkgIJLpYBig5JUYt
	tnwr0Pqxfqrmka3Ue0CV7qYa8C1jE3TK9QJm87Oi5c0oyNJGLHbfrvMxt+zsaJowRSY9VY8nfdV
	Sdyc3EJfQL9ZvgZpylFPy6M7FYueLTL0/aaus8SumK0/PLNRx0tTZ1NUxAw+WH08zFTfgVOTuxY
	mb97fI91g3zY1TiTkF/xI0rU5qYPQ0JwdWeRgAmPLCTfxK6P/8gr/ixMB1nOkxRq6VF9tsQmE4w
	eZSYUTrJRaEUS7gQ3bFY9rQ==
X-Received: by 2002:a05:622a:11c3:b0:4b4:946a:df22 with SMTP id d75a77b69052e-4b4946ae541mr79002061cf.9.1757074230296;
        Fri, 05 Sep 2025 05:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/V1Ut9FoAm3PMIuMlaHnEJiGeKOqT+3I7Y49huAY9u92oCVKu3lzCxSzcPEtH0e3dxFF09g==
X-Received: by 2002:a05:622a:11c3:b0:4b4:946a:df22 with SMTP id d75a77b69052e-4b4946ae541mr79001621cf.9.1757074229739;
        Fri, 05 Sep 2025 05:10:29 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7caesm16131666a12.9.2025.09.05.05.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:10:29 -0700 (PDT)
Message-ID: <a61d5e22-6a0b-49df-a203-aa408856cf43@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:10:26 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] arm64: dts: qcom: lemans-evk: Enable 2.5G
 Ethernet interface
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
        linux-i2c@vger.kernel.org,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-12-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-12-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXxZXRW4HK2Y1U
 FOMM8LHFlrWK6Lj8PBiaDxbeZlvpbzqRdPi2uhZF8GE2laAgYEhArOtZVgF1TbdqwQtiwUHOf0q
 B43NphKekD8nxr/trc5ocPMTE6lchidsAqbdfVHK91GTbiwqHrIugykPmKUR74kQUJKJJnoq2BB
 +TNSLgHCX6qe3E0cwv0iY0k5F9dowkVAjYJwRS1bXyfnUHHIA0BsbMpcaRxmyDv3P1BMLOSkvrC
 7k4xbmThn0V72cUGEGIcqi/MbUP7JMMIlhBRcZlly8l1JCZsjR7+9m7mPiHf5xXMFtWSp69rhj/
 ZYVSeqeK1mb3lqbIjC/EGO270dzemgXc5wtziQi1j0mqRjkDnR7HEgF2823Q2BqCPhcMB0wmqKC
 mNvwl73d
X-Proofpoint-ORIG-GUID: foMX3XQjW-Jy5iMbcCGjth4fXxQ9XwAX
X-Proofpoint-GUID: foMX3XQjW-Jy5iMbcCGjth4fXxQ9XwAX
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68bad337 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=eKh8lGy-H4yf2MGC_tcA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> 
> Enable the QCA8081 2.5G Ethernet PHY on port 0. Add MDC and MDIO pin
> functions for ethernet0, and enable the internal SGMII/SerDes PHY node.
> Additionally, support fetching the MAC address from EEPROM via an nvmem
> cell.
> 
> Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
