Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB0347FD7
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645403; cv=none; b=Lwu8y4Qv8blvHRx2M3aaadnA9TQ0PPJOyweaW/mLBKm5E6y1iGZTGZ/cvNqRdIE2hsIPVBXR+DIFLrPeaM70g+Zjdz5F1t2xsmpYVVaGGV0dsd5LMSbEcupJ79kpsCVVXBEJYdTQWsmOJ6Umn3reWmou8Z1C9Kf97WFOVQ+oySQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645403; c=relaxed/simple;
	bh=Ttsz8q5cDNZexWmXXKaGyGp1lEELQQ1lNOBljmUtN/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OK8Wel7r0IfXNXRHf+IcTY8G9Wy69XKWh9NxFEtFWV1iKIJNp+RJHEgJieZ95gRymoQ8Z/Y6ZqiFMuaMbxbkIQf7/8LsK2gfFvLsbDgfNnf1VhDGCScV511JxsILHqnaQuxCaYp6CjWCUP2iH9LwZqjVcmjKaFJ5b4ueQeYOTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eYA4RzvN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HniAZcmY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eYA4RzvN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HniAZcmY"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G654l92129875
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2AfTd0j3qDjIpPj5+9F/8NtKQlbfzmA3Mmk2X4HiLnE=; b=eYA4RzvNicB32xuN
	g72yxltGFGSifnl3joSG+g93JglS4MYtWrfxkybyIL+ag+BnaHOXAbyAjOKA0obr
	8MSxQUbNwIvo1l4f/At4/T3Wpw9I1ZS/ro9QzQ7Xz4RK8x5Xn6+eaXxjblyg+eds
	2gtHYDCRAy9wujm2JQ+BF3aUT6jvePF5kTY5t0YkiEG5NHrgcHOD/pFYzUXR8BBy
	pMfzkJo/kz+PbyivDzZdr7KWmsmhYWtfN2TSTTse2E3kj5MdxN50mpCaWlJNMMAU
	gkUYOdSLfEbYuU+HmT7qAa2qi7puNr8k8nHLoke4N98pvhTpWCc8BddaaeasUmQ4
	gSIwKw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00ammd2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:16:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b0560c1320so90109715ad.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773645400; x=1774250200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2AfTd0j3qDjIpPj5+9F/8NtKQlbfzmA3Mmk2X4HiLnE=;
        b=HniAZcmYxrWTXuQdTyuiB4QO4D7wT3KLhoccWXXQT7DtNv12iTbYDFsozCGm5k1wX5
         AlM/ztBZDHJiAnXlC8SkzkMjpJ5tmRKAu3XzhwszbMPc6ZSmHuBUI5C5h++p+yBV3wg5
         PydcQBHvwQd5QFOLClD03XR7vjGzGZonjojuhpCPLVNKsyiigHbEm0Q+/s8by+x0JKb4
         TtYqOqCbioFnGk/lOAkklas5xmaQnVaq5I+WoF+JFi02T5xGIZdD6BuQUc7y8HmIGy80
         Qmubg6G86VF+zr5PzrqCzhxdI6VXQx9UIvvge3y1EN09LXl/bJkYkL319jTrn2GjP3+H
         E7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773645400; x=1774250200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AfTd0j3qDjIpPj5+9F/8NtKQlbfzmA3Mmk2X4HiLnE=;
        b=F9cpd2sUkP1Rc8SL7esQzBTud2oyR4SFSBV4uBG5ag2qlh2FC9V09vzNqDY0srV+ZL
         ++nQ3hsoPlP2Yr/U2JY6MS//QlldfB3JfCMWkI5mvyvaJ5S9Sib30UbsGvbz/c6JvQ2w
         Zf9vPG7VIlFrtafouQl9Vq7eORa1nhSPgdvx/vtBCdEyTAJOCzA4qbeQ8yxpjWbUBUOR
         oAP0C2/1+iMKiaLS9vtxTeSO2k0keudqB7Htm4Jgo3eFHqTFckJLPEeYbGgg+BAzXLVq
         rlWb5FW95PfKvPSkaXFZF9VrDixaU5nuoXCjk2Eru8RwRq432JhDkQZ++eL3tH5imtFq
         HBuA==
X-Forwarded-Encrypted: i=1; AJvYcCUcBenDuuSnEGw55+JCkOpkKp6/x0wi+HV4Lgt5sIYgfhefdqRqD705sxGWpl/L1Rh9p9KP4tlGkNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcaTiTykJhPaY7UPSilxnsjGADJSKOvacOvK89jWTn4omglCsF
	YX0qiNu48YRVHIJmcVlK3pJraLKqIzLlOTZf/9MOJMrTNqx8ni9dL04pdXNT1Xe5pr9Ku1BcICx
	fnGKh6TMlIN9S6dUHaFGBgCCS9iTZJJmjk6A+cQWcZMN68onEN9aCMyb5Xb3tfyM=
X-Gm-Gg: ATEYQzy661Y+ccUNiwiWjF5I3PrYi2ao3Mt6yUuaum8lQDzLYxW8kQVR/cSPZLh8tnj
	F6KGAumR+IHwKkV8PHtF21xRaGGGGTFA8qq7FRvBbVh239GGxDRyYl8ZfZ7a7OqXTsE9fqrVu7F
	ltlsN6jGQoJ/Dp1PaxktRUJseUQiAW9Wlq0UFm7GPQ4AryJLp3M89N+RYVCqT47lk0z9vXbo3Up
	NcBLLhdbwplfAs4GH8x0dL66mocF/WUhdrm1pGAkHSO3LmSYVXJUvE2K/VexfPV9vGfPQmz5hj5
	SFYDtsf9QojPa8ktCDlLS6WbZqirGtgrj64EK6Pc5rVuTnuvYGjFCuqR5JEo43rH/FB9e/4cQ9W
	BCF49s0cHN8MyF97k16p6Dd2TCVF4g+Ma0mSFtIlAD9DmhA1Ti7cGWNX3B8XYr31MdQ==
X-Received: by 2002:a17:902:dad0:b0:2ae:57e2:9b32 with SMTP id d9443c01a7336-2aeca9b8bcbmr127501835ad.8.1773645400328;
        Mon, 16 Mar 2026 00:16:40 -0700 (PDT)
X-Received: by 2002:a17:902:dad0:b0:2ae:57e2:9b32 with SMTP id d9443c01a7336-2aeca9b8bcbmr127501515ad.8.1773645399849;
        Mon, 16 Mar 2026 00:16:39 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b05d95796asm9603665ad.52.2026.03.16.00.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 00:16:39 -0700 (PDT)
Message-ID: <a8e08742-c6e3-4b62-a97b-bc2ff26f03e4@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 12:46:32 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dt-bindings: clock: add Qualcomm IPQ5210 GCC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-1-fe857d68d698@oss.qualcomm.com>
 <20260313-demonic-ludicrous-lionfish-fbbce0@quoll>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20260313-demonic-ludicrous-lionfish-fbbce0@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: L_kEmwIV8aWFU7xO5Nw1ks19NVyH5H9v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA1NCBTYWx0ZWRfX+98rJ6rrXLSZ
 9HkZSo3IcYYMzjHlm30zzTJigR9M4NxxneJqjc8f4ulMIgf86wB83o09FR418SHGiB46YQJPIcq
 YgIuyVCeeDkJOWrgk3tuKxs6BMP2K4X2kx1FXQWwUbi7YmMGkNfTsksWM9Vt+DSN1ZZ7zCYsG9c
 yZrUUTRqO3rCDAn4fvnIo94uEevv/2rdI/lp68jqiIRMuS8hmX6q1AAUEZYL3cRaItiL1O8WZ+h
 X1Vp4goQtM5AOa8p1k6VMjxwWazATe4gywEtAP7uipPpUvFUD0QANMi1m90+jeeRez3IR5XClp/
 lcAtb4+RGpLNGkUiMDO0ax+qBjFr8H67y/D6rmBNGs+Fl94yOZyctVhiuMvB/Ntok6Pi4ApvbhX
 H51q24ugmTB5addCc4FmR5bd1qO/Ykx85fbnCCQqgPp6YZssU48suGHRiMv3uqoqk/y0BBrNvaB
 cF4ZO4nDxsG5E4S66BQ==
X-Proofpoint-ORIG-GUID: L_kEmwIV8aWFU7xO5Nw1ks19NVyH5H9v
X-Authority-Analysis: v=2.4 cv=ebIwvrEH c=1 sm=1 tr=0 ts=69b7ae59 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pmxRcdgLKSYvSCRR0ycA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160054


On 3/13/2026 6:52 PM, Krzysztof Kozlowski wrote:
> On Wed, Mar 11, 2026 at 03:15:43PM +0530, Kathiravan Thirumoorthy wrote:
>> Add binding for the Qualcomm IPQ5210 Global Clock Controller.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   .../bindings/clock/qcom,ipq5210-gcc.yaml           |  62 ++++++++++
>>   include/dt-bindings/clock/qcom,ipq5210-gcc.h       | 126 ++++++++++++++++++++
>>   include/dt-bindings/reset/qcom,ipq5210-gcc.h       | 127 +++++++++++++++++++++
>>   3 files changed, 315 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5210-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5210-gcc.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..aeb5d9a3f8322d5d36d2fd19a1d23b275efc34b3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5210-gcc.yaml
>> @@ -0,0 +1,62 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,ipq5210-gcc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Global Clock & Reset Controller on IPQ5210
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +  - Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> +
>> +description: |
>> +  Qualcomm global clock control module provides the clocks, resets and power
>> +  domains on IPQ5210
>> +
>> +  See also::
> Just a single ':'


Ack.


>
>> +    include/dt-bindings/clock/qcom,ipq5210-gcc.h
>> +    include/dt-bindings/reset/qcom,ipq5210-gcc.h
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


Thanks!


>
> Best regards,
> Krzysztof
>
