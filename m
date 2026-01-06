Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360421D5BC
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682199; cv=none; b=VVr10pwPk9b0M2dy2+8tR8vXCWBFFh2+wh/p+ylsDwpS2Z/IO8ZbMkSPpvscRztneEjzzHHWHJbr+X4V/JRVd7xVhBgOvN2iYSMozAtWaIGVZq/XpVAfMVhZV4+knAcNJBjILsffbKMAZHO8JFWnUETsLuEZZnYGZsRkrOeE9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682199; c=relaxed/simple;
	bh=/xmNFuyCPBpCMjB+FmENdhGG5UPd7j8WVyB+sYCtvDU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rg8NwVth8RWKe7hFYjEu7kOPIxIosetD2q6iWgiQSvxkydhroB6twPhGfUwZYIHqC7L9LrH5DmsjqF/FSdoAwEfI2lrG5j8msZPHdtfniiGekiDhOt221JbKp/tbHe2yUcG/LzEbsFnbGjqD4EgryJ4zul18fLKqmfxLAE+IUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oOj+dkr7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XllPDdoA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oOj+dkr7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XllPDdoA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6063R2oE529829
	for <linux-mmc@vger.kernel.org>; Tue, 6 Jan 2026 06:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ir1ouW5/vfSqycFJvOuPfX8uLIx2rdWxBCHocaK7CKw=; b=oOj+dkr7bi5TiHm1
	QVtX65330KjJYKblVFH8l3k4j8d64Yovn3xseNk62PcUbV/ZBNAGEvBAQk6dBpyw
	0TF2pKQulXeBOjX5c1AXi4EBHCdGusoc8a44kj0N2NDpXUstYBJ6FU6tm8hZqe2v
	PKi0G1NOSPJnJBGyCmiWP8EEjM1+ZMXzZQJ+EjcZKw0lLJuebEtBhiAt+lEFuCpQ
	0xCGgiWC98GaOuJ1zMdoR6/pwOhMgeeIRvylVO/ZZk2p96y7nZ2be8ttmyqy3l9+
	t5csOpTgbvYHzDSRYr2uKcGSvZeaoeTY7n6vTIP7X8fG6SKaHqRMDwnzhTtpSmx6
	2bwBhA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bggqu24as-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 06 Jan 2026 06:49:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so998866b3a.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jan 2026 22:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767682196; x=1768286996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ir1ouW5/vfSqycFJvOuPfX8uLIx2rdWxBCHocaK7CKw=;
        b=XllPDdoAl+paEBANcVY9Tr5FZs92iHJk01/Iv82k5naCSbvjtf5m2qjQdA3Qg7p5Pl
         hk1+n4y46vj4hy3bCEhcL1fnSmY4fXJjKBL6OP2wcAbRhOkR6dKWgelO9qpugyFA+Bo4
         dHFQgpJLgr1pHawSbvfnBhzKsrtPY9yDzvSSjNtKUfs4GTwgI3PNn4enKp0Qw5pMRA3n
         SKYNQa6CmW2Jvj/QuXDsMqIGjHfcl3G0lOZnprVdqUClaC+4cQL04tBLK0xrTgwtm1LU
         V9Z5E98I0RanSv1QfmXcevs3P4IfNZZx2/SLHU1yIVV+Zw2ie3VGaOvxFkpQlNsObpwY
         HwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767682196; x=1768286996;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir1ouW5/vfSqycFJvOuPfX8uLIx2rdWxBCHocaK7CKw=;
        b=D+m7yFtcy53DuhBngPLlswjbhWuj3spns2DYqY3XhvMKMKWtXJ08bvNU2StORwXzWZ
         vduCQsMArKtJtZprGvXxVVZKwAqIu8+ZcxohGeCaDYeIWbm0hiNN92ShRwnkibCY86e8
         Fanbgu7RpOTwo392KW+kN8zIOeIYKAQcCnNGkDzpqEmIGH+M2aX5yauiDfAsa36wqual
         Og5jRGd6/jFVt1XcTcQnLVKctZlnMcdcYRCMkG/+3jx3/uPg+4u5v0wIfRHN06/Du11c
         AjN1hj4oosTKNY1Smplkm7gZPbmj25DBEDUVod5hHLN703GYHurXTX4Ic/UNdb9hlbSr
         9LSg==
X-Gm-Message-State: AOJu0YzepOOhiXCuOSuMZ9axiMSC/U70x1y6IH4QRF5ncsbH2ysKKtzd
	s0cdevBMY2nll384UeJHlDnlXTmsk/vat4jBZCf/umhORI4DVE1cLWWYvsfShc7QJyBU/uAfm8O
	KsOdkssJPu4Ly9Kr75YtcPOYV5b41rROdAkJoWQ19c2K24Vx959oYqwTf0H0j/WU=
X-Gm-Gg: AY/fxX4UjDvkn64Ag8KU50sDRcBkbFnGg81Q7jcCuat9gYxWgBE97TsnOd4mvLMzEZt
	lpRhcbIWWFL9ArecpafXzrUy3DJUeAe2KIDeWFYomD55eefrHrgwn/R9nb9BtDvFFe+eYwF5FoD
	w2ymeF0QG9nXNHika2/lN29i4JOQQgt+svImbJ/r2k71+6j1pmDXzR4gKC0406qx9gDlVqvkiAo
	hs85eQ/c/I8YuZtq9kN1+kJbB7/h5ChzC2T8+v2Y6ih7uTwy9d1Wyk+lXP6SAHauxrbjsgV4vNb
	mMYy4MdBFYJH10frKrqeqXuY6DoSqpinz/xsRG+ZZQZ0TEmSQsaBK6fBt9+rWE1TYVcSmO8yhkU
	oKEupq4deXuRgXIHpUD/hkfAHeT75aeoZxpzF
X-Received: by 2002:a05:6a00:4ac5:b0:7e8:4587:e8cc with SMTP id d2e1a72fcca58-818847f8917mr1780240b3a.63.1767682195839;
        Mon, 05 Jan 2026 22:49:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDKds2ry3vRtmMnaFVhozottfyCYzZyEQY6c+wdNfaeSxkUHSC0bCpeb0dJRbSrkonglFWSA==
X-Received: by 2002:a05:6a00:4ac5:b0:7e8:4587:e8cc with SMTP id d2e1a72fcca58-818847f8917mr1780226b3a.63.1767682195366;
        Mon, 05 Jan 2026 22:49:55 -0800 (PST)
Received: from [10.218.4.105] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819baa195aesm1060691b3a.8.2026.01.05.22.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 22:49:54 -0800 (PST)
Subject: Re: [PATCH v3] mmc: Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
        Neeraj Soni <quic_neersoni@quicinc.com>,
        Ram Prakash Gupta <quic_rampraka@quicinc.com>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Sachin Gupta <quic_sachgupt@quicinc.com>,
        Bhaskar Valaboju <quic_bhaskarv@quicinc.com>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>,
        Sarthak Garg <quic_sartgarg@quicinc.com>
References: <20250718110217.1929526-1-quic_dmukhopa@quicinc.com>
 <a569a2c3-2fb2-4a40-8d54-898e7c36f4b3@oss.qualcomm.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <42797330-868a-bfcd-e0bb-b5f0dd3eeb16@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 12:19:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a569a2c3-2fb2-4a40-8d54-898e7c36f4b3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA1NiBTYWx0ZWRfX5twUoyS9Ix9c
 iCFf7iblS8/bZS6ZQ9b1goJ/E0BE01nkF+MjoFLZqnRENfWsOOg/2IdKRJHe38Bb1mYDtX17V9+
 A5mZDwVxx7dzaYMB0eG56dPK12UArL/48YlYht9NzdmP4XXqAgLt1lTqmbRPorsrtT9nXNftca2
 280aJygZCkXfuGPR2kztzj/8LkIdLUmuTg/fxsibC46B6pxqOQSVOi+u9sLSGT4oHZfZd0IXxFN
 UGnE9meY9NaBycfo2ju9IBJjT7EL740bGOoqfmqcFoZNQ4B/o0KnO8G82If+Annz8v4KtpBcnjh
 Kpxs99e/m3792IMdafuLtGEB3ancTHOBfeKxbbUjcYT9KpioM4zcR9ZVe/hxuEQtILg+4ItNLdk
 +5OyASD7syGRf210pcbsfW26z9sTEGiCXN50x5ZAJevcpyVX694xQg9dfC3JnZjuDE6a7Z7Zb0H
 T5vaiNLcrRTwnM0tNcg==
X-Proofpoint-ORIG-GUID: 0cAimXH2ahs1VEXKa6N3WVAmIRqxodiL
X-Authority-Analysis: v=2.4 cv=fr/RpV4f c=1 sm=1 tr=0 ts=695cb094 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=J6Ah2vJHh0uAst4CsOEA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0cAimXH2ahs1VEXKa6N3WVAmIRqxodiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060056

Hi,

Aplogies for replying so late to the queries.

On 7/18/2025 5:35 PM, Konrad Dybcio wrote:
> On 7/18/25 1:02 PM, Debraj Mukhopadhyay wrote:
>> Crypto reprogram all keys is called for each MMC runtime
>> suspend/resume in current upstream design. If this is implemented
>> as a non-interruptible call to TEE for security, the cpu core is
>> blocked for execution while this call executes although the crypto
>> engine already has the keys. For example, glitches in audio/video
>> streaming applications have been observed due to this. Add the flag
>> MMC_CAP2_CRYPTO_NO_REPROG as part of host->caps2 to control reprogramming
>> keys to crypto engine for socs which dont require this feature.
>>
>> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
>> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
>>
>> ---
> 
> Let's take a step back - do we need to ever program this more than
> once on QC? What about other devices (e.g. the generic cqhci-crypto)?
> Do they also lose the crypto context over a runtime pm cycle?
> 
Yes crypto context is not lost during runtime pm as crypto context is tied to the host
where the context is preesrved in runtime pm cycle.
This needs to be programmed whenever host looses the crypto context like during power on
or device power reset.
 
> If our hardware is fine with set-it-and-forget-it approach, maybe
> we could limit this to a small if-condition sdhci-msm.c
QC hardware will be fine with this approach and we are doing so in this patch in
sdhci_msm_gcc_reset() API but it is not clear how other devices behave during runtime pm
hence a quirk is added in mmc_crypto_set_initial_state() to prevent reprogramming of
crypto context only for QC hardware.
> 
> [...]
> 
>> @@ -459,6 +459,11 @@ struct mmc_host {
>>  #define MMC_CAP2_CRYPTO		0
>>  #endif
>>  #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
>> +#ifdef CONFIG_MMC_CRYPTO
>> +#define MMC_CAP2_CRYPTO_NO_REPROG	(1 << 29)	/* Host handles inline crypto key reprogramming */
>> +#else
>> +#define MMC_CAP2_CRYPTO_NO_REPROG	0
>> +#endif
> This (and the crypto ifdef for MMC_CAP2_CRYPTO) looks like unnecessary
> churn - crypto functions should never be called if the config is disabled
> in the first place
Do you suggest to remove #ifdef? I am not sure why #ifdef is used with MMC_CAP2_CRYPTO
(may be to reuse the bits if config is not defined) but for MMC_CAP2_CRYPTO_NO_REPROG we
followed the approach used for MMC_CAP2_CRYPTO.
> 
> Konrad
> 
Thanks
Neeraj
