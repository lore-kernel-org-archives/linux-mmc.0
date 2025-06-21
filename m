Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C81F2B88
	for <linux-mmc@vger.kernel.org>; Sat, 21 Jun 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750501218; cv=none; b=dAjQE60XcSEluG6GX7Wzgd4j8MP1r2SmF9cNcXVIJ7MG8rgRKY/92Z7kzf3WZPBITHakSLZyUL+v+8PmLako7XCnkbo6aZKEdGzuS5L4WNp8wcUUOH882r78fTMuh27oqsbP6dP/09jz7Yv8LAic4DyKw7Fpwcjdsx8ISpB6Qyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750501218; c=relaxed/simple;
	bh=uYTOGq0jOvna7DKf7Dv4VMej982iuzaeDJSxWzLVVUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRLp3dZ7e4hceNdYkLhCIBD9zfHX7IAxNTICRM0skZ2AMH5516+xvZorX+HH17ZrP9OFPiGMdD2Gz5EThqPkXH3QSWfbbXaQQLZMjRFsFrC3Lz3T/8p5Xza5hbex8ST4mwBG5+2JYQORylrgy6JQUHHevOObUVMmFBPDb8eb1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i1r+Crfs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i1r+Crfs"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55L8DApt024668
	for <linux-mmc@vger.kernel.org>; Sat, 21 Jun 2025 10:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rynw3AOu/IaDP3omqKgtPfVAeJGLq3yLWQV4mFHxifs=; b=i1r+CrfsWXFeiVfk
	A3SouKbh6YKBwE6ClE4oQm9DBT2Yxs4plbgbGFrFCE3Zifu8NZv+d8yopQ+l28Yx
	mog2Gh3zf4TW57SiYBBvps4+edRGva8OhsxGSoh1lpmUzwCgzHUYWUjhGU/rgwp9
	9sy2ftGg0rtUZGQVO3l+hnh1+4SqxnQUae8yCb55oszgBQbDEwh0xHjpu0J7syrm
	uCbWeyW/gBxc+zCuKeRMe55ivY4qGlbiXHy/FNEPrmhjyMiFFR1BqdkApmgwNLcu
	U6a4hdtBTcaz9OSQ9Dn0QLNBQPtNb58zI3QY9IS4PVz8caSMwQ7SIrWOzYlDChYH
	L+Y5PA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ds1a84r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sat, 21 Jun 2025 10:20:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fac0b29789so3980256d6.2
        for <linux-mmc@vger.kernel.org>; Sat, 21 Jun 2025 03:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750501215; x=1751106015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rynw3AOu/IaDP3omqKgtPfVAeJGLq3yLWQV4mFHxifs=;
        b=rr7aloEabd4iOPIwdj6N4mo7Bcj7TmfFDXq+JSUwDSGVzRLtNLG3k8VclFv4CaHrHy
         Gqo3JpT3Hb8V25meATkwG8RI6gfboL+hIpAVcnhgdQTiAqkCa7cKQaVgjmxwPv9N0ysp
         4li8EwHsj3W/lm0it0Lk1w1pY0Edyyuv1N8zMuEOLFQTDUSt53MC5ehWx4UksMPD/oI2
         DwU3rC3bwImnUMuFdSYBL5p+r00O/k6+0/C6F3f3bax+1gBBjfvSrAd75SV6MwH7JnzS
         BxuqtjqTb7Oekt/k6NAVTxbxSbv0H+C2IkCLKggiHAhWMouAZNue6WzQmnhBwa5sZeX7
         zPaA==
X-Gm-Message-State: AOJu0Yy0MxR3NHh9jOgbSBqLc/6+eSlSiW+7n4rmf84KhTSPUx8VH4Wt
	jv6aso6zyDhtNKlWzNmUVUZ++dg59NWPhFssru+897kk1hJKBvFgokI8DabLiEtf7ckd4HtjyX9
	EE03gYwnGtKRIpHEo7af0QhhEku/H6y3F/waIPFITQzZDmrSTkSv9K59cQCENLl0=
X-Gm-Gg: ASbGncs7OhKrbk74lIEyTDrLGJKQtmSImwBoUNwMpSK6dnKkwLBeOS2SqR+CDZDp+Fu
	y6avpOdklwaWBHRwegdqWlDtwv82YdpmeaTH3gQ3JnWRDzQhGqu8/CGjvEP4GOMOfpPjNjN0Vt4
	gtewcZDSEk1nliF2NPyXBiwiygqy8WEypTHq1zl/yDPvYbuTCDarQFWmA+Hug2BPJz4uXqkOhlt
	bsINtpoeBj33XYlWTgH/7xsOX4gXacOp7ozOUYiz/jmcK6dYv46uaRZkTqGv9F9qDzDvf+rx9Wu
	a57ZqvgXrAYt1fdmkF6HtJESvT2/M0KDMx/jHpe2WfGKUfCfiVcjyII8mxu/c9AZscqpagaVZA/
	yt44=
X-Received: by 2002:a05:6214:80d7:b0:6fd:b24:4e14 with SMTP id 6a1803df08f44-6fd0b244f40mr24550416d6.8.1750501214976;
        Sat, 21 Jun 2025 03:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENGnJKDkVr9os6hHS84wNudz3PjxojZ9bH/SywhPnRHict04HderlvMlUs0FRZqVtVgTL8Cw==
X-Received: by 2002:a05:6214:80d7:b0:6fd:b24:4e14 with SMTP id 6a1803df08f44-6fd0b244f40mr24550356d6.8.1750501214618;
        Sat, 21 Jun 2025 03:20:14 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b6e36sm333295866b.120.2025.06.21.03.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jun 2025 03:20:14 -0700 (PDT)
Message-ID: <9627ed6f-2bb8-40b0-b647-5f659d87f2f9@oss.qualcomm.com>
Date: Sat, 21 Jun 2025 12:20:11 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/4] dt-bindings: mmc: controller: Add
 max-sd-hs-frequency property
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
References: <20250618072818.1667097-1-quic_sartgarg@quicinc.com>
 <20250618072818.1667097-3-quic_sartgarg@quicinc.com>
 <6040afd9-a2a8-49f0-85e9-95257b938156@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6040afd9-a2a8-49f0-85e9-95257b938156@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Pej/hjhd c=1 sm=1 tr=0 ts=68568760 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=pUFaWy8oF3eVePBgSHwA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 9mp_We52KDXMSxVyht1-JuKJ0TAsJH1B
X-Proofpoint-ORIG-GUID: 9mp_We52KDXMSxVyht1-JuKJ0TAsJH1B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDA2MCBTYWx0ZWRfX0pB59dWRcjwf
 5W7yNhblAW6LAR0PgS+4hRRJ5KDgBSJEGqq5UsF8N1xhMzQEa9C+s/qnGwTCVkl/jv7ADkmIIq4
 bAdqdh4eK7E3DCHRx6uqVsO9W/iFfATEn+eRE+cdp3/imSUjSaJVXpz54+lMnV2tCC+tQmn33n7
 W6cH9eUZbgpBg3+KqXRimWIBvFnONssqeleey8CwAWgxY0FENk8f/VcnI3Tu6ApjarbTdzEd1j3
 cm77wEib+KrfG4m0rozV8HcCKqw3LsdxOA5N+hBPkAC1m1vn4k6cLgTHiU3HLYIFCi/U2lIiS1Y
 kHp/mzF2hXFQo+e/aYufoRN4I14Ya65bDoKm3IrXfsWOLgH5AeGBpugVh+2Dt1QmYL9QysOniKF
 MIZXAHCNBQG63gNZwrTbUZ7PkABY3k3/zShHCUptBAn2UB/QaE1h5Uv0qEzOEsGNwLRajPtG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210060

On 6/18/25 9:43 AM, Krzysztof Kozlowski wrote:
> On 18/06/2025 09:28, Sarthak Garg wrote:
>> Introduce a new optional device tree property `max-sd-hs-frequency` to
>> limit the maximum frequency (in Hz) used for SD cards operating in
>> High-Speed (HS) mode.
>>
>> This property is useful for platforms with vendor-specific hardware
>> constraints, such as the presence of a level shifter that cannot
>> reliably support the default 50 MHz HS frequency. It allows the host
>> driver to cap the HS mode frequency accordingly.
>>
>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> ---
>>  .../devicetree/bindings/mmc/mmc-controller-common.yaml | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> index 9a7235439759..1976f5f8c401 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> @@ -93,6 +93,16 @@ properties:
>>      minimum: 400000
>>      maximum: 384000000
>>  
>> +  max-sd-hs-frequency:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Maximum frequency (in Hz) to be used for SD cards operating in
>> +      High-Speed (HS) mode. This is useful for platforms with vendor-specific
>> +      limitations, such as the presence of a level shifter that cannot support
>> +      the default 50 MHz HS frequency or other.
>> +    minimum: 400000
>> +    maximum: 50000000
> 
> This might be fine, but your DTS suggests clearly this is SoC compatible
> deducible, which I already said at v1.

I don't understand why you're rejecting a common solution to a problem
that surely exists outside this one specific chip from one specific
vendor, which may be caused by a multitude of design choices, including
erratic board (not SoC) electrical design

Konrad
