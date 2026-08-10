Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4221348C7D
	for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349025; cv=none; b=G4KnaRYmlEYEI7V8IigJyt8zI989r+6n5IIXfXjlGNW165oaMMQmOEq5CxeAIZhesIIKFUgzlTXJsf4EapcVvzBQM6d6Q9afaEM9MBIVKG8yMYME2IVpHYck/X0n2Q3DF8BymbKK5Mzjwjq4FReRCiQfvHTDHIOinxJyl44+NTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349025; c=relaxed/simple;
	bh=foWs9e24w9qPUIsKEA7/suDgVJil5cRHU69ADdNXgR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEDoETVg0v9IcBYVg4y3Xz44glTLLkAXeckRhI9GXNjNEytGwrQ0iWrToLFozpQ2JhvcNgTxiY/zyo8xakEhkw0QL1y3PcE4wQvcMZcTjuld+bqoMq5pjhnD49BsCXe2Kj5Df7ovd84ZVbJSCRSSvv2ZfSgeGoWeMzFzhvly6wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gdTnpVyV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IEYjOHLP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gdTnpVyV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IEYjOHLP"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A5pWnr1240653
	for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 08:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JxKtSuEy3P4FHpzR9BO4tWVvzdjxxUd1uxUCq5FcQ4Q=; b=gdTnpVyV1nzijyYt
	CZqYZ3Ul4Fc2P1pm/QB4FlX/pxzxNSKwIuWKzp3S+WvUShL9DhYIRnwtQjNt8XrC
	kUy4sLeNk/dGiZyPBjFLvSgRqiXjfINqpzNC9v7CBUWiXWOER5uJsgsiWirbwcbt
	XMon4SpKAmT0q1+Wi9zmsnGiMi1PfCOSmAcgSNbGYmsXaqqQfkZ53eec6s/aup/V
	qZUbZqPUsCu/Auj6nr3LQ//ZjMPrTk4nI8nI+lMDD4pMxVFdmN3MiNFPiojYEEMu
	AQ503uAreeK+P6AsAWbjp6x60hfnGD0UV5sQ42j5lcftsTp/n5VnZU2oreABEtSW
	+mEQeg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v3rcqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 08:03:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so2855277a91.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786349020; x=1786953820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JxKtSuEy3P4FHpzR9BO4tWVvzdjxxUd1uxUCq5FcQ4Q=;
        b=IEYjOHLP7uq+h3agamktqQe08eHVDA8MyBUs31adICL81kzEOb70TeVOVYjHkSlu6p
         Juhcw43gziN6Avfofc3Va7SOh9G3uDLssb4mmHxD3iFRiv8lfJnpQxwEEKgv9XOUulmv
         wDH90EukSE6HdhQ+NaX+aJcK/92YNiYewOh52r9oPEYmXWuclth2Git14pY3RJrKv9qJ
         mxhfYrOfSfrfmLKJV6TqOBUiPKydqElVPWt7GP+32/pcs7rXVbKHCVw30umb2jxN6jvY
         i6eyqQXdU4K6rpkEvaHwVpmihayb7LK8IsfxMoTCek8kd3Od9w6VAZ3VSNouZ70sJrsn
         Kpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786349020; x=1786953820;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JxKtSuEy3P4FHpzR9BO4tWVvzdjxxUd1uxUCq5FcQ4Q=;
        b=AeIQrbSG0IWsQFqvPYgEvRmE7bHi5a6tMJl+JEZsHg9EkZBBbUfPM0rLb7Kv13bclX
         qtft53UcEHWLnTrFwTqpIX3nsF8b/S0wH4Geqbg02Znu745SMxszgmKHOH5MvZ7AOq5C
         ZZPZ52GH3qvsW/HvJly2Nwi+F/factBOdlRZ+k2+rrHTykEIxRcfEaQ0cOh35q7YGZKU
         NdVoKt5GcVFXOpIpFfO5UPTf535iugSCVyAfMXD95331X3jHI2V77EzzZbj47PD1g6aY
         UeRLNsrLqL0Bok5Mns7tBX+aKw3NClfYRUVPn84yCXc2yBD07U9xlgL1JDyFGeHWIRlr
         Izow==
X-Forwarded-Encrypted: i=1; AHgh+RqzOmvCmtIQiQv36AsoEKNx0asvay5Suroyamu8Lh7aEF9t1B4hga/z3h6in+CZkS5VW2fI3R94/+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJ2aDFo0w1e1Y8BGpXNhnvIf9NM645O7ywShqbVZd9/ScFAcT
	xAesf7BKg7kn+QYlRkXZw/Vr0/cjXbWqOEe7tNfkPF9bMu49SpHdQnuRrLy1b5CqTexH4l3pBA9
	CHofI/iXpeyUbwJR8W6FB8c/d9AvfEZPg8n9xIEa/4pB7jW5SEmIKBy2DJQChiw==
X-Gm-Gg: AR+sD102Lzzvz8tdXJrAyxAiXsAhBnvuCpRk+1Bv9LLm/xzG9kXYTqbF4T17a4e+DDI
	0StawB/2hEb7muoJauMb4GhVpkVzFQfm8CeZFOFjjJuVslcCyTZX2y/UrPz/YVoNQh0Ttc2xSv7
	8XYsbZUsSj8Q1qD+rtTu8YPuKT7jmUh4yH1xpdg6lZrG2ioymqGP6VlhKmALQwS07I4idHuQXjM
	bEfeAtl9GXCWXvzi2q9qF8mWTjzT+4IEcFELQ4AU7/tPVJxBZSGPFMCOKE7CEQg00p8tkvW9BxT
	MgYrRHd8TXHns1Y1DD+04fE9obPkucvPgFgwxyH7w3K4FDICmO/FrmqGsrFLFPyuliwpBGHni1C
	5blukwfxfCVquK68AznXR6aYl5w==
X-Received: by 2002:a17:90b:4f81:b0:38c:e9e9:e7ce with SMTP id 98e67ed59e1d1-392822bf6abmr15056743a91.3.1786349020381;
        Mon, 10 Aug 2026 01:03:40 -0700 (PDT)
X-Received: by 2002:a17:90b:4f81:b0:38c:e9e9:e7ce with SMTP id 98e67ed59e1d1-392822bf6abmr15056694a91.3.1786349019895;
        Mon, 10 Aug 2026 01:03:39 -0700 (PDT)
Received: from [192.168.0.102] ([49.204.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6c13asm11501889a91.2.2026.08.10.01.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 01:03:39 -0700 (PDT)
Message-ID: <c0716e8e-728a-4364-98b3-a122a5475bc3@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 13:33:32 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] mmc: sdhci-msm: Use pm ops instead of macro to
 restore crypto keys
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
        quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260803163123.1802005-1-neeraj.soni@oss.qualcomm.com>
 <20260803163123.1802005-3-neeraj.soni@oss.qualcomm.com>
 <20260803201803.GB63318@quark>
 <abe31a1b-e34c-d5b6-4bc4-3733acc56e98@oss.qualcomm.com>
Content-Language: en-US
From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
In-Reply-To: <abe31a1b-e34c-d5b6-4bc4-3733acc56e98@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9X0CoIAhfCJHAndPQ6PkdV5Kf_mZ-1rz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA2OCBTYWx0ZWRfXz2RzE9GoCLM4
 VqwwGQbjoUHz3EvIj0i9tEyX1xZ8Nj+TGgobBF12UQdJ1CfBsMq5wDOB5L0rADPsGYn510aBPqR
 HNmjWA0rTrbzR+Ikm2/GxoKx9nowFgKhirfT9sIpQG6zeC7j/xbGNeTkMARlSoXSM95lYrr+20o
 qC2sjxueA9biFVJUlQ8CAV5J4rGCyBdd/FJPBGACyr4msJrWIX1wyi0Y7t8Q9KAf5cv1QoWQsZ3
 UJ5Vf8L/RRAHbVOyEltoIgmdWUCYLNIXCTAC9YMs2ypm79QP4BdZwPsIeWa/WE2dyKgE05gJFZH
 aTM3HlLOnMq8pYEDco4fiiTXZ61JwTa2xnFG2iDJb5rwy42X16R2ACYR2SzTe0SnSYKmyImFR2x
 EEusL8eDPGaaN85a18dNPGWuh6ypc4+doxGUluDenJVCIWb+cNTTNB2XPCAelRk8hnZK1EGRw8e
 rSOs4s+ZKL24oHqSfWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA2OCBTYWx0ZWRfX/aykjIUHREZt
 6E1QAgaIpkURUQF6sOB6sH6kHA5KD9vgK3FWEmkLH2wn5eznvbo6KVMj424mxOuKnK5BkxKUwSn
 fqzwKCDx2DaLwhA8oqwAgEDAzXinUfo=
X-Proofpoint-GUID: 9X0CoIAhfCJHAndPQ6PkdV5Kf_mZ-1rz
X-Authority-Analysis: v=2.4 cv=c+mbhx9l c=1 sm=1 tr=0 ts=6a7985df cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=wB/OwOWguG3OqMiIzyR4iQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=RJ2Gkk4ao1b7OKlePUwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100068



On 8/7/2026 7:49 PM, Neeraj Soni wrote:
> 
> 
> On 8/4/2026 1:48 AM, Eric Biggers wrote:
>> On Mon, Aug 03, 2026 at 10:01:23PM +0530, Neeraj Soni wrote:
>>> From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>>>
>>> Inline Crypto Engine (ICE) keys are lost after hibernation entry and this
>>> needs to be restored when hibernation exits. ICE keys are re-programmed
>>> during sdhci_msm_ice_init() but it may not cover cases where the
>>> hibernation image is already restored.
>>>
>>> Unwrap the pm ops and use directly in driver to add the call to restore
>>> Inline Crypto Engine (ICE) keys. This ensures that ICE is brought into
>>> same state as before hibernation.
>>>
>>> Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-programming of ICE
>>> keys is not needed during MMC runtime suspend/resume.
>>>
>>> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>>> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
>>> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>>> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>>> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
>>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>> ---
>>>  drivers/mmc/host/sdhci-msm.c | 23 ++++++++++++++++++++++-
>>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>>> index 4aff965f0e2e..f64788a70309 100644
>>> --- a/drivers/mmc/host/sdhci-msm.c
>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>> @@ -1959,6 +1959,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>>>  	}
>>>  
>>>  	mmc->caps2 |= MMC_CAP2_CRYPTO;
>>> +	mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
>>>  	return 0;
>>>  }
>>>  
>>> @@ -2983,9 +2984,29 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>>>  	return ret;
>>>  }
>>>  
>>> +static int sdhci_msm_restore(struct device *dev)
>>> +{
>>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>>> +	int ret;
>>> +
>>> +	ret = pm_runtime_force_resume(dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (host->mmc->caps2 & MMC_CAP2_CRYPTO)
>>> +		blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
>>> +
>>> +	return ret;
>>> +}
>>
>> Sorry, it looks like this actually does need an #ifdef because the
>> crypto_profile field is conditional.  It doesn't need to be a new #ifdef
>> though, as you could add a function sdhci_msm_ice_restore() within the
>> existing CONFIG_MMC_CRYPTO section of this file (along with a no-op stub
>> in the !CONFIG_MMC_CRYPTO section), then call it from here.  Similar to
>> how the existing sdhci_msm_ice_resume() works, for example.
>>
> But MMC_CPA2_CRYPTO=0 if !CONFIG_MMC_CRYPTO so crypto_profile field is
> not accessed if !CONFIG_MMC_CRYPTO. Does it need encapsulation?
>  
>>>  static const struct dev_pm_ops sdhci_msm_pm_ops = {
>>> -	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>>>  	RUNTIME_PM_OPS(sdhci_msm_runtime_suspend, sdhci_msm_runtime_resume, NULL)
>>> +	.suspend	= pm_runtime_force_suspend,
>>> +	.resume		= pm_runtime_force_resume,
>>> +	.freeze		= pm_runtime_force_suspend,
>>> +	.restore	= sdhci_msm_restore,
>>> +	.thaw		= pm_runtime_force_resume,
>>> +	.poweroff	= pm_runtime_force_suspend,
>>
>> Should these use pm_sleep_ptr() to allow dead code elimination when
>> !CONFIG_PM_SLEEP?
>>
> Ram can you please check this. Looks valid to me. 
>  
>> - Eric

Agree with this, we will update this in next patchset using pm_sleep_ptr().

>>
> Regards
> Neeraj

