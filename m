Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5093B3FD13A
	for <linux-mmc@vger.kernel.org>; Tue,  9 Jun 2026 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005763; cv=none; b=OD6YAKJ4vv0iTGyc2/y/IP/6b7YQl8ZSHBjGhCwuVdJjuIMEjiXsedMevaP27bhdoxQQWjUkAsJSpVlcguN5kGbV/y1yEqp2Oi1U/6kexyR0BUXo1SsXpjcZwPDdIBIAWqs2GzoboT/MvG2qMdjudwby7hXOpJaY/efJWe3/+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005763; c=relaxed/simple;
	bh=UBZbAhx3whZDjCNyOyyrh2L0Ai8hRIBpb5mv2kUuO7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmIcxDr13RFYA/Wiqgkx91k+sbH3CRLubIAHly3Ap9wDNtefnlM+ZI+Re9AIBKZ66jkWAA7RDTg+IscoKueSKwfV9EQ36fjIblxkudAIvfR7J8V0yXZVDt7SgCj8UeBNOVmwx5oGkFrPF8yB9K1dLqToXtcOuj7ISduLdSYr9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j5uoxZcr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fIosF4l9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j5uoxZcr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fIosF4l9"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659BnLhE2559584
	for <linux-mmc@vger.kernel.org>; Tue, 9 Jun 2026 11:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V9NAMaDG1Y1ozc4IDVL9zgdHOjlqUw2haBkusjjTfy0=; b=j5uoxZcr1MW6IVWa
	gp5++5Qpl7fl8o4TwG7uDb34ZOYoe+w70Fm+2n8zZ1Ec6Ka+wytnhKx5bf5vNr6N
	gkZ5lSorkav9a7bnyxnvvo1THa66oK7mTE6Y82vCT7jrbClqjdE0fO47Q4586g8y
	CDU+SUZKW2ovisdo2v/T19yVX5LPpBcHheeDOIzXp8Ugzo48qLh4OOo5klvqBajD
	xl+4RGymB+3o9xWPgdDqXVVf+OYbiYzGGYZc5LJkF2o+HOH+IGgd0oMFNZW9D/y8
	F/HOxm8Q1/fuZOP/1LYJn7qtI5dzfACFkeAmMpVQGDa9ERSe+vQGzxS7iinOl5+C
	HE0iJA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3v0j6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 11:49:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5177f07ea82so135125111cf.3
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 04:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781005760; x=1781610560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9NAMaDG1Y1ozc4IDVL9zgdHOjlqUw2haBkusjjTfy0=;
        b=fIosF4l9yi2VPQav4+4pKoMCE20wM2cXqbsDGv85lFTXlN72Iqhm4YkghTL3mfllf6
         K/iT/HsTZ9u9i+5Ak7ZQHHyUfG2pMyypWbCwv/c0ZHLEFZ386J8VZPoOrJ7IxKyy8vG9
         5PZx8+IRKt4clDegUi7OB8I69mILdqAoD5posaLU7tkfrDND6/IZDabqqM88WNYf8XnZ
         SMI4wmpzOHS+IpTXR77aULommrNS1CnBUDvqDo7P9Y6vvqqDGgsA0WJ+WIQ/+9SNEnis
         eSzKNL1zQLyiQQgg5ysL83KYofXhh7P+Cyfim8vjc1ZeGl3s3sWYJp+/Ln2iuA5XeTyV
         Oycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005760; x=1781610560;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9NAMaDG1Y1ozc4IDVL9zgdHOjlqUw2haBkusjjTfy0=;
        b=m5NkaqFFs0rxmYnoWFvWNRCPSoxlr9HOgEokbms296BEF/E36czti33M80wy4jbyBL
         qHoDN5uNd1/sbV5aTzHL8710XqkkcApUYqopOyOzhEyyf1/dy8q4WBPiJJsvMuY2zpuT
         VvH9duRdQPNMVooyB144ADtUAfQqnm6L/jK4z5qr8ZsvnrWx0KaIaAXtliIy6HicGqhU
         UFCrHZm+6fDUEqgZc/RUmVIehSax+Zyf1i3FAdthn3R+YdupS02VQCKjmXo908D4qKrT
         S1X4eYynDqPmISnO4KPRpfNzmVc+SWXJhBQY8jbM4FzgpPNHa8NPZT+2BykPoKA8dZth
         7mGg==
X-Gm-Message-State: AOJu0Yzz6/3dVZPlXrYk8YfnM7TxkFXodhNqv86V+plxpd6/gGUBOxg/
	rZdcmm5NKYotTOwU28Hgmb296ALETEO+BBTGXoK3RS7mj+geNpQSe9CQ6LAjrAhdGGoHWXqBVux
	JlCqP8aa8J0iEBJtS0Q2BwoLcSw360tryNU+HmTwH+T+J5a//SnmXHEM5rx0GlKmUeVX1EgQ=
X-Gm-Gg: Acq92OF5YAYNaLunVRubBxoME7bQxrrBwDmtQo/LgDYuyW4jtfHyLm2VrHEzTlYTkFJ
	CJCKX9skJ7buFLaSNHfBIQLEjdbfTrgJALwsLAp/cJgbJw6Jl2MkMabi9fdarZH5GPXmEvhHYT6
	dZt3a52+FGcow6+EDMq9DloghDZ34CVpVzaDcPjnYI9ZH9of8tPGEiEv8Fjl717PyBPCSYFIs3o
	dwD9CTtaO3qiWTnldJv55nQfuPSbREg6mU2YDY1zz4I3fht4Ojs1PDaBvVk5+ubie3ucLN30izO
	R53248Wy2Od2SJLuAZzwYiKfAhQB0ZZx2HmQmxlDBT6zPWcHzcGeVuu7ytq1o3KANG0KotK0nBb
	Uj4yTKwEsZkRk6zgxf6NON7qs5ECPyzZaN5f2JSf15JQIuVCABquhg2cx1quogA==
X-Received: by 2002:a05:622a:164e:b0:517:21c9:a22a with SMTP id d75a77b69052e-51795be96bemr287107181cf.54.1781005759665;
        Tue, 09 Jun 2026 04:49:19 -0700 (PDT)
X-Received: by 2002:a05:622a:164e:b0:517:21c9:a22a with SMTP id d75a77b69052e-51795be96bemr287106671cf.54.1781005759119;
        Tue, 09 Jun 2026 04:49:19 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.222.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm50579818f8f.32.2026.06.09.04.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:49:18 -0700 (PDT)
Message-ID: <1a66f1a6-840b-4de4-8e65-a3456b654044@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 13:49:16 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, ulf.hansson@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
References: <20260608041650.541502-1-neeraj.soni@oss.qualcomm.com>
 <20260608041650.541502-2-neeraj.soni@oss.qualcomm.com>
 <dc833e56-e127-47b7-9ea5-58d6d2cc193a@oss.qualcomm.com>
 <c8da8a89-e372-ca87-cdca-396c754ef5d7@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c8da8a89-e372-ca87-cdca-396c754ef5d7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=St6gLvO0 c=1 sm=1 tr=0 ts=6a27fdc0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=jO6dYz2E5lbJ9Xj+xBc9tQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=lOk5vIY1-vP44UW2zVIA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gAchkGKcKbN5wzHk6y1EL5zMIZUm8XNW
X-Proofpoint-GUID: gAchkGKcKbN5wzHk6y1EL5zMIZUm8XNW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExMiBTYWx0ZWRfXw0uavwQhz2Ou
 1+wJtADPu4tgcFZl6TLCK0TLNrMgoZ17cDLiC+UwNoJb5pbHrZfk/erHJY2PpPSfO+eAfjBNWSd
 q7wjEmpJnti4ox41Fd9EZtqTE2uDEe/jr/U62pgDygJvJPjTKftvT8BsT871k0BoqUl3air2mJa
 Yu8/c+DzLWIBZu2Raqs5sJe00T1Q7m3MeGFBEFw9hl3L6Bg7w4cCb5/z3rPmwnne3VObLAoMQrU
 mNSD7oZmXfiloTJbSsa+tAv2SX+xzqhfLoltzZxJvVpgEStZ6RBVixQoZnCnfqfTJIZC16r9uR2
 NJn4NbBlCzYp8ocKAI6IoqCm5oY1A09kH6nhL1qUY9mVrj8/4yVg2cZl5TtdDoxQ9953od1p6pz
 oHwgabG7QZpHgpB2ASnKheFaQGk8cWxcuD/SiXRE/+oSYGfMMbtlWDft5oMBjrDIfy7Uvy0l+9F
 dPApUNBqsIqACe31l/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090112

On 09/06/2026 10:18, Neeraj Soni wrote:
> 
> 
> On 6/8/2026 11:40 AM, Kuldeep Singh wrote:
>> On 08-06-2026 09:46, Neeraj Soni wrote:
>>> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
>>> So add the qcom,ice property to reference it.
>>>
>>> To avoid double-modeling, when qcom,ice is present, disallow an embedded
>>> ICE register region in the SDHCI node. Older SoCs without ICE remain
>>> valid as no additional requirement is imposed.
>>>
>>> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>>> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>>> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>> Link: https://lore.kernel.org/r/20260310113557.348502-2-neeraj.soni@oss.qualcomm.com
>>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>
>> Link should go below "---" to specify previous discussions.
>>
>> Usually maintainers add link of patchset being merged here while merging
>> changes in their tree but authors don't add it here.
>>
> Do not see any such restrictions here https://www.kernel.org/doc/html/latest/process/submitting-patches.html

What do you provide that Link for? What does it bring?

Best regards,
Krzysztof
