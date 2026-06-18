Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07A391E58
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788315; cv=none; b=KB0gsKntq9ZVxvlyrQSR0qD5WGx/xipXHPrZmSFV9SCJAn/4/O6vFS/3rZjcWEmLC+Lxct0FULk3UxFJbAP8W1EkANvyYOdG7Ek/P7Tmv3wE2QFZQcbr6Yfd0j2oxBVY0CzJe/mGK9Evbn3oI01Sol0YeRTqbEZgykQ34VxbeCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788315; c=relaxed/simple;
	bh=2I/xHmupXzHalSqq6Seeo0I9rrJSEn4BYl/KS2Yfy2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pafbPx6/yuKtxS/JpCGTT0F2dOouvKoWTzgc052SJBx0BKwvbTAk1xiaPYh6i4L+tTIkTGLhl0SyBufp0qqEMy2LmLM8W9FXr7wSc/h4YFzNpUPSV+IjFR7Jp2hxHoT/8LI+gdvZqnykdWD+CUSvBHFV3XrkAHSoyND33eKnbw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wr0V7oL2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cbfL2L1Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wr0V7oL2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cbfL2L1Z"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ICrxlh1294852
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fj+s04btC0/OVbnaKb9M6wCHPUMEjrN7D2ylxGzfSA8=; b=Wr0V7oL2jMofSeir
	lMiEczb7ynRxZH9QnR21DSaVFoa/oBM1ztUp5kzDWWBGJ2ZCs72tCRJV1ykPZNUB
	f10rb0uSG2PN3PDVbb5thU3hoqlc0IkyCSu72ygnOl0o6u5ZSkA/rAbI8OLgees5
	RDoQE6QNssjWa2dJqpuZX4zO0eLKENGjDuqy9ncRi/d8ioEPmKPDDk8lo96VJgSo
	za73tKz0GPQEeiKvSJyZLFaFEKUOzt0teMytKpNbgKZXgvfowHyd60rkjsqEl9O5
	KI3gGs1yRjrjgWSix6CHjMQGQjPU+Hhi9CMdQmr2gW4UcQzdBnXLkSBX/TBnLVwm
	nHxGUw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vm3hk1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:11:51 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6c9239a1dccso68766137.3
        for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781788311; x=1782393111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fj+s04btC0/OVbnaKb9M6wCHPUMEjrN7D2ylxGzfSA8=;
        b=cbfL2L1ZCtPbVewPMGQBfp7BW7tcwxuMd1LDo+sCJiSz3/rj0QZuivMvDQKURXwzJt
         VAMGxlBlTcxnkrJeOSV4tt3R4F+h/KhTwRlLpvdGIvTobN4p5tKWY6OKpEUb6KvZIJlp
         MbX2BIouqEuG3ce6RtoFf+NpUOU6moDIJ0+9wXaPgmpUFVDzafUxModNFaBHU4LOT4V3
         RKb0lCXL5i+6kYcGNvY7c6JacXDxdM6BsEm+W9pxDtsvuTs2Bu5wHfbvorfzfzl5BHuk
         dRZEg820vDQFBWe2QYSeA+aKqG0Yy2BZO058fNMfjqUpQKKFsHYiYbTwJXwMDIZrXfIn
         rBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781788311; x=1782393111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fj+s04btC0/OVbnaKb9M6wCHPUMEjrN7D2ylxGzfSA8=;
        b=Z6+AQlVJDAge2/KXTjIqKmjsITdoH0nvvjKV5IuL+Our3c/AM3WbT9D0TRlkOdpjx2
         6HbLgMNcskc2VJke64cHOhqwZbgIq196KMRG/DQ2ZwGi/ri5+cCZj0Odh6u8FXyG3Iaq
         j7uiEV/aQzN6JTasDqixgLNrl8dNI/dMne+YDIiKs0Rm6fjm/vq3sNtPolpKmYzqayfE
         BXQB03v/ea0iqclwJWmFgFVmczwEOD0PA7X3xrpo8osPDAP5xeNTo8zH61u8lbhvGpXl
         XQQaQ80MmV3+qsv35pyGAEQUuZsVN5bQBgNBBXXtaezIUksrITE6Nn/nmSoEUleXD0Ms
         RSzA==
X-Gm-Message-State: AOJu0Yw0zQ2HTRI8MGmWVk1qoapdXi0XFJQimnAiZubOi7587A39nREW
	a7CmC34z0aJqNReftZvUjc9n6ozWuMnEiBajA5scVhvhYpsQzPNMT/pg0QLxCPf5uGwIx0z52oJ
	t9eKCY/BwOLJflbvH7ssm3CUNxQ8O/RUEJHwzLyjvABkUEMBU1MY7vTXNk9g4QO8=
X-Gm-Gg: AfdE7clyfdp/H8uEhxW0vHhMEhX5mXjT5zK2KuvPIknnfw7lLU8pDg372MgtlHO1QS4
	mgPfmsWOrOgPSq9m+Jhb4kVhj3q9sxhu7drC++953iqO0yL/ZdaFfuD/OFobpMp6F2Y+hXpF9Zv
	F/w6xTNqY98ZpXxsF/KWoDQKFrJmXZ6ze/Jq11SRaHnYsWt6lgWqg5ujGXBSXNA+vbt1ulWRmcf
	8SmrNM18EpNULWD4mUPPH/BctLbWjLKHeBfR8fEIiXwFepq9E7VbmtgGEFDfuIAFEHvQaivlB1L
	lHSLTKkTkx21W4TmVsbnoqs4zee94BxbCkMmUeIASIa5qgfC+KVgPDF4OvI7sQkuoyjnu/Dno45
	kFYirr2vrEnDsKj1bzt87MI4xClxLrOZGW5M=
X-Received: by 2002:a05:6102:5808:b0:674:d57b:fcb4 with SMTP id ada2fe7eead31-727d6b15affmr706645137.4.1781788310629;
        Thu, 18 Jun 2026 06:11:50 -0700 (PDT)
X-Received: by 2002:a05:6102:5808:b0:674:d57b:fcb4 with SMTP id ada2fe7eead31-727d6b15affmr706632137.4.1781788310179;
        Thu, 18 Jun 2026 06:11:50 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb5223309sm950480866b.28.2026.06.18.06.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 06:11:48 -0700 (PDT)
Message-ID: <62cd69ee-614b-41bf-9d4e-da83df66eeac@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:11:46 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-msm: Set ice clk rate
To: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        abhinaba.rakshit@oss.qualcomm.com
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pradeep.pragallapati@oss.qualcomm.com,
        manivannan.sadhasivam@oss.qualcomm.com
References: <20260529081045.2877910-1-ram.gupta@oss.qualcomm.com>
 <20260529081045.2877910-2-ram.gupta@oss.qualcomm.com>
 <18af0dcb-8cf1-4565-a90d-58bf1e66811f@intel.com>
 <a03e129c-6719-4cae-bffd-563bf1dfc335@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a03e129c-6719-4cae-bffd-563bf1dfc335@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEyMiBTYWx0ZWRfX87/4W7QpRKMS
 D2TaIKhHiKJ05OfYNT/ugmsqbe4b/GPNT1Cmmz76BgmNd3aPVhwVfvqz+EdzRpcO9q5St/irwBi
 AuC+tLmcOSAMKpX8DAVCQrJa1Fe3VcmuKG/vlrDZ3ORoohEnpZwnep9vSwVFgvgNmz6Bsns9Sno
 PJHY4lGpupKdnCQIF0+RUDXMmd8Aj19wy5MuRDqgEAis+3CaXQgZXFRqTLRe6pM5Urxp6wFy0ki
 Xam4d3tYebOGMrEJD9rGY+6QXDky03Vl+bfuB71ui7Vs4Iv5XsoLOosnTwXulGTGd+6B14BMXJf
 5LMnJ8NnB87EGLWeVQgqT/lCjPkBV7qfszXDTkADq3HrfE51ms3cqZeMsr7THDltVKuQaKU5Na0
 CkXHSxMKIq/pHBZTd0bHTO96f26IHRWap/GzATgbi+SfSYzLQfCbPsm+kC60x4fUv1Fprx0eVSu
 nGnIvK6WFED0LeaLHNw==
X-Proofpoint-ORIG-GUID: XTNbQ5t3Bja8raulTXLHicRRzatjgADl
X-Authority-Analysis: v=2.4 cv=UrRT8ewB c=1 sm=1 tr=0 ts=6a33ee97 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=nSvIXaLiVGUEEiUzc_0A:9
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: XTNbQ5t3Bja8raulTXLHicRRzatjgADl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEyMiBTYWx0ZWRfX49P+goXp4o1Q
 hOV0uuv16bZTygZfhQCw2z3GsShCAT4QtUV/CB454pkpQLFnnm7EZKfYWXF4UXzPlIz4loVSLA9
 Igw50cy0oXm1sxSMRlya3iaKFwydSXM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180122

On 6/3/26 9:03 AM, Ram Prakash Gupta wrote:
> 
> 
> On 6/1/2026 1:00 PM, Adrian Hunter wrote:
>> On 29/05/2026 11:10, Ram Prakash Gupta wrote:
>>> Set ice clk rate from sdhci msm platform driver, needed for
>>> target which are having legacy ice support, and need sdhci msm
>>> platform driver to set rate.
>>
>> Please expand upon what "legacy" means here?
>>
> 
> for devices where ice node is not created as separate device node those
> are referred here as legacy, separate device node for ice starts with
> below change: https://lore.kernel.org/all/20230407105029.2274111-1-abel.vesa@linaro.org/
> 
> also I will update legacy that ice nodes which are created withing mmc dt
> node, so that ambiguity about legacy is clear.
> 
>> For CQ case, qcom_ice_create() prefers "ice_core_clk" before
>> "ice".  How does that relate to this?  Please clarify that in the
>> commit message also.
>>
> 
> "ice" is the naming convention used for emmc ice core clk in dt and
> "ice_core_clk" is the naming convention for ufs ice core clk. In the
> function you referred, since ice driver is common for both storage media,
> it tries to parse both the clock.
> 
> Here we are handling "ice" as this is needed for emmc only. I will add
> the same in commit message.
> 
>>>
>>> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>>> ---
>>>  drivers/mmc/host/sdhci-msm.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>>> index b4131b12df56..c6a073718aa4 100644
>>> --- a/drivers/mmc/host/sdhci-msm.c
>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>> @@ -286,6 +286,7 @@ struct sdhci_msm_host {
>>>  	/* core, iface, cal and sleep clocks */
>>>  	struct clk_bulk_data bulk_clks[4];
>>>  #ifdef CONFIG_MMC_CRYPTO
>>> +	struct clk *ice_clk;	/* ICE clock */
>>
>> Why keep ice_clk?
>>
> 
> here we need this ice_clk because rate set is required only when ice clk
> is added with emmc node in dt, and in case we try to use the clk entry of
> qcom_ice structure it will set the rate for new ice node as well which is
> separate.
> 
> but also we can avoid this, since this one time operation, and we can reuse
> local variable clk inside sdhci_msm_probe, so it wont be needed. I will remove
> this in next patchset.
> 
>>>  	struct qcom_ice *ice;
>>>  #endif
>>>  	unsigned long clk_rate;
>>> @@ -2708,6 +2709,17 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>>  			return ret;
>>>  	}
>>>  
>>> +#ifdef CONFIG_MMC_CRYPTO
>>> +	/* Setup ICE clock */
>>> +	msm_host->ice_clk = devm_clk_get(&pdev->dev, "ice");
>>> +	if (!IS_ERR(msm_host->ice_clk)) {
>>
>> Does not attempt to deal with -EPROBE_DEFER, although bus_clk above
>> doesn't either.
>>
> 
> here need is just to set the rate, rest of the enablement part would be 
> taken care in ice driver, hence we can avoid this handling here.
> 
>>> +		/* Vote for max. clk rate for max. performance */
>>> +		ret = clk_set_rate(msm_host->ice_clk, INT_MAX);

This will cause crashes or at least brownouts because it carries no
votes for the parent power domains (CX etc.). DT should be updated
instead, this is a dead path

Konrad
