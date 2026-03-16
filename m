Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946F126BF7
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653707; cv=none; b=E7jThXT0MLAqsbxz4RLl4tARgoCKLoPiqKDgB8x96HhvTQdwcmRo5lfmNisyauWKJrxu6WY4ln7fkXeypY2mSORLlQYXMXyW5s5tvvR1loUM2fJRBsyn6pZXqicTb936Ju6nF1mcVcwSVYq+T2Do9yh1LLGNBEl6dHmmB3lnmdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653707; c=relaxed/simple;
	bh=4r2iMJNnjHizHuoua26v+38XXw7c1p7R6XSQ8WsVbGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dU1wZ3L+yBYB6/jMQlma2U1lgN6N6z+y8fcFbnS8w+VvWN2t10Wsv7EsZYBqzaXN4Kv3Q1qTAIg83oVi23ET/QxtFxCBNanGSwqaUOW2WqGTG5KCj2Rnt/SYKhmbMfFDXmRQOJhz1v2ruSGfihRtOsM9x6O2PEIE5C9SAEPlvCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U/PkFDeB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZTriZICZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U/PkFDeB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZTriZICZ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64csY3777642
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 09:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1B/hBs9jqGXN0SatIrrTFMFGQGJmlKhZrWp6PbywrY8=; b=U/PkFDeBlrTsKB4C
	6YsBXWqQLQNNKucxb4AjteIqyUsG8InibHHx6ZMbPsEHm3s1HGtUDQt2fukXAI/i
	V9XJXMqCRWxJ9/furxhpWWH0hrEWX1uv6n35rKXt93ceeX7jR+O2MfoivZoWdbe3
	Mktc3TXJHl6eUHdW06qqkfjP5NITEW3AznvFj1vCT0mBJhEauqWHJeVL1v2zf+5R
	848vXObuf59Ise8YjfczNFrguqYdJ/D7ge3dHodfA8iPDDUJ+Rsn+GczS/rWdrMj
	Chr3Jv0eRUZ+jQ8WyKf2NXAknettViT57x748EZ88KUQoriLMGMwBqhlQlua4dpL
	u7JHow==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0y7vxhr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 09:35:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb485c686cso278435485a.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773653704; x=1774258504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1B/hBs9jqGXN0SatIrrTFMFGQGJmlKhZrWp6PbywrY8=;
        b=ZTriZICZAqaMAdvDiWGWDrzsripmEcJfg9YGRvmXK2uYi+bm3ZpYQTG55Qjd1lBpsK
         WD2ZDDvH4zu1YqxxOGP3+gW2XwbsQSUcmIHJrED0gK2Rv9oQPeYro7BJT8Jm/EidMX7Y
         7q+h2gf84CkVthQME1CpnPls0GzD0lk/kUgDQzeYa3siI6nd9ZwlMAtcj8awx7XVJs5O
         kqtd/0uJQbkKXZxXW/b0kNFZ/G/FeTNfgBC4C6Dbkpqbp/dZBideSQPM0GcAecbYmqc5
         lpzlRcpjDLpkA9Uto71X8Ef3OL1HhEsmB6V0Qbx8C7VQbawUrdwjlGa6C3C4duSaXojb
         kGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653704; x=1774258504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1B/hBs9jqGXN0SatIrrTFMFGQGJmlKhZrWp6PbywrY8=;
        b=nDAkHkhUaUmlQQhhx2cMIqVO1M79yMJjavoWSo7hpGIHPIcAmDb/m/FyikSuaIB0i0
         dyrP+eBQMHV/xaTL0PbXLlplkSEcloofx4g5eU2OF7/JJ3Kqyoivj+CFzZ4ZEDHhEMZ0
         CkzOTnE8NOWLnW4HB7SlbOZiEN8jQ5+d3njL8DWJlODsa2F8Ncenh4GQyNbEv3BQTO00
         6/ugVtrnZ1AYaKFLGWueR2odwKwMlw6btW28YUCfGTWOZOF/EYbQSxmq3MpfXSCYOk/g
         cBcZoZ1JBVav5f0xqnKDv+uYG5qSPlqSMxQs2ka6zqp6DCTPuuvuauEl43d/7roUYoEN
         pjKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX60/8Gp9bb5M26l06BVFWqhbK5aQjyp/TA8yw9ph/nj4SYJTv84YOyPb2BExeMmNe5K/KURRYbfGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySiltoj2xHuV/whs3vhX/BR/Y/sa1x4UfJVCJWdfYh6ArbOc5p
	oVxvBwB+QhbDrB2xa+LO1TfoO+flQZqJcVtU4jwEhsTmGRgnLsSFqnZ4DoM8qOC9af7MZmtqiCn
	Vs1vUdd0tuX4Jgbt5vtJim0dDvuqUiOIAThDe3DDcNDfI2zcH2rBm/Mav4vmglzI=
X-Gm-Gg: ATEYQzwMJwVlayt6bfSyIeHw9OsUysdxAOR3i1pP52R+33Kpd8DULCicRIAVH7XWtFS
	yDSW8bujM/ppAleE+sgIz3B9tMzHTcTRemdn2jnjjvesFhrq43KdwUYvz5En2rzlJv31zMWYw78
	9L3/YJR+cqWefuGirj+rTKVWKTvpLlwYAdmiSwZZCPwRyUCohiMdYhGru1UmRFcgfiy8eWc6jLa
	GLlujfnD8DVqChMf/26z5ROxTy8IktKXnhr5vjZ9WlADi63w6acUtDzWIxKoDQUppKeA5x6lsuw
	GUzHDSnasZGt2/DvZchDiVcrPadJEqqb6TgV+gFyhnTsRdojr6e/nJpg2n5cj8n2cLcrTJz4kWo
	iNZvF85NNCnGp+HITNNpNt2FtfOsDPg1dhRRcSLfo1xI8XAD8wliE0gWIoQA2S+F4InWi2MmD97
	W23yA=
X-Received: by 2002:a05:620a:290e:b0:8c9:eee0:dba6 with SMTP id af79cd13be357-8cdb5b7617bmr1232409985a.7.1773653704202;
        Mon, 16 Mar 2026 02:35:04 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:8c9:eee0:dba6 with SMTP id af79cd13be357-8cdb5b7617bmr1232407785a.7.1773653703814;
        Mon, 16 Mar 2026 02:35:03 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97cb0d2df2sm45121166b.54.2026.03.16.02.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 02:35:02 -0700 (PDT)
Message-ID: <6679e85c-4eef-480f-882b-c64f8d0eb1b7@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:34:59 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: add IPQ5210 SoC and rdp504 board
 support
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
        Guru Das Srinagesh <linux@gurudas.dev>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-8-fe857d68d698@oss.qualcomm.com>
 <6e33daf1-bb90-47d8-955c-12ccdd30ebce@oss.qualcomm.com>
 <84f1407d-62c6-4ec2-8976-eabe66c74728@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <84f1407d-62c6-4ec2-8976-eabe66c74728@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: p_QGt3jXOmTpaF0tfvF2nHpFT9VFg-no
X-Proofpoint-ORIG-GUID: p_QGt3jXOmTpaF0tfvF2nHpFT9VFg-no
X-Authority-Analysis: v=2.4 cv=D9xK6/Rj c=1 sm=1 tr=0 ts=69b7cec9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4Zt3pBCKRviRSeEyxVwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3MyBTYWx0ZWRfX85mU+u94ePSK
 NB4AeC37JkTlamrazMOPNzrq6JzPpToj4gpXdOMBFBX3yvmRJuNCBct6TCczF+7BmWU8XUTEcTD
 E0KbdaA3AjDVL+1iBAasmFANDKWPcH8Ywds7GV5O8K1gzRkkKqMCwaFLzsVDH1Jv6OLi/fM4GhG
 qxkzF8+0X9jBw3jHVXTFi6SFvPZYJIysVokCpeOZGTF6xOlRNcMdshJmt6oHDxix2EKE8tP1AZ5
 NeTEjCX8fBqjv0PkP1ZjW98D+QjJW3Whlxr2eo9GkwFmcIs+NA/OFZ991iNUGHdXy9EdI5UnFqq
 Ux0zPU8BVvGwGwtTDNe/JxU+z7mqkoj3y6pbGRyVj6F68YbL6TowlBV6tnZUGqrtLj7D1tzIUbO
 dKhd3ZO36n7Z4HzNypjsFSq0n27Sm6Ftll68XvIz2NXGPi8/1uMxxgyO69cTGQ8w12JiGw7kUrN
 IrkkAKif0x2rS36sWPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160073

On 3/16/26 10:03 AM, Kathiravan Thirumoorthy wrote:
> 
> On 3/13/2026 6:18 PM, Konrad Dybcio wrote:
>> On 3/11/26 10:45 AM, Kathiravan Thirumoorthy wrote:
>>> Add initial device tree support for the Qualcomm IPQ5210 SoC and
>>> rdp504 board.
>>>
>>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>> ---

[...]

>>> +    firmware {
>>> +        optee {
>>> +            compatible = "linaro,optee-tz";
>>> +            method = "smc";
>>> +        };
>>> +
>>> +        scm {
>>> +            compatible = "qcom,scm-ipq5210", "qcom,scm";
>>> +        };
>> OP-TEE *and* SCM? What does the former do?
> 
> For OP-TEE, we have use cases like getting the random numbers, remoteproc PAS and few others.
> 
> For SCM, setting the download mode is one typical example where OP-TEE doesn't come into picture.
> 
> Please let me know if this helps.

I think it does, but it's odd that OPTEE wouldn't handle both

fwiw +Sumit is poking at OSS firmware for other platforms and may be
interested

Konrad
