Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2DE21D5BC
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 05:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764047412; cv=none; b=ahvkMQbfQVYBgFNr+2tYvMtjGipufMwDuI45H9oBGjdHdEIW/JLd1Wnuol4LQ3ro0JvtlKZV8rmRv9JqPQvb09eJ27l9pyXkB6jmyssW37VAOsTjmTkK4n0k+r+gDJnBDpGMDBDUA35ESQIiFqPQJMTRbxtBtHTkhX4vcJf7kn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764047412; c=relaxed/simple;
	bh=022GSCPseTRMgXNWglHK1kqPJ58v1uNwSCTmxXxjWck=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HcKuXHkvpUf2ucsIWrflDI+Zk1CQGe+dTZlLVOu47wYDmeJdbq28bDTBGurMjLXV6hKBAFlf/9hiux37D2FQDsvB1Je4gG+eqFGlOExYHF81DiT0M0k+WwX7cq5JD3jSqqCyy2b+WdSzoWMNX+oAtKW1bqLv5DZwX2ZjgA5tUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pm2avZ2h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iCZ+uSeT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pm2avZ2h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iCZ+uSeT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2gvuR1940187
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 05:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+N8BeGpumbONKGWCMu6fn5g4fVjDx+qEcbPnGvsi5i8=; b=Pm2avZ2hzMwY5JaE
	Hp31h1NV0W4SuK6wf9xuheBjEzU79jwq7QJ78z1/PoZLz6FlzgrgB3iN50+RBghs
	d7hcZVlJ9LB6TpwgAv2hxs3Ma2tuUHUue8pYqUoRuI3aKivZkUvJv/CzRZQSPbzj
	F5vcHePhwPzX5J0i/BoPsdAEu2NRptj69m13H2W8xfsope9zmKaUMy98Kc/Yb1lP
	WOT8DPkEkUVHT9xeTwtxVsB62AhybtpavZ3Ro4eIZZwJO2LA5u7Z9huI3/J7tlfk
	IqlL/x1R0xlssn/jiWj5I4ufEMEE7L7x1XQi3tMgPKVOlLrRsveEExl08+d3m8Rr
	66F+HA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amsst22he-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 05:10:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2956cdcdc17so53610765ad.3
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 21:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764047408; x=1764652208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+N8BeGpumbONKGWCMu6fn5g4fVjDx+qEcbPnGvsi5i8=;
        b=iCZ+uSeTUHORGNwK/vHAeKIPmg7/51m2yUQwY0d3I+XjgDN/i+mpaUpgmMfYwM31D6
         DYmmQtVvlcFUJlb7lSb8aJCgM97QT6Sv5DyshxZS1HRUo8zTaT2MfsxkmhUd94/1nLs7
         vguvxQaRd2x/4Ra7Mt6+Fzh2+F7y/Jie+fy2ahdaKE831VDHVYr6Ws2WokLPZoITwlNY
         y7CI0Ljq0xwpmhRAliSkmq5678I85ZCNvWlh+gdn2HXhafc8rldbHuaTvi9f0N1FBELy
         a/e4BHV1GYTV8adjSqXvCRsMh/d5uIIfodx9NeZ7zkrBxEJEQkYchDO404xf/uG6ymBd
         XBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764047408; x=1764652208;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+N8BeGpumbONKGWCMu6fn5g4fVjDx+qEcbPnGvsi5i8=;
        b=alpOTTn9O8sWpUhJPulAbaMhe7aw/y9R5GRAJEfpBJAY8MjncrFKgOnWVfh739cqZk
         xoQV5hqbg353PC73oFhhOV3nOCku8J+hLjEMNrhrNpJcjOBeL6eEo5O34jd55nsz3Tsw
         dy1JzpRtfJb+2mEhaFdVBuILAIR5PzrMsTt8o0Aep0xhF0kbPQEL7DXyafGD+5mlWWBh
         xWtwKCU/bpWi32Fr4rrs78r/4Ckb0uWE+51v4GghkvQNkUXc+f3hLUE2z+eu3Lg4AKnk
         wvYKMkxRehDGVmaIloPRNkIyOxbxIIw5j+bVyuRJSi7D8swfJLPGwoNCfcgZekQJySQz
         l05g==
X-Gm-Message-State: AOJu0YxqkNkXOSz5ufjM6VTIanxmswbvoC8Tm8SAbc9/SOaqiF1LwlQC
	l2QRfaCikWtOLGbMGIGu8t2PASpY/Lc8z1ONgzbJf/6g54DupUl2bDJNVXsMw6pQuBARC1B3tbG
	w7szKo26nIVV6Lk0E8vEr44bm0phL26TVb54rGMNPBTqmTHRVSdwoTggGBB8Wd6U=
X-Gm-Gg: ASbGncsuOluxxNpnojnKTaiQJcBsyLiPlQsy/y2zNqfz/TiUpVpvst05Je3mGijhslj
	gQ+22ndvcv+hlOK2MRFu3L2TRYvN4uxmUPlhpnWLTHbo2l6MWrbVHMcLObsikLJSgC4O3bd3QJH
	MepnNsDOTZp59XAEW1CsNwVVWR/e6AdVpsO/GySzzdekB7fKd6wCxPL+ggCrgPFsyT79kFvAfz5
	2vGNJHVjUyHVYCIa/ASZYISr5my/daPVvsCQ4wirb52lOc2HS90YyZ4m9VCMeV4DprJuVp7vnax
	4UMTrUcoelRJLWIBBqemh4QbU2a8zEreqWjCcqS9afAytpU+dtb30e1oXu1RsYQnCUrnHRCe1pJ
	lHuoXaNRDRMi78R8+WDbtGg5bkTmqDG8gvKGL5p8=
X-Received: by 2002:a17:903:40ca:b0:299:dd98:fac2 with SMTP id d9443c01a7336-29b6c6b2646mr186563895ad.54.1764047408455;
        Mon, 24 Nov 2025 21:10:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbbG5TY9URPidUBSwXIRFs39qkMRkq7Oe31XHBIJyIUYNOrSxadbtME++0xcudbnqSWme91g==
X-Received: by 2002:a17:903:40ca:b0:299:dd98:fac2 with SMTP id d9443c01a7336-29b6c6b2646mr186563535ad.54.1764047407964;
        Mon, 24 Nov 2025 21:10:07 -0800 (PST)
Received: from [10.217.223.198] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b273c16sm152479475ad.72.2025.11.24.21.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 21:10:07 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Krzysztof Kozlowski <krzk@kernel.org>, ulf.hansson@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251124111914.3187803-1-neeraj.soni@oss.qualcomm.com>
 <20251124111914.3187803-2-neeraj.soni@oss.qualcomm.com>
 <563ac54a-de2d-49af-a6a6-3230c8070c67@kernel.org>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <8060b517-2317-8f05-764d-2a0bb6a182a6@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 10:40:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <563ac54a-de2d-49af-a6a6-3230c8070c67@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bM0b4f+Z c=1 sm=1 tr=0 ts=69253a31 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ogPTC-R_ne2spXMaGusA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: uHI33YxF0GeFfQaiM77jQkFf90YPhpFx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA0MCBTYWx0ZWRfX1ZktWyAVaO2n
 e9do4DnBcuw/gIguofWTMHYdVm1l6+mNYBk+zSzLcn4RthVyvWwZIJ+CeTnmZR+OoOxHJFKCH/1
 6jfGDh3HEI8sNTsW4rZg6+jrAfKL/WtR7kJOLaxdyD/YQzBFnrD7NsLeHjpe7XrZfrj+Txl6DWO
 A0n9V6BtGviX2ZBznIFyvd6itPVN/hp0nFbQZP7RtsrdVsovH4AwsMd4tDcLC0ysFxGfIbrWqmD
 YJMzSk9TMDSYRzKzjC9z9t4X64xfY6o7eJNePSN6e2mPSZhtLZYXOg51XkH2UR0C2ahel/alK32
 YR/b9EuJg3MOEDyaGCuc9QHbsa4L2Ck0p3ptP4w7QYGdvTPcZU52NNWEt4Ls8vkL6dzPcF3Cesc
 fFaKPLdky0tEIy4r7Q9GL5cWuu7r+w==
X-Proofpoint-ORIG-GUID: uHI33YxF0GeFfQaiM77jQkFf90YPhpFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250040

Hi,

On 11/25/2025 1:23 AM, Krzysztof Kozlowski wrote:
> On 24/11/2025 12:19, Neeraj Soni wrote:
>> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
> 
> $ git grep kodiak
> Nothing. Please do not introduce some new namings.
This change renames sc7280 to kodiak:
https://lore.kernel.org/r/20251030-rename-dts-2-v1-2-80c0b81c4d77@oss.qualcomm.com
so i kept both the names. I will remove kodiak and just keep sc7280.
> 
> 
> 
>> So add the qcom,ice property to reference it.
>>
> 
> ...
> 
>> +    else:
>> +      properties:
>> +        reg:
>> +          minItems: 2
>> +          items:
>> +            - description: Host controller register map
>> +            - description: SD Core register map
>> +            - description: CQE register map
>> +            - description: Inline Crypto Engine register map
>> +        reg-names:
>> +          minItems: 2
>> +          items:
>> +            - const: hc
>> +            - const: core
>> +            - const: cqhci
>> +            - const: ice
> 
> No, look at the binding - it says there are variants without core. You
> cannot just rewrite everyone here.
> 
> I don't get what you want to achieve here, but the amount of errors this
> patch generates should make you think whether it is even correct. Or you
> never tested this?
Thanks for the comment. I tested the change with below commands:
pip install dtschema
make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/sdhci-msm.yaml dt_binding_check
make dtbs_check
but did not see any errors. I will re-check what i missed and re-test to fix accordingly.
> 
> Best regards,
> Krzysztof
> 
Regards,
Neeraj
