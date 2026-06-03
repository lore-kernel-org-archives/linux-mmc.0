Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3609F3F9260
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470208; cv=none; b=FMTAzx+QaO6QnOmHKm8xnfRBVg7APr5YP4HIs7O2qoWaJPmRoAse7gVrCkdKATzfjeGPGL/6RZ5s/x9BBqLnUpPMM5DMGWx6788WBhMGnnkeoopqOqBb+kjFCkme1lCPQjUCCNk+tfZQ1qQSpQlZH6avsmkkGZZxDLbTzg/2kAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470208; c=relaxed/simple;
	bh=+Bdyb8NLUTZehHkS/DRDaP+HG2rm7RhQMH8vfW8lELM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XWf1fVf9OEAki1g05PZVC+TdAbXUyXlr4vInycOCjdGhl3eq11l51+vUFc59Lif7cDeG/xzxHfaUvaMh9GfbXiplOmo+k22zXPv2IqGKkczkRF0dkzbCKozvwd3ta2piElkWg2NiJQcXEi2C6hHh6jN7qfghfDfG4KcNUD4WPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KDNFW9Ut; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hwY7HLml; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KDNFW9Ut";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hwY7HLml"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RWqD1946609
	for <linux-mmc@vger.kernel.org>; Wed, 3 Jun 2026 07:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nMLZeEzqO4xkJISu22ZsbDrmPK8krRqnPWp6pg5qz8g=; b=KDNFW9UtWVmjiyls
	xR0uZYOWAjfYhdLcE2loiDbT+8Jv8v8WTq/OvZShvHOkzZtFcLirVQenCvIwWAbE
	oA6x95oSAhe0fksPBRLrv/AbAcvPXFOsqxk4RuTg4kzTWW9P1MMdODcK4kpJJzFn
	tJ5GbH5+gWQi+JhHLWLUEAOJmNMVQ5+qDsrFkxONCs2TLbO8hz9pmqzAcP5Ci+kG
	9BFtMUBHttwjU2r89m0E7sNZCpF7kAorRL0vwVPLA1s2IXY4okRsWyg2T5hOnApd
	DINXy3h7GigdYgB6wJ5LL6C8jkLka5stsZRuQ1ogZcVvx63ffDTrf0UEL4Tdq36g
	SDcVTQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabgh4tt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Jun 2026 07:03:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8422b544a4bso2589956b3a.3
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jun 2026 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780470206; x=1781075006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nMLZeEzqO4xkJISu22ZsbDrmPK8krRqnPWp6pg5qz8g=;
        b=hwY7HLmlaECQjvdJnDaZis1ZZTkoDESODwR2r8pd0KEjTASgioFjwK4/mLg18nrOly
         Vj5wBRF7IJaJge7HcVIyNwNF7Mdsu5NCpOkYXO7pd21enC8TH7K2Ivrt2IDm6DcvlImy
         bZ110dpJi7rDiTc46HpmHB1lzB0+X429aHfMuE1BnMWaZKYnco1abUiMruKk4L4nUGAR
         9xralDwp8NCtAzn1RXJa1xvdkhfmq1oPeTCXbYKb/h1KRUa5AsY8mgdT8V3QZvSyxMGm
         uvsbXjCDI5SgtSjk8DkMja4MrR4dfi9FnTRgjM7fkVl7B3Qs3APNJLfj722hq6yW/CNo
         fAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780470206; x=1781075006;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMLZeEzqO4xkJISu22ZsbDrmPK8krRqnPWp6pg5qz8g=;
        b=iZxnkCkKrwI/suNA8wYnj81fgYd4k7c09+E9SabfKIp7I+mS5rupPXhtYIp+E0mr4r
         eQeH5UBuPNvBBEFQOSv4DdGL6fheZYImxIbuCnWAdL3x0W1kPji4OwfuAdni2GlJgopK
         jmpT8+CnNAMFgP97Yao8L459uqgTK7klE6dhi0FshBivz+PJFEOfsPKXpKJCIlO9CD65
         h3mSfk+tpZkm2A335yDLhlpNJzhwsCxBQR7IQRN0jVSYUu28CZGaQWA4yyC757hVzON9
         SdNAzgJYFlIjIidsOKIfYyL9RKWWu3Bp5X79oYMAozi0jJXhU3nKDu5QXs/7hPLZEU94
         RwNA==
X-Gm-Message-State: AOJu0Yw7R2yddpoxnaGeQ9Y2yioT2UNrWJkCHxV3Kzgf24Yw4aSDIzLI
	FNGkUlFvOfHS3lieh18bc1drc76HGhTb4xjnEd6qOseUPVCnhwyuzoAAiOn5Uwn1737IJKvKOyG
	xCE88dKThT9voV6Yxr/4yvCQ8Pkb+qoVVCLuJqp4uS/oJ6w5/SshhZiYF2jDGuw==
X-Gm-Gg: Acq92OHT8TtdCC2Zq4WIdCGorHOyswh1CAmD3k6OgHbSUzpI8eh8nxXBel2VE4mh6TB
	VZe/rfr5da0FXqsu1I7AveFxydi5vfgObuSGch2oRRxYro2xp84jzaV06WLdULvrk3T3OHcrBox
	9tDPbW1s8kk79vhP1TctebqLdH00OPt+1pbccWTuIEs5qL4mUwbNcPeuWnX92yj5NE8bZRBY7et
	zWObl9HbdMyYmcDU6bfZ8ltfKpPnn/u6oDmo8/d569AMXjxbyW83s92qTyz/Cv+YLm7g7M1/hLR
	rWIs4LVqFv1mRHb838PqSgFRIHNUxER3nbojSuN9cgd34U3RI6rvK8R8vN6JrKtpBL7HiONPzTN
	Ky51G0fD6cKZNRoEwPBK/4OqCRTV863wZA+FV9stcIcNlIbrs6FLEwSTg
X-Received: by 2002:a05:6a00:2351:b0:839:9053:9a16 with SMTP id d2e1a72fcca58-84284f936e9mr2207836b3a.47.1780470205617;
        Wed, 03 Jun 2026 00:03:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:2351:b0:839:9053:9a16 with SMTP id d2e1a72fcca58-84284f936e9mr2207789b3a.47.1780470204929;
        Wed, 03 Jun 2026 00:03:24 -0700 (PDT)
Received: from [10.217.216.18] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428706fa9asm1260427b3a.45.2026.06.03.00.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:03:24 -0700 (PDT)
Message-ID: <a03e129c-6719-4cae-bffd-563bf1dfc335@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:33:20 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
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
Content-Language: en-US
In-Reply-To: <18af0dcb-8cf1-4565-a90d-58bf1e66811f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R6sz39RX c=1 sm=1 tr=0 ts=6a1fd1be cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=6wBK2Req9ijoumtyTN8A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4eY28q8e6aB_MPzQVif20JdT0BWmfy-l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NSBTYWx0ZWRfX9FTpFufDyDNo
 8nwmdtLS9+cGS90pMDBOdXv0Drzrmd4FEehSClY7g1N5nDmZUwea5XIleMZlacg1uQUhNv2+E+/
 0ZxkjyxUomaEFYJXP7lyjmgcTmdVEs8gfSe08ANCsfyUyUBMPnkzSRY16PUN0dWCX6YYz82wt0U
 p59RyU3muITy7+uS7o4WkkfZ/r3/LsyiINaqOP/qjUCNbNXPUyauzUX0kiyEar4rLj+aJ187R2q
 ONRwCmLxe7FNXxuSkcERZLsL6j4/E+4AG7a+oeVgcuhg61GSoJPfFqQ2K2or+A6WWtKDebEmmYy
 RLzTjPJSx/yBV8hrGnW7Nwb3qJjBY9+e0L80BgMIZj4gQroPuWXcRem/BZ+XhcOPBdrXfE8iDRI
 /wX30zh+vXVfDuIssQrLdvdxMVcCvTxlvCmgSXn9wWcFXLJOCCG9Ik6Hu6r+ymP0Ff/oajdRGkz
 wDKT9cfhORVSZt+83Zg==
X-Proofpoint-ORIG-GUID: 4eY28q8e6aB_MPzQVif20JdT0BWmfy-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030065



On 6/1/2026 1:00 PM, Adrian Hunter wrote:
> On 29/05/2026 11:10, Ram Prakash Gupta wrote:
>> Set ice clk rate from sdhci msm platform driver, needed for
>> target which are having legacy ice support, and need sdhci msm
>> platform driver to set rate.
> 
> Please expand upon what "legacy" means here?
> 

for devices where ice node is not created as separate device node those
are referred here as legacy, separate device node for ice starts with
below change: https://lore.kernel.org/all/20230407105029.2274111-1-abel.vesa@linaro.org/

also I will update legacy that ice nodes which are created withing mmc dt
node, so that ambiguity about legacy is clear.

> For CQ case, qcom_ice_create() prefers "ice_core_clk" before
> "ice".  How does that relate to this?  Please clarify that in the
> commit message also.
> 

"ice" is the naming convention used for emmc ice core clk in dt and
"ice_core_clk" is the naming convention for ufs ice core clk. In the
function you referred, since ice driver is common for both storage media,
it tries to parse both the clock.

Here we are handling "ice" as this is needed for emmc only. I will add
the same in commit message.

>>
>> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index b4131b12df56..c6a073718aa4 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -286,6 +286,7 @@ struct sdhci_msm_host {
>>  	/* core, iface, cal and sleep clocks */
>>  	struct clk_bulk_data bulk_clks[4];
>>  #ifdef CONFIG_MMC_CRYPTO
>> +	struct clk *ice_clk;	/* ICE clock */
> 
> Why keep ice_clk?
> 

here we need this ice_clk because rate set is required only when ice clk
is added with emmc node in dt, and in case we try to use the clk entry of
qcom_ice structure it will set the rate for new ice node as well which is
separate.

but also we can avoid this, since this one time operation, and we can reuse
local variable clk inside sdhci_msm_probe, so it wont be needed. I will remove
this in next patchset.

>>  	struct qcom_ice *ice;
>>  #endif
>>  	unsigned long clk_rate;
>> @@ -2708,6 +2709,17 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>  			return ret;
>>  	}
>>  
>> +#ifdef CONFIG_MMC_CRYPTO
>> +	/* Setup ICE clock */
>> +	msm_host->ice_clk = devm_clk_get(&pdev->dev, "ice");
>> +	if (!IS_ERR(msm_host->ice_clk)) {
> 
> Does not attempt to deal with -EPROBE_DEFER, although bus_clk above
> doesn't either.
> 

here need is just to set the rate, rest of the enablement part would be 
taken care in ice driver, hence we can avoid this handling here.

>> +		/* Vote for max. clk rate for max. performance */
>> +		ret = clk_set_rate(msm_host->ice_clk, INT_MAX);
>> +		if (ret)
>> +			dev_err(&pdev->dev, "ice clk set rate failed (%d)\n", ret);
>> +	}
>> +#endif
> 
> Could put this in a helper+stub function in the "Inline Crypto Engine
> (ICE) support" section, to save having #ifdef CONFIG_MMC_CRYPTO here
> 

sure, will take care of this in next patchset.

>> +
>>  	/* Setup main peripheral bus clock */
>>  	clk = devm_clk_get(&pdev->dev, "iface");
>>  	if (IS_ERR(clk)) {
> 

