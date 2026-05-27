Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531931F993
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890964; cv=none; b=KLiRNMMfg/3W6D3FBjaH0JgYjy+9gffXODWORFMEZTY6iC9uvbe+CIegXtypFxyPQpzc3+Wvpay6TakO/z6nphObYodBIfl3LZDlHKHDjIjzyjeoeq578k1Eh3o12LHwgyf1qQ1EkXIK2Kx0xJfK4SwmQTQ9+6b98g74YOfsNbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890964; c=relaxed/simple;
	bh=qxF8y/suOhwQz9Jk3eY6ZF+c4CydHTqv7zgHv66xlJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMXQInsND96oWDVLMecn/4mU5uN1n8uL2N8mRPQrjB3rheKLvKACnPcAZ7Zh76WKc9maCzsrM9kXU2iT98C4AsBWr/iGgSgEXiGWlsmdbFQR+54UBHuIT+l+uqBDR4TaApfHKKA/9xbKhka0MLcr/qZteEZq2Sdzne0AnHfEarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hUcQ2FsT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h8lvAuG7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hUcQ2FsT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h8lvAuG7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8mVbb879342
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 14:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yom6/hlovSThP+6ieHUcTcbi8Vc1PPJ9H/N3E1WloIY=; b=hUcQ2FsT8aEnmGFT
	Ib5VtSROx9S2uK2Huo8XrRgAbKSL+wTT2idMZhYV4TMz7vn/jVNzeOWtsvEP0Eh7
	hyOjnDRkT4QpppR/aDCjqEhljlXp3BftqIvgNifO2pUCfEaOFenYDJVTiCBL7e/g
	wUySfm48jr8N6Wy/vi4ppReUnPknmnVGIdvHduWWW5GsBme0/3SDmIK70gbAcCT5
	6TiBi+VET7aWIel+5Il6Tmm422GM/eBVGk9xTXzAj2xq8HSY7LMKZnyho4ZXK2Ub
	6zOHlLTbKhtMkuZ7Ys+lFix2JTmKCVrFymYZTEJQRK6uBnfyVqOQp6Su+2fxoIPv
	QuKjgw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edvvqsah3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 14:09:21 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-83544d05c5aso6015263b3a.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779890960; x=1780495760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yom6/hlovSThP+6ieHUcTcbi8Vc1PPJ9H/N3E1WloIY=;
        b=h8lvAuG7vPnUF3hb1p/eFeGDGpwPYAmKqfmCFeiW2Gfynj6uSujVEf/b2fSga2PYBh
         JlN9JwvKobEixoTejr1mkvl7uhMuyRjNGVSu5vplWvjxwf5vIidrKXMQSC1jkUoazNJg
         KUl0webTIzc5I9UNw7OVdlvVlw6+j/LTfjoPbuxtAZvHv+fTrZr0AceenY8sRViX8dQ8
         OJqk5ABT4IKzYkGoWKJUu/zUXvdsiIN7ZF4EyCJWpgYzVNXIRr3DjN3X6EHg1OOyMJ93
         grjAqu9ZH+32d+rkWYCByo5TmQW+LaW+trZPZHUDjz2hJn3qhSgEojUkf5aw3MHALkB8
         vy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890960; x=1780495760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yom6/hlovSThP+6ieHUcTcbi8Vc1PPJ9H/N3E1WloIY=;
        b=H1hcp3PL90VLyBtK+qnnnsU69pl3rjeRCJQtjiokpjfApsvQGrkRUMj9CCcnlKNOxi
         xcD8WkwN0Qy086P106PTf2a4EyHroKDs9cqTpv9PJQ+HCgY22UXgDD+HTsgUOdE1XqVh
         rEum0AjgZrkkwHkgyAsV4+vbx2yc8ZuysAb+1yBPGGDLzkc52Rf/EKk+LRAwlkNqxjkX
         B2BgjtbC4pY24muQi9M+67B/IL3XEqdGCQUouIi7JIGqhViMOlV+GaGOGHp5WQ1HpxN0
         QxCQQEy//+Vp8ZlGsW55AW2NNcuNj3PcmETOLp12mcNdf4XHQXi8/mWi4VDKvtMbBqrK
         Tjxw==
X-Forwarded-Encrypted: i=1; AFNElJ/pnbXjOwpOjhceLc6yRnIIiB+IxfkZ8IiDUCvQ/atGx2zIw6tlLviFeYB8Ymhe4yJBUuvnEALnMoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc98QyTyrmjOfy5CEXtBT9NgCtCYZ+G6EsQvjlx2Yr4U6OE73N
	f5s9CE5ftGe/x1OChw6VXsuZADPj0zMqHul/99vi4V309JSVBKZQXx8Gy8Pa0Ti+x0QAsOWazhc
	Q4CCJ5wMP9v6AszbnYGSmEuShElwfJNPUc/heg81V7tvFXtnXhWB4LmG/dhvZQvg=
X-Gm-Gg: Acq92OG+DWHKe9oQ4mAc1tG/PZ4coCaDysMkmXWG5C+ZKpmkmcD/o67hC/xghmK5m0y
	DID+8LWTuiTPjpznVLPDH48U5owbbT9B/6cv9yCGelOUmSapk2EajcOJXTB08OTXwlaxRP88+6x
	PM2nSM4jKqc3OHY78OczZxFBCilDmzlysVhEaJ1n0ZASbOy2X21L5LA0aOzBG/Jwy/Uy6Frr535
	1yxSuWBJAQCkDCPMEXuH0xNtKV2vc+FlbGY3jRII1WnmcvCdbWhPxO5PKyHkrqVppnOBAoLfY2C
	VGH0TDfoGq5m36QlxztCiqFJSQotJZ6N9moZFlfogl29i/MChb6M7sAOcLFhTlde8gCoLTqm8++
	S0pn1owgw3aFCh4slwpwKbGzz2PL6cFx2uobMm+oXEATePg9A
X-Received: by 2002:a05:6a00:10c9:b0:82f:70a7:4a25 with SMTP id d2e1a72fcca58-8415f3640d3mr21841851b3a.35.1779890960399;
        Wed, 27 May 2026 07:09:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c9:b0:82f:70a7:4a25 with SMTP id d2e1a72fcca58-8415f3640d3mr21841821b3a.35.1779890959919;
        Wed, 27 May 2026 07:09:19 -0700 (PDT)
Received: from [10.219.57.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eb0587sm2484301b3a.21.2026.05.27.07.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 07:09:19 -0700 (PDT)
Message-ID: <28b62311-d3ce-422a-a3b6-79d098731ddd@oss.qualcomm.com>
Date: Wed, 27 May 2026 19:39:13 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: arm: qcom: Document Shikra and its
 EVK boards
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com
References: <20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com>
 <20260522-shikra-dt-v3-1-80ffde8a3dc4@oss.qualcomm.com>
 <20260526-quantum-funny-gorilla-cfc983@quoll>
 <951c9b8f-4513-47ca-afb6-481dedd3eff9@oss.qualcomm.com>
 <20260527-pastel-fuzzy-mastodon-a4d9cd@quoll>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <20260527-pastel-fuzzy-mastodon-a4d9cd@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEzNyBTYWx0ZWRfX8FbkWEyoWNSQ
 Hfn1amo78cKwVaBUsN3qjRGw10tRFiC9YiHtGsL0AtgxbKMPyWzzXggZOjoFT/uyCxAjB+75FNv
 zOIBQo2TlXhjlpzztEhl7Qb0moRC3+vRiV14NtXn5T/2KLudxYDjeFFhOBqduvOgbL6GrTLOY7Z
 0iMfpfLx0y6zv9O98KzrxE4gdZ/81wszi2F5bp+P4qrSelZHxuwzZia6R+03oJSFeeFD345nsek
 3El1Bx5GMSPzaIywEfqs8KwkP7TL9mwdJ5CtR5UbX27AUcE9zibhq7/BViR/p4zmwzu6U7U6yLw
 Qtfl7GkWOJrejJzLjK3cnjWvaX5ES4Z30HdLUUxoYUlzCyJuKv7q8sV3hjRiYfx0sCiSmrIaY3n
 hn72g+2ojGS5oxtw6Pd6Tb9o/XllwYgv+U4uv73sBYwcm3YSA9bA3+scg8xBRazpx/Wckp7vXiA
 lLZV+Phf+Ibbvdvw7fA==
X-Proofpoint-GUID: 03Y8kuGTw3BqvS-CpN6VB3_uRD2Bta1N
X-Proofpoint-ORIG-GUID: 03Y8kuGTw3BqvS-CpN6VB3_uRD2Bta1N
X-Authority-Analysis: v=2.4 cv=fLMJG5ae c=1 sm=1 tr=0 ts=6a16fb11 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=P-IC7800AAAA:8 a=bBPcOljkSGlYhA-67uEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270137

On 5/27/2026 2:25 PM, Krzysztof Kozlowski wrote:
> On Wed, May 27, 2026 at 12:42:20PM +0530, Komal Bajaj wrote:
>> On 5/26/2026 9:15 PM, Krzysztof Kozlowski wrote:
>>> On Fri, May 22, 2026 at 11:32:24PM +0530, Komal Bajaj wrote:
>>>> Shikra is a Qualcomm IoT SoC available in a System-on-Module (SoM)
>>>> form factor. The SoM integrates the Shikra SoC, PMICs, and essential
>>>> passives, and is designed to be mounted on carrier boards.
>>>>
>>>> Three eSoM variant are introduced:
>>>>     - CQM: retail variant with integrated modem
>>>>     - CQS: retail variant without modem
>>>>     - IQS: industrial-grade variant without modem
>>> Industrial/consumer variants differ often only with thermal, so how is
>>> it here? Thermal difference does not make them incompatible. Honestly,
>>> usually industrial one does not even receive dedicated compatibles.
>> The IQS variant uses a PM8150 PMIC, while CQS/CQM use PM4125 + PM8005. These
>
> This should be part of commit msg. You explained WHAT you did, not WHY.
> We see the diff and we see you added cqm, cqs and iqs...

Sure, I will add PMIC details in commit message.

>
> Also:
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Will take care in next revision.

Thanks
Komal

>
> Best regards,
> Krzysztof
>

