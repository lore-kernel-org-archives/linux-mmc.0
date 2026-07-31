Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B823D25CC
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491603; cv=none; b=C0Bg3jNLMwOpxKO68zGpRxkWEPpCvd700jrPz2NeS2S1hASqbjobMzJThw6tnGSsRHpSf4GECT2zZEPqTQ5jbAHQH2HOz+2tfElG2xWq+iDq8xjUsyXJ1F8/aiyFEFZJRCbg4qLyZvRHoHTxjqjKpYu9OfmHRHiawLt3SPoTCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491603; c=relaxed/simple;
	bh=H1LZa/KrxatxurmpF0jmErkpLMHZVVy5f1CpaCtqq/E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aFGX2HfQNzWIHvygsG1G88j4M9haFkh14u05ID2lpXmcAsZRfQ7cStEvAwUhFZIwxFvSqbYLvdsR3faEAGYheWhmWe0R3UPIkQjNj96BBa9BaWzGMz3CdKEg4sKYuIRseCFXzo2dd6P2os0YGp0Sg5EUh32IfUyFChgLAM/Ys34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FuWxOq+v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yy/6bYYe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FuWxOq+v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yy/6bYYe"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V9jFJB3832258
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 09:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HvZg9BaI71518j+dVN+0raZ5nJoSq6JKDTdb3ojUPXs=; b=FuWxOq+vNWU4cliy
	CS+GJZbQ4iGyaIFUYSTpu/ZBuHhBHJXSjWcMo+h596X8DMeMwnkNCLkkzbMkUznO
	qIIi7sCEhQs4xI1X5rOzzi9ixUNOB6c9ZgGjX74tHBgtpv3SId8aCzgb1X34aQ50
	7Tby/eKIZCwic1g90XT6SWp8p5oUaSE7qLYDRAprYPYSF3A28/le/Xw5NLxYDXvt
	lHpbleu36gb2hujIJC8o6tOC4kmmWjuEDcdTx/1KDgD9W+qf2HiKrz6+RlEizqiN
	RmkZwIj5yosqtaCNQi14i3Z6kXQuaglGvNMtjHTLHQrQ1MM/IjwCfolCGBcmFIdK
	ytl2kQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsbm810x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 09:53:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so958535a12.1
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785491588; x=1786096388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :subject:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HvZg9BaI71518j+dVN+0raZ5nJoSq6JKDTdb3ojUPXs=;
        b=Yy/6bYYeUg6o2w1sntgJBGgvgjI1b6Qzj5GPrEbB57MWoClhdeGeflJR6NWZZXIxzu
         rbMYvdUNhXOjy99INl9CqWx+fwx3Nj7LOWJaRETq921hSxy/YemxiF0HL+vlvF4P86sB
         rlPh4QuVn8X+7eLqpFbWflGHlX00wZGrohPVjH7bQ+tZtcTEZDdjMCCX8UcgwUYHshUj
         jkC760oDjTwMIamBzAtB8Nyni7kkisPIajlM6iQGOm3HGBjja+6ZQjNi6jlap8d+9abv
         CaHSioekF2L9P2QAQ7QbVWdYPO774HF46ScOk8TUUqPagnrkmnVrtjrHpgkj/Uypswr4
         Y9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785491588; x=1786096388;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :subject:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HvZg9BaI71518j+dVN+0raZ5nJoSq6JKDTdb3ojUPXs=;
        b=IULT++2F47izlhFjoQHODXhy0vlHn79/aU1TzGFhPNlJwil+xJY7D79FiAq4wzTEJW
         osfs8LxG5EyPqIL4k2OFwqKCyX2ii695hkUKhi+blFNH0nBDxocHlu0Kdh7NtrIO0m3M
         sLt7TXLOmnDHCRBmM4MD218VFixnZAyIXaMcOUZAoG7+lNZHInZG9tsAtxgDYuZcPFJJ
         HbxJeFy+B1+Rv+E0/d7dTLTsAWeXUAFtcIlZc80LkZEUWsX+0n6oDE4cAeCPxtL/2/gq
         hXojU51D8NA10IgRJs/ZXkG69apuXz8vPpmkT+zZR8pU8L11wWiEPClVeEY7+kFarH0V
         nnbw==
X-Forwarded-Encrypted: i=1; AHgh+RrvDUaL9Djno+SAM20c3FZa2p46Jc1l1zK2Ux7E/LoxUVx4BdLmKW8PxX5XCcrhLeH3PalyUjmHtyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5pGCAZJvd1hWQUcjVOYReWZkaRchV9m4V9jo5lTe/TlEFa/8F
	nxPm7wWadwjQXqNOJtHJh7iaFtlWWMJYg1gFh6P0tDfWk0Q6ZpLVMaTmsZ64Qm0bFBZpb5KS+rR
	9IFtvwXSuye+R7OCH5u44GJCO5MQHI368/nmbiTnckGAmh43ubqcLBaXPugrFKPQ=
X-Gm-Gg: AR+sD106DQCoisUZwEdwSzThQ2nEugOs7dfgzfEYQ/HkyQC77F11cRA6gkhU6+jNTo4
	0lYvfO+Nflo9WyiqtLWhq0elLRUPNaLHE70T3tIEnMOMO1v0kddkjN8CoFSnDyL5Ka+soyrqghg
	T5UgZ0yWT2IysTL01RMjJLpQTSzhojrSLn0HqhkzZRF8VUzviFRJsUpROsmCO3Ciw1n/xl123Hm
	3X8BtnqQMGe/RQub3pwhT3kmH1Mvaj6IEMZZmLd3xoStzFyxiB/SzsXHTa/amWqwsw+v7wBfLIx
	/XngC0DWj8+cienWGE1bg31G9fcKRhLV23c2PnoDjSBQjsN8hGWWLp36zJTAx6gVsChUTvxM8hz
	AYhVHthH7kUQaCnxzMsZTP1xEUUw=
X-Received: by 2002:a05:6a20:a109:b0:3bf:7c02:c46f with SMTP id adf61e73a8af0-3c91b09040emr1228385637.14.1785491587816;
        Fri, 31 Jul 2026 02:53:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:a109:b0:3bf:7c02:c46f with SMTP id adf61e73a8af0-3c91b09040emr1228369637.14.1785491587419;
        Fri, 31 Jul 2026 02:53:07 -0700 (PDT)
Received: from [10.218.4.105] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab14475asm1615245c88.5.2026.07.31.02.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 02:53:06 -0700 (PDT)
Subject: Re: [PATCH v5 3/4] mmc: sdhci-msm: Use pm ops instead of macro to
 restore crypto keys
To: Eric Biggers <ebiggers@kernel.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
        quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
        ram.gupta@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
 <20260730140822.1976635-4-neeraj.soni@oss.qualcomm.com>
 <20260730192336.GE3139@sol>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <a18f5699-0337-a4b8-369f-138c140fcaf7@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 15:23:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260730192336.GE3139@sol>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IKEyzAvG c=1 sm=1 tr=0 ts=6a6c7084 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HjoYPmhRGCijR8R-PCoA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 5ZjiFXf3NdZ4kgvINOdCpTXoVjEA8MoM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3MyBTYWx0ZWRfXyNvB89ay7kdi
 7s/g4o0ETwdVmywMKDlmdBglypt8MXlwQl+UBwXR6uYO9w8nzCGupRD3t6crPCcr54DzLVi+KVQ
 SJ5xvHMpU8ridJdN6I3RGQB0LLtpx8E=
X-Proofpoint-GUID: 5ZjiFXf3NdZ4kgvINOdCpTXoVjEA8MoM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3MyBTYWx0ZWRfXwzhnGeixTYl9
 fHYvl2b95nnVSm65W47owxPrfv34noVk4omD75pSBsW3dpRDKMEvmtP2arWVRqmlBz6IAfq7KsA
 cEU3q83TT8WY+Y8zCslZYIHQNCjBiqwTqhCfCA9UXwpYzYecQxmm3nR4lz4PsS1GR5sBmIWq0rv
 bQUI79DsbM/tNC2KylQry290r94Awg3LVJipsDc04EvjPnmE8XGJZnT6CiqPWyPhaQuT79Lm704
 +Mx6cLpb3MyIUhsnmuuRy9YexW/rBJOVyvBSzIP+BJR9E22LyRBmpF0qjJjyHDj0dL9SsLhE5Vg
 rrLUy8RlGzflQ5HaDFemglMvrhJzXepc1LxoT3MFxuDJOta1D8aas6vtNb/hq5KsCYBcacWmy7+
 /UHOzIy469ZKrFHf1LXnWLj2wdm7sHtuKnI3IS1HwT6vDJl77g6zO3Fg1pFwRjOJscR2OKAUI+P
 W8vMBf6HVx3e7l6zyOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310073



On 7/31/2026 12:53 AM, Eric Biggers wrote:
> On Thu, Jul 30, 2026 at 07:38:21PM +0530, Neeraj Soni wrote:
>> From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>>
>> Inline Crypto Engine (ICE) keys are lost after hibernation entry and this
>> needs to be restored when hibernation exits. ICE keys are re-programmed
>> during sdhci_msm_ice_init() but it may not cover cases where the
>> hibernation image is already restored.
>>
>> Unwrap the pm ops and use directly in driver to add the call to restore
>> Inline Crypto Engine (ICE) keys. This ensures that ICE is brought into
>> same state as before hibernation.
>>
>> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 7d71dc6f388d..a4998e74a2bd 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -2986,9 +2986,26 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>>  	return ret;
>>  }
>>  
>> +static int sdhci_msm_restore(struct device *dev)
>> +{
>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +#ifdef CONFIG_MMC_CRYPTO
>> +	if (host->mmc->caps2 & MMC_CAP2_CRYPTO)
>> +		blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
>> +#endif
>> +
>> +	return pm_runtime_force_resume(dev);
>> +}
> 
> Is it correct to access the ICE registers before
> pm_runtime_force_resume() has run?  Aren't clocks and power still off?
>
Ack. Will fix it in v6.
 
> Also, prefer IS_ENABLED() to '#ifdef'.  However, this suggests to me
> that we actually should just keep MMC_CAP2_CRYPTO defined to 0 when
> !IS_ENABLED(CONFIG_MMC_CRYPTO), as that solves this naturally without
> any need for #ifdef or IS_ENABLED().
>
Ack. I will revert the change made around MMC_CAP2_CRYPTO here:
https://lore.kernel.org/linux-mmc/20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com/.
and clean this as well in v6.
 
> - Eric
> 
Regards
Neeraj
