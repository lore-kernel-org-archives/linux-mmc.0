Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841BD3F2106
	for <linux-mmc@vger.kernel.org>; Fri,  5 Jun 2026 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653985; cv=none; b=CbVIPNyHOJAvPWscVwwM5PJL1rHLpRPA72ZhJipikzZyQW5bXNiGtKUSXRJoUbR4ZPmYXUlKv6/qCJr5lx3Zi9kjuCzOPzUy3fJagPLscMYZ+OmeoobrVGUWHU7uRqpgFxtkf+NRY9yXQk8iLVjb4pbMBeW2mFNRNM+sVgLdTC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653985; c=relaxed/simple;
	bh=x6Mx/EW/MnayQyGmBtoLxhCwOIWl2EnFGvzou5bIL3k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y1ElERbJJcCiWSB4nsftIiYXJSXfIJuCjVi0EB2rJCB4VGw66AagEV+sQU9cQQcIrTOklN+JYcmm/Cqmlxj8loC5lQ54e6bePFDa+7rijfbgNuYtEKnvx2Q51+Xy4xThfsOA5IuvditiiEzktpajg1oSHpVKr0vtpbLB6HR57jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b5JWmOkp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dO7L8OYw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b5JWmOkp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dO7L8OYw"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6555qGn32428353
	for <linux-mmc@vger.kernel.org>; Fri, 5 Jun 2026 10:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cm8WyObyqkNfRyMO7iz7bczR6KF/VFOYPmwAPfJalxw=; b=b5JWmOkp14IgWlcY
	HpfJ5cagbB0aPkpIrZJAMwxWbvT+yVC3pT1GB2h+A84TH/Id7e3t1NxtdDYlYUOV
	O7AL71vmtWheMVr7pOySNtYrcbTlRxKZApl6KevjsEofUxYfzhHApdPBxx9jROam
	9DXKkmQvdFENxdmvZcgw96aP7S1BQDEeKFd60L+ij8AyFVGXQT5OHJdLUlxgKiai
	HyGQZcOm7ELnaBjpP/KkxjTXcWPoOu2hg4llRZN2ToUQRUX8ikfcGDT5lC7jZPwK
	V+g0MEaonk9eya+jAswFI+izXoMuCCJvE9Kr1K/0IQgwLXwOGwXLfec15WbOMY/A
	aa8hsA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekrphh06c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Jun 2026 10:06:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0b35fa876so20429735ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jun 2026 03:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780653983; x=1781258783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cm8WyObyqkNfRyMO7iz7bczR6KF/VFOYPmwAPfJalxw=;
        b=dO7L8OYw0TIDOlkSO0CCQq05Q88NVHkHxEjIBzZtHsIDfo9qnd7cGrA1lmVNU2vABy
         QwWTBHylq3ZWLNRU74pJSAMVMZ+mmYmaoGc4eNFxr7C9hicT/hkgBSRc37R0H5z9RiWz
         c5nNUuALJJ1UU/IF1D1A8Vn6YMjvHNkiJZOD63L9DAGqXLWKVL2c7oPW83kOezpKZB60
         +m8mJfhS6OyV2KwoaWdq4yrYImYb7M75apC3uMRrr3eOSrgX311T+DovFRlxMjwzLEiG
         3GyEJzyGW+zDlVuRuaMpohn75vKOSJFVpMpvN6lC+WH2tTctZaVbxG0Cx1+TBUKJi3++
         rEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780653983; x=1781258783;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cm8WyObyqkNfRyMO7iz7bczR6KF/VFOYPmwAPfJalxw=;
        b=PZalqbTuCTCKHcfcotGhkrvA2FyM4yB+OJG2XPgWwUp+o7VPAj97eFz1T94x41NmxX
         Z2X/URsNUR2Pvmo+AXOVt2zu+P0PI3LXNNe8/coesmTyWX4NA9W2h2hS45DakZwER0QG
         yDpAaZeMnpNXKjbPDolGqHI6hT6L3/iz4mlzaRuStOfCqJdDEfLPiA72k5S7Z9j3Z8EH
         brdGx+PIURGMTmkFHpDKPb1o1Bo6pjNei910PWmkTu1AxK1eg7Smp9CyQZD5AQwOcGW5
         Y/wn7hv10nNE2FQcRDgUsou6WUYVk6Toi9KMBPIlLutiitiyewK6+qH18jRFHsh3S1b8
         ASxA==
X-Gm-Message-State: AOJu0YxxIor6a475BPpUxcc4ducek73FoMXDiqxrmfrq8HIsRia/wtt8
	Ko8o9dEBt9NrsssY5GrlFtjpp88tZB6CT4TizFDKnpl6pIXDVqKoaBL96SRfAKSVXiJ09BrAFJO
	F7EUKAtvp3YPoUdGBRR5csOod9u65Km780Y3iRLQy9gdgb9OqPmKBvPHWdaIxJw==
X-Gm-Gg: Acq92OGnQbZPtyIGvKm1K2I9uRkWRXVSKHb4cxwY/UXaMh1gqDhrZbWV2SWnfRXAs+j
	VUq4Lzt8wBmEjxHlpTwgJ7JJ10+J9K3VNvF6xRiip2fcma8j3aqwsafVRUlguAVh9sP47sGSo3n
	G8EycK1MVE/VEt4EW2tlpO/jhyAIgSE34mZmcq7Jyu2J7oggHS8aNKNjFAv/Q/RSXMCZ7ywq6FI
	PCK+uUDoDoEBjBr8j5hnuhqzPqXABnmFPduFnC7so3lb2WE7ykx20aRbcKc7ZSpciVn0xO1SJpL
	gekqJz1hKD8qAkhUAR5Np3EkHDTmDvca1hbU0dL9AttQosFF+PrRNicG6ZZpUcfr5oezyztUy71
	6gpf+G1eP0nrzU5r/3fqy95Od+TFu7PoLwC9IpdDXHPvOBbTyBhuUjsbu
X-Received: by 2002:a17:902:e790:b0:2bd:d7c5:9272 with SMTP id d9443c01a7336-2c1e78dfad0mr30498905ad.6.1780653982974;
        Fri, 05 Jun 2026 03:06:22 -0700 (PDT)
X-Received: by 2002:a17:902:e790:b0:2bd:d7c5:9272 with SMTP id d9443c01a7336-2c1e78dfad0mr30498265ad.6.1780653982379;
        Fri, 05 Jun 2026 03:06:22 -0700 (PDT)
Received: from [10.217.216.18] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm89757565ad.60.2026.06.05.03.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 03:06:21 -0700 (PDT)
Message-ID: <aa80d41d-43a9-423d-960b-c7a7125c5014@oss.qualcomm.com>
Date: Fri, 5 Jun 2026 15:36:17 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-msm: Set ice clk rate
From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
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
 <1487d620-eb28-4a66-a611-0c6dfdf1e538@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1487d620-eb28-4a66-a611-0c6dfdf1e538@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: E1EorhDWEsgCLKMcHgOUMNsGRoQSTfrr
X-Proofpoint-GUID: E1EorhDWEsgCLKMcHgOUMNsGRoQSTfrr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5OCBTYWx0ZWRfXzKGi7lXy1QSM
 NB9MPZgknSllXFcboyoa6xUV0j9DQyN/u5Wqd+7oxL2NYzw3iqSM8zm+5xUa3lniKO9xmUmNace
 P1QNh7hX2RTX9zMNDpKlpusGUTxaPlNT0pDhHbWXEndBdp7YvDRlsYmo9ZNRvWOVEqkBSXS+s5U
 59lmUMV9WXaqLDloKERtfqDIE/yD8fUcdsT9CfHIDR1Z7t1DBznSE3KihI9ZOufZBgLcKGzsiVE
 VAYn1iwZYMIhXU1vWI/422qnyqb2BQTEt4IyH+kmD/B0xLT5ys+yuBV1HwjoGPy+u017cn46nqR
 mT5Fhu+7VANKHgRhVgNkz6CytH5kgEUBaXVvK3IoYsuUGLFZ1Qokua68BZF+jmN92sGtSixWmBh
 pc6i/6C49Ls7lRZwUBelt3wjySzxoabN3XsAH3akNGZ2Aadb1Kc3Yy45WLcnw/juo/dgUKrHD8T
 tDgr0lI78ezYOK4Jfpw==
X-Authority-Analysis: v=2.4 cv=T9a8ifKQ c=1 sm=1 tr=0 ts=6a229f9f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=eytIU0s1LhRWHgRMX8MA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050098



On 6/4/2026 5:45 PM, Ram Prakash Gupta wrote:
> 
> 
> On 6/3/2026 1:18 PM, Adrian Hunter wrote:
>> On 03/06/2026 10:03, Ram Prakash Gupta wrote:
>>>
>>>
>>> On 6/1/2026 1:00 PM, Adrian Hunter wrote:
>>>> On 29/05/2026 11:10, Ram Prakash Gupta wrote:
>>>>> Set ice clk rate from sdhci msm platform driver, needed for
>>>>> target which are having legacy ice support, and need sdhci msm
>>>>> platform driver to set rate.
>>>>
>>>> Please expand upon what "legacy" means here?
>>>>
>>>
>>> for devices where ice node is not created as separate device node those
>>> are referred here as legacy, separate device node for ice starts with
>>> below change: https://lore.kernel.org/all/20230407105029.2274111-1-abel.vesa@linaro.org/
>>>
>>> also I will update legacy that ice nodes which are created withing mmc dt
>>> node, so that ambiguity about legacy is clear.
>>>
>>>> For CQ case, qcom_ice_create() prefers "ice_core_clk" before
>>>> "ice".  How does that relate to this?  Please clarify that in the
>>>> commit message also.
>>>>
>>>
>>> "ice" is the naming convention used for emmc ice core clk in dt and
>>> "ice_core_clk" is the naming convention for ufs ice core clk. In the
>>> function you referred, since ice driver is common for both storage media,
>>> it tries to parse both the clock.
>>>
>>> Here we are handling "ice" as this is needed for emmc only. I will add
>>> the same in commit message.
>>>
>>>>>
>>>>> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>>>>> ---
>>>>>  drivers/mmc/host/sdhci-msm.c | 12 ++++++++++++
>>>>>  1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>>>>> index b4131b12df56..c6a073718aa4 100644
>>>>> --- a/drivers/mmc/host/sdhci-msm.c
>>>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>>>> @@ -286,6 +286,7 @@ struct sdhci_msm_host {
>>>>>  	/* core, iface, cal and sleep clocks */
>>>>>  	struct clk_bulk_data bulk_clks[4];
>>>>>  #ifdef CONFIG_MMC_CRYPTO
>>>>> +	struct clk *ice_clk;	/* ICE clock */
>>>>
>>>> Why keep ice_clk?
>>>>
>>>
>>> here we need this ice_clk because rate set is required only when ice clk
>>> is added with emmc node in dt, and in case we try to use the clk entry of
>>> qcom_ice structure it will set the rate for new ice node as well which is
>>> separate.
>>>
>>> but also we can avoid this, since this one time operation, and we can reuse
>>> local variable clk inside sdhci_msm_probe, so it wont be needed. I will remove
>>> this in next patchset.
>>>
>>>>>  	struct qcom_ice *ice;
>>>>>  #endif
>>>>>  	unsigned long clk_rate;
>>>>> @@ -2708,6 +2709,17 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>>>>  			return ret;
>>>>>  	}
>>>>>  
>>>>> +#ifdef CONFIG_MMC_CRYPTO
>>>>> +	/* Setup ICE clock */
>>>>> +	msm_host->ice_clk = devm_clk_get(&pdev->dev, "ice");
>>>>> +	if (!IS_ERR(msm_host->ice_clk)) {
>>>>
>>>> Does not attempt to deal with -EPROBE_DEFER, although bus_clk above
>>>> doesn't either.
>>>>
>>>
>>> here need is just to set the rate, rest of the enablement part would be 
>>> taken care in ice driver, hence we can avoid this handling here.
>>
>> If devm_clk_get() returns -EPROBE_DEFER, then the rate will not be set,
>> so you are relying on devm_clk_get() never to return -EPROBE_DEFER.
>>
> 
> here -EPROBE_DEFER can be returned when clk driver is not ready, in that
> case other clks, core & iface, would also fail to get enabled and then driver
> would run into issues.
> 
> In case we get -EPROBE_DEFER for "ice" clk only then as you said rate
> will not be set for ice clk to max but warning log regarding ice clk
> rate not being set would be printed, and the ice clock would be set to
> 19.2MHz and in my opinion its not fatal.
>

my bad here, we wont get the print, I will add else case for log.

> so -EPROBE_DEFER handling seems overkill here for ice clk.
> 
>>>
>>>>> +		/* Vote for max. clk rate for max. performance */
>>>>> +		ret = clk_set_rate(msm_host->ice_clk, INT_MAX);
>>>>> +		if (ret)
>>>>> +			dev_err(&pdev->dev, "ice clk set rate failed (%d)\n", ret);
>>>>> +	}
>>>>> +#endif
>>>>
>>>> Could put this in a helper+stub function in the "Inline Crypto Engine
>>>> (ICE) support" section, to save having #ifdef CONFIG_MMC_CRYPTO here
>>>>
>>>
>>> sure, will take care of this in next patchset.
>>>
>>>>> +
>>>>>  	/* Setup main peripheral bus clock */
>>>>>  	clk = devm_clk_get(&pdev->dev, "iface");
>>>>>  	if (IS_ERR(clk)) {
>>>>
>>>
>>
> 

