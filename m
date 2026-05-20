Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7E3D9DA0
	for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274232; cv=none; b=JpomywW8ZDZ10VG09lEqBs167NajI+ZwZ9g2CLaJoJDS5mvaeN3jEy8QHbW+BWR7gLfJN3Ww4v3xinXtUkfHpgztkUAxFZIBWgAuxG4YZyvLTl66YI+OZMdUAYy9rsc+QyBklVwwZwbKoFRWBDUCpjaiU5u+gibeaDHlEnT3tzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274232; c=relaxed/simple;
	bh=IF2euUWVC/6Sux8Dsif8Tp7YWYJUPPwd72iRFP1vIAA=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R3laG9tpbATTgardjht1C6xDUZC7D0g6sKotUr4aSHOL/XhHwjOAddmi8w/Z2qQIV2AfKkgXatIWn9JTnwrtFvP/IELCaNlkIE5AjlRCl4HXAGGylH7lufJwQ+MWB4XHb/Bm/eJVB8vwk+Jom3NuCalOCUG77/Wt1xfpurRGm8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F0Nesiin; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XISvoCEH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F0Nesiin";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XISvoCEH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6dCmg629692
	for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 10:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hf6nNzQsjILLIYyZctOdObwlo3Tybufs1YkMWiSXAOM=; b=F0NesiiniX6Ws9Zj
	rY6sbq9e+F3nvNQz2kiAvpoMGtvG0/E+FzmYG0nixeIsszs9nU+cMCDyvgLFjiYJ
	+ZWyHrb2qj2mU1pAZb6XrZDGqSAouAMrmo1pd7PmL/SRasG2XVWY1cAm+Sx2EmJE
	TAv4p7GkktW9kTLIErMkA8nbGLS/pmhWOCGpvgjY8Rd69mZ5+AKzwSktBfYFn/e0
	pQHsUyiskIdpwsMTKpKL3/WfKI0D8lIUxd9LA1H5xn/gsQLgPlrmcvxXaAtiWY3W
	dqiRndFwwzIUXB0ON5tPfNIlgSC7dXhUTFb4XDI5B/2NlX/37YOeScn6dgAkWkRm
	cG8hvw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3nvdsu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 10:50:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba3245a43dso49093545ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779274228; x=1779879028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf6nNzQsjILLIYyZctOdObwlo3Tybufs1YkMWiSXAOM=;
        b=XISvoCEHwmwPoPpiVJnEmkdizG9wi7npBT18x/qg6JRJ+s0Wv8gCyJ4rCOQtmHmmgw
         3/hbidc9GLpdoYG7MmQ125mr3s/P5829WlAwfW4hNmDXFykkaq80g8qutyPeUfm+8865
         1o3XSOzioZ6gJHjbNinKnlJmgirjhnXd8J0lSjt1Wm7Q6KvWVfSvaqKenwsIrGsiCThz
         W0aJDyoc3Ofa3eGZhbp2XHIFCSomg2VPe2FAm1FZJ97Hg5rjzae3XvttuaqdsKG2jjr2
         tQItrgr7WGRdMxIKDV24+WxTrxtE77/uJbzKeouYX064tMwfZxEe2kKM1VQpG5FTNLTa
         GPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779274228; x=1779879028;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf6nNzQsjILLIYyZctOdObwlo3Tybufs1YkMWiSXAOM=;
        b=O5SPBRlwpC91SFLXcPblscSSpN3zyJ9h9exz9jibsbaPe2AA+uZRvNOq4NBaEQWZbA
         omMG/zeA8YyOUavjFHs+dN0DW0m8uK4a39ZOXH1/JejNdZe3qfmv/zDU/c2VZYA6pYiQ
         1MJRrtKX4pFEziwlj0DLm1FgP1O0jIHhoXKMu+yI798ZQRVv41WPh2xnOOGYn0y8x+eq
         PybLBDMbVwDZf9WEPOuFHikixP3kf0sPuNABTEEiGFlYI/XKNUFswZKtWyaRzm1Cp61l
         z2pP+OcvlFQ+2u+BfsAEFh86VrCAZk4PBrFloyv4sQq81WEYWE2U/m0NReM2Y1sqvo8Y
         5BiA==
X-Forwarded-Encrypted: i=1; AFNElJ+c6QlRyvYC+j2tauxSH6XlYIqs5+C28nkW9KgZ8NPZqrc+cCM0VP6lzY9oFKxfY4NrnE+CSl/MudQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzibhDpdQiwoA/CEYpA4mvcKSZS17zpPyb2g+/uwMWzonuXCbxO
	2RnPNyu0Ghbq8vLSvAsXI0Pjm528JjbOvmYI+TMOp3ONExkp4YpJjdJxCWXamJpIiLVmNCfqstZ
	TxzVuTgFeA5CzcvgCtY96eIQoGDIaiYKYxh7jUKLwCvghRfUvrjIWnKrO/U5ezIE=
X-Gm-Gg: Acq92OH2SPrvCkepK1oCINKSYLtoHItbSCfQ84jUmQa+y/B+OfJMm/awMKPLwaPGicR
	CJ03jGqFC1dxaxJFibmT3zXOKECx1pw4cpw2drvqSmh8TOG4gD12XDj23mqF8jLBkYMOx38ttdf
	BGdx0b9HTX8Zrrt0hc1sAmKGeSEHWCQlx6eH6u+POVR+oj/nbHFoYjXa59gWHVOPDPYWv+mgQUs
	JotXieIoqIgvmDusG3Fr1p/VSHhDLaCVDOijSHuIjRmYQsBIKRtR5KwyDEs9EYlaubr/zaJ4o8Q
	zPgMuy2qg3J0U97PG9mn4Fk0IMCDr0Wr0t9Lg440+wooSoInAJci+HdRJrOt2XYilYr6/3iFQpQ
	xqCW6FsgMaZp7s/UDc/V0BDf3fNhH484S73w9ngOYL4MWk9HveQ==
X-Received: by 2002:a17:903:390b:b0:2bd:1903:6ced with SMTP id d9443c01a7336-2bd7e93cf74mr259861745ad.41.1779274227885;
        Wed, 20 May 2026 03:50:27 -0700 (PDT)
X-Received: by 2002:a17:903:390b:b0:2bd:1903:6ced with SMTP id d9443c01a7336-2bd7e93cf74mr259861415ad.41.1779274227322;
        Wed, 20 May 2026 03:50:27 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d116287sm217130835ad.68.2026.05.20.03.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 03:50:26 -0700 (PDT)
Subject: Re: [PATCH v4] mmc: Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Eric Biggers <ebiggers@kernel.org>
Cc: adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
        quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com>
 <CAPDyKFrOHqStZbsye9Quk71UGkzUxOkwG9yAGYFVvt+=nMJSyw@mail.gmail.com>
 <20260122011417.GB946159@google.com>
 <CAPDyKFoPVeu3xe7ZAxBTNFfHmf=f7OZ3iUG=pRG8mD=UOGNVPA@mail.gmail.com>
 <3e04735c-ce0c-b2b6-508d-57ec363b8894@oss.qualcomm.com>
Message-ID: <625d16ec-052b-dfb2-61f4-bf0404297f28@oss.qualcomm.com>
Date: Wed, 20 May 2026 16:20:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3e04735c-ce0c-b2b6-508d-57ec363b8894@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEwNCBTYWx0ZWRfX8lzzUIEqKVE+
 f9UxCPFjhhCEZ8j0AMvfTk06kDB1/3yzC5iEnfXeylpNnEv4TR4T6zQ0Q/lSOIH73TiMPoroLd9
 ZdLxiylUHJqcYmF89yn6N4N6jz7uH+HPeEJtTrBeBkvQ5m+320VuweKw8L+cPPS7+1cSiRdU/2B
 gVDbWgLZt859JkHK6QFHRTfwhuW17r+bAQVeZmpnp7FqXV/y+b9GOpVY0zWkNpKVcA1TArneVuW
 FKz1v1AjTU3owjQIS+5KK/lAHcXfdZsg9x73gBo9KyLuqXZFC5V+jwBa/VlCxnoUqY7YctQ9Ls6
 4nBzYJbfEXcEmnirfCxU+1fU01pqqzmQZaE5JocooYFD8ztHWdY/xct7Vutz6eeRjsANw1aXHkW
 r10AojpTvs1h4IkRj5FetGp0ewv/6AXh+29WaYDLV5j15zvukyWcf3rgCqn7fZGtgq9B5m4WJVM
 nMAJbfX82RUjwsmpSYw==
X-Proofpoint-GUID: tMJm2bFDqc-3MyOVg29GI2tixUZqlLBZ
X-Proofpoint-ORIG-GUID: tMJm2bFDqc-3MyOVg29GI2tixUZqlLBZ
X-Authority-Analysis: v=2.4 cv=Mr9iLWae c=1 sm=1 tr=0 ts=6a0d91f4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xjeqlkpcTcYn5O9o0eIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200104

Hello Ulf,

Can you please help to clarify? If there is no more modifications expected
then wanted to understand when this patch can be picked for mmc-next.

Regards
Neeraj

On 5/14/2026 11:26 AM, Neeraj Soni wrote:
> 
> 
> On 1/22/2026 3:44 PM, Ulf Hansson wrote:
>> On Thu, 22 Jan 2026 at 02:14, Eric Biggers <ebiggers@kernel.org> wrote:
>>>
>>> On Wed, Jan 21, 2026 at 03:12:43PM +0100, Ulf Hansson wrote:
>>>>> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
>>>>> index fec4fbf16a5b..a5a90bfc634e 100644
>>>>> --- a/drivers/mmc/core/crypto.c
>>>>> +++ b/drivers/mmc/core/crypto.c
>>>>> @@ -15,7 +15,7 @@
>>>>>  void mmc_crypto_set_initial_state(struct mmc_host *host)
>>>>>  {
>>>>>         /* Reset might clear all keys, so reprogram all the keys. */
>>>>> -       if (host->caps2 & MMC_CAP2_CRYPTO)
>>>>> +       if ((host->caps2 & MMC_CAP2_CRYPTO) && !(host->caps2 & MMC_CAP2_CRYPTO_NO_REPROG))
>>>>>                 blk_crypto_reprogram_all_keys(&host->crypto_profile);
>>>>
>>>> As far as I understand, calling blk_crypto_reprogram_all_keys() would
>>>> only be needed for those mmc hosts that lose their corresponding ICE
>>>> context during runtime+system suspend, reset and possibly during
>>>> ->probe().
>>>>
>>>> In other words, calling mmc_crypto_set_initial_state() from
>>>> mmc_set_initial_state() looks like it's a mistake, as it has really
>>>> nothing to do with the card's initialization, unless I have understood
>>>> this wrong!?
>>>>
>>>> That said, I would rather make the mtk-sd and sdhci-msm drivers to
>>>> handle this themselves, by explicitly calling
>>>> blk_crypto_reprogram_all_keys() when needed - and drop
>>>> mmc_crypto_set_initial_state() altogether.
>>>>
>>>> For the sdhci-msm case, it seems like the only case we need to care
>>>> about is for the reset.
>>>>
>>>> For mtk-sd I don't know what is needed, but possibly Eric can help out here?
>>>
>>> The comment for mmc_set_initial_state() says "Set initial state after a
>>> power cycle or a hw_reset."  I relied on that when I added the call to
>>> mmc_crypto_set_initial_state() back in 2020.  In the following thread it
>>> was also discussed that the code was intended to reprogram the keys on
>>> reset, not runtime suspend as that shouldn't be needed:
>>> https://lore.kernel.org/linux-mmc/X7gQ9Y44iIgkiM64@sol.localdomain/T/#u
>>
>> The comment in the mmc_set_initial_state() is referring to the card
>> and not the host controller. There have been some similar
>> misunderstandings in the past for other functions in the core, sorry.
>>
>> In any case, I have been trying to understand where the ICE context
>> really belongs and recently Neeraj answered that question [1].
>>
>>>
>>> If that is not what it actually does, it probably would be appropriate
>>> to replace it with something else.
>>
>> I agree, the comment(s) could deserve some clarifications.
> 
> Hello Ulf. Do you expect modifications in the comment for mmc_set_initial_state()?
> I am sorry i did not follow up and assumed that no more changes are expected in
> the patch but i stil see it is not yet reviewed or approved.
>>
>>>
>>> - Eric
>>
>> Kind regards
>> Uffe
>>
>> [1]
>> https://lore.kernel.org/all/e1f689d0-523b-5842-3a6e-10b431d617ce@oss.qualcomm.com/
>>
> 
> Regards,
> Neeraj
> 
