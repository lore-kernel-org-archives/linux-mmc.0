Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB6944102E
	for <linux-mmc@vger.kernel.org>; Thu,  4 Jun 2026 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575362; cv=none; b=dh0UZ2xiutWUm2dlbiEOVq6sFr7H8sBrXUndQ/mT89QcZ47pnfK+i2QAyFnqYnkXOeKR1EU6x+s3EqfbcW7TM++JRqnj/yvahw+DrHMpol6249WSv7GDI2nTHhuBdRChu9llu0o6fwPuUIDucV9WZdRLvPdmuGnl0jQTUAdgn0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575362; c=relaxed/simple;
	bh=9osXu5fHUdBJo5gaIuC4k3hPxCN1r5YRP7q6+f+cR64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTWWL8Q9CGTLsipR6nsFu+hS+Jo2eg/rXIfgY4Hw6CVN1ZfJ6vsvYKNzbxEgVSzmSHaCXqGOn+lzhrYdRcn8n5YmuFhyAq5YdWLqaZWSgYB5BQDrMjTOiBk3vYYKxuG7jD4bNGnLvUuH3BsPPhMx/aS6gcNjINXMRQ2MZ6RA350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KUWENSLo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bfmR7gw9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KUWENSLo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bfmR7gw9"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654AEUMI3234759
	for <linux-mmc@vger.kernel.org>; Thu, 4 Jun 2026 12:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gvAt8SYmZzFHqCAJjilcE2ioUDijd8ZA9Agl1qVcjT8=; b=KUWENSLo7npGpOvW
	Dt0XYHEoE4s1Rg1F84BOShzhjjvLqbZBpH7tpmAth28ZsYXflsl4KIBQQ7NwzHG7
	F+P/Hq/f5ZZ9xb5jZixGzLdj9miS3n9OuESjCoXQ312JMONAz6kk34x34sJjmryv
	oEggdbWDaYJEdAEzlbx+9ULpAzKmAqep/UFTcnoanamj1wFKwT7Q+y3617vdh5u6
	3GRG9YqXQHeWXOd1Qjt3Wo8lBHc7i70SodOaqiNdSJMtWaB6Cz6FTqH9zYZwkcnk
	k+I2vMdXvCsdWaJLazMUqY91xalaE1RqwaaHfYMh84KrBk/K+udAADKrfrR5UdiP
	AdECJg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs4s3mnd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2026 12:15:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d99181eaaso878551a91.3
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2026 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780575358; x=1781180158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvAt8SYmZzFHqCAJjilcE2ioUDijd8ZA9Agl1qVcjT8=;
        b=bfmR7gw9fqB29NabKAwJ6EBo9lNGLPH2v2oX6R9NDIm2YNTprsm8uwirzwf6gjwQ6c
         CCvixhAFfb3tttDdsR8p57RvvLpGJ0Pg6qbje3DKdIs/8HC4vshra9N2acb23GTzDxnC
         +6j297QvP4Ep2hUg4myaXePrw0iDnoC6OvFNFYimhrqy08vr1GCny4sBujh+nY1AgToI
         XbIeMD5X6Ulgeeu3NsMshhTOfpa+dGdG4qHj/57Y1igGm9botzVMOukVcNcT3JrLYWHC
         CTn46dP7KsC0R7TM7kWH0QVVVfol8sjuzoBZ5UDwkU4Dxm5VA92HWUCHlFghueoy3orl
         Na4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575358; x=1781180158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvAt8SYmZzFHqCAJjilcE2ioUDijd8ZA9Agl1qVcjT8=;
        b=Io7QMs8En1qKZJAUuHt32U44uMiihgZG0JsOwCcg2Qn0i3Z5oQJVZJDQwIgaBX2XKf
         A1FulEwMhTLU+o81sCOKrSZfR/61Wt8axjDWp942eKNh1Bf8YvQVX6pMtZrnN5zUTHyL
         bx3eexneUyBifMVUuDVapjHLsAfIcQvz1ycOW5o4To4860mL8aCFr3T3DZ2KRfusjjnf
         L8uRsgUlCGgJ9kpSCnH+0BG9x8DnogJ0rYQneNcXuLrx66pJM7DSy+i2qppEztkAXKdQ
         E9+aNiKmUqgMc27CZJm0W2DT/Z/aNR7Ayl9StFMKkjJFZ9kVu+GI7f0jmI+RRI9KoCrM
         VN4A==
X-Gm-Message-State: AOJu0YxKi7c9zuy+RZ7ctg2elN09AEUSyPR6B0KC5btcUsm9i44yJN0d
	CIuGVr4G+pQ7+cfIh0PHFS6ijPRgk2fWugCEcYb/Gn7jy7u8lG8nxnpiOFwbmWeGXtsc+oe0wGo
	d3Oxa5vqP/Y5ySGbZZrWQtH8a+CggsLqC1CQ0meKHL4DPAaLENi/JgHuOqX/A0A==
X-Gm-Gg: Acq92OGhLBlCFvVsY5J37H0usYQwxR9Po9JM8b7sQxtTHWrssbLIybSYV3TMsTSPXVv
	dbYl98e2XKV/H0/N7pOwjU25M75Aj/9PKFozN6rcGUrk752ejHrya1NyBHneERKMgqC4I4RzqX/
	yz6SraYhHUK2fIQlfI69FaGDTusjjA2whGwDUZ0imGj11haDCe1VQbVwnemaF9msPyUPq1+5trj
	ZcZb0cbP9vhY6i8T9XKYAgpnglx5GcvE7dLnfnK3XxzixFlnsU4/ROLVFh9JsPp8vZSC043IPBi
	+QNnCr1050dKKpPWzUFokV30X/qtolCcpcUSKD2WOwCPy/+dA1eawREVzDRzfTkRuOnJi5ujKEc
	HdP0O6xNhlHncQYnNR2Pd8kJL/iDUFYtTiyw/n3ucVcUmAWfaaDnzQc5x
X-Received: by 2002:a17:90b:578d:b0:36b:9512:871b with SMTP id 98e67ed59e1d1-36e2fa98077mr7699305a91.11.1780575358080;
        Thu, 04 Jun 2026 05:15:58 -0700 (PDT)
X-Received: by 2002:a17:90b:578d:b0:36b:9512:871b with SMTP id 98e67ed59e1d1-36e2fa98077mr7699267a91.11.1780575357528;
        Thu, 04 Jun 2026 05:15:57 -0700 (PDT)
Received: from [10.217.216.18] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827f1sm3877450a91.3.2026.06.04.05.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 05:15:57 -0700 (PDT)
Message-ID: <1487d620-eb28-4a66-a611-0c6dfdf1e538@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 17:45:53 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-msm: Set ice clk rate
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, konrad.dybcio@oss.qualcomm.com,
        abhinaba.rakshit@oss.qualcomm.com
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pradeep.pragallapati@oss.qualcomm.com,
        manivannan.sadhasivam@oss.qualcomm.com
References: <20260529081045.2877910-1-ram.gupta@oss.qualcomm.com>
 <20260529081045.2877910-2-ram.gupta@oss.qualcomm.com>
 <18af0dcb-8cf1-4565-a90d-58bf1e66811f@intel.com>
 <a03e129c-6719-4cae-bffd-563bf1dfc335@oss.qualcomm.com>
 <650d6ae8-36c9-44ba-a065-a1ceebee48b2@intel.com>
Content-Language: en-US
From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
In-Reply-To: <650d6ae8-36c9-44ba-a065-a1ceebee48b2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _VBqyh5K2_QT17ZmV6PSdEQU051uQI2h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDExOCBTYWx0ZWRfX5RzSqZLJoy/I
 Z+iDcGY3FHZ7u3asS3I7OyINC5saxt39rA3ml7rZEI7k2BB0SsdQMU8XjDyMhPrbGBQJs224zNx
 qy+ryz1a7TxIEnRsrXNL9dAN/WuIbDyve58pjktBIp4TSmKJPreWdUn3CPxTW6kf5JC2RWSSLgf
 1ae3hcRlrzHQbeqZaAq3HxXoKpUmjQSsx5wPjJeMxYMEkhQa1oMrweVtan3Rb7oaC2nyMXUoFnt
 3yYUyizmIxI/EvxQdmZF60xqWJyY6LvrGzhrf0hQdRM4ATiBnNlsEQsIXqQE4L8YHfUqO+Gb9ga
 8Np7N3thUJaCWGzzxnL2tVYbS4poWHqMd4bOAPA/nLL6HUZkGJfP3RpEihANjV1mgE4RAtKdRJk
 r3sFhiYCDyUS29tdyUI8Oh6WS469kM2nTdK4/9L8s878UbNqXz4eIkbbPVtU1yKpXQnKvBHCnGD
 A7zxoU66IjP3T6ANJFg==
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a216c7f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=MYak2lq3idgefSP0UxwA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _VBqyh5K2_QT17ZmV6PSdEQU051uQI2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040118



On 6/3/2026 1:18 PM, Adrian Hunter wrote:
> On 03/06/2026 10:03, Ram Prakash Gupta wrote:
>>
>>
>> On 6/1/2026 1:00 PM, Adrian Hunter wrote:
>>> On 29/05/2026 11:10, Ram Prakash Gupta wrote:
>>>> Set ice clk rate from sdhci msm platform driver, needed for
>>>> target which are having legacy ice support, and need sdhci msm
>>>> platform driver to set rate.
>>>
>>> Please expand upon what "legacy" means here?
>>>
>>
>> for devices where ice node is not created as separate device node those
>> are referred here as legacy, separate device node for ice starts with
>> below change: https://lore.kernel.org/all/20230407105029.2274111-1-abel.vesa@linaro.org/
>>
>> also I will update legacy that ice nodes which are created withing mmc dt
>> node, so that ambiguity about legacy is clear.
>>
>>> For CQ case, qcom_ice_create() prefers "ice_core_clk" before
>>> "ice".  How does that relate to this?  Please clarify that in the
>>> commit message also.
>>>
>>
>> "ice" is the naming convention used for emmc ice core clk in dt and
>> "ice_core_clk" is the naming convention for ufs ice core clk. In the
>> function you referred, since ice driver is common for both storage media,
>> it tries to parse both the clock.
>>
>> Here we are handling "ice" as this is needed for emmc only. I will add
>> the same in commit message.
>>
>>>>
>>>> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci-msm.c | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>>>> index b4131b12df56..c6a073718aa4 100644
>>>> --- a/drivers/mmc/host/sdhci-msm.c
>>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>>> @@ -286,6 +286,7 @@ struct sdhci_msm_host {
>>>>  	/* core, iface, cal and sleep clocks */
>>>>  	struct clk_bulk_data bulk_clks[4];
>>>>  #ifdef CONFIG_MMC_CRYPTO
>>>> +	struct clk *ice_clk;	/* ICE clock */
>>>
>>> Why keep ice_clk?
>>>
>>
>> here we need this ice_clk because rate set is required only when ice clk
>> is added with emmc node in dt, and in case we try to use the clk entry of
>> qcom_ice structure it will set the rate for new ice node as well which is
>> separate.
>>
>> but also we can avoid this, since this one time operation, and we can reuse
>> local variable clk inside sdhci_msm_probe, so it wont be needed. I will remove
>> this in next patchset.
>>
>>>>  	struct qcom_ice *ice;
>>>>  #endif
>>>>  	unsigned long clk_rate;
>>>> @@ -2708,6 +2709,17 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>>>  			return ret;
>>>>  	}
>>>>  
>>>> +#ifdef CONFIG_MMC_CRYPTO
>>>> +	/* Setup ICE clock */
>>>> +	msm_host->ice_clk = devm_clk_get(&pdev->dev, "ice");
>>>> +	if (!IS_ERR(msm_host->ice_clk)) {
>>>
>>> Does not attempt to deal with -EPROBE_DEFER, although bus_clk above
>>> doesn't either.
>>>
>>
>> here need is just to set the rate, rest of the enablement part would be 
>> taken care in ice driver, hence we can avoid this handling here.
> 
> If devm_clk_get() returns -EPROBE_DEFER, then the rate will not be set,
> so you are relying on devm_clk_get() never to return -EPROBE_DEFER.
> 

here -EPROBE_DEFER can be returned when clk driver is not ready, in that
case other clks, core & iface, would also fail to get enabled and then driver
would run into issues.

In case we get -EPROBE_DEFER for "ice" clk only then as you said rate
will not be set for ice clk to max but warning log regarding ice clk
rate not being set would be printed, and the ice clock would be set to
19.2MHz and in my opinion its not fatal.

so -EPROBE_DEFER handling seems overkill here for ice clk.

>>
>>>> +		/* Vote for max. clk rate for max. performance */
>>>> +		ret = clk_set_rate(msm_host->ice_clk, INT_MAX);
>>>> +		if (ret)
>>>> +			dev_err(&pdev->dev, "ice clk set rate failed (%d)\n", ret);
>>>> +	}
>>>> +#endif
>>>
>>> Could put this in a helper+stub function in the "Inline Crypto Engine
>>> (ICE) support" section, to save having #ifdef CONFIG_MMC_CRYPTO here
>>>
>>
>> sure, will take care of this in next patchset.
>>
>>>> +
>>>>  	/* Setup main peripheral bus clock */
>>>>  	clk = devm_clk_get(&pdev->dev, "iface");
>>>>  	if (IS_ERR(clk)) {
>>>
>>
> 

