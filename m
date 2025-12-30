Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C329B8EF
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767074800; cv=none; b=SciOUos1xpL8QPuR6NLCz8DjqiyZG4Falqffu66vJ1VMSTrTgfOMywc27aoN+cfBhAg0nySFR7Mwi5lEqiW/dFwnvYiVpcuXr7FaXEnaADkcmgZZ9kzIo//TPiEAxDrn+BQgKIRba84KoR3GqsFtaxIjDdnSnCUXPEMF4IO6KLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767074800; c=relaxed/simple;
	bh=mGUf64cGCiM7u6oQI5DJ0578LfNjkbJBX4ABFnEYEYQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TbmqTWimiV/Dt4n63mxW8GTKT3uZ8y/+NiF2z7GuarzI5QZvD8Lyrf78+OBXcbO7y0U4T4Bdq1g4e2p8764R+XidEFH78thjoOPsSVo4iv/y9UN/fZkLcz5x1j82aOwqG+LJXh6508AgjmdxrIlE1RYN9nqLI5YRbpkZRS17zuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GcxkrXPn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QqTH5Sqx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GcxkrXPn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QqTH5Sqx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU54LWb3539781
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 06:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WG5mTV+rGoBWzgRbYvXrLqoGm1oRgWF/NX55bgcLtc8=; b=GcxkrXPnMOSMMvqv
	WKoJc2K816Xet5amIkhVS0BOhI893grjmSHkbPSxA3Z5vkk+wQZhjkkAxeAabWWZ
	ThOEWPoyMHoOpuJZmLDlxGUZhU0e6yZfdzwD9wA/DxN7KKgbEdNs8Swb9bep5v38
	HjKtJG40SEXGsfeqodY14+iv4sVSxONbxJ99Vd0ZF2/9lpvQxR52qnWFnyDvT2VB
	tZlQZqCkzjViANcrgaA9/uxeeKMCf7SlyDv5dOoEvgJvG7rQm0btDE50RdpG5uNE
	4+iCgDk2fXNauYZ5RdSiFFl4yfWnMf1682CSWyKs1YXM6nMGpy3vAEeU+UocLwzx
	JKMtAQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc88yg41q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 06:06:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ec823527eso13300149a91.2
        for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 22:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767074797; x=1767679597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WG5mTV+rGoBWzgRbYvXrLqoGm1oRgWF/NX55bgcLtc8=;
        b=QqTH5Sqx4tsgkQnttaPxNY95UvzvdW3Z7r9Y6slkegAX4D1Adv8viBODIACTiuuFhN
         fKMi/EojJQwNpTvHYKVElwmohJql1mWj0zlIE7KxnNvBV/SxNbVCKeoYYlgCWDn7cNLI
         JaOXHRw4ixbbv0wnULfoH8/6O1gWXquS7Nr2crocGJgdcg01+MLqV7NrYSaXjjGLqDru
         DtXD5WRwOGGekXtzulNSHDwuRKSXThaoLts40Rg0kDMHVelBm/DzbUAxtuKvPzJVVHU2
         GsRfttrw3l4p3Ks/k3Y7E92GN2QsmieGT8xi9g9ex8/onyD+gKe+A9G8wBeChC6tEaVH
         EwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767074797; x=1767679597;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WG5mTV+rGoBWzgRbYvXrLqoGm1oRgWF/NX55bgcLtc8=;
        b=fYaiBl+/2K+j5raVSiKmrnUphIETWNr5lVqvvH8cgdTo6udeQ7j1bAfnTmpoT/57Ql
         KZnQo8YXcJnOtUfttQEwzjbUNC/hq23Z6XCI2vvsOYf8S8Nctv65k1l+INccOyWkn2dl
         VdklqGgqiv+pzxEpAyLdt1jmvj62GII8R2MIe/mMtgtVybkQrHtueY3G8fFNtMiLX5l4
         ey4X7A4dpgHieU8MKT7OU31yZzVvauzIT1vrNCivv+sC95QUGVzdCqHI4pwuI/lAKmD2
         ykFhWIii/dK9y/yGvuJz+zlKV8jfE8LuuiiC9HbjlhjB+AP2GtalbtDlixm74KAucvyV
         0agA==
X-Forwarded-Encrypted: i=1; AJvYcCWcPDbcWkB6nKrX2nheEbqvRTyRX1oJodemnDGbsB7mtUDgvE4o4KmLR1iWRPFtLM9hc9GOAh65B0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQbItgdnCOTEmbBdDv6dDNPK0bJN3nyeaU1rWoLN8V1rmCg2A
	npkwCPP6SEPL856PKcD5Bmwxf5AgQe50RxY0GQq+9iHwb8kVvagf9nq/k8028pnq+yiOQ/ur3mm
	GhtkiBan7Y5XzGNeJhfDTm2dLLzvQO9eRho558JRcfSrWoGm2Tp3fjoB9AXU2aIc=
X-Gm-Gg: AY/fxX5rjekneyQjIG2uW/9tPakgJys4HKo0QrO7B0dRHOYaA1tZesm4bck9YPzinn0
	dUkRUKX/LuQ0v9nKYy0s+2jtKS2y4d8dB1Ze9StFmLd8GoWJ2wrfKzChjttWEffpt+c1wc5tesy
	ptKbZcXFNL2PaWdevq5ojR9D2Tcq3dUpF2sgfSof18LAtwEVEu7E+JyAemueHOuuDHREUiNq7mD
	lNOBqEB77BaC6xnGV79BYxuj4/9jeIgsaP84VBxgLMBNLrSuImLHJtqNFlFhOQ/HX65HO9sf5BE
	uCLD0YI7/r7Kx4y6RmzsOlmgvf08OfSpVrGxMrpSb7t+DFZIRoMLGEvA1rTvBQjns34P3uFyxoh
	W/Nd2ofhJEiA1XXPG2JjdhcTm83z9Hcc1WQHslOU=
X-Received: by 2002:a17:90b:28ce:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-34e921448b2mr28785418a91.12.1767074797220;
        Mon, 29 Dec 2025 22:06:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXU/WhMf/uABkEh6sm1byPn1ucFkm1LplqVDFVkK9rHWm92bL3U43pV5xkq45HGuqk0rcK1g==
X-Received: by 2002:a17:90b:28ce:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-34e921448b2mr28785411a91.12.1767074796753;
        Mon, 29 Dec 2025 22:06:36 -0800 (PST)
Received: from [10.217.223.198] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbd618sm31951170a91.12.2025.12.29.22.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 22:06:36 -0800 (PST)
Subject: Re: [PATCH v3] mmc: host: sdhci-msm: Add support for wrapped keys
To: Eric Biggers <ebiggers@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, abel.vesa@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
References: <20251229070507.3322149-1-neeraj.soni@oss.qualcomm.com>
 <20251229222528.GA4684@sol>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <02be322b-e49b-d7b9-c6f5-7b4c25e7b680@oss.qualcomm.com>
Date: Tue, 30 Dec 2025 11:36:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251229222528.GA4684@sol>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POcCOPqC c=1 sm=1 tr=0 ts=69536bed cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=90dgnz13A4KOmbfFnlkA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 3_219oqG90BalAM-mG3gMvQK1qqf6jzC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA1NCBTYWx0ZWRfX64knCOTVrsy/
 tOkrBwdpB+3YKHSEjIpC6PLxYP7UlMDsNTa4SfZHC7XFQWacg0VTPZiujr6EChAcJTBH7baTKXe
 PK4tr8rh5xN04P9DsfKFEuotCeRQM5g/3ttN4A+5X63Rsw3yaqX9vHabYTF+w2K24E1fQZNZ9mW
 iyBgZyNjKcvtSjld+PdA2FO4rHPRWSRySDj6+W9XKkngY76ni0NGw50yBRztP9yS9lF0rmniFZh
 ONkjYJ+dCOYUjIzBopfM1acNSjlHc3dYvI8BiKhM+N/l4hRrqeCMRwnkPLyovaaI1B0XgFQ90+s
 9fEWKw4dfWgFa0WTIQZN9gSP83Mev2RUelnng5lM/iL/8XNcCWy0KvxSjAodle/eP9vpDwWTaG8
 bOxQqJbcf0nVIrCjALV+aL9UW+gLXa3wgQyj/8rWw4uxFJG6+t6FqIBy4Utdoju7FpSuUkbdW0R
 CKBdH+3TmJ/1nztNS3Q==
X-Proofpoint-GUID: 3_219oqG90BalAM-mG3gMvQK1qqf6jzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300054

Hi

On 12/30/2025 3:55 AM, Eric Biggers wrote:
> On Mon, Dec 29, 2025 at 12:35:07PM +0530, Neeraj Soni wrote:
>> Add the wrapped key support for sdhci-msm by implementing the needed
>> methods in struct blk_crypto_ll_ops and setting the appropriate flag in
>> blk_crypto_profile::key_types_supported.
>>
>> Tested on SC7280 eMMC variant.
>>
>> How to test:
>>
>> Use the "wip-wrapped-keys-2024-12-09" tag from https://github.com/ebiggers/fscryptctl
>> and build fscryptctl that supports generating wrapped keys.
> 
> Use the official release of fscryptctl from
> https://github.com/google/fscryptctl instead.  v1.3.0 has wrapped key
> support.> 
> Note that the tag you linked to was for an older version of the wrapped
> key patches that wasn't compatible with the upstreamed version.  So it
> isn't plausible that it still works.  I'll assume you actually tested a
> different version and then just listed the wrong tag in your commit
> message.  To avoid confusion, I've deleted that old tag.
Okay. I Will test this patch using the fscryptctl you pointed and update the message accordingly in next patch.
> 
>> Tested-by: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> 
> Otherwise this patch looks good.
Thanks.
> 
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> 
> - Eric
> 
Regards
Neeraj
