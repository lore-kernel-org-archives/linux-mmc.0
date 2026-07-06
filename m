Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F962FD681
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335793; cv=none; b=eb/1+szmMGaq/I0Fii18bXBMdoauhBZhs42A1BDuTmIjxCcnpe4I7eru7YMz5AUUBXLcUNJqLcUN5t5f//xC7FAwIHafyUr1Y6/tKnKBVU7aOCIeij/o9vo/BaQJQp6mF/TkPjXs4oHTlJ0MRLvO0IHZP06yE57IyLYQDh/7sgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335793; c=relaxed/simple;
	bh=LsceVXmIVqblkEsqiJDufoAHGgW1q0gMF8K35wWqHws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtHUAVMnuQtGjqB0uXIptDk9rS30EvlJ1zkzAwzLKZLJhjWSUox/yITU4zGHhQx4w8DNGoK7Wg/Zc1i3cjZFwCgbWWH67pEQiKWe1uefNeqWKhRS80Ov2x9IpQWO4ln0l2HVrl7dxAV3SJWTq1GZrZWm9mnypSzf0IxsxzTwrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y4O924DG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g4HVKG/S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4O924DG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g4HVKG/S"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxO0o238927
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 11:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gBvpUaxM4cQy6esLgv4X661iQp5nyh71jp/dBjXyluw=; b=Y4O924DGE3oaXZuB
	N0C/2Sb3+oxDqQ6tu9s7LXtmI0FcDs70HxQwTZR+WzzB1yoTmgygljGBod6ttdpq
	xCzN2sInMe5oSwaOpk4qdmZzhI2lnhrHiWo7E/3aG9UIZKm6M5QamwOnmBEecHrk
	eSnnlFcmuVXFLJfOpRJtu+grJiBtgvaYvlOCibjSuEKkVEm3kdXgQN8083YA1dWN
	/K10PxE7zIRrPA9cfRJYbB8UbgB8UZPI8KYspF/qP/C480N6zD+hB+scnA0cKyFl
	Jh8umsPi8YBwSg7B/Peg66PJ6HhkhC+wfGD6Xo9k7+JTphKKENKjfnlRvKvyP7Qm
	jaguEw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t88mbw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 11:03:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c6a20348ceso40500795ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783335790; x=1783940590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gBvpUaxM4cQy6esLgv4X661iQp5nyh71jp/dBjXyluw=;
        b=g4HVKG/SAnxTqOQTDMUlJZMcAALJ/+629S2pX/qBJ6o7X2UsvXswzqlQCqAaRs15P6
         Y5kac9rntlm78wF5aLLOPzy4lZ0ZjQ+rKv9ve0PntsQaucCeUmE7s6w50Bh2sBVUbiDV
         yM9YiVqaaBVoe7eo2q2js7ap2GfYfhNlfo9tm0VK/1vb+VmMkljV8DEihxNGkhF/doI4
         RqXu208MvppR68bDdPXeeFQP0muCGbYmqxesJQ6GLjPlS6gWnBAFgqQw31VSK6Al4pSf
         Cj+Irfu+1d+GuHqqxZrMQj3oVw4ZCab+nQLBIMAWi5YjJdUWyGKSlYc1t0OquLwaqhaB
         C43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783335790; x=1783940590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gBvpUaxM4cQy6esLgv4X661iQp5nyh71jp/dBjXyluw=;
        b=Lrbq0SdzolSUhGmvrtiKX8swYnXv3mCu3B2L2ies0kmDPjLx/JhMtTw5T80ramhtLl
         E1VhClmQoLerT9PejS03vkdoQ/5KEc6CDc1ifw0l2fgn9OaRo/fGvN/w5EH97VNyDcHM
         gXTtYboo0vmkkJ3nlNZHFiLxUbXDI0cAjM/6pVv4ihzYr95XxxBO0VCr7J9xzqJrjivZ
         K+3u8HAv/hhFF8vxQEtQVlzs/kK0+q9wC4Awb7d31YlibjBxkSgzr+gOVMsAueQl11bl
         asQdgBPCa82Jj/pZgITDSBzKPCgHalKkp59FwcD2Q0NFaKApI4zifsdkwNpx/Rlgmx7G
         md2w==
X-Forwarded-Encrypted: i=1; AHgh+RqVzVRu0RfultgXCf5eMnveFSj4lMar1/R7HidrQDAct4C1Pa+mZDQgtZBM0lMzDwFV0QlTkO7ktzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvGvAyhg3lYasNF+waO8Smw2lSYLyvMkpm04Ds8fwcBtCokqP
	tMQ00Q8wkEV4MylJDFpTetdy5FR16E9nSwkeRdO5Y6Q7TKPKV1sVp2iBcLCVwMET/TAi5S/ivCS
	8ZoI/5bXnX+SVhugojN/n3Z/ZaG1YC3k4PNecSlX7MURz7WssrgUxM/YPxJ6uijImEFO5PCA=
X-Gm-Gg: AfdE7clFnL1tGYWThlYiwo/fRafSKddfW6dxmyLRqUkKEZaTnECBNoZN+hsGdLsJTqs
	mbXyurn1JOQA16Zsyl/nRunkfBHWoaSit6/8Kk1Is70VLOWY2otUmhR+A4oMSvfLud3J8RAedLa
	2M2SlI0Vns0gDOM2bBZyGghNVVhadsxLTQeINLKE5t8HxypflLfmNR765zIdRbwm1bWFqRyKtAI
	3afaAGuFt3ZaW9IMM0QkwQP1tuBLAvO96lC5ETNJcO8S21/cubbQNuw4RlF1USQ3Cl8tB0KEVmi
	ngwv/Y+0P2rUUUYEqo3k3S5qYvZ4YyHJkRxidKhbcrZwmTHPOh+0emTu3NZXBZ4i2x4zFyyPnzY
	d1Lf0V6Y2Ro5bkCgpM4JxY00m1WmhEiDoF9dzDR2yd38=
X-Received: by 2002:a17:903:1208:b0:2c9:e9c7:2b59 with SMTP id d9443c01a7336-2cbb9ee5fafmr89799975ad.35.1783335789750;
        Mon, 06 Jul 2026 04:03:09 -0700 (PDT)
X-Received: by 2002:a17:903:1208:b0:2c9:e9c7:2b59 with SMTP id d9443c01a7336-2cbb9ee5fafmr89799535ad.35.1783335789224;
        Mon, 06 Jul 2026 04:03:09 -0700 (PDT)
Received: from [10.217.222.146] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad77651c2sm48462225ad.49.2026.07.06.04.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 04:03:08 -0700 (PDT)
Message-ID: <48bee604-53f7-49ed-a757-554c4a83aa23@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 16:33:03 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] arm64: dts: qcom: kodiak: enable inline crypto
 engine for SDHC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>
References: <20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com>
 <20260629-ice_emmc_support-v8-2-1a26e1717b85@oss.qualcomm.com>
 <ba96f5e3-6b6e-40b6-b6c1-300e862e8ee4@oss.qualcomm.com>
 <d3be45ab-0390-4d0e-8d5b-330a48c529a1@oss.qualcomm.com>
 <1a0b91c6-5e17-4330-a8ab-ac14d3339024@oss.qualcomm.com>
 <ffca92db-a3ac-4345-8477-1f53ec61ef16@oss.qualcomm.com>
 <56ab63c3-4288-45f7-bfea-d40046437a9f@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <56ab63c3-4288-45f7-bfea-d40046437a9f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMiBTYWx0ZWRfX0//mDHqf/Qb3
 vMsjWXwBbkoUqi9T2KsCkZ0mh1laPaD+eeFqCWdWGIbIicqeKtfF36GNv8skQh9xKW/mZMs4gnl
 Pg1Pbv8M0LYoQKXyKoyegdyj4zom/3Y=
X-Proofpoint-GUID: idYosv7m2lloHd4BdXLEd31QHJMaD08l
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4b8b6e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HXWJYtWaUMqhmI3DdLQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: idYosv7m2lloHd4BdXLEd31QHJMaD08l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMiBTYWx0ZWRfXxeDiuv3vr9EY
 Vjm76Y0jJU62k5QIquwTMNTtZsacSDvog2yWtKyJQNJwKXpA+CB+93zivysAgLt5lk/0nJibTsT
 DQ+SD6fIfZydEpZM44jP0bTVJ5ql3mf+EbNzB7Aijsn3hqN3hcoHU+F/80sz/2GLWCPRedGIBbL
 UIQo6MOTrxus/TIt+7GknIa/FJaj5jT3Hep8EZwkkdC5MM7wzg82F+vSwLJdgBA1rumm2h8gE0H
 6fQWjaFmrRdr2fq8D5kYiBLjvVqLxoOWp7wWoaQMWLzICYufxAue7rWPWtZ5MW/feuwrFzI7njd
 QqxYVJ8zON+2f6uNhirPCVveHa+F1ahhuv6WdeAt2P3oLQggNqguAgNcmUDkgzCwFrvbzZV3wlb
 ePtsT6nD0X7c6Wr/eKADGODaL90RtkZVi7RLfLPMHks4Xh7akhbkDdSbw86o/GsEwO6oSDFAuFd
 7reTugXrE7AyBe/xAWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060112

On 30-06-2026 16:55, Konrad Dybcio wrote:
> On 6/30/26 12:23 PM, Kuldeep Singh wrote:
>>> qcom_ice_probe()
>>>   -> qcom_ice_create()
>>>     -> devm_clk_get_optional_enabled()
>>>
>>> If we remove the _enabled suffix and put a ice_resume() in ice_get(),
>>> I believe this is no longer an issue
>>
>> I see your point.
>> devm_clk_get_optional_enabled turns clocks on, whereas using
>> devm_clk_get_optioanl will only get handle but don't enable clock.
>> Please note, clocks are needed at probe to read ice hw version 
> 
> Right, but we don't need them afterwards in the probe function. We
> can simply gate them. There's a parallel effort to enable runtime PM
> in the driver:
> 
> https://lore.kernel.org/linux-arm-msm/20260512033750.3393050-3-linlin.zhang@oss.qualcomm.com/
> 
> and with that all you'd need after getting the clock is a
> pm_runtime_resume_and_get() before the version check, followed by a
> pm_runtime_put() right after it

I understand issue can be fixed in driver too.
My argument/understanding was just why to even probe and check hw
version in this case.

> 
>> and then
>> later ufs/sdhc fetch ice instance using of_qcom_ice_get() and control
>> suspend/resume path.
>>
>> But my idea is, if storage itself isn't there(like sdhc on
>> qcs6490-rb3gen2) then why sdhc-ice should even probe and check hardware
>> version? as there's no significance in even probing ice.
> 
> On the developer/customer experience side, would you expect having to
> manually enable what's essentially a sub-feature of the storage media
> on every single board?

Umm ok, I feel it's pretty subjective as enable required featureset(and
it's dependencies) only if user is explicitly enabling it.
Controlling from driver/DT can anyway fix clock powered-on issue.

-- 
Regards
Kuldeep

